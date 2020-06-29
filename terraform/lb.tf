resource "yandex_lb_target_group" "reddit-target-group" {
  name = "reddit-target-group"
  region_id = var.region_id

  dynamic "target" {
    for_each = [for vm in yandex_compute_instance.app : {
      subnet_id = var.subnet_id
      address = vm.network_interface.0.ip_address
    }]

    content {
      subnet_id = target.value.subnet_id
      address = target.value.address
    }

    #  target {
    #    subnet_id = var.subnet_id
    #    address   = yandex_compute_instance.app[0].network_interface.0.ip_address
    #  }
  }
}

resource "yandex_lb_network_load_balancer" "app-lb" {
  name = "reddit-load-balancer"

  listener {
    name        = "listener"
    port        = 80
    target_port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.reddit-target-group.id

    healthcheck {
      name = "http"
      http_options {
        port = 9292
        path = "/"
      }
    }
  }
}
