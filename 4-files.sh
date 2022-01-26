# -------------------------------------------------------------------------------------------
# --- Files: Modules
# -------------------------------------------------------------------------------------------
# Managing files modules:
#   - "lineinfile"  - ensures that a line is in a file, useful for changing a single line in a file.
#   - "blockinfile" - manipulate multi-line blocks of text in files.
#   - "copy"        - copies a file from a local or remote machine to a location on a managed host.
#   - "fetch"       - used to fetch a file from a remote machine and store it on the management node.
#   - "file"        - sets attributes to files, and can also create and remove files, symbolic links and more.

# -------------------------------------------------------------------------------------------
# --- Files: SELinux Context
# -------------------------------------------------------------------------------------------
# 1) "file" - sets attributes to files, includes SELInux context, and can also create and removes files,
#     symbolic links and more.
# 2) "sefcontext" - manages SELinux file context in the SELinux Policy (but not on files)
# 3) Notice that "file" sets SELinux context directly on the file (like the "chcon" command), and not in the policy.


# -------------------------------------------------------------------------------------------
# --- Files: Jinja2 Templates
# -------------------------------------------------------------------------------------------
# a) "lineinfile" and "blockinfile" can be used to apply modifications to files
# b) For more advanced modifications, use "Jinja2 Templates"
# c) While using templates, the target files are automatically customized using variables and facts.
# d) In Jinja2 Template, you will find multiple elements:
#    - data
#    - variables
#    - expression
#    - control structures

# e) The  variables in the template are replaced with their values
#    when the Jinja2 Template is rendered to the target file on the managed host.
# f) If using variables, they can be specified using "vars" section of the playbook.
# g) Alternatively, Ansible facts can be used as variables.

# h) To prevent administrators from overwriting files that are managed by Ansible, set the "ansible_managed" string:
#    1) First, in ansible.cfg set "ansible_managed - Ansible managed"
#    2) On top of the Jinja2 template, set the {{ ansible_managed }} variable.

# -------------------------------------------------------------------------------------------
# --- Files: Jinja2 Templates Control Structues
# -------------------------------------------------------------------------------------------
# for, if




