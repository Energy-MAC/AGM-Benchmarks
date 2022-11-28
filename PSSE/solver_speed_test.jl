using Revise
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

system = System("PSSE/data/PSCAD_VALIDATION_RAW.raw", "PSSE/data/PSCAD_VALIDATION_DYR.dyr";
bus_name_formatter = x -> strip(string(x["name"])) * "-" * string(x["index"]), runchecks = false)

for l in get_components(PowerLoad, system)
    set_model!(l, LoadModels.ConstantImpedance)
end

sim_config = Dict{Symbol,Any}(
        :file_level => Logging.Error,
        :console_level => Logging.Error,
        :system_to_file => false,
)

# Precompilation run
sim_ida = Simulation(
        ResidualModel,
        system,
        mktempdir(),
        (0.0, 20.0), #time span
        BranchTrip(1.0, Line, "CORONADO-1101-PALOVRDE-1401-i_2");
        sim_config...
        )

execute!(sim_ida, IDA(); enable_progress_bar = false)
results = read_results(sim_ida)

line_trip_speed_results = DataFrame(solver = String[],
                                    LinearSolver = String[],
                                    tol = Float64[],
                                    sol_time = String[])

for solver in (IDA(), IDA(linear_solver = :LapackDense), IDA(linear_solver = :KLU)), tol in (1e-6, 1e-8, 1e-10)
        solve_time = "failed"
        try
        sim_ida = Simulation(
                ResidualModel,
                system,
                pwd(),
                (0.0, 20.0), #time span
                BranchTrip(1.0, Line, "CORONADO-1101-PALOVRDE-1401-i_2");
                sim_config...
                )

        execute!(sim_ida, solver; enable_progress_bar = false, abstol = tol, reltol = tol)
        results = read_results(sim_ida)
        solve_time = "$(results.time_log[:timed_solve_time])"
        catch e
                @error("meh")
        finally
                solver_name, solver_meta = split("$(solver)", "{")
                linear_solver = split(solver_meta, ",")[1]
        push!(line_trip_speed_results,
              (solver_name, linear_solver, tol, solve_time)
        )
        end
end

# Precompilation run
sim = Simulation(
        MassMatrixModel,
        system,
        pwd(),
        (0.0, 20.0), #time span
        BranchTrip(1.0, Line, "CORONADO-1101-PALOVRDE-1401-i_2");
        sim_config...
        )

execute!(sim, Rodas4())

for solver in (
        # Rosenbrock
        RosShamp4(),
        Rodas4(),
        Rodas4(linsolve = KLUFactorization()),
        Rodas4P(),
        Rodas4P(linsolve = KLUFactorization()),
        Rodas5(),
        Rodas5(linsolve = KLUFactorization()),
        Rodas5P(),
        Rodas5P(linsolve = KLUFactorization()),
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
        Trapezoid(),
        # MultiStep Methods
        QNDF(),
        QBDF1(),
        ABDF2(),
        QNDF2(),
        QBDF2(),
        QNDF(),
        QBDF(),
        FBDF(),
        QNDF(linsolve = KLUFactorization()),
        QBDF1(linsolve = KLUFactorization()),
        ABDF2(linsolve = KLUFactorization()),
        QNDF2(linsolve = KLUFactorization()),
        QBDF2(linsolve = KLUFactorization()),
        QNDF(linsolve = KLUFactorization()),
        QBDF(linsolve = KLUFactorization()),
        FBDF(linsolve = KLUFactorization()),
        ), tol in (1e-6, 1e-8, 1e-10)
        solve_time = "failed"
        try
        sim = Simulation(
                MassMatrixModel,
                system,
                pwd(),
                (0.0, 20.0), #time span
                BranchTrip(1.0, Line, "CORONADO-1101-PALOVRDE-1401-i_2");
                sim_config...
                )

        execute!(sim, solver; enable_progress_bar = false, abstol = tol, reltol = tol)
        results = read_results(sim)
        solve_time = "$(results.time_log[:timed_solve_time])"
        catch e
                @error("meh")
        finally
                solver_name, solver_meta = split("$(solver)", "{")
                linear_solver = split(solver_meta, ",")[1]
        push!(line_trip_speed_results,
        (solver_name, linear_solver, tol, solve_time)
        )
end