import glina/vector

pub fn zeros_with_positive_size_creates_zero_vector_test() {
  let assert Ok(values) = vector.zeros(3)

  let assert Ok(first) = vector.get(values, 0)
  let assert Ok(second) = vector.get(values, 1)
  let assert Ok(third) = vector.get(values, 2)

  assert first == 0.0
  assert second == 0.0
  assert third == 0.0
}

pub fn zeros_with_zero_size_creates_empty_vector_test() {
  let assert Ok(values) = vector.zeros(0)

  assert vector.size(values) == 0
}

pub fn zeros_with_negative_size_returns_error_test() {
  assert vector.zeros(-3) == Error(vector.NegativeSize(-3))
}

pub fn ones_with_positive_size_creates_ones_vector_test() {
  let assert Ok(values) = vector.ones(3)

  let assert Ok(first) = vector.get(values, 0)
  let assert Ok(second) = vector.get(values, 1)
  let assert Ok(third) = vector.get(values, 2)

  assert first == 1.0
  assert second == 1.0
  assert third == 1.0
}

pub fn ones_with_zero_size_creates_empty_vector_test() {
  let assert Ok(values) = vector.ones(0)

  assert vector.size(values) == 0
}

pub fn ones_with_negative_size_returns_error_test() {
  assert vector.ones(-3) == Error(vector.NegativeSize(-3))
}

pub fn from_list_preserves_values_and_order_test() {
  let assert Ok(values) = vector.from_list([1.0, -3.5, 5.5])

  assert vector.size(values) == 3

  let assert Ok(first) = vector.get(values, 0)
  let assert Ok(second) = vector.get(values, 1)
  let assert Ok(third) = vector.get(values, 2)

  assert first == 1.0
  assert second == -3.5
  assert third == 5.5
}

pub fn from_list_accepts_empty_list_test() {
  let assert Ok(values) = vector.from_list([])

  assert vector.size(values) == 0
}
