#[derive(Copy, Drop)]
struct i32 {
    inner: u32,
    sign: bool,
}

fn __add(a: i32, b: i32) -> i32 {
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

impl I32Add of Add::<i32> {
    fn add(a: i32, b: i32) -> i32 {
        __add(a, b)
    }
}


fn __sub(a: i32, b: i32) -> i32 {
    let neg_b = i32 { inner: b.inner, sign: !b.sign };
    a + neg_b
}

impl I32Sub of Sub::<i32> {
    fn sub(a: i32, b: i32) -> i32 {
        __sub(a, b)
    }
}


fn __mul(a: i32, b: i32) -> i32 {
    if (a.inner == 0_u32 | b.inner == 0_u32) {
        return i32 { inner: 0_u32, sign: false };
    }

    let sign = a.sign ^ b.sign;
    let inner = a.inner * b.inner;
    return i32 { inner, sign };
}

impl I32Mul of Mul::<i32> {
    fn mul(a: i32, b: i32) -> i32 {
        __mul(a, b)
    }
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

impl I32Div of Div::<i32> {
    fn div(a: i32, b: i32) -> i32 {
        div_no_rem(a, b)
    }
}

fn modulo(a: i32, b: i32) -> i32 {
    return a - (b * (a / b));
}

impl I32Rem of Rem::<i32> {
    fn rem(a: i32, b: i32) -> i32 {
        modulo(a, b)
    }
}

fn div_rem(a: i32, b: i32) -> (i32, i32) {
    let quotient = div_no_rem(a, b);
    let remainder = modulo(a, b);

    return (quotient, remainder);
}

fn __eq(a: i32, b: i32) -> bool {
    if a.sign == b.sign & a.inner == b.inner {
        return true;
    }

    return false;
}

fn __ne(a: i32, b: i32) -> bool {
    if a.sign != b.sign | a.inner != b.inner {
        return true;
    }

    return false;
}

impl I32PartialEq of PartialEq::<i32> {
    fn eq(a: i32, b: i32) -> bool {
        __eq(a, b)
    }

    fn ne(a: i32, b: i32) -> bool {
        __ne(a, b)
    }
}

fn __gt(a: i32, b: i32) -> bool {
    if (a.sign & !b.sign) {
        return false;
    }
    if (!a.sign & b.sign) {
        return true;
    }
    if (a.sign & b.sign) {
        return a.inner < b.inner;
    } else {
        return a.inner > b.inner;
    }
}

fn __lt(a: i32, b: i32) -> bool {
    if (a.sign & !b.sign) {
        return true;
    }
    if (!a.sign & b.sign) {
        return false;
    }
    if (a.sign & b.sign) {
        return a.inner > b.inner;
    } else {
        return a.inner < b.inner;
    }
}

fn __le(a: i32, b: i32) -> bool {
    if (a == b | __lt(a, b) == true) {
        return true;
    } else {
        return false;
    }
}

fn __ge(a: i32, b: i32) -> bool {
    if (a == b | __gt(a, b) == true) {
        return true;
    } else {
        return false;
    }
}

impl I32PartialOrd of PartialOrd::<i32> {
    fn le(a: i32, b: i32) -> bool {
        __le(a, b)
    }
    fn ge(a: i32, b: i32) -> bool {
        __ge(a, b)
    }

    fn lt(a: i32, b: i32) -> bool {
        __lt(a, b)
    }
    fn gt(a: i32, b: i32) -> bool {
        __gt(a, b)
    }
}

fn __neg(x: i32) -> i32 {
    return i32 { inner: x.inner, sign: !x.sign };
}

impl I32Neg of Neg::<i32> {
    fn neg(x: i32) -> i32 {
        __neg(x)
    }
}

fn abs(x: i32) -> i32 {
    return i32 { inner: x.inner, sign: false };
}

fn max(a: i32, b: i32) -> i32 {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

fn min(a: i32, b: i32) -> i32 {
    if (a < b) {
        return a;
    } else {
        return b;
    }
}