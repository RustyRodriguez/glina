import gleam/list

pub type VectorError {
  NegativeSize(size: Int)
  IndexOutOfBounds(index: Int, size: Int)
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
