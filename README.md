# GLinA
## Gleam Linear Algebra

A general linear algebra library for Gleam, intended for learning and everyday
calculations. The project prioritizes a simple API, clear documentation, and
numerical correctness over handling large workloads.

[![Package Version](https://img.shields.io/hexpm/v/glina)](https://hex.pm/packages/glina)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://glina.hexdocs.pm/)

```sh
gleam add glina@1
```

Further documentation can be found at <https://glina.hexdocs.pm/>

## Roadmap

Development will progress through these milestones:

1. Define the API conventions and numerical behavior
2. Implement dense vectors, matrices, and basic operations
3. Add linear system solvers and LU decomposition
4. Add QR and Cholesky decomposition, least squares, and rank
5. Add symmetric eigenvalue problems and singular value decomposition

The first usable milestone is basic vector and matrix operations; the initial
numerical milestone adds solving square linear systems. Sparse matrices are a
possible later extension

See [the detailed roadmap](docs/roadmap.md) for scope, completion criteria, and
open decisions. The milestones express intended order, not release dates

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
