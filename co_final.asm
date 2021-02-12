#TASK Nour
.data
	ourChoicePrint: .asciiz "\n1-how many word occure \n2-how many char occure \n3-Search on a specific word/character and get all results -And- Find and replace for a character or a word \n4-FreqCharEq \n5-Quick Sort\n"
	userChoice:     .asciiz "\n Enter Your Choice : "
	paragraph: .space 100
	swa: .space 100
	rw: .space 100
	w: .space 100
	token:             .space 100              # space for each word that will cut from user string
	arrOfString:       .word  0:100                # array that use to stor each word in it to can make quick Sort
	newline:           .asciiz "\n" 
	spacechar:         .asciiz " " 
	flag: .word 0
	i: .word 0
	j: .word 0
	k: .word 0
	m: .word 0
	n: .word 0 
	l: .word 0
	found: .word
	tosearch: .space 100
	ch: .space 1
	numbers: .space 100
	firstPrint: .asciiz "\nPlease enter the Paragraph : \n"
	secondPrint: .asciiz "Please enter the word to search for and replace: \n"
	thirdPrint: .asciiz "Please enter the replace word or char : \n"
	forthPrint: .asciiz "your word to search not found : \n"
	fifthPrint: .asciiz "Output = " 
	#full: .space 300
	letter: .word
	str: .space 50
	 space :   .word 0
 len : .word -1 
  count :    .word 1
 arr1 : .space 100 
 arr : .space 10000   # arr[100][100]
 MessageToUser : .asciiz "please enter the paragraph :\n"
 Message2      : .asciiz " times"
 Message3      : .asciiz " Occurs-> "
 CharMessage: .asciiz "The Character "
OccursMessage: .asciiz " Occurs "
FreqArr: .space 100
	wordMessage: .asciiz "please enter the word to Count: \n"
	wordMessage2: .asciiz "the occurence of the word:  "
	wordMessage3: .asciiz "Quick Sort Output :  "
	chars_arr: .word   0 : 32 
freq_arr: .word   0 : 32
size: .word  32 


$s0:i 	# load counter 
Msg1:.asciiz "carachter"
Msg2:.asciiz"has freq of 1 \n"
Msg3:.asciiz"has freq of 2 \n" 
Msg4:.asciiz"has freq of 3 \n"

################################################################# main ##############################################################3
.text
	main:
		#Display message to user -- enter string
		li $v0, 4
		la $a0, firstPrint
		syscall
		
		# Scanning message
		li $v0, 8 #accept input from user
		la $a0, paragraph #address where we store the user input
		li $a1, 100 #maximum length of characters
		syscall
		
		#Display message to user -- choice
		li $v0, 4
		la $a0, ourChoicePrint
		syscall
		
		#Display message to user -- choice
		li $v0, 4
		la $a0, userChoice
		syscall
		
		
		li $v0, 5
		syscall
		move $t0, $v0
		
		beq $t0,1,Word_Statistics 
		beq $t0,2,Frequency
		beq $t0,3,countWordOccureAndReplaceWord
		beq $t0,4,FreqCharEq
		beq $t0,5,StartQucikSort

				
