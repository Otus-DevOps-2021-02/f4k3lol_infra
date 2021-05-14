variable public_key_path {
  # Описание переменной
  description = "Path to public key file"
}
variable private_key_path {
  # Описание переменной
  description = "Path to private key file"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default = "fd8remj654etgdf8s6ir"
}
variable subnet_id {
  description = "Subnet id"
}