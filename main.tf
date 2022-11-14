resource "local_file" "foo" {
    content  = "foo!"
    filename = "${path.module}/foo.bar"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  ifconfig_co_json = jsondecode(data.http.my_public_ip.response_body)
}

output "my_ip_addr" {
  value = local.ifconfig_co_json.ip
}
