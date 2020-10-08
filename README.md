# ANSIBLE RESOURCES

This is a project to collect as many resources as I can

## Install Ansible

* [Conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Vagrant

* [Vagrant](https://www.vagrantup.com)

### Work with Vagrant

#### First start

0. How to know SSH configuration

~~~
$ vagrant ssh-config
~~~

1. Start vagrant

~~~
$ cd vagrant/one_server
$ vagrant up
$ ssh vagrant
~~~

2. SSH to Virtual Machine

* `$ vagrant ssh`
* `$ ssh -p 2222 vagrant@127.0.0.1` (user: vagrant | password: vagrant)
* `$ ssh vagrant@10.0.0.10` (user: vagrant | password: vagrant)
* `$ ssh -p 2222 -i .vagrant/machines/default/virtualbox/private_key vagrant@127.0.0.1` (where Vagrantfile is located)
* `$ ssh -i .vagrant/machines/default/virtualbox/private_key vagrant@10.0.0.10` (user: vagrant | password: vagrant)

3. Stop Virtual Machine

~~~
$ vagrant halt
~~~

4. Destroy Virtual Machine

~~~
$ vagrant destroy
~~~

### Virtual Machines

#### one_server

* box: debian/buster64
* ip: 10.0.0.10
* hostname: oneserver

### SSH

#### Configure SSH keys for remote access

1. In machine where ansible runs `$ ssh-keygen` and follow the steps
    * This command generates two files: public key and private key
2. Copy the public key into remote machine `$ ssh-copy-id -i $HOME/.ssh/mykey.pub <user>@<ip>`
    * You can check the copy in **$HOME/.ssh/authorized_keys**
3. Change private key permirmissionsin the local machine `$ chmod 400 $HOME/.ssh/mykey`
4. Test connection `$ ssh -i mykey <user>@<ip>`

## Inventories

Files to define servers where Ansible is going to work

* inventory-local - definition to work with the local machine
* inventory-vagrant-oneserver - definition to work with vagrant machines

## Test Ansible

~~~
$ ansible all -a "whoami"
$ ansible all -i inventory-local -a "whoami"
~~~

## How to run examples

All the examples can be executed using the following command:

~~~
$ ansible-playbook -i <inventory> example
~~~

## Tips

### Use ansible asking for sudo password

**--ask-sudo-pass**

~~~
$ ansible-playbook -i <inventory> example --ask-sudo-pass
~~~

## Index

### 01 Gather facts

Example to show how we can get system information from a machine. It depends on inventory you choose

~~~
$ ansible-playbook -i inventory-local 01_gather_facts/example_1.yml
$ ansible-playbook -i inventory-vagrant-oneserver 01_gather_facts/example_1.yml
$ ansible-playbook -i inventory-local 01_gather_facts/example_2.yml
$ ansible-playbook -i inventory-vagrant-oneserver 01_gather_facts/example_2.yml
~~~

## References

* [Ansible](https://docs.ansible.com/ansible/latest/user_guide/index.html)
* [Ansible Galaxy](https://galaxy.ansible.com)
* [Vagrant](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)