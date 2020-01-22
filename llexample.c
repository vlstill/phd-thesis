struct Foo {
    int x;
    long y;
    float z;
};

int fun(int x, void *ptr) {
    int y = *((int *)ptr);
    return x + y;
}

int g;

int main( void ) {
    struct Foo f;
    int a = 42;
    return fun( a, &g );
}
