use array::ArrayTrait;
use cairo_ml::math::matrix::Matrix;
use cairo_ml::math::matrix::matrix_dot_vec;
use cairo_ml::math::matrix::slice_matrix;
use cairo_ml::math::matrix::matrix_new;
use cairo_ml::math::signed_integers::i33;

impl Arrayi33Drop of Drop::<Array::<i33>>;

#[test]
#[available_gas(2000000)]
fn dot_test() {
    // Test with random numbers

    let mut matrix_data = ArrayTrait::new();
    matrix_data.append(i33 { inner: 87_u32, sign: false });
    matrix_data.append(i33 { inner: 28_u32, sign: true });
    matrix_data.append(i33 { inner: 104_u32, sign: true });
    matrix_data.append(i33 { inner: 42_u32, sign: false });
    matrix_data.append(i33 { inner: 6_u32, sign: true });
    matrix_data.append(i33 { inner: 75_u32, sign: false });

    let mut matrix = matrix_new(2_usize, 3_usize, matrix_data);

    let mut vec = ArrayTrait::new();
    vec.append(i33 { inner: 3_u32, sign: false });
    vec.append(i33 { inner: 63_u32, sign: true });
    vec.append(i33 { inner: 31_u32, sign: false });

    let mut result = matrix_dot_vec(@matrix, vec);

    assert(*result.at(0_usize).inner == 1199_u32, 'result[0] == -1199');
    assert(*result.at(0_usize).sign == true, 'result[0] == -1199');
    assert(*result.at(1_usize).inner == 2829_u32, 'result[1] == 2829');
    assert(*result.at(1_usize).sign == false, 'result[1] == 2829');
}

#[test]
#[available_gas(20000000)]
fn slice_matrix_test() {
    let matrix = matrix_helper();

    // TEST WITH SLICER (2,2)

    let slicer = (2_usize, 2_usize);
    let mut result = slice_matrix(@matrix, 2_usize, 2_usize, 0_usize).data;
// assert(*result.at(0_usize).inner == 1_u32, 'result[0] == 1');
// assert(*result.at(1_usize).inner == 2_u32, 'result[1] == 2');
// assert(*result.at(2_usize).inner == 4_u32, 'result[2] == 4');
// assert(*result.at(3_usize).inner == 5_u32, 'result[3] == 5');

// // TEST WITH SLICER (2,3)
// let slicer = (2_usize, 3_usize);
// let mut result = slice_matrix(@matrix, slicer, 0_usize).data;
// assert(*result.at(0_usize).inner == 1_u32, 'result[0] == 1');
// assert(*result.at(1_usize).inner == 2_u32, 'result[1] == 2');
// assert(*result.at(2_usize).inner == 3_u32, 'result[2] == 3');
// assert(*result.at(3_usize).inner == 4_u32, 'result[3] == 4');
// assert(*result.at(4_usize).inner == 5_u32, 'result[3] == 5');
// assert(*result.at(5_usize).inner == 6_u32, 'result[3] == 6');

// // TEST WITH SLICER (3,2)
// let slicer = (3_usize, 2_usize);
// let mut result = slice_matrix(@matrix, slicer, 0_usize).data;
// assert(*result.at(0_usize).inner == 1_u32, 'result[0] == 1');
// assert(*result.at(1_usize).inner == 2_u32, 'result[1] == 2');
// assert(*result.at(2_usize).inner == 4_u32, 'result[2] == 4');
// assert(*result.at(3_usize).inner == 5_u32, 'result[3] == 5');
// assert(*result.at(4_usize).inner == 7_u32, 'result[3] == 7');
// assert(*result.at(5_usize).inner == 8_u32, 'result[3] == 8');

// // TEST SLICING WITH DIFFERENT START INDEX
// let slicer = (2_usize, 2_usize);
// let mut result = slice_matrix(@matrix, slicer, 1_usize).data;
// assert(*result.at(0_usize).inner == 2_u32, 'result[0] == 2');
// assert(*result.at(1_usize).inner == 3_u32, 'result[1] == 3');
// assert(*result.at(2_usize).inner == 5_u32, 'result[2] == 5');
// assert(*result.at(3_usize).inner == 6_u32, 'result[3] == 6');
}

fn matrix_helper() -> Matrix {
    let mut data = ArrayTrait::new();
    data.append(i33 { inner: 1_u32, sign: false });
    data.append(i33 { inner: 2_u32, sign: false });
    data.append(i33 { inner: 3_u32, sign: false });
    data.append(i33 { inner: 4_u32, sign: false });
    data.append(i33 { inner: 5_u32, sign: false });
    data.append(i33 { inner: 6_u32, sign: false });
    data.append(i33 { inner: 7_u32, sign: false });
    data.append(i33 { inner: 8_u32, sign: false });
    data.append(i33 { inner: 9_u32, sign: false });

    matrix_new(3_usize, 3_usize, data)
}

