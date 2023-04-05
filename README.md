# crystal-gsl

[![Linux CI](https://github.com/konovod/crystal-gsl/actions/workflows/linux.yml/badge.svg)](https://github.com/konovod/crystal-gsl/actions/workflows/linux.yml)
[![MacOS CI](https://github.com/konovod/crystal-gsl/actions/workflows/macos.yml/badge.svg)](https://github.com/konovod/crystal-gsl/actions/workflows/macos.yml)
[![Windows CI](https://github.com/konovod/crystal-gsl/actions/workflows/windows.yml/badge.svg)](https://github.com/konovod/crystal-gsl/actions/workflows/windows.yml)

GNU Scientific Library (GSL) binding for Crystal

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  gsl:
    github: konovod/crystal-gsl
```

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

Full documentation can be found at [here](https://konovod.github.io/crystal-gsl/).

### Examples

Examples can be found [here](https://ruivieira.github.io/projects/crystal-gsl/). (broken link)

You can check `spec` directory for some simple examples

_Warning_:

- Not fully test
- Pre-release (API will break)
- Not fit for production

## Status

Implementation list:

- Statistical
  - Distributions
    - Binomial
    - Chi-square
    - Uniform
    - Exponential
    - Cauchy
    - Gaussian (univariate and multivariate)
    - Poisson
    - Multinomial
    - Gamma
  - Vectors
  - Matrices
  - Sparse and dense matrices
  - Histograms
  - Permutations
- Analysis
  - Numerical integration
  - Numerical differentiation
  - Ordinary differential equations
- Optimization
  - Scalar functions minimization
  - Scalar functions root finding
- Physical constants

## Contributing

1. Fork it ( https://github.com/konovod/crystal-gsl/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

I'm maintaining this fork for now, at least until it is merged to origin

- [ruivieira](https://github.com/ruivieira) Rui Vieira - creator
- [dylandy](https://github.com/dylandy) Dylandy Chang - developer
- [konovod](https://github.com/konovod) Andrey Konovod - developer, maintainer
