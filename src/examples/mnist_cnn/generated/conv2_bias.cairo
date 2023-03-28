use array::ArrayTrait;
use cairo_ml::math::signed_integers::i33;

fn conv2_bias() -> Array::<i33> {

    let mut bias = ArrayTrait::new();
    bias.append(i33 { inner: 63_u32, sign: true });
    bias.append(i33 { inner: 78_u32, sign: true });
    bias.append(i33 { inner: 104_u32, sign: true });
    bias.append(i33 { inner: 42_u32, sign: true });
    bias.append(i33 { inner: 29_u32, sign: true });
    bias.append(i33 { inner: 33_u32, sign: true });
    bias.append(i33 { inner: 4_u32, sign: true });
    bias.append(i33 { inner: 127_u32, sign: false });
    bias.append(i33 { inner: 73_u32, sign: false });
    bias.append(i33 { inner: 58_u32, sign: false });
    bias.append(i33 { inner: 45_u32, sign: false });
    bias.append(i33 { inner: 14_u32, sign: false });
    bias.append(i33 { inner: 32_u32, sign: false });
    bias.append(i33 { inner: 112_u32, sign: false });
    bias.append(i33 { inner: 43_u32, sign: true });
    bias.append(i33 { inner: 84_u32, sign: false });
    bias.append(i33 { inner: 6_u32, sign: true });
    bias.append(i33 { inner: 72_u32, sign: true });
    bias.append(i33 { inner: 87_u32, sign: true });
    bias.append(i33 { inner: 60_u32, sign: true });

    return bias;
}
