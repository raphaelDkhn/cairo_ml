// ====================== INT 33 ======================
use cairo_ml::utils::u32_to_u64;
use cairo_ml::utils::u64_to_u128;
use cairo_ml::utils::i65_to_i33;
use cairo_ml::utils::i33_to_i65;
use cairo_ml::utils::i129_to_i65;
use debug::print_felt;
use traits::Into;

// i33 represents a 33-bit integer.
// The inner field holds the absolute value of the integer.
// The sign field is true for negative integers, and false for non-negative integers.
#[derive(Copy, Drop)]
struct i33 {
    inner: u32,
    sign: bool,
}

// Checks if the given i33 integer is zero and has the correct sign.
// # Arguments
// * `x` - The i33 integer to check.
// # Panics
// Panics if `x` is zero and has a sign that is not false.
fn i33_check_sign_zero(x: i33) {
    if x.inner == 0_u32 {
        assert(x.sign == false, 'sign of 0 must be false');
    }
}

// Adds two i33 integers.
// # Arguments
// * `a` - The first i33 to add.
// * `b` - The second i33 to add.
// # Returns
// * `i33` - The sum of `a` and `b`.
fn i33_add(a: i33, b: i33) -> i33 {
    i33_check_sign_zero(a);
    i33_check_sign_zero(b);

    // If both integers have the same sign, 
    // the sum of their absolute values can be returned.
    if a.sign == b.sign {
        let sum = a.inner + b.inner;
        if (sum == 0_u32) {
            return i33 { inner: sum, sign: false };
        }
        return i33 { inner: sum, sign: a.sign };
    } else {
        // If the integers have different signs, 
        // the larger absolute value is subtracted from the smaller one.
        let (larger, smaller) = if a.inner >= b.inner {
            (a, b)
        } else {
            (b, a)
        };
        let difference = larger.inner - smaller.inner;

        if (difference == 0_u32) {
            return i33 { inner: difference, sign: false };
        }
        return i33 { inner: difference, sign: larger.sign };
    }
}

// Implements the Add trait for i33.
impl i33Add of Add::<i33> {
    fn add(a: i33, b: i33) -> i33 {
        i33_add(a, b)
    }
}

// Implements the AddEq trait for i33.
impl i33AddEq of AddEq::<i33> {
    #[inline(always)]
    fn add_eq(ref self: i33, other: i33) {
        self = Add::add(self, other);
    }
}

// Subtracts two i33 integers.
// # Arguments
// * `a` - The first i33 to subtract.
// * `b` - The second i33 to subtract.
// # Returns
// * `i33` - The difference of `a` and `b`.
fn i33_sub(a: i33, b: i33) -> i33 {
    i33_check_sign_zero(a);
    i33_check_sign_zero(b);

    if (b.inner == 0_u32) {
        return a;
    }

    // The subtraction of `a` to `b` is achieved by negating `b` sign and adding it to `a`.
    let neg_b = i33 { inner: b.inner, sign: !b.sign };
    return a + neg_b;
}

// Implements the Sub trait for i33.
impl i33Sub of Sub::<i33> {
    fn sub(a: i33, b: i33) -> i33 {
        i33_sub(a, b)
    }
}

// Implements the SubEq trait for i33.
impl i33SubEq of SubEq::<i33> {
    #[inline(always)]
    fn sub_eq(ref self: i33, other: i33) {
        self = Sub::sub(self, other);
    }
}

// Multiplies two i33 integers.
// 
// # Arguments
//
// * `a` - The first i33 to multiply.
// * `b` - The second i33 to multiply.
//
// # Returns
//
// * `i33` - The product of `a` and `b`.
fn i33_mul(a: i33, b: i33) -> i33 {
    i33_check_sign_zero(a);
    i33_check_sign_zero(b);

    // The sign of the product is the XOR of the signs of the operands.
    let sign = a.sign ^ b.sign;
    // The product is the product of the absolute values of the operands.
    let inner = a.inner * b.inner;

    if (inner == 0_u32) {
        return i33 { inner: inner, sign: false };
    }

    return i33 { inner, sign };
}

// Implements the Mul trait for i33.
impl i33Mul of Mul::<i33> {
    fn mul(a: i33, b: i33) -> i33 {
        i33_mul(a, b)
    }
}

// Implements the MulEq trait for i33.
impl i33MulEq of MulEq::<i33> {
    #[inline(always)]
    fn mul_eq(ref self: i33, other: i33) {
        self = Mul::mul(self, other);
    }
}

// Divides the first i33 by the second i33.
// # Arguments
// * `a` - The i33 dividend.
// * `b` - The i33 divisor.
// # Returns
// * `i33` - The quotient of `a` and `b`.
fn i33_div(a: i33, b: i33) -> i33 {
    i33_check_sign_zero(a);
    // Check that the divisor is not zero.
    assert(b.inner != 0_u32, 'b can not be 0');

    // The sign of the quotient is the XOR of the signs of the operands.
    let sign = a.sign ^ b.sign;

    if (sign == false) {
        // If the operands are positive, the quotient is simply their absolute value quotient.
        return i33 { inner: a.inner / b.inner, sign: sign };
    }

    // If the operands have different signs, rounding is necessary.
    // First, check if the quotient is an integer.
    if (a.inner % b.inner == 0_u32) {
        let quotient = a.inner / b.inner;
        if (quotient == 0_u32) {
            return i33 { inner: quotient, sign: false };
        }
        return i33 { inner: quotient, sign: sign };
    }

    // If the quotient is not an integer, multiply the dividend by 10 to move the decimal point over.
    let quotient = (a.inner * 10_u32) / b.inner;
    let last_digit = quotient % 10_u32;

    if (quotient == 0_u32) {
        return i33 { inner: quotient, sign: false };
    }

    // Check the last digit to determine rounding direction.
    if (last_digit <= 5_u32) {
        return i33 { inner: quotient / 10_u32, sign: sign };
    } else {
        return i33 { inner: (quotient / 10_u32) + 1_u32, sign: sign };
    }
}

