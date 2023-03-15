use array::ArrayTrait;
use cairo_ml::math::int33;
use cairo_ml::math::int33::i33;
use cairo_ml::math::vector::slice_vec;
use cairo_ml::math::vector::concat_vectors;

impl Arrayi33Drop of Drop::<Array::<i33>>;

//=================================================//
//================ MATRIX DOT VECTORS =============//
//=================================================//

#[derive(Copy, Drop)]
struct MatrixShape {
    num_rows: usize,
    num_cols: usize,
}

fn matrix_dot_vec(
    matrix_data: Array::<i33>, matrix_shape: MatrixShape, vector: Array::<i33>
) -> (Array::<i33>) {
    // Initialize variables.
    let mut _matrix_data = matrix_data;
    let mut _matrix_shape = matrix_shape;
    let mut _vector = vector;
    let mut result_vec = ArrayTrait::new();

    __matrix_dot_vec(ref _matrix_data, ref _matrix_shape, ref _vector, ref result_vec, 0_usize);

    return result_vec;
}

fn __matrix_dot_vec(
    ref matrix_data: Array::<i33>,
    ref matrix_shape: MatrixShape,
    ref vector: Array::<i33>,
    ref result_vec: Array::<i33>,
    row: usize
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
    if row == matrix_shape.num_rows {
        return ();
    }

    // --- Compute dot product of the row ---
    let dot = row_dot_vec(ref matrix_data, ref matrix_shape, ref vector, row, 0_usize);

    // --- Append the dot product to the result_vec ---
    result_vec.append(dot);

    // --- The process is repeated for the remaining rows in the matrix_shape --- 
    __matrix_dot_vec(ref matrix_data, ref matrix_shape, ref vector, ref result_vec, row + 1_usize);
}

fn row_dot_vec(
    ref matrix: Array::<i33>,
    ref matrix_shape: MatrixShape,
    ref vector: Array::<i33>,
    row: usize,
    current_col: usize
) -> i33 {
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
    if (current_col == matrix_shape.num_cols) {
        return (i33 { inner: 0_u32, sign: false });
    }

    // --- Calculates the product ---
    let ele = *matrix.at(matrix_shape.num_cols * row + current_col);
    let result = ele * (*vector.at(current_col));

    let acc = row_dot_vec(ref matrix, ref matrix_shape, ref vector, row, current_col + 1_usize);

    // --- Returns the sum of the current product with the previous ones ---
    return acc + result;
}
//=================================================//
//=================== SLICE MATRIX ================//
//=================================================//

fn slice_matrix(
    matrix: Array::<i33>, matrix_shape: MatrixShape, slicer_shape: MatrixShape, start_index: usize, 
) -> Array::<i33> {

    let rows = matrix_shape.num_rows;
    let cols = matrix_shape.num_cols;
    let start_row = start_index / cols;
    let start_col = start_index % cols;
    let end_row = start_row + slicer_shape.num_rows;
    let end_col = start_col + slicer_shape.num_cols;
    let mut _matrix = matrix;

    return __slice_matrix(ref _matrix, rows, cols, start_row, start_col, end_row, end_col);
}

fn __slice_matrix(
    ref matrix: Array::<i33>,
    rows: usize,
    cols: usize,
    start_row: usize,
    start_col: usize,
    end_row: usize,
    end_col: usize
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

    let row_start = start_row * cols;
    let row_end = row_start + cols;

    if (end_row == start_row
        + 1_usize) {
            return slice_vec(ref matrix, row_start + start_col, row_start + end_col);
        }

    let _submatrix = __slice_matrix(
        ref matrix, rows, cols, start_row + 1_usize, start_col, end_row, end_col
    );

    let submatrix = concat_vectors(
        slice_vec(ref matrix, row_start + start_col, row_start + end_col), _submatrix
    );

    return submatrix;
}

