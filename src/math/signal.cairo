use array::ArrayTrait;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::matrix::Matrix;
use cairo_ml::math::matrix::matrix_new;
use cairo_ml::math::matrix::slice_matrix;
use cairo_ml::math::vector::vec_dot_vec;
use cairo_ml::utils::check_gas;

// =================================================//
// ================ CROSS CORELATION ===============//
// =================================================//

// Computes a valid 2D cross-correlation between a Matrix and a kernel.
// # Arguments
// * input - A reference to a Matrix to be correlated.
// * kernel - A reference to a Matrix representing the kernel to be used in the correlation.
// # Returns
// * Matrix - The result of the valid cross-correlation of the input Matrix and kernel.
// # Panics
// * If the length of the output data does not match the expected size based on the input and kernel shapes.
fn valid_correlate_2d(input: @Matrix, kernel: @Matrix) -> Matrix {
    // Initialize variables.
    let mut output_data = ArrayTrait::new();
    let max_index = 0_usize + (*kernel.rows * *input.cols) + *kernel.cols - 2_usize;

    __valid_correlate_2d(input, kernel, ref output_data, 0_usize, max_index);

    let output_rows = *input.rows - *kernel.rows + 1_usize;
    let output_cols = *input.cols - *kernel.cols + 1_usize;

    assert(output_data.len() == output_rows * output_cols, 'wrong output shape');

    return matrix_new(output_rows, output_cols, output_data);
}

fn __valid_correlate_2d(
    input: @Matrix, kernel: @Matrix, ref output_data: Array::<i33>, n: usize, max_index: usize
) {
    check_gas();

    let col_index = n % *input.cols;
    // --- End of the recursion ---
    if (n >= max_index) {
        return ();
    }
    // --- Slice Input ---
    let mut sliced_input = slice_matrix(input, *kernel.rows, *kernel.cols, n);

    // --- Dot product ---
    let dot = vec_dot_vec(@sliced_input.data, kernel.data);

    // --- Append the dot product to the result array ---
    output_data.append(dot);

    let col_index = n % *input.cols;
    if (col_index == *input.cols
        - *kernel.cols) {
            __valid_correlate_2d(input, kernel, ref output_data, n + *kernel.cols, max_index);
        } else {
            __valid_correlate_2d(input, kernel, ref output_data, n + 1_usize, max_index);
        }
}
