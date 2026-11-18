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

The script compiles and runs the program at each optimization level; the shell's `time` output reports elapsed time (along with CPU time information). The measured time is for the complete program. It includes memory allocation, array initialization, array addition, correctness checking, and memory cleanup, so it does not isolate the vectorized loop by itself. This is a simple demonstration, not a precise benchmark. Times vary with the CPU, compiler, operating system, and system activity.

### Why `-O3` Is Not Always Faster Than `-O2`

More aggressive optimization does not guarantee better performance. It can create larger code that affects the CPU's instruction cache, and memory bandwidth can become the bottleneck. The result depends on the hardware, compiler, and workload.

## Checking Whether Vectorization Happened

Ask GNU GCC for a report about loops it optimized:

```bash
gcc -O3 -fopt-info-vec-optimized vectorization.c -o vectorized
```

This report option is specific to GNU GCC. For example, Apple Clang may reject it even when launched with the command name `gcc`; install/use GNU GCC if you want this exact report. Check which compiler the command invokes with:

```bash
gcc --version
```

On macOS, `gcc` may invoke Apple Clang rather than GNU GCC. If you use Homebrew to install GNU GCC, its command is usually versioned (for example, `gcc-<version>`). Use that command in place of `gcc` for the report and assembly commands below. You do not need GNU GCC to compile and run this basic C program or use the benchmark script; Apple Clang can do those jobs too.

GCC may print a message identifying a loop it vectorized. That means the compiler found it could process multiple loop elements together. Output depends on the GCC version, target, and machine; no particular report is guaranteed.

You can also generate assembly:

```bash
gcc -O3 -S -march=native vectorization.c -o vectorization.s
```

Open `vectorization.s` and look for vector instructions/registers. The spelling varies by architecture and instruction set. `-march=native` asks GCC to use features available on the current machine, so the resulting program may not run on an older or different CPU. Without `-march=native`, GCC may target a more general instruction set.

Optimization levels tell GCC how aggressively to apply transformations. `-O0` disables most optimization, while `-O2` and `-O3` enable progressively broader optimization choices. Optimization does not guarantee vectorization: dependencies between loop iterations, uncertain memory overlap, unsupported operations, target settings, or compiler decisions may prevent it.

### Experimental Evidence: Did GCC Actually Vectorize the Loop?

I used GCC's vectorization report to check whether it transformed the array-addition loop into SIMD operations. This is the command:

```bash
gcc -O3 -fopt-info-vec-optimized vectorization.c -o vectorized
```

The following is an **observed result from the test environment**, not a guaranteed result on every machine:

```text
vectorization.c:6:23: optimized:
loop vectorized using 16 byte vectors

vectorization.c:6:23: optimized:
loop versioned for vectorization because of possible aliasing

vectorization.c:6:23: optimized:
loop vectorized using 8 byte vectors
```

In simple terms, a 16-byte vector is 128 bits wide, and an 8-byte vector is 64 bits wide. Each `float` uses 4 bytes, so those vectors can hold four floats and two floats, respectively. GCC also created a versioned loop: it can choose a safe loop path when the input and output arrays might overlap in memory (aliasing). This report is evidence that GCC actually vectorized the loop in that test environment, rather than only being given an optimization flag. Different machines, GCC versions, and target settings can produce different reports and instructions.

## Compiler Vectorization Evidence

I also used Apple Clang's optimization remarks to check whether it automatically vectorized the loops in this program.

```bash
clang -O3 -Rpass=loop-vectorize -Rpass-missed=loop-vectorize -Rpass-analysis=loop-vectorize vectorization.c -o vectorized
```

### Results

Relevant Apple Clang remarks from the compile (abridged):

```text
vectorization.c:6:5: remark: vectorized loop (vectorization width: 4, interleaved count: 4)
vectorization.c:26:5: remark: vectorized loop (vectorization width: 4, interleaved count: 4)
vectorization.c:34:5: remark: loop not vectorized: could not determine number of loop iterations
```

The first remark is for the array-addition loop; the second is for the array-initialization loop. A vectorization width of 4 means one vector operation handles four elements. Since the array elements are `float`s, that is four floats per vector operation. An interleaved count of 4 means Clang unrolled the vector loop to use four vector operations in its main loop body, which can handle up to 16 elements in one pass through that body. A smaller remainder, if present, is handled separately.

Clang did not vectorize the correctness-check loop because it could not determine its number of iterations. This report confirms that the compiler automatically vectorized the addition loop without explicit SIMD instructions in the C source. The exact remarks and generated instructions can vary by compiler version, target, and machine.

### My Experimental Results

### Experimental Environment

- **Operating System:** macOS 26.5.1
- **Processor:** Apple M2
- **Architecture:** ARM64
- **Compiler:** Apple Clang 17.0.0
- **Experiment Date:** November 18, 2026

### Benchmark Results

I compiled and executed the array addition program using three compiler optimization levels. Each version processed 1,000,000 array elements and successfully passed the correctness check.

| Optimization Level | Real Time | User Time | System Time |
| ------------------ | --------- | --------- | ----------- |
| `-O0`              | 0.311 s   | 0.014 s   | 0.006 s     |
| `-O2`              | 0.196 s   | 0.004 s   | 0.004 s     |
| `-O3`              | 0.171 s   | 0.004 s   | 0.004 s     |

### Observations

- `-O0` had the longest execution time at 0.311 seconds.
- `-O2` reduced execution time to 0.196 seconds.
- `-O3` achieved the shortest execution time at 0.171 seconds.
- All three versions produced correct results for all 1,000,000 elements.
- In this particular run, `-O3` was approximately 45% faster than `-O0`.

These measurements are from a single benchmark run on an Apple M2 Mac. Execution times can vary due to system activity, compiler behavior, and hardware conditions. The results demonstrate the effect of compiler optimization but do not establish that `-O3` will always outperform `-O2`.

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
