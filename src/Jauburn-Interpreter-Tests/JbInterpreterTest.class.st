Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #tests }
JbInterpreterTest >> testAbsBinding [

	self interpret: 'var a = abs(10);'.
	self interpret: 'var b = abs(-10);'.
	self assert: (interpreter environment at: 'a') equals: 10.
	self assert: (interpreter environment at: 'b') equals: 10.
]

{ #category : #tests }
JbInterpreterTest >> testAssignmentExecuteIn [

	self interpret: 'var x = 10;'.
	self interpret: 'x = 11;'.
	self assert: (interpreter environment at: 'x') equals: 11.
]

{ #category : #tests }
JbInterpreterTest >> testBooleanOperators [

	self interpret: 'var x = 4;'.
	self interpret: 'var y = 3;'.
	self interpret: 'var z = 5;'.
	
	self interpret: 'var b = x == x;'.
	self assert: (interpreter environment at: 'b') equals: true.
	self interpret: 'var b = x == y;'.
	self assert: (interpreter environment at: 'b') equals: false.
	
	self interpret: 'var b = x < y;'.
	self assert: (interpreter environment at: 'b') equals: false.
	self interpret: 'var b = x < x;'.
	self assert: (interpreter environment at: 'b') equals: false.
	self interpret: 'var b = x < z;'.
	self assert: (interpreter environment at: 'b') equals: true.
	
	self interpret: 'var b = x <= y;'.
	self assert: (interpreter environment at: 'b') equals: false.
	self interpret: 'var b = x <= x;'.
	self assert: (interpreter environment at: 'b') equals: true.
	self interpret: 'var b = x <= z;'.
	self assert: (interpreter environment at: 'b') equals: true.
	
	self interpret: 'var b = x > y;'.
	self assert: (interpreter environment at: 'b') equals: true.
	self interpret: 'var b = x > x;'.
	self assert: (interpreter environment at: 'b') equals: false.
	self interpret: 'var b = x > z;'.
	self assert: (interpreter environment at: 'b') equals: false.
	
	self interpret: 'var b = x >= y;'.
	self assert: (interpreter environment at: 'b') equals: true.
	self interpret: 'var b = x >= x;'.
	self assert: (interpreter environment at: 'b') equals: true.
	self interpret: 'var b = x >= z;'.
	self assert: (interpreter environment at: 'b') equals: false.
	
	self interpret: 'var b = x != x;'.
	self assert: (interpreter environment at: 'b') equals: false.
	self interpret: 'var b = x != y;'.
	self assert: (interpreter environment at: 'b') equals: true.
	
	
	
]

{ #category : #tests }
JbInterpreterTest >> testConcatBinding [

	self interpret: 'var a = length("cat");'.
	self interpret: 'var b = length("cats");'.
	self assert: (interpreter environment at: 'a') equals: 3.
	self assert: (interpreter environment at: 'b') equals: 4.
	
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self interpret: 'x = x + 1;'.
	self assert: (interpreter environment at: 'x') equals: 20.
	
	self interpret: 'var x = 4 / 2 - 1;'.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #tests }
JbInterpreterTest >> testFunctionCallInAndReturn [

	self interpret: 'var z = function(x) { return 2 * 3; } ;'.
	self interpret: 'var y = z(5);'.
	self assert: (interpreter environment at: 'y') equals: 6.

	self interpret: 'var z = function(x) { return x * 3; } ;'.
	self interpret: 'var y = z(5);'.
	self assert: (interpreter environment at: 'y') equals: 15.
	
	self interpret: 'var z = function(x) { x = x + 1; return x * 3; } ;'.
	self interpret: 'var y = z(5);'.
	self assert: (interpreter environment at: 'y') equals: 18.
	
]

{ #category : #tests }
JbInterpreterTest >> testIfAndElseIf [

	self interpret: 'var z = function(x) { if (x > 10) {return 5;} return 6; } ;'.
	self interpret: 'var y = z(5);'.
	self assert: (interpreter environment at: 'y') equals: 6.
	self interpret: 'y = z(15);'.
	self assert: (interpreter environment at: 'y') equals: 5.
	
	self interpret: 'var z = function(x) { if (x > 10) {return 5;} else {return 6;} } ;'.
	self interpret: 'var y = z(5);'.
	self assert: (interpreter environment at: 'y') equals: 6.
	self interpret: 'y = z(15);'.
	self assert: (interpreter environment at: 'y') equals: 5.
	
	self interpret: 'var z = function(x) { var a = 0; if (x > 10) {a = 5;} else {a = 6;} return a;} ;'.
	self interpret: 'var y = z(5);'.
	self assert: (interpreter environment at: 'y') equals: 6.
	self interpret: 'y = z(15);'.
	self assert: (interpreter environment at: 'y') equals: 5.
]

{ #category : #tests }
JbInterpreterTest >> testInputBinding [ 
	
	interpreter uimanager: JbMockUIManager new.
	self interpret: 'var b = input("Demo");'.
	self assert: (interpreter environment at: 'b') equals: 'Demo'.
	
	self interpret: 'var a = "bear";'.
	self interpret: 'var b = input(a);'.
	self assert: (interpreter environment at: 'b') equals: 'bear'.
]

{ #category : #tests }
JbInterpreterTest >> testLengthBinding [

	self interpret: 'var a = length("cat");'.
	self interpret: 'var b = length("cats");'.
	self assert: (interpreter environment at: 'a') equals: 3.
	self assert: (interpreter environment at: 'b') equals: 4.
]

{ #category : #tests }
JbInterpreterTest >> testModBinding [

	self interpret: 'var a = mod(9, 2);'.
	self interpret: 'var b = mod(10, 2);'.
	self assert: (interpreter environment at: 'a') equals: 1.
	self assert: (interpreter environment at: 'b') equals: 0.
]

{ #category : #tests }
JbInterpreterTest >> testNegateBooleanOperator [

	self interpret: 'var x = -4;'.
	self assert: (interpreter environment at: 'x') equals: -4.
	
	self interpret: 'var x = 5;'.
	self interpret: 'var x = -x;'.
	self assert: (interpreter environment at: 'x') equals: -5.
]

{ #category : #tests }
JbInterpreterTest >> testNotBinding [

	self interpret: 'var a = not(true);'.
	self interpret: 'var b = not(false);'.
	self assert: (interpreter environment at: 'a') equals: false.
	self assert: (interpreter environment at: 'b') equals: true.
]

{ #category : #tests }
JbInterpreterTest >> testStringToNumberBinding [

	self interpret: 'var a = stringToNumber("12");'.
	self interpret: 'var b = stringToNumber("256");'.
	self assert: (interpreter environment at: 'a') equals: 12.
	self assert: (interpreter environment at: 'b') equals: 256.
]

{ #category : #tests }
JbInterpreterTest >> testWhileLoop [

	self interpret: 'var sum = 0;'.
	self interpret: 'var x = 1;'.
	self interpret: 'while (x <= 10) {sum = sum + x; x = x + 1;}'.
	self assert: (interpreter environment at: 'sum') equals: 55.

	
]
