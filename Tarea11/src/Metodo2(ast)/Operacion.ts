class Operacion{

    public operador : string;
    public izquierda : Operacion | null;
    public derecha : Operacion | null;

    constructor(operador : string , izq : Operacion, der : Operacion ){
        this.operador = operador;
        this.izquierda = izq;
        this.derecha = der;
    }

    public traducir() : string{
        if(this.operador == "+"){

        }
        else if(this.operador == "-"){
            
        }
        else if(this.operador == "*"){
            
        }
        else if(this.operador == "/"){
            
        }
        else{
            return this.operador;
        }
        return "";
    }

};