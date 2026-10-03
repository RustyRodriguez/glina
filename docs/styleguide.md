# Rusty's GLinA Style Guide

## List iteration
Prefer list.each when performing side effects on every element, such as printing or logging
```
let numbers = [1, 2, 3, 4, 5]

list.each(numbers, fn(n) {
    io.println(int.to_string(n))
})
```

Prefer list.mapp when want to transform elements in our list and create a new list

```
pub fn scalar_multiply(
  numbers: List(Int),
  scalar: Int,
) -> List(Int) {
  list.map(numbers, fn(n) {
    n * scalar
  })
}
```
Prefer list.fold to 

## Summing and Accumulating Lists
When summing a list of numerical values, prefer Gleam's built-in int.sum or float.sum functions over manually implementing the operation with list.fold.

```
let integers = int.sum([1, 2, 3, 4, 5])
let decimals = float.sum([1.0, 2.0, 3.0, 4.0])
```

```
pub fn sum_of_squares(numbers: List(Int)) -> Int {
  list.fold(numbers, 0, fn(acc, n) {
    acc + n * n
  })
}
```



