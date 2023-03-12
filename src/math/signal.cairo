// use array::ArrayTrait;
// use cairo_ml::math::matrix::MatrixShape;
// use cairo_ml::math::matrix::matrix_dot_vec;


// //=================================================//
// //================ CROSS CORELATION ===============//
// //=================================================//

// fn cross_corelation_2d(
//     input_data: Array::<i33>,
//     input_shape: MatrixShape,
//     kernel: Array::<i33>,
//     kernel_shape: MatrixShape
// ) {
//     // Initialize variables.
//     let mut _input_data = input_data;
//     let mut _input_shape = input_shape;
//     let mut _kernel = kernel;
//     let mut _kernel_shape = kernel_shape;
//     let mut output = ArrayTrait::new();

//     __cross_corelation_2d(
//         ref _input_data, ref _input_shape, ref _kernel, ref _kernel_shape, ref output, 0_usize
//     );
// }

// fn __cross_corelation_2d(
//     ref input_data: Array::<i33>,
//     ref input_shape: MatrixShape,
//     ref kernel: Array::<i33>,
//     ref kernel_shape: MatrixShape,
//     ref output: Array::<i33>,
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
    
//     // --- End of the recursion ---
//     if n == kernel.len(){
//         return();
//     }

//     // --- Compute dot product of the row ---

//     let res = matrix_dot_vec();
 


// }
