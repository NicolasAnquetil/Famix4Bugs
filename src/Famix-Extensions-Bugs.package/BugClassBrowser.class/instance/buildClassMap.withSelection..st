as yet unclassified
buildClassMap: view withSelection: aBug
	
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