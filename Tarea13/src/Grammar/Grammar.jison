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
;

e
    : e '+' t
    {

    
    }
    | e '-' t    
    {

    }
    | t
    {
        $$ = $1;
    }
;

t
    : t '*' f
    {

    }    
    | t '/' f    
    {

    }
    | f 
    {
        $$ = $1;
    }
;

f
    : 'ID'
    {

    }
    | '(' e ')'
    {
    $$ = $2;    
    }    
;