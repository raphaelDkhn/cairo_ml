use array::ArrayTrait;
use cairo_ml::math::int33;
use cairo_ml::math::int33::i33;

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
    matrix_shape: MatrixShape, slicer_shape: MatrixShape, matrix_data: Array::<i33>
) -> Array::<i33> {
    assert(
        matrix_shape.num_rows > slicer_shape.num_rows | matrix_shape.num_cols > slicer_shape.num_cols,
        'out of matrix bounds'
    );

    // Initialize variables.
    let mut _matrix_data = matrix_data;
    let mut result = ArrayTrait::new();

    let row_ratio = matrix_shape.num_rows / slicer_shape.num_rows;
    let col_ratio = matrix_shape.num_cols / slicer_shape.num_cols;

    __slice_matrix(
        0_usize, // current_row
        0_usize, // current_col
        matrix_shape,
        slicer_shape,
        row_ratio,
        col_ratio,
        ref _matrix_data,
        ref result
    );

    return result;
}

fn __slice_matrix(
    current_row: usize,
    current_col: usize,
    matrix_shape: MatrixShape,
    slicer_shape: MatrixShape,
    row_ratio: usize,
    col_ratio: usize,
    ref matrix_data: Array::<i33>,
    ref result: Array::<i33>
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
    if (current_row == slicer_shape.num_rows) {
        return ();
    }

    // --- If we reach the limit of columns --- 
    if (current_col == slicer_shape.num_cols) {
        // --- The process is repeated for the remaining rows --- 
        __slice_matrix(
            current_row + 1_usize, // current_row
            0_usize, // current_col
            matrix_shape,
            slicer_shape,
            row_ratio,
            col_ratio,
            ref matrix_data,
            ref result
        );
    } else {
        // --- Find the index ---
        let index = (current_row * row_ratio * matrix_shape.num_cols) + (current_col * col_ratio);

        // --- Append the value at the index to the new matrix ---
        result.append(*matrix_data.at(index));

        // --- The process is repeated for the remaining cols --- 
        __slice_matrix(
            current_row, // current_row
            current_col + 1_usize, // current_col
            matrix_shape,
            slicer_shape,
            row_ratio,
            col_ratio,
            ref matrix_data,
            ref result
        );
    }
}

