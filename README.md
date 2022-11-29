# AGM-Benchmarks
This repository contains the files and summary of results for the numerical Benchmark on the Reduced WECC 240 Bus System. This project was supported  by the U.S. Department of Energy by the Advanced Grid Modeling program within the Office of Electricity, under contract DE-AC02-05CH1123.

The comparison of results is done using the commercial tools Siemens PSS®E and PSCAD™/EMTDC™ against the Julia toolbox [PowerSimulationsDynamics](https://github.com/NREL-SIIP/PowerSimulationsDynamics.jl) using numerical solvers provided by [Sundials](https://github.com/SciML/Sundials.jl) and [DifferentialEquations.jl](https://github.com/SciML/DifferentialEquations.jl).

Some of the key discoveries on solver performance are:

- Solution methods will perform better/worse depending on the contingency. As a result, not all improvements apply across the simulation requirements. Contingencies that result in a post-fault state with large imaginary eigenvalues need different treatment that contingencies that result in large negative real eigenvalues.
- Discrete behavior like state limiters (i.e., clamps) has an significant effect on the the solution methods. Rodas methods are slower but more resilient to discrete behavior than BDF methods.
- Improvements in the Linear Solver have significant impact in the solution speed. This is reflected in the speed up when using Sundials IDA.
