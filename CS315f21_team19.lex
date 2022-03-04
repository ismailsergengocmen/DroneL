%option yylineno
VOID_TYPE void
INT_TYPE int
BOOLEAN_TYPE boolean
STRING_TYPE string
CHAR_TYPE char
FLOAT_TYPE float
CONST const
GLOBAL global
RETURN return
IF if
ELSE else
ELSEIF elseif
FOR for
WHILE while
DO do
CONTINUE continue
BREAK break
TRY try
CATCH catch
PLUS \+
MINUS \-
MUL \*
DIV \/
SIN_COM	\/\/.*
MULT_COM \/\*([^*]|\*+[^*/])*\*\/
SIN_Q \'	
DBL_Q \"	
TAB \t
LP \(
RP \)
LSB \[
RSB \]
LCB \{
RCB \}
LT \<
GT \>
LTE \<\=
GTE \>\=
ASSIGN \=
EQ \=\=
NEQ \!\=
OR \|\|
AND \&\&
NOT \!
S_COLON \;
COMMA \,
DOLLAR \$
DIGIT [0-9]
INT [+-]?[0-9]+
FLOAT [+-]?{DIGIT}*(\.)?{DIGIT}+
BOOLEAN true|false
LETTER [a-zA-Z_]
SIGN [+|-]
ALPHANUMERIC ({LETTER}|{DIGIT})
IDENTIFIER {LETTER}{ALPHANUMERIC}* 
STRING \"(\\.|[^"\\])*\"
CHAR \'{LETTER}\'
ARRAY \<\<[ ]*{IDENTIFIER}[ ]*\>\>
MAIN \$main\$
READ_HEADER \$readHeader\$
READ_ALTITUDE \$readAltitude\$
READ_TEMPERATURE \$readTemperature\$
MOVE_VERTICALLY \$moveVertically\$
MOVE_HORIZONTALLY \$moveHorizontally\$
TURN_HEADING \$turnHeading\$
TURN_SPRAY \$turnSpray\$
CONNECT \$connect\$
GET \$get\$
PRINT \$print\$
FUNC_NAME \${IDENTIFIER}\$
NEWLINE \n

%%
{VOID_TYPE}            	return VOID_TYPE;     
{INT_TYPE}            	return INT_TYPE;
{BOOLEAN_TYPE}       	return BOOLEAN_TYPE;
{STRING_TYPE}          	return STRING_TYPE;
{CHAR_TYPE}           	return CHAR_TYPE;
{FLOAT_TYPE}           	return FLOAT_TYPE;
{CONST}           		return CONST;
{GLOBAL}		return GLOBAL;
{RETURN}          	return RETURN;
{IF}              		return IF;
{ELSE}           		return ELSE;
{ELSEIF}			return ELSEIF;
{FOR}             		return FOR;
{WHILE}           		return WHILE;
{DO}                               return DO;
{CONTINUE}                  return CONTINUE;
{BREAK}                         return BREAK;
{TRY}			return TRY;
{CATCH}		return CATCH;
{PLUS}            		return ADD_OP;
{MINUS}            	return SUB_OP;
{MUL}              		return MULT_OP;
{DIV}            		return DIV_OP;
{SIN_COM}     		return SINGLE_COMMENT;
{MULT_COM}		return MULTI_COMMENT;
{SIN_Q}		return SINGLE_QUOTE;
{DBL_Q}		return DOUBLE_QUOTE;
{LP}             		return LP;
{RP}              		return RP;
{LSB}              		return LSB;
{RSB}              		return RSB;
{LCB}              		return LCB;
{RCB}              		return RCB;
{LT}             		return LESS_THAN;
{GT}                  		return GREATER_THAN;
{LTE}            		return LESS_THAN_OR_EQUAL;
{GTE}                		return GREATER_THAN_OR_EQUAL;
{ASSIGN}         		return ASSIGN;
{EQ}           		return EQUAL_OP;
{NEQ}            		return NOTEQUAL_OP;
{OR}           		return LOGICAL_OR;
{AND}           		return LOGICAL_AND;
{NOT}	            		return NOT;
{S_COLON} 		return SEMICOLON;
{COMMA}		return COMMA;
{DOLLAR}		return DOLLAR;
{BOOLEAN}                                return BOOLEAN;
{IDENTIFIER}    	return IDENTIFIER;
{INT}			return INT;
{FLOAT}	  		return FLOAT;
{STRING}			return STRING;
{CHAR}				return CHAR;
{ARRAY}			return ARRAY;
{MAIN}			return MAIN;
{READ_HEADER}		return READ_HEADER;
{READ_ALTITUDE}		return READ_ALTITUDE;
{READ_TEMPERATURE}	return READ_TEMPERATURE;
{MOVE_VERTICALLY}		return MOVE_VERTICALLY;
{MOVE_HORIZONTALLY}	return MOVE_HORIZONTALLY;
{TURN_HEADING}		return TURN_HEADING;
{TURN_SPRAY}			return TURN_SPRAY;
{CONNECT}			return CONNECT;
{GET}                                   	return GET;
{PRINT}			return PRINT;
{FUNC_NAME}			return FUNC_NAME;
[ \t\n]			;


%%
int yywrap() { return 1;}

