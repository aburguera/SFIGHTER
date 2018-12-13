; =============================================================================
; PLAYER MANAGEMENT
; =============================================================================

; -----------------------------------------------------------------------------
PLRINIT
; INITIALIZES THE PLAYER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #PLRWIDTH/2,(PLRPOSX)
            MOVE.W  #(SCRHEIGH-PLRHEIGH)/2,(PLRPOSY)
            MOVE.W  #PLRINIEN,(PLRENER)
            CLR.W   (PLRSCORE)
            CLR.W   (PLRDMG)
            RTS

; -----------------------------------------------------------------------------
PLRUPD
; UPDATES THE PLAYER MOTION
; INPUT    - NONE (ACCESSES KBDVAL AND KBDEDGE)
; OUTPUT   - NONE (MODIFIES PLAYER DATA)
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BCLR.B  #PLRUBDMG,(PLRDMG)
            BEQ     .NODMG
            SUB.W   #ASTDMG,(PLRENER)
            BGT     .NODMG
            MOVE.W  #STAGOVR,(STANEXT)      ; IF LIFE IS 0, GAME OVER
.NODMG      MOVE.W  D1,-(A7)
            MOVE.B  (KBDVAL),D1             ; PERFORM MOTION AND CHECK BOUNDS.
            ROR.B   #1,D1
            BCC     .CHKUP
            SUB.W   #PLRSPEED,(PLRPOSX)
            TST.W   (PLRPOSX)
            BGE     .CHKUP
            CLR.W   (PLRPOSX)
.CHKUP      ROR.B   #1,D1
            BCC     .CHKRT
            SUB.W   #PLRSPEED,(PLRPOSY)
            TST.W   (PLRPOSY)
            BGE     .CHKRT
            CLR.W   (PLRPOSY)
.CHKRT      ROR.B   #1,D1
            BCC     .CHKDN
            ADD.W   #PLRSPEED,(PLRPOSX)
            CMP.W   #SCRWIDTH-PLRWIDTH,(PLRPOSX)
            BLE     .CHKDN
            MOVE.W  #SCRWIDTH-PLRWIDTH,(PLRPOSX)
.CHKDN      ROR.B   #1,D1
            BCC     .MDONE
            ADD.W   #PLRSPEED,(PLRPOSY)
            CMP.W   #SCRHEIGH-PLRHEIGH,(PLRPOSY)
            BLE     .MDONE
            MOVE.W  #SCRHEIGH-PLRHEIGH,(PLRPOSY)
.MDONE      BTST.B  #KBDBITF1,(KBDEDGE)
            BEQ     .NOFIRE
            MOVEM.L A1-A3/D0-D2,-(A7)
            LEA     SHTINIT,A1
            LEA     SHTUPD,A2
            LEA     SHTPLOT,A3
            MOVE.W  #SHTTYPE,D0
            MOVE.W  (PLRPOSX),D1
            MOVE.W  (PLRPOSY),D2
            JSR     AGLADD
            MOVEM.L (A7)+,A1-A3/D0-D2
.NOFIRE     MOVE.W  (A7)+,D1
            RTS

; -----------------------------------------------------------------------------
PLRPLOT
; PLOTS THE PLAYER ITS LIFE AND THE SCORE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            MOVE.L  #PLRNRMCL,D1            ; DECIDE COLOR
            BCLR.B  #PLRPBDMG,(PLRDMG)
            BEQ     .NODMG
            MOVE.L  #PLRDMGCL,D1
.NODMG      MOVE.B  #80,D0
            TRAP    #15
            ADDQ.B  #1,D0
            TRAP    #15
            MOVE.W  (PLRPOSX),D1            ; PLOT THE PLAYER
            MOVE.W  (PLRPOSY),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #PLRWIDTH,D3
            ADD.W   #PLRHEIGH,D4
            MOVE.B  #88,D0
            TRAP    #15
            SUB.W   #PLRWIDTH/2,D3
            MOVE.B  #87,D0
            TRAP    #15

            UTLSPEN #PLRTXTCL               ; PLOT THE SCORE TEXT
            UTLSFIL #$00000000
            UTLLOCT PLRTXTX,PLRTXTY
            LEA     .SCORESTR,A1
            CLR.L   D1
            MOVE.W  (PLRSCORE),D1
            MOVE.B  #17,D0
            TRAP    #15

            UTLSPEN #$00FFFFFF              ; PLOT LIFE
            UTLSFIL #PLRLIFEC
            MOVE.W  #(SCRWIDTH-PLRINIEN)/2,D1
            MOVE.W  #PLRLIFEY,D2
            MOVE.W  (PLRENER),D3
            ADD.W   D1,D3
            MOVE.W  #PLRLIFEY+PLRLIFEH,D4
            MOVE.B  #87,D0
            TRAP    #15
            MOVE.W  #(SCRWIDTH+PLRINIEN)/2,D3
            MOVE.B  #90,D0
            TRAP    #15

            MOVEM.L (A7)+,D0-D4
            RTS
.SCORESTR   DC.B    'SCORE: ',0





*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
