use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::matrix::Matrix;

use cairo_ml::layers::conv2d::conv2d;
use cairo_ml::layers::linear::linear;
use cairo_ml::layers::max_pool_2d::batch_max_pool_2d;
use cairo_ml::activations::relu::relu;
use cairo_ml::activations::softmax::softmax;
use cairo_ml::activations::relu::batch_relu;
use cairo_ml::fixed_point::core::FixedType;

use cairo_ml::examples::mnist_cnn::generated::conv1_weight::conv1_weight;
use cairo_ml::examples::mnist_cnn::generated::conv1_bias::conv1_bias;
use cairo_ml::examples::mnist_cnn::generated::conv2_weight::conv2_weight;
use cairo_ml::examples::mnist_cnn::generated::conv2_bias::conv2_bias;
use cairo_ml::examples::mnist_cnn::generated::fc1_weight::fc1_weight;
use cairo_ml::examples::mnist_cnn::generated::fc1_bias::fc1_bias;
use cairo_ml::examples::mnist_cnn::generated::fc2_weight::fc2_weight;
use cairo_ml::examples::mnist_cnn::generated::fc2_bias::fc2_bias;

impl Arrayi33Drop of Drop::<Array::<i33>>;
impl ArrayMatrixDrop of Drop::<Array::<Matrix>>;
impl ArrayOfArrayMatrixDrop of Drop::<Array::<Array::<Matrix>>>;


fn conv1(inputs: @Array::<Matrix>) -> Array::<Matrix> {
    let weight = conv1_weight();
    let bias = conv1_bias();
    let x = conv2d(inputs, @weight, @bias);
    let x = batch_max_pool_2d(@x, (2_usize, 2_usize));
    let x = batch_relu(@x);
    x
}

fn conv2(inputs: @Array::<Matrix>) -> Array::<Matrix> {
    let weight = conv2_weight();
    let bias = conv2_bias();
    let x = conv2d(inputs, @weight, @bias);
    let x = batch_max_pool_2d(@x, (2_usize, 2_usize));
    let x = batch_relu(@x);
    x
}

fn fc1(input: Array::<i33>) -> Array::<i33> {
    let weight = fc1_weight();
    let bias = fc1_bias();
    let x = linear(@input, @weight, @bias);
    let x = relu(@x);
    x
}

fn fc2(input: Array::<i33>) -> Array::<FixedType> {
    let weight = fc2_weight();
    let bias = fc2_bias();
    let x = linear(@input, @weight, @bias);
    let x = relu(@x);
    let x = softmax(@x);
    x
}

