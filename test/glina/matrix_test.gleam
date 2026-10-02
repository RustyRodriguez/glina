import glina/matrix

pub fn from_rows_accepts_rectangular_rows_test() {
  let rows = [[1.0, 3.0, 7.0], [2.0, 4.0, 6.0], [8.0, 9.0, 10.0]]

  let assert Ok(mat) = matrix.from_rows(rows)

  assert matrix.shape(mat) == #(3, 3)
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

pub fn get_returns_element_at_row_and_column_test() {
  let rows = [[1.0, 3.0, 7.0], [2.0, 4.0, 6.0], [8.0, 9.0, 10.0]]

  let assert Ok(mat) = matrix.from_rows(rows)

  assert matrix.get(mat, 0, 0) == Ok(1.0)
  assert matrix.get(mat, 0, 1) == Ok(3.0)
  assert matrix.get(mat, 0, 2) == Ok(7.0)
  assert matrix.get(mat, 1, 0) == Ok(2.0)
  assert matrix.get(mat, 1, 1) == Ok(4.0)
  assert matrix.get(mat, 1, 2) == Ok(6.0)
  assert matrix.get(mat, 2, 0) == Ok(8.0)
  assert matrix.get(mat, 2, 1) == Ok(9.0)
  assert matrix.get(mat, 2, 2) == Ok(10.0)
}

pub fn get_returns_error_for_negative_row_test() {
  let rows = [[1.0, 3.0, 7.0], [2.0, 4.0, 6.0], [8.0, 9.0, 10.0]]

  let assert Ok(mat) = matrix.from_rows(rows)

  assert matrix.get(mat, -1, 2) == Error(matrix.IndexOutOfBounds(-1, 2))
}

pub fn get_returns_error_for_negative_column_test() {
  let rows = [[1.0, 3.0, 7.0], [2.0, 4.0, 6.0], [8.0, 9.0, 10.0]]

  let assert Ok(mat) = matrix.from_rows(rows)

  assert matrix.get(mat, 1, -2) == Error(matrix.IndexOutOfBounds(1, -2))
}

pub fn get_returns_error_for_row_past_end_test() {
  let rows = [[1.0, 3.0, 7.0], [2.0, 4.0, 6.0], [8.0, 9.0, 10.0]]

  let assert Ok(mat) = matrix.from_rows(rows)

  assert matrix.get(mat, 3, 1) == Error(matrix.IndexOutOfBounds(3, 1))
}

pub fn get_returns_error_for_column_past_end_test() {
  let rows = [[1.0, 3.0, 7.0], [2.0, 4.0, 6.0], [8.0, 9.0, 10.0]]

  let assert Ok(mat) = matrix.from_rows(rows)

  assert matrix.get(mat, 1, 3) == Error(matrix.IndexOutOfBounds(1, 3))
}

pub fn get_row_returns_requested_row_test() {
  let rows = [[1.0, 3.0, 7.0], [2.0, 4.0, 6.0], [8.0, 9.0, 10.0]]

  let assert Ok(mat) = matrix.from_rows(rows)

  let assert Ok(first) = matrix.get_row(mat, 0)
  let assert Ok(second) = matrix.get_row(mat, 1)
  let assert Ok(third) = matrix.get_row(mat, 2)

  assert first == [1.0, 3.0, 7.0]
  assert second == [2.0, 4.0, 6.0]
  assert third == [8.0, 9.0, 10.0]
}

pub fn get_row_returns_error_for_negative_index_test() {
  let rows = [[1.0, 3.0, 7.0], [2.0, 4.0, 6.0], [8.0, 9.0, 10.0]]

  let assert Ok(mat) = matrix.from_rows(rows)

  assert matrix.get_row(mat, -1) == Error(matrix.RowIndexOutOfBounds(-1))
}

pub fn get_row_returns_error_for_index_past_end_test() {
  let rows = [[1.0, 3.0, 7.0], [2.0, 4.0, 6.0], [8.0, 9.0, 10.0]]

  let assert Ok(mat) = matrix.from_rows(rows)

  assert matrix.get_row(mat, 3) == Error(matrix.RowIndexOutOfBounds(3))
}

pub fn get_column_returns_requested_column_test() {
  let rows = [[1.0, 3.0, 7.0], [2.0, 4.0, 6.0], [8.0, 9.0, 10.0]]

  let assert Ok(mat) = matrix.from_rows(rows)

  let assert Ok(first) = matrix.get_column(mat, 0)
  let assert Ok(second) = matrix.get_column(mat, 1)
  let assert Ok(third) = matrix.get_column(mat, 2)

  assert first == [1.0, 2.0, 8.0]
  assert second == [3.0, 4.0, 9.0]
  assert third == [7.0, 6.0, 10.0]
}

pub fn get_column_returns_error_for_negative_index_test() {
  let rows = [[1.0, 3.0, 7.0], [2.0, 4.0, 6.0], [8.0, 9.0, 10.0]]

  let assert Ok(mat) = matrix.from_rows(rows)

  assert matrix.get_column(mat, -1) == Error(matrix.ColumnIndexOutOfBounds(-1))
}

pub fn get_column_returns_error_for_index_past_end_test() {
  let rows = [[1.0, 3.0, 7.0], [2.0, 4.0, 6.0], [8.0, 9.0, 10.0]]

  let assert Ok(mat) = matrix.from_rows(rows)

  assert matrix.get_column(mat, -1) == Error(matrix.ColumnIndexOutOfBounds(-1))
}

pub fn transpose_swaps_rows_and_columns_test() {
  let rows = [[1.0, 3.0, 7.0], [2.0, 4.0, 6.0], [8.0, 9.0, 10.0]]

  let assert Ok(mat) = matrix.from_rows(rows)
  let assert Ok(transposed_mat) = matrix.transpose(mat)

  let assert Ok(first) = matrix.get_row(transposed_mat, 0)
  let assert Ok(second) = matrix.get_row(transposed_mat, 1)
  let assert Ok(third) = matrix.get_row(transposed_mat, 2)

  assert first == [1.0, 2.0, 8.0]
  assert second == [3.0, 4.0, 9.0]
  assert third == [7.0, 6.0, 10.0]
}
