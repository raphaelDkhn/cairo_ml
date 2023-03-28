use array::ArrayTrait;
use cairo_ml::math::signed_integers::i33;

fn fc2_bias() -> Array::<i33> {

    let mut bias = ArrayTrait::new();
    bias.append(i33 { inner: 107_u32, sign: false });
    bias.append(i33 { inner: 127_u32, sign: false });
    bias.append(i33 { inner: 18_u32, sign: true });
    bias.append(i33 { inner: 69_u32, sign: false });
    bias.append(i33 { inner: 7_u32, sign: false });
    bias.append(i33 { inner: 38_u32, sign: false });
    bias.append(i33 { inner: 5_u32, sign: false });
    bias.append(i33 { inner: 18_u32, sign: true });
    bias.append(i33 { inner: 83_u32, sign: false });
    bias.append(i33 { inner: 73_u32, sign: false });

    return bias;
}
