variable cloud_id {
  description = "Cloud id"
}
variable folder_id {
  description = "Folder id"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable public_key_path {
  # Описание переменной
  description = "Path to public key file"
}
variable private_key_path {
  description = "Path to private key file"
}
variable image_id {
  description = "Image id"
}
variable subnet_id {
  description = "Subnet id"
}
variable service_account_key_file {
  description = "Service account key file"
}
variable instance_count {
  description = "Number of instances"
  default     = 1
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default = "fd8ubsc6n2j5mv7pcqu2"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default = "fd8remj654etgdf8s6ir"
}