// Implements the Div trait for i33.
impl i33Div of Div::<i33> {
    fn div(a: i33, b: i33) -> i33 {
        i33_div(a, b)
    }
}

// Implements the DivEq trait for i33.
impl i33DivEq of DivEq::<i33> {
    #[inline(always)]
    fn div_eq(ref self: i33, other: i33) {
        self = Div::div(self, other);
    }
}

// Calculates the remainder of the division of a first i33 by a second i33.
// # Arguments
// * `a` - The i33 dividend.
// * `b` - The i33 divisor.
// # Returns
// * `i33` - The remainder of dividing `a` by `b`.
fn i33_rem(a: i33, b: i33) -> i33 {
    i33_check_sign_zero(a);
    // Check that the divisor is not zero.
    assert(b.inner != 0_u32, 'b can not be 0');

    return a - (b * (a / b));
}

// Implements the Rem trait for i33.
impl i33Rem of Rem::<i33> {
    fn rem(a: i33, b: i33) -> i33 {
        i33_rem(a, b)
    }
}

// Implements the RemEq trait for i33.
impl i33RemEq of RemEq::<i33> {
    #[inline(always)]
    fn rem_eq(ref self: i33, other: i33) {
        self = Rem::rem(self, other);
    }
}

// Calculates both the quotient and the remainder of the division of a first i33 by a second i33.
// # Arguments
// * `a` - The i33 dividend.
// * `b` - The i33 divisor.
// # Returns
// * `(i33, i33)` - A tuple containing the quotient and the remainder of dividing `a` by `b`.
fn div_rem(a: i33, b: i33) -> (i33, i33) {
    let quotient = i33_div(a, b);
    let remainder = i33_rem(a, b);

    return (quotient, remainder);
}

// Compares two i33 integers for equality.
// # Arguments
// * `a` - The first i33 integer to compare.
// * `b` - The second i33 integer to compare.
// # Returns
// * `bool` - `true` if the two integers are equal, `false` otherwise.
fn i33_eq(a: i33, b: i33) -> bool {
    // Check if the two integers have the same sign and the same absolute value.
    if a.sign == b.sign & a.inner == b.inner {
        return true;
    }

    return false;
}

// Compares two i33 integers for inequality.
// # Arguments
// * `a` - The first i33 integer to compare.
// * `b` - The second i33 integer to compare.
// # Returns
// * `bool` - `true` if the two integers are not equal, `false` otherwise.
fn i33_ne(a: i33, b: i33) -> bool {
    // The result is the inverse of the equal function.
    return !i33_eq(a, b);
}

// Implements the PartialEq trait for i33.
impl i33PartialEq of PartialEq::<i33> {
    fn eq(a: i33, b: i33) -> bool {
        i33_eq(a, b)
    }

    fn ne(a: i33, b: i33) -> bool {
        i33_ne(a, b)
    }
}

// Compares two i33 integers for greater than.
// # Arguments
// * `a` - The first i33 integer to compare.
// * `b` - The second i33 integer to compare.
// # Returns
// * `bool` - `true` if `a` is greater than `b`, `false` otherwise.
fn i33_gt(a: i33, b: i33) -> bool {
    // Check if `a` is negative and `b` is positive.
    if (a.sign & !b.sign) {
        return false;
    }
    // Check if `a` is positive and `b` is negative.
    if (!a.sign & b.sign) {
        return true;
    }
    // If `a` and `b` have the same sign, compare their absolute values.
    if (a.sign & b.sign) {
        return a.inner < b.inner;
    } else {
        return a.inner > b.inner;
    }
}

// Determines whether the first i33 is less than the second i33.
// # Arguments
// * `a` - The i33 to compare against the second i33.
// * `b` - The i33 to compare against the first i33.
// # Returns
// * `bool` - `true` if `a` is less than `b`, `false` otherwise.
fn i33_lt(a: i33, b: i33) -> bool {
    // The result is the inverse of the greater than function.
    return !i33_gt(a, b);
}

// Checks if the first i33 integer is less than or equal to the second.
// # Arguments
// * `a` - The first i33 integer to compare.
// * `b` - The second i33 integer to compare.
// # Returns
// * `bool` - `true` if `a` is less than or equal to `b`, `false` otherwise.
fn i33_le(a: i33, b: i33) -> bool {
    if (a == b | i33_lt(a, b) == true) {
        return true;
    } else {
        return false;
    }
}

// Checks if the first i33 integer is greater than or equal to the second.
// # Arguments
// * `a` - The first i33 integer to compare.
// * `b` - The second i33 integer to compare.
// # Returns
// * `bool` - `true` if `a` is greater than or equal to `b`, `false` otherwise.
fn i33_ge(a: i33, b: i33) -> bool {
    if (a == b | i33_gt(a, b) == true) {
        return true;
    } else {
        return false;
    }
}

// Implements the PartialOrd trait for i33.
impl i33PartialOrd of PartialOrd::<i33> {
    fn le(a: i33, b: i33) -> bool {
        i33_le(a, b)
    }
    fn ge(a: i33, b: i33) -> bool {
        i33_ge(a, b)
    }

    fn lt(a: i33, b: i33) -> bool {
        i33_lt(a, b)
    }
    fn gt(a: i33, b: i33) -> bool {
        i33_gt(a, b)
    }
}

// Negates the given i33 integer.
// # Arguments
// * `x` - The i33 integer to negate.
// # Returns
// * `i33` - The negation of `x`.
fn i33_neg(x: i33) -> i33 {
    // The negation of an integer is obtained by flipping its sign.
    return i33 { inner: x.inner, sign: !x.sign };
}

