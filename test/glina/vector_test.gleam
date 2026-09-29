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

pub fn scale_vector_by_factor_multiplies_each_element_test() {
  let assert Ok(values) = vector.from_list([1.0, 2.0, 3.0])
  let scaled_values = vector.scale(values, 3.0)

  assert vector.size(scaled_values) == 3

  let assert Ok(first) = vector.get(scaled_values, 0)
  let assert Ok(second) = vector.get(scaled_values, 1)
  let assert Ok(third) = vector.get(scaled_values, 2)

  assert first == 3.0
  assert second == 6.0
  assert third == 9.0
}

pub fn add_with_matching_sizes_returns_sum_test() {
  let assert Ok(v1) = vector.from_list([1.0, 2.0, 3.0])
  let assert Ok(v2) = vector.from_list([5.0, 2.0, 4.0])

  let assert Ok(sum_vector) = vector.add(v1, v2)

  let assert Ok(first) = vector.get(sum_vector, 0)
  let assert Ok(second) = vector.get(sum_vector, 1)
  let assert Ok(third) = vector.get(sum_vector, 2)

  assert first == 6.0
  assert second == 4.0
  assert third == 7.0
}

pub fn add_with_mismatched_sizes_returns_error_test() {
  let assert Ok(v1) = vector.from_list([1.0, 2.0, 3.0])
  let assert Ok(v2) = vector.from_list([5.0, 2.0, 4.0, 5.0])

  assert vector.add(v1, v2) == Error(vector.DimensionMismatch(3, 4))
}

pub fn subtract_with_matching_sizes_returns_difference_test() {
  let assert Ok(v1) = vector.from_list([1.0, 2.0, 3.0])
  let assert Ok(v2) = vector.from_list([1.0, 1.0, 1.0])

  let assert Ok(difference_vector) = vector.subtract(v1, v2)

  let assert Ok(first) = vector.get(difference_vector, 0)
  let assert Ok(second) = vector.get(difference_vector, 1)
  let assert Ok(third) = vector.get(difference_vector, 2)

  assert first == 0.0
  assert second == 1.0
  assert third == 2.0
}

pub fn subtract_with_mismatched_sizes_returns_error_test() {
  let assert Ok(v1) = vector.from_list([1.0, 2.0, 3.0])
  let assert Ok(v2) = vector.from_list([5.0, 2.0, 4.0, 5.0])

  assert vector.subtract(v1, v2) == Error(vector.DimensionMismatch(3, 4))
}

pub fn get_returns_element_at_valid_index_test() {
  let assert Ok(values) = vector.from_list([1.0, 2.0, 3.0])

  let assert Ok(value) = vector.get(values, 0)

  assert value == 1.0
}

pub fn get_returns_error_for_negative_index_test() {
  let assert Ok(values) = vector.from_list([1.0, 2.0, 3.0])

  assert vector.get(values, -1) == Error(vector.IndexOutOfBounds(-1, 3))
}

pub fn get_returns_error_when_index_equals_size_test() {
  let assert Ok(values) = vector.from_list([1.0, 2.0, 3.0])

  assert vector.get(values, 3) == Error(vector.IndexOutOfBounds(3, 3))
}

pub fn dot_with_matching_sizes_returns_dot_product_test() {
  let assert Ok(v1) = vector.from_list([1.0, 2.0, 3.0])
  let assert Ok(v2) = vector.from_list([5.0, 2.0, 4.0])

  let assert Ok(dot_product) = vector.dot(v1, v2)

  assert dot_product == 21.0
}

pub fn dot_with_mismatched_sizes_returns_error_test() {
  let assert Ok(v1) = vector.from_list([1.0, 2.0, 3.0])
  let assert Ok(v2) = vector.from_list([5.0, 2.0, 4.0, 5.0])

  assert vector.dot(v1, v2) == Error(vector.DimensionMismatch(3, 4))
}
