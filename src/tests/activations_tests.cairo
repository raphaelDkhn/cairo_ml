use array::ArrayTrait;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::matrix::matrix_new;
use cairo_ml::activations::relu::relu;

impl Arrayi33Drop of Drop::<Array::<i33>>;

#[test]
#[available_gas(2000000)]
fn relu_tests() {
    let mut matrix_data = ArrayTrait::<i33>::new();
    let val_1 = i33 { inner: 1_u32, sign: false };
    let val_2 = i33 { inner: 2_u32, sign: false };
    let val_3 = i33 { inner: 1_u32, sign: true };
    let val_4 = i33 { inner: 2_u32, sign: true };
    matrix_data.append(val_1);
    matrix_data.append(val_2);
    matrix_data.append(val_3);
    matrix_data.append(val_4);

    let matrix = matrix_new(2_usize, 2_usize, matrix_data);
    let result = relu(@matrix).data;

    assert(*result.at(0_usize).inner == 1_u32, 'result[0] == 1');
    assert(*result.at(0_usize).sign == false, 'result[0] --> positive');
    assert(*result.at(1_usize).inner == 2_u32, 'result[0] == 2');
    assert(*result.at(1_usize).sign == false, 'result[0] --> positive');
    assert(*result.at(2_usize).inner == 0_u32, 'result[0] == 0');
    assert(*result.at(2_usize).sign == false, 'result[0] --> positive');
    assert(*result.at(3_usize).inner == 0_u32, 'result[0] == 0');
    assert(*result.at(3_usize).sign == false, 'result[0] --> positive');
}
