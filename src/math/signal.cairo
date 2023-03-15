// use array::ArrayTrait;
// use cairo_ml::math::int33::i33;
// use cairo_ml::math::matrix::MatrixShape;
// use cairo_ml::math::matrix::__slice_matrix;
// use cairo_ml::math::matrix::slice_matrix;
// use cairo_ml::math::vector::__vec_dot_vec;

// use traits::Into;
// use debug::print_felt;


// impl Arrayi33Drop of Drop::<Array::<i33>>;

// // //=================================================//
// // //================ CROSS CORELATION ===============//
// // //=================================================//

// fn valid_correlate_2d(
//     matrix: Array::<i33>, matrix_shape: MatrixShape, kernel: Array::<i33>, kernel_shape: MatrixShape
// ) -> Array::<i33> {
//     // Initialize variables.
//     let mut _matrix = matrix;
//     let mut _kernel = kernel;
//     let mut result = ArrayTrait::new();

//     let row_ratio = matrix_shape.num_rows / kernel_shape.num_rows;
//     let col_ratio = matrix_shape.num_cols / kernel_shape.num_cols;

//     __valid_correlate_2d(
//         matrix_shape,
//         kernel_shape,
//         row_ratio,
//         col_ratio,
//         ref _matrix,
//         ref _kernel,
//         ref result,
//         0_usize, // n
//     );

//     // assert(result.len() == _matrix.len() - _kernel.len() + 1_usize, 'Y = I - K + 1');

//     return result;
// }

// fn __valid_correlate_2d(
//     matrix_shape: MatrixShape,
//     kernel_shape: MatrixShape,
//     row_ratio: usize,
//     col_ratio: usize,
//     ref matrix: Array::<i33>,
//     ref kernel: Array::<i33>,
//     ref result: Array::<i33>,
//     n: usize
// ) {
//     // --- Check if out of gas ---
//     // TODO: Remove when automatically handled by compiler.
//     match gas::get_gas() {
//         Option::Some(_) => {},
//         Option::None(_) => {
//             let mut data = array_new::<felt>();
//             array_append::<felt>(ref data, 'OOG');
//             panic(data);
//         },
//     }

//     // if (n >=???) {
//     //     return ();
//     // }

//     // --- Slice Matrix ---
//     let mut sliced_matrix = ArrayTrait::new();
//     __slice_matrix(
//         0_usize, // current_row
//         0_usize, // current_col
//         matrix_shape,
//         kernel_shape,
//         row_ratio,
//         col_ratio,
//         n,
//         ref matrix,
//         ref sliced_matrix
//     );

//     // --- Dot product ---
//     let dot = __vec_dot_vec(ref sliced_matrix, ref kernel, 0_usize);

//     // --- Append the dot product to the result array ---
//     result.append(dot);

//     let col_index = n % matrix_shape.num_cols;
//     if (col_index == matrix_shape.num_cols
//         - kernel_shape.num_cols) {
//             __valid_correlate_2d(
//                 matrix_shape,
//                 kernel_shape,
//                 row_ratio,
//                 col_ratio,
//                 ref matrix,
//                 ref kernel,
//                 ref result,
//                 n + kernel_shape.num_cols
//             );
//         } else {
//             __valid_correlate_2d(
//                 matrix_shape,
//                 kernel_shape,
//                 row_ratio,
//                 col_ratio,
//                 ref matrix,
//                 ref kernel,
//                 ref result,
//                 n + 1_usize
//             );
//         }
// }
