Extension { #name : #MooseAbstractGroup }

{ #category : #'*famix-Extensions-Bugs' }
MooseAbstractGroup >> allBugs [
    <navigation: 'All bugs'>
    ^ self allWithType: FAMIXBugEntity

]
