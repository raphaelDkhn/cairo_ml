// ====================== INT 33 ======================
use cairo_ml::math::signed_integers;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::signed_integers::div_rem;
use cairo_ml::math::signed_integers::i33_power;
use cairo_ml::math::signed_integers::i33_twos_compl;
use cairo_ml::math::signed_integers::twos_compl_to_i33;
use cairo_ml::math::signed_integers::i33_left_shift;
use cairo_ml::math::signed_integers::i33_right_shift;


use debug::print_felt;
use traits::Into;


#[test]
fn test_add() {
    // Test addition of two positive integers
    let a = i33 { inner: 42_u32, sign: false };
    let b = i33 { inner: 13_u32, sign: false };
    let result = a + b;
    assert(result.inner == 55_u32, '42 + 13 = 55');
    assert(result.sign == false, '42 + 13 -> positive');

    // Test addition of two negative integers
    let a = i33 { inner: 42_u32, sign: true };
    let b = i33 { inner: 13_u32, sign: true };
    let result = a + b;
    assert(result.inner == 55_u32, '-42 - 13 = -55');
    assert(result.sign == true, '-42 - 13 -> negative');

    // Test addition of a positive integer and a negative integer with the same magnitude
    let a = i33 { inner: 42_u32, sign: false };
    let b = i33 { inner: 42_u32, sign: true };
    let result = a + b;
    assert(result.inner == 0_u32, '42 - 42 = 0');
    assert(result.sign == false, '42 - 42 -> positive');

    // Test addition of a positive integer and a negative integer with different magnitudes
    let a = i33 { inner: 42_u32, sign: false };
    let b = i33 { inner: 13_u32, sign: true };
    let result = a + b;
    assert(result.inner == 29_u32, '42 - 13 = 29');
    assert(result.sign == false, '42 - 13 -> positive');

    // Test addition of a negative integer and a positive integer with different magnitudes
    let a = i33 { inner: 42_u32, sign: true };
    let b = i33 { inner: 13_u32, sign: false };
    let result = a + b;
    assert(result.inner == 29_u32, '-42 + 13 = -29');
    assert(result.sign == true, '-42 + 13 -> negative');
}

#[test]
fn test_sub() {
    // Test subtraction of two positive integers with larger first
    let a = i33 { inner: 42_u32, sign: false };
    let b = i33 { inner: 13_u32, sign: false };
    let result = a - b;
    assert(result.inner == 29_u32, '42 - 13 = 29');
    assert(result.sign == false, '42 - 13 -> positive');

    // Test subtraction of two positive integers with larger second
    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 42_u32, sign: false };
    let result = a - b;
    assert(result.inner == 29_u32, '13 - 42 = -29');
    assert(result.sign == true, '13 - 42 -> negative');

    // Test subtraction of two negative integers with larger first
    let a = i33 { inner: 42_u32, sign: true };
    let b = i33 { inner: 13_u32, sign: true };
    let result = a - b;
    assert(result.inner == 29_u32, '-42 - -13 = 29');
    assert(result.sign == true, '-42 - -13 -> negative');

    // Test subtraction of two negative integers with larger second
    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 42_u32, sign: true };
    let result = a - b;
    assert(result.inner == 29_u32, '-13 - -42 = 29');
    assert(result.sign == false, '-13 - -42 -> positive');

    // Test subtraction of a positive integer and a negative integer with the same magnitude
    let a = i33 { inner: 42_u32, sign: false };
    let b = i33 { inner: 42_u32, sign: true };
    let result = a - b;
    assert(result.inner == 84_u32, '42 - -42 = 84');
    assert(result.sign == false, '42 - -42 -> postive');

    // Test subtraction of a negative integer and a positive integer with the same magnitude
    let a = i33 { inner: 42_u32, sign: true };
    let b = i33 { inner: 42_u32, sign: false };
    let result = a - b;
    assert(result.inner == 84_u32, '-42 - 42 = -84');
    assert(result.sign == true, '-42 - 42 -> negative');

    // Test subtraction of a positive integer and a negative integer with different magnitudes
    let a = i33 { inner: 100_u32, sign: false };
    let b = i33 { inner: 42_u32, sign: true };
    let result = a - b;
    assert(result.inner == 142_u32, '100 - - 42 = 142');
    assert(result.sign == false, '100 - - 42 -> postive');

    // Test subtraction of a negative integer and a positive integer with different magnitudes
    let a = i33 { inner: 42_u32, sign: true };
    let b = i33 { inner: 100_u32, sign: false };
    let result = a - b;
    assert(result.inner == 142_u32, '-42 - 100 = -142');
    assert(result.sign == true, '-42 - 100 -> negative');

    // Test subtraction resulting in zero
    let a = i33 { inner: 42_u32, sign: false };
    let b = i33 { inner: 42_u32, sign: false };
    let result = a - b;
    assert(result.inner == 0_u32, '42 - 42 = 0');
    assert(result.sign == false, '42 - 42 -> positive');
}

