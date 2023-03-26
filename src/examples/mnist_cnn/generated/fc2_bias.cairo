use array::ArrayTrait;
use cairo_ml::math::signed_integers::i33;

fn fc2_bias() -> Array::<i33> {

    let mut bias = ArrayTrait::new();
    bias.append(i33 { inner: 72_u32, sign: false });
    bias.append(i33 { inner: 49_u32, sign: false });
    bias.append(i33 { inner: 14_u32, sign: true });
    bias.append(i33 { inner: 39_u32, sign: false });
    bias.append(i33 { inner: 11_u32, sign: true });
    bias.append(i33 { inner: 45_u32, sign: false });
    bias.append(i33 { inner: 2_u32, sign: true });
    bias.append(i33 { inner: 20_u32, sign: false });
    bias.append(i33 { inner: 127_u32, sign: false });
    bias.append(i33 { inner: 4_u32, sign: true });

    return bias;
}
