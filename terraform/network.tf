resource "sakuracloud_internet" "main" {
  name = "main"

  lifecycle {
    prevent_destroy = true
  }
}
