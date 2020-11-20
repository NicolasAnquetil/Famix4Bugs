run
parseBugLine:  line
	
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

	