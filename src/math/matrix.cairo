use array::ArrayTrait;
use cairo_ml::math::int32;
use cairo_ml::math::int32::i32;

impl Arrayi32Drop of Drop::<Array::<i32>>;

//=================================================//
//================ MATRIX DOT VECTORS =============//
//=================================================//

#[derive(Copy, Drop)]
struct MatrixShape {
    num_rows: usize,
    num_cols: usize,
}

fn matrix_dot_vec(
    matrix_data: Array::<i32>, matrix_shape: MatrixShape, vector: Array::<i32>
) -> (Array::<i32>) {
    // Initialize variables.
    let mut _matrix_data = matrix_data;
    let mut _matrix_shape = matrix_shape;
    let mut _vector = vector;
    let mut result_vec = ArrayTrait::new();

    __matrix_dot_vec(ref _matrix_data, ref _matrix_shape, ref _vector, ref result_vec, 0_usize);

    return result_vec;
}

fn __matrix_dot_vec(
    ref matrix_data: Array::<i32>,
    ref matrix_shape: MatrixShape,
    ref vector: Array::<i32>,
    ref result_vec: Array::<i32>,
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
    ref matrix: Array::<i32>,
    ref matrix_shape: MatrixShape,
    ref vector: Array::<i32>,
    row: usize,
    current_col: usize
) -> i32 {
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
        return (i32 { inner: 0_u32, sign: true });
    }

    // --- Calculates the product ---
    let ele = *matrix.at(matrix_shape.num_cols * row + current_col);
    let result = ele * (*vector.at(current_col));

    let acc = row_dot_vec(ref matrix, ref matrix_shape, ref vector, row, current_col + 1_usize);

    // --- Returns the sum of the current product with the previous ones ---
    return acc + result;
}
