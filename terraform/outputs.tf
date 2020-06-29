#output "external_ip_address_app" {
#  value = yandex_compute_instance.app[count.index].network_interface.0.nat_ip_address
#}

output "external_ip_address_app" {
  value = yandex_compute_instance.app[*].network_interface.0.nat_ip_address
}

output "external_ip_address_app-lb" {
  value = [for ip in yandex_lb_network_load_balancer.app-lb.listener : ip.external_address_spec.0.address].0
}
