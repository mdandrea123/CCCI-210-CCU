#include <stdio.h>

// THis was written by Michael Dandrea
int main(void) {
  int X[] = {1, 2, 3, 4};
  int Y[] = {5, 6, 7, 8};
  int Z[4];
  int i, dp = 0;
  for (i = 0; i < 4; i++) {
    Z[i] = X[i] + Y[i];
    printf("%d, ", Z[i]);
    printf("\n");
  }
}