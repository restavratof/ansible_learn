# https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html
# -------------------------------------------------------------------------------------------
# --- Ansible Roles: Directory Layout Best Practices
# -------------------------------------------------------------------------------------------
~/myproj/ansible.cfg
      ../inventory-dev
      ../inventory-prod
      ../site.yml
      ../lamp.yml
      ../file.yml
      ../group-vars/lamp
      ../group-vars/file
      ../host-vars/

# Roles should eb created under
~/.ansible/roles/nginx
              ../samba
              ../nfs
              ../httpd

# a) When working with Ansible, it;s recommended to use project directories soo that contents can be organized
#    in a consistent way.
# b) Each project directory may have its own ansible.cfg, inventory as well as playbooks
# c) If the directory grows bigger, variable files and other include files may be used.
# d) And finally, roles can be used to standardize and easily re-use specific parts of Ansible.
# e) For now, consider a "role" a complete project dedicated to a specific task
#    that is going to be included in the main playbook.

# ---- SOME HIGHLIGHTS:
# - On top in the directory, use site.yml as the master playbook
# - From site.yml call specific playbooks for specific types of host
# - Consider using different inventory files to differentiate between production and staging phases.
# - Use groups_vars/ and host_vars/ to set host related variables
# - Use roles to standardize common tasks

# -------------------------------------------------------------------------------------------
# --- Ansible Roles: Understanding Roles
# -------------------------------------------------------------------------------------------
# 1) Ansible Playbooks can be very similar: code used in one playbook can be useful in other playbook also
# 2) To make it easy to re-use code, roles can be used. A role is a collection of tasks, variables, files, templates
#    and other resources in a fixed directory structure that, as such, can easily be included from a playbook.
# 3) Roles should be written in a generic way, such that play specifics can be defined as variables in the play, and
#    overwrite the default variables that should be set in the role.
# 4) Using roles makes working with large projects more manageable.

# -------------------------------------------------------------------------------------------
# --- Ansible Roles: Default Structure
# -------------------------------------------------------------------------------------------
#└── myrole
#    ├── defaults
#    │         └── main.yml
#    ├── handlers
#    │         └── main.yml
#    ├── meta
#    │         └── main.yml
#    ├── README.md
#    ├── tasks
#    │         └── main.yml
#    ├── tests
#    │         ├── inventory.yml
#    │         └── test.yml
#    └── vars
#        └── main.yml

# a) "defaults" contan default values of role variables. If variables are set at the play level as well,
#    these default values are overwritten.
# b) "files" may contain static files that are needed from the role tasks
# c) "handlers" has a inventory.yml that defined handlers used in the role
# d) "meta" has a inventory.yml that may be used to include role metadata, such as information about author, license,
#    dependencies and more
# e) "tasks" contains a inventory.yml that defines the role task definition
# f) "templates" is used to store Jinja2 templates
# g) "tests" may contain an optional inventory file, as well as a test.yml playbook that can be used to test the role.
# h) "vars" may contain a inventory.yml with standard variables for the role (which are not meant to be overwritten
#    by playbook variables)

# -------------------------------------------------------------------------------------------
# --- Ansible Roles: Understanding Role Variables
# -------------------------------------------------------------------------------------------
# a) Variables can be defined at different levels in a role
# b) "vars/main.yml" has the role default variables, which are used in default role functionaning.
#    They are not intended to be overwritten.
# c) "defaults/main.yml" can contain default variables. These have a low precedence, and can be overwritten
#    by variables with the same name that are set in the playbook and which have higher precedence.
# d) Playbook vaiables will always overwrite the variables as set in the role. Site-specific variables such as
#    secrets and vault encrypted data should always be managed from the playbook,
#    as role variables are intended to be generic.
# e) Role variables are defined in the playbook when calling the role and they have highest precedence
#    and overwrite playbook variables as well as inventory variables.


# -------------------------------------------------------------------------------------------
# --- Ansible Roles: Understanding Role Location
# -------------------------------------------------------------------------------------------
# Roles can be obtained in many ways:
#   - You can write your own roles
#   - For Red Hat Enterprise Linux, the rhel-system-roles package is available
#   - The community provides roles through the Ansible Galaxy wesite

# Roles can be stored at a default location, and from there can easily be used from playbooks:
#   - "./roles" has highest precedence
#   - "~/.ansible/roles" is checked after that
#   - "/etc/ansible/roles" is checked next
#   - "/usr/share/ansible/roles" is checked last

