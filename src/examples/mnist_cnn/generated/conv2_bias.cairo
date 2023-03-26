use array::ArrayTrait;
use cairo_ml::math::signed_integers::i33;

fn conv2_bias() -> Array::<i33> {

    let mut bias = ArrayTrait::new();
    bias.append(i33 { inner: 82_u32, sign: true });
    bias.append(i33 { inner: 21_u32, sign: false });
    bias.append(i33 { inner: 14_u32, sign: true });
    bias.append(i33 { inner: 92_u32, sign: true });
    bias.append(i33 { inner: 49_u32, sign: true });
    bias.append(i33 { inner: 100_u32, sign: true });
    bias.append(i33 { inner: 8_u32, sign: true });
    bias.append(i33 { inner: 12_u32, sign: true });
    bias.append(i33 { inner: 33_u32, sign: false });
    bias.append(i33 { inner: 29_u32, sign: true });
    bias.append(i33 { inner: 127_u32, sign: true });
    bias.append(i33 { inner: 68_u32, sign: false });
    bias.append(i33 { inner: 12_u32, sign: true });
    bias.append(i33 { inner: 38_u32, sign: true });
    bias.append(i33 { inner: 72_u32, sign: false });
    bias.append(i33 { inner: 33_u32, sign: false });
    bias.append(i33 { inner: 31_u32, sign: false });
    bias.append(i33 { inner: 80_u32, sign: true });
    bias.append(i33 { inner: 17_u32, sign: true });
    bias.append(i33 { inner: 48_u32, sign: true });

    return bias;
}
