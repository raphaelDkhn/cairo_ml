use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::fixed_point;
use cairo_ml::math::fixed_point::from_i33;


use debug::print_felt;
use traits::Into;

#[test]
#[available_gas(200000000)]
fn from_i33_test() {
    let a = i33 { inner: 42_u32, sign: false };
    let res = from_i33(a, 8_u64).raw_value;
    assert(res.inner == 10752_u32, '42 -> 10752');
}

#[test]
#[available_gas(200000000)]
fn fixed_point_add() {
    let a = from_i33(i33 { inner: 42_u32, sign: false }, 8_u64);
    let b = from_i33(i33 { inner: 5_u32, sign: false }, 8_u64);

    let sum = a + b;
    assert(sum.raw_value.inner == 12032_u32, 'a + b = 12032');
}

#[test]
#[available_gas(200000000)]
fn fixed_point_sub() {
    let a = from_i33(i33 { inner: 42_u32, sign: false }, 8_u64);
    let b = from_i33(i33 { inner: 5_u32, sign: false }, 8_u64);

    let sub = a - b;
    assert(sub.raw_value.inner == 9472_u32, 'a - b = 9472');
}

#[test]
#[available_gas(200000000)]
fn fixed_point_mul() {
    let a = from_i33(i33 { inner: 42_u32, sign: false }, 8_u64);
    let b = from_i33(i33 { inner: 5_u32, sign: false }, 8_u64);

    let mul = a * b;
    assert(mul.raw_value.inner == 53760_u32, 'a * b = 53760');
}


#[test]
#[available_gas(200000000)]
fn fixed_point_div() {
    let a = from_i33(i33 { inner: 42_u32, sign: false }, 8_u64);
    let b = from_i33(i33 { inner: 5_u32, sign: false }, 8_u64);

    let div = a / b;
    assert(div.raw_value.inner == 2150_u32, 'a / b = 2150');
}

