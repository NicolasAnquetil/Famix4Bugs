"
A parser for textual bug description
Input format unknown
"
Class {
	#name : #BugImporter,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : 'Famix-Extensions-Bugs'
}

{ #category : #initialization }
BugImporter >> initialize [

	 "self model: MooseModel root allModels first."
]

{ #category : #accessing }
BugImporter >> model [
	^ model
]

{ #category : #accessing }
BugImporter >> model: anObject [
	model := anObject
]

{ #category : #run }
BugImporter >> parseBugLine:  line [
	
	| fields aBug |
	
	fields := (line subStrings: ',').
	aBug := FAMIXBugEntity new
		bugID: fields first ;
		openDate: fields second asDateAndTime ;
		resolutionDate: fields third asDateAndTime ; 
		yourself.
	self parseEntitiesLine: (fields fourth) forBug: aBug.
	"self model add: aBug."
	^ aBug

	
]

{ #category : #run }
BugImporter >> parseEntitiesLine:  line forBug: aBug [

	(line subStrings: ';') do: [ :str | | name entity |
		"must remove possible leading [ and trailing space from name"
		name := str trimLeft: [:c | c == $[ ] right: [:c | c == $  ].
		"must remove possible xxxx:: before org::"
		
		"name :=  self removeBefore: 'org::' in: name."
		entity := model allModelClassHistories detect: [:each | name endsWith: each mooseName] ifNone: [nil].
		entity notNil ifTrue: [ aBug addEntity: entity	]
	].

	^ aBug entities

	
]

{ #category : #run }
BugImporter >> readFile: aFileName [

	| stream buffer |
	
	[stream := FileStream readOnlyFileNamed: aFileName.

		buffer := String new: stream size.
		[stream atEnd] whileFalse: [
			self parseBugLine: stream nextLine.
		]
	] ensure: [stream close].
	buffer.
]

{ #category : #'filter streaming' }
BugImporter >> removeBefore: starter in: string [
	"remove anything before started in the string if started is present. otherwise returns string"

	| i |
	i := string findString: starter.
	^ (i > 0)
		ifTrue: [string copyFrom: i to: (string size)]
		ifFalse: [string].
]