################################################## count Word Occure And Replace Word #########################################
	countWordOccureAndReplaceWord:
		li $s0,0 
		remove11:
		    lb $a3,paragraph($s0)    # Load character at index
		    addi $s0,$s0,1      # Increment index
		    bnez $a3,remove11     # Loop until the end of string is reached
		    beq $a1,$s0,skip11    # Do not remove \n when string = maxlength
		    subiu $s0,$s0,2     # If above not true, Backtrack index to '\n'
		    sb $0, paragraph($s0)    # Add the terminating character in its place
		    skip11:
		
		jal CountOccurrences
		
		li $t6, '\n'
		sb $t6, letter
  		    
  		lb $a0, letter
		li $v0, 11   # print_character
		syscall
		
		    		    		    
		#Display message to user
		li $v0, 4
		la $a0, secondPrint
		syscall
		
		# Scanning Paragraph
		li $v0, 8 #accept input from user
		la $a0, swa #address where we store the user input
		li $a1, 100 #maximum length of characters
		syscall
		
		 li $s0,0        # Set index to 0
		    remove:
		    lb $a3,swa($s0)    # Load character at index
		    addi $s0,$s0,1      # Increment index
		    bnez $a3,remove     # Loop until the end of string is reached
		    beq $a1,$s0,skip    # Do not remove \n when string = maxlength
		    subiu $s0,$s0,2     # If above not true, Backtrack index to '\n'
		    sb $0, swa($s0)    # Add the terminating character in its place
		    skip:
		
		
		
		#Display message to user
		li $v0, 4
		la $a0, thirdPrint
		syscall
		
		# Scanning Paragraph
		li $v0, 8 #accept input from user
		la $a0, rw #address where we store the user input
		li $a1, 100 #maximum length of characters
		syscall
	
		 li $s0,0        # Set index to 0
		    remove1:
		    lb $a3,rw($s0)    # Load character at index
		    addi $s0,$s0,1      # Increment index
		    bnez $a3,remove1     # Loop until the end of string is reached
		    beq $a1,$s0,skip1    # Do not remove \n when string = maxlength
		    subiu $s0,$s0,2     # If above not true, Backtrack index to '\n'
		    sb $0, rw($s0)    # Add the terminating character in its place
		    skip1:
		
		
		#Display message to user
		li $v0, 4
		la $a0, fifthPrint
		syscall
		
	#	la $a0, paragraph
	#	la $a1, w
	#	la $a2, swa
	#	jal FindAndReplace
	
		 li $t0, 0  # i
		li $t1, 0  # k	
		li $t2, 0  # flag
  		la $t3, paragraph # S1
  		la $t4, w  # w
		la $t5, swa   # swa
		
		forloop:
			add $s0, $t3,$t0
			lb $s1,0($s0)
			beqz $s1, ExitFor
			beq $s1, ' ', ElseFor
			add $s2, $t4, $t1
			sb $s1, 0($s2)   # w[k] = s[i] 
			addi $t1, $t1, 1
			j inc
			ElseFor:
			add $s2, $t4, $t1
			li $s3, '\0'
			sb $s3, 0($s2)
			andi $t1, $t1,0
			
			
			
			
			la $a0, w
			la $a1, swa
			
			jal compare
			move $t6, $v0
		#	li $v0,1     #prepare system call 
		#	move $a0,$t6 #copy t0 to a0 
		#	syscall 
			bnez $t6, elseelse
			li $t2, 1
			# print rw
			li $v0, 4
			la $a0, rw
			syscall
			
			li $s5, ' '
			li $v0,11     #prepare system call 
			move $a0,$s5 #copy t0 to a0 
			syscall 
			
			
			j inc
			elseelse:
			#print w
			
			li $v0, 4
			la $a0, w
			syscall
			
			li $s5, ' '
			li $v0,11     #prepare system call 
			move $a0,$s5 #copy t0 to a0 
			syscall 
			
		inc:
			addi $t0, $t0,1
			j forloop
		ExitFor:
		
		add $s2, $t4, $t1
			li $s3, '\0'
			sb $s3, 0($s2)
			#andi $t1, $t1,0
			la $a0, w
			la $a1, swa
			jal compare
			move $t6, $v0
			
		#	li $v0,1     #prepare system call 
		#	move $a0,$t6 #copy t0 to a0 
		#	syscall  
			
			bnez $t6, elseelse2
			li $t2, 1
			# print rw
			li $v0, 4
				la $a0, rw
				syscall
				
			j inc2
			elseelse2:
			#print w
			li $v0, 4
				la $a0, w
				syscall
		
		inc2:
		move $v0,$t2
	
