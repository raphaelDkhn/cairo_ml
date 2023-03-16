use array::ArrayTrait;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::vector::sum_two_vec;
use cairo_ml::math::tensor::Tensor;
use cairo_ml::math::tensor::tensor_new;
use cairo_ml::math::signal::valid_correlate_2d;
use cairo_ml::math::matrix::Matrix;
use cairo_ml::math::matrix::matrix_new;
use cairo_ml::math::matrix::slice_arr_of_matrices;

impl Arrayi33Drop of Drop::<Array::<i33>>;

fn conv2d(input: @Tensor, kernels: @Tensor, biases: @Tensor) -> Tensor {
    assert(*kernels.depth == *input.depth, 'kernels depth do not match');

    //Initialize variables
    let mut output_data = ArrayTrait::new();

    __conv2d(input, kernels, biases, ref output_data, 0_usize);

    return tensor_new(rows: 1_usize, cols: 1_usize, depth: biases.data.len(), data: output_data);
}

fn __conv2d(
    input: @Tensor, kernels: @Tensor, biases: @Tensor, ref output_data: Array::<Matrix>, n: usize, 
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

    // --- End of the recursion ---
    if n == biases.data.len() {
        return ();
    }

    let get_kernel_data = slice_arr_of_matrices(
        kernels.data, n * *kernels.depth, *kernels.depth * (n + 1_usize)
    );

    let kernel = tensor_new(1_usize, 1_usize, *kernels.depth, get_kernel_data);

    let output_n_data = ArrayTrait::new();
    let mut acc_correlation = ArrayTrait::new();
    let mut output_n = matrix_new(*biases.data.at(n).rows, *biases.data.at(n).cols, output_n_data);

    conv2d_by_depth(input, @kernel, biases.data.at(n), ref acc_correlation, ref output_n, 0_usize);
    output_data.append(output_n);

    __conv2d(input, kernels, biases, ref output_data, n + 1_usize);
}

fn conv2d_by_depth(
    input: @Tensor,
    kernel: @Tensor,
    bias: @Matrix,
    ref acc_correlation: Array::<i33>,
    ref output: Matrix,
    n: usize
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

    // --- End of the recursion ---
    if n == *kernel.depth {
        return ();
    }

    let correlation = @valid_correlate_2d(input.data.at(n), kernel.data.at(n));

    if (n > 0_usize) {
        acc_correlation = sum_two_vec(@acc_correlation, correlation.data);

        if n == *kernel.depth
            - 1_usize {
                // --- Sum bias ---
                let sum = sum_two_vec(@acc_correlation, bias.data);
                output.data = sum;
            }
    }

    conv2d_by_depth(input, kernel, bias, ref acc_correlation, ref output, n + 1_usize);
}
