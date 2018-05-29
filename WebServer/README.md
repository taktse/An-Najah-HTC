# Virtual-Machines
KVM scripts

##       CreateCentOS7VM - Builds a CentOS7 virtual machine using virt-install. The defaults:

                           CreateCentOS7VM hostname 

                           Many parameters can be changed by setting environmental variables

                           * Boot ISO /mnt/boot.iso
                           * Kickstart file: http://172.16.9.180/software/ks/${hostname}-ks.cfg
                           * Bridge device: br0
                           * Number CPUs: 1
                           * Memory: 2048MB
                           * VM storage directory: /var/lib/libvirt/images

##       CreateCentOS7VMKickStart - Create a VM kickstart file
                        
                           CreateCentOS7VMKickStart hostname

##       GetDiskById - Get the kickstart disk ID
##       GetRootDiskById - Get the root disk kickstart disk ID
##       ResetSATA - Reset the SATA Bus
##       VirtClone - Clone a VM by running virt-clone
