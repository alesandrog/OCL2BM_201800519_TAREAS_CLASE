export class Operacion{

    public operador : string;
    public izquierda : Operacion | null;
    public derecha : Operacion | null;
    public temp : string;

    constructor(operador : string , izq : Operacion, der : Operacion, temp:string ){
        this.operador = operador;
        this.izquierda = izq;
        this.derecha = der;
        this.temp = temp;
    }

    public traducir() : string{
        if(this.izquierda != null && this.derecha != null){
            let izq = this.izquierda?.traducir();
            let der = this.derecha?.traducir();

            return `${izq}\n${der}\n${this.temp} = ${this.izquierda.temp} ${this.operador} ${this.derecha.temp}`;
        }
        return "";
    }

};