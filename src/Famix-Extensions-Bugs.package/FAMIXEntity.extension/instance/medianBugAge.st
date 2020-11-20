*famix-Extensions-Bugs
medianBugAge
	<MSEProperty: #medianBugAge type: #Number> <derived>
	<MSEComment: 'median number of hours from opening to resolution of the bugs of this entity'>

	^ self privateState attributeAt: #averageBugAge
			ifAbsentPut: [ |myBugs|
				myBugs := self bugs.
				(myBugs isEmpty)
					ifFalse: [ ^ (myBugs collect: [:bug | bug age asFloat]) median ]
					ifTrue: [^0]
			]