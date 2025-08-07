; =============================================================================
; Suite: boop (Basic Output Of PPU)
; Test:  Solid Color 2 Background
; -----------------------------------------------------------------------------
;
; Displays a solid Color 2 screen using the Background layer.
;
; This test relies on the Game Boy's initial state after boot where VRAM
; has been cleared to $00, making the tilemap draw tile #0 everywhere
; and tile #0's pattern consists entirely of Color ID #0.
;
; Expected result:
; - A solid screen filled with the second darkest shade (Color 2).
;
; =============================================================================

INCLUDE "inc/hardware.inc"

SECTION "Header", ROM0[$100]

	jp EntryPoint

	ds $150 - @, 0 ; Make room for the header

EntryPoint:
	; Set Color ID #0 to %10 (Color 2) and other IDs to %00 (Color 0)
	ld a, %00000010
	ld [rBGP], a

	; Turn the LCD and Background on
	ld a, LCDCF_ON | LCDCF_BGON
	ld [rLCDC], a

Done:
	jp Done