
tokens  = (
    'PARIZQ',
    'PARDER',
    'MAS',
    'MENOS',
    'POR',
    'DIVIDIDO',
    'ID',
    'ENTERO'
)


t_PARIZQ    = r'\('
t_PARDER    = r'\)'
t_MAS       = r'\+'
t_MENOS     = r'-'
t_POR       = r'\*'
t_DIVIDIDO  = r'/'


t_ignore = " \t"

    
def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)

def t_ID(t):
     r'[a-zA-Z_][a-zA-Z_0-9]*'
     return t

def t_ENTERO(t):
    r'\d+'
    try:
        t.value = int(t.value)
    except ValueError:
        print("Integer value too large %d", t.value)
        t.value = 0
    return t


import ply.lex as lex
lexer = lex.lex()
from operacion import *



def p_init(t):
    'init   :  e '
    print(t[1].traducir())


def p_e(t):
    '''e    : e MAS t
            | e MENOS t
    '''
    if   t[2] == '+'  : t[0] =   Operacion( t[1] , t[3], t[2])
    elif t[2] == '-'  : t[0] =   Operacion( t[1] , t[3], t[2])



def p_et(t):
    'e : t '
    t[0] = t[1]


def p_t(t):
    '''t    : t POR f
            | t DIVIDIDO f
    '''
    if   t[2] == '*': t[0] = Operacion( t[1] , t[3], t[2])
    elif t[2] == '/': t[0] = Operacion( t[1] , t[3], t[2])



def p_tf(t):
    't : f '
    t[0] = t[1]



def p_f(t):
    'f : ID'
    t[0] = Operacion( None, None, t[1] )


def p_fpar(t):
    'f : PARIZQ e PARDER'
    t[0] = t[2]


def p_error(t):
    print("Error sintáctico en '%s'" % t.value)

import ply.yacc as yacc
parser = yacc.yacc()


f = open("./entrada.txt", "r")
input = f.read()
print(input)
parser.parse(input)