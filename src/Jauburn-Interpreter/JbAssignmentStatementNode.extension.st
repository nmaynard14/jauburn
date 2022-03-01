Extension { #name : #JbAssignmentStatementNode }

{ #category : #'*Jauburn-Interpreter' }
JbAssignmentStatementNode >> executeIn: anEnvironment [

	anEnvironment lookupAt: self identifier put: (self expression evaluateIn: anEnvironment )
]