# -------------------------------------------------------------------------------------------
# --- Ansible Roles: Using Roles in a Playbook
# -------------------------------------------------------------------------------------------
# 1) Roles are referred to from playbooks:
#    a) When roles are used, they will run before any task that is defined in the playbook
---
- name: role demo
  hosts: all
  roles:
    - role1
    - role2
#    b) When calling a role, role variables can be defined
---
- name: role variable demo
  hosts: all
  roles:
    - role: role1
    - role: role2
      var1: cow
      var2: goat

# -------------------------------------------------------------------------------------------
# --- Ansible Roles: Using Ansible Galaxy
# -------------------------------------------------------------------------------------------
# a) Administrators can define their own roles, or standard roles can be used from Ansible Galaxy
# b) Ansible Galaxy is a public website where community provided roles are offered
# c) Before writing your own role, check Galaxy, you may get the roles from there
# d) As easy-to-use search interface is available at galaxy.ansible.com
# e) Role installation from galaxy:
ansible-galaxy install geerlingguy.nginx



# a) ansible-galaxy-search will search for roles
#     - If an argument is rpovided, "ansible-galaxy" will search for this argument in the role description
#     - Use options "--author", "--platforms" and "--galaxy-tags" to narrow down the search results
#     - e.g. "ansible-galaxy search 'install mariadb' --platforms el"
#             will search for mariadb that will run on enterprise linux.
#
# b) "ansible-galaxy info" provides information about roles
#     - e.g. "ansible-galaxy info f500.mariadb55"
#
# c) "ansible-galaxy install" downloads a role and installs it in ~/.ansible/roles
#    After download, these roles can be used in playbooks, like any other role.
#
# d) "ansible-galaxy list" shows installed roles
# e) "ansible-galaxy remove" can be used to clean up and remove roles
# f) "ansible-galaxy init" creates a directory structure that can be used to start developing your own role.
#     - It interacts with the Ansible Galaxy website API
#     - Use "--offline" to work offline
#     - Specify username and role name as arguments
#     - e.g. ansible-galaxy init --offline user.myrole

# -------------------------------------------------------------------------------------------
# --- Ansible Roles: Using a Requirements File
# -------------------------------------------------------------------------------------------
# a) "ansible-galaxy" can be used to install a list of roles based on definitions in a requirements file.
# b) A requirements file is a yml file that defines a list of required roles that are specified using the "src" keyword.
# c) The "src" keyword can contain the name of a role from Ansible Galaxy, or an URL to a custom location pointing to
#    your own roles.
# d) Create roles/requirements.txt in the projects directory to use it
# e) Always specify the optional "version" attribute, to avoid getting surprises when a newer version of a role
#    has become available.
- src: file:///opt/local/roles/myrole.tar
  name: myrole
  version: 1.0

# -------------------------------------------------------------------------------------------
# --- Ansible Roles: Creating Custom Roles
# -------------------------------------------------------------------------------------------
# a) To create your own roles, use "ansible-galaxy init myrole" to create role directory structure
# b) Mind the location of the directory structure, you can put it in the local project directory,
#    or in a directory that is accessible for all projects
# c) Populate the required role files as discussed before.

# -------------------------------------------------------------------------------------------
# --- Ansible Roles: BEST PRACTICES
# -------------------------------------------------------------------------------------------
# 1) Each role should have its own version control repository
# 2) Dont't  put sensitive information in the role, but in the local playbooks or Ansible Vault instead.
# 3) Use "ansible-galaxy init" to create the role structure
# 4) Don't forget to edit the README.md and the meta/main.yml to contain documentation about your role.
# 5) Roles should be dedicated to one/task function.
# 6) Have a look at existing (Galaxy) roles before starting to write your own.

# -------------------------------------------------------------------------------------------
# --- Ansible Roles: Defining Role Dependencies
# -------------------------------------------------------------------------------------------
# a) The "meta/main.yml" can be used to define role dependencies
# b) Dependencies listed here will be installed automatically when this role is used.

# -------------------------------------------------------------------------------------------
# --- Ansible Roles: Using Conditional Roles
# -------------------------------------------------------------------------------------------
# a) Conditional roles call a role dynamically, using "include_role" module
#    - This makes it so conditional roles are treated more as tasks
# b) Conditional Roles can be combined with conditional statements
#    - This makes it so a role will only run if the conditional statement is true
#    - Use "include_role" in a task statement to do so
---
- hosts: ansible1
  tasks:
  - include_role:
      name: lamp
    when: "ansible_facts['os_family'] == 'RedHat'"








