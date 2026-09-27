# Roadmap

glina will be a general linear algebra library for learning and everyday Gleam
applications. Its priorities are a simple API, understandable implementations,
useful numerical algorithms, and clear explanations of their limitations.
Large numerical workloads and performance tuning are secondary concerns.

This is an initial plan. Milestones describe intended order rather than dates
or fixed release versions. Each milestone should leave the library usable on
its own. GitHub issues can track individual tasks as their requirements become
clear.

## 1. Scope and API conventions

Agree on the foundations before implementing the public API:

- Start with dense vectors and matrices of real numbers. Decide whether the
  initial public API should use `Float` as the data type for everyhing
- Decide how callers construct values, access elements, and inspect shapes/dimensions of structures (such as vectors or matrices)
- Define behavior for dimension mismatches, empty values, and invalid input
- Decide how floating-point comparisons and tolerances are expressed
- Decide the supported compilation targets and document any differences in
  numerical behavior

## 2. Vectors, matrices, and basic operations

- Construct vectors and rectangular matrices from ordinary Gleam values
- Inspect dimensions, access elements, and retrieve rows and columns
- Provide zero vectors, zero matrices, identity matrices, and diagonal matrices.
- Implement addition, subtraction, scaling, and transpose
- Implement dot products, matrix-vector multiplication, and matrix multiplication.
- Provide vector norms and normalization, matrix norms, and trace
- Return understandable errors for incompatible shapes and invalid operations,
  including normalization of a zero vector


## 3. Linear systems and LU decomposition

- Implement Gaussian elimination with partial pivoting, with an explanation of
  why pivoting is needed
- Solve square systems `Ax = b` with a unique solution
- Add LU decomposition with permutation information and triangular solvers
- Use the decomposition to solve systems and calculate determinants.
- Add matrix inversion through solving systems
- Define and document how singular or nearly singular systems are reported

## 4. Least squares and additional decompositions

- Implement QR decomposition using Householder reflections
- Solve overdetermined least-squares problems, initially for matrices with full
  column rank.
- Implement Cholesky decomposition for symmetric positive definite matrices.
- Estimate numerical rank using a method and tolerance policy documented as part
  of the API.
- Add examples such as fitting a line to observations, including the meaning of
  the residual and the assumptions of the selected solver


## 5. Eigenvalues and singular value decomposition

- Start eigenvalue and eigenvector support with real symmetric matrices.
- Implement singular value decomposition for rectangular matrices
- Use SVD to extend rank estimation and support rank deficient least squares
  problems and the pseudoinverse

## Possible later extensions

Sparse matrices, complex numbers, general nonsymmetric eigenvalue problems, and
specialized performance improvements can be considered after the dense real
number API and core algorithms are established
