output "mediawiki-ssh-key-name" {
    description                 = "Name of the key pair"
    value                       = aws_key_pair.mediawiki_ssh_key.id
}

output "mediawiki-ssh-key-id" {
    description                 = "ID of the key pair"
    value                       = aws_key_pair.mediawiki_ssh_key.key_pair_id
}

