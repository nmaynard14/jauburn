Extension { #name : #JbIfElseNode }

{ #category : #'*Jauburn-Interpreter' }
JbIfElseNode >> evaluateIn: anEnvironment [

	| newBody nBR |
	newBody := JbFunction new.
	(self condition evaluateIn: anEnvironment)
		ifTrue: [ newBody body: self trueStatements ]
		ifFalse: [ newBody body: self falseStatements ].
	nBR := newBody parseBody: anEnvironment.
	nBR notNil ifTrue: [ ^ nBR ] ifFalse: [ ^nil ]
]

{ #category : #'*Jauburn-Interpreter' }
JbIfElseNode >> executeIn: anEnvironment [

	| newBody nBR |
	newBody := JbFunction new.
	(self condition evaluateIn: anEnvironment)
		ifTrue: [ newBody body: self trueStatements ]
		ifFalse: [ newBody body: self falseStatements ].
	nBR := newBody parseBody: anEnvironment.
	nBR notNil ifTrue: [ ^ nBR ] ifFalse: [ ^nil ]
]
