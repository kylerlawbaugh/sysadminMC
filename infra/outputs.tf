output "instance_id" {
    value = aws_instance.minecraft2.id
}

output "public_ip" {
    value = aws_instance.minecraft2.public_ip