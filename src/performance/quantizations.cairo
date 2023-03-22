//  8 BIT LINEAR-QUANTIZATION
//  https://onnxruntime.ai/docs/performance/quantization.html#quantization-overview

use array::ArrayTrait;
use option::OptionTrait;
use cairo_ml::math::signed_integers;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::math::signed_integers::i33_max;
use cairo_ml::math::signed_integers::i33_abs;
use cairo_ml::math::vector::find_min_max;
use cairo_ml::utils::check_gas;

// Performs 8-bit symmetric quantization on an integer.
// # Arguments
// * min_val - The minimum value in the dataset.
// * max_val - The maximum value in the dataset.
// * data - The value to be quantized.
// # Returns
// * i33 - The quantized value.
// # Panics
// * If the quantized data value is greater than 127, indicating 
// that it is out of the range of an 8-bit integer.
fn symetric_quant(min_val: i33, max_val: i33, data: i33) -> i33 {
    //  Define quantization range
    //  int8 range : [-127;127] 
    let q_min_int = i33 { inner: 127_u32, sign: true };
    let q_max_int = i33 { inner: 127_u32, sign: false };

    let factor = i33 { inner: 1000_u32, sign: false };
    let min_val = min_val * factor;
    let max_val = max_val * factor;

    //  Calculate the scale based on 8 bit symetric quantization
    //  scale = max(abs(data_range_max), abs(data_range_min)) * 2 / (quantization_range_max - quantization_range_min)
    let scale = (i33_max(i33_abs(min_val), i33_abs(max_val)) * i33 { inner: 2_u32, sign: false })
        / (q_max_int - q_min_int);

    //  Quantize data based on the scale
    let quantized_data = (data * factor) / scale;

    assert(quantized_data.inner <= 127_u32, 'out of range');

    return quantized_data;
}

// Quantizes all values in an i33 array to 8-bit integers based 
// on the minimum and maximum values in the array.
// # Arguments
// * vec - The array of i33 values to be quantized.
// # Returns
// * Array::<i33> - The quantized array of i33 values.
// The returned array has the same size as the input array.
fn quant_vec(ref vec: Array::<i33>) -> Array::<i33> {
    let mut result = ArrayTrait::new();

    let (mut min_val, mut max_val) = find_min_max(ref vec);

    __quant_vec(ref min_val, ref max_val, ref vec, ref result, 0_usize);

    return result;
}

fn __quant_vec(
    ref min_val: i33, ref max_val: i33, ref vec: Array::<i33>, ref result: Array::<i33>, n: usize
) {
    check_gas();

    // --- End of the recursion ---
    if n == vec.len() {
        return ();
    }

    // --- Quantize data and append to the result vector --- 
    let quantized = symetric_quant(min_val, max_val, *vec.at(n));
    result.append(quantized);

    // --- The process is repeated for the remaining elemets in the array --- 
    __quant_vec(ref min_val, ref max_val, ref vec, ref result, n + 1_usize)
}

