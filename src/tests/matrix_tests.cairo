use array::ArrayTrait;

use cairo_ml::math::matrix::matrix_dot_vec;
use cairo_ml::math::matrix::slice_matrix;
use cairo_ml::math::matrix::MatrixShape;
use cairo_ml::math::signed_integers::i33;

use traits::Into;
use debug::print_felt;

impl Arrayi33Drop of Drop::<Array::<i33>>;

#[test]
#[available_gas(2000000)]
fn dot_test() {
    // Test with random numbers

    let mut matrix = ArrayTrait::new();
    matrix.append(i33 { inner: 87_u32, sign: false });
    matrix.append(i33 { inner: 28_u32, sign: true });
    matrix.append(i33 { inner: 104_u32, sign: true });
    matrix.append(i33 { inner: 42_u32, sign: false });
    matrix.append(i33 { inner: 6_u32, sign: true });
    matrix.append(i33 { inner: 75_u32, sign: false });

    let mut shape = MatrixShape { num_rows: 2_usize, num_cols: 3_usize };

    let mut vec = ArrayTrait::new();
    vec.append(i33 { inner: 3_u32, sign: false });
    vec.append(i33 { inner: 63_u32, sign: true });
    vec.append(i33 { inner: 31_u32, sign: false });

    let mut result = matrix_dot_vec(matrix, shape, vec);

    assert(*result.at(0_usize).inner == 1199_u32, 'result[0] == -1199');
    assert(*result.at(0_usize).sign == true, 'result[0] == -1199');
    assert(*result.at(1_usize).inner == 2829_u32, 'result[1] == 2829');
    assert(*result.at(1_usize).sign == false, 'result[1] == 2829');
}