#		sb $v0, letter
#		
#		 $a0, letter 
		
#		li $v0,1
		
#		syscall
		
		#Tell the system that the program is done
		
		
	
		j done
 	
		#li $v0,1     #prepare system call 
		#move $a0,$t0 #copy t0 to a0 
		#syscall      #print integer
 	
			#msh mot2kd mn dah
			
			
			
			
	
	CountOccurrences:
		#Display message to user
		li $v0, 4
		la $a0, wordMessage
		syscall
		
		# Scanning Paragraph
		li $v0, 8 #accept input from user
		la $a0, tosearch #address where we store the user input
		li $a1, 100 #maximum length of characters
		syscall
		
		li $s0,0 
		remove12:
		    lb $a3,tosearch($s0)    # Load character at index
		    addi $s0,$s0,1      # Increment index
		    bnez $a3,remove12     # Loop until the end of string is reached
		    beq $a1,$s0,skip12    # Do not remove \n when string = maxlength
		    subiu $s0,$s0,2     # If above not true, Backtrack index to '\n'
		    sb $0, tosearch($s0)    # Add the terminating character in its place
		    skip12:
		
		
		li $s0, 0   # i
		
		li $s3, 0
		
		li $t0, 0
		
		la $t2, paragraph
		
		la $t3, tosearch
		
		li $t6, 0
		
		
		ForLoop1O:
			add $t7, $t2, $s0
  			
  			lb $t8, 0($t7)
			
			beq $t8,$zero, DONE
			
			ori $t0, $t0, 1
			
			ForLoop2O:
				add $s7, $t3, $s3
  				lb $t9, 0($s7)
				beq $t9, $zero , IF #end of the word 
				
				add $s1, $s0, $s3 #$s0=i , $s3=j --> x= i+j
				add $s5, $t2, $s1 # y= str+x
				lb $s4, 0($s5)
				
				beq $s4, $t9, L1O #if(str[i+j] != tosearch[j]) 
				
				andi $t0, $t0, 0 # $t0 = found --> found = 0
				j IF #break
				L1O: addi $s3, $s3, 1 #j++
				
				
				j f2				
			IF:
				#IF Body (found==1)
				
				bne $t0, 1, ,f1 # if found==1
				
				addi $t6, $t6 ,1 # count++
	
			f1: 
			addi $s0, $s0, 1
			andi $s3, $s3, 0
			j ForLoop1O
			f2:
				addi $s3, $s3, 1
				j ForLoop2O
		DONE:
			
			li $v0, 4
			la $a0, wordMessage2
			syscall
			
			sb $t6, letter
  		    
  		    	lb $a0, letter
		   	li $v0, 1   # print_character
		    	syscall
		    	
		    jr $ra
	
	
			
# compare two strings  , str2
compare: 
	li $v0, 0
LOOP:
	lb $t8, ($a0) #load the first string into t0
	lb $t9, ($a1) #load the second string into t1
	add $a0, $a0, 1	#add 1 to the value of the  first string 
	add $a1, $a1, 1	#add 1 to the value of the second  string
	beqz $t8, LOOP_END #compare the first string with the second 
	beqz $t9, LOOP_END #compare the second string with first
	bgt $t8, $t9, GREATER #if value of t0 > t1 go to greater
	blt $t8, $t9, LESS #if value of t0 > t1 go to greater
	beq $t8, $t9, LOOP #if t0==t1 loop
GREATER:
	li $v0, 1
	j END
LESS:
	li $v0, -1
	j END
EQUAL:
	li $v0, 0
	j END
LOOP_END:
	beq $t8, $t9, EQUAL
	beqz $t8, LESS
	beqz $t9, GREATER
END:
	jr $ra
	
	
	

	
strcats:
lw $t0, i
move $t3, $a0
lopp: 
add $s7, $t3, $t0
lb $t9, 0($s7)
beq $t9, $zero , printf
addi $t0,$t0,1
j lopp



