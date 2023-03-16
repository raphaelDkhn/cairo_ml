use array::ArrayTrait;
use option::OptionTrait;

use cairo_ml::math::signed_integers;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::matrix::Matrix;

impl ArrayMatrixDrop of Drop::<Array::<Matrix>>;
impl ArrayTensorCopy of Copy::<Array::<Matrix>>;

#[derive(Copy, Drop)]
struct Tensor {
    rows: usize,
    cols: usize,
    depth: usize,
    data: Array::<Matrix>,
}

fn tensor_new(rows: usize, cols: usize, depth: usize, data: Array::<Matrix>) -> Tensor {
    assert(data.len() == rows * cols * depth, 'Tensor not match dimensions');

    Tensor { rows: rows, cols: cols, depth: depth, data: data,  }
}
