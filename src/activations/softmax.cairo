use array::ArrayTrait;
use cairo_ml::math::signed_integers::i33;
use cairo_ml::fixed_point::core;
use cairo_ml::fixed_point::core::Fixed;
use cairo_ml::fixed_point::core::FixedType;
use cairo_ml::utils::u32_to_u128;
use cairo_ml::math::vector::vec_exp;
use cairo_ml::math::vector::sum_vec_values_fp;

impl ArrayFPDrop of Drop::<Array::<FixedType>>;

//  Softax.
// # Arguments
// * vec - a reference to an array of i33.
// # Returns
// * an array of fixed points representing the softmax of the reference vector.
fn softmax(vec: @Array::<i33>) -> Array::<FixedType> {
    // Initialize variables.
    let exp_vec = vec_exp(vec);
    let sum_exp = sum_vec_values_fp(@exp_vec);
    let mut result = ArrayTrait::new();

    __softmax(@exp_vec, sum_exp, ref result, 0_usize);

    return result;
}

fn __softmax(
    exp_vec: @Array::<FixedType>, sum_exp: FixedType, ref result: Array::<FixedType>, n: usize
) {
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
    if n == exp_vec.len() {
        return ();
    }
    let res = *exp_vec.at(n) / sum_exp;

    result.append(res);
    __softmax(exp_vec, sum_exp, ref result, n + 1_usize);
}
