# Setting Up Ansible User on WireGuard Server
Once the instance is provisioned, you need to create an `ansible` user for managing the server via Ansible. Follow these steps to set up the user:

```bash
passwd root
adduser ansible
```

Then allow the ansible user to become root without a password prompt:

```bash
sudo visudo
```

Add the following line to the sudoers file:

```plaintext
ansible ALL=(ALL) NOPASSWD: ALL
```

Allow SSH Access:

```bash
su ansible
mkdir .ssh
sudo cp /root/.ssh/authorized_keys /home/ansible/.ssh/authorized_keys
sudo chown -R ansible:ansible /home/ansible/.ssh
```
