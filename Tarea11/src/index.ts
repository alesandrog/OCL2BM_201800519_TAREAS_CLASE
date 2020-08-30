
/* Metodo #1 : Concatenacion de valores sintetizados  */
console.log("-----------------------Metodo #1 ----------------------------");

let entrada = "(a+b+c*d+e*f+g)*t*y*u/e-o";
//let entrada = "a+b+c";
const parser = require('./Metodo1(sintetizar c3d)/Grammar');


let analizar = () => { console.log(parser.parse(entrada)) };
analizar();



/* Metodo #2 : Recorrido del AST  */

console.log("-----------------------Metodo #2 ----------------------------");


const parser2 = require('./Metodo2(ast)/Grammar');
import { Operacion } from "./Metodo2(ast)/Operacion";


let analizar2 = () => { 
    let ast : Operacion = parser2.parse(entrada);
    console.log(ast.traducir());
};
analizar2();