printf:
li $t1, ' '
sb $t1, 0($s7)
addi $t0,$t0,1
add $s7, $t3, $t0
sb $zero, 0($s7)

jr $ra

################################################################### word Statistics #########################################
Word_Statistics :
		 la $t0 , paragraph # but the base address for paragraph in $t0 
		 li $t1 , 0         # loop counter (i) in $t0
		 li $t2 , 0     # space = the No of the space in paragraph
		 li $t7 , -1       # len of string 
		 # loop for count len of string 
		 loop:
    			lb   $a0,0($t0)
    			beqz $a0,ForLoop1
    			addi $t0,$t0,1
   			 addi $t7,$t7,1
   			 j     loop
		
		ForLoop1:
			la $t0 , paragraph
			add $s1 , $t0 , $t1  # Put the sum of the address of paragraph and i in $s1
			lb  $s2 ,0($s1)     # Get the value of the address in register $s1 and put it in $s2
			# if i < paragraph length 
			bge $t1 , $t7 , ExitL1
			addi $t1 ,$t1 , 1  # i++
			bne $s2 , ' ' ,ForLoop1  # if paragraph [i] == ' ' 
			addi $t2 ,$t2 , 1        # space ++ 
			j ForLoop1
			
							
		ExitL1:
		la $t0 , paragraph # but the base address for paragraph in $t0 
		li $t1 , 0        #var  i 
		li $t3 , 0       # loop counter j 
		la $t4 , arr     # arr[i][k]
		li $t5 , 0	 # var  k 
		ForLoop2:
			
			add $s1 , $t0 , $t3  # Put the sum of the address of paragraph and i in $s1
			lb  $s2 ,0($s1)     # Get the value of the address in register $s1 and put it in $s2
			bge $t3 ,$t7 ,Exit2  # j< paragraph length
			######################################### arr[i][k]
			mul $s3, $t1, 100 # calculates i * # of columns
			add $s3, $s3, $t5 # calculates i * # of columns + k++
			mul $s3, $s3, 1 # calculates (i * # of columns + k++)* size of an element
			add $s3, $t4, $s3 # complete address calculation for arr[i][k++]
			#########################################
			beq $s2,' ',Then   # if paragraph[j] == ' ' 
			sb $s2 ,0($s3) #arr[i][k++] = paragraph[j]
			addi $t5,$t5,1 #k++
			addi $t3 ,$t3 , 1  # j++ 
			j ForLoop2 

		       Then:
	 	          sb $zero , 0($s3)#arr[i][k] = '\0'
		       	  addi $t1,$t1,1 #i++
		       	  andi $t5,$t5,0 #k=0
		       	  addi $t3 ,$t3 , 1  # j++ 

		       	  j ForLoop2
			
		Exit2:
		li $t0, 0 
		li $t1, 0 
		# space firt in $t2 
		li $t3, 0
		la $t4, arr 
		li $t5, 0
		li $t6, 0
		la $t7 , arr1
		
		ForLoop3:

			bgt $t0,$t2,Exit3 #i<= space
		
			
			L4:
			
				bgt $t1,$t2,Exit4 # j<= space 
				andi $t3,$t3,0  #k=0
				#########################################  arr[i]for print
				mul $s3, $t0, 100 # calculates i * # of columns
				add $s3, $s3, $t3 # calculates i * # of columns + k
				mul $s3, $s3, 1 # calculates (i * # of columns + k)* size of an element
				add $s3, $t7, $s3 # complete address calculation for arr[i][k]
				lb $s7, 0($s3) # load the value of element arr[i][k] to register $s4
				
				#while loop 
				WL:
				
				#########################################  arr[i][k]
				mul $s3, $t0, 100 # calculates i * # of columns
				add $s3, $s3, $t3 # calculates i * # of columns + k
				mul $s3, $s3, 1 # calculates (i * # of columns + k)* size of an element
				add $s3, $t4, $s3 # complete address calculation for arr[i][k]
				lb $s4, 0($s3) # load the value of element arr[i][k] to register $s4
				#####################################
				move $s7,$s4 
					beqz $s4,ExitWL # arr[i][k] != '\0'
					
					#########################################  arr[j][k]
					mul $s3, $t1, 100 # calculates j * # of columns
					add $s3, $s3, $t3 # calculates j * # of columns + k
					mul $s3, $s3, 1 # calculates (j * # of columns + k)* size of an element
					add $s3, $t4, $s3 # complete address calculation for arr[j][k]
					lb $s6, 0($s3) # load the value of element arr[j][k] to register $s6
					#########################################
				        bne $s4,$s6 ,Then1  #if arr[i][k] != arr [j][k] 
				        addi $t3,$t3,1  #k++
				        j WL #return to while loop 
				        Then1:
				        ori $t6 ,$t6 , 1 #flag = 1
				         
				ExitWL:
					bne $t6 ,0 , EX  #if flag == 0 
					addi $t5,$t5,1  #count ++
					andi $t6,$t6,0 #flag = 0 
					addi $t1,$t1,1  # j++ 
					
					j L4
					EX:
						andi $t6,$t6,0 #flag = 0 
						addi $t1,$t1,1  # j++
						j L4
			Exit4:
		       
			
			# loop for display the word 
			la $t7 , arr1  
  			li $t3 ,0   # Var  k 
  			addi $t0,$t0,1    # i++
			L:
			       #########################################  arr[i]for print
				mul $s3, $t0, 100 # calculates i * # of columns
				add $s3, $s3, $t3 # calculates i * # of columns + k
				mul $s3, $s3, 1 # calculates (i * # of columns + k)* size of an element
				add $s3, $t7, $s3 # complete address calculation for arr[i][k]
				lb $s7, 0($s3) # load the value of element arr[i][k] to register $s7
			
				beq $s7,$zero,exi  # if arr[i][k] = '\0'
				beq $s7,' ',exi    # if arr[i][k] = ' '
				beq $s7,'\n',exi   # if arr[i][k] = '\n'
				sb $s7, letter
  		    		lb $a0, letter
		    		li $v0, 11   
		      		
		      		syscall
		      		addi $t3,$t3,1   # k ++ ; 
		      		j L 
				
  			exi:
  			# Display Message3
  			
  			li $v0, 4
			la $a0, Message3
			syscall
  			
  			#display the count 
  			sb $t5, letter
  		    	lb $a0, letter
		    	li $v0, 1   # print_character
		    	syscall
		    	 #print statement
		        # Display message 2
  			
  			li $v0, 4
			la $a0, Message2
			syscall
		    	# Make new Line
		    	
		    	li $t8,'\n'         
			sb $t8,letter	   
			lb $a0,letter	    
			li $v0,11	   
			syscall
			andi $t5,$t5,0 #count = 0 
			andi $t1,$t1,0  # j = 0 
			
			j ForLoop3 
			
		
							
		Exit3:
		j done
		
