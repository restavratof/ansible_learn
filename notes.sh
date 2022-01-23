# -------------------------------------------------------------------------------------------
# --- COMMANDS
# -------------------------------------------------------------------------------------------
ansible-doc -l
ansible-doc MODULE_NAME

# Install python (will ask root ssh password)
ansible -u root -i inventory ansible3 --ask-pass -m raw -a 'apt install python3 -y'

# show file content 
ansible ansible3 -m command -a 'cat /tmp/README'


# -------------------------------------------------------------------------------------------
# --- PLAYBOOKS
# -------------------------------------------------------------------------------------------
# Playbook dry-run
ansible-playbook -C playbook.yml


# -------------------------------------------------------------------------------------------
# --- VARIABLES: Defining host variable through inventory
# -------------------------------------------------------------------------------------------
# assigning variable directly to a host
[servers]
ansible1.com web_package=httpd

# Assigning variables to host groups
[servers:vars]
web_package=httpd


# -------------------------------------------------------------------------------------------
# --- VARIABLES: Using Include Files
# -------------------------------------------------------------------------------------------
# Directories should be created in current project directory.

# For host specific variables use
~/myproject/host_vars/ansible1.com

# For host group specific variables
~/myproject/group_vars/webservers

# -------------------------------------------------------------------------------------------
# --- VARIABLES: Using Ansible Vault
# -------------------------------------------------------------------------------------------
ansible-vault create playbook.yml
# The command will prompt for a new vault password, and opens the file in vi for further editing.

# As alternative a vault password file may be used
ansible-vault create --vault-password-file=vault-pass playbook.yml

# To view a vault encrypted file
ansible-vault view playbook.yml

# To edit
ansible-vault edit playbook.yml

# To encrypt existing file
ansible-vault encrypt playbook.yml

# To decrypt
ansible-vault decrypt playbook.yml

# To change password on existing file
ansible-vault rekey playbook.yml

# To run a playbook that access Vault encrypted file, use:
# 1) --vault-id @prompt option to be prompted for  a password
ansible-playbook --ask-vault-pass vault/create-user.yml
# 2) Store password as a single line string in a password file, and access that using --vault-password=vault-file
ansible-playbook --vault-password=vault/vault-pass vault/create-user.yml
ansible-playbook --vault-password-file=vault/vault-pass vault/create-user.yml

# -------------------------------------------------------------------------------------------
# --- FACTS
# -------------------------------------------------------------------------------------------
# By default all playbooks perform Fact Gathering before running actual playbook.
# Fact gathering can be ran in an Ad Hoc command using the "setup" module.
# To show facts, use debug module to print the value of the ansible_facts variable.
ansible -m setup all
ansible -m setup -a 'filter=ansible_default_ipv4' all

# Ansible +2.4  - Facts were stored as individual variables (e.g. ansible_hostname, ansible_interfaces )
# Ansible 2.5+  - All facts are stored in one variable with the name "ansible_facts".
#                 And reference to specific facts happens in a different way (e.g. ansible_facts["hostname"] )

# The old approach is referred to as "injecting facts as variables",
# and this behaviour can be managed through:
# a) The "inject_facts_as_vars" parameter.
# b) Use "inject_facts_as_vars=true" in the [default] section of ansible.cfg to specifically enable the old way.

# Disabling Fact gathering may seriously speed up playbooks.
# Use "gather_facts: no" in the play header to disable
# INFO: even if fact gathering is disabled, it can be enabled again by running the setup module in a task.

# -------------------------------------------------------------------------------------------
# --- FACTS : Custom Facts
# -------------------------------------------------------------------------------------------
# a) Allow administrators to dynamically generate variables which are stored as facts.
# b) Custom facts are stored in an ini or json file in the /etc/ansible/facts.d/ directory on the managed host
#    The name of these files must in ".fact"
# c) Custom facts are stored in the ansible_facts.ansible_local variable.
# d) To display local facts use:
ansible hostname -m setup -a "filter=ansible_local"




















