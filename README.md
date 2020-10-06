# ANSIBLE RESOURCES

This is a project to collect as many resources as I can

## Install Ansible

* [Conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Configure Vagrant

* [Vagrant](https://www.vagrantup.com)

## Inventory

Files to define servers where Ansible is going to work

* inventory-local - definition to work with the local machine
* inventory-vagrant - definition to work with vagrant machines

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

## Index

### 01 Gather facts

Example to show how we can get system information from a machine. It depence on inventory you choose

~~~
$ ansible-playbook -i inventory-local 01_gather_facts/example_1.yml
~~~

## References

* [Ansible](https://docs.ansible.com/ansible/latest/user_guide/index.html)
* [Ansible Galaxy](https://galaxy.ansible.com)
* [Vagrant](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)