#[test]
fn test_mul() {
    // Test multiplication of positive integers
    let a = i33 { inner: 10_u32, sign: false };
    let b = i33 { inner: 5_u32, sign: false };
    let result = a * b;
    assert(result.inner == 50_u32, '10 * 5 = 50');
    assert(result.sign == false, '10 * 5 -> positive');

    // Test multiplication of negative integers
    let a = i33 { inner: 10_u32, sign: true };
    let b = i33 { inner: 5_u32, sign: true };
    let result = a * b;
    assert(result.inner == 50_u32, '-10 * -5 = 50');
    assert(result.sign == false, '-10 * -5 -> positive');

    // Test multiplication of positive and negative integers
    let a = i33 { inner: 10_u32, sign: false };
    let b = i33 { inner: 5_u32, sign: true };
    let result = a * b;
    assert(result.inner == 50_u32, '10 * -5 = -50');
    assert(result.sign == true, '10 * -5 -> negative');

    // Test multiplication by zero
    let a = i33 { inner: 10_u32, sign: false };
    let b = i33 { inner: 0_u32, sign: false };
    let expected = i33 { inner: 0_u32, sign: false };
    let result = a * b;
    assert(result.inner == 0_u32, '10 * 0 = 0');
    assert(result.sign == false, '10 * 0 -> positive');
}

#[test]
fn test_div_no_rem() {
    // Test division of positive integers
    let a = i33 { inner: 10_u32, sign: false };
    let b = i33 { inner: 5_u32, sign: false };
    let result = a / b;
    assert(result.inner == 2_u32, '10 // 5 = 2');
    assert(result.sign == false, '10 // 5 -> positive');

    // Test division of negative integers
    let a = i33 { inner: 10_u32, sign: true };
    let b = i33 { inner: 5_u32, sign: true };
    let result = a / b;
    assert(result.inner == 2_u32, '-10 // -5 = 2');
    assert(result.sign == false, '-10 // -5 -> positive');

    // Test division of positive and negative integers
    let a = i33 { inner: 10_u32, sign: false };
    let b = i33 { inner: 5_u32, sign: true };
    let result = a / b;
    assert(result.inner == 2_u32, '10 // -5 = -2');
    assert(result.sign == true, '10 // -5 -> negative');

    // Test division with a = zero
    let a = i33 { inner: 0_u32, sign: false };
    let b = i33 { inner: 10_u32, sign: false };
    let result = a / b;
    assert(result.inner == 0_u32, '0 // 10 = 0');
    assert(result.sign == false, '0 // 10 -> positive');

    // Test division with a = zero
    let a = i33 { inner: 0_u32, sign: false };
    let b = i33 { inner: 10_u32, sign: false };
    let result = a / b;
    assert(result.inner == 0_u32, '0 // 10 = 0');
    assert(result.sign == false, '0 // 10 -> positive');
}

#[test]
fn test_div_rem() {
    // Test division and remainder of positive integers
    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 5_u32, sign: false };
    let (q, r) = div_rem(a, b);
    assert(q.inner == 2_u32 & r.inner == 3_u32, '13 // 5 = 2 r 3');
    assert(q.sign == false & r.sign == false, '13 // 5 -> positive');

    // Test division and remainder of negative integers
    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 5_u32, sign: true };
    let (q, r) = div_rem(a, b);
    assert(q.inner == 2_u32 & r.inner == 3_u32, '-13 // -5 = 2 r -3');
    assert(q.sign == false & r.sign == true, '-13 // -5 -> positive');

    // Test division and remainder of positive and negative integers
    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 5_u32, sign: true };
    let (q, r) = div_rem(a, b);
    assert(q.inner == 3_u32 & r.inner == 2_u32, '13 // -5 = -3 r -2');
    assert(q.sign == true & r.sign == true, '13 // -5 -> negative');

    // Test division with a = zero
    let a = i33 { inner: 0_u32, sign: false };
    let b = i33 { inner: 10_u32, sign: false };
    let (q, r) = div_rem(a, b);
    assert(q.inner == 0_u32 & r.inner == 0_u32, '0 // 10 = 0 r 0');
    assert(q.sign == false & r.sign == false, '0 // 10 -> positive');

    // Test division and remainder with a negative dividend and positive divisor
    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 5_u32, sign: false };
    let (q, r) = div_rem(a, b);
    assert(q.inner == 3_u32 & r.inner == 2_u32, '-13 // 5 = -3 r 2');
    assert(q.sign == true & r.sign == false, '-13 // 5 -> negative');
}

