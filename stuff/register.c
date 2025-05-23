void putchar(void);

void putchar(void) {
    __asm
        ld a, #'C'
        call 0x00a2
        ld a, #'H'
        call 0x00a2
        ld a, #'R'
        call 0x00a2
        ld a, #'I'
        call 0x00a2
        ld a, #'S'
        call 0x00a2

        ret
    __endasm;
}

int main(void) {
    putchar();

    return 0;
}
