run
parseEntitiesLine:  line forBug: aBug

	(line subStrings: ';') do: [ :str | | name entity |
		"must remove possible leading [ and trailing space from name"
		name := str trimLeft: [:c | c == $[ ] right: [:c | c == $  ].
		"must remove possible xxxx:: before org::"
		
		"name :=  self removeBefore: 'org::' in: name."
		entity := model allModelClassHistories detect: [:each | name endsWith: each mooseName] ifNone: [nil].
		entity notNil ifTrue: [ aBug addEntity: entity	]
	].

	^ aBug entities

	