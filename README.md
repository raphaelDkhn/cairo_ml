# Explore ML in Cairo 1.0 ![PRs Welcome](https://img.shields.io/badge/PRs-welcome-green.svg)

Build neural network models in Cairo 1.0 to perform inference.

---

The calculations are performed using `i33` values, and the outcomes are quantized into 8 bits based on the [ONNX standard for symmetric quantization](https://onnxruntime.ai/docs/performance/quantization.html#quantization-overview).

## Installation

Follow the [**`auditless/cairo-template`**](https://github.com/auditless/cairo-template) instructions.

## Cairo Version
- [Cairo](https://github.com/starkware-libs/cairo/releases/tag/v1.0.0-alpha.4) v1.0.0-alpha.4

## How to use it?

### Build

Build the code.

```bash
$ make build
```

### Test

Run the tests in `src/tests`:

```bash
$ make test
```

## Features

### Layers
- [x] Linear
- [x] Conv2d

### Math

#### Matrix
- [x] Matrix representation
- [x] Matrix dot vector
- [x] Slice matrix

#### Vector
- [x] Sum vectors
- [x] Dot vectors
- [x] Find in vectors
- [x] Slice vector
- [x] Concat vectors

#### Signal
- [x] Valid 2D cross-correlation

### Performance
#### Quantizations
- [x] 8-bit symmetric quantization

## TODO
- Activation layers
- MNIST example
- more

## Credits
- [circomlib-ml](https://github.com/socathie/circomlib-ml) for the inspiration.
- [GuiltyGyoza](https://github.com/guiltygyoza/tiny-dnn-on-starknet) for the inspiration.
- [Franalgaba](https://github.com/franalgaba/neural-network-cairo/tree/main/src) for the inspiration.
- [Modulus-Labs](https://github.com/Modulus-Labs/RockyBot) for the inspiration.
- [Auditless](https://github.com/auditless) for this great [cairo-template](https://github.com/auditless/cairo-template).
- The [Quaireaux](https://github.com/keep-starknet-strange/quaireaux) the unofficial cairo doc 😅.
