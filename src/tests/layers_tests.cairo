use array::ArrayTrait;
use cairo_ml::layers::linear;
use cairo_ml::layers::conv2d;
use cairo_ml::math::matrix::Matrix;
use cairo_ml::math::matrix::matrix_new;
use cairo_ml::math::tensor::tensor_new;
use cairo_ml::math::signed_integers::i33;

#[test]
#[available_gas(2000000)]
fn linear_layer_test() {
    let mut inputs = ArrayTrait::new();
    inputs.append(i33 { inner: 71_u32, sign: true });
    inputs.append(i33 { inner: 38_u32, sign: false });
    inputs.append(i33 { inner: 62_u32, sign: false });

    let mut weights_data = ArrayTrait::new();
    weights_data.append(i33 { inner: 8_u32, sign: true });
    weights_data.append(i33 { inner: 64_u32, sign: false });
    weights_data.append(i33 { inner: 40_u32, sign: false });
    weights_data.append(i33 { inner: 33_u32, sign: true });
    weights_data.append(i33 { inner: 34_u32, sign: true });
    weights_data.append(i33 { inner: 20_u32, sign: true });

    let mut weights = matrix_new(2_usize, 3_usize, weights_data);

    let mut bias = ArrayTrait::new();
    bias.append(i33 { inner: 61_u32, sign: false });
    bias.append(i33 { inner: 71_u32, sign: true });

    let mut result = linear::linear(inputs, @weights, bias);

    assert(*result.at(0_usize).inner == 127_u32, 'result[0] == 127');
    assert(*result.at(1_usize).inner == 6_u32, 'result[1] == 6');
}

#[test]
#[available_gas(2000000)]
fn conv2D_test() {
    let mut input_data = ArrayTrait::new();
    input_data.append(input_helper());
    input_data.append(input_helper());
    input_data.append(input_helper());
    let mut input = tensor_new(1_usize, 1_usize, 3_usize, input_data);

    let mut kernels_data = ArrayTrait::new();
    kernels_data.append(input_helper());
    kernels_data.append(input_helper());
    kernels_data.append(input_helper());
    kernels_data.append(input_helper());
    kernels_data.append(input_helper());
    kernels_data.append(input_helper());
    let mut kernels = tensor_new(1_usize, 2_usize, 3_usize, kernels_data);

    let mut biases_data = ArrayTrait::new();
    biases_data.append(input_helper());
    biases_data.append(input_helper());
    let mut biases = tensor_new(1_usize, 2_usize, 1_usize, biases_data);

    //conv2d::conv2d(@input, @kernels, @biases);
}

fn input_helper() -> Matrix {
    let mut matrix_data = ArrayTrait::new();
    matrix_data.append(i33 { inner: 1_u32, sign: false });
    matrix_data.append(i33 { inner: 6_u32, sign: false });
    matrix_data.append(i33 { inner: 2_u32, sign: false });
    matrix_data.append(i33 { inner: 5_u32, sign: false });
    matrix_data.append(i33 { inner: 3_u32, sign: false });
    matrix_data.append(i33 { inner: 1_u32, sign: false });
    matrix_data.append(i33 { inner: 7_u32, sign: false });
    matrix_data.append(i33 { inner: 0_u32, sign: false });
    matrix_data.append(i33 { inner: 4_u32, sign: false });
    matrix_new(3_usize, 3_usize, matrix_data)
}

fn kernel_helper() -> Matrix {
    let mut matrix_data = ArrayTrait::new();
    matrix_data.append(i33 { inner: 1_u32, sign: false });
    matrix_data.append(i33 { inner: 2_u32, sign: false });
    matrix_data.append(i33 { inner: 1_u32, sign: true });
    matrix_data.append(i33 { inner: 0_u32, sign: false });
    matrix_new(2_usize, 2_usize, matrix_data)
}

fn bias_helper() -> Matrix {
    let mut matrix_data = ArrayTrait::new();
    matrix_data.append(i33 { inner: 1_u32, sign: false });
    matrix_data.append(i33 { inner: 2_u32, sign: false });
    matrix_data.append(i33 { inner: 3_u32, sign: true });
    matrix_data.append(i33 { inner: 4_u32, sign: false });
    matrix_new(2_usize, 2_usize, matrix_data)
}

