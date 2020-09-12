%{
    const { ExpresionAritmetica } = require('../Expresiones/ExpresionAritmetica');
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

%}

%% 

expressions
    : o EOF
        { 
            return $1;
        }
    ;

o
    : o '||' a
    | a
;


a
    : a '&&' n
    | n
;

n
    : '!' r
    | r
;

r
    : e '<=' e
    | e '>=' e
    | e '<' e
    | e '>' e            
    | e
;

e
    : e '+' t
    {
        $$ = new ExpresionAritmetica( $2 , $1 , $3);    
    }
    | e '-' t    
    {
        $$ = new ExpresionAritmetica( $2 , $1 , $3);
    }
    | t
    {
        $$ = $1;
    }
;

t
    : t '*' f
    {
        $$ = new ExpresionAritmetica( $2 , $1 , $3);
    }    
    | t '/' f    
    {
        $$ = new ExpresionAritmetica( $2 , $1 , $3);
    }
    | f 
    {
        $$ = $1;
    }
;

f
    : 'ID'
    {
        $$ = new ExpresionAritmetica( $1 , null ,null);
    }
    | '(' e ')'
    {
    $$ = $2;    
    }    
;