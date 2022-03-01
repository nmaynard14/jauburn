"
Just a place to house a few sample programs
"
Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [
	"self run: #noFunctions"

	^'var x = 1;
var y = 10 * x - 1;
if (y == 9) { 
   x = 16;
}
'
]

{ #category : #utilities }
JbSamplePrograms class >> run: method [
	"Look at sample programs for examples of using this method."

	^JbInterpreter new run: (self perform: method)
]

{ #category : #demos }
JbSamplePrograms >> gcd [ 

	self inter: 'var gcd = function(a,b) { if (a < b) { var temp = a; a = b; b = temp; } var rem = mod(a,b); if (rem == 0) {return b;} else { return gcd(b, rem); } };'.
	self inter: 'var numInA = stringToNumber(input("Please input the first number: "));'.
	self inter: 'var numInB = stringToNumber(input("Please input the second number: "));'.
	self inter: 'println(gcd(numInA, numInB));'
]

{ #category : #initialization }
JbSamplePrograms >> initialize [

		super initialize.
		interpreter := JbInterpreter new.
		parser := JbParser new.
]

{ #category : #interpreting }
JbSamplePrograms >> inter: aStatement [

	interpreter interpret: (parser parse: aStatement)
]

{ #category : #demos }
JbSamplePrograms >> squareRoot [
	
	self inter: 
		'var sqrt = function(s) { var prevX = 0; var curX = s / 2; var x = 1; println(curX); while (x <= 5) { prevX = curX; curX = (1/2) * (prevX + (s / prevX)); println(curX); x = x + 1;} return curX; };'.
	self inter: 'var numIn = stringToNumber(input("Please enter a number to get its square root: "));'.
	self inter: 'var output = sqrt(numIn);'.
	self inter: 'print("Your approx square root is: ");'.
	self inter: 'println(output);'.
	
	
]
