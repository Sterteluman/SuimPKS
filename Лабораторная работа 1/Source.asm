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
  ; Зануляем регистры, чтобы не запутаться в расчетах (дополнительно)
  xor eax,eax
  xor ebx,ebx
  xor ecx,ecx

  ; Инверсия переменной z
  mov al, [z]
  not al

  ; Сложение X + Y
  add bl, [x]
  add bl, [y]

  ; Исключающее ИЛИ
  xor al, bl

  ; Вычитание X - Y
  sub bl, [y]
  sub bl, [y]
  
  ; Конъюнкция двух переменных
  and al, bl



exit:
Invoke ExitProcess,1
End Start