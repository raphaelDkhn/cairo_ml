use option::OptionTrait;
use traits::Into;

use cairo_ml::fixed_point::core::ONE;
use cairo_ml::fixed_point::core::ONE_u128;
use cairo_ml::fixed_point::core::HALF;
use cairo_ml::fixed_point::core::_felt_abs;
use cairo_ml::fixed_point::core::_felt_sign;
use cairo_ml::fixed_point::core::Fixed;
use cairo_ml::fixed_point::core::FixedInto;
use cairo_ml::fixed_point::core::FixedPartialEq;
use cairo_ml::fixed_point::core::FixedPartialOrd;
use cairo_ml::fixed_point::core::FixedAdd;
use cairo_ml::fixed_point::core::FixedAddEq;
use cairo_ml::fixed_point::core::FixedSub;
use cairo_ml::fixed_point::core::FixedSubEq;
use cairo_ml::fixed_point::core::FixedMul;
use cairo_ml::fixed_point::core::FixedMulEq;
use cairo_ml::fixed_point::core::FixedDiv;

#[test]
fn test_into() {
    let a = Fixed::from_unscaled_felt(5);
    assert(a.into() == 5 * ONE, 'invalid result');
}

#[test]
#[should_panic]
fn test_overflow_large() {
    let too_large = 0x100000000000000000000000000000000;
    Fixed::from_felt(too_large);
}

#[test]
#[should_panic]
fn test_overflow_small() {
    let too_small = -0x100000000000000000000000000000000;
    Fixed::from_felt(too_small);
}

#[test]
fn test_sign() {
    let min = -1809251394333065606848661391547535052811553607665798349986546028067936010240;
    let max = 1809251394333065606848661391547535052811553607665798349986546028067936010240;
    assert(_felt_sign(min) == true, 'invalid result');
    assert(_felt_sign(-1) == true, 'invalid result');
    assert(_felt_sign(0) == false, 'invalid result');
    assert(_felt_sign(1) == false, 'invalid result');
    assert(_felt_sign(max) == false, 'invalid result');
}

#[test]
fn test_abs() {
    assert(_felt_abs(5) == 5, 'abs of pos should be pos');
    assert(_felt_abs(-5) == 5, 'abs of neg should be pos');
    assert(_felt_abs(0) == 0, 'abs of 0 should be 0');
}

#[test]
fn test_ceil() {
    let a = Fixed::from_felt(194615506); // 2.9
    assert(a.ceil().into() == 3 * ONE, 'invalid pos decimal');
}

#[test]
fn test_floor() {
    let a = Fixed::from_felt(194615506); // 2.9
    assert(a.floor().into() == 2 * ONE, 'invalid pos decimal');
}

#[test]
fn test_round() {
    let a = Fixed::from_felt(194615506); // 2.9
    assert(a.round().into() == 3 * ONE, 'invalid pos decimal');
}

#[test]
#[should_panic]
fn test_sqrt_fail() {
    let a = Fixed::from_unscaled_felt(-25);
    a.sqrt();
}

#[test]
fn test_sqrt() {
    let a = Fixed::from_unscaled_felt(0);
    assert(a.sqrt().into() == 0, 'invalid zero root');
}

#[test]
#[available_gas(10000000)]
fn test_pow() {
    let a = Fixed::from_unscaled_felt(3);
    let b = Fixed::from_unscaled_felt(4);
    assert(a.pow(b).into() == 81 * ONE, 'invalid pos base power');
}

#[test]
#[available_gas(10000000)]
fn test_exp() {
    let a = Fixed::from_unscaled_felt(2);

    assert(a.exp().into() == 495871164, 'invalid exp of 2'); // 7.389056317241236
}

#[test]
#[available_gas(10000000)]
fn test_exp2() {
    let a = Fixed::from_unscaled_felt(2);

    assert(a.exp2().into() == 268435428, 'invalid exp2 of 2'); // 3.99999957248 = 4
}

#[test]
#[available_gas(10000000)]
fn test_ln() {
    let a = Fixed::from_unscaled_felt(1);
    assert(a.ln().into() == 0, 'invalid ln of 1');
}

#[test]
#[available_gas(10000000)]
fn test_log2() {
    let a = Fixed::from_unscaled_felt(32);
    assert(a.log2().into() == 335544129, 'invalid log2'); // 4.99999995767848
}

#[test]
#[available_gas(10000000)]
fn test_log10() {
    let a = Fixed::from_unscaled_felt(100);
    assert(a.log10().into() == 134217717, 'invalid log10'); // 1.9999999873985543
}

