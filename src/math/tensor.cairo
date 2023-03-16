use array::ArrayTrait;
use option::OptionTrait;

use cairo_ml::math::signed_integers;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::matrix::Matrix;

impl Arrayi33Drop of Drop::<Array::<i33>>;

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
