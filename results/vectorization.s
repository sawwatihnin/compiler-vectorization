	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 26, 0	sdk_version 26, 2
	.globl	_add_arrays                     ; -- Begin function add_arrays
	.p2align	2
_add_arrays:                            ; @add_arrays
	.cfi_startproc
; %bb.0:
	cmp	w3, #1
	b.lt	LBB0_5
; %bb.1:
	mov	w8, w3
	cmp	w3, #4
	b.hs	LBB0_6
; %bb.2:
	mov	x9, #0                          ; =0x0
LBB0_3:
	lsl	x12, x9, #2
	add	x10, x2, x12
	add	x11, x1, x12
	add	x12, x0, x12
	sub	x8, x8, x9
LBB0_4:                                 ; =>This Inner Loop Header: Depth=1
	ldr	s0, [x12], #4
	ldr	s1, [x11], #4
	fadd	s0, s0, s1
	str	s0, [x10], #4
	subs	x8, x8, #1
	b.ne	LBB0_4
LBB0_5:
	ret
LBB0_6:
	mov	x9, #0                          ; =0x0
	sub	x10, x2, x0
	cmp	x10, #64
	b.lo	LBB0_3
; %bb.7:
	sub	x10, x2, x1
	cmp	x10, #64
	b.lo	LBB0_3
; %bb.8:
	cmp	w3, #16
	b.hs	LBB0_10
; %bb.9:
	mov	x9, #0                          ; =0x0
	b	LBB0_14
LBB0_10:
	and	x9, x8, #0x7ffffff0
	add	x10, x2, #32
	add	x11, x1, #32
	add	x12, x0, #32
	mov	x13, x9
