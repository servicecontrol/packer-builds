terraform {
  required_providers {
    upcloud = {
      source = "registry.upcloud.com/upcloud/upcloud"
    }
  }
  required_version = ">= 0.13"
}
provider "upcloud" {
  # You need to set UpCloud credentials in shell environment variable
  # using .bashrc, .zshrc or similar
  # export UPCLOUD_USERNAME="Username for Upcloud API user"
  # export UPCLOUD_PASSWORD="Password for Upcloud API user"
}

resource "upcloud_server" "test" {
  zone     = "de-fra1"
  hostname = "test2"
  metadata = true

  cpu = "1"
  mem = "1024"

  network_interface {
    type = "public"
  }

  network_interface {
    type = "utility"
  }

  storage_devices {
    # You can use both storage template names and UUIDs
    size    = 20
    action  = "clone"
    tier    = "maxiops"
    storage = "015b39c2-0fc6-4956-9c2e-d61de359151d"
  }
 
  user_data = <<-EOT
#cloud-config
write_files:
- encoding: b64
  content: CiMgVGhpcyBmaWxlIGNvbnRyb2xzIHRoZSBzdGF0ZSBvZiBTRUxpbnV4...
  owner: root:root
  path: /root/asd
  permissions: '0644'
EOT
}

output "Public_ip" {
  value = upcloud_server.test.network_interface[0].ip_address
}
