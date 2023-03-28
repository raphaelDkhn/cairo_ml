use array::ArrayTrait;
use cairo_ml::math::signed_integers::i33;

fn conv1_bias() -> Array::<i33> {

    let mut bias = ArrayTrait::new();
    bias.append(i33 { inner: 15_u32, sign: true });
    bias.append(i33 { inner: 54_u32, sign: true });
    bias.append(i33 { inner: 10_u32, sign: true });
    bias.append(i33 { inner: 31_u32, sign: true });
    bias.append(i33 { inner: 37_u32, sign: true });
    bias.append(i33 { inner: 7_u32, sign: false });
    bias.append(i33 { inner: 74_u32, sign: true });
    bias.append(i33 { inner: 84_u32, sign: false });
    bias.append(i33 { inner: 127_u32, sign: true });
    bias.append(i33 { inner: 15_u32, sign: true });

    return bias;
}
