use traits::Into;
use traits::TryInto;
use option::OptionTrait;

/// Conversion from `u64` to `u128`.
fn u32_to_u128(a: u32) -> u128 {
    let felt = a.into();
    felt.try_into().unwrap()
}