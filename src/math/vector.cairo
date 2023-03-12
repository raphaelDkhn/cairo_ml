use array::ArrayTrait;
use cairo_ml::math::int33;
use cairo_ml::math::int33::i33;

impl Arrayi33Drop of Drop::<Array::<i33>>;

//=================================================//
//=================== SUM VECTORS =================//
//=================================================//

fn sum_two_vec(vec1: Array::<i33>, vec2: Array::<i33>) -> Array::<i33> {
    assert(vec1.len() == vec2.len(), 'Vectors must have the same size');

    // Initialize variables.
    let mut _vec1 = vec1;
    let mut _vec2 = vec2;
    let mut result = ArrayTrait::new();

    __sum_two_vec(ref _vec1, ref _vec2, ref result, 0_usize);

    return result;
}

fn __sum_two_vec(
    ref vec1: Array::<i33>, ref vec2: Array::<i33>, ref result: Array::<i33>, n: usize, 
) {
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

    // --- End of the recursion ---
    if n == vec1.len() {
        return ();
    }

    // --- Sum and assign the result to the current index ---
    result.append(*vec1.at(n) + *vec2.at(n));

    // --- The process is repeated for the remaining elemets in the array --- 
    __sum_two_vec(ref vec1, ref vec2, ref result, n + 1_usize);
}

//=================================================//
//=================== DOT VECTORS =================//
//=================================================//

fn vec_dot_vec(vec1: Array::<i33>, vec2: Array::<i33>) -> i33 {
    assert(vec1.len() == vec2.len(), 'Vectors must have the same size');

    // Initialize variables.
    let mut _vec1 = vec1;
    let mut _vec2 = vec2;
    let result = __vec_dot_vec(ref _vec1, ref _vec2, 0_usize);

    return result;
}

fn __vec_dot_vec(ref vec1: Array::<i33>, ref vec2: Array::<i33>, n: usize) -> i33 {
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

    // --- End of the recursion ---
    if (n == vec1.len()) {
        return (i33 { inner: 0_u32, sign: false });
    }

    // --- Calculates the product ---
    let ele = *vec1.at(n);
    let result = ele * (*vec2.at(n));

    let acc = __vec_dot_vec(ref vec1, ref vec2, n + 1_usize);

    // --- Returns the sum of the current product with the previous ones ---
    return acc + result;
}

//=================================================//
//=================== FIND IN VECTOR ==============//
//=================================================//

fn find_min_max(ref vec: Array::<i33>) -> (i33, i33) {
    // Initialize variables.
    let mut min_value = i33 { inner: 65535_u32, sign: false };
    let mut max_value = i33 { inner: 65535_u32, sign: true };

    __find_min_max(ref vec, ref min_value, ref max_value, 0_usize, );

    return (min_value, max_value);
}

fn __find_min_max(ref vec: Array::<i33>, ref min_value: i33, ref max_value: i33, n: usize, ) {
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
    // --- End of the recursion ---
    if n == vec.len() {
        return ();
    }

    // --- Check the minimum value and update min_value if necessary --- 
    let check_min = int33::min(min_value, *vec.at(n));
    if (min_value != check_min) {
        min_value = check_min;
    }

    // --- Check the maximum value and update max_value if necessary --- 
    let check_max = int33::max(max_value, *vec.at(n));
    if (max_value != check_max) {
        max_value = check_max;
    }

    // --- The process is repeated for the remaining elemets in the array --- 
    __find_min_max(ref vec, ref min_value, ref max_value, n + 1_usize);
}
