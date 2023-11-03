#include <stdio.h>

void swap(int v[], int k);
void sort(int v[], int n);
void sort_descending(int v[], int n);
void print_array(int v[], int n);

int main(void) {

  //.data
  // A: .word 2, 4, 3, 1, 9, 7
  int A[] = {2, 4, 3, 1, 9, 7};
  int N = 6; // Length of array
  print_array(A, N);
  sort_descending(A, N);
  //sort(A, N);
  print_array(A, N);

  return 0;
}

void swap(int v[], int k) {
  int temp;
  temp = v[k];
  v[k] = v[k + 1];
  v[k + 1] = temp;
}

void sort(int v[], int n) {
  for (int i = 0; i < n; i += 1) {
    for (int j = i - 1; j >= 0 && v[j] > v[j + 1]; j -= 1) {
      swap(v, j);
    }
  }
}

void sort_descending(int v[], int n) {
  for (int i = 0; i < n; i++){
    for (int j = i - 1; j >= 0 && v[j] < v[j + 1]; j--) {
      swap(v, j);
    }
  }
}

void print_array(int v[], int n) {
  for (int i = 0; i < n; i++) {
    printf("%d,", v[i]);
  }
  printf("\n");
}