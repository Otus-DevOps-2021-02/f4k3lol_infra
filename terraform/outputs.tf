# output "external_ip_address_app" {
#   value = yandex_compute_instance.app[*].network_interface.0.nat_ip_address
# }

output "external_ip_address_app" {
  value = yandex_compute_instance.app.network_interface.0.nat_ip_address
}

output "external_ip_address_db" {
  value = yandex_compute_instance.db.network_interface.0.nat_ip_address
}
# output "lb_ip_address" {
#   #не знаю как правильно написать
#   value = tolist(tolist(yandex_lb_network_load_balancer.reddit_lb.listener)[0].external_address_spec)[0].address
# }