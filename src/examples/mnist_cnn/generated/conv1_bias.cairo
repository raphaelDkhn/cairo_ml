use array::ArrayTrait;
use cairo_ml::math::signed_integers::i33;

fn conv1_bias() -> Array::<i33> {

    let mut bias = ArrayTrait::new();
    bias.append(i33 { inner: 74_u32, sign: true });
    bias.append(i33 { inner: 127_u32, sign: false });
    bias.append(i33 { inner: 89_u32, sign: false });
    bias.append(i33 { inner: 109_u32, sign: true });
    bias.append(i33 { inner: 76_u32, sign: true });
    bias.append(i33 { inner: 12_u32, sign: true });
    bias.append(i33 { inner: 22_u32, sign: true });
    bias.append(i33 { inner: 1_u32, sign: false });
    bias.append(i33 { inner: 0_u32, sign: false });
    bias.append(i33 { inner: 77_u32, sign: true });

    return bias;
}
