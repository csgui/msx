void putchar(void);

void putchar(void) {
    __asm
        ld a, #'M'
        call 0x00a2
        ld a, #'S'
        call 0x00a2
        ld a, #'X'
        call 0x00a2
        ld a, #' '
        call 0x00a2

        ret
    __endasm;
}

int main(void) {
    putchar();

    return 0;
}
