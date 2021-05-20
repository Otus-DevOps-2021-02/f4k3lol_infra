resource "yandex_compute_instance" "db" {
  
  name = "reddit-db"
  labels = {
    tags = "reddit-db"
  }


  resources {
    cores         = 2
    memory        = 2
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = var.db_disk_image
    }
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }


  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
  #depends_on = [vpc.yandex_vpc_subnet.app-subnet]

}
