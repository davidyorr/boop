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
; Even though only Color ID #0 is used, all four Color IDs are mapped to Color 0.
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
	; Set all 4 colors slots to %00, which is Color 0
	ld a, %00000000
	ld [rBGP], a

	; Turn the LCD and Background on
	ld a, LCDCF_ON | LCDCF_BGON
	ld [rLCDC], a

Done:
	jp Done