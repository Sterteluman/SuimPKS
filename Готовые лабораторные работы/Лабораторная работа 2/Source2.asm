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
  xor eax, eax ; ������� ���������
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
  mov [M], eax		    ; ���������� ���������� � M
  add ebx, [M]			; EBX = EBX + M

  cmp ebx, 21h          ; ���������� edx � 0x21h
  jg sravnenye_more		; ���� ��������� ������, �� ��������� � sravnenye_more
  jle sravnenye_less    ; ����� � sravnenye_less

  sravnenye_more:
	or ebx, 0FF0h ; ebx = M or 0FF0h
	jmp last_step ; 

  sravnenye_less:
	and ebx, 1028h
	mov [R], ebx
	jmp last_step ;

  last_step:
	 test ebx, ebx;
	 js ADR2   ; ���� �������������, ������� � ���1, ���� �������������, �� � ���2 


ADR1:
  clc			 ; ����� ����� �������� (CF = 0)
  stc			 ; ��������� ����� �������� (CF = 1)
  rcl ebx, 3	 ; ����������� ����� ����� ����� CF �� 3 ����
  jmp last       ; ������� � ����������

ADR2:
  ror [R], 2	 ; ����������� ����� ������ ���������� R �� 2 ����
  jmp last		 ; ������� � ����������
	

last:
  Invoke ExitProcess, 0

End Start
