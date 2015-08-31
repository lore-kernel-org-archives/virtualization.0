From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: rfc: vhost user enhancements for vm2vm communication
Date: Mon, 31 Aug 2015 17:11:02 +0300
Message-ID: <20150831160655-mutt-send-email-mst__33487.1098203168$1441030290$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, opnfv-tech-discuss@lists.opnfv.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Claudio.Fontana@huawei.com
List-Id: virtualization@lists.linuxfoundation.org

Hello!
During the KVM forum, we discussed supporting virtio on top
of ivshmem. I have considered it, and came up with an alternative
that has several advantages over that - please see below.
Comments welcome.

-----

Existing solutions to userspace switching between VMs on the
same host are vhost-user and ivshmem.

vhost-user works by mapping memory of all VMs being bridged into the
switch memory space.

By comparison, ivshmem works by exposing a shared region of memory to all VMs.
VMs are required to use this region to store packets. The switch only
needs access to this region.

Another difference between vhost-user and ivshmem surfaces when polling
is used. With vhost-user, the switch is required to handle
data movement between VMs, if using polling, this means that 1 host CPU
needs to be sacrificed for this task.

This is easiest to understand when one of the VMs is
used with VF pass-through. This can be schematically shown below:

+-- VM1 --------------+            +---VM2-----------+
| virtio-pci          +-vhost-user-+ virtio-pci -- VF | -- VFIO -- IOMMU -- NIC
+---------------------+            +-----------------+


With ivshmem in theory communication can happen directly, with two VMs
polling the shared memory region.


I won't spend time listing advantages of vhost-user over ivshmem.
Instead, having identified two advantages of ivshmem over vhost-user,
below is a proposal to extend vhost-user to gain the advantages
of ivshmem.


1: virtio in guest can be extended to allow support
for IOMMUs. This provides guest with full flexibility
about memory which is readable or write able by each device.
By setting up a virtio device for each other VM we need to
communicate to, guest gets full control of its security, from
mapping all memory (like with current vhost-user) to only
mapping buffers used for networking (like ivshmem) to
transient mappings for the duration of data transfer only.
This also allows use of VFIO within guests, for improved
security.

vhost user would need to be extended to send the
mappings programmed by guest IOMMU.

2. qemu can be extended to serve as a vhost-user client:
remote VM mappings over the vhost-user protocol, and
map them into another VM's memory.
This mapping can take, for example, the form of
a BAR of a pci device, which I'll call here vhost-pci - 
with bus address allowed
by VM1's IOMMU mappings being translated into
offsets within this BAR within VM2's physical
memory space.

Since the translation can be a simple one, VM2
can perform it within its vhost-pci device driver.

While this setup would be the most useful with polling,
VM1's ioeventfd can also be mapped to
another VM2's irqfd, and vice versa, such that VMs
can trigger interrupts to each other without need
for a helper thread on the host.


The resulting channel might look something like the following:

+-- VM1 --------------+  +---VM2-----------+
| virtio-pci -- iommu +--+ vhost-pci -- VF | -- VFIO -- IOMMU -- NIC
+---------------------+  +-----------------+

comparing the two diagrams, a vhost-user thread on the host is
no longer required, reducing the host CPU utilization when
polling is active.  At the same time, VM2 can not access all of VM1's
memory - it is limited by the iommu configuration setup by VM1.


Advantages over ivshmem:

- more flexibility, endpoint VMs do not have to place data at any
  specific locations to use the device, in practice this likely
  means less data copies.
- better standardization/code reuse
  virtio changes within guests would be fairly easy to implement
  and would also benefit other backends, besides vhost-user
  standard hotplug interfaces can be used to add and remove these
  channels as VMs are added or removed.
- migration support
  It's easy to implement since ownership of memory is well defined.
  For example, during migration VM2 can notify hypervisor of VM1
  by updating dirty bitmap each time is writes into VM1 memory.

Thanks,

-- 
MST
