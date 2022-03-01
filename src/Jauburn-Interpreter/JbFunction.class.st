"
I am the value that results from evaluating a function.  My i-vars

	parameters -- collection holding names of my parameters 
	environment -- a JbEnvironment instance holding the environment in effect when I was created (closures!)
	body -- an AST node for the body of this function
"
Class {
	#name : #JbFunction,
	#superclass : #Object,
	#instVars : [
		'body',
		'parameters',
		'environment'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #accessing }
JbFunction >> body [
	^ body
]

{ #category : #accessing }
JbFunction >> body: anObject [
	body := anObject
]

{ #category : #api }
JbFunction >> call: arguments in: callEnvironment [

	environment := JbEnvironment
		               newFromKeys: (self parameters collect: [ :e | e identifier])
		               andValues: (arguments collect: [ :e | e evaluateIn: callEnvironment ]).
	environment outerEnvironment: callEnvironment.
	
	environment at: 'return' put: nil.

	^self parseBody: environment
]

{ #category : #accessing }
JbFunction >> environment [
	^ environment
]

{ #category : #accessing }
JbFunction >> parameters [
	^ parameters
]

{ #category : #accessing }
JbFunction >> parameters: anObject [
	parameters := anObject
]

{ #category : #parsing }
JbFunction >> parseBody:  anEnvironment [ 

	| nBR |

	body do: [ :e | 
		(e className includesSubstring: 'Statement')
			ifTrue: [ (e className = 'JbReturnStatementNode') 
				ifTrue: [ ^ e executeIn: anEnvironment  ]
				ifFalse: [ e executeIn: anEnvironment ] ].
		(e className includesSubstring: 'Expression')
			ifTrue: [ e evaluateIn: anEnvironment ].
		((e className = 'JbIfElseNode') or: (e className = 'JbIfNode'))
			ifTrue: [ nBR := e executeIn: anEnvironment.
						 nBR notNil ifTrue: [ ^nBR ] ].
		(e className = 'JbWhileLoopNode')
			ifTrue: [ e executeIn: anEnvironment ]].
		^nil.
]