##################################################################### Frequency ######################################################
		Frequency:
  		
  		
  		la $t0, paragraph # Put the address of the array paragraph in $t0
  		lw $t1, i # First loop Counter
  		la $t2, FreqArr # Put the address of the array arr in $t2
  		lw $t3, i  #Second loop Counter j
  		lw $t4, i  #Flag 
  		lw $t5, i  #Index of the array arr (m)

  		L1: 
  		
  		
  		    add $s1, $t0, $t1 # Put the sum of the address of paragraph and i in $s1
  		    lb $s2, 0($s1) # Get the value of the address in register $s1 and put it in $s2
  		    # If $s2 = NULL Go to Exit1
  		    beq $s2, $zero, Exit1F
  		    
			
  		    L2: 
  		    	add $s3, $t2, $t3 # Put the sum of the address of arr and j in $s3
  		    	lb $s4, 0($s3) # Get the value of the address in register $s3 and put it in $s4
  		    	# If $s4 = NULL Go to Exit2
  		    	beq $s4, $zero, Exit2F
  		    	addi $t3, $t3, 1 # j++
  		    	# If paragraph[i] == arr[j]
  		    	bne $s2, $s4, L2 
  		    	ori $t4, $t4, 1 #flag = 1
  		    	j L2
  		    	
  		    	Exit2F:
  		    		# If flag == 0
  		    		bne $t4, $zero, Exit3F
  		    		# If flag != ' '
  		    		beq $s2, ' ', Exit3F
  		    		# If flag != '\n'
  		    		beq $s2, '\n', Exit3F
  		    		
  		    		add $s5, $t2, $t5 # address of array arr + index of arr
  		    		# Put the value of $s2 in address that is in register $s5
  		    		sb  $s2, 0($s5)
  		    		addi $t5, $t5, 1 #index of arr + 1
  		    		
  		    	Exit3F:
  		    	
  		    	andi $t4, $t4, 0 # Flag = 0
  		    
  		    
  		    addi $t1, $t1, 1 # i++
  		    andi $t3, $t3, 0 # j=0
  		    j L1
  		    
  			
  	    
		Exit1F:	    
			
		la $t0, paragraph
  		lw $t1, i #First loop Counter
  		la $t2, FreqArr
  		lw $t3, j  #Second loop Counter j
  		lw $t4, m  #Frequency
  		la $t5, numbers #Array to save number of occurence
  		lw $t6, i 	# Counter of Numbers Array	
  		Loop1: 
  		
  			add $s0, $t2, $t1  #Put the sum of the address of arr and i in $s0
  			lb $s1, 0($s0)  # Get the value of the address in register $s0 and put it in $s1
  			# If value in $s1 (arr[i] != NULL)
  			beqz $s1, E_Loop1
  			
  			Loop2:
  			
  				add $s2, $t0, $t3  #Put the sum of the address of paragraph and j in $s2
  				lb $s3, 0($s2)  # Get the value of the address in register $s2 and put it in $s3
  				# If value in $s3 (paragraph[j] != NULL)
  				beqz $s3, E_Loop2
  				# If ( paragraph[j] ==  arr[i] )
  				bne $s3, $s1, E_If1
  				addi $t4, $t4, 1 # Frequency++
  				
  				E_If1:
  				
  				addi $t3, $t3, 1 # j++
  				j Loop2
  			E_Loop2:
  			
  			# Display CharMessage
  			
  			li $v0, 4
			la $a0, CharMessage
			syscall
  			
  			# Display the Character
  			
  			sb $s1, letter
  		    	lb $a0, letter
		    	li $v0, 11   
		      	syscall
  			
  			# Display OccursMessage
  			
  			li $v0, 4
			la $a0, OccursMessage
			syscall
  			
  			# Display the value in register $t4 (frequency)
  			
  			sb $t4, letter
  		    	lb $a0, letter
		    	li $v0, 1   # print_character
		    	syscall
		    	
		    	# Make new Line
		    	
		    	li $t8,'\n'         
			sb $t8,letter	   
			lb $a0,letter	    
			li $v0,11	   
			syscall
			
			#Add the number to an array
			
			add $s4, $t5, $t6
			sb $t4, 0($s4)
			addi $t6, $t6, 1
			
  			andi $t4, $t4, 0 # Frequency =0
  			addi $t1, $t1, 1 # i++
  			andi $t3, $t3, 0 # j=0
  			j Loop1
  		E_Loop1:
	j done
	
		    
