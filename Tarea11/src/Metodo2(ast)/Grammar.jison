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
    : e EOF
        { 
            return $1;
        }
    ;

e
    : e '+' t
    {

    $$ = new Operacion( "+" , $1 , $3 );
    
    }
    | e '-' t    
    {

    $$ = new Operacion( "-" , $1 , $3 );
    }
    | t
    {
        $$ = $1;
    }
;

t
    : t '*' f
    {

    $$ = new Operacion( "*" , $1 , $3);
    }    
    | t '/' f    
    {

    $$ = new Operacion( "/" , $1 , $3 );
    }
    | f 
    {
        $$ = $1;
    }
;

f
    : 'ID'
    {

    $$ = new Operacion( eval('$1'), null, null ); 
    }
    | '(' e ')'
    {
    $$ = $2;    
    }    
;