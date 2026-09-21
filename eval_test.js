globalThis.eval("function getDescramblingKey() { return 42; }");
let r = globalThis.eval("getDescramblingKey();");
console.log(r);
