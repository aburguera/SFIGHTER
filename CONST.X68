; =============================================================================
; SYSTEM CONSTANTS
; =============================================================================

; --- GAME STATES -------------------------------------------------------------

STANONE     EQU     -1                      ; PLACEHOLDER TO FORCE CHANGE
STAINTR     EQU     0                       ; INTRO/PRESS FIRE STATE
STAPLAY     EQU     1                       ; NORMAL GAME STATE
STAGOVR     EQU     2                       ; GAME OVER STATE

; --- AGENT TYPES -------------------------------------------------------------

SHTTYPE     EQU     1
ASTTYPE     EQU     2
XPLTYPE     EQU     3

; --- PLAYER RELATED CONSTANTS ------------------------------------------------

PLRWIDTH    EQU     30                      ; PLAYER WIDTH (PIXELS)
PLRHEIGH    EQU     30                      ; PLAYER HEIGHT (PIXELS)
PLRINIEN    EQU     500                     ; PLAYER INITIAL ENERGY (<SCRWIDTH)
PLRSPEED    EQU     5                       ; PLAYER SPEED (PIXELS PER INT)
PLRNRMCL    EQU     $0000C0FF               ; PLAYER NORMAL COLOR
PLRDMGCL    EQU     $000000FF               ; PLAYER DAMAGED COLOR
PLRTXTCL    EQU     $00FFFFFF               ; FONT COLOR
PLRTXTX     EQU     2                       ; SCORE X COORDINATE
PLRTXTY     EQU     1                       ; SCORE Y COORDINATE
PLRLIFEH    EQU     20                      ; HEIGHT OF LIFE BAR
PLRLIFEY    EQU     SCRHEIGH-PLRLIFEH*2     ; LIFE BAR Y POS
PLRLIFEC    EQU     $000000FF               ; LIFE BAR COLOR
PLRUMDMG    EQU     %00000001               ; UPDATE DAMAGE MASK
PLRPMDMG    EQU     %00000010               ; PLOT DAMAGE MASK
PLRUBDMG    EQU     0                       ; UPDATE DAMAGE BIT
PLRPBDMG    EQU     1                       ; PLOT DAMAGE BIT

; --- SHOT RELATED CONSTANTS --------------------------------------------------

SHTWIDTH    EQU     20                      ; SHOT WIDTH (PIXELS)
SHTHEIGH    EQU     3                       ; SHOT HEIGHT. ONLY TO DRAW.
SHTSPEED    EQU     10                      ; SHOT SPEED (PIXELS PER INT)

; --- ASTEROID RELATED CONSTANTS ----------------------------------------------

ASTSIZE     EQU     60                      ; ASTEROID DIAMETER
ASTPENCL    EQU     $00FFFFFF               ; ASTEROID PEN COLOR
ASTFILCL    EQU     $0000FF00               ; ASTEROID FIL COLOR
ASTDMG      EQU     10                      ; ASTEROID DAMAGE TO PLAYER
ASTNFRAG    EQU     5                       ; NUMBER OF FRAGMENTS IN EXPLOSION
ASTSCORE    EQU     5                       ; SCORE ASTEROID DESTRUCTION

; --- EXPLOSION RELATED CONSTANTS ---------------------------------------------

XPLSIZE     EQU     20                      ; EXPLOSION ITEM DIAMETER (PIXELS)
XPLPENCL    EQU     $00DDDDDD               ; EXPLOSION ITEM PEN COLOR
XPLFILCL    EQU     $00CCCCCC               ; EXPLOSION ITEM FIL COLOR

; --- INTRO STATE RELATED CONSTANTS -------------------------------------------

INTTITX     EQU     31                      ; TITLE X COORDINATE
INTTITY     EQU     5                       ; TITLE Y COORDINATE
INTTITC     EQU     $000000FF               ; TITLE COLOR
INTPRSX     EQU     31                      ; PRESS FIRE X COORDINATE
INTPRSY     EQU     26                      ; PRESS FIRE Y COORDINATE
INTPRSC     EQU     $00FFFFFF               ; PRESS FIRE COLOR

; --- GAME OVER STATE RELATED CONSTANTS ---------------------------------------

GOVSTRX     EQU     35                      ; TITLE X COORDINATE
GOVSTRY     EQU     15                      ; TITLE Y COORDINATE
GOVSTRC     EQU     $00FFFFFF               ; TITLE COLOR

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
