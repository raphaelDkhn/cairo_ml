use array::ArrayTrait;
use cairo_ml::math::signed_integers;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::vector::slice_vec;
use cairo_ml::math::vector::concat_vectors;

impl Arrayi33Drop of Drop::<Array::<i33>>;

#[derive(Drop)]
struct Matrix {
    rows: usize,
    cols: usize,
    data: Array::<i33>,
}

fn matrix_new(rows: usize, cols: usize, data: Array::<i33>) -> Matrix {
    Matrix { rows: rows, cols: cols, data: data,  }
}

//=================================================//
//================ MATRIX DOT VECTORS =============//
//=================================================//

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

fn slice_matrix(matrix: @Matrix, slicer: (usize, usize), start_index: usize) -> Matrix {
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
