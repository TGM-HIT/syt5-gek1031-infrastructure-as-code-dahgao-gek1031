
resource "hcloud_server" "webservers" {
  count       = 2
  name        = "webserver-${count.index + 1}"
  image       = "ubuntu-22.04" # Adjust if needed
  server_type = "cax11"
  location    = "nbg1"
  ssh_keys    = ["texotek@macfedora"]
  connection {
    type        = "ssh"
    user        = "root"  # Default for Hetzner Cloud images
    private_key = file("~/.ssh/id_rsa")
    host        = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y && sudo apt upgrade -y",
      "sudo apt install -y nginx",
      "sudo systemctl enable --now nginx",
      "echo '<h1>Hello from webserver-${count.index + 1}!</h1>' | sudo tee /var/www/html/index.html"
    ]
  }
}

resource "hcloud_load_balancer" "lb" {
  name     = "web-lb"
  load_balancer_type = "lb11"
  location = "nbg1"
}

resource "hcloud_load_balancer_target" "web_targets" {
  count             = 2
  load_balancer_id  = hcloud_load_balancer.lb.id
  type              = "server"
  server_id         = hcloud_server.webservers[count.index].id
}

resource "hcloud_load_balancer_service" "http" {
  load_balancer_id = hcloud_load_balancer.lb.id
  protocol         = "http"
  listen_port      = 80
  destination_port = 80
}
