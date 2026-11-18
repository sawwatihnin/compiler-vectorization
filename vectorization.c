#include <stdio.h>
#include <stdlib.h>

/* Add corresponding elements from a and b into c. */
void add_arrays(float *a, float *b, float *c, int n) {
    for (int i = 0; i < n; i++) {
        c[i] = a[i] + b[i];
    }
}

int main(void) {
    const int n = 1000000;
    float *a = malloc((size_t)n * sizeof(float));
    float *b = malloc((size_t)n * sizeof(float));
    float *c = malloc((size_t)n * sizeof(float));

    if (a == NULL || b == NULL || c == NULL) {
        fprintf(stderr, "Error: could not allocate arrays.\n");
        free(a);
        free(b);
        free(c);
        return 1;
    }

    /* Initialize inputs with predictable values. */
    for (int i = 0; i < n; i++) {
        a[i] = (float)i;
        b[i] = 2.0f * (float)i;
    }

    add_arrays(a, b, c, n);

    /* Check every result so the computation has an observable purpose. */
    for (int i = 0; i < n; i++) {
        float expected = 3.0f * (float)i;
        if (c[i] != expected) {
            fprintf(stderr, "Error: incorrect result at index %d.\n", i);
            free(a);
            free(b);
            free(c);
            return 1;
        }
    }

    printf("Success: all %d array elements were added correctly.\n", n);

    free(a);
    free(b);
    free(c);
    return 0;
}