##################################################################### FreqCharEq ######################################################
		FreqCharEq:
		
			
			addi $t2,$zero,0
			addi $t3,$zero,0
 			
 				la   $t0, Chars      # load address of char array 
 				la   $t1, numbers        # load address of freq array
 				
 					
 				 		
			L5:# while 
				
				add $s0,$t0,$t2
				add $s1,$t1,$t3
								
				beqz  $s0,exit 	      # exit if reach to end of array 
				
				IFm:
					bne $s0,1,ELSE1 #if $s1"i"==1 go to label else1
					#print char from array
					li $v0,4
					lb $a0,($s0)
					syscall
					# print freq = 1
					li $v0,4
					la $a0,Msg1
					syscall
					
					#increment counters
					addi $t2,$t2,1
					addi $t3,$t3,1
					#check the condetion of loop with new values
					j L5
					
				ELSE1:
					bne $s0,2,ELSE2
					#print char from array
					li $v0,4
					lb $a0,($s0)
					syscall
					# print freq = 1
					li $v0,4
					la $a0,Msg2
					syscall
					
					#increment counters
					addi $t2,$t2,1
					addi $t3,$t3,1
					#check the condetion of loop with new values
					j L5
					
				ELSE2:
					bne $s0,3,ELSE3
					#print char from array
					li $v0,4
					lb $a0,($s0)
					syscall
					# print freq = 1
					li $v0,4
					la $a0,Msg3
					syscall
					
					#increment counters
					addi $t2,$t2,1
					addi $t3,$t3,1
					#check the condetion of loop with new values
					j L5
					
				ELSE3:

					addi $t2,$t2,1
					addi $t3,$t3,1
					j L5
					
				exit:
		    			j done
		    

