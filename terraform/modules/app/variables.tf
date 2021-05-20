variable public_key_path {
  # Описание переменной
  description = "Path to public key file"
}
variable private_key_path {
  # Описание переменной
  description = "Path to private key file"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default = "fd8ubsc6n2j5mv7pcqu2"
}
variable subnet_id {
  description = "Subnet id"
}