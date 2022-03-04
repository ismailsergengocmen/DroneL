%token VOID_TYPE    
%token INT_TYPE
%token BOOLEAN_TYPE
%token STRING_TYPE
%token CHAR_TYPE
%token FLOAT_TYPE
%token CONST
%token GLOBAL
%token RETURN
%token IF
%token ELSE
%token ELSEIF
%token FOR
%token WHILE
%token DO
%token CONTINUE
%token BREAK
%token TRY
%token CATCH
%token ADD_OP
%token SUB_OP
%token MULT_OP
%token DIV_OP
%token SINGLE_COMMENT
%token MULTI_COMMENT
%token SINGLE_QUOTE
%token DOUBLE_QUOTE
%token LP
%token RP
%token LSB
%token RSB
%token LCB
%token RCB
%token LESS_THAN
%token GREATER_THAN
%token LESS_THAN_OR_EQUAL
%token GREATER_THAN_OR_EQUAL
%token ASSIGN
%token EQUAL_OP
%token NOTEQUAL_OP
%token LOGICAL_OR
%token LOGICAL_AND
%token NOT
%token SEMICOLON
%token COMMA
%token DOLLAR
%token DIGIT
%token IDENTIFIER
%token INT
%token FLOAT
%token BOOLEAN
%token LETTER
%token STRING
%token CHAR
%token ARRAY
%token MAIN
%token READ_HEADER
%token READ_ALTITUDE
%token READ_TEMPERATURE
%token MOVE_VERTICALLY
%token MOVE_HORIZONTALLY
%token TURN_HEADING
%token TURN_SPRAY
%token CONNECT
%token GET
%token PRINT
%token FUNC_NAME    
%start initial

%%   
initial:
	before_main main_function;
before_main:
	comment_line before_main
	| function_definition before_main
	| global_var_dec before_main
	|
;
main_function:
           MAIN LP RP LCB statements RCB;
statements:
		statement statements
		|
;
statement:
		loop_statement 
		| function_call
		| var_dec
		| assign
		| comment_line
		| error_statement
		| if_statement
;

if_statement:
	only_if | if_else | if_elseif_else;
only_if:
	IF LP l_expression RP LCB statements RCB;
if_else:
	IF LP l_expression RP LCB statements RCB ELSE LCB statements RCB;
if_elseif_else:
	IF LP l_expression RP LCB statements RCB ELSEIF LP l_expression RP LCB statements RCB ELSE LCB statements RCB;

return_statement:
	RETURN val SEMICOLON | RETURN var_name SEMICOLON | RETURN SEMICOLON;
array:
	ARRAY LSB INT RSB 
	| ARRAY LSB var_name RSB
;
loop_statement:
	while_loop 
	| for_loop
	| do_while_loop
;
while_loop:
	WHILE LP l_expression RP LCB statements RCB;
for_loop:
	FOR LP var_dec l_expression SEMICOLON assign RP LCB statements RCB;
do_while_loop:
	DO LCB statements RCB WHILE LP l_expression RP SEMICOLON;
var_dec: 
	global_var_dec
	| non_global_var_dec	
;
global_var_dec:
	GLOBAL const_var_dec
	| GLOBAL non_const_var_dec
;
non_global_var_dec:
	const_var_dec 
	| non_const_var_dec
;
non_const_var_dec:
	var_id_type var_name ASSIGN l_expression SEMICOLON
	| var_id_type var_name ASSIGN function_call
	| var_id_type var_name SEMICOLON 
	| array ASSIGN LCB list RCB SEMICOLON
;
const_var_dec:
	CONST var_id_type var_name ASSIGN l_expression SEMICOLON
	| CONST var_id_type var_name ASSIGN function_call
	| CONST var_id_type var_name SEMICOLON 
	| CONST array ASSIGN LCB list RCB SEMICOLON
;
list: 
	val COMMA list 
	|
;

l_expression:
        l_factor_0
	| l_expression ADD_OP l_factor_0
	| l_expression SUB_OP l_factor_0
