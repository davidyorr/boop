; =============================================================================
; Suite: boop (Basic Output Of PPU)
; Test:  Solid Color 0 Background
; -----------------------------------------------------------------------------
;
; Displays a solid Color 0 screen using the Background layer.
;
; This test relies on the Game Boy's initial state after boot where VRAM
; has been cleared to $00, making the tilemap draw tile #0 everywhere
; and tile #0's pattern consists entirely of Color ID #0.
;
; Expected result:
; - A solid screen filled with the lightest shade (Color 0).
;
; =============================================================================

INCLUDE "inc/hardware.inc"

SECTION "Header", ROM0[$100]

	jp EntryPoint

	ds $150 - @, 0 ; Make room for the header

EntryPoint:
	; Set Color ID #0 to %00 (Color 0) and other IDs to %11 (Color 3)
	ld a, %11111100
	ld [rBGP], a

	; Turn the LCD and Background on
	ld a, LCDCF_ON | LCDCF_BGON
	ld [rLCDC], a

Done:
	jp Done