accessing
age
	<MSEProperty: #age type: #Number> <derived>
	<MSEComment: 'Number of hours of this bug from opening to resolution'>
	^ (resolutionDate - openDate) asSeconds / 3600.