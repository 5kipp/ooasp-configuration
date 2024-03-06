% generate object IDs
object_id(1..30).

% generate attribute values
int_value(1..100).
bool_value("TRUE").
bool_value("FALSE").

% generate instantiation 
ooasp_instantiation(M, I) :- ooasp_isa(I, C, O), ooasp_class(M, C).


% INHERITANCE
% inherit attributes to subclasses
ooasp_attribute(M, SC, AT, TYPE) :- ooasp_attribute(M, C, AT, TYPE), ooasp_subclass(M, SC, C).

% inherit associations to subclasses
ooasp_assoc(M, A, C1, C1MIN, C1MAX, SC2, C2MIN, C2MAX) :- 
	ooasp_assoc(M, A, C1, C1MIN, C1MAX, C2, C2MIN, C2MAX), ooasp_subclass(M, SC2, C2).

ooasp_assoc(M, A, SC1, C1MIN, C1MAX, C2, C2MIN, C2MAX) :- 
	ooasp_assoc(M, A, C1, C1MIN, C1MAX, C2, C2MIN, C2MAX), ooasp_subclass(M, SC1, C1).

% designate associations between leaf classes to be 'final'
final(M, A, C1, C2) :- 
	ooasp_assoc(M, A, C1, C1MIN, C1MAX, C2, C2MIN, C2MAX), 
	not ooasp_subclass(M, _, C1), not ooasp_subclass(M, _, C2).


% GENERATE NEW OBJECTS
% generates all possible combinations of leaf objects
{ ooasp_isa(I, C, O) : object_id(O) } :-
	ooasp_instantiation(M, I), ooasp_class(M, C), not ooasp_subclass(M, _, C).

% associate objects with one another
{ooasp_associated(I, A, O1, O2) :
	ooasp_instantiation(M, I), 
	ooasp_assoc(M, A, C1, C1MIN, C1MAX, C2, C2MIN, C2MAX), 
	ooasp_isa(I, C1, O1), ooasp_isa(I, C2, O2)}. 


% assign attribute values
{ooasp_attribute_value(I, AT, O, INTVAL) :
	ooasp_instantiation(M, I), 
	ooasp_isa(I, C, O),  
	ooasp_attribute(M, C, AT, "integer"), 
	int_value(INTVAL)}.

{ooasp_attribute_value(I, AT, O, BOOLVAL) :
	ooasp_instantiation(M, I), 
	ooasp_isa(I, C, O),  
	ooasp_attribute(M, C, AT, "boolean"), 
	bool_value(BOOLVAL)}.

{ooasp_attribute_value(I, AT, O, STRING) :
	ooasp_instantiation(M, I), 
	ooasp_isa(I, C, O),  
	ooasp_attribute(M, C, AT, "string"), 
	ooasp_attribute_enum(M, C, AT, STRING)}. 


% CONSTRAINTS:
% no two objects with same ID
:- ooasp_isa(I,C1,O1), ooasp_isa(I,C2,O2), C1 != C2, O1 = O2.


% associations
% objects with association have to be associated (with anything)
% FC stands for "final class"
:- ooasp_instantiation(M, I), ooasp_isa(I, FC1, O), 
	final(M, A, FC1, FC2), ooasp_assoc(M, A, C1, C1MIN, C1MAX, C2, C2MIN, C2MAX), C2MIN>0, 
	not ooasp_associated(I, A, O, _).

:- ooasp_instantiation(M, I), ooasp_isa(I, FC2, O), 
	final(M, A, FC1, FC2), ooasp_assoc(M, A, C1, C1MIN, C1MAX, C2, C2MIN, C2MAX), C1MIN>0, 
	not ooasp_associated(I, A, _, O).


% min cardinality (right side)
:- ooasp_instantiation(M, I), ooasp_assoc(M, A, C1, C1MIN, C1MAX, C2, C2MIN, C2MAX),
	ooasp_isa(I, C1, O1), C2MIN>0, 
	N = #count { O2 : ooasp_isa(I, FC2, O2), final(M, A, FC1, FC2), ooasp_associated(I, A, O1, O2)}, N < C2MIN. 

% min cardinality (left side)
:- ooasp_instantiation(M, I), ooasp_assoc(M, A, C1, C1MIN, C1MAX, C2, C2MIN, C2MAX),
	ooasp_isa(I, C2, O2), C1MIN>0, 
	N = #count { O1 : ooasp_isa(I, FC1, O1), final(M, A, FC1, FC2), ooasp_associated(I, A, O1, O2)}, N < C1MIN. 

% max cardinality (right side)
:- ooasp_instantiation(M, I), ooasp_assoc(M, A, C1, C1MIN, C1MAX, C2, C2MIN, C2MAX),
	ooasp_isa(I, C1, O1), 
	N = #count { O2 : ooasp_isa(I, FC2, O2), final(M, A, FC1, FC2), ooasp_associated(I, A, O1, O2)}, N > C2MAX. 

% max cardinality (left side)
:- ooasp_instantiation(M, I), ooasp_assoc(M, A, C1, C1MIN, C1MAX, C2, C2MIN, C2MAX),
	ooasp_isa(I, C2, O2),
	N = #count { O1 : ooasp_isa(I, FC1, O1), final(M, A, FC1, FC2), ooasp_associated(I, A, O1, O2)}, N > C1MAX.  



% attributes
% attribute has to have exactly one value
:- ooasp_instantiation(M, I), ooasp_attribute(M, C, AT, TYPE), ooasp_isa(I, C, O), 
	not ooasp_attribute_value(I, AT, O, _).

:- ooasp_instantiation(M, I), ooasp_attribute(M, C, AT, TYPE), ooasp_isa(I, C, O), 
	ooasp_attribute_value(I, AT, O1, VAL1), ooasp_attribute_value(I, AT, O2, VAL2), O1 = O2, VAL1 != VAL2.

% min/max int value
:- ooasp_instantiation(M, I), ooasp_attribute(M, C, AT, TYPE), 
	ooasp_attribute_value(I, AT, O, VAL), 
	ooasp_attribute_minInclusive(M, C, AT, MIN), VAL<MIN.

:- ooasp_instantiation(M, I), ooasp_attribute(M, C, AT, TYPE), 
	ooasp_attribute_value(I, AT, O, VAL), 
	ooasp_attribute_maxInclusive(M, C, AT, MAX), VAL>MAX.


#minimize { 1, I, C, O : ooasp_isa(I, C, O) }.

#show ooasp_instantiation/2.
#show ooasp_isa/3.
#show ooasp_associated/4.
#show ooasp_attribute_value/4.



% solving time goes up dramatically with number of object_ids. Although the first solution is often found at a 
% fraction of that time, it might not be optimal yet.