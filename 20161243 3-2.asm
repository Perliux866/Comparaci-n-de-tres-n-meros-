;Macro para mostrar mensajes
MostrarMensaje Macro mensaje
  mov ah, 09h
    lea dx, mensaje
    int 21h  
endm 
; Macro para solicitar numerosxd
solicitarNumero Macro registro
    mov ah, 01h
    int 21h         
    sub al, '0'     
    mov registro, al
endm

; Macro para comparar 
comparaTres Macro
    cmp bl, bh
    ja primerMayor     
    jb segundoMayor     
    je segundo         

segundo:
    cmp bl, cl
    ja primerMayor      
    jb tercerMayor      
    je igual            
endm

; Segmento de pila
pila segment stack
    db 32 dup(0)
pila ends

; Segmento de datos
data segment
    ingresarPN db 10,13, 'Ingrese primer numero: $'
    ingresarSN db 10,13, 'Ingrese segundo numero: $'
    ingresarTN db 10,13, 'Ingrese tercer numero: $'
    primerMayorMsg db 10,13, 'El primer numero es el mayor $'
    segundoMayorMsg db 10,13, 'El segundo numero es el mayor $'
    tercerMayorMsg db 10,13, 'El tercer numero es el mayor $'
    todosIgualesMsg db 10,13, 'Los tres numeros son iguales $'
data ends

; Segmento de codigo
code segment
principal proc far
    assume cs:code, ds:data, ss:pila
    push ds
    push 0
    
    ; Inicializar segmento de datos
    mov ax, data
    mov ds, ax

    ; Modo de video
    mov ah, 00h
    mov al, 03h
    int 10h

    ; Solicitar el primer numero
    MostrarMensaje ingresarPN
    solicitarNumero bl

    ; Solicitar el segundo numero
    MostrarMensaje ingresarSN
    solicitarNumero bh

    ; Solicitar el tercer numero
    MostrarMensaje ingresarTN
    solicitarNumero cl

    ; Comparar 
    comparaTres

primerMayor:
    MostrarMensaje primerMayorMsg
    jmp final

segundoMayor:
    
    MostrarMensaje segundoMayorMsg
    jmp final

tercerMayor:
   
    MostrarMensaje tercerMayorMsg
   
    jmp final

igual:
    
    MostrarMensaje todosIgualesMsg
    
    jmp final

final:
    
    mov ax, 4Ch
    int 21h

principal endp
code ends
end principal
