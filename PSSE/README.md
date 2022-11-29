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

|           solver | LinearSolver |     tol |        sol_time |
|           String |       String | Float64 |          String |
|------------------|--------------|---------|-----------------|
|              IDA |       :Dense |  1.0e-6 |    38.019059193 |
|              IDA |       :Dense |  1.0e-8 |    86.349812044 |
|              IDA |       :Dense | 1.0e-10 |          failed |
|              IDA | :LapackDense |  1.0e-6 |    39.405227774 |
|              IDA | :LapackDense |  1.0e-8 |    57.458396116 |
|              IDA | :LapackDense | 1.0e-10 |          failed |
|              IDA |         :KLU |  1.0e-6 |     35.91148802 |
|              IDA |         :KLU |  1.0e-8 |    28.744469957 |
|              IDA |         :KLU | 1.0e-10 |          failed |
|        RosShamp4 |            0 |  1.0e-6 |          failed |
|        RosShamp4 |            0 |  1.0e-8 |          failed |
|        RosShamp4 |            0 | 1.0e-10 |          failed |
|           Rodas4 |            0 |  1.0e-6 |    93.332499092 |
|           Rodas4 |            0 |  1.0e-8 |   314.150108226 |
|           Rodas4 |            0 | 1.0e-10 |          failed |
|          Rodas4P |            0 |  1.0e-6 |    93.408913818 |
|          Rodas4P |            0 |  1.0e-8 |   283.517319016 |
|          Rodas4P |            0 | 1.0e-10 |          failed |
|           Rodas5 |            0 |  1.0e-6 |    74.332371087 |
|           Rodas5 |            0 |  1.0e-8 |   170.482321077 |
|           Rodas5 |            0 | 1.0e-10 |          failed |
|          Rodas5P |            0 |  1.0e-6 |    67.724113479 |
|          Rodas5P |            0 |  1.0e-8 |   645.033338045 |
|          Rodas5P |            0 | 1.0e-10 |          failed |
|     Rosenbrock23 |            0 |  1.0e-6 |   148.094622999 |
|     Rosenbrock23 |            0 |  1.0e-8 |   690.297438473 |
|     Rosenbrock23 |            0 | 1.0e-10 | 16939.862327296 |
|     Rosenbrock32 |            0 |  1.0e-6 |          failed |
|     Rosenbrock32 |            0 |  1.0e-8 |          failed |
|     Rosenbrock32 |            0 | 1.0e-10 |          failed |
| RosenbrockW6S4OS |            0 |  1.0e-6 |     5.237913601 |
| RosenbrockW6S4OS |            0 |  1.0e-8 |     1.075039211 |
| RosenbrockW6S4OS |            0 | 1.0e-10 |     1.088376044 |
|        ROS34PW1a |            0 |  1.0e-6 |   129.126215143 |
|        ROS34PW1a |            0 |  1.0e-8 |          failed |
|        ROS34PW1a |            0 | 1.0e-10 |          failed |
|        ROS34PW1b |            0 |  1.0e-6 |   124.771566544 |
|        ROS34PW1b |            0 |  1.0e-8 |          failed |
|        ROS34PW1b |            0 | 1.0e-10 |          failed |
|         ROS34PW2 |            0 |  1.0e-6 |          failed |
|         ROS34PW2 |            0 |  1.0e-8 |          failed |
|         ROS34PW2 |            0 | 1.0e-10 |          failed |
|         ROS34PW3 |            0 |  1.0e-6 |          failed |
|         ROS34PW3 |            0 |  1.0e-8 |          failed |
|         ROS34PW3 |            0 | 1.0e-10 |          failed |
|        RadauIIA5 |            0 |  1.0e-6 |          failed |
|        RadauIIA5 |            0 |  1.0e-8 |          failed |
|        RadauIIA5 |            0 | 1.0e-10 |          failed |
|    ImplicitEuler |            0 |  1.0e-6 |   337.024890576 |
|    ImplicitEuler |            0 |  1.0e-8 |  2444.054498596 |
|    ImplicitEuler |            0 | 1.0e-10 |          failed |
|        Trapezoid |            0 |  1.0e-6 |          failed |
|        Trapezoid |            0 |  1.0e-8 |          failed |
|        Trapezoid |            0 | 1.0e-10 |          failed |
|             QNDF |            5 |  1.0e-6 |    16.513326051 |
|             QNDF |            5 |  1.0e-8 |    18.210026853 |
|             QNDF |            5 | 1.0e-10 |          failed |
|            QNDF1 |            0 |  1.0e-6 |          failed |
|            QNDF1 |            0 |  1.0e-8 |          failed |
|            QNDF1 |            0 | 1.0e-10 |          failed |
|            ABDF2 |            0 |  1.0e-6 |          failed |
|            ABDF2 |            0 |  1.0e-8 |          failed |
|            ABDF2 |            0 | 1.0e-10 |          failed |
|            QNDF2 |            0 |  1.0e-6 |          failed |
|            QNDF2 |            0 |  1.0e-8 |          failed |
|            QNDF2 |            0 | 1.0e-10 |          failed |
|            QNDF2 |            0 |  1.0e-6 |          failed |
|            QNDF2 |            0 |  1.0e-8 |          failed |
|            QNDF2 |            0 | 1.0e-10 |          failed |
|             QNDF |            5 |  1.0e-6 |    10.751543691 |
|             QNDF |            5 |  1.0e-8 |    16.810390499 |
|             QNDF |            5 | 1.0e-10 |          failed |
|             QNDF |            5 |  1.0e-6 |    15.495031633 |
|             QNDF |            5 |  1.0e-8 |    17.018038259 |
|             QNDF |            5 | 1.0e-10 |          failed |
|             FBDF |            5 |  1.0e-6 |    18.384086764 |
|             FBDF |            5 |  1.0e-8 |    19.676802442 |
|             FBDF |            5 | 1.0e-10 |          failed |

