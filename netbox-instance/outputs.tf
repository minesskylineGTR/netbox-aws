output "cloudfront-dns" { value = "${aws_cloudfront_distribution.netbox-instance.domain_name}" }
output "server-ip" { value = "${aws_instance.netbox-instance.public_ip}" }
output "nginx-site-config" {
  value = data.template_file.nginx-site-config.rendered
}