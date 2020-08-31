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
	let temporales = 0;
    let newTemp = () =>{
        temporales++;
        return `t${temporales}`;
    }
%}

%% 

expressions
    : e EOF
        { 
            return eval('$1').c3d;
        }
    ;

e
    : e '+' t
    {
        let v1 = eval('$1');
        let v2 = eval('$3');
        let temporal = newTemp(); 
        $$ ={
           temp :  temporal,
           c3d :   `${v1.c3d}\n` +  
                   `${v2.c3d}\n` +
                   `${temporal} = ${v1.temp} + ${v2.temp}`
        };
    }
    | e '-' t    
    {
        let v3 = eval('$1');
        let v4 = eval('$3');
        let temporal2 = newTemp();
        $$ ={
           temp :  temporal2,
           c3d :   `${v3.c3d}\n` + 
                   `${v4.c3d}\n` +
                   `${temporal2} = ${v3.temp} - ${v4.temp}`
        };
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
        let temporal3 = newTemp();
        $$ ={
           temp :  temporal3,
           c3d :   `${v5.c3d}\n`+  
                   `${v6.c3d}\n`+
                   `${temporal3} = ${v5.temp} * ${v6.temp}`
        };
    }    
    | t '/' f    
    {
        let v7 = eval('$1');
        let v8 = eval('$3');
        let temporal4 = newTemp();
        $$ ={
           temp :  temporal4,
           c3d :   `${v7.c3d}\n` + 
                   `${v8.c3d}\n` +
                   `${temporal4} = ${v7.temp} / ${v8.temp}`
        };
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