From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: rfc: vhost user enhancements for vm2vm communication
Date: Tue, 1 Sep 2015 11:17:20 +0300
Message-ID: <20150901110627-mutt-send-email-mst__615.78646204925$1441095460$gmane$org@redhat.com>
References: <20150831160655-mutt-send-email-mst@redhat.com>
	<CAL54oT2udFxDnY4jwFb1mZEEZ7vQzco7XL2QiDNv-kYQSVFH1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAL54oT2udFxDnY4jwFb1mZEEZ7vQzco7XL2QiDNv-kYQSVFH1Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: virtio-dev@lists.oasis-open.org, Jan Kiszka <jan.kiszka@siemens.com>, Claudio.Fontana@huawei.com, qemu-devel@nongnu.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, opnfv-tech-discuss@lists.opnfv.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 31, 2015 at 11:35:55AM -0700, Nakajima, Jun wrote:
> On Mon, Aug 31, 2015 at 7:11 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Hello!
> > During the KVM forum, we discussed supporting virtio on top
> > of ivshmem. I have considered it, and came up with an alternative
> > that has several advantages over that - please see below.
> > Comments welcome.
> 
> Hi Michael,
> 
> I like this, and it should be able to achieve what I presented at KVM
> Forum (vhost-user-shmem).
> Comments below.
> 
> >
> > -----
> >
> > Existing solutions to userspace switching between VMs on the
> > same host are vhost-user and ivshmem.
> >
> > vhost-user works by mapping memory of all VMs being bridged into the
> > switch memory space.
> >
> > By comparison, ivshmem works by exposing a shared region of memory to all VMs.
> > VMs are required to use this region to store packets. The switch only
> > needs access to this region.
> >
> > Another difference between vhost-user and ivshmem surfaces when polling
> > is used. With vhost-user, the switch is required to handle
> > data movement between VMs, if using polling, this means that 1 host CPU
> > needs to be sacrificed for this task.
> >
> > This is easiest to understand when one of the VMs is
> > used with VF pass-through. This can be schematically shown below:
> >
> > +-- VM1 --------------+            +---VM2-----------+
> > | virtio-pci          +-vhost-user-+ virtio-pci -- VF | -- VFIO -- IOMMU -- NIC
> > +---------------------+            +-----------------+
> >
> >
> > With ivshmem in theory communication can happen directly, with two VMs
> > polling the shared memory region.
> >
> >
> > I won't spend time listing advantages of vhost-user over ivshmem.
> > Instead, having identified two advantages of ivshmem over vhost-user,
> > below is a proposal to extend vhost-user to gain the advantages
> > of ivshmem.
> >
> >
> > 1: virtio in guest can be extended to allow support
> > for IOMMUs. This provides guest with full flexibility
> > about memory which is readable or write able by each device.
> 
> I assume that you meant VFIO only for virtio by "use of VFIO".  To get
> VFIO working for general direct-I/O (including VFs) in guests, as you
> know, we need to virtualize IOMMU (e.g. VT-d) and the interrupt
> remapping table on x86 (i.e. nested VT-d).

Not necessarily: if pmd is used, mappings stay mostly static,
and there are no interrupts, so existing IOMMU emulation in qemu
will do the job.


> > By setting up a virtio device for each other VM we need to
> > communicate to, guest gets full control of its security, from
> > mapping all memory (like with current vhost-user) to only
> > mapping buffers used for networking (like ivshmem) to
> > transient mappings for the duration of data transfer only.
> 
> And I think that we can use VMFUNC to have such transient mappings.

Interesting. There are two points to make here:


1. To create transient mappings, VMFUNC isn't strictly required.
Instead, mappings can be created when first access by VM2
within BAR triggers a page fault.
I guess VMFUNC could remove this first pagefault by hypervisor mapping
host PTE into the alternative view, then VMFUNC making
VM2 PTE valid - might be important if mappings are very dynamic
so there are many pagefaults.

2. To invalidate mappings, VMFUNC isn't sufficient since
translation cache of other CPUs needs to be invalidated.
I don't think VMFUNC can do this.




> > This also allows use of VFIO within guests, for improved
> > security.
> >
> > vhost user would need to be extended to send the
> > mappings programmed by guest IOMMU.
> 
> Right. We need to think about cases where other VMs (VM3, etc.) join
> the group or some existing VM leaves.
> PCI hot-plug should work there (as you point out at "Advantages over
> ivshmem" below).
> 
> >
> > 2. qemu can be extended to serve as a vhost-user client:
> > remote VM mappings over the vhost-user protocol, and
> > map them into another VM's memory.
> > This mapping can take, for example, the form of
> > a BAR of a pci device, which I'll call here vhost-pci -
> > with bus address allowed
> > by VM1's IOMMU mappings being translated into
> > offsets within this BAR within VM2's physical
> > memory space.
> 
> I think it's sensible.
> 
> >
> > Since the translation can be a simple one, VM2
> > can perform it within its vhost-pci device driver.
> >
> > While this setup would be the most useful with polling,
> > VM1's ioeventfd can also be mapped to
> > another VM2's irqfd, and vice versa, such that VMs
> > can trigger interrupts to each other without need
> > for a helper thread on the host.
> >
> >
> > The resulting channel might look something like the following:
> >
> > +-- VM1 --------------+  +---VM2-----------+
> > | virtio-pci -- iommu +--+ vhost-pci -- VF | -- VFIO -- IOMMU -- NIC
> > +---------------------+  +-----------------+
> >
> > comparing the two diagrams, a vhost-user thread on the host is
> > no longer required, reducing the host CPU utilization when
> > polling is active.  At the same time, VM2 can not access all of VM1's
> > memory - it is limited by the iommu configuration setup by VM1.
> >
> >
> > Advantages over ivshmem:
> >
> > - more flexibility, endpoint VMs do not have to place data at any
> >   specific locations to use the device, in practice this likely
> >   means less data copies.
> > - better standardization/code reuse
> >   virtio changes within guests would be fairly easy to implement
> >   and would also benefit other backends, besides vhost-user
> >   standard hotplug interfaces can be used to add and remove these
> >   channels as VMs are added or removed.
> > - migration support
> >   It's easy to implement since ownership of memory is well defined.
> >   For example, during migration VM2 can notify hypervisor of VM1
> >   by updating dirty bitmap each time is writes into VM1 memory.
> 
> Also, the ivshmem functionality could be implemented by this proposal:
> - vswitch (or some VM) allocates memory regions in its address space, and
> - it sets up that IOMMU mappings on the VMs be translated into the regions

I agree it's possible, but that's not something that exists on real
hardware. It's not clear to me what are the security implications
of having VM2 control IOMMU of VM1. Having each VM control its own IOMMU
seems more straight-forward.


> >
> > Thanks,
> >
> > --
> > MST
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 
> 
> -- 
> Jun
> Intel Open Source Technology Center
