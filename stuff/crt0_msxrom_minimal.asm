;; Minimal CRT0 for MSX ROMs
;; -------------------------
;; This startup stub defines the 16-byte MSX cartridge header and a tiny
;; initialization routine that calls a C `main()` and then loops indefinitely.

    ;; Give the module a name for SDASz80’s symbol tables
    .module crt0msx

    ;; Declare that `_main` (the C entry point) will be resolved at link time
    .globl  _main

;; ----------------------------------------------------------------------------
;; MSX Cartridge Header (16 bytes at 0x4000–0x400F)
;; -- The BIOS scans these 16 bytes on every power-up or reset --
;; ----------------------------------------------------------------------------

    ;; Switch into an absolute section so `.org` is honored
    .area   _HEADER (ABS)

    ;; Place the header starting at 0x4000 in the CPU’s address space
    .org    0x4000

    ;; 0x4000: Signature bytes “AB” identify a valid cartridge
    .db     0x41            ;; ASCII 'A'
    .db     0x42            ;; ASCII 'B'

    ;; 0x4002: INIT vector — BIOS will CALL this address after signature check
    .dw     init

    ;; 0x4004: STATEMENT vector — used by BASIC’s RST #16, unused here
    .dw     0x0000

    ;; 0x4006: DEVICE vector — hooks for custom device handlers, unused
    .dw     0x0000

    ;; 0x4008: TEXT vector — pointer to tokenized BASIC text, unused
    .dw     0x0000

    ;; 0x400A–0x400F: Reserved fields — must be zero
    .dw     0x0000
    .dw     0x0000
    .dw     0x0000

;; ----------------------------------------------------------------------------
;; init Routine
;; -- First code executed after BIOS INIT call --
;; ----------------------------------------------------------------------------

init:
    ;; Call the C `main()` function (must be defined as `void main(void)`)
    call    _main

    ;; Never return into undefined memory: loop here forever
    jp      init
