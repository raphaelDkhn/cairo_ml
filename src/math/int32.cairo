mod Int32 {

    #[derive(Copy, Drop)]
    struct i32 {
        inner: u32,
        sign: bool,
    }

    fn add(a: i32, b: i32) -> i32 {
        if a.sign == b.sign {
            // If the signs are the same, add the magnitudes and return the result with the same sign
            let sum = a.inner + b.inner;
            return i32 { inner: sum, sign: a.sign };
        } else {
            // If the signs are different, subtract the smaller magnitude from the larger magnitude
            // and return the result with the sign of the larger magnitude
            let (larger, smaller) = if a.inner >= b.inner {
                (a, b)
            } else {
                (b, a)
            };
            let difference = larger.inner - smaller.inner;

            if difference == 0_u32 {
                return i32 { inner: 0_u32, sign: false };
            } else {
                return i32 { inner: difference, sign: larger.sign };
            }
        }
    }

    fn sub(a: i32, b: i32) -> i32 {
        let neg_b = i32 { inner: b.inner, sign: !b.sign };
        add(a, neg_b)
    }


    fn mul(a: i32, b: i32) -> i32 {
        if (a.inner == 0_u32 | b.inner == 0_u32) {
            return i32 { inner: 0_u32, sign: false };
        }

        let sign = a.sign ^ b.sign;
        let inner = a.inner * b.inner;
        return i32 { inner, sign };
    }

    fn modulo(a: i32, b: i32) -> i32 {
        return sub(a, mul(b, div_no_rem(a, b)));
    }

    fn div_no_rem(a: i32, b: i32) -> i32 {
        if (a.inner == 0_u32) {
            return i32 { inner: 0_u32, sign: false };
        }

        let sign = a.sign ^ b.sign;

        if (sign == false) {
            return i32 { inner: a.inner / b.inner, sign: sign };
        }

        //check if result is integer 
        if (a.inner % b.inner == 0_u32) {
            return i32 { inner: a.inner / b.inner, sign: sign };
        }

        let quotient = (a.inner * 10_u32) / b.inner;
        let last_digit = quotient % 10_u32;

        if (last_digit <= 5_u32) {
            return i32 { inner: quotient / 10_u32, sign: sign };
        } else {
            return i32 { inner: (quotient / 10_u32) + 1_u32, sign: sign };
        }
    }

    fn div_rem(a: i32, b: i32) -> (i32, i32) {
        let quotient = div_no_rem(a, b);
        let remainder = modulo(a, b);

        return (quotient, remainder);
    }

    fn max(a: i32, b: i32) -> i32 {
        if (a.sign & !b.sign) {
            return b;
        }
        if (!a.sign & b.sign) {
            return a;
        }
        if (a.sign & b.sign) {
            if (a.inner < b.inner) {
                return a;
            } else {
                return b;
            }
        } else {
            if a.inner > b.inner {
                return a;
            } else {
                return b;
            }
        }
    }

    fn min(a: i32, b: i32) -> i32 {
        if (a.sign & !b.sign) {
            return a;
        }
        if (!a.sign & b.sign) {
            return b;
        }
        if (a.sign & b.sign) {
            if (a.inner > b.inner) {
                return a;
            } else {
                return b;
            }
        } else {
            if a.inner < b.inner {
                return a;
            } else {
                return b;
            }
        }
    }

    fn not_equal(a: i32, b: i32) -> bool {
        if a.sign != b.sign | a.inner != b.inner {
            return true;
        }

        return false;
    }

    fn abs(x: i32) -> i32 {
        return i32 { inner: x.inner, sign: false };
    }
}

