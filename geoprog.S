.intel_syntax noprefix

.data
FORMAT 	: .asciz "%d\n"
COMPARE	: .asciz "%d - %d\n"
DEBUG  	: .asciz "%d - q=%d r=%d\n" 
OK 	: .asciz "OK\n"
NOT_OK 	: .asciz "NOT OK\n"
EXIT	: .asciz "EXIT\n"

.text
.global is_geometric
is_geometric: 
	# int summethod(int array[], int length);
	#  array  => [ebp + 4*2]
	#  length => [ebp + 4*3]

	push ebp
	mov ebp, esp

	# cdecl
	push ebx			# !pop ebx
	
	#-if (length <= 1) exit
	cmp DWORD PTR [ebp + 4*3], 0x1
	jle exit_0	
	
	# ebx (array) := array
	mov ebx, [ebp + 4*2]

	#-if (array[0] == 0) 
	cmp DWORD PTR [ebx + 4*0], 0x0 
	je quotient_0 
	
	# eax:edx (quotient) := array[1] / array[0]
	mov eax, [ebx + 4*1]
	cdq
	idiv DWORD PTR [ebx + 4*0]

	push eax  			# revert 4*1
	jmp start	


	quotient_0:
		push 0x0
		jmp start

	start:
	# ecx (i) := 1 
	mov ecx, 0 			
	loop: # for(int i = 1; i < length; i++);
		# i 	   := ecx
		# arr[i]   := [ebx + 4 * ecx]
		# quotient := [ebp - 4 * 2]

		#-if (i + 1 >= length) exit
		inc ecx
		cmp ecx, [ebp + 4 * 3]
		jge return_1
		dec ecx	
		
		# eax := arr[i] * q
		mov eax, [ebx + 4 * ecx]
		imul eax, DWORD PTR [ebp - 4 * 2]	
		
		#-if (arr[i] * q != arr[i + 1]) kilep
		cmp eax, DWORD PTR [ebx + 4 * (ecx + 1)]
		jne return_0	

		#push ecx

		#push eax
		#push [ebp - 4 * 2]
		#push [ebx + 4 * ecx]
		#push offset DEBUG
		#call printf
		#add esp, 4*4

		#pop ecx		
	
		# i++
		inc ecx	
		jmp loop
	
	return_1:
		# print('OK');
		#push offset OK
		#call printf
		#add esp, 4*1

		# return 1
	 	mov eax, 1
		jmp revert

	return_0:
		# print('NOT OK');
		#push offset NOT_OK
		#call printf
		#add esp, 4*1
	
		# return 0
		mov eax, 0
		jmp revert
	
	exit_0:
		# print('EXIT')
		#push offset EXIT		
		#call printf
		#add esp, 4*1

		mov eax, 0
		jmp return	
	
	revert:
		# revert stack	
		add esp, 4*1

		jmp return	

	return: 
		# cdecl
		pop ebx		

		mov esp, ebp
		pop ebp

		ret
