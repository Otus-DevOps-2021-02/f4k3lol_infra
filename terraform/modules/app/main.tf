resource "yandex_compute_instance" "app" {
  name  = "reddit-app"
  labels = {
    tags = "reddit-app"
  }


  resources {
    cores         = 2
    memory        = 2
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = var.app_disk_image
    }
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
    #user-data = "#cloud-config\nusers:\n  - name: appuser\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n    ${file(var.public_key_path)}"
    user-data = file("${path.module}/cloud_config.yml")
  }

  provisioner "file" {
    source      = "../files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "file" {
    source      = "../files/deploy.sh"
    destination = "/tmp/deploy.sh"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "appuser"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }


  provisioner "remote-exec" {
    inline = [
      #"ip a",
      "sleep 20s",
      "sudo rm /var/lib/dpkg/lock-frontend",
      "sudo rm /var/lib/dpkg/lock",
      "chmod 777 /tmp/deploy.sh",
      "sudo /tmp/deploy.sh",
      # "sudo mkdir /home/appuser/.ssh",
      # "sudo cp /home/ubuntu/.ssh/authorized_keys /home/appuser/.ssh/",
      # "sudo chmod 600 /home/appuser/.ssh/authorized_keys",
      # "sudo chown appuser /home/appuser/.ssh/authorized_keys",
    ]
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
  #depends_on = 

}

