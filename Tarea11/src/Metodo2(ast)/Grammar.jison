%{
    const { Operacion } = require('./Operacion');
%}

%lex

%%

\s+                   {}
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
[a-z]                 return 'ID'
"*"                   return '*'
"/"                   return '/'
"-"                   return '-'
"+"                   return '+'
"("                   return '('
")"                   return ')'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex


%start expressions
%{
    //Control para creacion de variables temporales
	let temporales = 1;
%}

%% 

expressions
    : e EOF
        { 
            return $1;
        }
    ;

e
    : e '+' t
    {

    $$ = new Operacion( "+" , $1 , $3 , `t${temporales}`);
    temporales++;
    
    }
    | e '-' t    
    {

    $$ = new Operacion( "-" , $1 , $3 , `t${temporales}`);
    temporales++;
    }
    | t
    {
        $$ = $1;
    }
;

t
    : t '*' f
    {

    $$ = new Operacion( "*" , $1 , $3 , `t${temporales}`);
    temporales++;
    }    
    | t '/' f    
    {

    $$ = new Operacion( "/" , $1 , $3 , `t${temporales}`);
    temporales++;
    }
    | f 
    {
        $$ = $1;
    }
;

f
    : 'ID'
    {

    $$ = new Operacion( "" , null, null , eval('$1')); 
    }
    | '(' e ')'
    {
    $$ = $2;    
    }    
;