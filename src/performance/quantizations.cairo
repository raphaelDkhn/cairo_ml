//  8 BIT LINEAR-QUANTIZATION
//  https://onnxruntime.ai/docs/performance/quantization.html#quantization-overview

use array::ArrayTrait;
use option::OptionTrait;
use cairo_ml::math::int32::i32;
use cairo_ml::math::int32::sub;
use cairo_ml::math::int32::mul;
use cairo_ml::math::int32::div_no_rem;
use cairo_ml::math::int32::max;
use cairo_ml::math::int32::abs;
use cairo_ml::math::vector::find_min_max;

impl Arrayi32Drop of Drop::<Array::<i32>>;

fn symetric_quant(min_val: i32, max_val: i32, data: i32) -> i32 {
    //  Define quantization range
    //  int8 range : [-127;127] 
    let q_min_int = i32 { inner: 127_u32, sign: true };
    let q_max_int = i32 { inner: 127_u32, sign: false };

    let factor = i32 { inner: 1000_u32, sign: false };
    let min_val = mul(min_val, factor);
    let max_val = mul(max_val, factor);

    //  Calculate the scale based on 8 bit symetric quantization
    //  scale = max(abs(data_range_max), abs(data_range_min)) * 2 / (quantization_range_max - quantization_range_min)
    let scale = div_no_rem(
        mul(max(abs(min_val), abs(max_val)), i32 { inner: 2_u32, sign: false }),
        sub(q_max_int, q_min_int)
    );

    //  Quantize data based on the scale
    let quantized_data = div_no_rem(mul(data, factor), scale);

    assert(quantized_data.inner <= 127_u32, 'out of range');

    return quantized_data;
}

fn quant_vec(ref vec: Array::<i32>) -> Array::<i32> {
    let mut result = ArrayTrait::new();

    let (mut min_val, mut max_val) = find_min_max(ref vec);

    __quant_vec(ref min_val, ref max_val, ref vec, ref result, 0_usize);

    return result;
}

fn __quant_vec(
    ref min_val: i32, ref max_val: i32, ref vec: Array::<i32>, ref result: Array::<i32>, n: usize
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
    if n == vec.len() {
        return ();
    }

    // --- Quantize data and append to the result vector --- 
    let quantized = symetric_quant(min_val, max_val, *vec.at(n));
    result.append(quantized);

    // --- The process is repeated for the remaining elemets in the array --- 
    __quant_vec(ref min_val, ref max_val, ref vec, ref result, n + 1_usize)
}

