class Operacion() :
    def __init__(self, izq, der, operador) :
        self.izq = izq
        self.der = der
        self.operador = operador
        self.temporal = 1
    
    def new_temp(self) :
        if self.temporal < self.izq.temporal or self.temporal < self.der.temporal:
            if self.izq.temporal >= self.der.temporal :
                self.temporal = self.izq.temporal
            else :
                self.temporal = self.der.temporal
        str_temp = f"t{self.temporal}"
        self.temporal+=1
        return str_temp

    def traducir(self):
        print(self)
        if self.izq is not None and self.der is not None:
            v_izq = self.izq.traducir()
            self.der.temporal = self.izq.temporal
            v_der = self.der.traducir()
            op = self.operador
            self.operador = self.new_temp()
            return f"{v_izq}\n{v_der}\n{self.operador}={self.izq.operador} {op} {self.der.operador}"
        else:
            return ""
        
