# crystal-gsl

[![Linux CI](https://github.com/konovod/crystal-gsl/actions/workflows/linux.yml/badge.svg)](https://github.com/konovod/crystal-gsl/actions/workflows/linux.yml)
[![MacOS CI](https://github.com/konovod/crystal-gsl/actions/workflows/macos.yml/badge.svg)](https://github.com/konovod/crystal-gsl/actions/workflows/macos.yml)
[![Windows CI](https://github.com/konovod/crystal-gsl/actions/workflows/windows.yml/badge.svg)](https://github.com/konovod/crystal-gsl/actions/workflows/windows.yml)
[![API Documentation](https://img.shields.io/website?down_color=red&down_message=Offline&label=API%20Documentation&up_message=Online&url=https%3A%2F%2Fkonovod.github.io%2Fcrystal-gsl%2F)](https://konovod.github.io/crystal-gsl)

GNU Scientific Library (GSL) binding for Crystal

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  gsl:
    github: konovod/crystal-gsl
```

Run `shards install`

## System dependencies

### Ubuntu

- libatlas-base-dev
- libgsl-dev

### Fedora

- gsl
- gsl-devel

### MacOS

- brew install gsl

### Windows

- Recommended on [GSL website](https://www.gnu.org/software/gsl/extras/native_win_builds.html) way to get GSL on Windows is to build manually using .sln files from https://github.com/BrianGladman/gsl

## Usage

```crystal
require "gsl"
```

### Documentation

(Incomplete) documentation can be found [here](https://konovod.github.io/crystal-gsl/). It is generated from sources, so can be messy.

You can also check original GSL docs for details of implementation and theory (https://www.gnu.org/software/gsl/doc/html/)

### Examples

You can check `spec` directory for some simple examples

_Warning_:

- Mostly tested, but some bugs are possible
- Pre-release (API could break)
- Perhaps not ready for production

## Status

If you know GSL, you can call all GSL functions directly: `LibGSL.gsl_some_function(arg, ...)`. This could be cumbersome, but it works.

For a high-level wrappers, see [TODO.md](https://github.com/konovod/crystal-gsl/blob/master/TODO.md) for detailed list on what is done\missing.

Below is a categorized list of what is done (with links to docs):

- General
  - [Vectors](https://konovod.github.io/crystal-gsl/GSL/Vector.html)
  - [Matrices](https://konovod.github.io/crystal-gsl/GSL/Matrix.html)
  - [Sparse](https://konovod.github.io/crystal-gsl/GSL/SparseMatrix.html) and [dense](https://konovod.github.io/crystal-gsl/GSL/DenseMatrix.html) matrices
- Statistical
  - [Distributions](https://konovod.github.io/crystal-gsl/Statistics.html) (33 of 38)
  - [Histograms](https://konovod.github.io/crystal-gsl/GSL/AbstractHistogram.html)
  - [Permutations](https://konovod.github.io/crystal-gsl/GSL/Permutation.html)
  - [Correlation](https://konovod.github.io/crystal-gsl/GSL/Stats.html)
- Analysis
  - [Numerical integration](https://konovod.github.io/crystal-gsl/GSL/Integration.html)
  - [Numerical differentiation](https://konovod.github.io/crystal-gsl/GSL.html#diff%28function%3AGSL%3A%3AFunction%2Cx%3AFloat64%2Cstep%3AFloat64%3D0.01%2Cdir%3ADiff%3A%3ADirection%3DDiff%3A%3ADirection%3A%3ACentral%29-class-method)
  - [Ordinary differential equations](https://konovod.github.io/crystal-gsl/GSL/ODE/Driver.html)
  - [Polynomials](https://konovod.github.io/crystal-gsl/GSL/Poly.html)
  - [Monte Carlo Integration](https://konovod.github.io/crystal-gsl/GSL/MonteCarlo.html)
  - [Series Acceleration](https://konovod.github.io/crystal-gsl/GSL/Sum.html)
- Optimization
  - [Scalar functions minimization](https://konovod.github.io/crystal-gsl/GSL/Min.html)
  - [Scalar functions root finding](https://konovod.github.io/crystal-gsl/GSL/Roots.html)
  - [Simulated Annealing](https://konovod.github.io/crystal-gsl/GSL/Siman.html)
  - [Linear Regression](https://konovod.github.io/crystal-gsl/GSL/LinearRegression.html)
  - Multidimensional Minimization
  - Multidimensional Root-Finding
- Approximation
  - [Chebyshev approximation](https://konovod.github.io/crystal-gsl/GSL/Chebyshev.html)
  - [B Splines](https://konovod.github.io/crystal-gsl/GSL/BSpline.html) (2.7 API)
  - [Interpolation](https://konovod.github.io/crystal-gsl/GSL/Interpolate1D.html)
- [Physical constants](https://konovod.github.io/crystal-gsl/GSL/Consts.html)
- [Special functions](https://konovod.github.io/crystal-gsl/GSL/SpecFunctions.html) (273 of 338)

## Contributing

1. Fork it ( https://github.com/konovod/crystal-gsl/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [ruivieira](https://github.com/ruivieira) Rui Vieira - creator
- [dylandy](https://github.com/dylandy) Dylandy Chang - developer
- [konovod](https://github.com/konovod) Andrey Konovod - developer, maintainer
