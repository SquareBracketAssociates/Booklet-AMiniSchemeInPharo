## Scheme in a \(super\) nutshell
	(lambda (l)
		(if (null? l)
			0
			(+ 1 (len2 (cdr l))))))
>>> 4
>>> #t
>>> 11
>>> 1
>>> (2 3 4)
>>> (1 2 3 4)
>>> (1)
>>> ()
>>> #t
>>> #f
>>> 11

(define goldenRatio (/ (+ 1 (sqrt 5)) 2))

pi 
>>> 3.14
	(+ 2 x))
	(+ 2 x))
	3)
>>> 5

(add2 3)
>>> 5

(add2 33)
>>> 35
	((lambda (x)
		(lambda (y)
			(+ x y)))
		3))
>>> 7
		((lambda (x)
			(lambda (y)
				(begin
					(set x (+ x 2))
					(+ x y))))
			3))
>>> 10
(sy3 5)
>>> 12
(sy3 5)
>>> 14
>>> 1
>>> (add2 17)
>>> (quote 1)
>>>  (1 2 3 4)
>>> 1
>>> (2 3 4)
>>> (1 2 3 4)
>>> (2 3)
	instanceVariableNames: 'ph'
	classVariableNames: ''
	package: 'Phsyche'
	ph := Phsyche new
	self 
		assert: (ph parse: '(define squared (lambda (x) (* x x)))') 
		equals: #(#define #squared #(#lambda #(#x) #(* x x)))
	self assert: (ph parse: '()') equals: #()
	self 
		assert: (ph parse: '12.33')
		equals: 12.33
	self 
		assert: (ph parse: 'r')
		equals: #r
	self assert: (ph parse: '(isNull (cons (quote a) #()))') equals: #(#isNull #(#cons #(#quote #a) #())).
	self assert: (ph parse: '(isNull (cons (quote a) ()))') equals: #(#isNull #(#cons #(#quote #a) #()))
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'Phsyche'
	aProgramString ifEmpty: [ ^ #() ].
	^ (Scanner new scanTokens: aProgramString) first 
	self assert: (ph parseAndEval: '()') equals: #()
	self assert: (ph parseAndEval: 'true') equals: true.
	self assert: (ph parseAndEval: 'false') equals: false.
	self assert: (ph parseAndEval: '12') equals: 12.
	self assert: (ph parseAndEval: '3.14') equals: 3.14.

	^ self eval: (self parse: anExpression)
	^ self eval: expression in: nil
	^ expression 
	ph parseAndEval: '(define pi 3.14)'.
	self 
		assert: (ph  parseAndEval: 'pi')
		equals:  3.14.
	super initialize.
	environment := Dictionary new
	^ self eval: expression in: environment
	expression = #()
		ifTrue: [ ^ expression ].
	expression isSymbol
		ifTrue: [ ^ anEnvironment at: expression ].	"returns the variable value"
	expression isArray
		ifFalse: [ "returns literals boolean, string, number" ^ expression ]
		ifTrue: [ 
			expression first = #define
				ifTrue: [ ^ self evalDefineSpecialForm: expression in: anEnvironment ].
	anEnvironment 
		at: expression second 
		put: (self eval: expression third in: anEnvironment).
	^ #undefined
	ph parseAndEval: '(define pi 3.14)'.
	ph parseAndEval: '(define pi2 pi)'.
	ph parseAndEval: '(define pi 6.28)'.
	self assert: (ph parseAndEval: 'pi2') equals: 3.14
	self 
		assert: (ph parseAndEval: '(quote (* x x))') 
		equals: #(#* #x #x).
	self 
		assert: (ph parseAndEval: '(quote (quote (* x x)))') 
		equals: #(quote #(#* #x #x))
	expression = #()
		ifTrue: [ ^ expression ].
	expression isSymbol
		ifTrue: [ ^ anEnvironment at: expression ].	"returns the variable value"
	expression isArray
		ifFalse: [ "returns literals boolean, string, number" ^ expression ]
		ifTrue: [ | first |
			first := expression first. 
			first = #define
				ifTrue: [ ^ self evalDefineSpecialForm: expression in: anEnvironment ]
			first = #quote
				ifTrue: [ ^ expression second ]
	self assert: (ph parseAndEval: '(* 3 8)') equals: 24
	self assert: (ph parseAndEval: '(* (+ 2 3) 8)') equals: 40.
	self assert: (ph parseAndEval: '(* 8 (+ 2 3))') equals: 40
	^ #* -> [:e :v | e * v]
	^ #+ ->  [:e :v | e + v]
	instanceVariableNames: 'environment primitives'
	classVariableNames: ''
	package: 'Phsyche'
	super initialize.
	environment := Dictionary new.
	primitives := OrderedCollection new.
	self initializeEnvBindings
	(self class selectors select: [ :each | each endsWith: 'Binding' ])
		do: [ :s | 
				| binding |
				binding := self perform: s.
				primitives add: binding key.
				environment at: binding key put: binding value ]

	^ (anEnvironment at: exp first) 
			valueWithPossibleArgs: (exp allButFirst collect: [ :e | self eval: e in: anEnvironment])
	expression = #()
		ifTrue: [ ^ expression ].
	expression isSymbol
		ifTrue: [ ^ anEnvironment at: expression ].	"returns the variable value"
	expression isArray
		ifFalse: [ "returns literals boolean, string, number" ^ expression ]
		ifTrue: [ | first |
			first := expression first.
			(primitives includes: first)
				ifTrue: [ ^ self evalPrimitive: expression in: anEnvironment ]
				ifFalse: [ first = #define
						ifTrue: [ ^ self evalDefineSpecialForm: expression in: anEnvironment ].
					first = #quote
						ifTrue: [ ^ expression second ]]
	^ #equal -> [ :e :v | e = v ]
	^ #>= -> [ :e :v | e >= v ]
	^ #equal -> [ :e :v | e = v ]
	^ #- -> [ :e :v | e - v ]
	^ #< -> [ :e :v | e < v ]
	^ #< -> [ :e :v | e <= v ]
	^ #- -> [ :e :v | e - v ]
	^ #/ -> [ :e :v | (e / v) asFloat ]
	self should: [ ph parseAndEval: '(/ 5 0)' ] raise: ZeroDivide
	self assert: (ph parseAndEval: '(not false)').
	self deny: (ph parseAndEval: '(not true)')
	^ #not -> [ :a | a not ]
	self assert: (ph parseAndEval: '(cons (quote a) ())') equals: #(a)
	self
		assert: (ph parseAndEval:  '(car (cons (quote a) (cons (quote b) ())))')
		equals: #a
	self assert: (ph parseAndEval: '(cdr (quote (quote a)))') equals: #(a)
	self assert: (ph parseAndEval: '(isNull #())').
	self assert: (ph parseAndEval: '(isNull (quote ()))').
	self deny: (ph parseAndEval: '(isNull (cons (quote a) #()))')
	^ #car -> [ :l | l first ]
	^ #cdr -> [ :l | l allButFirst ]
	^ #cons -> [ :e :l | {e} , l ]
	^ #isNull -> [ :l | l = #() ]
	self assert: (ph parseAndEval: '(if true 4 5)') equals: 4.
	self assert: (ph parseAndEval: '(if false 4 5)') equals: 5
	self assert: (ph eval: (ph parse: '(if true 4 (/ 5 0))')) equals: 4.
	self assert: (ph eval: (ph parse: '(if false (/ 5 0) 5)')) equals: 5
	^ (self eval: expression second in: anEnvironment)
		ifTrue: [ self eval: expression third in: anEnvironment ]
		ifFalse: [ self eval: expression fourth in: anEnvironment ]
	expression = #()
		ifTrue: [ ^ expression ].
	expression isSymbol
		ifTrue: [ ^ anEnvironment at: expression ].	"returns the variable value"
	expression isArray
		ifFalse: [ "returns literals boolean, string, number" ^ expression ]
		ifTrue: [ | first |
			first := expression first.
			(primitives includes: first)
				ifTrue: [ ^ self evalPrimitive: expression in: anEnvironment ]
				ifFalse: [ first = #define
						ifTrue: [ ^ self evalDefineSpecialForm: expression in: anEnvironment ].
								first = #if
						ifTrue: [ ^ self evalIfSpecialForm: expression in: anEnvironment].
					first = #quote
						ifTrue: [ ^ expression second ]]
					]
(define area
	(lambda (r)
		(* pi (* r r))))
>>> 314
(define pi 3.14)
(define area
	(lambda (r)
		(* pi (* r r))))
>>> 314
	instanceVariableNames: 'outer inner'
	classVariableNames: ''
	package: 'Phsyche'
	outer := PEnvironment new.
	inner := PEnvironment new.
	inner outerEnvironment: outer
	outer at: #dad put: 'donald'.
	self assert: (outer at: #dad) equals: 'donald'.
	inner at: #son put: 'riri'.
	self assert: (inner at: #son) equals: 'riri'
	outer at: #dad put: 'donald'.
	inner at: #son put: 'riri'.
	self assert: (inner at: #dad) equals: 'donald'
	outer at: #dad put: 'donald'.
	inner at: #son put: 'riri'.
	self should: [ outer at: #nodad ] raise: KeyNotFound.
	self should: [ outer at: #noson ] raise: KeyNotFound.
	self should: [ inner at: #nodad ] raise: KeyNotFound
	instanceVariableNames: 'outerEnvironment'
	classVariableNames: ''
	package: 'Phsyche'
	outerEnvironment := anEnvironment
	| value |
	value := self at: aKey ifAbsent: [ nil ].
	^ value
		ifNil: [ outerEnvironment 
			ifNil: [ super at: aKey ] 
			ifNotNil: [ outerEnvironment at: aKey ] ]
		ifNotNil: [ :v | v ]
	| proc |
	ph parseAndEval: '(define squared (lambda (x) (* x x)))'.
	proc := ph parseAndEval: #squared.
	self assert: proc parameters equals: #(#x).
	self assert: proc body equals: #(#* #x #x)
	instanceVariableNames: 'parameters body'
	classVariableNames: ''
	package: 'Phsyche'
	expression = #()
		ifTrue: [ ^ expression ].
	expression isSymbol
		ifTrue: [ ^ anEnvironment at: expression ].	"returns the variable value"
	expression isArray
		ifFalse: [ "returns literals boolean, string, number" ^ expression ]
		ifTrue: [ | first |
			first := expression first.
			(primitives includes: first)
				ifTrue: [ ^ self evalPrimitive: expression in: anEnvironment ]
				ifFalse: [ first = #define
						ifTrue: [ ^ self evalDefineSpecialForm: expression in: anEnvironment ].
					first = #lambda
						ifTrue: [ ^ self evalLambdaSpecialForm: expression in: anEnvironment ].
					first = #if
						ifTrue: [ ^ self evalIfSpecialForm: expression in: anEnvironment].
					first = #quote
						ifTrue: [ ^ expression second ] ] ]
	^ PFunction new
		parameters: expression second;
		body: expression third
	self assert: (ph parseAndEval: '((lambda (x) (* x x)) 3)') equals: 9.
	ph parseAndEval: '(define squared (lambda (x) (* x x)))'.
	self assert: (ph parseAndEval: '(squared 3)') equals: 9
	expression = #()
		ifTrue: [ ^ expression ].
	expression isSymbol
		ifTrue: [ ^ anEnvironment at: expression ].	"returns the variable value"
	expression isArray
		ifFalse: [ "returns literals boolean, string, number" ^ expression ]
		ifTrue: [ | first |
			first := expression first.
			(primitives includes: first)
				ifTrue: [ ^ self evalPrimitive: expression in: anEnvironment ]
				ifFalse: [ 
						first = #define
							ifTrue: [ ^ self evalDefineSpecialForm: expression in: anEnvironment ].
						first = #lambda
							ifTrue: [ ^ self evalLambdaSpecialForm: expression in: anEnvironment ].
						first = #if
							ifTrue: [ ^ self evalIfSpecialForm: expression in: anEnvironment].
						first = #quote
							ifTrue: [ ^ expression second ]
							ifFalse: [
								^ self evalApplicativeOrder: expression in: anEnvironment ] ] ]
	"Now we have function application ((lambda (x) (+ x 3)) (+ 9 1))"
	
	| proc newEnv |
	proc := self eval: expression first in: anEnvironment.
	newEnv := proc
		setEnvironmentForParameters: (expression allButFirst collect: [ :e | self eval: e in: anEnvironment ])
		in: anEnvironment.
	^ self eval: proc body in: newEnv
	"Create a new environment inheriting from the functino one, for the current application."
	| applicationEnvironment |
	applicationEnvironment := PEnvironment newFromKeys: self parameters andValues: values.
	applicationEnvironment outerEnvironment: outerEnvironment.
	^ applicationEnvironment
	"Create a dictionary from the keys and values arguments which should have the same length."	
	"(Dictionary newFromKeys: #(#x #y) andValues: #(3 6)) >>> (Dictionary new at: #x put: 3; at: #y put: 6 ;yourself)"
	
	| dict |
	dict := self new.
	keys with: values do: [ :k :v | dict at: k put: v ].
	^ dict
 ((lambda (x)
   (lambda (y)
     (+ x y)))
  3)
 7)
>>> 10
   (lambda (y)
     (+ x y)))
  3)
 ((lambda (x)
   (lambda (y)
     (+ x y)))
  3))
>>> 10
	<=>
((lambda (x) (+ x x)) 3)
  ((lambda (x)
      (lambda (y)
       x))
	  3))

(fy3 7)

	| proc |
	ph eval: (ph parseAndEval: '(define fy3 
  ((lambda (x)
   (lambda (y)
      x))
  3))').
	proc := ph parseAndEval: '#fy3'.
	self assert: proc parameters equals: #(y).
	self assert: (proc environment at: #x) equals: 3.

	| res |
	res := ph eval: (ph parse: '(
 ((lambda (x)
   (lambda (y)
     (+ x y)))
  3)
 7)').
	self assert: res equals: 10
	instanceVariableNames: 'parameters body environment'
	classVariableNames: ''
	package: 'Pheme-Interpreters'
	^ PFunction new
		parameters: expression second;
		body: expression third;
		environment: anEnvironment
	"Now we have function application ((lambda (x) (+ x 3)) (+ 9 1))"
	| proc newEnv |
	proc := self eval: expression first in: anEnvironment.
	newEnv := proc
		setEnvironmentForParameters: (expression allButFirst collect: [ :e | self eval: e in: anEnvironment ])
		in: proc environment.
	^ self eval: proc body in: newEnv
	"Now we have function application ((lambda (x) (+ x 3)) (+ 9 1))"
	| proc newEnv |
	proc := self eval: expression first in: anEnvironment.
	newEnv := proc
		setEnvironmentForParameters: (expression allButFirst collect: [ :e | self eval: e in: anEnvironment ])
		in: proc environment.
	^ self eval: proc body in: newEnv
	
	outer at: #dad put: 'donald'.
	inner at: #son put: 'riri'.
	self assert: (inner at: #son) = 'riri'.
	inner lookupAt: #son put: 'fifi'.
	
	self assert: (outer at: #dad) = 'donald'.
	outer lookupAt: #dad put: 'piscou'.
	self assert: (outer at: #dad) = 'piscou'.
	outer at: #dad put: 'donald'.
	inner at: #son put: 'riri'.
	self assert: (inner at: #dad) = 'donald'.
	inner lookupAt: #dad put: 'picsou'.
	self assert: (outer at: #dad) = 'picsou'.
	self assert: (inner at: #dad) = 'picsou'.
	self deny: (inner keys includes: #dad)
	"Change the value of the binding whose key is aKey, but looking in the complete ancestor chain.
	If the binding does not exist, it raises an error to indicate that we should define it first."
	| found |
	found := self at: aKey ifAbsent: nil.
	found 
		ifNil: [ outerEnvironment  
					ifNotNil: [ outerEnvironment lookupAt: aKey put: aValue] 
					ifNil: [ KeyNotFound signal: aKey , ' not found in the environment' ]]
		ifNotNil: [ self at: aKey put: aValue ]
	self assert: (ph parseAndEval: '(define x2 21') equals: #undefined.
	self assert: (ph parseAndEval: '(set x2 22)') equals: #undefined.
	self assert: (ph parseAndEval: 'x2') equals: 22.
	...
		first = #define
			ifTrue: [ ^ self evalDefineSpecialForm: expression in: anEnvironment ].
		first = #set
			ifTrue: [ ^ self evalSetSpecialForm: expression in: anEnvironment ].
		first = #lambda
			ifTrue: [ ^ self evalLambdaSpecialForm: expression in: anEnvironment ].
	...
	anEnvironment 
		lookupAt: expression second 
		put: (self eval: expression third in: anEnvironment).
	^ #undefined
	self assert: (ph parseAndEval: '(begin 1 2 3)') equals: 3
	self assert: (ph parseAndEval:  '(begin (define x 1) (set x 2) x)') equals: 2
	...
		first = #define
			ifTrue: [ ^ self evalDefineSpecialForm: expression in: anEnvironment ].
		first = #set
			ifTrue: [ ^ self evalSetSpecialForm: expression in: anEnvironment ].
		first = #lambda
			ifTrue: [ ^ self evalLambdaSpecialForm: expression in: anEnvironment ].
		first = #begin
			ifTrue: [ ^ self evalBeginSpecialForm: expression in: anEnvironment ].
	...
	| res |
	expression allButFirst 
		do: [ :each | res := self eval: each in: anEnvironment ].
	^ res
	| proc |
	ph parseAndEval: '
	(define fy3 
		((lambda (x)
			(lambda (y)
					(begin
						(set x (+ x 2))
						(+ x y))))
				3))
	').
	proc := ph eval: #fy3.
	self assert: (ph parseAndEval: '(fy3 5)') equals: 10
	(lambda (balance)
		(lambda (amount)
			(begin 
				(set! balance (+ balance amount))
				balance))))
(ac1 -200)
>>> 800
(define ac2 (makeAccount 2000))
(ac2 300)
>>> 2300
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'Pheme-Tests'
	super setUp.
	ph := Phsycoo new
	instanceVariableNames: 'primitives environment'
	classVariableNames: ''
	package: 'Pheme-Phsycoo'
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'Pheme-Phsycoo'
	with: anInterpreter 
	environment: anEnvironment 
	
	^ self subclassResponsibility
	^ self subclassResponsibility 
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'Pheme-Phsycoo'
	^ #+
	^  (anInterpreter eval: aCollection first in: anEnvironment ) 
			+ (anInterpreter eval: aCollection second in: anEnvironment )
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'Pheme-Phsycoo'
	"aCollection: (if cond expr1 expr2)"

	| cond |
	cond := anInterpreter eval: aCollection first in: anEnvironment.
	^ cond
		ifTrue: [ anInterpreter eval: aCollection second in: anEnvironment ]
		ifFalse: [ anInterpreter eval: aCollection third in: anEnvironment ]

	^ #if
	
	^ PhsycooPrimitives allSubclasses 	
			do: [ :cls | primitives add: cls tag. 
					environment at: cls tag put: cls new ]
	expression = #()
		ifTrue: [ ^ expression ].
	expression isSymbol
		ifTrue: [ ^ anEnvironment at: expression ].
	expression isArray
		ifFalse: [ ^ expression ]
		ifTrue: [ (self isPrimitive: expression first)
				ifTrue: [ ^ self evaluateNonApplicativeOrder: expression in: anEnvironment]
				ifFalse: [ ^ self evaluateApplicativeOrder: expression in: anEnvironment] ]
	^ (anEnvironment at: expression first)
		valueFor: expression allButFirst
		with: self
		environment: anEnvironment 
	"Now we have function application ((lambda (x) (+ x 3)) (+ 9 1))"
	| proc applicationEnv |
	proc := self eval: expression first in: anEnvironment.
	applicationEnv := proc
		setEnvironmentForParameters: (expression allButFirst collect: [ :e | self eval: e in: anEnvironment])
		in: proc environment.	
	^ self eval: proc body in: applicationEnv.