// Implements the Neg trait for i33.
impl i33Neg of Neg::<i33> {
    fn neg(x: i33) -> i33 {
        i33_neg(x)
    }
}

// Computes the absolute value of the given i33 integer.
// # Arguments
// * `x` - The i33 integer to compute the absolute value of.
// # Returns
// * `i33` - The absolute value of `x`.
fn i33_abs(x: i33) -> i33 {
    return i33 { inner: x.inner, sign: false };
}

// Computes the maximum between two i33 integers.
// # Arguments
// * `a` - The first i33 integer to compare.
// * `b` - The second i33 integer to compare.
// # Returns
// * `i33` - The maximum between `a` and `b`.
fn i33_max(a: i33, b: i33) -> i33 {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

// Computes the minimum between two i33 integers.
// # Arguments
// * `a` - The first i33 integer to compare.
// * `b` - The second i33 integer to compare.
// # Returns
// * `i33` - The minimum between `a` and `b`.
fn i33_min(a: i33, b: i33) -> i33 {
    if (a < b) {
        return a;
    } else {
        return b;
    }
}

// Raise a i33 to a power.
// # Arguments
/// * `base` - The number to raise.
/// * `exp` - The exponent.
/// # Returns
/// * `i33` - The result of base raised to the power of exp.
fn i33_power(base: i33, exp: u32) -> i33 {
    // --- Check if out of gas ---
    // TODO: Remove when automatically handled by compiler.
    match gas::get_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    if (exp == 0_u32) {
        return i33 { inner: 1_u32, sign: false };
    } else {
        return base * i33_power(base, exp - 1_u32);
    }
}

// Calculate the two's complement representation of a negative number 
fn i33_twos_compl(integer: i33) -> u64 {
    if (integer.sign == false) {
        return u32_to_u64(integer.inner);
    }

    let mut complement = 1_u64;

    __i33_twos_compl(integer, ref complement, 0_u8);

    return complement - u32_to_u64(integer.inner);
}

fn __i33_twos_compl(integer: i33, ref complement: u64, n: u8) {
    // --- Check if out of gas ---
    // TODO: Remove when automatically handled by compiler.
    match gas::get_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    if (n == 31_u8) {
        return ();
    }

    complement = complement * 2_u64;

    __i33_twos_compl(integer, ref complement, n + 1_u8);
}

fn twos_compl_to_i33(value: u64) -> i33 {
    let max_positive = i65 { inner: 2147483648_u64, sign: false };
    let i65_value = i65 { inner: value, sign: false };
    let two = i65 { inner: 2_u64, sign: false };

    if (i65_value >= max_positive / two) {
        return i65_to_i33(i65_value - max_positive);
    }

    return i65_to_i33(i65_value);
}

fn i33_bitxor(a: i33, b: i33) -> i33 {
    let a_twos_compl = i33_twos_compl(a);
    let b_twos_compl = i33_twos_compl(b);
    let power_of_two = 1_u64;
    let mut result_compl = 0_u64;

    __i33_bitxor(a_twos_compl, b_twos_compl, power_of_two, ref result_compl);

    return twos_compl_to_i33(result_compl);
}

fn __i33_bitxor(a: u64, b: u64, power_of_two: u64, ref result: u64) {
    // --- Check if out of gas ---
    // TODO: Remove when automatically handled by compiler.
    match gas::get_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    if (a == 0_u64 & b == 0_u64) {
        return ();
    }

    let a_bit = a % 2_u64;
    let b_bit = b % 2_u64;

    let xor_bit = (a_bit + b_bit) % 2_u64;
    result = result + (xor_bit * power_of_two);

    __i33_bitxor(a / 2_u64, b / 2_u64, power_of_two * 2_u64, ref result);
}

impl i33BitXor of BitXor::<i33> {
    fn bitxor(a: i33, b: i33) -> i33 {
        i33_bitxor(a, b)
    }
}

fn i33_bitand(a: i33, b: i33) -> i33 {
    let a_twos_compl = i33_twos_compl(a);
    let b_twos_compl = i33_twos_compl(b);
    let power_of_two = 1_u64;
    let mut result_compl = 0_u64;

    __i33_bitand(a_twos_compl, b_twos_compl, power_of_two, ref result_compl);

    return twos_compl_to_i33(result_compl);
}

fn __i33_bitand(a: u64, b: u64, power_of_two: u64, ref result: u64) {
    // --- Check if out of gas ---
    // TODO: Remove when automatically handled by compiler.
    match gas::get_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    // ---End recursion---
    if (a == 0_u64 & b == 0_u64) {
        return ();
    }

    let a_bit = a % 2_u64;
    let b_bit = b % 2_u64;

    let and_bit = a_bit * b_bit;
    result = result + (and_bit * power_of_two);

    __i33_bitand(a / 2_u64, b / 2_u64, power_of_two * 2_u64, ref result);
}

impl i33BitAnd of BitAnd::<i33> {
    fn bitand(a: i33, b: i33) -> i33 {
        i33_bitand(a, b)
    }
}

fn i33_left_shit(value: i33, shift_amount: u64) -> i33 {
    let value_i65 = i33_to_i65(value);
    let mut result = i33_to_i65(value);

    let two = i65 { inner: 2_u64, sign: false };
    let mask = i65_power(two, 32_u64) - i65 { inner: 1_u64, sign: false };

    // Get the two's complement of the negative value.
    if (value.sign == true) {
        result = (i65 { inner: value_i65.inner, sign: false } ^ mask) + i65 {
            inner: 1_u64, sign: false
        };
    }

    result = result * i65_power(two, shift_amount);

    // Check for overflow and limit result to bit_width bits.
    result = result & mask;
   // print_felt(result.inner.into());

    let is_negative = result & i65_power(two, 32_u64 - 1_u64);

    // If the result is negative, convert it back to two's complement.
    if (is_negative.inner == 2147483648_u64) {
        result = -((result ^ mask)) - i65 { inner: 1_u64, sign: false };
    }

    return i65_to_i33(result);
}

// ====================== INT 65 ======================

// i65 represents a 65-bit integer.
// The inner field holds the absolute value of the integer.
// The sign field is true for negative integers, and false for non-negative integers.
#[derive(Copy, Drop)]
struct i65 {
    inner: u64,
    sign: bool,
}

// Checks if the given i65 integer is zero and has the correct sign.
// # Arguments
// * `x` - The i65 integer to check.
// # Panics
// Panics if `x` is zero and has a sign that is not false.
fn i65_check_sign_zero(x: i65) {
    if x.inner == 0_u64 {
        assert(x.sign == false, 'sign of 0 must be false');
    }
}

// Adds two i65 integers.
// # Arguments
// * `a` - The first i65 to add.
// * `b` - The second i65 to add.
// # Returns
// * `i65` - The sum of `a` and `b`.
fn i65_add(a: i65, b: i65) -> i65 {
    i65_check_sign_zero(a);
    i65_check_sign_zero(b);

    // If both integers have the same sign, 
    // the sum of their absolute values can be returned.
    if a.sign == b.sign {
        let sum = a.inner + b.inner;
        if (sum == 0_u64) {
            return i65 { inner: sum, sign: false };
        }
        return i65 { inner: sum, sign: a.sign };
    } else {
        // If the integers have different signs, 
        // the larger absolute value is subtracted from the smaller one.
        let (larger, smaller) = if a.inner >= b.inner {
            (a, b)
        } else {
            (b, a)
        };
        let difference = larger.inner - smaller.inner;

        if (difference == 0_u64) {
            return i65 { inner: difference, sign: false };
        }
        return i65 { inner: difference, sign: larger.sign };
    }
}

// Implements the Add trait for i65.
impl i65Add of Add::<i65> {
    fn add(a: i65, b: i65) -> i65 {
        i65_add(a, b)
    }
}

// Implements the AddEq trait for i65.
impl i65AddEq of AddEq::<i65> {
    #[inline(always)]
    fn add_eq(ref self: i65, other: i65) {
        self = Add::add(self, other);
    }
}

// Subtracts two i65 integers.
// # Arguments
// * `a` - The first i65 to subtract.
// * `b` - The second i65 to subtract.
// # Returns
// * `i65` - The difference of `a` and `b`.
fn i65_sub(a: i65, b: i65) -> i65 {
    i65_check_sign_zero(a);
    i65_check_sign_zero(b);

    if (b.inner == 0_u64) {
        return a;
    }

    // The subtraction of `a` to `b` is achieved by negating `b` sign and adding it to `a`.
    let neg_b = i65 { inner: b.inner, sign: !b.sign };
    return a + neg_b;
}

// Implements the Sub trait for i65.
impl i65Sub of Sub::<i65> {
    fn sub(a: i65, b: i65) -> i65 {
        i65_sub(a, b)
    }
}

// Implements the SubEq trait for i65.
impl i65SubEq of SubEq::<i65> {
    #[inline(always)]
    fn sub_eq(ref self: i65, other: i65) {
        self = Sub::sub(self, other);
    }
}

// Multiplies two i65 integers.
// 
// # Arguments
//
// * `a` - The first i65 to multiply.
// * `b` - The second i65 to multiply.
//
// # Returns
//
// * `i65` - The product of `a` and `b`.
fn i65_mul(a: i65, b: i65) -> i65 {
    i65_check_sign_zero(a);
    i65_check_sign_zero(b);

    // The sign of the product is the XOR of the signs of the operands.
    let sign = a.sign ^ b.sign;
    // The product is the product of the absolute values of the operands.
    let inner = a.inner * b.inner;

    if (inner == 0_u64) {
        return i65 { inner: inner, sign: false };
    }

    return i65 { inner, sign };
}

// Implements the Mul trait for i65.
impl i65Mul of Mul::<i65> {
    fn mul(a: i65, b: i65) -> i65 {
        i65_mul(a, b)
    }
}

// Implements the MulEq trait for i65.
impl i65MulEq of MulEq::<i65> {
    #[inline(always)]
    fn mul_eq(ref self: i65, other: i65) {
        self = Mul::mul(self, other);
    }
}

// Divides the first i65 by the second i65.
// # Arguments
// * `a` - The i65 dividend.
// * `b` - The i65 divisor.
// # Returns
// * `i65` - The quotient of `a` and `b`.
fn i65_div(a: i65, b: i65) -> i65 {
    i65_check_sign_zero(a);
    // Check that the divisor is not zero.
    assert(b.inner != 0_u64, 'b can not be 0');

    // The sign of the quotient is the XOR of the signs of the operands.
    let sign = a.sign ^ b.sign;

    if (sign == false) {
        // If the operands are positive, the quotient is simply their absolute value quotient.
        return i65 { inner: a.inner / b.inner, sign: sign };
    }

    // If the operands have different signs, rounding is necessary.
    // First, check if the quotient is an integer.
    if (a.inner % b.inner == 0_u64) {
        let quotient = a.inner / b.inner;
        if (quotient == 0_u64) {
            return i65 { inner: quotient, sign: false };
        }
        return i65 { inner: quotient, sign: sign };
    }

    // If the quotient is not an integer, multiply the dividend by 10 to move the decimal point over.
    let quotient = (a.inner * 10_u64) / b.inner;
    let last_digit = quotient % 10_u64;

    if (quotient == 0_u64) {
        return i65 { inner: quotient, sign: false };
    }

    // Check the last digit to determine rounding direction.
    if (last_digit <= 5_u64) {
        return i65 { inner: quotient / 10_u64, sign: sign };
    } else {
        return i65 { inner: (quotient / 10_u64) + 1_u64, sign: sign };
    }
}

// Implements the Div trait for i65.
impl i65Div of Div::<i65> {
    fn div(a: i65, b: i65) -> i65 {
        i65_div(a, b)
    }
}

// Implements the DivEq trait for i65.
impl i65DivEq of DivEq::<i65> {
    #[inline(always)]
    fn div_eq(ref self: i65, other: i65) {
        self = Div::div(self, other);
    }
}

// Calculates the remainder of the division of a first i65 by a second i65.
// # Arguments
// * `a` - The i65 dividend.
// * `b` - The i65 divisor.
// # Returns
// * `i65` - The remainder of dividing `a` by `b`.
fn i65_rem(a: i65, b: i65) -> i65 {
    i65_check_sign_zero(a);
    // Check that the divisor is not zero.
    assert(b.inner != 0_u64, 'b can not be 0');

    return a - (b * (a / b));
}

// Implements the Rem trait for i65.
impl i65Rem of Rem::<i65> {
    fn rem(a: i65, b: i65) -> i65 {
        i65_rem(a, b)
    }
}

// Implements the RemEq trait for i65.
impl i65RemEq of RemEq::<i65> {
    #[inline(always)]
    fn rem_eq(ref self: i65, other: i65) {
        self = Rem::rem(self, other);
    }
}

// Calculates both the quotient and the remainder of the division of a first i65 by a second i65.
// # Arguments
// * `a` - The i65 dividend.
// * `b` - The i65 divisor.
// # Returns
// * `(i65, i65)` - A tuple containing the quotient and the remainder of dividing `a` by `b`.
fn i65_div_rem(a: i65, b: i65) -> (i65, i65) {
    let quotient = i65_div(a, b);
    let remainder = i65_rem(a, b);

    return (quotient, remainder);
}

// Compares two i65 integers for equality.
// # Arguments
// * `a` - The first i65 integer to compare.
// * `b` - The second i65 integer to compare.
// # Returns
// * `bool` - `true` if the two integers are equal, `false` otherwise.
fn i65_eq(a: i65, b: i65) -> bool {
    // Check if the two integers have the same sign and the same absolute value.
    if a.sign == b.sign & a.inner == b.inner {
        return true;
    }

    return false;
}

// Compares two i65 integers for inequality.
// # Arguments
// * `a` - The first i65 integer to compare.
// * `b` - The second i65 integer to compare.
// # Returns
// * `bool` - `true` if the two integers are not equal, `false` otherwise.
fn i65_ne(a: i65, b: i65) -> bool {
    // The result is the inverse of the equal function.
    return !i65_eq(a, b);
}

// Implements the PartialEq trait for i65.
impl i65PartialEq of PartialEq::<i65> {
    fn eq(a: i65, b: i65) -> bool {
        i65_eq(a, b)
    }

    fn ne(a: i65, b: i65) -> bool {
        i65_ne(a, b)
    }
}

// Compares two i65 integers for greater than.
// # Arguments
// * `a` - The first i65 integer to compare.
// * `b` - The second i65 integer to compare.
// # Returns
// * `bool` - `true` if `a` is greater than `b`, `false` otherwise.
fn i65_gt(a: i65, b: i65) -> bool {
    // Check if `a` is negative and `b` is positive.
    if (a.sign & !b.sign) {
        return false;
    }
    // Check if `a` is positive and `b` is negative.
    if (!a.sign & b.sign) {
        return true;
    }
    // If `a` and `b` have the same sign, compare their absolute values.
    if (a.sign & b.sign) {
        return a.inner < b.inner;
    } else {
        return a.inner > b.inner;
    }
}

// Determines whether the first i65 is less than the second i65.
// # Arguments
// * `a` - The i65 to compare against the second i65.
// * `b` - The i65 to compare against the first i65.
// # Returns
// * `bool` - `true` if `a` is less than `b`, `false` otherwise.
fn i65_lt(a: i65, b: i65) -> bool {
    // The result is the inverse of the greater than function.
    return !i65_gt(a, b);
}

// Checks if the first i65 integer is less than or equal to the second.
// # Arguments
// * `a` - The first i65 integer to compare.
// * `b` - The second i65 integer to compare.
// # Returns
// * `bool` - `true` if `a` is less than or equal to `b`, `false` otherwise.
fn i65_le(a: i65, b: i65) -> bool {
    if (a == b | i65_lt(a, b) == true) {
        return true;
    } else {
        return false;
    }
}

// Checks if the first i65 integer is greater than or equal to the second.
// # Arguments
// * `a` - The first i65 integer to compare.
// * `b` - The second i65 integer to compare.
// # Returns
// * `bool` - `true` if `a` is greater than or equal to `b`, `false` otherwise.
fn i65_ge(a: i65, b: i65) -> bool {
    if (a == b | i65_gt(a, b) == true) {
        return true;
    } else {
        return false;
    }
}

// Implements the PartialOrd trait for i65.
impl i65PartialOrd of PartialOrd::<i65> {
    fn le(a: i65, b: i65) -> bool {
        i65_le(a, b)
    }
    fn ge(a: i65, b: i65) -> bool {
        i65_ge(a, b)
    }

    fn lt(a: i65, b: i65) -> bool {
        i65_lt(a, b)
    }
    fn gt(a: i65, b: i65) -> bool {
        i65_gt(a, b)
    }
}

// Negates the given i65 integer.
// # Arguments
// * `x` - The i65 integer to negate.
// # Returns
// * `i65` - The negation of `x`.
fn i65_neg(x: i65) -> i65 {
    // The negation of an integer is obtained by flipping its sign.
    return i65 { inner: x.inner, sign: !x.sign };
}

// Implements the Neg trait for i65.
impl i65Neg of Neg::<i65> {
    fn neg(x: i65) -> i65 {
        i65_neg(x)
    }
}

// Computes the absolute value of the given i65 integer.
// # Arguments
// * `x` - The i65 integer to compute the absolute value of.
// # Returns
// * `i65` - The absolute value of `x`.
fn i65_abs(x: i65) -> i65 {
    return i65 { inner: x.inner, sign: false };
}

// Computes the maximum between two i65 integers.
// # Arguments
// * `a` - The first i65 integer to compare.
// * `b` - The second i65 integer to compare.
// # Returns
// * `i65` - The maximum between `a` and `b`.
fn i65_max(a: i65, b: i65) -> i65 {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

// Computes the minimum between two i65 integers.
// # Arguments
// * `a` - The first i65 integer to compare.
// * `b` - The second i65 integer to compare.
// # Returns
// * `i65` - The minimum between `a` and `b`.
fn i65_min(a: i65, b: i65) -> i65 {
    if (a < b) {
        return a;
    } else {
        return b;
    }
}

// Raise a i65 to a power.
// # Arguments
/// * `base` - The number to raise.
/// * `exp` - The exponent.
/// # Returns
/// * `i65` - The result of base raised to the power of exp.
fn i65_power(base: i65, exp: u64) -> i65 {
    // --- Check if out of gas ---
    // TODO: Remove when automatically handled by compiler.
    match gas::get_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    if (exp == 0_u64) {
        return i65 { inner: 1_u64, sign: false };
    } else {
        return base * i65_power(base, exp - 1_u64);
    }
}

// Calculate the two's complement representation of a negative number 
fn i65_twos_compl(integer: i65) -> u128 {
    if (integer.sign == false) {
        return u64_to_u128(integer.inner);
    }

    let mut complement = 1_u128;

    __i65_twos_compl(integer, ref complement, 0_u8);

    return complement - u64_to_u128(integer.inner);
}

fn __i65_twos_compl(integer: i65, ref complement: u128, n: u8) {
    // --- Check if out of gas ---
    // TODO: Remove when automatically handled by compiler.
    match gas::get_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    if (n == 31_u8) {
        return ();
    }

    complement = complement * 2_u128;

    __i65_twos_compl(integer, ref complement, n + 1_u8);
}

fn twos_compl_to_i65(value: u128) -> i65 {
    let max_positive = i129 { inner: 9223372036854775808_u128, sign: false };
    let i129_value = i129 { inner: value, sign: false };
    let two = i129 { inner: 2_u128, sign: false };

    if (i129_value >= max_positive / two) {
        return i129_to_i65(i129_value - max_positive);
    }

    return i129_to_i65(i129_value);
}

fn i65_bitxor(a: i65, b: i65) -> i65 {
    let a_twos_compl = i65_twos_compl(a);
    let b_twos_compl = i65_twos_compl(b);
    let power_of_two = 1_u128;
    let mut result_compl = 0_u128;

    __i65_bitxor(a_twos_compl, b_twos_compl, power_of_two, ref result_compl);

    return twos_compl_to_i65(result_compl);
}

fn __i65_bitxor(a: u128, b: u128, power_of_two: u128, ref result: u128) {
    // --- Check if out of gas ---
    // TODO: Remove when automatically handled by compiler.
    match gas::get_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    if (a == 0_u128 & b == 0_u128) {
        return ();
    }

    let a_bit = a % 2_u128;
    let b_bit = b % 2_u128;

    let xor_bit = (a_bit + b_bit) % 2_u128;
    result = result + (xor_bit * power_of_two);

    __i65_bitxor(a / 2_u128, b / 2_u128, power_of_two * 2_u128, ref result);
}

impl i65BitXor of BitXor::<i65> {
    fn bitxor(a: i65, b: i65) -> i65 {
        i65_bitxor(a, b)
    }
}

fn i65_bitand(a: i65, b: i65) -> i65 {
    let a_twos_compl = i65_twos_compl(a);
    let b_twos_compl = i65_twos_compl(b);
    let power_of_two = 1_u128;
    let mut result_compl = 0_u128;

    __i65_bitand(a_twos_compl, b_twos_compl, power_of_two, ref result_compl);

    return twos_compl_to_i65(result_compl);
}

fn __i65_bitand(a: u128, b: u128, power_of_two: u128, ref result: u128) {
    // --- Check if out of gas ---
    // TODO: Remove when automatically handled by compiler.
    match gas::get_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    // ---End recursion---
    if (a == 0_u128 & b == 0_u128) {
        return ();
    }

    let a_bit = a % 2_u128;
    let b_bit = b % 2_u128;

    let and_bit = a_bit * b_bit;
    result = result + (and_bit * power_of_two);

    __i65_bitand(a / 2_u128, b / 2_u128, power_of_two * 2_u128, ref result);
}

impl i65BitAnd of BitAnd::<i65> {
    fn bitand(a: i65, b: i65) -> i65 {
        i65_bitand(a, b)
    }
}

// ====================== INT 129 ======================

// i129 represents a 129-bit integer.
// The inner field holds the absolute value of the integer.
// The sign field is true for negative integers, and false for non-negative integers.
#[derive(Copy, Drop)]
struct i129 {
    inner: u128,
    sign: bool,
}

// Checks if the given i129 integer is zero and has the correct sign.
// # Arguments
// * `x` - The i129 integer to check.
// # Panics
// Panics if `x` is zero and has a sign that is not false.
fn i129_check_sign_zero(x: i129) {
    if x.inner == 0_u128 {
        assert(x.sign == false, 'sign of 0 must be false');
    }
}

// Adds two i129 integers.
// # Arguments
// * `a` - The first i129 to add.
// * `b` - The second i129 to add.
// # Returns
// * `i129` - The sum of `a` and `b`.
fn i129_add(a: i129, b: i129) -> i129 {
    i129_check_sign_zero(a);
    i129_check_sign_zero(b);

    // If both integers have the same sign, 
    // the sum of their absolute values can be returned.
    if a.sign == b.sign {
        let sum = a.inner + b.inner;
        if (sum == 0_u128) {
            return i129 { inner: sum, sign: false };
        }
        return i129 { inner: sum, sign: a.sign };
    } else {
        // If the integers have different signs, 
        // the larger absolute value is subtracted from the smaller one.
        let (larger, smaller) = if a.inner >= b.inner {
            (a, b)
        } else {
            (b, a)
        };
        let difference = larger.inner - smaller.inner;

        if (difference == 0_u128) {
            return i129 { inner: difference, sign: false };
        }
        return i129 { inner: difference, sign: larger.sign };
    }
}

// Implements the Add trait for i129.
impl i129Add of Add::<i129> {
    fn add(a: i129, b: i129) -> i129 {
        i129_add(a, b)
    }
}

// Implements the AddEq trait for i129.
impl i129AddEq of AddEq::<i129> {
    #[inline(always)]
    fn add_eq(ref self: i129, other: i129) {
        self = Add::add(self, other);
    }
}

// Subtracts two i129 integers.
// # Arguments
// * `a` - The first i129 to subtract.
// * `b` - The second i129 to subtract.
// # Returns
// * `i129` - The difference of `a` and `b`.
fn i129_sub(a: i129, b: i129) -> i129 {
    i129_check_sign_zero(a);
    i129_check_sign_zero(b);

    if (b.inner == 0_u128) {
        return a;
    }

    // The subtraction of `a` to `b` is achieved by negating `b` sign and adding it to `a`.
    let neg_b = i129 { inner: b.inner, sign: !b.sign };
    return a + neg_b;
}

// Implements the Sub trait for i129.
impl i129Sub of Sub::<i129> {
    fn sub(a: i129, b: i129) -> i129 {
        i129_sub(a, b)
    }
}

// Implements the SubEq trait for i129.
impl i129SubEq of SubEq::<i129> {
    #[inline(always)]
    fn sub_eq(ref self: i129, other: i129) {
        self = Sub::sub(self, other);
    }
}

// Multiplies two i129 integers.
// 
// # Arguments
//
// * `a` - The first i129 to multiply.
// * `b` - The second i129 to multiply.
//
// # Returns
//
// * `i129` - The product of `a` and `b`.
fn i129_mul(a: i129, b: i129) -> i129 {
    i129_check_sign_zero(a);
    i129_check_sign_zero(b);

    // The sign of the product is the XOR of the signs of the operands.
    let sign = a.sign ^ b.sign;
    // The product is the product of the absolute values of the operands.
    let inner = a.inner * b.inner;

    if (inner == 0_u128) {
        return i129 { inner: inner, sign: false };
    }

    return i129 { inner, sign };
}

// Implements the Mul trait for i129.
impl i129Mul of Mul::<i129> {
    fn mul(a: i129, b: i129) -> i129 {
        i129_mul(a, b)
    }
}

// Implements the MulEq trait for i129.
impl i129MulEq of MulEq::<i129> {
    #[inline(always)]
    fn mul_eq(ref self: i129, other: i129) {
        self = Mul::mul(self, other);
    }
}

// Divides the first i129 by the second i129.
// # Arguments
// * `a` - The i129 dividend.
// * `b` - The i129 divisor.
// # Returns
// * `i129` - The quotient of `a` and `b`.
fn i129_div(a: i129, b: i129) -> i129 {
    i129_check_sign_zero(a);
    // Check that the divisor is not zero.
    assert(b.inner != 0_u128, 'b can not be 0');

    // The sign of the quotient is the XOR of the signs of the operands.
    let sign = a.sign ^ b.sign;

    if (sign == false) {
        // If the operands are positive, the quotient is simply their absolute value quotient.
        return i129 { inner: a.inner / b.inner, sign: sign };
    }

    // If the operands have different signs, rounding is necessary.
    // First, check if the quotient is an integer.
    if (a.inner % b.inner == 0_u128) {
        let quotient = a.inner / b.inner;
        if (quotient == 0_u128) {
            return i129 { inner: quotient, sign: false };
        }
        return i129 { inner: quotient, sign: sign };
    }

    // If the quotient is not an integer, multiply the dividend by 10 to move the decimal point over.
    let quotient = (a.inner * 10_u128) / b.inner;
    let last_digit = quotient % 10_u128;

    if (quotient == 0_u128) {
        return i129 { inner: quotient, sign: false };
    }

    // Check the last digit to determine rounding direction.
    if (last_digit <= 5_u128) {
        return i129 { inner: quotient / 10_u128, sign: sign };
    } else {
        return i129 { inner: (quotient / 10_u128) + 1_u128, sign: sign };
    }
}

// Implements the Div trait for i129.
impl i129Div of Div::<i129> {
    fn div(a: i129, b: i129) -> i129 {
        i129_div(a, b)
    }
}

// Implements the DivEq trait for i129.
impl i129DivEq of DivEq::<i129> {
    #[inline(always)]
    fn div_eq(ref self: i129, other: i129) {
        self = Div::div(self, other);
    }
}

// Calculates the remainder of the division of a first i129 by a second i129.
// # Arguments
// * `a` - The i129 dividend.
// * `b` - The i129 divisor.
// # Returns
// * `i129` - The remainder of dividing `a` by `b`.
fn i129_rem(a: i129, b: i129) -> i129 {
    i129_check_sign_zero(a);
    // Check that the divisor is not zero.
    assert(b.inner != 0_u128, 'b can not be 0');

    return a - (b * (a / b));
}

// Implements the Rem trait for i129.
impl i129Rem of Rem::<i129> {
    fn rem(a: i129, b: i129) -> i129 {
        i129_rem(a, b)
    }
}

// Implements the RemEq trait for i129.
impl i129RemEq of RemEq::<i129> {
    #[inline(always)]
    fn rem_eq(ref self: i129, other: i129) {
        self = Rem::rem(self, other);
    }
}

// Calculates both the quotient and the remainder of the division of a first i129 by a second i129.
// # Arguments
// * `a` - The i129 dividend.
// * `b` - The i129 divisor.
// # Returns
// * `(i129, i129)` - A tuple containing the quotient and the remainder of dividing `a` by `b`.
fn i129_div_rem(a: i129, b: i129) -> (i129, i129) {
    let quotient = i129_div(a, b);
    let remainder = i129_rem(a, b);

    return (quotient, remainder);
}

// Compares two i129 integers for equality.
// # Arguments
// * `a` - The first i129 integer to compare.
// * `b` - The second i129 integer to compare.
// # Returns
// * `bool` - `true` if the two integers are equal, `false` otherwise.
fn i129_eq(a: i129, b: i129) -> bool {
    // Check if the two integers have the same sign and the same absolute value.
    if a.sign == b.sign & a.inner == b.inner {
        return true;
    }

    return false;
}

// Compares two i129 integers for inequality.
// # Arguments
// * `a` - The first i129 integer to compare.
// * `b` - The second i129 integer to compare.
// # Returns
// * `bool` - `true` if the two integers are not equal, `false` otherwise.
fn i129_ne(a: i129, b: i129) -> bool {
    // The result is the inverse of the equal function.
    return !i129_eq(a, b);
}

// Implements the PartialEq trait for i129.
impl i129PartialEq of PartialEq::<i129> {
    fn eq(a: i129, b: i129) -> bool {
        i129_eq(a, b)
    }

    fn ne(a: i129, b: i129) -> bool {
        i129_ne(a, b)
    }
}

// Compares two i129 integers for greater than.
// # Arguments
// * `a` - The first i129 integer to compare.
// * `b` - The second i129 integer to compare.
// # Returns
// * `bool` - `true` if `a` is greater than `b`, `false` otherwise.
fn i129_gt(a: i129, b: i129) -> bool {
    // Check if `a` is negative and `b` is positive.
    if (a.sign & !b.sign) {
        return false;
    }
    // Check if `a` is positive and `b` is negative.
    if (!a.sign & b.sign) {
        return true;
    }
    // If `a` and `b` have the same sign, compare their absolute values.
    if (a.sign & b.sign) {
        return a.inner < b.inner;
    } else {
        return a.inner > b.inner;
    }
}

// Determines whether the first i129 is less than the second i129.
// # Arguments
// * `a` - The i129 to compare against the second i129.
// * `b` - The i129 to compare against the first i129.
// # Returns
// * `bool` - `true` if `a` is less than `b`, `false` otherwise.
fn i129_lt(a: i129, b: i129) -> bool {
    // The result is the inverse of the greater than function.
    return !i129_gt(a, b);
}

// Checks if the first i129 integer is less than or equal to the second.
// # Arguments
// * `a` - The first i129 integer to compare.
// * `b` - The second i129 integer to compare.
// # Returns
// * `bool` - `true` if `a` is less than or equal to `b`, `false` otherwise.
fn i129_le(a: i129, b: i129) -> bool {
    if (a == b | i129_lt(a, b) == true) {
        return true;
    } else {
        return false;
    }
}

// Checks if the first i129 integer is greater than or equal to the second.
// # Arguments
// * `a` - The first i129 integer to compare.
// * `b` - The second i129 integer to compare.
// # Returns
// * `bool` - `true` if `a` is greater than or equal to `b`, `false` otherwise.
fn i129_ge(a: i129, b: i129) -> bool {
    if (a == b | i129_gt(a, b) == true) {
        return true;
    } else {
        return false;
    }
}

// Implements the PartialOrd trait for i129.
impl i129PartialOrd of PartialOrd::<i129> {
    fn le(a: i129, b: i129) -> bool {
        i129_le(a, b)
    }
    fn ge(a: i129, b: i129) -> bool {
        i129_ge(a, b)
    }

    fn lt(a: i129, b: i129) -> bool {
        i129_lt(a, b)
    }
    fn gt(a: i129, b: i129) -> bool {
        i129_gt(a, b)
    }
}

// Negates the given i129 integer.
// # Arguments
// * `x` - The i129 integer to negate.
// # Returns
// * `i129` - The negation of `x`.
fn i129_neg(x: i129) -> i129 {
    // The negation of an integer is obtained by flipping its sign.
    return i129 { inner: x.inner, sign: !x.sign };
}

// Implements the Neg trait for i129.
impl i129Neg of Neg::<i129> {
    fn neg(x: i129) -> i129 {
        i129_neg(x)
    }
}

// Computes the absolute value of the given i129 integer.
// # Arguments
// * `x` - The i129 integer to compute the absolute value of.
// # Returns
// * `i129` - The absolute value of `x`.
fn i129_abs(x: i129) -> i129 {
    return i129 { inner: x.inner, sign: false };
}

// Computes the maximum between two i129 integers.
// # Arguments
// * `a` - The first i129 integer to compare.
// * `b` - The second i129 integer to compare.
// # Returns
// * `i129` - The maximum between `a` and `b`.
fn i129_max(a: i129, b: i129) -> i129 {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

// Computes the minimum between two i129 integers.
// # Arguments
// * `a` - The first i129 integer to compare.
// * `b` - The second i129 integer to compare.
// # Returns
// * `i129` - The minimum between `a` and `b`.
fn i129_min(a: i129, b: i129) -> i129 {
    if (a < b) {
        return a;
    } else {
        return b;
    }
}
