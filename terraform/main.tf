provider "yandex" {
  service_account_key_file = var.service_account_key_file
  #token = "AQAAAAAjXwyxAATuwcHKwMbyNEbrhxjJOqnK-_w"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}
