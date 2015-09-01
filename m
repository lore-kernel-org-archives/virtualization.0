From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] rfc: vhost user enhancements for vm2vm	communication
Date: Tue, 1 Sep 2015 11:30:02 +0300
Message-ID: <20150901111738-mutt-send-email-mst@redhat.com>
References: <20150831160655-mutt-send-email-mst@redhat.com>
	<CAL54oT2udFxDnY4jwFb1mZEEZ7vQzco7XL2QiDNv-kYQSVFH1Q@mail.gmail.com>
	<BN1PR0301MB0627D7AE90FC7A08545848CAEA6A0@BN1PR0301MB0627.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <BN1PR0301MB0627D7AE90FC7A08545848CAEA6A0@BN1PR0301MB0627.namprd03.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Claudio.Fontana@huawei.com" <Claudio.Fontana@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "opnfv-tech-discuss@lists.opnfv.org" <opnfv-tech-discuss@lists.opnfv.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 01, 2015 at 03:03:12AM +0000, Varun Sethi wrote:
> Hi Michael,
> When you talk about VFIO in guest, is it with a purely emulated IOMMU in =
Qemu?

This can use the emulated IOMMU in Qemu.
That's probably fast enough if mappings are mostly static.
We can also add a PV-IOMMU if necessary.

> Also, I am not clear on the following points:
> 1. How transient memory would be mapped using BAR in the backend VM

The simplest way is that =

each update sends a vhost-user message. backend gets it and
mmaps it into backend QEMU and make it part of RAM memory slot.

Or - backend QEMU could detect a pagefault on access and get the
IOMMU from frontend QEMU - using vhost-user messages or
from shared memory.




> 2. How would the backend VM update the dirty page bitmap for the frontend=
 VM
> =

> Regards
> Varun

The easiest to implement way is probably for backend QEMU to setup dirty tr=
acking
for the relevant slot (upon getting vhost user message
from the frontend) then retrieve the dirty map
from kvm and record it in a shared memory region
(when do it? We could have an eventfd and/or vhost-user message to
trigger this from the frontend QEMU, or just use a timer).

An alternative is for backend VM to get access to dirty log
(e.g. map it within BAR) and update it directly in shared memory.
Seems like more work.

Marc-Andr=E9 Lureau recently sent patches to support passing
dirty log around, these would be useful.


> > -----Original Message-----
> > From: qemu-devel-bounces+varun.sethi=3Dfreescale.com@nongnu.org
> > [mailto:qemu-devel-bounces+varun.sethi=3Dfreescale.com@nongnu.org] On
> > Behalf Of Nakajima, Jun
> > Sent: Monday, August 31, 2015 1:36 PM
> > To: Michael S. Tsirkin
> > Cc: virtio-dev@lists.oasis-open.org; Jan Kiszka;
> > Claudio.Fontana@huawei.com; qemu-devel@nongnu.org; Linux
> > Virtualization; opnfv-tech-discuss@lists.opnfv.org
> > Subject: Re: [Qemu-devel] rfc: vhost user enhancements for vm2vm
> > communication
> > =

> > On Mon, Aug 31, 2015 at 7:11 AM, Michael S. Tsirkin <mst@redhat.com>
> > wrote:
> > > Hello!
> > > During the KVM forum, we discussed supporting virtio on top of
> > > ivshmem. I have considered it, and came up with an alternative that
> > > has several advantages over that - please see below.
> > > Comments welcome.
> > =

> > Hi Michael,
> > =

> > I like this, and it should be able to achieve what I presented at KVM F=
orum
> > (vhost-user-shmem).
> > Comments below.
> > =

