# Add GCP service account access via gcloud
gcloud auth activate-service-account SA_ACCOUNT_NAME --key-file=SA_KEYFILE_PATH --project=GCP_PROJECT_ID
# Verify
gcloud auth list

gcloud config set compute/zone us-central1-a


# -------------------------------------------------------------------------------------------
# --- SSH to VMs
# -------------------------------------------------------------------------------------------
# --- 1 : generate keys
ssh-keygen -t rsa -f ~/.ssh/ansible -C ansible -b 2048

# --- 2 : Create key file
filename: gcp_ssh_key
<username>:<ssh pub key content>


# --- 3 : add pub key to remote VMs
gcp_ssh_key  (local file name)
# File content format:  [ansible]:[content of .ssh/ansible.pub]
    gcloud compute instances add-metadata VM_NAME --metadata-from-file ssh-keys=gcp_ssh_key

# --- 4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       : connect VM's
ssh ansible@VM_NAME
