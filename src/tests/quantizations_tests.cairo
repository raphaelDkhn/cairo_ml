use array::ArrayTrait;

use cairo_ml::math::int32::i32;
use cairo_ml::performance::quantizations::quant_vec;
use debug::print_felt;

impl Arrayi32Drop of Drop::<Array::<i32>>;

#[test]
#[available_gas(2000000)]
fn quant_vec_test() {
    let mut vec = ArrayTrait::new();
    vec.append(i32 { inner: 30523_u32, sign: true });
    vec.append(i32 { inner: 24327_u32, sign: false });
    vec.append(i32 { inner: 12288_u32, sign: true });
    vec.append(i32 { inner: 29837_u32, sign: false });
    vec.append(i32 { inner: 19345_u32, sign: true });
    vec.append(i32 { inner: 15416_u32, sign: false });

    let mut res = quant_vec(ref vec);

    assert(*res.at(0_usize).inner == 127_u32, 'result[0] == -127');
    assert(*res.at(0_usize).sign == true, 'result[0] -> negative');

    assert(*res.at(1_usize).inner == 101_u32, 'result[1] == 101');
    assert(*res.at(1_usize).sign == false, 'result[1] -> positive');

    assert(*res.at(2_usize).inner == 51_u32, 'result[2] == -51');
    assert(*res.at(2_usize).sign == true, 'result[2] -> negative');

    assert(*res.at(3_usize).inner == 124_u32, 'result[3] == 124');
    assert(*res.at(3_usize).sign == false, 'result[3] -> positive');

    assert(*res.at(4_usize).inner == 80_u32, 'result[4] == -80');
    assert(*res.at(4_usize).sign == true, 'result[4] -> negative');

    assert(*res.at(5_usize).inner == 64_u32, 'result[5] == 64');
    assert(*res.at(5_usize).sign == false, 'result[5] -> positive');
}
