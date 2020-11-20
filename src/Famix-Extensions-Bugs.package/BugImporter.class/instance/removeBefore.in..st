filter streaming
removeBefore: starter in: string
	"remove anything before started in the string if started is present. otherwise returns string"

	| i |
	i := string findString: starter.
	^ (i > 0)
		ifTrue: [string copyFrom: i to: (string size)]
		ifFalse: [string].