##################################################################### StartQucikSort ######################################################
StartQucikSort:
	jal SplitString             # call split string 
	la $t0, arrOfString         # Moves the address of array into register $t0.
	addi $s6,$t5,1              # array length use in print array ater sort
	addi $a0, $t0, 0            # Set argument 1 to the array.
	addi $a1,$t5,0              # Set argument 2 to length array
	jal quicksort               # Call quick sort
	j PrintArray


# actual unction quick sort
quicksort:
	addi $sp, $sp, -12		    # Make room for 4

	sw $a0, 0($sp)			    # a0 array
	sw $a1, 4($sp)			    # length
	sw $ra, 12($sp)			    # return address
	
	move $t0, $a1			    # saving length in t0
	subi $t0,$t0,1                      # index or last element (length-1)
	li $s7,1
	beq $a1,$s7 endif                   # if length = 1, endif
	blt $a1,$s7,endif                   # i length = 1, end
	
	sll $t1, $t0, 2		           # t1 = 4* (length-1)
	add $t2, $a0, $t1	           # t1 = arr + 4* (length-1)
	lw $s4, 0($t2)		           # t2 = arr[length-1] //pivot
	
	
	li $t4,0                           # $t4 is index for array f
	li $t6,0                           # index for piv increase it fi first charcter less then first char in pivot
	Loop:
		beq $a1,$t4,endfor        # exit loop if array size like user enter minus one i < length
		lb $s1, ($s4)                # last elemnt first char
		
		sll $t1, $t4, 2		     # t1 = j*4
		add $t7,$a0,$t1	             # t1 = arr + 4j
		lw $t5, ($t7)		     # t7 = arr[j]
		lb $s2, ($t5)                # arr[j] elemnt first char
		
		
		sll $t1, $t6, 2		     # t1 = pivot * 4
		add $t8, $t1, $a0	     # t1 = arr + 4 pivot
		lw $t3, ($t8)		     # t7 = arr[pivot]
		
		blt $s2, $s1, swap           # if first charcter less then first char or pivot
		continue:
			addi $t4,$t4,1         #add one to counter or array
			j Loop                 #jump to printLoop agian and check that t3 equal t2
		
	endfor:
		sw  $s4, ($t8) 		            # t3 = t2 
		sw  $t3, ($t2)		            # t2 = s3
		
		lw  $a0, 0($sp)			    # a0 = array
		addi $a1, $t6, 0	            # a1 = pivot
		jal quicksort			    # call quicksort
		
		addi $t6,$t6,1                     # pivot + 1    
		sll $t1, $t6, 2		           # t1 = 4* (length-1)
		add $a0, $a0, $t1	           # t1 = arr + 4* (length-1)
		lw $a1, 4($sp)
		sub  $a1,$a1,$t6                   # length - pivot
		jal quicksort			   # call quicksort	
		
		j endif
