export function greet(name = "world") {
  return `hello ${name}`;
}

if (import.meta.url === `file://${process.argv[1]}`) {
  console.log(greet());
}