> > >
> > > -----
> > >
> > > Existing solutions to userspace switching between VMs on the same host
> > > are vhost-user and ivshmem.
> > >
> > > vhost-user works by mapping memory of all VMs being bridged into the
> > > switch memory space.
> > >
> > > By comparison, ivshmem works by exposing a shared region of memory to
> > all VMs.
> > > VMs are required to use this region to store packets. The switch only
> > > needs access to this region.
> > >
> > > Another difference between vhost-user and ivshmem surfaces when
> > > polling is used. With vhost-user, the switch is required to handle
> > > data movement between VMs, if using polling, this means that 1 host
> > > CPU needs to be sacrificed for this task.
> > >
> > > This is easiest to understand when one of the VMs is used with VF
> > > pass-through. This can be schematically shown below:
> > >
> > > +-- VM1 --------------+            +---VM2-----------+
> > > | virtio-pci          +-vhost-user-+ virtio-pci -- VF | -- VFIO -- IO=
MMU -- NIC
> > > +---------------------+            +-----------------+
> > >
> > >
> > > With ivshmem in theory communication can happen directly, with two VMs
> > > polling the shared memory region.
> > >
> > >
> > > I won't spend time listing advantages of vhost-user over ivshmem.
> > > Instead, having identified two advantages of ivshmem over vhost-user,
> > > below is a proposal to extend vhost-user to gain the advantages of
> > > ivshmem.
> > >
> > >
> > > 1: virtio in guest can be extended to allow support for IOMMUs. This
> > > provides guest with full flexibility about memory which is readable or
> > > write able by each device.
> > =

> > I assume that you meant VFIO only for virtio by "use of VFIO".  To get =
VFIO
> > working for general direct-I/O (including VFs) in guests, as you know, =
we
> > need to virtualize IOMMU (e.g. VT-d) and the interrupt remapping table =
on
> > x86 (i.e. nested VT-d).
> > =

> > > By setting up a virtio device for each other VM we need to communicate
> > > to, guest gets full control of its security, from mapping all memory
> > > (like with current vhost-user) to only mapping buffers used for
> > > networking (like ivshmem) to transient mappings for the duration of
> > > data transfer only.
> > =

> > And I think that we can use VMFUNC to have such transient mappings.
> > =

> > > This also allows use of VFIO within guests, for improved security.
> > >
> > > vhost user would need to be extended to send the mappings programmed
> > > by guest IOMMU.
> > =

> > Right. We need to think about cases where other VMs (VM3, etc.) join the
> > group or some existing VM leaves.
> > PCI hot-plug should work there (as you point out at "Advantages over
> > ivshmem" below).
> > =

> > >
> > > 2. qemu can be extended to serve as a vhost-user client:
> > > remote VM mappings over the vhost-user protocol, and map them into
> > > another VM's memory.
> > > This mapping can take, for example, the form of a BAR of a pci device,
> > > which I'll call here vhost-pci - with bus address allowed by VM1's
> > > IOMMU mappings being translated into offsets within this BAR within
> > > VM2's physical memory space.
> > =

> > I think it's sensible.
> > =

> > >
> > > Since the translation can be a simple one, VM2 can perform it within
> > > its vhost-pci device driver.
> > >
> > > While this setup would be the most useful with polling, VM1's
> > > ioeventfd can also be mapped to another VM2's irqfd, and vice versa,
> > > such that VMs can trigger interrupts to each other without need for a
> > > helper thread on the host.
> > >
> > >
> > > The resulting channel might look something like the following:
> > >
> > > +-- VM1 --------------+  +---VM2-----------+
> > > | virtio-pci -- iommu +--+ vhost-pci -- VF | -- VFIO -- IOMMU -- NIC
> > > +---------------------+  +-----------------+
> > >
> > > comparing the two diagrams, a vhost-user thread on the host is no
> > > longer required, reducing the host CPU utilization when polling is
> > > active.  At the same time, VM2 can not access all of VM1's memory - it
> > > is limited by the iommu configuration setup by VM1.
> > >
> > >
> > > Advantages over ivshmem:
> > >
> > > - more flexibility, endpoint VMs do not have to place data at any
> > >   specific locations to use the device, in practice this likely
> > >   means less data copies.
> > > - better standardization/code reuse
> > >   virtio changes within guests would be fairly easy to implement
> > >   and would also benefit other backends, besides vhost-user
> > >   standard hotplug interfaces can be used to add and remove these
> > >   channels as VMs are added or removed.
> > > - migration support
> > >   It's easy to implement since ownership of memory is well defined.
> > >   For example, during migration VM2 can notify hypervisor of VM1
> > >   by updating dirty bitmap each time is writes into VM1 memory.
> > =

> > Also, the ivshmem functionality could be implemented by this proposal:
> > - vswitch (or some VM) allocates memory regions in its address space, a=
nd
> > - it sets up that IOMMU mappings on the VMs be translated into the regi=
ons
> > =

> > >
> > > Thanks,
> > >
> > > --
> > > MST
> > > _______________________________________________
> > > Virtualization mailing list
> > > Virtualization@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > =

> > =

> > --
> > Jun
> > Intel Open Source Technology Center
> =
