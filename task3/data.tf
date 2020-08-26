data "external" "myip" {
  program = ["curl", "https://api.ipify.org?format=json"]
}
