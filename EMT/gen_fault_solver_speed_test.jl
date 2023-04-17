using Pkg
Pkg.instantiate()

using PowerSystems
using PowerSimulationsDynamics
using OrdinaryDiffEq
using Sundials
using Logging
using KLU
using LinearSolve
using CSV
using PowerFlows
using DataFrames
using LinearAlgebra
using PrettyTables

include("../utils.jl")

system = System("EMT/data/144Bus.json")

sim_config = Dict{Symbol,Any}(
    :file_level => Logging.Error,
    :console_level => Logging.Error,
    :system_to_file => false,
    :all_lines_dynamic => true,
)

# Get high tolerance results
sim_diffeq_high_tol = Simulation(
    MassMatrixModel,
    system,
    pwd(),
    (0.0, 10.0), #time span
    GeneratorTrip(1.0, get_component(DynamicGenerator, system, "GFM_Battery_31"));
    sim_config...
)

execute!(sim_diffeq_high_tol, Rodas5P();
    #dtmax = 1e-3,
    abstol=1e-8,
    reltol=1e-8,)
sim_diffeq_high_tol_res = read_results(sim_diffeq_high_tol)

# Precompilation run
sim_ida = Simulation(
    ResidualModel,
    system,
    mktempdir(),
    (0.0, 10.0), #time span
    GeneratorTrip(1.0, get_component(DynamicGenerator, system, "GFM_Battery_31"));
    sim_config...
)

execute!(sim_ida, IDA(); abstol=1e-2, reltol=1e-2, enable_progress_bar=false)

gen_trip_speed_results = DataFrame(solver=String[],
    LinearSolver=String[],
    max_error=Float64[],
    rmse=Float64[],
    tol=Float64[],
    sol_time=String[],
    step_count=Int[],
    max_error_state=Tuple{String,Symbol}[],)

for solver in (IDA(), IDA(linear_solver=:LapackDense), IDA(linear_solver=:KLU)), tol in (1e-2, 1e-3, 1e-4, 1e-5, 1e-6, 1e-7, 1e-8)
    solve_time = "failed"
    solver_name, solver_meta = split("$(solver)", "{")
    linear_solver = split(solver_meta, ",")[1]
    step_count = 0
    rmse, max_error, state_error = (NaN, NaN, ("", :x))
    try
        sim_ida = Simulation(
            ResidualModel,
            system,
            pwd(),
            (0.0, 10.0), #time span
            GeneratorTrip(1.0, get_component(DynamicGenerator, system, "GFM_Battery_31"));
            sim_config...
        )

        execute!(sim_ida, solver; enable_progress_bar=false, abstol=tol, reltol=tol)
        results = read_results(sim_ida)
        rmse, max_error, state_error = get_rmse(sim_diffeq_high_tol_res, results)
        step_count = length(results.solution.t)
        solve_time = "$(results.time_log[:timed_solve_time])"
        tr, valr = get_state_series(results, state_error)
        ti, vali = get_state_series(sim_diffeq_high_tol_res, state_error)
        df_res = DataFrame(t=tr, state=valr)
        df_base = DataFrame(t=ti, state=vali)
        CSV.write("res_gen_$(solver_name)_$(state_error[1])_$(state_error[2])_$(linear_solver)_$(tol).csv", df_res)
        CSV.write("base_gen_$(solver_name)_$(state_error[1])_$(state_error[2])_$(linear_solver)_$(tol).csv", df_base)
    catch e
        @error("meh")
    finally
        push!(gen_trip_speed_results,
            (solver_name, linear_solver, max_error, rmse, tol, solve_time, step_count, state_error)
        )
    end
end

# Precompilation run
sim = Simulation(
    MassMatrixModel,
    system,
    pwd(),
    (0.0, 10.0), #time span
    GeneratorTrip(1.0, get_component(DynamicGenerator, system, "GFM_Battery_31"));
    sim_config...
)

execute!(sim, Rodas4(); enable_progress_bar=false)

for solver in (
        # Rosenbrock
        Rodas4(),
        Rodas5P(),
        Rodas4(),
        Rodas4P(),
        Rodas5(),
        # Rosenbrock W
        Rosenbrock23(),
        Rosenbrock32(),
        RosenbrockW6S4OS(),
        ROS34PW1a(),
        ROS34PW1b(),
        ROS34PW2(),
        ROS34PW3(),
        # FIRK
        RadauIIA5(),
        # SDIRK
        ImplicitEuler(),
        # MultiStep Methods
        QNDF(),
        QBDF1(),
        QNDF2(),
        QBDF2(),
        QBDF(),
        FBDF(),
    ), tol in (1e-2, 1e-3, 1e-4, 1e-5, 1e-6, 1e-7, 1e-8)
    solve_time = "failed"
    solver_name, solver_meta = split("$(solver)", "{")
    linear_solver = split(solver_meta, ",")[1]
    step_count = 0
    rmse, max_error, state_error = (NaN, NaN, ("", :x))
    try
        sim = Simulation(
            MassMatrixModel,
            system,
            pwd(),
            (0.0, 10.0), #time span
            GeneratorTrip(1.0, get_component(DynamicGenerator, system, "GFM_Battery_31"));
            sim_config...
        )

        execute!(sim, solver; enable_progress_bar=false, abstol=tol, reltol=tol)
        results = read_results(sim)
        rmse, max_error, state_error = get_rmse(sim_diffeq_high_tol_res, results)
        step_count = length(results.solution.t)
        solve_time = "$(results.time_log[:timed_solve_time])"
        tr, valr = get_state_series(results, state_error)
        ti, vali = get_state_series(sim_diffeq_high_tol_res, state_error)
        df_res = DataFrame(t=tr, state=valr)
        df_base = DataFrame(t=ti, state=vali)
        CSV.write("res_$(solver_name)_$(state_error[1])_$(state_error[2])_$(linear_solver)_$(tol).csv", df_res)
        CSV.write("base_$(solver_name)_$(state_error[1])_$(state_error[2])_$(linear_solver)_$(tol).csv", df_base)
    catch e
        @error("meh")
    finally
        push!(gen_trip_speed_results,
            (solver_name, linear_solver, max_error, rmse, tol, solve_time, step_count, state_error)
        )
    end
end

readme_text = read("EMT/README.md", String)

val_ini = findnext("## Solver comparison gen trip", readme_text, 1)[end]

open("EMT/README.md", "w") do f
    write(f, readme_text[1:val_ini])
    write(f, "\n\n")
    pretty_table(f, gen_trip_speed_results, tf=tf_markdown)
    write(f, "\n")
end
