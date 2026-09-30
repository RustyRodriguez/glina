import glina/matrix

pub fn from_rows_accepts_rectangular_rows_test() {
  let rows = [[1.0, 3.0, 7.0], [2.0, 4.0, 6.0], [8.0, 9.0, 10.0]]

  let assert Ok(rectangular_matrix) = matrix.from_rows(rows)

  assert matrix.shape(rectangular_matrix) == #(3, 3)
}

pub fn from_rows_accepts_rows_with_zero_columns_test() {
  let rows = [[], [], []]

  let assert Ok(empty_column_matrix) = matrix.from_rows(rows)

  assert matrix.shape(empty_column_matrix) == #(3, 0)
}

pub fn from_rows_rejects_empty_input_test() {
  assert matrix.from_rows([]) == Error(matrix.EmptyMatrix([]))
}

pub fn from_rows_rejects_ragged_rows_test() {
  let rows = [[1.0, 2.0], [3.0, 4.0, 5.0]]

  assert matrix.from_rows(rows) == Error(matrix.InvalidRows(rows))
}