LBB0_11:                                ; =>This Inner Loop Header: Depth=1
	ldp	q0, q1, [x12, #-32]
	ldp	q2, q3, [x12], #64
	ldp	q4, q5, [x11, #-32]
	ldp	q6, q7, [x11], #64
	fadd.4s	v0, v0, v4
	fadd.4s	v1, v1, v5
	fadd.4s	v2, v2, v6
	fadd.4s	v3, v3, v7
	stp	q0, q1, [x10, #-32]
	stp	q2, q3, [x10], #64
	subs	x13, x13, #16
	b.ne	LBB0_11
; %bb.12:
	cmp	x9, x8
	b.eq	LBB0_5
; %bb.13:
	tst	x8, #0xc
	b.eq	LBB0_3
LBB0_14:
	mov	x13, x9
	and	x9, x8, #0x7ffffffc
	lsl	x12, x13, #2
	add	x10, x0, x12
	add	x11, x1, x12
	add	x12, x2, x12
	sub	x13, x13, x9
LBB0_15:                                ; =>This Inner Loop Header: Depth=1
	ldr	q0, [x10], #16
	ldr	q1, [x11], #16
	fadd.4s	v0, v0, v1
	str	q0, [x12], #16
	adds	x13, x13, #4
	b.ne	LBB0_15
; %bb.16:
	cmp	x9, x8
	b.ne	LBB0_3
	b	LBB0_5
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function main
lCPI1_0:
	.long	0                               ; 0x0
	.long	1                               ; 0x1
	.long	2                               ; 0x2
	.long	3                               ; 0x3
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	w22, #2304                      ; =0x900
	movk	w22, #61, lsl #16
	mov	w0, #2304                       ; =0x900
	movk	w0, #61, lsl #16
	bl	_malloc
	mov	x21, x0
	mov	w0, #2304                       ; =0x900
	movk	w0, #61, lsl #16
	bl	_malloc
	mov	x20, x0
	mov	w0, #2304                       ; =0x900
	movk	w0, #61, lsl #16
	bl	_malloc
	mov	x19, x0
	cbz	x21, LBB1_11
; %bb.1:
	cbz	x20, LBB1_11
; %bb.2:
	cbz	x19, LBB1_11
; %bb.3:
	mov	x8, #0                          ; =0x0
Lloh0:
	adrp	x9, lCPI1_0@PAGE
Lloh1:
	ldr	q0, [x9, lCPI1_0@PAGEOFF]
	movi.4s	v1, #4
	movi.4s	v2, #8
	movi.4s	v3, #12
	movi.4s	v4, #16
LBB1_4:                                 ; =>This Inner Loop Header: Depth=1
	add.4s	v5, v0, v1
	add.4s	v6, v0, v2
	add.4s	v7, v0, v3
	ucvtf.4s	v16, v0
	ucvtf.4s	v5, v5
	ucvtf.4s	v6, v6
	ucvtf.4s	v7, v7
	add	x9, x21, x8
	stp	q16, q5, [x9]
	stp	q6, q7, [x9, #32]
	fadd.4s	v16, v16, v16
	fadd.4s	v5, v5, v5
	fadd.4s	v6, v6, v6
	fadd.4s	v7, v7, v7
	add	x9, x20, x8
	stp	q16, q5, [x9]
	stp	q6, q7, [x9, #32]
	add.4s	v0, v0, v4
	add	x8, x8, #64
	cmp	x22, x8
	b.ne	LBB1_4
; %bb.5:
	mov	x8, #0                          ; =0x0
LBB1_6:                                 ; =>This Inner Loop Header: Depth=1
	add	x9, x21, x8
	ldp	q0, q1, [x9]
	ldp	q2, q3, [x9, #32]
	add	x9, x20, x8
	ldp	q4, q5, [x9]
	ldp	q6, q7, [x9, #32]
	fadd.4s	v0, v0, v4
	fadd.4s	v1, v1, v5
	fadd.4s	v2, v2, v6
	fadd.4s	v3, v3, v7
	add	x9, x19, x8
	stp	q0, q1, [x9]
	stp	q2, q3, [x9, #32]
	add	x8, x8, #64
	cmp	x22, x8
	b.ne	LBB1_6
; %bb.7:
	mov	x8, #0                          ; =0x0
	fmov	s0, #3.00000000
	mov	w9, #16960                      ; =0x4240
	movk	w9, #15, lsl #16
LBB1_8:                                 ; =>This Inner Loop Header: Depth=1
	ucvtf	s1, w8
	fmul	s1, s1, s0
	ldr	s2, [x19, x8, lsl #2]
	fcmp	s2, s1
	b.ne	LBB1_12
; %bb.9:                                ;   in Loop: Header=BB1_8 Depth=1
	add	x8, x8, #1
	cmp	x8, x9
	b.ne	LBB1_8
; %bb.10:
	mov	w8, #16960                      ; =0x4240
	movk	w8, #15, lsl #16
	str	x8, [sp]
Lloh2:
	adrp	x0, l_.str.2@PAGE
Lloh3:
	add	x0, x0, l_.str.2@PAGEOFF
	bl	_printf
	mov	x0, x21
	bl	_free
	mov	x0, x20
	bl	_free
	mov	x0, x19
	bl	_free
	mov	w22, #0                         ; =0x0
	mov	x0, x22
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
LBB1_11:
Lloh4:
	adrp	x8, ___stderrp@GOTPAGE
Lloh5:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh6:
	ldr	x3, [x8]
Lloh7:
	adrp	x0, l_.str@PAGE
Lloh8:
	add	x0, x0, l_.str@PAGEOFF
	mov	w22, #1                         ; =0x1
	mov	w1, #34                         ; =0x22
	mov	w2, #1                          ; =0x1
	bl	_fwrite
	mov	x0, x21
	bl	_free
	mov	x0, x20
	bl	_free
	mov	x0, x19
	bl	_free
	mov	x0, x22
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
LBB1_12:
Lloh9:
	adrp	x9, ___stderrp@GOTPAGE
Lloh10:
	ldr	x9, [x9, ___stderrp@GOTPAGEOFF]
Lloh11:
	ldr	x0, [x9]
	str	x8, [sp]
Lloh12:
	adrp	x1, l_.str.1@PAGE
Lloh13:
	add	x1, x1, l_.str.1@PAGEOFF
	bl	_fprintf
	mov	x0, x21
	bl	_free
	mov	x0, x20
	bl	_free
	mov	x0, x19
	bl	_free
	mov	w22, #1                         ; =0x1
	mov	x0, x22
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.loh AdrpLdr	Lloh0, Lloh1
	.loh AdrpAdd	Lloh2, Lloh3
	.loh AdrpAdd	Lloh7, Lloh8
	.loh AdrpLdrGotLdr	Lloh4, Lloh5, Lloh6
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpLdrGotLdr	Lloh9, Lloh10, Lloh11
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"Error: could not allocate arrays.\n"

l_.str.1:                               ; @.str.1
	.asciz	"Error: incorrect result at index %d.\n"

l_.str.2:                               ; @.str.2
	.asciz	"Success: all %d array elements were added correctly.\n"

.subsections_via_symbols
