# include <stdio.h>

extern int is_geometric(int array[], int length);

int main() {
    int values[] = {1, -2, 4, -8, 16};

    printf("Is geometric progression? : %d\n", is_geometric(values, 5));
    
    return 0;
}