## Solver comparison gen trip

|           solver | LinearSolver |     tol |       sol_time |
|           String |       String | Float64 |         String |
|------------------|--------------|---------|----------------|
|              IDA |       :Dense |  0.0001 |   28.397906956 |
|              IDA |       :Dense |  1.0e-6 |   41.773129218 |
|              IDA |       :Dense |  1.0e-8 |   57.410082248 |
|              IDA |       :Dense | 1.0e-10 |         failed |
|              IDA | :LapackDense |  0.0001 |   33.869605478 |
|              IDA | :LapackDense |  1.0e-6 |   22.209042321 |
|              IDA | :LapackDense |  1.0e-8 |   30.826639676 |
|              IDA | :LapackDense | 1.0e-10 |         failed |
|              IDA |         :KLU |  0.0001 |   31.253522706 |
|              IDA |         :KLU |  1.0e-6 |   18.023927841 |
|              IDA |         :KLU |  1.0e-8 |   25.257642586 |
|              IDA |         :KLU | 1.0e-10 |         failed |
|        RosShamp4 |            0 |  0.0001 |         failed |
|        RosShamp4 |            0 |  1.0e-6 |         failed |
|        RosShamp4 |            0 |  1.0e-8 |         failed |
|        RosShamp4 |            0 | 1.0e-10 |         failed |
|           Rodas4 |            0 |  0.0001 |   35.127815015 |
|           Rodas4 |            0 |  1.0e-6 |  106.957260384 |
|           Rodas4 |            0 |  1.0e-8 |  328.380848472 |
|           Rodas4 |            0 | 1.0e-10 |         failed |
|          Rodas4P |            0 |  0.0001 |   36.990142223 |
|          Rodas4P |            0 |  1.0e-6 |  104.008105062 |
|          Rodas4P |            0 |  1.0e-8 |  312.321948282 |
|          Rodas4P |            0 | 1.0e-10 |         failed |
|           Rodas5 |            0 |  0.0001 |    35.10391001 |
|           Rodas5 |            0 |  1.0e-6 |   76.196039255 |
|           Rodas5 |            0 |  1.0e-8 |  189.758614488 |
|           Rodas5 |            0 | 1.0e-10 |         failed |
|          Rodas5P |            0 |  0.0001 |   35.535475861 |
|          Rodas5P |            0 |  1.0e-6 |   76.904113473 |
|          Rodas5P |            0 |  1.0e-8 |  192.813984949 |
|          Rodas5P |            0 | 1.0e-10 |         failed |
|     Rosenbrock23 |            0 |  0.0001 |   47.402470283 |
|     Rosenbrock23 |            0 |  1.0e-6 |  178.359854803 |
|     Rosenbrock23 |            0 |  1.0e-8 |  780.282797149 |
|     Rosenbrock23 |            0 | 1.0e-10 |  3491.62968723 |
|     Rosenbrock32 |            0 |  0.0001 |         failed |
|     Rosenbrock32 |            0 |  1.0e-6 |         failed |
|     Rosenbrock32 |            0 |  1.0e-8 |         failed |
|     Rosenbrock32 |            0 | 1.0e-10 |         failed |
| RosenbrockW6S4OS |            0 |  0.0001 |    5.044530351 |
| RosenbrockW6S4OS |            0 |  1.0e-6 |    1.214577318 |
| RosenbrockW6S4OS |            0 |  1.0e-8 |    1.557843322 |
| RosenbrockW6S4OS |            0 | 1.0e-10 |    1.125511523 |
|        ROS34PW1a |            0 |  0.0001 |   59.108542439 |
|        ROS34PW1a |            0 |  1.0e-6 |         failed |
|        ROS34PW1a |            0 |  1.0e-8 |         failed |
|        ROS34PW1a |            0 | 1.0e-10 |         failed |
|        ROS34PW1b |            0 |  0.0001 |   59.098230458 |
|        ROS34PW1b |            0 |  1.0e-6 |         failed |
|        ROS34PW1b |            0 |  1.0e-8 |         failed |
|        ROS34PW1b |            0 | 1.0e-10 |         failed |
|         ROS34PW2 |            0 |  0.0001 |         failed |
|         ROS34PW2 |            0 |  1.0e-6 |         failed |
|         ROS34PW2 |            0 |  1.0e-8 |         failed |
|         ROS34PW2 |            0 | 1.0e-10 |         failed |
|         ROS34PW3 |            0 |  0.0001 |   86.448210954 |
|         ROS34PW3 |            0 |  1.0e-6 |         failed |
|         ROS34PW3 |            0 |  1.0e-8 |         failed |
|         ROS34PW3 |            0 | 1.0e-10 |         failed |
|        RadauIIA5 |            0 |  0.0001 |         failed |
|        RadauIIA5 |            0 |  1.0e-6 |         failed |
|        RadauIIA5 |            0 |  1.0e-8 |         failed |
|        RadauIIA5 |            0 | 1.0e-10 |         failed |
|    ImplicitEuler |            0 |  0.0001 |   14.779742202 |
|    ImplicitEuler |            0 |  1.0e-6 |  609.775427079 |
|    ImplicitEuler |            0 |  1.0e-8 | 4165.964468145 |
|    ImplicitEuler |            0 | 1.0e-10 |         failed |
|        Trapezoid |            0 |  0.0001 |         failed |
|        Trapezoid |            0 |  1.0e-6 |         failed |
|        Trapezoid |            0 |  1.0e-8 |         failed |
|        Trapezoid |            0 | 1.0e-10 |         failed |
|             QNDF |            5 |  0.0001 |   16.454503697 |
|             QNDF |            5 |  1.0e-6 |   15.187290012 |
|             QNDF |            5 |  1.0e-8 |   16.577169174 |
|             QNDF |            5 | 1.0e-10 |         failed |
|            QNDF1 |            0 |  0.0001 |         failed |
|            QNDF1 |            0 |  1.0e-6 |         failed |
|            QNDF1 |            0 |  1.0e-8 |         failed |
|            QNDF1 |            0 | 1.0e-10 |         failed |
|            ABDF2 |            0 |  0.0001 |         failed |
|            ABDF2 |            0 |  1.0e-6 |         failed |
|            ABDF2 |            0 |  1.0e-8 |         failed |
|            ABDF2 |            0 | 1.0e-10 |         failed |
|            QNDF2 |            0 |  0.0001 |   15.777078845 |
|            QNDF2 |            0 |  1.0e-6 |         failed |
|            QNDF2 |            0 |  1.0e-8 |         failed |
|            QNDF2 |            0 | 1.0e-10 |         failed |
|            QNDF2 |            0 |  0.0001 |         failed |
|            QNDF2 |            0 |  1.0e-6 |         failed |
|            QNDF2 |            0 |  1.0e-8 |         failed |
|            QNDF2 |            0 | 1.0e-10 |         failed |
|             QNDF |            5 |  0.0001 |     9.00118402 |
|             QNDF |            5 |  1.0e-6 |   13.400853967 |
|             QNDF |            5 |  1.0e-8 |   16.640276186 |
|             QNDF |            5 | 1.0e-10 |         failed |
|             QNDF |            5 |  0.0001 |    13.04222659 |
|             QNDF |            5 |  1.0e-6 |   13.075943163 |
|             QNDF |            5 |  1.0e-8 |    19.45373122 |
|             QNDF |            5 | 1.0e-10 |         failed |
|             FBDF |            5 |  0.0001 |   14.733640127 |
|             FBDF |            5 |  1.0e-6 |   16.382447889 |
|             FBDF |            5 |  1.0e-8 |   18.537015862 |
|             FBDF |            5 | 1.0e-10 |         failed |