#[test]
fn test_eq() {
    let a = Fixed::from_unscaled_felt(42);
    let b = Fixed::from_unscaled_felt(42);
    let c = a == b;
    assert(c == true, 'invalid result');
}

#[test]
fn test_ne() {
    let a = Fixed::from_unscaled_felt(42);
    let b = Fixed::from_unscaled_felt(42);
    let c = a != b;
    assert(c == false, 'invalid result');
}

#[test]
fn test_add() {
    let a = Fixed::from_unscaled_felt(1);
    let b = Fixed::from_unscaled_felt(2);
    assert(a + b == Fixed::from_unscaled_felt(3), 'invalid result');
}

#[test]
fn test_add_eq() {
    let mut a = Fixed::from_unscaled_felt(1);
    let b = Fixed::from_unscaled_felt(2);
    a += b;
    assert(a.into() == 3 * ONE, 'invalid result');
}

#[test]
fn test_sub() {
    let a = Fixed::from_unscaled_felt(5);
    let b = Fixed::from_unscaled_felt(2);
    let c = a - b;
    assert(c.into() == 3 * ONE, 'false result invalid');
}

#[test]
fn test_sub_eq() {
    let mut a = Fixed::from_unscaled_felt(5);
    let b = Fixed::from_unscaled_felt(2);
    a -= b;
    assert(a.into() == 3 * ONE, 'invalid result');
}

#[test]
fn test_mul_pos() {
    let a = Fixed::from_unscaled_felt(5);
    let b = Fixed::from_unscaled_felt(2);
    let c = a * b;
    assert(c.into() == 10 * ONE, 'invalid result');
}

#[test]
fn test_mul_neg() {
    let a = Fixed::from_unscaled_felt(5);
    let b = Fixed::from_unscaled_felt(-2);
    let c = a * b;
    assert(c.into() == -10 * ONE, 'true result invalid');
}

#[test]
fn test_mul_eq() {
    let mut a = Fixed::from_unscaled_felt(5);
    let b = Fixed::from_unscaled_felt(-2);
    a *= b;
    assert(a.into() == -10 * ONE, 'invalid result');
}

#[test]
fn test_div() {
    let a = Fixed::from_unscaled_felt(10);
    let b = Fixed::from_felt(194615706); // 2.9
    let c = a / b;
    assert(c.into() == 231409875, 'invalid pos decimal'); // 3.4482758620689653
}

#[test]
fn test_le() {
    let a = Fixed::from_unscaled_felt(1);
    let b = Fixed::from_unscaled_felt(0);
    let c = Fixed::from_unscaled_felt(-1);

    assert(a <= a, 'a <= a');
    assert(a <= b == false, 'a <= b');
    assert(a <= c == false, 'a <= c');

    assert(b <= a, 'b <= a');
    assert(b <= b, 'b <= b');
    assert(b <= c == false, 'b <= c');

    assert(c <= a, 'c <= a');
    assert(c <= b, 'c <= b');
    assert(c <= c, 'c <= c');
}

#[test]
fn test_lt() {
    let a = Fixed::from_unscaled_felt(1);
    let b = Fixed::from_unscaled_felt(0);
    let c = Fixed::from_unscaled_felt(-1);

    assert(a < a == false, 'a < a');
    assert(a < b == false, 'a < b');
    assert(a < c == false, 'a < c');

    assert(b < a, 'b < a');
    assert(b < b == false, 'b < b');
    assert(b < c == false, 'b < c');

    assert(c < a, 'c < a');
    assert(c < b, 'c < b');
    assert(c < c == false, 'c < c');
}

#[test]
fn test_ge() {
    let a = Fixed::from_unscaled_felt(1);
    let b = Fixed::from_unscaled_felt(0);
    let c = Fixed::from_unscaled_felt(-1);

    assert(a >= a, 'a >= a');
    assert(a >= b, 'a >= b');
    assert(a >= c, 'a >= c');

    assert(b >= a == false, 'b >= a');
    assert(b >= b, 'b >= b');
    assert(b >= c, 'b >= c');

    assert(c >= a == false, 'c >= a');
    assert(c >= b == false, 'c >= b');
    assert(c >= c, 'c >= c');
}

#[test]
fn test_gt() {
    let a = Fixed::from_unscaled_felt(1);
    let b = Fixed::from_unscaled_felt(0);
    let c = Fixed::from_unscaled_felt(-1);

    assert(a > a == false, 'a > a');
    assert(a > b, 'a > b');
    assert(a > c, 'a > c');

    assert(b > a == false, 'b > a');
    assert(b > b == false, 'b > b');
    assert(b > c, 'b > c');

    assert(c > a == false, 'c > a');
    assert(c > b == false, 'c > b');
    assert(c > c == false, 'c > c');
}
