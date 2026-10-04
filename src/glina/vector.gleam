import gleam/list

pub type VectorError {
  NegativeSize(size: Int)
  IndexOutOfBounds(index: Int, size: Int)
  DimensionMismatch(left_size: Int, right_size: Int)
}

pub opaque type Vector {
  Vector(nums: List(Float))
}

pub fn from_list(nums: List(Float)) -> Result(Vector, VectorError) {
  Ok(Vector(nums: nums))
}

pub fn get(vector: Vector, index: Int) -> Result(Float, VectorError) {
  let size = list.length(vector.nums)

  case index < 0 || index >= size {
    True -> Error(IndexOutOfBounds(index, size))
    False -> {
      case list.drop(vector.nums, index) {
        [value, ..] -> Ok(value)
        [] -> Error(IndexOutOfBounds(index, size))
      }
    }
  }
}

pub fn size(vector: Vector) -> Int {
  list.length(vector.nums)
}

pub fn zeros(size: Int) -> Result(Vector, VectorError) {
  case size < 0 {
    True -> Error(NegativeSize(size))
    False -> Ok(Vector(nums: list.repeat(0.0, size)))
  }
}

pub fn ones(size: Int) -> Result(Vector, VectorError) {
  case size < 0 {
    True -> Error(NegativeSize(size))
    False -> Ok(Vector(nums: list.repeat(1.0, size)))
  }
}

pub fn add(v1: Vector, v2: Vector) -> Result(Vector, VectorError) {
  let v1_size = size(v1)
  let v2_size = size(v2)
  case v1_size != v2_size {
    True -> Error(DimensionMismatch(v1_size, v2_size))
    False -> {
      Ok(
        Vector(
          nums: list.map2(v1.nums, v2.nums, fn(left, right) { left +. right }),
        ),
      )
    }
  }
}

pub fn subtract(v1: Vector, v2: Vector) -> Result(Vector, VectorError) {
  let v1_size = size(v1)
  let v2_size = size(v2)
  case v1_size != v2_size {
    True -> Error(DimensionMismatch(v1_size, v2_size))
    False -> {
      Ok(
        Vector(
          nums: list.map2(v1.nums, v2.nums, fn(left, right) { left -. right }),
        ),
      )
    }
  }
}

pub fn scale(vector: Vector, factor: Float) -> Vector {
  Vector(list.map(vector.nums, fn(value) { value *. factor }))
}

pub fn dot(v1: Vector, v2: Vector) -> Result(Float, VectorError) {
  let v1_size = size(v1)
  let v2_size = size(v2)
  case v1_size != v2_size {
    True -> Error(DimensionMismatch(v1_size, v2_size))
    False ->
      Ok(
        list.zip(v1.nums, v2.nums)
        |> list.map(fn(pair) {
          let #(x, y) = pair
          x *. y
        })
        |> list.fold(0.0, fn(acc, x) { acc +. x }),
      )
  }
}
