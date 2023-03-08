use array::ArrayTrait;

use cairo_ml::math::matrix::matrix_dot_vec;
use cairo_ml::math::matrix::MatrixShape;
use cairo_ml::math::int32::i32;

impl Arrayi32Drop of Drop::<Array::<i32>>;

#[test]
#[available_gas(2000000)]
fn dot_test() {
    // Test with random numbers

    let mut matrix = ArrayTrait::new();
    matrix.append(i32 { inner: 87_u32, sign: false });
    matrix.append(i32 { inner: 28_u32, sign: true });
    matrix.append(i32 { inner: 104_u32, sign: true });
    matrix.append(i32 { inner: 42_u32, sign: false });
    matrix.append(i32 { inner: 6_u32, sign: true });
    matrix.append(i32 { inner: 75_u32, sign: false });

    let mut shape = MatrixShape { num_rows: 2_usize, num_cols: 3_usize };

    let mut vec = ArrayTrait::new();
    vec.append(i32 { inner: 3_u32, sign: false });
    vec.append(i32 { inner: 63_u32, sign: true });
    vec.append(i32 { inner: 31_u32, sign: false });

    let mut result = matrix_dot_vec(matrix, shape, vec);

    assert(*result.at(0_usize).inner == 1199_u32, 'result[0] == -1199');
    assert(*result.at(0_usize).sign == true, 'result[0] == -1199');
    assert(*result.at(1_usize).inner == 2829_u32, 'result[1] == 2829');
    assert(*result.at(1_usize).sign == false, 'result[1] == 2829');
}
