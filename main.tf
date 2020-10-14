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
    storage = "0119bcbd-a7e1-4078-9351-15f72253f633"
  }
 
  user_data = <<-EOT
#cloud-config
users:
 - name: mkaesz
   ssh_authorized_keys:
     - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1pY0voKcNrZrsVbVe0VLDxTDRxfbbjAE3Cv5bIWEcYJwbAYUl0TZ0JkFAoYGCKG9Ml0Ddq+pyrPKlEBWnyblPmiKOwHnwPsjPtjGUuFGNlOcpfgOf5nDEo/OdOIlHrPJYRbTVAmXBSS99MjmJQJdGMwOsIiASU+1wJZtmya7yT9/y3GepoesiCzFwibpzsISa2Jucik6awNcIfrTkMwp3DPunbAESpJf9sGRRlF2LQffEKn1FKL8ECZEjXt8+u600ze5+wKq2ciWcMkZql6yiC38t+pU/+9zM1UYVLRX1s8BweH3AId7Gfa2bMuaaYCmd2xaz8K2YQ5AVE5Mle6l7gpxcGQl8ZXiwrqjlt7SeK0dBpb150K40S+wgzG3CxQ84Ai0sfSdO9dlrbDOJ2efWbhbEWllkOpdlO9lKg4YSBxDkETnTpheUlwxPb5cINkr8dsUhI3o3sJcwOCFqTKnQY/6jkR/urjQEc1xw1c6VGPENo7RZzp0xRG3O7u6BNMc=
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
