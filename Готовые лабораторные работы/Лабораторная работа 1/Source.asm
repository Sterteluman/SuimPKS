.686
.model flat,stdcall

.stack 100h

.data

x db 11
y db 5
z db 76



.code
ExitProcess PROTO STDCALL :DWORD
Start:
  ; �������� ��������, ����� �� ���������� � �������� (�������������)
  xor eax,eax
  xor ebx,ebx
  xor ecx,ecx

  ; �������� ���������� z
  mov al, [z]
  not al

  ; �������� X + Y
  add bl, [x]
  add bl, [y]

  ; ����������� ���
  xor al, bl

  ; ��������� X - Y
  sub bl, [y]
  sub bl, [y]
  
  ; ���������� ���� ����������
  and al, bl



exit:
Invoke ExitProcess,1
End Start