# Explore ML in Cairo 1.0 ![PRs Welcome](https://img.shields.io/badge/PRs-welcome-green.svg)

Build neural network models in Cairo 1.0 to perform inference.

---

The calculations are performed using `i32` values, and the outcomes are quantized into 8 bits based on the [ONNX standard for symmetric quantization](https://onnxruntime.ai/docs/performance/quantization.html#quantization-overview).

## Installation

Follow the [**`auditless/cairo-template`**](https://github.com/auditless/cairo-template) instructions.

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

### Format

Format the Cairo source code (using Scarb):

```bash
$ make fmt
```

## TODO
- Activation layers
- Convolutional layer
- MNIST example
- ...

## Credits
- [circomlib-ml](https://github.com/socathie/circomlib-ml) for the inspiration.
- [GuiltyGyoza](https://github.com/guiltygyoza/tiny-dnn-on-starknet) for the inspiration.
- [Franalgaba](https://github.com/franalgaba/onnx-cairo) for the inspiration.
- [Modulus-Labs](https://github.com/Modulus-Labs/RockyBot) for the inspiration.
- [Auditless](https://github.com/auditless) for this great [cairo-template](https://github.com/auditless/cairo-template).
- The [Quaireaux](https://github.com/keep-starknet-strange/quaireaux) the unofficial cairo doc 😅.
