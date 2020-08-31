export class Operacion{

    public valor : string;
    public izquierda : Operacion | null;
    public derecha : Operacion | null;
    public temp : number = 1;

    constructor(valor : string , izq : Operacion, der : Operacion ){
        this.valor = valor;
        this.izquierda = izq;
        this.derecha = der;
     }

    public traducir() : string{
        if(this.izquierda != null && this.derecha != null){
            let izq = this.izquierda?.traducir();
            //Pasar al sub arbol derecho la profundidad del sub arbol izquierdo
            this.derecha.temp = this.izquierda.temp;
            let der = this.derecha?.traducir();

            let operador = this.valor;
            this.valor = this.newTemp();
            return `${izq}\n${der}\n${this.valor} = ${this.izquierda.valor} ${operador} ${this.derecha.valor}`;
        }
        return "";
    }

    public newTemp():string{
        //Verificar si la profundidad actual heredo una profundidad mas baja que la de los hijos
        if(this.temp < this.izquierda?.temp! || this.temp < this.derecha?.temp!){
            if(this.izquierda?.temp! >= this.derecha?.temp!){
                this.temp = this.izquierda?.temp!;
            }else{
                this.temp = this.derecha?.temp!;
            }
        }
        let str_temp = `t${this.temp}`;
        this.temp++;
        return str_temp;
    }

};