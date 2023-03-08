use array::ArrayTrait;

use cairo_ml::math::int32::i32;
use cairo_ml::math::int32::add;
use cairo_ml::math::int32::min;
use cairo_ml::math::int32::max;
use cairo_ml::math::int32::not_equal;

impl Arrayi32Drop of Drop::<Array::<i32>>;

//=================================================//
//=================== SUM VECTORS =================//
//=================================================//

fn sum_two_vec(vec1: Array::<i32>, vec2: Array::<i32>) -> Array::<i32> {
    // Initialize variables.
    let mut _vec1 = vec1;
    let mut _vec2 = vec2;
    let mut result = ArrayTrait::new();

    __sum_two_vec(ref _vec1, ref _vec2, ref result, 0_usize);

    return result;
}

fn __sum_two_vec(
    ref vec1: Array::<i32>, ref vec2: Array::<i32>, ref result: Array::<i32>, n: usize, 
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

    assert(vec1.len() == vec2.len(), 'Vectors must have the same size');

    // --- End of the recursion ---
    if n == vec1.len() {
        return ();
    }

    // --- Sum and assign the result to the current index ---
    result.append(add(*vec1.at(n), *vec2.at(n)));

    // --- The process is repeated for the remaining elemets in the array --- 
    __sum_two_vec(ref vec1, ref vec2, ref result, n + 1_usize);
}


//=================================================//
//=================== FIND IN VECTOR ==============//
//=================================================//

fn find_min_max(ref vec: Array::<i32>) -> (i32, i32) {
    // Initialize variables.
    let mut min_value = i32 { inner: 65535_u32, sign: false };
    let mut max_value = i32 { inner: 65535_u32, sign: true };

    __find_min_max(ref vec, ref min_value, ref max_value, 0_usize, );

    return (min_value, max_value);
}

fn __find_min_max(ref vec: Array::<i32>, ref min_value: i32, ref max_value: i32, n: usize, ) {
    
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
    let check_min = min(min_value, *vec.at(n));
    if not_equal(min_value, check_min) {
        min_value = check_min;
    }

    // --- Check the maximum value and update max_value if necessary --- 
    let check_max = max(max_value, *vec.at(n));
    if not_equal(max_value, check_max) {
        max_value = check_max;
    }

    // --- The process is repeated for the remaining elemets in the array --- 
    __find_min_max(ref vec, ref min_value, ref max_value, n + 1_usize);
}
