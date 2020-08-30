%lex



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
%{
	let temporales = 1;
%}

%% 

expressions
    : e EOF
        { 
            console.log(eval('$1').c3d);
        }
    ;

e
    : e '+' t
    {
        let v1 = eval('$1');
        let v2 = eval('$3');

        $$ ={
           temp :  `t${temporales}`,
           c3d :   `${v1.c3d}\n` +  
                   `${v2.c3d}\n` +
                   `t${temporales} = ${v1.temp} + ${v2.temp}\n`
        };
        temporales++;
    }
    | e '-' t    
    {
        let v3 = eval('$1');
        let v4 = eval('$3');

        $$ ={
           temp :  `t${temporales}`,
           c3d :   `${v3.c3d}\n` + 
                   `${v4.c3d}\n` +
                   `t${temporales} = ${v3.temp} - ${v4.temp}\n`
        };
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
        let v5 = eval('$1');
        let v6 = eval('$3');

        $$ ={
           temp :  `t${temporales}`,
           c3d :   `${v5.c3d}\n`+  
                   `${v6.c3d}\n`+
                   `t${temporales} = ${v5.temp} * ${v6.temp}\n`
        };
        temporales++;
    }    
    | t '/' f    
    {
        let v7 = eval('$1');
        let v8 = eval('$3');

        $$ ={
           temp :  `t${temporales}`,
           c3d :   `${v7.c3d}\n` + 
                   `${v8.c3d}\n` +
                   `t${temporales} = ${v7.temp} / ${v8.temp}\n`
        };
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
    
    $$ = {
        temp : $1,
        c3d : ""
    }
    
    }
    | '(' e ')'
    {
    $$ = $2;    
    }    
;