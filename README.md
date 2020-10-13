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
* RAM: 2Gb
* cores: 2

#### several_servers

__server1__
* box: devian/buster64
* ip: 10.0.0.101
* hostname: server1
* RAM: 1Gb
* cores: 1

__server2__
* box: devian/buster64
* ip: 10.0.0.102
* hostname: server2
* RAM: 1Gb
* cores: 1

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
* inventory-vagrant-severalservers - definition to work with multiple vagrant virtual machines

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

### Loop of a collection of tasks

~~~
- name: Install Jupyterhub
  include_role:
    name: jupyterhub
  loop: '{{ jupyters }}'
  loop_control:
    loop_var: jupyter
~~~

### Use of tags

~~~
$ ansible-playbook -i xxx myplaybook.yml --tags tag1, tag2
~~~

### Skip tags

~~~
$ ansible-playbook -i xxx myplaybook.yml --skip-tags tag1, tag2
~~~

### always and never tag

~~~
$ ansible-playbook -i xxx myplaybook.yml --skip-tags always
$ ansible-playbook -i xxx myplaybook.yml --tags never
~~~

[More information](https://docs.ansible.com/ansible/latest/user_guide/playbooks_tags.html#special-tags-always-and-never)

### extra-vars

[Defining variables at runtime](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#defining-variables-at-runtime)

~~~
$ ansible-playbook -i xxx myplaybook.yml --extra-vars '{"version": "1.2.3"}'
~~~

## Examples Index

### 01 Gather facts

Example to show how we can get system information from a machine. It depends on inventory you choose

~~~
$ ansible-playbook -i inventory-local 01_gather_facts/example_1.yml
$ ansible-playbook -i inventory-vagrant-oneserver 01_gather_facts/example_1.yml
$ ansible-playbook -i inventory-local 01_gather_facts/example_2.yml
$ ansible-playbook -i inventory-vagrant-oneserver 01_gather_facts/example_2.yml
~~~

### 02 Galaxy

Example of how to use third party roles from Ansible Galaxy. In this example, we use a role to install docker and docker-compose in a machine.

For futher information about the role you can go to the following urls:
* [Pip](https://galaxy.ansible.com/geerlingguy/pip)
* [Docker](https://galaxy.ansible.com/geerlingguy/docker)

~~~
$ ansible-playbook -i inventory-vagrant-oneserver 02_galaxy/install_docker.yml
~~~

### 03 Easy tasks

#### Clone

An easy way to clone or update a repo using Git. In this example we are using vars from file and inside playbook

~~~
$ ansible-playbook -i inventory-vagrant-oneserver 03_easy_tasks/clone.yml
~~~

### 04 Real world

A real use for Ansible. Install Jupyterhub in a machine

~~~
$ ansible-playbook -i inventory-xxx 04_real_world/install_several_jupyterhub.yml
~~~

### 05 AWS

An example of how you can use Ansible to connect with AWS EC2 instances.

First of all, you need to have configured and environment with AWS CLI
~~~
$ conda create --name ansible python=3 
$ conda activate ansible 
$ pip install boto 
$ pip install awscli
~~~

And then, you could run playbooks
~~~
$ ansible-playbook -i inventory-aws check_status.yml
$ ansible-playbook -i inventory-aws start_ec2.yml
$ ansible-playbook -i inventory-aws stop_ec2.yml
~~~

## References

* [Ansible](https://docs.ansible.com/ansible/latest/user_guide/index.html)
* [Ansible Galaxy](https://galaxy.ansible.com)
* [Vagrant](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)