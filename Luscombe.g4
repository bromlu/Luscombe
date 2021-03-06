grammar Luscombe;

program : location* ('INVENTORY' inventory)? location* ;

inventory: '{' item* '}';

item: name '{' action* '}' ;

location : name '{' properties* '}' ;

properties: actions
          | objects
          | intro ;

declarations : name OPERATOR NUMBER
             | name OPERATOR name;

command: declarations
       | PRINT
       | gotolocation
       | add
       | drop
       | conditional ;

add : 'ADD' item ;

drop : 'DROP' '{' name '}' ;

gotolocation : 'GOTO' '{' name '}' ;

conditional : ifblock elseIfBlock* elseblock? ;

ifblock : 'IF' (comparison|name) '{' command* '}' ;

elseIfBlock : 'ELSE IF' (comparison|name) '{' command* '}' ;

elseblock : 'ELSE' '{' command* '}';

comparison : name COMPAREOP NUMBER
            | NUMBER COMPAREOP NUMBER
            | NUMBER COMPAREOP name
            | name COMPAREOP name;

intro : 'INTRO' '{' command* '}' ;

actions: 'ACTIONS' '{' action* '}' ;

action: name (',' name)* '{' command* '}' ;

objects: 'OBJECTS' '{' item* '}' ;

name: WORD+ ;

WS : [ \r\t\n]+ -> skip ;
WORD : [a-zA-Z][a-zA-Z0-9]* ;
NUMBER : [0-9]+ ;
OPERATOR : [+=\-/*%] ;
COMPAREOP : ('=='|'<'|'>'|'>='|'<=') ;
PRINT : 'PRINT' ' '* '{' .*? '}' ;
COMMENT : '//' .*? [\r\n] -> skip ;