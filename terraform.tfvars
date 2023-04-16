#===============================================================================
# VMware vSphere configuration
#===============================================================================

# vCenter IP or FQDN #
vsphere_vcenter = "vcenter.tejaratshayan.com"

# vSphere username used to deploy the infrastructure #
vsphere_user = "nikoukam@tejaratshayan.com"

# Skip the verification of the vCenter SSL certificate (true/false) #
vsphere_unverified_ssl = "true"

# vSphere datacenter name where the infrastructure will be deployed #
vsphere_datacenter = "Payam-Shatel"

# vSphere cluster name where the infrastructure will be deployed #
vsphere_cluster = "Cluster"

#===============================================================================
# Virtual machine parameters
#===============================================================================

# The name of the virtual machine #
vm_name = "Centos7-jenkins"

# The datastore name used to store the files of the virtual machine #
vm_datastore = "Srv01-vDisk1-Raid10"

# The vSphere network name used by the virtual machine #
vm_network = "LAN"

# The netmask used to configure the network card of the virtual machine (example: 24) #
vm_netmask = "24"

# The network gateway used by the virtual machine #
vm_gateway = ""

# The DNS server used by the virtual machine #
vm_dns = "8.8.8.8"

# The domain name used by the virtual machine #
vm_domain = ""

# The vSphere template the virtual machine is based on #
vm_template = "Ubuntu-20.04.5"

# Use linked clone (true/false)
vm_linked_clone = "false"

# The number of vCPU allocated to the virtual machine #
vm_cpu = "2"

# The amount of RAM allocated to the virtual machine #
vm_ram = "2048"

# The IP address of the virtual machine #
vm_ip = "10.132.160.227"