#[test]
fn test_partial_ord() {
    // Test two postive integers
    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 5_u32, sign: false };
    assert(a > b, '13 > 5');
    assert(a >= b, '13 >= 5');
    assert(b < a, '5 < 13');
    assert(b <= a, '5 <= 13');

    // Test `a` postive and `b` negative
    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 5_u32, sign: true };
    assert(a > b, '13 > -5');
    assert(a >= b, '13 >= -5');
    assert(b < a, '-5 < 13');
    assert(b <= a, '-5 <= 13');

    // Test `a` negative and `b` postive
    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 5_u32, sign: false };
    assert(b > a, '5 > -13');
    assert(b >= a, '5 >= -13');
    assert(a < b, '-13 < 5');
    assert(a <= b, '5 <= -13');

    // Test `a` negative and `b` negative
    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 5_u32, sign: true };
    assert(b > a, '-5 > -13');
    assert(b >= a, '-13 >= -5');
    assert(a < b, '-13 < -5');
    assert(a <= b, '-13 <= -5');
}

#[test]
fn test_eq_not_eq() {
    // Test two postive integers
    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 5_u32, sign: false };
    assert(a != b, '13 != 5');

    // Test `a` postive and `b` negative
    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 5_u32, sign: true };
    assert(a != b, '13 != -5');

    // Test `a` negative and `b` postive
    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 5_u32, sign: false };
    assert(a != b, '-13 != 5');

    // Test `a` negative and `b` negative
    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 5_u32, sign: true };
    assert(a != b, '-13 != -5');
}

#[test]
fn test_equality() {
    // Test equal with two positive integers
    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 13_u32, sign: false };
    assert(a == b, '13 == 13');

    // Test equal with two negative integers
    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 13_u32, sign: true };
    assert(a == b, '-13 == -13');

    // Test not equal with two postive integers
    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 5_u32, sign: false };
    assert(a != b, '13 != 5');

    // Test not equal with `a` postive and `b` negative
    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 5_u32, sign: true };
    assert(a != b, '13 != -5');

    // Test not equal with `a` negative and `b` postive
    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 5_u32, sign: false };
    assert(a != b, '-13 != 5');

    // Test not equal with `a` negative and `b` negative
    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 5_u32, sign: true };
    assert(a != b, '-13 != -5');
}

#[test]
#[available_gas(2000000)]
fn power_test() {
    let a = i33 { inner: 4_u32, sign: false };
    let b = 2_u32;
    let result = i33_power(a, b);

    assert(result.inner == 16_u32, '4**2 = 16');
    assert(result.sign == false, '4**2 = 16');

    let a = i33 { inner: 4_u32, sign: true };
    let b = 2_u32;
    let result = i33_power(a, b);

    assert(result.inner == 16_u32, '(-4)**2 = 16');
    assert(result.sign == false, '(-4)**2 = 16');

    let a = i33 { inner: 4_u32, sign: false };
    let b = 3_u32;
    let result = i33_power(a, b);

    assert(result.inner == 64_u32, '4**3 = 64');
    assert(result.sign == false, '4**3 = 64');

    let a = i33 { inner: 4_u32, sign: true };
    let b = 3_u32;
    let result = i33_power(a, b);

    assert(result.inner == 64_u32, '(-4)**3 = -64');
    assert(result.sign == true, '(-4)**3 = -64');
}

#[test]
#[available_gas(2000000)]
fn twos_compl_test() {
    let x = i33 { inner: 10_u32, sign: false };
    let res = i33_twos_compl(x);

    assert(res == 10_u64, '-10 -> 10');

    let orginal = twos_compl_to_i33(res);
    assert(orginal.inner == 10_u32, '10 -> 10');
    assert(orginal.sign == false, '10 -> -10');

    let x = i33 { inner: 10_u32, sign: true };
    let res = i33_twos_compl(x);
    assert(res == 2147483638_u64, '-10 -> 2147483638');

    let orginal = twos_compl_to_i33(res);
    assert(orginal.inner == 10_u32, '2147483638 -> -10');
    assert(orginal.sign == true, '2147483638 -> -10');
}

