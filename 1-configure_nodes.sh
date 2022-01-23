# -------------------------------------------------------------------------------------------
# --- CONTROL NODE
# -------------------------------------------------------------------------------------------
# install ansible
pip3 install ansible --user
# or
apt install ansible

# -------------------------------------------------------------------------------------------
# --- MANAGED NODES
# -------------------------------------------------------------------------------------------
# 1: Install python
sudo apt install python3
sudo apt install python3-pip3
# 2: Make 'python' point to our python
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
update-alternatives --list python
