Extension { #name : #JbArity1OperatorNode }

{ #category : #'*Jauburn-Interpreter' }
JbArity1OperatorNode >> evaluateIn: environment [

	| value |
	value := self operand evaluateIn: environment. 
	self operator = $-
		ifTrue: [ ^value negated].
]
