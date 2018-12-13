; =============================================================================
; SHOT MANAGEMENT. IT IS AN AGENT.
; LOCAL MEMORY IS:
; +0 WORD X COORDINATE
; +2 WORD Y COORDINATE
; =============================================================================

; -----------------------------------------------------------------------------
SHTINIT
; INITALIZES A SHOT
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
;            D1.W INITIAL X COORDINATE
;            D2.W INITIAL Y COORDINATE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  D1,(A0)
            MOVE.W  D2,2(A0)
            RTS

; -----------------------------------------------------------------------------
SHTUPD
; UPDATES A SHOT BY MOVING IT RIGHTWARD.
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            ADD.W   #SHTSPEED,(A0)          ; MOVE
            CMP.W   #SCRWIDTH-SHTWIDTH,(A0) ; KILL IF OUT OF SCREEN
            BGE     AGLKILL
            MOVEM.L A0-A1/D0-D7,-(A7)
            MOVE.W  (A0),D2                 ; PREPARE SHOT COORDINATES FOR
            MOVE.W  2(A0),D3                ; COLLISION CHECK
            MOVE.W  #SHTWIDTH,D5
            MOVE.W  #PLRHEIGH,D7
            MOVE.L  A0,A1
            MOVE.W  #ASTTYPE,D0             ; LOOP THROUGH ALL ASTEROIDS
            JSR     DMMFRSTO
.LOOP       CMP.L   #0,A0
            BEQ     .END
            MOVE.W  8(A0),D0
            MOVE.W  10(A0),D1
            MOVE.W  #ASTSIZE,D4
            MOVE.W  #ASTSIZE,D6
            JSR     UTLCHCOL
            TST.B   D0
            BNE     .EXPLO                  ; IF COLLISION, EXPLODE IT
            MOVE.W  #ASTTYPE,D0
            JSR     DMMNEXTO
            BRA     .LOOP
.END        MOVEM.L (A7)+,A0-A1/D0-D7
            RTS
.EXPLO      ADD.L   #8,A0
            JSR     ASTXPLO                 ; EXPLODE ASTEROID
            MOVE.L  A1,A0
            JSR     AGLKILL                 ; DESTROY SHOT
            ADD.W   #ASTSCORE,(PLRSCORE)    ; INCREASE SCORE
            BRA     .END

; -----------------------------------------------------------------------------
SHTPLOT
; PLOTS THE SHOT.
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L     A0/D1-D4,-(A7)
            UTLSPEN     #$00FFFFFF
            UTLSFIL     #$000000FF
            MOVE.W      (A0)+,D1
            MOVE.W      (A0),D2
            MOVE.W      D1,D3
            MOVE.W      D2,D4
            ADD.W       #SHTWIDTH,D3
            ADD.W       #SHTHEIGH,D4
            MOVE.B      #87,D0
            TRAP        #15
            ADD.W       #PLRHEIGH-SHTHEIGH,D2
            ADD.W       #PLRHEIGH-SHTHEIGH,D4
            TRAP        #15
            MOVEM.L     (A7)+,A0/D1-D4
            RTS
