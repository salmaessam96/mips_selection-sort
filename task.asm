.data
x: .word 3,2,8,9,4,6
n: .word 6
.text
la $s0,x               #base address of array x
la $t0,n                #size address
lw $s2,0($t0)           #$s2=n=6

main:
addi $sp,$sp,-4  
sw $ra,0($sp)
move $a0,$s0
move $a1,$s2
jal sort   #call sort(x[],n)
lw $ra,0($sp)
addi $sp,$sp,4  

#--------------------------------------------------------------------------------------------------------------#

sort:
addi $sp,$sp,-16   # saving on the stack
sw $ra,0($sp)
sw $s0,4($sp)
sw $s2,8($sp)
sw $s3,12($sp)
move $s0,$a0	    # $s0=base address of x
move $s2,$a1        #$s2=n=6
add $s1,$zero,$zero # $s1=i=0

Sforloop:
bge $s1,$s2,endfor  #i<=n
move $a0,$s0          #first arg=base address of x
move $a1,$s2	      #second arg=n
move $a2,$s1	      #third arg=i
jal min              #call min(x,n,i)
move $s3,$v0	    #idx=return value of procedure min
move $a0,$s0	    #first arg=base address of x
move $a1,$s3	    #second arg=idx
move $a2,$s1	    #third arg=i
jal swap            #call swap(x,idx,i)
addi $s1,$s1,1	  #incrementing i
j Sforloop	

endfor:
lw $ra,0($sp)
lw $s0,4($sp)
lw $s2,8($sp)
lw $s3,12($sp)
addi $sp,$sp,16
jr $ra	

#-----------------------------------------------------------------------------------------------------------------------#

min:
addi $sp,$sp,-4
sw $s3,0($sp)
move $t0,$a0	#$t0=base of the array
move $t1,$a1	#$t1=n
move $t2,$a2	#$t2=start
add $s3,$t2,$zero  #idx=start
sll $t3,$t2,2
add $t3,$t3,$t0	
lw $t4,0($t3)	#min=x[start]
add $t5,$t2,$zero  #int i=$t5=start

Mforloop:
bge $t5,$t1,minend
sll $t6,$t5,2
add $t6,$t6,$t0	
lw $t7,0($t6)	 #$t7=x[i]
bge $t7,$t4,Mifexit  #if(x[i]<min)
move $t4,$t7	#min=x[i]
move $s3,$t5	#idx=i

Mifexit:	
addi $t5,$t5,1	#incrementing i
j Mforloop

minend:	
move $v0,$s3	#return idx
lw $s3,0($sp)
addi $sp,$sp,4
jr $ra

#-----------------------------------------------------------------------------------------------------------------------#

swap:
sll $t1,$a1,2	#$t0=i
sll $t2,$a2,2   #$t1=j
add $t1,$a0,$t1
add $t2,$a0,$t2
lw $t0,0($t1)	#$t2=x[i]
lw $t3,0($t2)	#$t3=x[j]
add $t4,$t0,$zero  #$t4=temp=x[i]
sw $t3,0($t1)   #$x[i]=x[j]
sw $t4,0($t2)   #x[j]=temp
jr $ra	
