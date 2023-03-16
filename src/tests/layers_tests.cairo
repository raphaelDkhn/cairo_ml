use array::ArrayTrait;
use cairo_ml::layers::linear::linear;
use cairo_ml::layers::conv2d::conv2d;
use cairo_ml::math::matrix::Matrix;
use cairo_ml::math::matrix::matrix_new;
use cairo_ml::math::signed_integers::i33;

impl Arrayi33Drop of Drop::<Array::<i33>>;
impl ArrayMatrixDrop of Drop::<Array::<Matrix>>;
impl ArrayOfArrayMatrixDrop of Drop::<Array::<Array::<Matrix>>>;


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

    let mut result = linear(inputs, @weights, bias);

    assert(*result.at(0_usize).inner == 127_u32, 'result[0] == 127');
    assert(*result.at(1_usize).inner == 6_u32, 'result[1] == 6');
}

#[test]
#[available_gas(200000000000)]
fn conv2D_test() {
    //Intiate inputs
    let mut inputs = ArrayTrait::new();
    inputs.append(input_helper());
    inputs.append(input_helper());
    inputs.append(input_helper());

    //Intiate kernels
    let mut kernel_1 = ArrayTrait::new();
    kernel_1.append(kernel_helper());
    kernel_1.append(kernel_helper());
    kernel_1.append(kernel_helper());
    let mut kernel_2 = ArrayTrait::new();
    kernel_2.append(kernel_helper());
    kernel_2.append(kernel_helper());
    kernel_2.append(kernel_helper());
    let mut kernels = ArrayTrait::new();
    kernels.append(kernel_1);
    kernels.append(kernel_2);

    //Intiate biases
    let mut biases = ArrayTrait::new();
    biases.append(bias_helper());
    biases.append(bias_helper());

    conv2d(@inputs, @kernels, @biases);
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