#swap 
swap:
	sw   $t3, ($t7)                        # s3 = t5
	sw   $t5, ($t8) 		       # t5 = t3	 
	addi $t6,$t6,1                         # increase index for pivot 
	j continue
		
# get last element in array as pivot in s1
endif:
	lw $a0, 0($sp)              # restore a0
 	lw $a1, 4($sp)		    # restore a1
 	lw $ra, 12($sp)	            # restore return address
 	addi $sp, $sp, 12	    # restore the stack
 	jr $ra                      # return to last stack pointer
	
	
#Split String with " " space to some word
SplitString:
	la $t0,paragraph     # take input string to $t0
	la $t3,token      # token to carry each word in array
	lw $t1,i          # loop Counter to can read each char from user string
	lw $t2,n          # loop Counter to can set each char in word that load in token  
	lw $t4,k          # loop Counter for arrayOString
	lw $t5,l          # loop Counter to know how many word in array
	loop1:
		add $s1, $t0, $t1              # Put the sum of the address of paragraph and i in $s1
		add $s3, $t3, $t2              # Put the sum of the address of token and n in $s3
  		lb $s2,($s1)                   # Get the value of the address in register $s1 and put it in $s2
  		beq $s2, '\n',TakeWord         # if($s2 == '\n') splite last word 
  		beq $s2, ' ', TakeWord         # if($s2 == ' ') splite when found space
  		sb $s2,($s3)                   # set this value in another address register that pointer to token
  		addi $t1, $t1, 1               # incremnt to next addredd to can get next char
  		addi $t2, $t2,1                # incremnt to next addredd to can set next char
  		beq $s2, $zero, BackToPointer  # If $s2 = '\o' when reach to end of string back to quickSort unction
    		j loop1                         # jump to loop again
	
# Take each split word in array	
TakeWord:
	sw   $t3,arrOfString($t4)       # store each split token in array string -> a[i] 
	addi $t4,$t4,4                  # next postion in array
	addi $t5,$t5,1                  # count  how many word in array
	addi $t1,$t1,1                  # incremnt to next addredd to can get next char to skap space in loop
	lw $t2,n                        # re init loop Counter to can set each char in word that load in token 
	addi $t3,$t3,20                 # add another space for next word
	j loop1
	
#print array o string
PrintArray:
	li $t2, 1                             #$t4 is index for array for print
	la $s5,arrOfString                     #load the irst address or array 
	printLoop:
		beq $s6,$t2,done               #exit loop if array size like user enter
		lw $a0, ($s5)                  #take a[i] into $a0
		li $v0,4                       #print string
		syscall
		addi $t8,$s6,-1
		blt $t2,$t8,PrintSpace
		continueLoop:
			addi $t2,$t2,1                 #add one to counter or array
			addi $s5,$s5,4                 #incremnt index $t4   $t4=$t4+1
			j printLoop                    #jump to printLoop agian and check that t3 equal t2
		
# Back To Last Stack Pointer in program
BackToPointer:
	lw $s1,i
	lw $s2,i
	lw $s3,i
	jr      $ra

# new_line -- output a newline char
new_line:
    la      $a0,newline
    li      $v0,4
    syscall
    jr      $ra
    
PrintSpace:
		li $v0,4                       #print char
		la $a0,spacechar                   #print space
		syscall
		j continueLoop
#exit project	
done:
 	li $v0, 10
	syscall
	
