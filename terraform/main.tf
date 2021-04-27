provider "yandex" {
  service_account_key_file = var.service_account_key_file
  #token = "AQAAAAAjXwyxAATuwcHKwMbyNEbrhxjJOqnK-_w"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_compute_instance" "app" {
  count = var.instance_count
  name  = join("", ["reddit-app", count.index + 1]) 

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = var.image_id
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "file" {
    source      = "files/deploy.sh"
    destination = "/tmp/deploy.sh"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }


  provisioner "remote-exec" {
    inline = [
      #"ip a",
      "sleep 30s",
      "sudo rm /var/lib/dpkg/lock-frontend",
      "sudo rm /var/lib/dpkg/lock",
      "chmod 777 /tmp/deploy.sh",
      "sudo /tmp/deploy.sh",
    ]
  }
}

