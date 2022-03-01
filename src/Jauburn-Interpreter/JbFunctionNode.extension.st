Extension { #name : #JbFunctionNode }

{ #category : #'*Jauburn-Interpreter' }
JbFunctionNode >> evaluateIn: anEnvironment [

	| jbf |
	jbf := JbFunction new.
	jbf body: body.
	jbf parameters: parameters.
	^jbf
]
