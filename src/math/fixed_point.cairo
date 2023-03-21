// Fixed Point Q16.16

use cairo_ml::math::signed_integers;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::signed_integers::i33_left_shift;
use cairo_ml::math::signed_integers::i33_right_shift;

use debug::print_felt;
use traits::Into;

#[derive(Copy, Drop)]
struct FixedPoint {
    raw_value: i33,
    fractional_bits: u64
}


fn from_i33(value: i33, fractional_bits: u64) -> FixedPoint {
    let scale_factor = i33_left_shift(i33 { inner: 1_u32, sign: false }, fractional_bits);
    let raw_value = value * scale_factor;
    return FixedPoint { raw_value: raw_value, fractional_bits: fractional_bits };
}


// Implements the Add trait for FixedPoint.
impl FixedPointAdd of Add::<FixedPoint> {
    fn add(a: FixedPoint, b: FixedPoint) -> FixedPoint {
        __add__(a, b)
    }
}

// Implements the AddEq trait for FixedPoint.
impl FixedPointAddEq of AddEq::<FixedPoint> {
    #[inline(always)]
    fn add_eq(ref self: FixedPoint, other: FixedPoint) {
        self = Add::add(self, other);
    }
}

fn __add__(a: FixedPoint, b: FixedPoint) -> FixedPoint {
    assert(a.fractional_bits == b.fractional_bits, 'fractional bits do not match');
    let sum = a.raw_value + b.raw_value;
    FixedPoint { raw_value: sum, fractional_bits: a.fractional_bits }
}

// Implements the Sub trait for FixedPoint.
impl FixedPointSub of Sub::<FixedPoint> {
    fn sub(a: FixedPoint, b: FixedPoint) -> FixedPoint {
        __sub__(a, b)
    }
}

// Implements the SubEq trait for FixedPoint.
impl FixedPointSubEq of SubEq::<FixedPoint> {
    #[inline(always)]
    fn sub_eq(ref self: FixedPoint, other: FixedPoint) {
        self = Sub::sub(self, other);
    }
}

fn __sub__(a: FixedPoint, b: FixedPoint) -> FixedPoint {
    assert(a.fractional_bits == b.fractional_bits, 'fractional bits do not match');
    let sub = a.raw_value - b.raw_value;
    FixedPoint { raw_value: sub, fractional_bits: a.fractional_bits }
}

// Implements the Mul trait for FixedPoint.
impl FixedPointMul of Mul::<FixedPoint> {
    fn mul(a: FixedPoint, b: FixedPoint) -> FixedPoint {
        __mul__(a, b)
    }
}

// Implements the MulEq trait for FixedPoint.
impl FixedPointMulEq of MulEq::<FixedPoint> {
    #[inline(always)]
    fn mul_eq(ref self: FixedPoint, other: FixedPoint) {
        self = Mul::mul(self, other);
    }
}

fn __mul__(a: FixedPoint, b: FixedPoint) -> FixedPoint {
    assert(a.fractional_bits == b.fractional_bits, 'fractional bits do not match');
    let mul = i33_right_shift(a.raw_value * b.raw_value, a.fractional_bits);
    FixedPoint { raw_value: mul, fractional_bits: a.fractional_bits }
}

// Implements the Div trait for FixedPoint.
impl FixedPointDiv of Div::<FixedPoint> {
    fn div(a: FixedPoint, b: FixedPoint) -> FixedPoint {
        __div__(a, b)
    }
}

// Implements the DivEq trait for FixedPoint.
impl FixedPointDivEq of DivEq::<FixedPoint> {
    #[inline(always)]
    fn div_eq(ref self: FixedPoint, other: FixedPoint) {
        self = Div::div(self, other);
    }
}

fn __div__(a: FixedPoint, b: FixedPoint) -> FixedPoint {
    assert(a.fractional_bits == b.fractional_bits, 'fractional bits do not match');

    let div = i33_left_shift(a.raw_value, a.fractional_bits) / b.raw_value;
    FixedPoint { raw_value: div, fractional_bits: a.fractional_bits }
}
