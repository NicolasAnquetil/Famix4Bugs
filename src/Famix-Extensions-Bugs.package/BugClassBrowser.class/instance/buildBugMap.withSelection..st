as yet unclassified
buildBugMap: view withSelection: class

	| isYoung isOld allBugs start end|

	allBugs := model allFAMIXBugEntity asSortedCollection: [:a :b | a openDate < b openDate].

	start := allBugs first openDate year.
	end := allBugs last openDate year.
	
	isYoung := [:c | c age < (24*30*3)].
	isOld := [:c | (isYoung value: c) not].
		
	view shape rectangle withoutBorder.
	view nodes: (start to: end) forEach: [:year |
	  view shape label.
	  view node: year asString.
	  view node: year forIt: [
	    view shape rectangle
		width: [:b |  b entities size + 4] ;
		if: isYoung fillColor: (MONColorLinearNormalizer
							inContext: (allBugs select: isYoung)
							withCommand: [:c | c age]
							lowColor: Color white
							highColor: Color yellow) ;
		if: isOld fillColor: (MONColorLinearNormalizer
							inContext: (allBugs select: isOld) 
							withCommand: [:c | c age]
							lowColor: Color yellow
							highColor: Color red);
		if:[:aBug | aBug entities includes: class] fillColor: Color cyan.
	    view nodes: ((allBugs select: [:b| (b openDate >= (('01-01-' , year asString) asDate)) and: [b openDate <= (('12-31-' , year asString) asDate)]]) asSet sortedAs: #openDate).
	    view gridLayout].
	  view verticalLineLayout ].
	view verticalLineLayout.
