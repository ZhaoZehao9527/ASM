
data segment
	str1 db 'Please input username:',0dh,0ah,'$'
	username db 'zzh'
	cr db 0dh,0ah,'$'
	buffer db 40,0,40 DUP(?)
	mtch db 'match',0dh,0ah,'$'
	nmth db 'not match',0dh,0ah,'$'
data ends

code segment
	assume cs:code,ds:data
start:	
		;输出提示字符串并换行
		mov ax,data
		mov ds,ax
		lea dx,str1		;获取要显示字符串的首地址
		mov ah,9		;No9，输出提示字符串
		int 21h		
		lea dx,cr
		mov ah,9
		int 21
		
		lea dx,buffer	
		mov ah,0ah		;No10，从buffer读取输入的字符串
		int 21h
		
		;获取用户输入的字符串并输出
		mov cl,buffer+1
		xor ch,ch
		lea dx,buffer+2
		mov bx,dx
		add bx,cx
		mov byte ptr[bx],'$'
		mov ah,9		
		int 21h
		
		lea dx,cr
		mov ah,9
		int 21
		
		
		;输出username并换行
		lea dx,username	
		mov ah,9
		int 21h
		lea dx,cr
		mov ah,9
		int 21
		
		lea si,username
		lea di,buffer+2
		cld
		repz cmpsb
		jz match
		jnz nomatch
		
match:	mov ah,9
		lea dx,mtch
		int 21h
		jmp done
		
nomatch:mov ah,9
		lea dx,nmth
		int 21h
		jmp	done
		
done:	mov ah,1
		int 21h
		mov ah,4ch
		int 21h
		
code ends  
end start  
		
		
		
		
		
		

		
	
	