# PSS®E Validation Results

The positive-sequence validation is done in the [Reduced WECC 240-Bus System](https://ieeexplore.ieee.org/document/9299666), a system with 2420 dynamic states and 506 algebraic states. In total, 195 generator trips and 329 line trips simulations were performed, and the Root Mean Square Error (RMSE) was compared against the tools PSS/E and PowerSimulationsDynamics.jl. The following table compares the RMSE across 311,780 traces of bus voltages and angles. All the simulations were performed in the [University of California Berkeley High Performance Computing (Savio)](https://research-it.berkeley.edu/services-projects/high-performance-computing-savio).

Scripts and data to replicate the results are available in the PSSE folder of this repository. The Julia project environment is also available in such folder.

|                           | Generator Trip             | Line Trip                  |
|---------------------------|----------------------------|----------------------------|
| Max Angle RMSE [deg]      | 4.100 × 10<sup>-1</sup> | 4.500 × 10<sup>-1</sup> |
| Max Voltage RMSE [pu]     | 2.592 × 10<sup>-5</sup> | 2.618 × 10<sup>-5</sup> |
| Max Speed RMSE [pu]       | 6.567 × 10<sup>-6</sup> | 1.221 × 10<sup>-5</sup> |
| Average Angle RMSE [deg]  | 3.172 × 10<sup>-2</sup> | 1.569 × 10<sup>-4</sup> |
| Average Voltage RMSE [pu] | 1.082 × 10<sup>-5</sup> | 7.831 × 10<sup>-7</sup> |
| Average Speed RMSE [pu]   | 1.599 × 10<sup>-6</sup> | 5.225 × 10<sup>-7</sup> |

## Solver comparison line trip

## Solver comparison gen trip
