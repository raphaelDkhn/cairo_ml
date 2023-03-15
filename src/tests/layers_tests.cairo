use array::ArrayTrait;
use cairo_ml::layers::linear;
use cairo_ml::math::matrix::matrix_new;
use cairo_ml::math::signed_integers::i33;

#[test]
#[available_gas(2000000)]
fn linear_layer_test() {
    let mut inputs = ArrayTrait::new();
    inputs.append(i33 { inner: 71_u32, sign: true });
    inputs.append(i33 { inner: 38_u32, sign: false });
    inputs.append(i33 { inner: 62_u32, sign: false });

    let mut weights_data = ArrayTrait::new();
    weights_data.append(i33 { inner: 8_u32, sign: true });
    weights_data.append(i33 { inner: 64_u32, sign: false });
    weights_data.append(i33 { inner: 40_u32, sign: false });
    weights_data.append(i33 { inner: 33_u32, sign: true });
    weights_data.append(i33 { inner: 34_u32, sign: true });
    weights_data.append(i33 { inner: 20_u32, sign: true });

    let mut weights = matrix_new(2_usize, 3_usize, weights_data);

    let mut bias = ArrayTrait::new();
    bias.append(i33 { inner: 61_u32, sign: false });
    bias.append(i33 { inner: 71_u32, sign: true });

    let mut result = linear::linear(inputs, @weights, bias);

    assert(*result.at(0_usize).inner == 127_u32, 'result[0] == 127');
    assert(*result.at(1_usize).inner == 6_u32, 'result[1] == 6');
}

