#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>

float data[4];
size_t size = 0;
size_t capacity = 4;

int push(float value)
{
    if (size == capacity) {
        return 0;
    }

    data[size] = value;
    size++;

    return 1;
}

float pop(void)
{
    size--;
    return data[size];
}

int is_empty(void)
{
    return size == 0;
}

void print_stack(void)
{
    printf("size: %zu, capacity: %zu, data:", size, capacity);

    for (size_t i = 0; i < size; i++) {
        printf(" %.4f", data[i]);
    }

    printf("\n");
}

int main(void)
{
    char input[128];

    while (fgets(input, sizeof input, stdin) != NULL) {
        if (input[0] == 'q' &&
            (input[1] == '\n' || input[1] == '\0')) {
            break;
        }

        float value = strtof(input, NULL);

        if (!push(value)) {
            printf("stack full\n");
            continue;
        }

        printf("push: %.4f, ", value);
        print_stack();
    }

    while (!is_empty()) {
        float value = pop();

        printf("pop: %.4f, ", value);
        print_stack();
    }

    printf("stack empty\n");

    return 0;
}