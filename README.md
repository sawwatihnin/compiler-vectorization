# Compiler Optimizations: Vectorization

## Overview

This small C project adds two arrays element by element. The loop is ordinary C, so GCC can try to optimize it, including by using SIMD instructions. Vectorization can improve performance by doing several independent additions in one instruction.

## What Is SIMD?

SIMD means **Single Instruction, Multiple Data**. For example, one SIMD instruction can add several pairs of numbers at once instead of adding one pair at a time.

## How Vectorization Works

Scalar execution handles one pair per operation:

- Add A[0] + B[0].
- Add A[1] + B[1].
- Add A[2] + B[2].
- Add A[3] + B[3].

Vectorized execution can process multiple additions together using one SIMD instruction. A vector register is a processor storage location wide enough to hold several values; the instruction operates on those values together. The exact number depends on the CPU's vector width and data type. On x86 processors, instruction sets may include SSE, AVX, or AVX2. Other architectures use different instruction sets, and not every computer supports the same ones.

## Project Structure

- `vectorization.c` — allocates, initializes, adds, and checks the arrays.
- `benchmark.sh` — builds and times the program with `-O0`, `-O2`, and `-O3`.
- `.gitignore` — excludes generated binaries and temporary compiler output.
- `results/.gitkeep` — keeps the empty results directory in Git.

## Requirements

You need GCC and a Unix-like shell. macOS users may need to install GCC separately; GCC on macOS may also need architecture-specific adjustments. Check `gcc --version`: on macOS, the `gcc` command may invoke Apple Clang instead of GNU GCC. The GCC report command below requires GNU GCC.

## How to Run

From this project directory:

```bash
gcc -O0 vectorization.c -o vector_O0
./vector_O0

gcc -O2 vectorization.c -o vector_O2
./vector_O2

gcc -O3 vectorization.c -o vector_O3
./vector_O3
```

Each run should print a success message if every result is correct.

## Benchmarking

```bash
chmod +x benchmark.sh
./benchmark.sh
```

The script compiles and runs the program at each optimization level; the shell's `time` output reports elapsed time (along with CPU time information). These measurements include program startup and allocation, and are intended as a simple demonstration, not a precise benchmark. Times vary with the CPU, compiler, operating system, and system activity. `-O3` is not guaranteed to be faster than `-O2`.

## Checking Whether Vectorization Happened

Ask GCC for a report about loops it optimized:

```bash
gcc -O3 -fopt-info-vec-optimized vectorization.c -o vectorized
```

This report option is specific to GCC. For example, Apple Clang may reject it even when launched with the command name `gcc`; install/use GNU GCC if you want this exact report.

GCC may print a message identifying a loop it vectorized. That means the compiler found it could process multiple loop elements together. Output depends on the GCC version, target, and machine; no particular report is guaranteed.

You can also generate assembly:

```bash
gcc -O3 -S -march=native vectorization.c -o vectorization.s
```

Open `vectorization.s` and look for vector instructions/registers. The spelling varies by architecture and instruction set. `-march=native` asks GCC to use features available on the current machine, so the resulting program may not run on an older or different CPU. Without `-march=native`, GCC may target a more general instruction set.

Optimization levels tell GCC how aggressively to apply transformations. `-O0` disables most optimization, while `-O2` and `-O3` enable progressively broader optimization choices. Optimization does not guarantee vectorization: dependencies between loop iterations, uncertain memory overlap, unsupported operations, target settings, or compiler decisions may prevent it.

## What I Learned

Programmers can write a normal C loop, and a compiler may transform it into SIMD instructions. That can speed up repeated independent work without manually writing processor-specific instructions.

## Limitations

- Not every loop can be vectorized.
- Memory bandwidth can limit performance.
- Small workloads may not show measurable speedups.
- Hardware and compiler differences affect results.
- `-O3` does not guarantee a speedup over `-O2`.

## References

- [GCC optimization options](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html)
- [GCC tree-SSA vectorization](https://gcc.gnu.org/projects/tree-ssa/vectorization.html)
- [Intel Intrinsics Guide](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html)