;
l_factor_0:
	l_factor_1 
	| l_factor_0 MULT_OP l_factor_1 
	| l_factor_0 DIV_OP l_factor_1
;
l_factor_1:
        l_factor_2
        | l_factor_1 LOGICAL_OR l_factor_2
;
l_factor_2:
	l_factor_3
	| l_factor_2 LOGICAL_AND l_factor_3
;
l_factor_3:  	
	l_factor_4
	| l_factor_3 EQUAL_OP l_factor_4 
	| l_factor_3 NOTEQUAL_OP l_factor_4
;
l_factor_4:  	
	l_factor_5
	|  l_factor_4 GREATER_THAN l_factor_5
	|  l_factor_4 GREATER_THAN_OR_EQUAL l_factor_5
        |  l_factor_4 LESS_THAN l_factor_5
        |  l_factor_4 LESS_THAN_OR_EQUAL l_factor_5
;
l_factor_5:  	
	l_factor_6
	| l_factor_5 NOT l_factor_6
;
l_factor_6:
	INT
	| FLOAT
	| BOOLEAN
	| CHAR
	| var_name
	| LP l_expression RP
;
input:
	GET LP STRING RP SEMICOLON
	| GET LP RP SEMICOLON
;
output: 
	PRINT LP var_name RP SEMICOLON
	| PRINT LP val RP SEMICOLON
;
var_id_type: 
	INT_TYPE
	| CHAR_TYPE
	| BOOLEAN_TYPE
	| STRING_TYPE
	| FLOAT_TYPE
;
assign:
	var_name assign_op l_expression SEMICOLON
	| var_name assign_op function_call	
;
assign_op:
	ASSIGN;
error_statement:
	TRY LCB statement RCB CATCH LCB statement RCB;
function_definition:
	function_type function_identifier LP parameters RP LCB statements return_statement RCB;
function_identifier:
	FUNC_NAME;
function_type:
	 INT_TYPE | VOID_TYPE | STRING_TYPE | BOOLEAN_TYPE | CHAR_TYPE;
parameters:
	var_id_type var_name 
	| var_id_type var_name COMMA parameters
	|
;
function_call:
	function_identifier LP arguments RP SEMICOLON
	| primitive_function_call
;
arguments: 
	var_name 
	| val 
	| var_name COMMA arguments 
	| val COMMA arguments 
	|
;
val:
	INT | FLOAT | STRING | CHAR;
var_name:
	IDENTIFIER
;
primitive_function_call: 
	read_header_function 
	| read_altitude_function
	| read_temperature_function
	| move_vertically_function
	| move_horizontally_function
	| turn_heading_function
	| turn_spray_function
	| connect_function
	| input
	| output
;
read_header_function: 
 	READ_HEADER LP RP SEMICOLON;
read_altitude_function: 
 	READ_ALTITUDE LP RP SEMICOLON;
read_temperature_function: 
 	READ_TEMPERATURE LP RP SEMICOLON;
move_vertically_function: 
	MOVE_VERTICALLY LP INT RP SEMICOLON
	| MOVE_VERTICALLY LP FLOAT RP SEMICOLON
	| MOVE_VERTICALLY LP var_name RP SEMICOLON
;
move_horizontally_function: 
	MOVE_HORIZONTALLY LP INT RP SEMICOLON
	| MOVE_HORIZONTALLY LP FLOAT RP SEMICOLON
	| MOVE_HORIZONTALLY LP var_name RP SEMICOLON
;
turn_heading_function:
	TURN_HEADING LP l_expression RP SEMICOLON 
;
turn_spray_function:
	TURN_SPRAY LP BOOLEAN RP SEMICOLON;
connect_function:
        CONNECT LP STRING RP SEMICOLON
	| CONNECT LP var_name RP SEMICOLON;
comment_line:
	SINGLE_COMMENT | MULTI_COMMENT;
%%
#include "lex.yy.c"
int yyerror(char* s){
  fprintf(stderr, "%s on line %d\n", s, yylineno);
  return 1;
}

int main(){
  yyparse();

  if(yynerrs < 1) {
	printf("Parsing is successfully done\n");
  }
 return 0;
}

