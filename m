From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [RFC] virtio-net: help live migrate SR-IOV devices
Date: Tue, 28 Nov 2017 11:27:22 -0800
Message-ID: <20171128112722.00003716@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, mst@redhat.com, Sridhar Samudrala <sridhar.samudrala@intel.com>, Achiad <achiad@mellanox.com>, Peter Waskiewicz Jr <peter.waskiewicz.jr@intel.com>, "Singhai,
	Anjali" <anjali.singhai@intel.com>, Andy Gospodarek <gospo@broadcom.com>, Or Gerlitz <gerlitz.or@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi, I'd like to get some feedback on a proposal to enhance virtio-net
to ease configuration of a VM and that would enable live migration of
passthrough network SR-IOV devices. 

Today we have SR-IOV network devices (VFs) that can be passed into a VM
in order to enable high performance networking direct within the VM.
The problem I am trying to address is that this configuration is
generally difficult to live-migrate.  There is documentation [1]
indicating that some OS/Hypervisor vendors will support live migration
of a system with a direct assigned networking device.  The problem I
see with these implementations is that the network configuration
requirements that are passed on to the owner of the VM are quite
complicated.  You have to set up bonding, you have to configure it to
enslave two interfaces, those interfaces (one is virtio-net, the other
is SR-IOV device/driver like ixgbevf) must support MAC address changes
requested in the VM, and on and on...

So, on to the proposal:
Modify virtio-net driver to be a single VM network device that
enslaves an SR-IOV network device (inside the VM) with the same MAC
address. This would cause the virtio-net driver to appear and work like
a simplified bonding/team driver.  The live migration problem would be
solved just like today's bonding solution, but the VM user's networking
config would be greatly simplified.

At it's simplest, it would appear something like this in the VM.

==========
= vnet0  =
         =============
(virtio- =       |
 net)    =       |
         =  ==========
         =  = ixgbef =
==========  ==========

(forgive the ASCII art)

The fast path traffic would prefer the ixgbevf or other SR-IOV device
path, and fall back to virtio's transmit/receive when migrating.

Compared to today's options this proposal would
1) make virtio-net more sticky, allow fast path traffic at SR-IOV
   speeds 
2) simplify end user configuration in the VM (most if not all of the
   set up to enable migration would be done in the hypervisor)
3) allow live migration via a simple link down and maybe a PCI
   hot-unplug of the SR-IOV device, with failover to the virtio-net
   driver core
4) allow vendor agnostic hardware acceleration, and live migration 
   between vendors if the VM os has driver support for all the required
   SR-IOV devices.

Runtime operation proposed:
- <in either order> virtio-net driver loads, SR-IOV driver loads
- virtio-net finds other NICs that match it's MAC address by 
  both examining existing interfaces, and sets up a new device notifier
- virtio-net enslaves the first NIC with the same MAC address
- virtio-net brings up the slave, and makes it the "preferred" path
- virtio-net follows the behavior of an active backup bond/team
- virtio-net acts as the interface to the VM
- live migration initiates
- link goes down on SR-IOV, or SR-IOV device is removed
- failover to virtio-net as primary path
- migration continues to new host
- new host is started with virio-net as primary
- if no SR-IOV, virtio-net stays primary
- hypervisor can hot-add SR-IOV NIC, with same MAC addr as virtio
- virtio-net notices new NIC and starts over at enslave step above

Future ideas (brainstorming):
- Optimize Fast east-west by having special rules to direct east-west
  traffic through virtio-net traffic path

Thanks for reading!
Jesse

[1]
https://access.redhat.com/documentation/en-us/red_hat_virtualization/4.1/html/virtual_machine_management_guide/sect-migrating_virtual_machines_between_hosts
