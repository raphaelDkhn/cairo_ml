use array::ArrayTrait;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::matrix::MatrixShape;
use cairo_ml::math::matrix::__slice_matrix;
use cairo_ml::math::matrix::slice_matrix;
use cairo_ml::math::vector::vec_dot_vec;

use traits::Into;
use debug::print_felt;

impl Arrayi33Drop of Drop::<Array::<i33>>;

// =================================================//
// ================ CROSS CORELATION ===============//
// =================================================//

fn valid_correlate_2d(
    input: Array::<i33>, input_shape: MatrixShape, kernel: Array::<i33>, kernel_shape: MatrixShape
) -> Array::<i33> {
    // Initialize variables.
    let mut _input = input;
    let mut _kernel = kernel;
    let mut result = ArrayTrait::new();
    let max_index = 0_usize
        + (kernel_shape.num_rows * input_shape.num_cols)
        + kernel_shape.num_cols
        - 2_usize;

    __valid_correlate_2d(
        input_shape, kernel_shape, ref _input, ref _kernel, ref result, 0_usize, max_index
    );

    assert(
        result.len() == (input_shape.num_rows - kernel_shape.num_rows + 1_usize)
            * (input_shape.num_cols - kernel_shape.num_cols + 1_usize),
        'wrong output shape'
    );

    return result;
}

fn __valid_correlate_2d(
    input_shape: MatrixShape,
    kernel_shape: MatrixShape,
    ref input: Array::<i33>,
    ref kernel: Array::<i33>,
    ref result: Array::<i33>,
    n: usize,
    max_index: usize
) {
    // --- Check if out of gas ---
    // TODO: Remove when automatically handled by compiler.
    match gas::get_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    let col_index = n % input_shape.num_cols;

    // --- End of the recursion ---
    if (n >= max_index) {
        return ();
    }

    // --- Slice Input ---
    let mut sliced_input = slice_matrix(ref input, input_shape, kernel_shape, n);

    // --- Dot product ---
    let dot = vec_dot_vec(ref sliced_input, ref kernel);

    // --- Append the dot product to the result array ---
    result.append(dot);

    let col_index = n % input_shape.num_cols;
    if (col_index == input_shape.num_cols
        - kernel_shape.num_cols) {
            __valid_correlate_2d(
                input_shape,
                kernel_shape,
                ref input,
                ref kernel,
                ref result,
                n + kernel_shape.num_cols,
                max_index
            );
        } else {
            __valid_correlate_2d(
                input_shape,
                kernel_shape,
                ref input,
                ref kernel,
                ref result,
                n + 1_usize,
                max_index
            );
        }
}
