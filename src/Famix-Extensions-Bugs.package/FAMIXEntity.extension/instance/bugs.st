*famix-Extensions-Bugs
bugs
	<MSEProperty: #bugs type: #FAMIXBugEntity opposite: #entities> <multivalued> <derived>
	^ self privateState attributeAt: #bugs
			ifAbsentPut: [FMMultiMultivalueLink on: self opposite: #entities]