"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'uimanager'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #binding }
JbInterpreter >> absBinding [

	^ #abs -> [ :e | 
	  e < 0
		  ifTrue: [ e * -1 ]
		  ifFalse: [ e ] ]
]

{ #category : #binding }
JbInterpreter >> concatBinding [

	^ #concat -> [ :a :b | a,b]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #accessing }
JbInterpreter >> environment: anObject [
	environment := anObject
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new.
	uimanager := UIManager default.
	(self class selectors select: [ :each | each endsWith: 'Binding' ])
		do: [ :s |  
			| binding jbp |
				binding := self perform: s.
				jbp := JbPrimitive new.
				jbp block: binding value. 
				environment at: binding key put: jbp ]
]

{ #category : #binding }
JbInterpreter >> inputBinding [

	^ #input -> [ :e | uimanager request: e ]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #binding }
JbInterpreter >> lengthBinding [

	^ #length -> [ :e | e size]
]

{ #category : #binding }
JbInterpreter >> modBinding [

	 ^ #mod -> [ :a :b | a \\ b]
]

{ #category : #binding }
JbInterpreter >> notBinding [

	 ^ #not -> [ :e | e not]
]

{ #category : #binding }
JbInterpreter >> printBinding [

	^ #print -> [ :value |  Transcript show: value printString]
]

{ #category : #binding }
JbInterpreter >> printlnBinding [

	^ #println -> [ :value |  Transcript show: value printString; cr]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]

{ #category : #binding }
JbInterpreter >> stringToNumberBinding [

	 ^ #stringToNumber -> [ :s | s asNumber]
]

{ #category : #accessing }
JbInterpreter >> uimanager: aUIManager [

	uimanager := aUIManager 
]
