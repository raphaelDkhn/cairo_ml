use array::ArrayTrait;
use cairo_ml::math::matrix::MatrixShape;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::signal::valid_correlate_2d;

impl Arrayi33Drop of Drop::<Array::<i33>>;

#[test]
#[available_gas(2000000)]
fn valid_correlate_2d_test() {
    let mut input = ArrayTrait::new();
    input.append(i33 { inner: 1_u32, sign: false });
    input.append(i33 { inner: 6_u32, sign: false });
    input.append(i33 { inner: 2_u32, sign: false });
    input.append(i33 { inner: 5_u32, sign: false });
    input.append(i33 { inner: 3_u32, sign: false });
    input.append(i33 { inner: 1_u32, sign: false });
    input.append(i33 { inner: 7_u32, sign: false });
    input.append(i33 { inner: 0_u32, sign: false });
    input.append(i33 { inner: 4_u32, sign: false });
    let mut input_shape = MatrixShape { num_rows: 3_usize, num_cols: 3_usize };

    let mut kernel = ArrayTrait::new();
    kernel.append(i33 { inner: 1_u32, sign: false });
    kernel.append(i33 { inner: 2_u32, sign: false });
    kernel.append(i33 { inner: 1_u32, sign: true });
    kernel.append(i33 { inner: 0_u32, sign: false });
    let mut kernel_shape = MatrixShape { num_rows: 2_usize, num_cols: 2_usize };

    let mut result = valid_correlate_2d(input, input_shape, kernel, kernel_shape);
    assert(*result.at(0_usize).inner == 8_u32, 'result[0] == 8');
    assert(*result.at(0_usize).sign == false, 'result[0] -> positive');
    assert(*result.at(1_usize).inner == 7_u32, 'result[1] == 7');
    assert(*result.at(1_usize).sign == false, 'result[1] -> positive');
    assert(*result.at(2_usize).inner == 4_u32, 'result[2] == 4');
    assert(*result.at(2_usize).sign == false, 'result[2] -> positive');
    assert(*result.at(3_usize).inner == 5_u32, 'result[3] == 5');
    assert(*result.at(3_usize).sign == false, 'result[3] -> positive');
}

