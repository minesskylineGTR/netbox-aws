  
output "cloudfront-dns" {
  value = module.netbox-instance.cloudfront-dns
}

output "server-ip" {
  value = module.netbox-instance.server-ip
}
#
#output "debug" { 
#  value = module.netbox-instance.nginx-site-config
#}