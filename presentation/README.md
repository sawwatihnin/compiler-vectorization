# Student-Created Presentation Materials

Save the slides you create for COMP 211 Checkoff 3 in this folder. No slides have been generated for you.

## Suggested 5–7 Minute Outline

- **0:00–0:45 — Goal:** Explain what the program computes and why optimization matters.
- **0:45–1:45 — SIMD idea:** Contrast one-at-a-time scalar addition with several values per vector instruction.
- **1:45–2:45 — C loop:** Walk through `add_arrays` and explain why its iterations are independent.
- **2:45–4:00 — Compiler evidence:** Show the Apple Clang remarks and explain vectorization width 4 and interleaved count 4.
- **4:00–5:15 — Measurements:** Present the three recorded Apple M2 timings and note that the benchmark covers the full program.
- **5:15–6:00 — Limits and takeaway:** Mention aliasing, loop dependencies, compiler/CPU differences, and why `-O3` is not always faster.

Leave about 3 minutes for questions and answers. Adjust the outline to fit the slides you make and your speaking pace.
