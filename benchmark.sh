#!/usr/bin/env bash

set -e

for level in O0 O2 O3; do
    echo "Testing -$level"
    gcc "-$level" vectorization.c -o "vector_$level"
    time "./vector_$level"
done
