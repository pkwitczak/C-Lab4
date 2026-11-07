#include <stdio.h>
#include <stdlib.h>

float add(float a, float b)
{
    return a + b;
}

float subtract(float a, float b)
{
    return a - b;
}

float multiply(float a, float b)
{
    return a * b;
}

float divide(float a, float b)
{
    return a / b;
}

int main(void)
{
    char input[128];
    char *end;
    float a;
    float b;
    float result = 0.0f;
    char operation;

    fgets(input, sizeof input, stdin);

    a = strtof(input, &end);
    b = strtof(end, &end);
    operation = end[1];

    switch (operation) {
    case '+':
        result = add(a, b);
        break;
    case '-':
        result = subtract(a, b);
        break;
    case '*':
        result = multiply(a, b);
        break;
    case '/':
        result = divide(a, b);
        break;
    }

    printf("result: %.4f\n", result);

    return 0;
}