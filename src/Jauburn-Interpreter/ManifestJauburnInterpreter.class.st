"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestJauburnInterpreter,
	#superclass : #PackageManifest,
	#category : #'Jauburn-Interpreter-Manifest'
}

{ #category : #'code-critics' }
ManifestJauburnInterpreter class >> ruleCodeCruftLeftInMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#JbInterpreter #printBinding #false)) #'2022-02-28T17:32:57.987-06:00') )
]

{ #category : #'code-critics' }
ManifestJauburnInterpreter class >> ruleGuardingClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#JbWhileLoopNode #executeIn: #false)) #'2022-02-28T20:21:35.751-06:00') )
]

{ #category : #'code-critics' }
ManifestJauburnInterpreter class >> ruleReGuardClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#JbWhileLoopNode #executeIn: #false)) #'2022-02-28T20:21:33.316-06:00') )
]
