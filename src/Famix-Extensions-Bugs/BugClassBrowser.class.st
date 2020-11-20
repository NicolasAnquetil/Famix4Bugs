"
A small browser of bugs
"
Class {
	#name : #BugClassBrowser,
	#superclass : #GLMBrowserTemplate,
	#instVars : [
		'model'
	],
	#category : 'Famix-Extensions-Bugs'
}

{ #category : #'as yet unclassified' }
BugClassBrowser >> buildBrowser [

	browser := GLMTabulator withStatusbar.
	browser title: 'Bug as Entity'.
	
	browser
		row: [ :row | row column: #one; column: #two].
	
	browser  transmit
		to: #one;
		andShow: [ :a | 
			a mondrian
				title: [ :entity | entity mooseName]; 
				painting: [ :view :bug | self buildClassMap: view withSelection: bug] ].

	browser  transmit
		to: #two;
		andShow: [ :a | 
			a mondrian
				title: [ :entity | entity mooseName]; 
				painting: [ :view :class | self buildBugMap: view withSelection: class ] ].
		

	browser transmit from: #one; to:#two; toOutsidePort: #entity.
	browser transmit from: #two; to:#one; toOutsidePort: #entity.

"	browser transmit from: #one; to: #two port: #entity.
	browser transmit from: #two; to:#one port: #entity.
"
	^ browser
]

{ #category : #'as yet unclassified' }
BugClassBrowser >> buildBugMap: view withSelection: class [

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

]

{ #category : #'as yet unclassified' }
BugClassBrowser >> buildClassMap: view withSelection: aBug [
	
			view shape rectangle withoutBorder.
			view nodes: model allModelNamespaceHistories forEach: [ :each |
				view shape label.
				view node: each name.
				view interaction menu: #mooseMenu.
				view node: each forIt: [
					| classes |
					
					classes := (each classHistories asOrderedCollection sortedAs: #medianBugAge).
					classes := classes reject: [ :class | class first versionEntity isInnerClass or: [ class first versionEntity myNamespace isNil ]].
					
					view interaction menu: #mooseMenu.
					view shape 
						rectangle
							size: 12;
							if: [ :c | c medianBugAge <= (24 * 7) ] fillColor: Color green;
							if: [ :c | c medianBugAge > (24 * 7) and: [ c medianBugAge < (24 * 30) ] ] fillColor: Color orange;
							if: [ :c | c medianBugAge >= (24 * 30) ] fillColor: Color red;
							if: [ :c | c bugs includes: aBug ] fillColor: Color black.
					view nodes: classes.
					view gridLayout gapSize: 2 ].
					view verticalLineLayout ].
			view gridLayout
]

{ #category : #'as yet unclassified' }
BugClassBrowser >> model: aModel [

	model := aModel.
]
