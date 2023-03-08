use array::ArrayTrait;
use cairo_ml::math::vector::sum_two_vec;
use cairo_ml::math::matrix::matrix_dot_vec;
use cairo_ml::math::matrix::MatrixShape;
use cairo_ml::math::int32::i32;
use cairo_ml::performance::quantizations::quant_vec;

impl Arrayi32Drop of Drop::<Array::<i32>>;

fn linear(
    mut inputs: Array::<i32>,
    weights: Array::<i32>,
    weights_shape: MatrixShape,
    mut bias: Array::<i32>
) -> (Array::<i32>) {
    // --- Checks ---
    assert(weights_shape.num_cols == inputs.len(), 'shape do not match');
    assert(weights_shape.num_rows == bias.len(), 'shape do not match');

    // --- Calculate dot product ---
    let dot_result = matrix_dot_vec(weights, weights_shape, inputs);

    // --- Add bias ---
    let mut result = sum_two_vec(dot_result, bias);

    // --- Return quantized result --- 
    return quant_vec(ref result);
}

