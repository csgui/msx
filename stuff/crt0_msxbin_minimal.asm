;; Minimal crt0 for MSX-BASIC .BIN binaries
;; ----------------------------------------
;; This stub sets up a bare “.BIN”-style program at a custom RAM
;; address, then jumps into C `main()`.  After `main` returns
;; it loops indefinitely to avoid falling into unmapped memory.

    ;; Name this module for SDASz80’s symbol tables
    .module crt0msx

    ;; Tell the linker “`_main`” will be defined elsewhere (in the C code)
    .globl  _main

    ;; Adjust this to wherever you want the stub to live.
    START_ADDR .equ 0x8000

;;------------------------------------------------------------------------------
;; Header area (absolute placement)
;;------------------------------------------------------------------------------

    ;; Switch into an absolute (“ABS”) section named _HEADER
    .area   _HEADER (ABS)

    ;; Position the next bytes at START_ADDR in RAM.
    .org    START_ADDR

    ;; BASIC “BLOAD” header byte: 0xFE marks a raw binary image.
    .db     0xFE

    ;; Three 16-bit words:
    ;;  - the address the loader/CALL will jump to
    ;;  - “end” address (last byte of data)
    ;;  - (repeat of the init vector)
    .dw     init, 0x8029, init

;;------------------------------------------------------------------------------
;; The `init` routine: first code executed after loading
;;------------------------------------------------------------------------------

init:
    ;; Invoke C entry point (`void main(void)`)
    call    _main

    ;; Infinite loop: when `main` returns, jump back to `init`
    ;; (Prevents the CPU from running into unmapped memory)
    jp      init
