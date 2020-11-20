Extension { #name : #FAMIXEntity }

{ #category : #'*famix-Extensions-Bugs' }
FAMIXEntity >> averageBugAge [
	<MSEProperty: #averageBugAge type: #Number> <derived>
	<MSEComment: 'Average number of hours from opening to resolution of the bugs of this entity'>

	^ self privateState attributeAt: #averageBugAge
			ifAbsentPut: [ |myBugs|
				myBugs := self bugs.
				(myBugs isEmpty)
					ifFalse: [ ^ (myBugs inject: 0 into: [:sum :bug | sum + bug age]) / (self bugs size) asFloat. ]
					ifTrue: [^0]
			]
]

{ #category : #'*famix-Extensions-Bugs' }
FAMIXEntity >> bugs [
	<MSEProperty: #bugs type: #FAMIXBugEntity opposite: #entities> <multivalued> <derived>
	^ self privateState attributeAt: #bugs
			ifAbsentPut: [FMMultiMultivalueLink on: self opposite: #entities]
]

{ #category : #'*famix-Extensions-Bugs' }
FAMIXEntity >> medianBugAge [
	<MSEProperty: #medianBugAge type: #Number> <derived>
	<MSEComment: 'median number of hours from opening to resolution of the bugs of this entity'>

	^ self privateState attributeAt: #averageBugAge
			ifAbsentPut: [ |myBugs|
				myBugs := self bugs.
				(myBugs isEmpty)
					ifFalse: [ ^ (myBugs collect: [:bug | bug age asFloat]) median ]
					ifTrue: [^0]
			]
]
