use array::ArrayTrait;
use cairo_ml::math::signed_integers;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::matrix::Matrix;
use cairo_ml::math::matrix::matrix_new;

//  ReLu.
// # Arguments
// * matrix - a reference to the matrix.
// # Returns
// * a matrix representing the result of the ReLu
fn relu(matrix: @Matrix) -> Matrix {
    // Initialize variables.
    let mut arr = ArrayTrait::new();

    __relu(matrix, ref arr, 0_usize);

    return matrix_new(*matrix.rows, *matrix.cols, arr);
}

fn __relu(matrix: @Matrix, ref result: Array::<i33>, n: usize) {
    // TODO: Remove when automatically handled by compiler.
    match try_fetch_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    if (n == matrix.data.len()) {
        return ();
    }

    let zero = i33 { inner: 0_u32, sign: false };

    if (*matrix.data.at(
        n
    ) <= zero) {
        result.append(zero);
    } else {
        result.append(*matrix.data.at(n));
    }

    __relu(matrix, ref result, n + 1_usize);
}

