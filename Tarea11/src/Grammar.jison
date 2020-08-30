%lex

%{
	let temporales = 1;
%}

%%

\s+                   {}
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
    {
        let v1 = eval('$1');
        let v2 = eval('$3');

        $$ ={
           temp :  `t${temporales}`,
           c3d :   `${v1.c3d}  
                    ${v2.c3d}
                    t${temporales} = ${v1.temp} + ${v2.temp}`
        };
        temporales++;
    }
    | e '-' t    
    | t
;

t
    : t '*' f
    | t '/' f    
    | f
;

f
    : 'ID'
    {
    $$ = {
        temp : eval($1),
        c3d : ""
    }
    }
    | '(' e ')'
;
