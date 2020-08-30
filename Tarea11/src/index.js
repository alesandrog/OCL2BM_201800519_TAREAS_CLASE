
/* Metodo #1 : Concatenacion de valores sintetizados  */

let entrada = "(a+b+c*d+e*f+g)*t*y*u/e-o";
const parser = require('./Metodo1(sintetizar c3d)/Grammar');


let analizar = () => { console.log(parser.parse(entrada)) };
analizar();

/* Metodo #2 : Recorrido del AST  */

