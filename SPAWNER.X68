; =============================================================================
; SPAWNER MANAGEMENT.
; =============================================================================

; -----------------------------------------------------------------------------
SPWUPD
; UPDATES THE SPAWNER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L  D0/A1-A3,-(A7)
            MOVE.B  (SCRCYCCT),D0
            AND     #$0F,D0                 ; EVERY 16 CYCLES
            BNE     .END                    ; CREATE A NEW ASTEROID
            LEA     ASTINIT,A1
            LEA     ASTUPD,A2
            LEA     ASTPLOT,A3
            MOVE.W  #ASTTYPE,D0
            JSR     AGLADD
.END        MOVEM.L (A7)+,D0/A1-A3
            RTS
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
