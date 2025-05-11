.686
.model flat, stdcall
.stack 100h

.data
  X dd 8A64h ;
  Y dd 0B3D1h ;
  Q dd 88BDh ;
  M dd ?     ;
  R dd ?     ;

.code
  ExitProcess PROTO STDCALL :DWORD

Start:
  xor eax, eax ; очистка регистров
  xor ebx, ebx ;
  xor ecx, ecx ;
  xor edx, edx ;

  mov cx, 4    ; loop 4 times

cycle_4:
  movzx eax, word ptr [X]      ; ax = X
  shl eax, 2					 ; ax = X * 4
 
  movzx ebx, word ptr [Y]      ; bx = Y
  shl ebx, 2					 ; bx = Y * 4

  movzx edx, word ptr [Q]      ; dx = Q
  shl edx, 2					 ; dx = Q * 4

  loop cycle_4 ;

sravnenye:
  ; M = X + Y - Q
  sub eax, edx          ; EAX = EAX - EDX
  mov [M], eax		    ; сохранение результата в M
  add ebx, [M]			; EBX = EBX + M

  cmp ebx, 21h          ; сравниваем edx с 0x21h
  jg sravnenye_more		; если результат больше, то переходим в sravnenye_more
  jle sravnenye_less    ; иначе в sravnenye_less

  sravnenye_more:
	or ebx, 0FF0h ; ebx = M or 0FF0h
	jmp last_step ; 

  sravnenye_less:
	and ebx, 1028h
	mov [R], ebx
	jmp last_step ;

  last_step:
	 test ebx, ebx;
	 js ADR2   ; если положительное, переход к АДР1, если отрицательное, то к АДР2 


ADR1:
  clc			 ; Сброс флага переноса (CF = 0)
  stc			 ; Установка флага переноса (CF = 1)
  rcl ebx, 3	 ; Циклический сдвиг влево через CF на 3 бита
  jmp last       ; Переход к завершению

ADR2:
  ror [R], 2	 ; Циклический сдвиг вправо переменной R на 2 бита
  jmp last		 ; Переход к завершению
	

last:
  Invoke ExitProcess, 0

End Start
