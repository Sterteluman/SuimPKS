.686
.model flat,stdcall
.stack 100h
.data
array_start		dd 0.5, 1.0, 0.9 ; ���������� ��������� ������ 3x3
				dd 0.1, 2.0, 0.2
				dd 0.3, 4.0, 3.0

array_sin 		dd 0.0, 0.0, 0.0 ; ������ 3x3 ��� �������� �������
		  		dd 0.0, 0.0, 0.0
		 		dd 0.0, 0.0, 0.0

array_cos 		dd 0.0, 0.0, 0.0 ; ������ 3x3 ��� �������� ���������
		  		dd 0.0, 0.0, 0.0
		  		dd 0.0, 0.0, 0.0
i dd 0	; ������� �����
j dd 0	; ������� ��������
n dd 3	; ����������� �������
temp dd 0.0		; ��������� ����������
mysize dd 4		; ������ ������

.code
ExitProcess PROTO STDCALL :DWORD
Start:
	
	finit; ; ������������� ������������ FPU

L1:
	mov j, 0; ��������� �������� �������� 
	xor eax, eax;
	xor ebx, ebx;
	xor ecx, ecx;

L2:
	mov eax, n; ;�������� ������� ������� � EAX
	mul i;		;��������� EAX �� ������� ������ ������ (i)
	add eax, j; ; ���������� �������� ������� ������� (j) ��� ���������� ��������� �������
	mul mysize; ; ��������� �� ������ �������� (4 �����) ��� ��������� ��������� ��������

	fld array_start[eax]; �������� �������� ������� array_start � ���� FPU. ������ � ��������
	fld array_start[eax];

	fsin;					���������� sin
	fstp array_sin[eax];
	fcos;					���������� cos
	fstp array_cos[eax];

	inc j;					��������� ������ j, ���������� ��������
	mov ebx, j;
	mov ecx, n;
	cmp ebx, ecx;			��������� �������� �������� � �������� �������, ���� �� ����� - ������� �� L2
	jne L2;
			
	inc i;					��������� ������ i
	mov ebx, i;
	mov ecx, n;
	cmp ebx, ecx;
	jne L1;

exit:
Invoke ExitProcess,1
End Start
