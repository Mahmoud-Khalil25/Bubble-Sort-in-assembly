 .model tiny 
.data
 
playersId db 25 dup(?)  
recordedTime db 25 dup(?)   
sortedId     db 25 dup(?)
sortedTime     db 25 dup(?)
MSG1 db "THIS IS PROJECT #5$"
MSG2 db "DONE BY MAHMOUD AHMED #6375$"
MSG3 db "ENTER THE ID OF PLAYER no: $"  
MSG4 db "ENTER THE TIME OF PLAYER no: $"
MSG5 db "----------------------------$"  
MSG6 DB "PLAYERS ID: $"
MSG7 DB "PLAYERS RECORDED TIME: $"

MSG DB "ENTER A NUMBER: $"
TOTAL DB 0
VALUE DB 0 
ten   DB 10

.code



main proc near
   begin:
   mov ax,@data
   mov ds,ax 
   mov ah,9        ;display msg 1
   lea dx,MSG1
   int 21h 
   
   mov ah,2
   mov dl,0Ah  
   int 21h        ;empty line
   mov dl,0Dh
   int 21h  
   
   
   mov ah,9         ;Display msg 2
   lea dx,MSG2
   int 21h
   
   mov ah,2
   mov dl,0Ah  
   int 21h        ;empty line
   mov dl,0Dh
   int 21h
   
   mov ah,9         ;Display msg 5
   lea dx,MSG5
   int 21h  
        
   
   mov ah,2
   mov dl,0Ah  
   int 21h        ;empty line
   mov dl,0Dh
   int 21h  
   
   mov cx,1
   mov si,00
   
   
   
   EnterIDMSG: 
   
   mov ah,2
   mov dl,0Ah  
   int 21h        ;empty line
   mov dl,0Dh
   int 21h 
   
   MOV AH, 9
   LEA DX, MSG3
   INT 21H 
   
   MOV AX,CX   ;ssdfs
   PUSH CX
   CALL PRINT 
   POP CX
   
    mov ah,2
    mov dl,0Ah  
    int 21h        ;empty line
    mov dl,0Dh
    int 21h
    push cx 
    mov cx,00 
    mov bl,10
    
    IDRead:
    MOV AH,1
    INT 21H
    CMP AL,13
    JE NumProcessing ;NUMBER PROCESSING
    SUB AL,48 ;CONVERT ASCII TO DECIMAL
    MOV AH,0
    PUSH AX
    INC CX
    JMP IDRead 
    
    NumProcessing:
    pop ax
    add al,TOTAL
    mov TOTAL,al 
    cmp cx,1
    je StoreId
    dec cx
    
    AboveTens: 
    pop ax
    mov ah,0
    mul bl ;intially 10
    add TOTAL,al 
    mov al,bl
    mul ten
    mov bl,al    ; second pass 100
    loop AboveTens 
    
    StoreId:
    pop cx        ; intial till 25 index counter
  ;  LEA SI,playersId
    MOV AL,TOTAL  
    MOV dl,0
    MOV TOTAL,dl  ; make total equal to zero for other passes
    MOV playersId[SI],AL 
    mov ah,2
    mov dl,0Ah  
    int 21h        ;empty line
    mov dl,0Dh
    int 21h 
   
    mov ah,9         ;Display msg 4
    lea dx,MSG4
    int 21h  
    MOV AX,CX   ;ssdfs
    PUSH CX
    CALL PRINT 
    POP CX
    
    mov ah,2
    mov dl,0Ah  
    int 21h        ;empty line
    mov dl,0Dh
    int 21h 
    push cx
    mov bl,10 
    Mov cx,00
    
    
    TimeRead: 
    
    MOV AH,1
    INT 21H
    CMP AL,13
    JE TimeProcessing ;NUMBER PROCESSING  
     MOV AH,0
    SUB AL,48 ;CONVERT ASCII TO DECIMAL
    PUSH AX
    INC CX
    JMP TimeRead 
    
    TimeProcessing:
    pop ax
    add al,TOTAL
    mov TOTAL,al 
    cmp cx,1
    je StoreTime
    dec cx
    
    AboveTensTime: 
     pop ax
    mov ah,0
    mul bl
    add TOTAL,al 
    mov al,bl
    mul ten
    mov bl,al
    loop AboveTensTime
    
    StoreTime:
    pop cx
   ; LEA SI,recordedTime
    MOV AL,TOTAL  
    MOV dl,0
    MOV TOTAL,dl
    MOV recordedTime[SI],AL   
    
    INC SI 
    
    INC CX  
    
    
    CMP CX,25
    JLE EnterIDMSG 
            

    FINISHED: 
    MOV CX,24  
    
    MOV SI,00   ;COUNTER

