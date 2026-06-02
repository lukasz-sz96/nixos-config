fn greet(name: &str) -> String {
    format!("hello {name}")
}

fn main() {
    println!("{}", greet("world"));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn greet_returns_greeting() {
        assert_eq!(greet("dev"), "hello dev");
    }
}
