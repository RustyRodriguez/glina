import gleam/list

pub opaque type Matrix {
  Matrix(rows: List(List(Float)))
}

pub type MatrixError {
  InvalidRows(List(List(Float)))
  EmptyMatrix(List(List(Float)))
  IndexOutOfBounds(Int, Int)
  RowIndexOutOfBounds(Int)
  ColumnIndexOutOfBounds(Int)
}

pub fn from_rows(rows: List(List(Float))) -> Result(Matrix, MatrixError) {
  case rows {
    [] -> Error(EmptyMatrix(rows))
    [first_row, ..] -> {
      let columns = list.length(first_row)
      case list.all(rows, fn(row) { list.length(row) == columns }) {
        True -> Ok(Matrix(rows))
        False -> Error(InvalidRows(rows))
      }
    }
  }
}

pub fn shape(mat: Matrix) -> #(Int, Int) {
  case mat.rows {
    [] -> #(0, 0)
    [first_row, ..] -> #(list.length(mat.rows), list.length(first_row))
  }
}

pub fn get(mat: Matrix, row: Int, column: Int) -> Result(Float, MatrixError) {
  case row < 0 || column < 0 {
    True -> Error(IndexOutOfBounds(row, column))
    False -> {
      case list.drop(mat.rows, row) {
        [row_values, ..] ->
          case list.drop(row_values, column) {
            [value, ..] -> Ok(value)
            [] -> Error(IndexOutOfBounds(row, column))
          }
        [] -> Error(IndexOutOfBounds(row, column))
      }
    }
  }
}

pub fn get_row(mat: Matrix, index: Int) -> Result(List(Float), MatrixError) {
  case index < 0 {
    True -> Error(RowIndexOutOfBounds(index))
    False -> {
      case list.drop(mat.rows, index) {
        [row, ..] -> Ok(row)
        [] -> Error(RowIndexOutOfBounds(index))
      }
    }
  }
}

pub fn get_column(mat: Matrix, index: Int) -> Result(List(Float), MatrixError) {
  case index < 0 {
    True -> Error(ColumnIndexOutOfBounds(index))
    False -> {
      list.try_map(mat.rows, fn(row) {
        case list.drop(row, index) {
          [value, ..] -> Ok(value)
          [] -> Error(ColumnIndexOutOfBounds(index))
        }
      })
    }
  }
}

pub fn transpose(mat: Matrix) -> Result(Matrix, MatrixError) {
  let #(_, column_count) = shape(mat)

  case transpose_columns(mat, 0, column_count, []) {
    Error(error) -> Error(error)
    Ok(rows) -> Ok(Matrix(rows))
  }
}

fn transpose_columns(
  mat: Matrix,
  column_index: Int,
  column_count: Int,
  accumulated_rows: List(List(Float)),
) -> Result(List(List(Float)), MatrixError) {
  case column_index >= column_count {
    True -> Ok(list.reverse(accumulated_rows))
    False ->
      case get_column(mat, column_index) {
        Error(error) -> Error(error)
        Ok(column) ->
          transpose_columns(mat, column_index + 1, column_count, [
            column,
            ..accumulated_rows
          ])
      }
  }
}