BUBBLESORT:
CMP CX,SI
JZ NEXT
MOV AL,recordedTime[SI] ;ARRAY[i]
MOV BL,recordedTime[SI+1]
CMP AL,BL
JA EXCHANGE 
ADD SI,1   ;INC ACCOUNT
JMP BUBBLESORT


EXCHANGE:
MOV recordedTime[SI],BL   ;SWAP
MOV recordedTime[SI+1],AL 

MOV AL,playersId[SI] ;ARRAY[i]
MOV BL,playersId[SI+1]

MOV playersId[SI],BL   ;SWAP
MOV playersId[SI+1],AL 

ADD SI,1
JMP BUBBLESORT  

NEXT:  
MOV SI,00   ;ENTER NEXT LOOP
SUB CX,1
CMP CX,0
JNZ BUBBLESORT 

mov ah,2
mov dl,0Ah  
int 21h        ;empty line
mov dl,0Dh
int 21h   

mov ah,9         ;Display msg 5
lea dx,MSG5
int 21h  

mov ah,2
mov dl,0Ah  
int 21h        ;empty line
mov dl,0Dh
int 21h  

MOV SI,00 



DISPAYARRAY:
mov ah,9         ;Display msg 6
lea dx,MSG6
int 21h

mov ah,2
mov dl,0Ah  
int 21h        ;empty line
mov dl,0Dh
int 21h
mov ah,00
mov al,playersId[SI]
call PRINT  

mov ah,2
mov dl,0Ah  
int 21h        ;empty line
mov dl,0Dh
int 21h 

mov ah,9         ;Display msg 7
lea dx,MSG7
int 21h




mov ah,2
mov dl,0Ah  
int 21h        ;empty line
mov dl,0Dh
int 21h    

mov ah,00
mov al,recordedTime[SI] 
call print


mov ah,2
mov dl,0Ah  
int 21h        ;empty line
mov dl,0Dh
int 21h  
inc si

CMP SI,25
JL DISPAYARRAY






   
    
    
    
    
    
 
   
    
     
  
  
  PRINT PROC          
     
    ;initialize count
    mov cx,0
    mov dx,0
    label1:
        ; if ax is zero
        cmp ax,0     ;ax element i ewant to print
        je print1     ;extracted all elements
         
        ;initialize bx to 10        ;count num of digit
        mov bx,10       
         
        ; extract the last digit
        div bx                 
         
        ;push it in the stack
        push dx                               ;we want to print 1234
                                               ;After div by 10
                                               ;al-123
                                               ;last digit pushed into stack
                                               ;at end
                                               ;stack
                                              ; 1   Top of the stack
                                            
                                              ; 2
                                              ; 3
                                              ; 4
         
        ;increment the count                  ;add 48 to return to ascii for display
        inc cx             
         
        ;set dx to 0
        xor dx,dx
        jmp label1
    print1:
        ;check if count
        ;is greater than zero
        cmp cx,0
        je exit
                                            ;quotient in al
        
        pop dx
         
        ;add 48 so that it
        ;represents the ASCII
        
        add dx,48
         
        
        
        mov ah,02h
        int 21h
         
        ;decrease the count
        dec cx
        jmp print1
exit:
ret
PRINT ENDP
end main
  
  
   