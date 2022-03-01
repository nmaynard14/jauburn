Extension { #name : #JbIfNode }

{ #category : #'*Jauburn-Interpreter' }
JbIfNode >> evaluateIn: anEnvironment [

	| newBody nBR |
	newBody := JbFunction new.
	newBody body: self trueStatements.
	nBR := nil.
	(self condition evaluateIn: anEnvironment) ifTrue: [ 
		nBR := newBody parseBody: anEnvironment].
	nBR notNil ifTrue: [ ^ nBR ] ifFalse: [ ^nil ]
]

{ #category : #'*Jauburn-Interpreter' }
JbIfNode >> executeIn: anEnvironment [

	| newBody nBR |
	newBody := JbFunction new.
	newBody body: self trueStatements.
	nBR := nil.
	(self condition evaluateIn: anEnvironment) ifTrue: [ 
		nBR := newBody parseBody: anEnvironment].
	nBR notNil ifTrue: [ ^ nBR ] ifFalse: [ ^nil ]
]
