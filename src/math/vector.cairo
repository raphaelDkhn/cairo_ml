use array::ArrayTrait;
use option::OptionTrait;
use traits::Into;
use cairo_ml::math::signed_integers;
use cairo_ml::math::signed_integers::i33_min;
use cairo_ml::math::signed_integers::i33_max;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::fixed_point::core;
use cairo_ml::fixed_point::core::Fixed;
use cairo_ml::fixed_point::core::FixedType;
use cairo_ml::utils::u32_to_u128;

//=================================================//
//=================== SUM VECTORS =================//
//=================================================//

// Sums two vectors of the same size.
// # Arguments
// * vec1 - An Array of i33 integers to be summed with vec2.
// * vec2 - An Array of i33 integers to be summed with vec1.
// # Returns
// * Array::<i33> - An Array containing the result of the element-wise sum of vec1 and vec2.
// # Panics
// * If vec1 and vec2 have different lengths.
fn sum_two_vec(vec1: @Array::<i33>, vec2: @Array::<i33>) -> Array::<i33> {
    assert(vec1.len() == vec2.len(), 'Vectors must have the same size');

    // Initialize variables.
    let mut result = ArrayTrait::new();

    __sum_two_vec(vec1, vec2, ref result, 0_usize);

    return result;
}

fn __sum_two_vec(vec1: @Array::<i33>, vec2: @Array::<i33>, ref result: Array::<i33>, n: usize, ) {
    // TODO: Remove when automatically handled by compiler.
    match try_fetch_gas() {
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
    __sum_two_vec(vec1, vec2, ref result, n + 1_usize);
}

//=================================================//
//=================== DOT VECTORS =================//
//=================================================//

// Computes the dot product between two i33 vectors.
// # Arguments
// * vec1 - The first vector.
// * vec2 - The second vector.
// # Returns
// * i33 - The dot product between vec1 and vec2.
// # Panics
// This function will panic if vec1 and vec2 have different lengths.
fn vec_dot_vec(vec1: @Array::<i33>, vec2: @Array::<i33>) -> i33 {
    assert(vec1.len() == vec2.len(), 'Vectors must have the same size');

    // Initialize variables.
    let mut sum = i33 { inner: 0_usize, sign: false };
    let result = __vec_dot_vec(vec1, vec2, 0_usize, sum);

    return result;
}

fn __vec_dot_vec(vec1: @Array::<i33>, vec2: @Array::<i33>, index: usize, mut sum: i33) -> i33 {
    // TODO: Remove when automatically handled by compiler.
    match try_fetch_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    if index == vec1.len() {
        sum
    } else {
        __vec_dot_vec(vec1, vec2, index + 1_usize, sum + *vec1.at(index) * *vec2.at(index))
    }
}

//=================================================//
//=================== FIND IN VECTOR ==============//
//=================================================//

// Finds the minimum and maximum values in an Array of i33 integers.
// # Arguments
// * vec - An Array of i33 integers.
// # Returns
// * (i33, i33) - A tuple containing the minimum and maximum values found in the input array.
fn find_min_max(vec: @Array::<i33>) -> (i33, i33) {
    // Initialize variables.
    let mut min_value = i33 { inner: 65535_u32, sign: false };
    let mut max_value = i33 { inner: 65535_u32, sign: true };

    __find_min_max(vec, ref min_value, ref max_value, 0_usize, );

    return (min_value, max_value);
}

fn __find_min_max(vec: @Array::<i33>, ref min_value: i33, ref max_value: i33, n: usize, ) {
    // TODO: Remove when automatically handled by compiler.
    match try_fetch_gas() {
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
    let check_min = i33_min(min_value, *vec.at(n));
    if (min_value != check_min) {
        min_value = check_min;
    }

    // --- Check the maximum value and update max_value if necessary --- 
    let check_max = i33_max(max_value, *vec.at(n));
    if (max_value != check_max) {
        max_value = check_max;
    }

    // --- The process is repeated for the remaining elemets in the array --- 
    __find_min_max(vec, ref min_value, ref max_value, n + 1_usize);
}

// Finds the maximum value in an Array of i33 integers.
// # Arguments
// * vec - An Array of i33 integers.
// # Returns
// * i33 - The maximum value found in the input array.
fn find_max(vec: @Array::<i33>) -> i33 {
    // Initialize variables.
    let mut max_value = i33 { inner: 65535_u32, sign: true };

    __find_max(vec, ref max_value, 0_usize, );

    return (max_value);
}

fn __find_max(vec: @Array::<i33>, ref max_value: i33, n: usize, ) {
    // TODO: Remove when automatically handled by compiler.
    match try_fetch_gas() {
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

    // --- Check the maximum value and update max_value if necessary --- 
    let check_max = i33_max(max_value, *vec.at(n));
    if (max_value != check_max) {
        max_value = check_max;
    }

    // --- The process is repeated for the remaining elemets in the array --- 
    __find_max(vec, ref max_value, n + 1_usize);
}

//=================================================//
//=================== SLICE VECTOR ================//
//=================================================//

// Slices an Array of i33 integers from a start index to an end index.
// # Arguments
// * vec - A reference to an Array of i33 integers to slice.
// * start_index - The index to start the slice from.
// * end_index - The index to end the slice at.
// # Returns
// * Array::<i33> - An Array of i33 integers containing the sliced values.
fn slice_vec(vec: @Array::<i33>, start_index: usize, end_index: usize) -> Array::<i33> {
    let mut result = ArrayTrait::new();
    __slice_vec(vec, end_index, ref result, start_index);

    return result;
}

fn __slice_vec(vec: @Array::<i33>, end_index: usize, ref result: Array::<i33>, n: usize) {
    // TODO: Remove when automatically handled by compiler.
    match try_fetch_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    if (n == end_index) {
        return ();
    }

    result.append(*vec.at(n));
    __slice_vec(vec, end_index, ref result, n + 1_usize);
}

//=================================================//
//=================== CONCAT VECTORS ==============//
//=================================================//

// Concatenates two Arrays of i33 integers.
// # Arguments
// * vec1 - The first Array of i33 integers to concatenate.
// * vec2 - The second Array of i33 integers to concatenate.
// # Returns
// * Array::<i33> - An Array of i33 integers containing the concatenated values.
fn concat_vectors(vec1: Array::<i33>, vec2: Array::<i33>) -> Array::<i33> {
    let mut result = vec1;
    __concat_vectors(vec2, ref result, 0_usize);

    return result;
}

fn __concat_vectors(vec: Array::<i33>, ref result: Array::<i33>, n: usize) {
    // TODO: Remove when automatically handled by compiler.
    match try_fetch_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = array_new::<felt>();
            array_append::<felt>(ref data, 'OOG');
            panic(data);
        },
    }

    if (n == vec.len()) {
        return ();
    }

    result.append(*vec.at(n));
    __concat_vectors(vec, ref result, n + 1_usize);
}

//=================================================//
//=================== EXP OF VECTOR ===============//
//=================================================//

// Calculate the exponential of all elements in the input array
// # Arguments
// * vec - A reference to an Array of i33.
// # Returns
// * Array::<FixedType> - An Array of Fixed Point containing the exp values.
fn vec_exp(vec: @Array::<i33>) -> Array::<FixedType> {
    // Initialize variables.
    let mut result = ArrayTrait::new();

    __vec_exp(vec, ref result, 0_usize);

    return result;
}

fn __vec_exp(vec: @Array::<i33>, ref result: Array::<FixedType>, n: usize) {
    // TODO: Remove when automatically handled by compiler.
    match try_fetch_gas() {
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

    let fp_value = Fixed::new_unscaled(u32_to_u128(*vec.at(n).inner), *vec.at(n).sign);

    let exp = result.append(fp_value.exp());

    __vec_exp(vec, ref result, n + 1_usize)
}

//=================================================//
//============== SUM VALUES  IN VECTOR ============//
//=================================================//

// Calculate the sum of all fixed point values in the input array
// # Arguments
// * vec - A reference to an Array of fixed points.
// # Returns
// * FixedType - A Fixed Point representing the sum of all fixed point values in the input array.
fn sum_vec_values_fp(vec: @Array::<FixedType>) -> FixedType {
    // Initialize variables.
    let mut sum = Fixed::new_unscaled(0_u128, false);

    __sum_vec_values_fp(vec, ref sum, 0_usize);

    return sum;
}

fn __sum_vec_values_fp(vec: @Array::<FixedType>, ref sum: FixedType, n: usize) {
    // TODO: Remove when automatically handled by compiler.
    match try_fetch_gas() {
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

    sum += *vec.at(n);

    __sum_vec_values_fp(vec, ref sum, n + 1_usize);
}
