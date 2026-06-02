export function greet(name = "world") {
  return `hello ${name}`;
}

if (import.meta.main) {
  console.log(greet());
}
