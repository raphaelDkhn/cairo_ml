use array::ArrayTrait;
use cairo_ml::math::matrix::matrix_new;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::signal::valid_correlate_2d;

impl Arrayi33Drop of Drop::<Array::<i33>>;

#[test]
#[available_gas(2000000)]
fn valid_correlate_2d_test() {
    let mut input_data = ArrayTrait::new();
    input_data.append(i33 { inner: 1_u32, sign: false });
    input_data.append(i33 { inner: 6_u32, sign: false });
    input_data.append(i33 { inner: 2_u32, sign: false });
    input_data.append(i33 { inner: 5_u32, sign: false });
    input_data.append(i33 { inner: 3_u32, sign: false });
    input_data.append(i33 { inner: 1_u32, sign: false });
    input_data.append(i33 { inner: 7_u32, sign: false });
    input_data.append(i33 { inner: 0_u32, sign: false });
    input_data.append(i33 { inner: 4_u32, sign: false });
    let mut input = matrix_new(3_usize, 3_usize, input_data);

    let mut kernel_data = ArrayTrait::new();
    kernel_data.append(i33 { inner: 1_u32, sign: false });
    kernel_data.append(i33 { inner: 2_u32, sign: false });
    kernel_data.append(i33 { inner: 1_u32, sign: true });
    kernel_data.append(i33 { inner: 0_u32, sign: false });
    let mut kernel = matrix_new(2_usize, 2_usize, kernel_data);

    let mut result = valid_correlate_2d(@input, @kernel).data;
    assert(*result.at(0_usize).inner == 8_u32, 'result[0] == 8');
    assert(*result.at(0_usize).sign == false, 'result[0] -> positive');
    assert(*result.at(1_usize).inner == 7_u32, 'result[1] == 7');
    assert(*result.at(1_usize).sign == false, 'result[1] -> positive');
    assert(*result.at(2_usize).inner == 4_u32, 'result[2] == 4');
    assert(*result.at(2_usize).sign == false, 'result[2] -> positive');
    assert(*result.at(3_usize).inner == 5_u32, 'result[3] == 5');
    assert(*result.at(3_usize).sign == false, 'result[3] -> positive');
}

