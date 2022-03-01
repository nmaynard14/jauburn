Extension { #name : #JbWhileLoopNode }

{ #category : #'*Jauburn-Interpreter' }
JbWhileLoopNode >> executeIn: anEnvironment [

	| newBody |
	newBody := JbFunction new.
	newBody body: self trueStatements.
	(self condition evaluateIn: anEnvironment) ifTrue: [ 
		newBody parseBody: anEnvironment.
		self executeIn: anEnvironment].
]
