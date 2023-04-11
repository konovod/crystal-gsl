Status of GSL areas (list taken from [GSL docs](https://www.gnu.org/software/gsl/doc/html/))

|Area | Status | Comment |
|-----|--------|---------|
| Error Handling | Done |  |
| Mathematical Functions | Not planned | Already in Crystal stdlib |
| Complex Numbers | Not planned | Already in Crystal stdlib |
| Polynomials | Done |  |
| Special Functions | Partially done |  |
| Vectors and Matrices | Partially done | lack VectorView, row swapping, maybe other minor features |
| Permutations | Partially done | Not a priority for me (PR welcome though) |
| Combinations | - | Not a priority for me (PR welcome though) |
| Multisets | - | Not a priority for me (PR welcome though) |
| Sorting | Not planned | Already in Crystal stdlib |
| BLAS Support | - | Not a priority for me, See https://github.com/konovod/linalg for linalg library |
| Linear Algebra | - | Not a priority for me, See https://github.com/konovod/linalg for linalg library |
| Eigensystems | - | Not a priority for me, See https://github.com/konovod/linalg for linalg library |
| Fast Fourier Transforms (FFTs) | - | Not a priority for me, See https://github.com/firejox/fftw.cr for FFTW3 bindings |
| Numerical Integration | Done |  |
| Random Number Generation | Not planned | Already in Crystal stdlib |
| Quasi-Random Sequences | - | Not a priority for me (PR welcome though) |
| Random Number Distributions | Partially done | Not a priority for me (PR welcome though) |
| Statistics | Partially done | Not a priority for me (PR welcome though) |
| Running Statistics | - | Not a priority for me (PR welcome though) |
| Moving Window Statistics | - | Not a priority for me (PR welcome though) |
| Digital Filtering | - | Not a priority for me (PR welcome though) |
| Histograms | Partially done | Not a priority for me (PR welcome though) |
| N-tuples | - | Not a priority for me (PR welcome though) |
| Monte Carlo Integration | Partially done | Vegas chisq estimate is not supported |
| Simulated Annealing | Done |  |
| Ordinary Differential Equations | Done |  |
| Interpolation | Done |  |
| Numerical Differentiation | Done |  |
| Chebyshev Approximations | Done |  |
| Series Acceleration | - |  |
| Wavelet Transforms | - |  |
| Discrete Hankel Transforms | - | I dont' understand what is it |
| One Dimensional Root-Finding | Done |  |
| One Dimensional Minimization | Done |  |
| Multidimensional Root-Finding | - |  |
| Multidimensional Minimization | - | See https://github.com/konovod/nlopt for NLOpt bindings. But GSL would be nice to have too |
| Linear Least-Squares Fitting | - |  |
| Nonlinear Least-Squares Fitting | - |  |
| Basis Splines | Partially Done | 2.7 API done, but they were significantly overhauled in 2.8 |
| Sparse Matrices | Partially done |  |
| Sparse BLAS Support | - | Maybe there are better alternatives, but none for Crystal atm |
| Sparse Linear Algebra | - | Maybe there are better alternatives, but none for Crystal atm |
| Physical Constants | Done |  |
