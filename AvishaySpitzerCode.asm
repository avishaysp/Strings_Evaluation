;avishay spitzer's assembly project
.MODEL      small
.STACK      100h
.DATA
logo1       db '---------------------------------------------------------------------------',13,10,
            db '---A---V-------V--I--SSSSS-H---H----A---Y---Y----',13,10,
            db '--A-A---V-----V---I--S-----H---H---A-A---Y-Y-----',13,10,
            db '-AAAAA---V---V----I--SSSSS-HHHHH--AAAAA---Y------',13,10,
            db '-A---A----V-V-----I------S-H---H--A---A---Y------',13,10,
            db '-A---A-----V------I--SSSSS-H---H--A---A---Y------',13,10,
            db '-------------------------------------------------',13,10,'$'
msg1        db 13,10,'Enter 2 strings up to 120 chars each',13,10,'$'
msg2        db 13,10,'Hit any key to exit$'    
msg3        db 13,10,'This is the higher string:$'
msg4        db 13,10,'the biggest shared part from the beginning:$'
msg5        db 13,10,'the biggest shared part from the end:$'
msg6        db 13,10,'if you want to repeat, press y, enter any char to exit$'
str1        db 120
strlen1     db 0
strtxt1     db 121 dup(0)
str2        db 120
strlen2     db 0
strtxt2     db 121 dup(0)
crlf        db 13,10,'$'
mone        dw 0
lastindx     dw 0
.CODE

            mov AX,@data
            mov DS,AX

main:       call logo
shuv:       call getstr
            call bigger
            call getbegin
            call getend
            call ask
            call exit
            
            
           
            
            
logo:       lea DX,logo
            mov AH,09h
            int 21h
                       
            ret
                        
getstr:     lea DX,msg1     ;show instructions
            mov AH,09h
            int 21h 
            
            lea DX,str1     ;acceept first string
            mov AH,0Ah
            int 21h
            
            lea BX,strtxt1
            mov AH,0
            mov AL,strlen1
            add BX,AX
            mov [BX],'$'
            
            lea DX,crlf     ;crlf
            mov AH,09h
            int 21h 
            
            lea DX,str2     ;acceept second string
            mov AH,0Ah
            int 21h
            
            lea BX,strtxt2
            mov AH,0
            mov AL,strlen2
            add BX,AX
            mov [BX],'$'
            
            ret
            

            
bigger:
            
            lea DX,msg3     ;show instructions
            mov AH,09h
            int 21h
            
            lea SI,strtxt1
            lea DI,strtxt2
again:

            mov AX,[SI]
            mov BX,[DI]
            inc SI
            inc DI
            cmp AX,BX
            ja above
            jb below
            jmp again
            
above:      lea DX,crlf     ;crlf
            mov AH,09h
            int 21h
            int 21h
            
            lea DX,strtxt1     ;show first string
            mov AH,09h
            int 21h
            
            
            ret
            
below:      lea DX,crlf         ;crlf
            mov AH,09h
            int 21h
            int 21h
            
            lea DX,strtxt2     ;show second string
            mov AH,09h
            int 21h
            
            ret
            
getbegin:
            lea DX,msg4     ;show instructions
            mov AH,09h
            int 21h
            
            lea DX,crlf     ;crlf
            mov AH,09h
            int 21h
            int 21h
            
            lea SI,strtxt1     ;puting SI and DI at the start of the strings
            lea DI,strtxt2
            
again1:     mov AX,[SI]        ;compering the analogous chars
            mov BX,[DI]
            cmp AX,BX
            je incmone
            mov AX,[SI]        ;compering the analogous chars
            mov BX,[DI]
back:       cmp AX,BX
            je again1         
            inc SI             ;moving to the next chars
            inc DI
            jmp showchar
            
incmone:    inc mone
            jmp back            
                        
                  
showchar:   mov CX,0
            cmp CX,mone
            je return
            lea BX,strtxt1
shchagain:  mov DL,[BX]
            mov AH,02h
            int 21h
            
            inc BX            
            dec mone
            cmp mone,0
            ja  shchagain
                       
return:     ret
            
            
getend:     lea DX,msg5     ;show instructions
            mov AH,09h
            int 21h
            
            lea DX,crlf     ;crlf
            mov AH,09h
            int 21h
            int 21h
            
            mov mone,0
            
            lea SI,strtxt1
            lea DI,strtxt2
            mov CX,0
            mov CL,strlen1
            add SI,CX
            mov CX,0
            mov CL,strlen2
            add DI,CX
            dec DI
            dec SI
            
again2:     mov AX,[SI]
            mov BX,[DI]
            dec SI
            dec DI
            inc mone
            cmp AX,BX
            je again2
            
                  
showchar1:  mov CX,0
            cmp CX,mone
            je return
            dec mone
            lea BX,strtxt1
            mov CX,0
            mov CL,strlen1
            add BX,CX
            sub BX,mone
shchagain1: mov DL,[BX]
            mov AH,02h
            int 21h
            
            inc BX            
            dec mone
            cmp mone,0
            ja  shchagain1                         
            ret
            
ask:                    
            
            lea DX,msg6     ;show instructions
            mov AH,09h
            int 21h
             
            mov AH,01h
            int 21h
            
            cmp AL,'y'
            je shuv
exit:    
            mov AH,4Ch
            int 21h
END
             
            
            