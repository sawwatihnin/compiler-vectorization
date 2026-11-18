# AI Exploration and Reflection

## Reflection

I used AI to explore how compiler vectorization works and to make sense of the output from Apple Clang. I learned that SIMD lets a processor apply one instruction to multiple values, and that the compiler's report gives evidence about which loops it vectorized. In my program, the array addition loop was vectorized with a width of 4 and an interleaved count of 4. The initialization loop was vectorized too, but the correctness-check loop was not because Clang could not determine its number of iterations.

I checked the explanation against the compiler output and the loop locations in my C file. That helped me understand what I can explain in my presentation and what the report does not say: the timing results are separate evidence, and they do not by themselves prove vectorization. I also learned that compiler results can depend on the machine and compiler.

## Representative Prompts

These are examples of prompts I used while exploring the topic:

1. “The loop is supposed to have vectorized but the terminal is showing this” (with the Clang output).
2. “is this correct” (with the compiler output screenshot).
3. “give me a one line summary to explain what is happening in my presentation”

## Conversation Permalink

https://chatgpt.com/s/cx_6afdcafb950c8191b75bde799b6a7d18
