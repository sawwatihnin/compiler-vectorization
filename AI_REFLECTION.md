# Written Reflection: Exploring Compiler Vectorization with AI

## 1. How I Approached Learning My Topic

To explore compiler auto-vectorization for COMP 211, I started by grounding the topic in C programming concepts we already covered in class—specifically arrays, pointers, dynamic memory allocation (`malloc`/`free), and `for` loops. Before asking complex questions, I wrote a baseline C program (`vectorization.c`) that allocates three arrays of 1,000,000 `float` elements and adds them element-by-element. My initial goal was to understand the difference between traditional scalar execution and SIMD (Single Instruction, Multiple Data) processing, and to figure out why compilers cannot automatically optimize every loop in C.

## 2. Representative Prompts I Used

- **Connecting Starter Code to Core Concepts:**
  > “I want to learn about vectorization, I have made a starter code with my class materials it is a simple vector + free code... I specifically want to address vectorization SIMD vs Scalar AND If Vectorization can improve performance, why shouldn’t we assume every loop will benefit?”
- **Aligning with Assignment Expectations:**
  > “this is the rubric, I would like to cover all the content to ensure that my project is perfectly aligned with expectations...”
- **Distilling Edge Cases into Concise Examples:**
  > “I need a neat and tidy answer to the question that i will ask the audience with examples for this so please give me proper examples for these 3 that is simple enough to not take up space”

## 3. How I Engaged with AI

Rather than accepting AI's explanations at face value, I used its responses as a roadmap to test and verify behavior on my own machine:

- **Empirical Benchmarking:** After learning how optimization flags enable auto-vectorization, I compiled and timed my `vectorization.c` code across `-O0` (`0.311s`), `-O2` (`0.196s`), and `-O3` (`0.171s`), observing an approximate 45% total runtime reduction.
- **Verifying with Compiler Diagnostics:** I ran Apple Clang with `-Rpass=loop-vectorize` and `-Rpass-missed=loop-vectorize` to verify what the compiler actually did. This confirmed that my `add_arrays` loop was vectorized (with a vectorization width of 4 and interleaved count of 4), while also revealing firsthand that my verification loop was *not* vectorized because of its conditional early-exit (`return 1`).
- **Refining Explanations for Peers:** I used AI to help translate low-level hardware constraints—like loop-carried dependencies, pointer aliasing (`restrict`), and branch divergence—into short, readable C snippets and analogies suitable for a 5–7 minute peer presentation.

## 4. What I Would Do Differently

If I were to explore this topic further, I would isolate my performance measurements more precisely. Using the terminal `time` command measured the entire program's execution—including `malloc`, array initialization, correctness checking, and `free`. In the future, I would use `clock_gettime()` directly inside the C code around *only* the `add_arrays()` function call to measure the pure SIMD speedup without memory allocation overhead. I would also inspect the generated assembly (`clang -O3 -S`) to see the exact hardware vector instructions produced by the compiler.

## Conversation Permalink

[https://share.gemini.google/u5ZQqHUqHpKS](https://share.gemini.google/u5ZQqHUqHpKS)
