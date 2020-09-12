let entrada = "(a+b+c*d+e*f+g)*t*y*u/e-o";

const parser2 = require('./Grammar/Grammar');

let analizar = () => { 
    let ast   = parser2.parse(entrada);
    console.log(ast.traducir());
};
analizar();