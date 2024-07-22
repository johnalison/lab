# arith - addition drill
# usage: awk -f arith optional problem size
# output: queries of the form "i + j = ?"

BEGIN {
    #maxnum = ARGC > 1 ? ARGV[1] : 10 # default size is 10
    ARGV[1] = "-" #read standard input subsequently
    srand() #reset rand from time of day
    do {
	randNum = rand()
	if(randNum < 1.0){
	    answer = multiply2with2()
	}else if(randNum < 0.3){
	    answer = square2()
	}else if(randNum < 1.0){
	    answer = multiply3with1()
	}else if(randNum < 1.0){
	    answer = multiply2with1()
	}else if(randNum < 1.0){
	    answer = subtraction(1000)
	}else if(randNum < 1.0){
	    answer = subtraction(100)	    
	}else if(randNum < 0.0){
	    answer = addition(100)	    
	}else if(randNum < 0.0){
	    answer = addition(1000)
	}else if(randNum < 1){
	    answer = addition3with4()	    	    
	}else if(randNum < 0.9){
	    answer = multiply11()
	}else if(randNum < 0.4){
	    answer = squareX5()
	}else{
	    answer = sameFirstDigitSum10()
	}

	while ((input= getline) > 0)
	    if ($0 == answer) {
		print "Right!"
		break
	    }else if ($0 == ""){
		print answer
		break
	    }else
		printf("wrong, try again: ")
	
    } while (input > 0)
}

function randint(n) {return int(rand()*n)+1 }

function square2() {
    n1 = randint(99)

    printf("%g^2  = ? " , n1 )
    return n1 * n1
}

function multiply2with2() {
    n1 = randint(99)
    n2 = randint(99)

    printf("%g * %g = ? " , n1, n2)
    return n1 * n2
}


function multiply3with1() {
    n1 = randint(999)
    n2 = randint(9)

    printf("%g * %g = ? " , n1, n2)
    return n1 * n2
}

function multiply2with1() {
    n1 = randint(99)
    n2 = randint(9)

    printf("%g * %g = ? " , n1, n2)
    return n1 * n2
}


function addition(maxnum) {
    n1 = randint(maxnum)
    n2 = randint(maxnum)

    printf("%g + %g = ? " , n1, n2)
    return n1 + n2
}

function subtraction(maxnum) {
    n1 = randint(maxnum)
    n2 = randint(maxnum)

    if (n2 > n1){
	tmp = n1
	n1 = n2
	n2 = tmp
    }
    
    printf("%g - %g = ? " , n1, n2)
    return n1 - n2
}


function addition3with4() {
    rn1 = randint(9)
    rn2 = randint(9)
    rn3 = randint(9)

    n1 = 1000*rn1 + 100*rn2 + 10*rn3

    n2 = randint(1000)
    
    printf("%g + %g = ? " , n1, n2)
    return n1 + n2
}


function multiply11() {
    n1 = randint(100)
    n2 = 11

    printf("%g x %g = ? " , n1, n2)
    return n1 * n2
}

function squareX5() {
    n1 = randint(9)
    n1 = n1*10 + 5
    printf("%g^2 = ? " , n1 )
    return n1 * n1
}

function sameFirstDigitSum10(){
    rn1 = randint(9)
    rn2 = randint(9)

    n1 = 10*rn1 + rn2
    n2 = 10*rn1 + (10-rn2)
    printf("%g x %g = ? " , n1, n2)
    return n1 * n2    
}
