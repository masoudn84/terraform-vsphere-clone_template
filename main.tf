terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.1.1"
    }
  }
}

#===============================================================================
# vSphere Provider
#===============================================================================

provider "vsphere" {
  vsphere_server       = var.vsphere_vcenter
  user                 = var.vsphere_user
  password             = var.vsphere_password
  allow_unverified_ssl = var.vsphere_unverified_ssl
}

#===============================================================================
# vSphere Data
#===============================================================================

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = var.vm_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vm_network
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_virtual_machine" "template" {
  name          = var.vm_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

#===============================================================================
# vSphere Resources
#===============================================================================

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = var.vm_cpu
  memory           = var.vm_ram
  guest_id         = var.vm_guestID
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "${var.vm_name}-disk0"
    size  = var.vm_disk_size
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      timeout = "20"

      linux_options {
        host_name = var.vm_hostname
        domain    = var.vm_domain
      }
      network_interface {}

    }
  }
}
resource "local_file" "vm_ip" {
  content  = <<-DOC
  [all]
  ${vsphere_virtual_machine.vm.default_ip_address} ansible_user=ubuntu ansible_ssh_pass=ubuntu host_key_checking=False ansible_ssh_common_args='-o StrictHostKeyChecking=no'
  DOC
  filename = "vm_ip.txt"
}

output "my_ip_address" {
  value = vsphere_virtual_machine.vm.default_ip_address
}
