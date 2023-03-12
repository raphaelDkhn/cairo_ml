use cairo_ml::math::int33::i33;
use cairo_ml::math::matrix::MatrixShape;

// //=================================================//
// //================ CROSS CORELATION ===============//
// //=================================================//

// For each sliding slice the matrix with kernel 
// And perform dot product on the new sliced matrix and the kernel 
// Add the result to the output matrix. 
// The shape of the output should be Y = I - K + 1

// fn valid_correlate_2d(
//     matrix: Array::<i33>, 
//     matrix_shape: MatrixShape, 
//     kernel: Array::<i33>, 
//     kernel_shape: MatrixShape
// ) -> Array::<i33> {

// }