#[test]
#[available_gas(20000000)]
fn slice_matrix_test() {
    let mut matrix = ArrayTrait::new();
    matrix.append(i33 { inner: 1_u32, sign: false });
    matrix.append(i33 { inner: 2_u32, sign: false });
    matrix.append(i33 { inner: 3_u32, sign: false });
    matrix.append(i33 { inner: 4_u32, sign: false });
    matrix.append(i33 { inner: 5_u32, sign: false });
    matrix.append(i33 { inner: 6_u32, sign: false });
    matrix.append(i33 { inner: 7_u32, sign: false });
    matrix.append(i33 { inner: 8_u32, sign: false });
    matrix.append(i33 { inner: 9_u32, sign: false });

    let shape = MatrixShape { num_rows: 3_usize, num_cols: 3_usize };
    let slicer_shape = MatrixShape { num_rows: 2_usize, num_cols: 2_usize };
    let mut result = slice_matrix(matrix, shape, slicer_shape, 0_usize);

    assert(*result.at(0_usize).inner == 1_u32, 'result[0] == 1');
    assert(*result.at(1_usize).inner == 2_u32, 'result[1] == 2');
    assert(*result.at(2_usize).inner == 4_u32, 'result[2] == 4');
    assert(*result.at(3_usize).inner == 5_u32, 'result[3] == 5');

    let mut matrix = ArrayTrait::new();
    matrix.append(i33 { inner: 1_u32, sign: false });
    matrix.append(i33 { inner: 2_u32, sign: false });
    matrix.append(i33 { inner: 3_u32, sign: false });
    matrix.append(i33 { inner: 4_u32, sign: false });
    matrix.append(i33 { inner: 5_u32, sign: false });
    matrix.append(i33 { inner: 6_u32, sign: false });
    matrix.append(i33 { inner: 7_u32, sign: false });
    matrix.append(i33 { inner: 8_u32, sign: false });
    matrix.append(i33 { inner: 9_u32, sign: false });

    let slicer_shape = MatrixShape { num_rows: 2_usize, num_cols: 3_usize };
    let mut result = slice_matrix(matrix, shape, slicer_shape, 0_usize);

    assert(*result.at(0_usize).inner == 1_u32, 'result[0] == 1');
    assert(*result.at(1_usize).inner == 2_u32, 'result[1] == 2');
    assert(*result.at(2_usize).inner == 3_u32, 'result[2] == 3');
    assert(*result.at(3_usize).inner == 4_u32, 'result[3] == 4');
    assert(*result.at(4_usize).inner == 5_u32, 'result[3] == 5');
    assert(*result.at(5_usize).inner == 6_u32, 'result[3] == 6');

    let mut matrix = ArrayTrait::new();
    matrix.append(i33 { inner: 1_u32, sign: false });
    matrix.append(i33 { inner: 2_u32, sign: false });
    matrix.append(i33 { inner: 3_u32, sign: false });
    matrix.append(i33 { inner: 4_u32, sign: false });
    matrix.append(i33 { inner: 5_u32, sign: false });
    matrix.append(i33 { inner: 6_u32, sign: false });
    matrix.append(i33 { inner: 7_u32, sign: false });
    matrix.append(i33 { inner: 8_u32, sign: false });
    matrix.append(i33 { inner: 9_u32, sign: false });

    let slicer_shape = MatrixShape { num_rows: 3_usize, num_cols: 2_usize };
    let mut result = slice_matrix(matrix, shape, slicer_shape, 0_usize);

    assert(*result.at(0_usize).inner == 1_u32, 'result[0] == 1');
    assert(*result.at(1_usize).inner == 2_u32, 'result[1] == 2');
    assert(*result.at(2_usize).inner == 4_u32, 'result[2] == 4');
    assert(*result.at(3_usize).inner == 5_u32, 'result[3] == 5');
    assert(*result.at(4_usize).inner == 7_u32, 'result[3] == 7');
    assert(*result.at(5_usize).inner == 8_u32, 'result[3] == 8');

    // Test slicing from start index != 0

    let mut matrix = ArrayTrait::new();
    matrix.append(i33 { inner: 1_u32, sign: false });
    matrix.append(i33 { inner: 2_u32, sign: false });
    matrix.append(i33 { inner: 3_u32, sign: false });
    matrix.append(i33 { inner: 4_u32, sign: false });
    matrix.append(i33 { inner: 5_u32, sign: false });
    matrix.append(i33 { inner: 6_u32, sign: false });
    matrix.append(i33 { inner: 7_u32, sign: false });
    matrix.append(i33 { inner: 8_u32, sign: false });
    matrix.append(i33 { inner: 9_u32, sign: false });

    let slicer_shape = MatrixShape { num_rows: 2_usize, num_cols: 2_usize };
    let mut result = slice_matrix(matrix, shape, slicer_shape, 1_usize);

    assert(*result.at(0_usize).inner == 2_u32, 'result[0] == 2');
    assert(*result.at(1_usize).inner == 3_u32, 'result[1] == 3');
    assert(*result.at(2_usize).inner == 5_u32, 'result[2] == 5');
    assert(*result.at(3_usize).inner == 6_u32, 'result[3] == 6');

    let mut matrix = ArrayTrait::new();
    matrix.append(i33 { inner: 1_u32, sign: false });
    matrix.append(i33 { inner: 2_u32, sign: false });
    matrix.append(i33 { inner: 3_u32, sign: false });
    matrix.append(i33 { inner: 4_u32, sign: false });
    matrix.append(i33 { inner: 5_u32, sign: false });
    matrix.append(i33 { inner: 6_u32, sign: false });
    matrix.append(i33 { inner: 7_u32, sign: false });
    matrix.append(i33 { inner: 8_u32, sign: false });
    matrix.append(i33 { inner: 9_u32, sign: false });
    matrix.append(i33 { inner: 8_u32, sign: false });
    matrix.append(i33 { inner: 9_u32, sign: false });
    matrix.append(i33 { inner: 10_u32, sign: false });
    matrix.append(i33 { inner: 11_u32, sign: false });
    matrix.append(i33 { inner: 12_u32, sign: false });
    matrix.append(i33 { inner: 13_u32, sign: false });
    matrix.append(i33 { inner: 14_u32, sign: false });
    matrix.append(i33 { inner: 15_u32, sign: false });
    matrix.append(i33 { inner: 16_u32, sign: false });

    let shape = MatrixShape { num_rows: 4_usize, num_cols: 4_usize };
    let slicer_shape = MatrixShape { num_rows: 2_usize, num_cols: 2_usize };
    let mut result = slice_matrix(matrix, shape, slicer_shape, 0_usize);

    assert(*result.at(0_usize).inner == 1_u32, 'result[0] == 1');
    assert(*result.at(1_usize).inner == 2_u32, 'result[1] == 2');
    assert(*result.at(2_usize).inner == 5_u32, 'result[2] == 5');
    assert(*result.at(3_usize).inner == 6_u32, 'result[3] == 6');
}
