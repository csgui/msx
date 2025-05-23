;; Minimal crt0 for MSX ROMs
;; -------------------------

    .module crt0msx           ; Name of this module

    .globl  _main             ; Export the C entry point symbol

;;------------------------------------------------------------------------------
;; MSX-ROM header (16 bytes)
;; MSX BIOS looks at 0x4000–0x400F for “AB” signature and vectors
;;------------------------------------------------------------------------------

    .area _HEADER (ABS)       ; Switch to an absolute section
    .org  0x4000              ; Place the following bytes at address 0x4000

    .db   0x41                ; ‘A’ — ASCII 0x41 — cartridge signature
    .db   0x42                ; ‘B’ — ASCII 0x42

    .dw   init                ; INIT vector: BIOS will CALL this on power-up
    .dw   0x0000              ; STATEMENT vector (unused in this stub)
    .dw   0x0000              ; DEVICE    vector (unused)
    .dw   0x0000              ; TEXT      vector (unused)
    .dw   0x0000              ; Reserved
    .dw   0x0000              ; Reserved
    .dw   0x0000              ; Reserved

;;------------------------------------------------------------------------------
;; init routine — the first code the BIOS jumps to
;;------------------------------------------------------------------------------

init:
    call  _main               ; Transfer control to C `main()` function
    jp    init                ; Infinite loop to prevent falling off into RAM
