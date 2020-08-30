%lex
%%

\s+                   
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
[a-z]                 return 'ID'
"*"                   return '*'
"/"                   return '/'
"-"                   return '-'
"+"                   return '+'
"^"                   return '^'
"("                   return '('
")"                   return ')'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex


%start expressions

%% 

expressions
    : e EOF
        {return $1;}
    ;

e
    : e '+' t
;

t
    : t '*' f
;

f
    : 'NUMBER'
    | 'ID'
    | '(' e ')'
;
