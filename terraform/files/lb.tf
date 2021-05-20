resource "yandex_lb_target_group" "reddit_lb_group" {
  name = "reddit-target-group"

  dynamic "target" {
    for_each = yandex_compute_instance.app
    content {
      subnet_id = var.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }

  depends_on = [yandex_compute_instance.app]
}

resource "yandex_lb_network_load_balancer" "reddit_lb" {
  name = "reddit-lb"

  listener {
    name        = "my-listener"
    port        = 80
    target_port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_lb_target_group.reddit_lb_group.id}"

    healthcheck {
      name = "http"
      http_options {
        port = 9292
        path = "/"
      }
    }
  }

  depends_on = [yandex_lb_target_group.reddit_lb_group]
}