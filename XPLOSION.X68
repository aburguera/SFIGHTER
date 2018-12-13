; =============================================================================
; EXPLOSTION MANAGEMENT. IS AN AGENT.
; LOCAL MEMORY IS:
; +0 WORD X COORDINATE
; +2 WORD Y COORDINATE
; +4 WORD X SPEED
; +6 WORD Y SPEED
; =============================================================================

; -----------------------------------------------------------------------------
XPLINIT
; INITALIZES AN EXPLOSION ITEM
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
;            D1 X COORDINATE
;            D2 Y COORDINATE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - ASSUMES SCRHEIGH IS GREATER THAN 255
; -----------------------------------------------------------------------------
            MOVEM.L D0-D2,-(A7)
            MOVE.W  D1,(A0)                 ; SET X POSITION
            MOVE.W  D2,2(A0)                ; SET Y POSITION
            JSR     UTLRAND                 ; SET RANDOM SPEEDS
            AND.W   #$01F,D0
            SUB.W   #$0F,D0
            MOVE.W  D0,4(A0)
            JSR     UTLRAND
            AND.W   #$01F,D0
            SUB.W   #$0F,D0
            MOVE.W  D0,6(A0)
            MOVEM.L (A7)+,D0-D2
            RTS

; -----------------------------------------------------------------------------
XPLUPD
; UPDATES AN EXPLOSION ITEM
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  D0,-(A7)
            MOVE.W  4(A0),D0                ; UPDATE COORDINATES
            SUB.W   D0,(A0)
            MOVE.W  6(A0),D0
            ADD.W   D0,2(A0)
            CMP.W   #-XPLSIZE,(A0)
            BLE     .KILL
            CMP.W   #SCRWIDTH,(A0)
            BGE     .KILL
            CMP.W   #-XPLSIZE,2(A0)
            BLE     .KILL
            CMP.W   #SCRHEIGH,2(A0)
            BGE     .KILL
.END        MOVE.W  (A7)+,D0
            RTS
.KILL       JSR   AGLKILL
            BRA   .END

; -----------------------------------------------------------------------------
XPLPLOT
; PLOTS AN EXPLOSION ITEM
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            UTLSPEN #XPLPENCL
            UTLSFIL #XPLFILCL
            MOVEM.W D1-D4,-(A7)
            MOVE.W  (A0),D1
            MOVE.W  2(A0),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #XPLSIZE,D3
            ADD.W   #XPLSIZE,D4
            MOVE.B  #88,D0
            TRAP    #15
            MOVEM.W (A7)+,D1-D4
            RTS
