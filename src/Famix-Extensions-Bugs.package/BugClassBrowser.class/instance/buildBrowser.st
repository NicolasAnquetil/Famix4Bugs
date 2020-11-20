as yet unclassified
buildBrowser

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