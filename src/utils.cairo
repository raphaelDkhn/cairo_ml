use traits::Into;
use traits::TryInto;
use option::OptionTrait;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::signed_integers::i65;
use cairo_ml::math::signed_integers::i129;

/// Conversion from `u32` to `u64`.
fn u32_to_u64(a: u32) -> u64 {
    let felt = a.into();
    felt.try_into().unwrap()
}

/// Unsafe conversion from `u64` to `u32`.
fn u64_to_u32(a: u64) -> u32 {
    let felt = a.into();
    felt.try_into().unwrap()
}

/// Conversion from `u64` to `u128`.
fn u64_to_u128(a: u64) -> u128 {
    let felt = a.into();
    felt.try_into().unwrap()
}

/// Unsafe conversion from `u128` to `u64`.
fn u128_to_u64(a: u128) -> u64 {
    let felt = a.into();
    felt.try_into().unwrap()
}

/// Unsafe conversion from `i65` to `i33`.
fn i65_to_i33(a: i65) -> i33 {
    let inner = u64_to_u32(a.inner);
    return i33 { inner: inner, sign: a.sign };
}

/// Conversion from `i33` to `i65`.
fn i33_to_i65(a: i33) -> i65 {
    let inner = u32_to_u64(a.inner);
    return i65 { inner: inner, sign: a.sign };
}

/// Unsafe conversion from `i129` to `i65`.
fn i129_to_i65(a: i129) -> i65 {
    let inner = u128_to_u64(a.inner);
    return i65 { inner: inner, sign: a.sign };
}

fn max_u64(a: u64, b: u64) -> u64 {
    if a > b {
        return a;
    } else {
        return b;
    }
}

fn min_u64(a: u64, b: u64) -> u64 {
    if a < b {
        return a;
    } else {
        return b;
    }
}

fn max_u128(a: u128, b: u128) -> u128 {
    if a > b {
        return a;
    } else {
        return b;
    }
}

fn min_u128(a: u128, b: u128) -> u128 {
    if a < b {
        return a;
    } else {
        return b;
    }
}