#[test]
#[available_gas(20000000)]
fn bitxor_test() {
    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 7_u32, sign: false };
    let result = a ^ b;

    assert(result.inner == 10_u32, '13^7 = 10');
    assert(result.sign == false, '13^7 = 10');

    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 7_u32, sign: true };
    let result = a ^ b;

    assert(result.inner == 12_u32, '13^(-7) = -12');
    assert(result.sign == true, '13^(-7) = -12');

    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 7_u32, sign: false };
    let result = a ^ b;

    assert(result.inner == 12_u32, '(-13)^7 = -12');
    assert(result.sign == true, '(-13)^7 = -12');

    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 7_u32, sign: true };
    let result = a ^ b;

    assert(result.inner == 10_u32, '(-13)^(-7) = 10');
    assert(result.sign == false, '(-13)^(-7) = 10');
}

#[test]
#[available_gas(200000000)]
fn bitand_test() {
    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 7_u32, sign: false };
    let result = a & b;

    assert(result.inner == 5_u32, '13 & 7 = 5');
    assert(result.sign == false, '13 & 7 = 5');

    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 7_u32, sign: false };
    let result = a & b;

    assert(result.inner == 3_u32, '(-13) & 7 = 3');
    assert(result.sign == false, '(-13) & 7 = 3');

    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 7_u32, sign: true };
    let result = a & b;

    assert(result.inner == 9_u32, '13 & (-7) = 9');
    assert(result.sign == false, '13 & (-7) = 9');

    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 7_u32, sign: true };
    let result = a & b;

    assert(result.inner == 15_u32, '(-13)&(-7) = -15');
    assert(result.sign == true, '(-13)&(-7) = -15');
}

#[test]
#[available_gas(200000000)]
fn bitor_test() {
    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 7_u32, sign: false };
    let result = a | b;

    assert(result.inner == 15_u32, '13 | 7 = 15');
    assert(result.sign == false, '13 | 7 = 15');

    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 7_u32, sign: false };
    let result = a | b;

    assert(result.inner == 9_u32, '(-13) | 7 = -9');
    assert(result.sign == true, '(-13) | 7 = -9');

    let a = i33 { inner: 13_u32, sign: false };
    let b = i33 { inner: 7_u32, sign: true };
    let result = a | b;

    assert(result.inner == 3_u32, '13 | (-7) = -3');
    assert(result.sign == true, '13 | (-7) = -3');

    let a = i33 { inner: 13_u32, sign: true };
    let b = i33 { inner: 7_u32, sign: true };
    let result = a | b;

    assert(result.inner == 5_u32, '(-13)|(-7) = -5');
    assert(result.sign == true, '(-13)|(-7) = -5');
}

#[test]
#[available_gas(200000000)]
fn left_shift_test() {
    let x = i33 { inner: 42_u32, sign: false };
    let res = i33_left_shift(x, 8_u64);
    assert(res.inner == 10752_u32, '42 << 8 = 10752 ');
    assert(res.sign == false, '42 << 8 = 10752');

    let x = i33 { inner: 42_u32, sign: true };
    let res = i33_left_shift(x, 8_u64);

    assert(res.inner == 10752_u32, '-42 << 8 = - 10752');
    assert(res.sign == true, '-42 << 8 = - 10752');
}

#[test]
#[available_gas(200000000)]
fn right_shift_test() {
    let x = i33 { inner: 10752_u32, sign: false };
    let res = i33_right_shift(x, 8_u64);
    assert(res.inner == 42_u32, '10752 >> 8 = 42 ');
    assert(res.sign == false, '10752 >> 8 = 42');

    let x = i33 { inner: 10752_u32, sign: true };
    let res = i33_right_shift(x, 8_u64);
    assert(res.inner == 42_u32, '-10752 >> 8 = - 42');
    assert(res.sign == true, '-10752 >> 8 = - 42');
}

#[test]
#[should_panic]
fn test_check_sign_zero() {
    let x = i33 { inner: 0_u32, sign: true };
    signed_integers::i33_check_sign_zero(x);
}
