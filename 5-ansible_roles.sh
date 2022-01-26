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
