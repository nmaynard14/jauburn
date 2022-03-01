Extension { #name : #JbReturnStatementNode }

{ #category : #'*Jauburn-Interpreter' }
JbReturnStatementNode >> executeIn: anEnvironment [

	^self expression evaluateIn: anEnvironment 
]
