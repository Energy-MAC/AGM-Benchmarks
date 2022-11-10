# AGM-Benchmarks
This repository contains the files and summary of results for the numerical Benchmark on the Reduced WECC 240 Bus System. This project was supported  by the U.S. Department of Energy by the Advanced Grid Modeling program within the Office of Electricity, under contract DE-AC02-05CH1123.

The comparison of results is done using the commercial tools Siemens PSS®E and PSCAD™/EMTDC™ against the Julia toolbox [PowerSimulationsDynamics](https://github.com/NREL-SIIP/PowerSimulationsDynamics.jl) using numerical solvers provided by [Sundials](https://github.com/SciML/Sundials.jl) and [DifferentialEquations.jl](https://github.com/SciML/DifferentialEquations.jl).

## PSS®E Results

The positive-sequence validation is done in the [Reduced WECC 240-Bus System](https://ieeexplore.ieee.org/document/9299666), a system with 2420 dynamic states and 506 algebraic states. In total, 195 generator trips and 329 line trips simulations were performed, and the Root Mean Square Error (RMSE) was compared against the tools PSS/E and PowerSimulationsDynamics.jl. The following table compares the RMSE across 311,780 traces of bus voltages and angles.

|                           | Generator Trip             | Line Trip                  |
|---------------------------|----------------------------|----------------------------|
| Max Angle RMSE [deg]      | 4.100 × 10<sup>-1</sup> | 4.500 × 10<sup>-1</sup> |
| Max Voltage RMSE [pu]     | 2.592 × 10<sup>-5</sup> | 2.618 × 10<sup>-5</sup> |
| Max Speed RMSE [pu]       | 6.567 × 10<sup>-6</sup> | 1.221 × 10<sup>-5</sup> |
| Average Angle RMSE [deg]  | 3.172 × 10<sup>-2</sup> | 1.569 × 10<sup>-4</sup> |
| Average Voltage RMSE [pu] | 1.082 × 10<sup>-5</sup> | 7.831 × 10<sup>-7</sup> |
| Average Speed RMSE [pu]   | 1.599 × 10<sup>-6</sup> | 5.225 × 10<sup>-7</sup> |

In addition, the Julia toolbox allows the usage of different solvers at different tolerances. The following table compares the simulation times for the base case:

|      Solver      | Time [s] for abstol/reltol = 10<sup>-9</sup> | Time [s] for abstol/reltol = 10<sup>-6</sup> | Time [s] for abstol/reltol = 10<sup>-3</sup> |
|:----------------:|:----------------------------------------:|:------------------------------------------:|:------------------------------------------:|
|     ROS34PW1b    |                  Failed                  |                   19.221                   |                    5.335                   |
|     ROS34PW1a    |                  Failed                  |                   19.301                   |                    5.369                   |
|      Rodas5P     |                  608.673                 |                   23.327                   |                    7.123                   |
|      Rodas4      |                  135.416                 |                   28.689                   |                    7.123                   |
|   Rosenbrock23   |                  488.898                 |                   35.090                   |                    6.804                   |
| RosenbrockW6S4OS |                  11.576                  |                    0.979                   |                    0.969                   |
|     Rodas4P2     |                  132.271                 |                   29.432                   |                    6.782                   |
|      Rodas5      |                  84.341                  |                   24.619                   |                    7.007                   |
|      Rodas42     |                  245.498                 |                   32.915                   |                    6.771                   |
|       FBDF       |                  10.407                  |                    1.824                   |                    0.506                   |
|       QNDF       |                  Failed                  |                    1.681                   |                    0.616                   |
|       QBDF       |                  Failed                  |                    2.282                   |                    1.122                   |
|     IDA Dense    |                  63.382                  |                   30.903                   |                   27.986                   |
|  IDA LAPACKDENSE |                  48.532                  |                   16.507                   |                   14.429                   |
|      IDA KLU     |                  26.131                  |                   14.465                   |                   13.088                   |

## PSCAD™ Results

Work in progress