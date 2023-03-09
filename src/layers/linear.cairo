use array::ArrayTrait;
use cairo_ml::math::vector::sum_two_vec;
use cairo_ml::math::matrix::matrix_dot_vec;
use cairo_ml::math::matrix::MatrixShape;
use cairo_ml::math::int33::i33;
use cairo_ml::performance::quantizations::quant_vec;

impl Arrayi33Drop of Drop::<Array::<i33>>;

fn linear(
    mut inputs: Array::<i33>,
    weights: Array::<i33>,
    weights_shape: MatrixShape,
    mut bias: Array::<i33>
) -> (Array::<i33>) {
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

