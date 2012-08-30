From: George Zhang <georgezhang@vmware.com>
Subject: [Pv-drivers] [vmw_vmci 00/11] VMCI driver for Linux
Date: Thu, 30 Aug 2012 09:35:08 -0700
Message-ID: <15333E71B3DDCB48A90165AD57993F285685DB43D6__40563.299941323$1346779672$gmane$org@exch-mbx-114.vmware.com>
References: <20120824171042.4775.36871.stgit@promb-2n-dhcp175.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120824171042.4775.36871.stgit@promb-2n-dhcp175.eng.vmware.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, George Zhang <georgezhang@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org



The following series implements VMware VMCI linux kernel driver.
Changes includes VMCI driver public API naming conversion from
upper case to lower case, some bug fixes.



In an effort to improve the out-of-the-box experience with Linux
kernels for VMware users, VMware is working on readying the Virtual
Machine Communication Interface (vmw_vmci) and VMCI Sockets
(vmw_vsock) kernel modules for inclusion in the Linux kernel. The
purpose of this post is to acquire feedback on the vmw_vmci kernel
module. The vmw_vsock kernel module will be presented in a later post.

VMCI allows virtual machines to communicate with host kernel modules
and the VMware hypervisors. User level applications both in a virtual
machine and on the host can use vmw_vmci through VMCI Sockets, a socket
address family designed to be compatible with UDP and TCP at the
interface level. Today, VMCI and VMCI Sockets are used by the VMware
shared folders (HGFS) and various VMware Tools components inside the
guest for zero-config, network-less access to VMware host services. In
addition to this, VMware's users are using VMCI Sockets for various
applications, where network access of the virtual machine is
restricted or non-existent. Examples of this are VMs communicating
with device proxies for proprietary hardware running as host
applications and automated testing of applications running within
virtual machines.

In a virtual machine, VMCI is exposed as a regular PCI device. The
primary communication mechanisms supported are a point-to-point
bidirectional transport based on a pair of memory-mapped queues, and
asynchronous notifications in the form of datagrams and
doorbells. These features are available to kernel level components
such as HGFS and VMCI Sockets through the VMCI kernel API. In addition
to this, the VMCI kernel API provides support for receiving events
related to the state of the VMCI communication channels, and the
virtual machine itself.

Outside the virtual machine, the host side support of the VMCI kernel
module makes the same VMCI kernel API available to VMCI endpoints on
the host. In addition to this, the host side manages each VMCI device
in a virtual machine through a context object. This context object
serves to identify the virtual machine for communication, and to track
the resource consumption of the given VMCI device. Both operations
related to communication between the virtual machine and the host
kernel, and those related to the management of the VMCI device state
in the host kernel, are invoked by the user level component of the
hypervisor through a set of ioctls on the VMCI device node.  To
provide seamless support for nested virtualization, where a virtual
machine may use both a VMCI PCI device to talk to its hypervisor, and
the VMCI host side support to run nested virtual machines, the VMCI
host and virtual machine support are combined in a single kernel
module.

For additional information about the use of VMCI and in particular
VMCI Sockets, please refer to the VMCI Socket Programming Guide
available at https://www.vmware.com/support/developer/vmci-sdk/.


