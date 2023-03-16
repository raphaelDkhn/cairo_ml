use array::ArrayTrait;
use cairo_ml::math::signed_integers;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::vector::slice_vec;
use cairo_ml::math::vector::concat_vectors;

impl Arrayi33Drop of Drop::<Array::<i33>>;
impl Arrayi33Copy of Copy::<Array::<i33>>;
impl ArrayMatrixDrop of Drop::<Array::<Matrix>>;
impl ArrayMatrixCopy of Copy::<Array::<Matrix>>;

#[derive(Copy, Drop)]
struct Matrix {
    rows: usize,
    cols: usize,
    data: Array::<i33>,
}

// Creates a new Matrix with the specified dimensions and data.
// # Arguments
// * rows - The number of rows in the matrix.
// * cols - The number of columns in the matrix.
// * data - An Array of i33 integers representing the data in the matrix, stored in row-major order.
// # Returns
// * Matrix - The new matrix created with the specified dimensions and data.
fn matrix_new(rows: usize, cols: usize, data: Array::<i33>) -> Matrix {
    assert(data.len() == rows * cols, 'Matrix not match dimensions');
    Matrix { rows: rows, cols: cols, data: data,  }
}

//=================================================//
//================ MATRIX DOT VECTOR =============//
//=================================================//

// Computes the dot product of a matrix and a vector.
// # Arguments
// * matrix - A reference to a Matrix to be multiplied by the vector.
// * vector - An Array of i33 integers representing the vector to be multiplied by the matrix.
// # Returns
// * Array::<i33> - The result of multiplying the matrix by the vector.
// # Panics
// * If the number of columns in the matrix does not match the length of the input vector.
fn matrix_dot_vec(matrix: @Matrix, vector: Array::<i33>) -> (Array::<i33>) {
    // Initialize variables.
    let mut _vector = vector;
    let mut result_vec = ArrayTrait::new();

    __matrix_dot_vec(matrix, ref _vector, ref result_vec, 0_usize);

    return result_vec;
}

fn __matrix_dot_vec(
    matrix: @Matrix, ref vector: Array::<i33>, ref result: Array::<i33>, row: usize
) {
    // --- Check if out of gas ---
    // TODO: Remove when automatically handled by compiler.
    match gas::get_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    // --- End of the recursion ---
    if row == *matrix.rows {
        return ();
    }

    // --- Compute dot product of the row ---
    let dot = row_dot_vec(matrix, ref vector, row, 0_usize);

    // --- Append the dot product to the result_vec ---
    result.append(dot);

    // --- The process is repeated for the remaining rows in the matrix_shape --- 
    __matrix_dot_vec(matrix, ref vector, ref result, row + 1_usize);
}

fn row_dot_vec(matrix: @Matrix, ref vector: Array::<i33>, row: usize, current_col: usize) -> i33 {
    // --- Check if out of gas ---
    // TODO: Remove when automatically handled by compiler.
    match gas::get_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    // --- End of the recursion ---
    if (current_col == *matrix.cols) {
        return (i33 { inner: 0_u32, sign: false });
    }

    // --- Calculates the product ---
    let ele = *matrix.data.at(*matrix.cols * row + current_col);
    let result = ele * (*vector.at(current_col));

    let acc = row_dot_vec(matrix, ref vector, row, current_col + 1_usize);

    // --- Returns the sum of the current product with the previous ones ---
    return acc + result;
}

//=================================================//
//=================== SLICE MATRIX ================//
//=================================================//

// Slices a Matrix to specified dimensions.
// # Arguments
// * matrix - A reference to the Matrix to be sliced.
// * slicer - A tuple of two usize values representing the number of rows and columns to slice.
// * start_index - The index of the starting element of the slice in the row-major order.
// # Returns
// * Matrix - The new Matrix created by slicing the original Matrix with the specified dimensions.
fn slice_matrix(matrix: @Matrix, slicer: (usize, usize), start_index: usize) -> Matrix {
    // Initialize variables.
    let (slicer_rows, slicer_cols) = slicer;
    let start_row = start_index / *matrix.cols;
    let start_col = start_index % *matrix.cols;
    let end_row = start_row + slicer_rows;
    let end_col = start_col + slicer_cols;

    let data = __slice_matrix(matrix, start_row, start_col, end_row, end_col);

    return matrix_new(slicer_rows, slicer_cols, data);
}

fn __slice_matrix(
    matrix: @Matrix, start_row: usize, start_col: usize, end_row: usize, end_col: usize
) -> Array::<i33> {
    // --- Check if out of gas ---
    // TODO: Remove when automatically handled by compiler.
    match gas::get_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    let row_start = start_row * *matrix.cols;
    let row_end = row_start + *matrix.cols;

    // --- End of the recursion ---
    if (end_row == start_row
        + 1_usize) {
            return slice_vec(matrix.data, row_start + start_col, row_start + end_col);
        }

    let _submatrix = __slice_matrix(matrix, start_row + 1_usize, start_col, end_row, end_col);
    let submatrix = concat_vectors(
        slice_vec(matrix.data, row_start + start_col, row_start + end_col), _submatrix
    );

    return submatrix;
}
