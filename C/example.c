#include <stdio.h>
#include <stdlib.h>

int my_add(int a, int b) {
    int c = a + b;
    return c;
}

void my_add_by_pointer(int *a, int *b, int *result) {
    // add the numbers together and return the result
    int c = *a + *b;
    *result = c;
}

int main(int argc, char **argv) {
    if(argc != 3) {
        printf("Usage: %s <num1> <num2>\n", argv[0]);
        exit(1);
    }
    int x = atoi(argv[1]); 
    int *xp = &x;
    int y = atoi(argv[2]); 
    int *yp = &y;
    int z;
    my_add_by_pointer(xp, yp, &z);
    printf("Hello World: x = %d y = %d z = %d\n", x, y, z);
    return 0;
}
