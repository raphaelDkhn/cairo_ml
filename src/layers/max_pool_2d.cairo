use array::ArrayTrait;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::matrix::Matrix;
use cairo_ml::math::matrix::matrix_new;
use cairo_ml::math::matrix::slice_matrix;
use cairo_ml::math::vector::find_max;

use debug::print_felt;
use traits::Into;

impl Arrayi33Drop of Drop::<Array::<i33>>;

// =================================================//
// ================== MAX POOL 2D ==================//
// =================================================//

// Computes a 2D max pooling.
// # Arguments
// * input - A reference to a Matrix to be correlated.
// * kernel_size - A tuple representing the size of the kernel (number of rows, number of cols).
// # Returns
// * Matrix - The result of the 2D max pooling.
// # Panics
// * If the length of the output data does not match the expected size based on the input and kernel size.
fn max_pool_2d(input: @Matrix, kernel_size: (usize, usize)) -> Matrix {
    // Initialize variables.
    let mut output_data = ArrayTrait::new();
    let (kernel_rows, kernel_cols) = kernel_size;

   // print_felt((*input.rows).into());
   // print_felt((kernel_rows).into());

    let output_rows = *input.rows - kernel_rows + 1_usize;
    print_felt(555);
    let output_cols = *input.cols - kernel_cols + 1_usize;
    print_felt(999);

    __max_pool_2d(
        input, kernel_rows, kernel_cols, ref output_data, 0_usize, output_rows * output_cols
    );

    assert(output_data.len() == output_rows * output_cols, 'wrong output shape');

    return matrix_new(output_rows, output_cols, output_data);
}

fn __max_pool_2d(
    input: @Matrix,
    kernel_rows: usize,
    kernel_cols: usize,
    ref output_data: Array::<i33>,
    n: usize,
    max_len: usize
) {
    // TODO: Remove when automatically handled by compiler.
    match try_fetch_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    let col_index = n % *input.cols;
    // --- End of the recursion ---
    if (output_data.len() > max_len - 1_usize) {
        return ();
    }

    // --- Slice Input ---
    let mut sliced_input = slice_matrix(input, kernel_rows, kernel_cols, n);

    // --- Max ---
    let max = find_max(@sliced_input.data);

    // --- Append the max value to the result array ---
    output_data.append(max);

    let col_index = n % *input.cols;

    if (col_index == *input.cols
        - kernel_cols) {
            __max_pool_2d(
                input, kernel_rows, kernel_cols, ref output_data, n + kernel_cols, max_len
            );
        } else {
            __max_pool_2d(input, kernel_rows, kernel_cols, ref output_data, n + 1_usize, max_len);
        }
}


// Computes a 2D max pooling on multiple matrices.
// # Arguments
// * input - A reference to an array of Matrices to be correlated.
// * kernel_size - A tuple representing the size of the kernel (number of rows, number of cols).
// # Returns
// * Array::<Matrix> - The result of the batch 2D max pooling.
fn batch_max_pool_2d(inputs: @Array::<Matrix>, kernel_size: (usize, usize)) -> Array::<Matrix> {
    // Initialize variables.
    let mut result = ArrayTrait::new();

    __batch_max_pool_2d(inputs, kernel_size, ref result, 0_usize);

    return result;
}


fn __batch_max_pool_2d(
    inputs: @Array::<Matrix>, kernel_size: (usize, usize), ref result: Array::<Matrix>, n: usize
) {
    // TODO: Remove when automatically handled by compiler.
    match try_fetch_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    // --- End of the recursion ---
    if (n == inputs.len()) {
        return ();
    }

    result.append(max_pool_2d(inputs.at(n), kernel_size));

    __batch_max_pool_2d(inputs, kernel_size, ref result, n + 1_usize);
}
