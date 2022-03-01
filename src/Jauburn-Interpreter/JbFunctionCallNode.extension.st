Extension { #name : #JbFunctionCallNode }

{ #category : #'*Jauburn-Interpreter' }
JbFunctionCallNode >> evaluateIn: anEnvironment [

	| jbf |
	jbf := anEnvironment at: identifier .
	^jbf call: arguments in: anEnvironment .
	
]

{ #category : #'*Jauburn-Interpreter' }
JbFunctionCallNode >> executeIn: anEnvironment [

	| jbp |
	jbp := anEnvironment at: identifier .
	^jbp call: arguments in: anEnvironment .
	
]
