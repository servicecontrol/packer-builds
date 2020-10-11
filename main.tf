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
  hostname = "test"

  cpu = "2"
  mem = "1024"

  network_interface {
    type = "public"
  }

  network_interface {
    type = "utility"
  }

  storage_devices {
    # You can use both storage template names and UUIDs
    size    = 50
    action  = "clone"
    tier    = "maxiops"
    storage = "01d12ae3-9d86-432f-b3a8-6c2e8ae12bc1"
  }
}

output "Public_ip" {
  value = upcloud_server.test.network_interface[0].ip_address
}
