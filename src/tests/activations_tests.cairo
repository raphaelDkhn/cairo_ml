use array::ArrayTrait;
use option::OptionTrait;
use traits::Into;

use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::matrix::matrix_new;
use cairo_ml::activations::relu::relu;
use cairo_ml::activations::softmax::softmax;
use cairo_ml::fixed_point::core::ONE_u128;
use cairo_ml::fixed_point::core::FixedType;
use cairo_ml::math::vector::sum_vec_values_fp;

impl Arrayi33Drop of Drop::<Array::<i33>>;
impl ArrayFPDrop of Drop::<Array::<FixedType>>;


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

#[test]
#[available_gas(20000000)]
fn softmax_tests() {
    let mut vec = ArrayTrait::<i33>::new();
    let val_1 = i33 { inner: 1_u32, sign: false };
    let val_2 = i33 { inner: 2_u32, sign: false };
    let val_3 = i33 { inner: 3_u32, sign: false };
    let val_4 = i33 { inner: 4_u32, sign: false };
    let val_5 = i33 { inner: 1_u32, sign: false };
    let val_6 = i33 { inner: 2_u32, sign: false };
    let val_7 = i33 { inner: 3_u32, sign: false };
    vec.append(val_1);
    vec.append(val_2);
    vec.append(val_3);
    vec.append(val_4);
    vec.append(val_5);
    vec.append(val_6);
    vec.append(val_7);

    let result = softmax(@vec);

    assert((*result.at(0_usize).mag).into() == 1586490, 'vec[0]');
    assert((*result.at(1_usize).mag).into() == 4312527, 'vec[1]');
    assert((*result.at(2_usize).mag).into() == 11722663, 'vec[2]');
    assert((*result.at(3_usize).mag).into() == 31865502, 'vec[3]');
    assert((*result.at(4_usize).mag).into() == 1586490, 'vec[4]');
    assert((*result.at(5_usize).mag).into() == 4312527, 'vec[5]');
    assert((*result.at(6_usize).mag).into() == 11722663, 'vec[6]');

    let sum_outputs = sum_vec_values_fp(@result);

    assert(sum_outputs.mag == 67108862_u128, 'sum_outputs = 1');
}

