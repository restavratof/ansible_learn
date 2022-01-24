# -------------------------------------------------------------------------------------------
# --- Task Control: Loops and items
# -------------------------------------------------------------------------------------------
# 1) The "loop" keyword allows you to iterate through a simple list of items
# 2) Before Ansible 2.5, the "items" keyword was used instead. (
- name: start some services
  service:
    name: "{{ item }}"
    state: started
  loop:
    - vsftpd
    - httpd

# -----------------------------------------------------------------------------
# 3) The list that loop is using can be defined by a variable:
vars:
  my_services:
    - httpd
    - vsftpd
- name: start some services
  service:
    name: "{{ item }}"
    state: started
  loop: "{{ my_services }}"

# -----------------------------------------------------------------------------
# 4) Each item in a loop can be a hash/dictionary with multiple keys in each hash/dictionary:
- name: create users using a loop
  hosts: all
  tasks:
  - name: create users
    user:
      name: "{{ item.name }}"
      state: present
      groups: "{{ item.groups }}"
  loop:
    - name: anna
      groups: wheel
    - name: linda
      groups: users

# -----------------------------------------------------------------------------
# 5) In previous versions of Ansible, the "with_*" keyword was used for the same purpose.
#    This syntax will probably be deprecated in future versions of Ansible.
#       - "with_items" : equivalent to the "loop" keyword
#       - "with_file" : contains a file, which content is used to loop through
#       - "with_sequence" : generates a list of values based on a numeric sequence

# -----------------------------------------------------------------------------
# 6) A "register" is used to store the output of a command and address it as a variable.
#    The result of the command can be used next in a conditional or in a loop.


# -------------------------------------------------------------------------------------------
# --- Task Control: Conditions
# -------------------------------------------------------------------------------------------
# 1) "when" statements are used to run a task conditionally
# 2) Playbook variables, registered variables and facts can be used in conditions and make
#    sure that tasks only run if specific conditions are true.
#    e.g. check if has run successfully, a certain amount of memory is available, file exists, etc.
ansible_machine == "x86_64"
ansible_distribution_major_version == "8"
ansible_memfree_mb == 1024
ansible_memfree_mb < 256
ansible_memfree_mb > 256
ansible_memfree_mb <= 256
ansible_memfree_mb != 512
my_variable is defined
my_variable is not defined
my_variable

# -------------------------------------------------------------------------------------------
# --- Task Control: Handlers
# -------------------------------------------------------------------------------------------
# a) Handlers allow you to configure playbook in a way that one task will only run if
#    another task has been running successfully.
# b) To run the handler , a "notify" statement is used from the main task to trigger the handler.
# c) Handlers typically are used to restart services or reboot host.
# d) Handlers are executed after running all tasks in a play
# e) Handlers will only run if a task has "changed" something,
#    so if an "ok" result is reported, the handler will not run.
# f) If one of the tasks fail -> handler will not run
#    But this may be overwritten using "force_handlers: True"
# g) One task may trigger more than one handler.


# -------------------------------------------------------------------------------------------
# --- Task Control: Blocks
# -------------------------------------------------------------------------------------------
# a) A block - is a logical group of tasks.
# b) Can be used to control tasks execution
# c) One block can be enabled using a single when for instance.
# d) Blocks can be used in error condition handling
#   - Use "block" to define main task to run
#   - Use "rescue" to define tasks that run if tasks defined in "block" fail.
#   - Use "always" to define tasks that will run, regardless the success or failure of the "block" and "rescue" tasks.


# -------------------------------------------------------------------------------------------
# --- Task Control: Failure Handling
# -------------------------------------------------------------------------------------------
# a) Ansible looks at the exit status of task to determine whether it has failed.
# b) When any task fais, Ansible aborts the rest of the play on that host and continues with the next host.
# c) Different solutions can be used to change that behavior:
#    - Use "ignore_errors" in a task to ignore failures
#    - Use "force_handlers" to force a handler that has been triggered to run, even if another task fails.

# d) As Ansible only look at the exit status of a failed task, it may think a task was successful
#    whether it is not the case
# e) To be more specific, use "failed_when" to specify what to look for in command output to recognize a failure.


# -------------------------------------------------------------------------------------------
# --- Task Control: Handling Changed Status
# -------------------------------------------------------------------------------------------
# Managing Changed Status may be important, as handlers trigger on the changed status
# a) The result of a command can be registered
#    And the registered variable can be scanned for specific text to determine that a change has occurred.
# b) This allows Ansible to report a changed status, where it normally would not,
#    thus allowing handlers to be triggered.








