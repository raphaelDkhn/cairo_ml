use array::ArrayTrait;
use cairo_ml::math::matrix::Matrix;
use cairo_ml::math::matrix::matrix_new;
use cairo_ml::math::signed_integers::i33;

fn conv1_weight() -> Array::<Array::<Matrix>> {

    let mut kernels = ArrayTrait::new();
    // KERNEL_1
    let mut kernel_1 = ArrayTrait::new();

    let mut kernel_1_matrix_1_data = ArrayTrait::new();
    kernel_1_matrix_1_data.append(i33 { inner: 55_u32, sign: false });
    kernel_1_matrix_1_data.append(i33 { inner: 5_u32, sign: true });
    kernel_1_matrix_1_data.append(i33 { inner: 98_u32, sign: true });
    kernel_1_matrix_1_data.append(i33 { inner: 127_u32, sign: true });
    kernel_1_matrix_1_data.append(i33 { inner: 2_u32, sign: true });
    kernel_1_matrix_1_data.append(i33 { inner: 4_u32, sign: false });
    kernel_1_matrix_1_data.append(i33 { inner: 15_u32, sign: true });
    kernel_1_matrix_1_data.append(i33 { inner: 40_u32, sign: false });
    kernel_1_matrix_1_data.append(i33 { inner: 45_u32, sign: false });
    kernel_1_matrix_1_data.append(i33 { inner: 33_u32, sign: true });
    kernel_1_matrix_1_data.append(i33 { inner: 21_u32, sign: false });
    kernel_1_matrix_1_data.append(i33 { inner: 91_u32, sign: false });
    kernel_1_matrix_1_data.append(i33 { inner: 104_u32, sign: false });
    kernel_1_matrix_1_data.append(i33 { inner: 61_u32, sign: true });
    kernel_1_matrix_1_data.append(i33 { inner: 2_u32, sign: false });
    kernel_1_matrix_1_data.append(i33 { inner: 28_u32, sign: false });
    kernel_1_matrix_1_data.append(i33 { inner: 104_u32, sign: false });
    kernel_1_matrix_1_data.append(i33 { inner: 80_u32, sign: false });
    kernel_1_matrix_1_data.append(i33 { inner: 39_u32, sign: true });
    kernel_1_matrix_1_data.append(i33 { inner: 104_u32, sign: true });
    kernel_1_matrix_1_data.append(i33 { inner: 44_u32, sign: true });
    kernel_1_matrix_1_data.append(i33 { inner: 19_u32, sign: true });
    kernel_1_matrix_1_data.append(i33 { inner: 4_u32, sign: false });
    kernel_1_matrix_1_data.append(i33 { inner: 40_u32, sign: true });
    kernel_1_matrix_1_data.append(i33 { inner: 30_u32, sign: true });

    let kernel_1_matrix_1 = matrix_new(5_usize, 5_usize, kernel_1_matrix_1_data);
    kernel_1.append(kernel_1_matrix_1);

    kernels.append(kernel_1);

    // KERNEL_2
    let mut kernel_2 = ArrayTrait::new();

    let mut kernel_2_matrix_1_data = ArrayTrait::new();
    kernel_2_matrix_1_data.append(i33 { inner: 76_u32, sign: true });
    kernel_2_matrix_1_data.append(i33 { inner: 127_u32, sign: true });
    kernel_2_matrix_1_data.append(i33 { inner: 113_u32, sign: true });
    kernel_2_matrix_1_data.append(i33 { inner: 78_u32, sign: true });
    kernel_2_matrix_1_data.append(i33 { inner: 58_u32, sign: true });
    kernel_2_matrix_1_data.append(i33 { inner: 29_u32, sign: true });
    kernel_2_matrix_1_data.append(i33 { inner: 79_u32, sign: true });
    kernel_2_matrix_1_data.append(i33 { inner: 64_u32, sign: true });
    kernel_2_matrix_1_data.append(i33 { inner: 8_u32, sign: true });
    kernel_2_matrix_1_data.append(i33 { inner: 22_u32, sign: false });
    kernel_2_matrix_1_data.append(i33 { inner: 59_u32, sign: false });
    kernel_2_matrix_1_data.append(i33 { inner: 21_u32, sign: false });
    kernel_2_matrix_1_data.append(i33 { inner: 9_u32, sign: true });
    kernel_2_matrix_1_data.append(i33 { inner: 63_u32, sign: false });
    kernel_2_matrix_1_data.append(i33 { inner: 11_u32, sign: true });
    kernel_2_matrix_1_data.append(i33 { inner: 60_u32, sign: false });
    kernel_2_matrix_1_data.append(i33 { inner: 64_u32, sign: false });
    kernel_2_matrix_1_data.append(i33 { inner: 72_u32, sign: false });
    kernel_2_matrix_1_data.append(i33 { inner: 35_u32, sign: false });
    kernel_2_matrix_1_data.append(i33 { inner: 18_u32, sign: false });
    kernel_2_matrix_1_data.append(i33 { inner: 56_u32, sign: false });
    kernel_2_matrix_1_data.append(i33 { inner: 50_u32, sign: false });
    kernel_2_matrix_1_data.append(i33 { inner: 39_u32, sign: false });
    kernel_2_matrix_1_data.append(i33 { inner: 7_u32, sign: false });
    kernel_2_matrix_1_data.append(i33 { inner: 38_u32, sign: false });

    let kernel_2_matrix_1 = matrix_new(5_usize, 5_usize, kernel_2_matrix_1_data);
    kernel_2.append(kernel_2_matrix_1);

    kernels.append(kernel_2);

    // KERNEL_3
    let mut kernel_3 = ArrayTrait::new();

    let mut kernel_3_matrix_1_data = ArrayTrait::new();
    kernel_3_matrix_1_data.append(i33 { inner: 79_u32, sign: true });
    kernel_3_matrix_1_data.append(i33 { inner: 73_u32, sign: true });
    kernel_3_matrix_1_data.append(i33 { inner: 57_u32, sign: true });
    kernel_3_matrix_1_data.append(i33 { inner: 20_u32, sign: true });
    kernel_3_matrix_1_data.append(i33 { inner: 57_u32, sign: false });
    kernel_3_matrix_1_data.append(i33 { inner: 11_u32, sign: true });
    kernel_3_matrix_1_data.append(i33 { inner: 61_u32, sign: false });
    kernel_3_matrix_1_data.append(i33 { inner: 72_u32, sign: false });
    kernel_3_matrix_1_data.append(i33 { inner: 94_u32, sign: false });
    kernel_3_matrix_1_data.append(i33 { inner: 38_u32, sign: false });
    kernel_3_matrix_1_data.append(i33 { inner: 40_u32, sign: false });
    kernel_3_matrix_1_data.append(i33 { inner: 83_u32, sign: false });
    kernel_3_matrix_1_data.append(i33 { inner: 48_u32, sign: false });
    kernel_3_matrix_1_data.append(i33 { inner: 76_u32, sign: false });
    kernel_3_matrix_1_data.append(i33 { inner: 34_u32, sign: false });
    kernel_3_matrix_1_data.append(i33 { inner: 31_u32, sign: true });
    kernel_3_matrix_1_data.append(i33 { inner: 46_u32, sign: false });
    kernel_3_matrix_1_data.append(i33 { inner: 45_u32, sign: true });
    kernel_3_matrix_1_data.append(i33 { inner: 89_u32, sign: true });
    kernel_3_matrix_1_data.append(i33 { inner: 112_u32, sign: true });
    kernel_3_matrix_1_data.append(i33 { inner: 40_u32, sign: true });
    kernel_3_matrix_1_data.append(i33 { inner: 127_u32, sign: true });
    kernel_3_matrix_1_data.append(i33 { inner: 114_u32, sign: true });
    kernel_3_matrix_1_data.append(i33 { inner: 76_u32, sign: true });
    kernel_3_matrix_1_data.append(i33 { inner: 57_u32, sign: true });

    let kernel_3_matrix_1 = matrix_new(5_usize, 5_usize, kernel_3_matrix_1_data);
    kernel_3.append(kernel_3_matrix_1);

    kernels.append(kernel_3);

    // KERNEL_4
    let mut kernel_4 = ArrayTrait::new();

    let mut kernel_4_matrix_1_data = ArrayTrait::new();
    kernel_4_matrix_1_data.append(i33 { inner: 48_u32, sign: true });
    kernel_4_matrix_1_data.append(i33 { inner: 30_u32, sign: false });
    kernel_4_matrix_1_data.append(i33 { inner: 74_u32, sign: false });
    kernel_4_matrix_1_data.append(i33 { inner: 44_u32, sign: false });
    kernel_4_matrix_1_data.append(i33 { inner: 62_u32, sign: false });
    kernel_4_matrix_1_data.append(i33 { inner: 44_u32, sign: true });
    kernel_4_matrix_1_data.append(i33 { inner: 33_u32, sign: true });
    kernel_4_matrix_1_data.append(i33 { inner: 41_u32, sign: true });
    kernel_4_matrix_1_data.append(i33 { inner: 27_u32, sign: false });
    kernel_4_matrix_1_data.append(i33 { inner: 79_u32, sign: false });
    kernel_4_matrix_1_data.append(i33 { inner: 49_u32, sign: true });
    kernel_4_matrix_1_data.append(i33 { inner: 42_u32, sign: true });
    kernel_4_matrix_1_data.append(i33 { inner: 68_u32, sign: true });
    kernel_4_matrix_1_data.append(i33 { inner: 31_u32, sign: true });
    kernel_4_matrix_1_data.append(i33 { inner: 80_u32, sign: false });
    kernel_4_matrix_1_data.append(i33 { inner: 127_u32, sign: true });
    kernel_4_matrix_1_data.append(i33 { inner: 80_u32, sign: true });
    kernel_4_matrix_1_data.append(i33 { inner: 7_u32, sign: true });
    kernel_4_matrix_1_data.append(i33 { inner: 37_u32, sign: false });
    kernel_4_matrix_1_data.append(i33 { inner: 80_u32, sign: false });
    kernel_4_matrix_1_data.append(i33 { inner: 122_u32, sign: true });
    kernel_4_matrix_1_data.append(i33 { inner: 58_u32, sign: true });
    kernel_4_matrix_1_data.append(i33 { inner: 26_u32, sign: true });
    kernel_4_matrix_1_data.append(i33 { inner: 48_u32, sign: false });
    kernel_4_matrix_1_data.append(i33 { inner: 37_u32, sign: false });

    let kernel_4_matrix_1 = matrix_new(5_usize, 5_usize, kernel_4_matrix_1_data);
    kernel_4.append(kernel_4_matrix_1);

    kernels.append(kernel_4);

    // KERNEL_5
    let mut kernel_5 = ArrayTrait::new();

    let mut kernel_5_matrix_1_data = ArrayTrait::new();
    kernel_5_matrix_1_data.append(i33 { inner: 127_u32, sign: false });
    kernel_5_matrix_1_data.append(i33 { inner: 124_u32, sign: false });
    kernel_5_matrix_1_data.append(i33 { inner: 44_u32, sign: false });
    kernel_5_matrix_1_data.append(i33 { inner: 14_u32, sign: false });
    kernel_5_matrix_1_data.append(i33 { inner: 39_u32, sign: false });
    kernel_5_matrix_1_data.append(i33 { inner: 41_u32, sign: true });
    kernel_5_matrix_1_data.append(i33 { inner: 22_u32, sign: false });
    kernel_5_matrix_1_data.append(i33 { inner: 70_u32, sign: false });
    kernel_5_matrix_1_data.append(i33 { inner: 12_u32, sign: true });
    kernel_5_matrix_1_data.append(i33 { inner: 62_u32, sign: true });
    kernel_5_matrix_1_data.append(i33 { inner: 112_u32, sign: true });
    kernel_5_matrix_1_data.append(i33 { inner: 126_u32, sign: true });
    kernel_5_matrix_1_data.append(i33 { inner: 77_u32, sign: true });
    kernel_5_matrix_1_data.append(i33 { inner: 1_u32, sign: true });
    kernel_5_matrix_1_data.append(i33 { inner: 35_u32, sign: false });
    kernel_5_matrix_1_data.append(i33 { inner: 87_u32, sign: true });
    kernel_5_matrix_1_data.append(i33 { inner: 69_u32, sign: true });
    kernel_5_matrix_1_data.append(i33 { inner: 7_u32, sign: true });
    kernel_5_matrix_1_data.append(i33 { inner: 26_u32, sign: false });
    kernel_5_matrix_1_data.append(i33 { inner: 2_u32, sign: false });
    kernel_5_matrix_1_data.append(i33 { inner: 60_u32, sign: false });
    kernel_5_matrix_1_data.append(i33 { inner: 78_u32, sign: false });
    kernel_5_matrix_1_data.append(i33 { inner: 4_u32, sign: false });
    kernel_5_matrix_1_data.append(i33 { inner: 33_u32, sign: true });
    kernel_5_matrix_1_data.append(i33 { inner: 32_u32, sign: true });

    let kernel_5_matrix_1 = matrix_new(5_usize, 5_usize, kernel_5_matrix_1_data);
    kernel_5.append(kernel_5_matrix_1);

    kernels.append(kernel_5);

    // KERNEL_6
    let mut kernel_6 = ArrayTrait::new();

    let mut kernel_6_matrix_1_data = ArrayTrait::new();
    kernel_6_matrix_1_data.append(i33 { inner: 86_u32, sign: false });
    kernel_6_matrix_1_data.append(i33 { inner: 81_u32, sign: false });
    kernel_6_matrix_1_data.append(i33 { inner: 57_u32, sign: false });
    kernel_6_matrix_1_data.append(i33 { inner: 30_u32, sign: true });
    kernel_6_matrix_1_data.append(i33 { inner: 35_u32, sign: true });
    kernel_6_matrix_1_data.append(i33 { inner: 58_u32, sign: false });
    kernel_6_matrix_1_data.append(i33 { inner: 36_u32, sign: false });
    kernel_6_matrix_1_data.append(i33 { inner: 10_u32, sign: true });
    kernel_6_matrix_1_data.append(i33 { inner: 63_u32, sign: true });
    kernel_6_matrix_1_data.append(i33 { inner: 109_u32, sign: true });
    kernel_6_matrix_1_data.append(i33 { inner: 108_u32, sign: false });
    kernel_6_matrix_1_data.append(i33 { inner: 55_u32, sign: false });
    kernel_6_matrix_1_data.append(i33 { inner: 44_u32, sign: true });
    kernel_6_matrix_1_data.append(i33 { inner: 118_u32, sign: true });
    kernel_6_matrix_1_data.append(i33 { inner: 111_u32, sign: true });
    kernel_6_matrix_1_data.append(i33 { inner: 7_u32, sign: false });
    kernel_6_matrix_1_data.append(i33 { inner: 54_u32, sign: false });
    kernel_6_matrix_1_data.append(i33 { inner: 91_u32, sign: true });
    kernel_6_matrix_1_data.append(i33 { inner: 127_u32, sign: true });
    kernel_6_matrix_1_data.append(i33 { inner: 36_u32, sign: true });
    kernel_6_matrix_1_data.append(i33 { inner: 54_u32, sign: false });
    kernel_6_matrix_1_data.append(i33 { inner: 46_u32, sign: true });
    kernel_6_matrix_1_data.append(i33 { inner: 108_u32, sign: true });
    kernel_6_matrix_1_data.append(i33 { inner: 63_u32, sign: true });
    kernel_6_matrix_1_data.append(i33 { inner: 2_u32, sign: true });

    let kernel_6_matrix_1 = matrix_new(5_usize, 5_usize, kernel_6_matrix_1_data);
    kernel_6.append(kernel_6_matrix_1);

    kernels.append(kernel_6);

    // KERNEL_7
    let mut kernel_7 = ArrayTrait::new();

    let mut kernel_7_matrix_1_data = ArrayTrait::new();
    kernel_7_matrix_1_data.append(i33 { inner: 127_u32, sign: true });
    kernel_7_matrix_1_data.append(i33 { inner: 50_u32, sign: true });
    kernel_7_matrix_1_data.append(i33 { inner: 84_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 24_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 24_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 112_u32, sign: true });
    kernel_7_matrix_1_data.append(i33 { inner: 59_u32, sign: true });
    kernel_7_matrix_1_data.append(i33 { inner: 22_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 70_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 45_u32, sign: true });
    kernel_7_matrix_1_data.append(i33 { inner: 124_u32, sign: true });
    kernel_7_matrix_1_data.append(i33 { inner: 52_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 61_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 29_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 24_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 85_u32, sign: true });
    kernel_7_matrix_1_data.append(i33 { inner: 20_u32, sign: true });
    kernel_7_matrix_1_data.append(i33 { inner: 9_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 6_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 84_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 51_u32, sign: true });
    kernel_7_matrix_1_data.append(i33 { inner: 70_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 59_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 60_u32, sign: false });
    kernel_7_matrix_1_data.append(i33 { inner: 20_u32, sign: true });

    let kernel_7_matrix_1 = matrix_new(5_usize, 5_usize, kernel_7_matrix_1_data);
    kernel_7.append(kernel_7_matrix_1);

    kernels.append(kernel_7);

    // KERNEL_8
    let mut kernel_8 = ArrayTrait::new();

    let mut kernel_8_matrix_1_data = ArrayTrait::new();
    kernel_8_matrix_1_data.append(i33 { inner: 40_u32, sign: false });
    kernel_8_matrix_1_data.append(i33 { inner: 54_u32, sign: false });
    kernel_8_matrix_1_data.append(i33 { inner: 83_u32, sign: false });
    kernel_8_matrix_1_data.append(i33 { inner: 45_u32, sign: false });
    kernel_8_matrix_1_data.append(i33 { inner: 46_u32, sign: false });
    kernel_8_matrix_1_data.append(i33 { inner: 58_u32, sign: true });
    kernel_8_matrix_1_data.append(i33 { inner: 25_u32, sign: false });
    kernel_8_matrix_1_data.append(i33 { inner: 33_u32, sign: false });
    kernel_8_matrix_1_data.append(i33 { inner: 73_u32, sign: false });
    kernel_8_matrix_1_data.append(i33 { inner: 81_u32, sign: false });
    kernel_8_matrix_1_data.append(i33 { inner: 110_u32, sign: true });
    kernel_8_matrix_1_data.append(i33 { inner: 19_u32, sign: true });
    kernel_8_matrix_1_data.append(i33 { inner: 11_u32, sign: false });
    kernel_8_matrix_1_data.append(i33 { inner: 3_u32, sign: false });
    kernel_8_matrix_1_data.append(i33 { inner: 20_u32, sign: true });
    kernel_8_matrix_1_data.append(i33 { inner: 122_u32, sign: true });
    kernel_8_matrix_1_data.append(i33 { inner: 88_u32, sign: true });
    kernel_8_matrix_1_data.append(i33 { inner: 38_u32, sign: true });
    kernel_8_matrix_1_data.append(i33 { inner: 43_u32, sign: true });
    kernel_8_matrix_1_data.append(i33 { inner: 89_u32, sign: true });
    kernel_8_matrix_1_data.append(i33 { inner: 7_u32, sign: false });
    kernel_8_matrix_1_data.append(i33 { inner: 89_u32, sign: true });
    kernel_8_matrix_1_data.append(i33 { inner: 127_u32, sign: true });
    kernel_8_matrix_1_data.append(i33 { inner: 106_u32, sign: true });
    kernel_8_matrix_1_data.append(i33 { inner: 64_u32, sign: true });

    let kernel_8_matrix_1 = matrix_new(5_usize, 5_usize, kernel_8_matrix_1_data);
    kernel_8.append(kernel_8_matrix_1);

    kernels.append(kernel_8);

    // KERNEL_9
    let mut kernel_9 = ArrayTrait::new();

    let mut kernel_9_matrix_1_data = ArrayTrait::new();
    kernel_9_matrix_1_data.append(i33 { inner: 17_u32, sign: true });
    kernel_9_matrix_1_data.append(i33 { inner: 45_u32, sign: false });
    kernel_9_matrix_1_data.append(i33 { inner: 98_u32, sign: true });
    kernel_9_matrix_1_data.append(i33 { inner: 20_u32, sign: true });
    kernel_9_matrix_1_data.append(i33 { inner: 125_u32, sign: true });
    kernel_9_matrix_1_data.append(i33 { inner: 46_u32, sign: false });
    kernel_9_matrix_1_data.append(i33 { inner: 8_u32, sign: false });
    kernel_9_matrix_1_data.append(i33 { inner: 39_u32, sign: true });
    kernel_9_matrix_1_data.append(i33 { inner: 16_u32, sign: true });
    kernel_9_matrix_1_data.append(i33 { inner: 40_u32, sign: true });
    kernel_9_matrix_1_data.append(i33 { inner: 29_u32, sign: false });
    kernel_9_matrix_1_data.append(i33 { inner: 96_u32, sign: false });
    kernel_9_matrix_1_data.append(i33 { inner: 53_u32, sign: true });
    kernel_9_matrix_1_data.append(i33 { inner: 7_u32, sign: false });
    kernel_9_matrix_1_data.append(i33 { inner: 59_u32, sign: true });
    kernel_9_matrix_1_data.append(i33 { inner: 21_u32, sign: false });
    kernel_9_matrix_1_data.append(i33 { inner: 88_u32, sign: false });
    kernel_9_matrix_1_data.append(i33 { inner: 27_u32, sign: false });
    kernel_9_matrix_1_data.append(i33 { inner: 58_u32, sign: false });
    kernel_9_matrix_1_data.append(i33 { inner: 87_u32, sign: true });
    kernel_9_matrix_1_data.append(i33 { inner: 39_u32, sign: false });
    kernel_9_matrix_1_data.append(i33 { inner: 2_u32, sign: true });
    kernel_9_matrix_1_data.append(i33 { inner: 66_u32, sign: false });
    kernel_9_matrix_1_data.append(i33 { inner: 127_u32, sign: false });
    kernel_9_matrix_1_data.append(i33 { inner: 18_u32, sign: true });

    let kernel_9_matrix_1 = matrix_new(5_usize, 5_usize, kernel_9_matrix_1_data);
    kernel_9.append(kernel_9_matrix_1);

    kernels.append(kernel_9);

    // KERNEL_10
    let mut kernel_10 = ArrayTrait::new();

    let mut kernel_10_matrix_1_data = ArrayTrait::new();
    kernel_10_matrix_1_data.append(i33 { inner: 11_u32, sign: true });
    kernel_10_matrix_1_data.append(i33 { inner: 14_u32, sign: false });
    kernel_10_matrix_1_data.append(i33 { inner: 118_u32, sign: false });
    kernel_10_matrix_1_data.append(i33 { inner: 85_u32, sign: false });
    kernel_10_matrix_1_data.append(i33 { inner: 46_u32, sign: true });
    kernel_10_matrix_1_data.append(i33 { inner: 25_u32, sign: true });
    kernel_10_matrix_1_data.append(i33 { inner: 79_u32, sign: false });
    kernel_10_matrix_1_data.append(i33 { inner: 79_u32, sign: false });
    kernel_10_matrix_1_data.append(i33 { inner: 26_u32, sign: false });
    kernel_10_matrix_1_data.append(i33 { inner: 127_u32, sign: true });
    kernel_10_matrix_1_data.append(i33 { inner: 25_u32, sign: false });
    kernel_10_matrix_1_data.append(i33 { inner: 97_u32, sign: false });
    kernel_10_matrix_1_data.append(i33 { inner: 51_u32, sign: true });
    kernel_10_matrix_1_data.append(i33 { inner: 14_u32, sign: true });
    kernel_10_matrix_1_data.append(i33 { inner: 2_u32, sign: false });
    kernel_10_matrix_1_data.append(i33 { inner: 88_u32, sign: false });
    kernel_10_matrix_1_data.append(i33 { inner: 74_u32, sign: false });
    kernel_10_matrix_1_data.append(i33 { inner: 94_u32, sign: true });
    kernel_10_matrix_1_data.append(i33 { inner: 18_u32, sign: true });
    kernel_10_matrix_1_data.append(i33 { inner: 70_u32, sign: true });
    kernel_10_matrix_1_data.append(i33 { inner: 71_u32, sign: true });
    kernel_10_matrix_1_data.append(i33 { inner: 68_u32, sign: true });
    kernel_10_matrix_1_data.append(i33 { inner: 39_u32, sign: true });
    kernel_10_matrix_1_data.append(i33 { inner: 17_u32, sign: false });
    kernel_10_matrix_1_data.append(i33 { inner: 4_u32, sign: false });

    let kernel_10_matrix_1 = matrix_new(5_usize, 5_usize, kernel_10_matrix_1_data);
    kernel_10.append(kernel_10_matrix_1);

    kernels.append(kernel_10);

    return kernels;
}