George Zhang (11):
      vmci_context.patch: VMCI context list operations.
      vmci_datagram.patch: VMCI datagram entity handling.
      vmci_doorbell.patch: VMCI doorbell notification handling.
      vmci_driver.patch: VMCI device driver.
      vmci_event.patch: VMCI kernel events handling.
      vmci_handle_array.patch: VMCI array of vmci_handle.
      vmci_hash_table.patch: VMCI hash table implementation.
      vmci_queue_pair.patch: VMCI queue pair implementation.
      vmci_resource.patch: VMCI resource hash table implementation.
      vmci_route.patch: VMCI routing implementation.
      vmci_headers.patch: VMCI kernel driver public API.


 drivers/misc/Kconfig                      |    1
 drivers/misc/Makefile                     |    2
 drivers/misc/vmw_vmci/Kconfig             |   16
 drivers/misc/vmw_vmci/Makefile            |   42
 drivers/misc/vmw_vmci/vmci_common_int.h   |   34
 drivers/misc/vmw_vmci/vmci_context.c      | 1245 ++++++++++
 drivers/misc/vmw_vmci/vmci_context.h      |  174 +
 drivers/misc/vmw_vmci/vmci_datagram.c     |  583 +++++
 drivers/misc/vmw_vmci/vmci_datagram.h     |   55
 drivers/misc/vmw_vmci/vmci_doorbell.c     |  749 ++++++
 drivers/misc/vmw_vmci/vmci_doorbell.h     |   54
 drivers/misc/vmw_vmci/vmci_driver.c       | 2293 +++++++++++++++++++
 drivers/misc/vmw_vmci/vmci_driver.h       |   48
 drivers/misc/vmw_vmci/vmci_event.c        |  448 ++++
 drivers/misc/vmw_vmci/vmci_event.h        |   25
 drivers/misc/vmw_vmci/vmci_handle_array.c |  163 +
 drivers/misc/vmw_vmci/vmci_handle_array.h |   46
 drivers/misc/vmw_vmci/vmci_hash_table.c   |  329 +++
 drivers/misc/vmw_vmci/vmci_hash_table.h   |   53
 drivers/misc/vmw_vmci/vmci_queue_pair.c   | 3545 +++++++++++++++++++++++++++++
 drivers/misc/vmw_vmci/vmci_queue_pair.h   |  195 ++
 drivers/misc/vmw_vmci/vmci_resource.c     |  190 ++
 drivers/misc/vmw_vmci/vmci_resource.h     |   59
 drivers/misc/vmw_vmci/vmci_route.c        |  237 ++
 drivers/misc/vmw_vmci/vmci_route.h        |   30
 include/linux/vmw_vmci_api.h              |   86 +
 include/linux/vmw_vmci_defs.h             |  917 ++++++++
 27 files changed, 11619 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/vmw_vmci/Kconfig
 create mode 100644 drivers/misc/vmw_vmci/Makefile
 create mode 100644 drivers/misc/vmw_vmci/vmci_common_int.h
 create mode 100644 drivers/misc/vmw_vmci/vmci_context.c
 create mode 100644 drivers/misc/vmw_vmci/vmci_context.h
 create mode 100644 drivers/misc/vmw_vmci/vmci_datagram.c
 create mode 100644 drivers/misc/vmw_vmci/vmci_datagram.h
 create mode 100644 drivers/misc/vmw_vmci/vmci_doorbell.c
 create mode 100644 drivers/misc/vmw_vmci/vmci_doorbell.h
 create mode 100644 drivers/misc/vmw_vmci/vmci_driver.c
 create mode 100644 drivers/misc/vmw_vmci/vmci_driver.h
 create mode 100644 drivers/misc/vmw_vmci/vmci_event.c
 create mode 100644 drivers/misc/vmw_vmci/vmci_event.h
 create mode 100644 drivers/misc/vmw_vmci/vmci_handle_array.c
 create mode 100644 drivers/misc/vmw_vmci/vmci_handle_array.h
 create mode 100644 drivers/misc/vmw_vmci/vmci_hash_table.c
 create mode 100644 drivers/misc/vmw_vmci/vmci_hash_table.h
 create mode 100644 drivers/misc/vmw_vmci/vmci_queue_pair.c
 create mode 100644 drivers/misc/vmw_vmci/vmci_queue_pair.h
 create mode 100644 drivers/misc/vmw_vmci/vmci_resource.c
 create mode 100644 drivers/misc/vmw_vmci/vmci_resource.h
 create mode 100644 drivers/misc/vmw_vmci/vmci_route.c
 create mode 100644 drivers/misc/vmw_vmci/vmci_route.h
 create mode 100644 include/linux/vmw_vmci_api.h
 create mode 100644 include/linux/vmw_vmci_defs.h


---------------------------------------------------------
Pv-drivers mailing list
Pv-drivers@vmware.com
http://mailman2.vmware.com/mailman/listinfo/pv-drivers
---------------------------------------------------------
