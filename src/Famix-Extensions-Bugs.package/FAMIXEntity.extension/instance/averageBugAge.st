*famix-Extensions-Bugs
averageBugAge
	<MSEProperty: #averageBugAge type: #Number> <derived>
	<MSEComment: 'Average number of hours from opening to resolution of the bugs of this entity'>

	^ self privateState attributeAt: #averageBugAge
			ifAbsentPut: [ |myBugs|
				myBugs := self bugs.
				(myBugs isEmpty)
					ifFalse: [ ^ (myBugs inject: 0 into: [:sum :bug | sum + bug age]) / (self bugs size) asFloat. ]
					ifTrue: [^0]
			]