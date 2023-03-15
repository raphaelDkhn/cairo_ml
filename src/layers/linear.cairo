use array::ArrayTrait;
use cairo_ml::math::vector::sum_two_vec;
use cairo_ml::math::matrix::Matrix;
use cairo_ml::math::matrix::matrix_dot_vec;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::performance::quantizations::quant_vec;

impl Arrayi33Drop of Drop::<Array::<i33>>;

fn linear(inputs: Array::<i33>, weights: @Matrix, bias: Array::<i33>) -> (Array::<i33>) {
    // --- Checks ---
    assert(*weights.cols == inputs.len(), 'shape do not match');
    assert(*weights.rows == bias.len(), 'shape do not match');

    // --- Calculate dot product ---
    let dot_result = matrix_dot_vec(weights, inputs);

    // --- Add bias ---
    let mut result = sum_two_vec(dot_result, bias);

    // --- Return quantized result --- 
    return quant_vec(ref result);
}

