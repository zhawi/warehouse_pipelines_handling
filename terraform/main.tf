provider "local" {
  # No configuration is necessary for the local provider
}

resource "local_file" "hello_world" {
  content  = "Hello, World!"
  filename = "${path.module}/hello_world.txt"
}