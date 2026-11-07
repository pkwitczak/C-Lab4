#include <stdio.h>
#include <stddef.h>

int main(void)
{
    float data[4];
    size_t size = 0;

    data[size] = 2.0f;
    size++;

    printf("size: %zu, data:", size);

    for (size_t i = 0; i < size; i++) {
        printf(" %.4f", data[i]);
    }

    printf("\n");

    return 0;
}

