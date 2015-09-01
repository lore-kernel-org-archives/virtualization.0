From: "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: rfc: vhost user enhancements for vm2vm communication
Date: Tue, 1 Sep 2015 15:56:32 -0700
Message-ID: <CAL54oT273joQfwsX+Y5CBwmcbYyQgrkB4EPiEcA4p6YpPPJXPw@mail.gmail.com>
References: <20150831160655-mutt-send-email-mst@redhat.com>
	<CAL54oT2udFxDnY4jwFb1mZEEZ7vQzco7XL2QiDNv-kYQSVFH1Q@mail.gmail.com>
	<20150901110627-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150901110627-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jan Kiszka <jan.kiszka@siemens.com>, Claudio.Fontana@huawei.com, qemu-devel@nongnu.org, Linux Virtualization <virtualization@lists.linux-foundation.org>, opnfv-tech-discuss@lists.opnfv.org
List-Id: virtualization@lists.linuxfoundation.org

My previous email has been bounced by virtio-dev@lists.oasis-open.org.
I tried to subscribed it, but to no avail...

On Tue, Sep 1, 2015 at 1:17 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Aug 31, 2015 at 11:35:55AM -0700, Nakajima, Jun wrote:
>> On Mon, Aug 31, 2015 at 7:11 AM, Michael S. Tsirkin <mst@redhat.com> wrote:

>> > 1: virtio in guest can be extended to allow support
>> > for IOMMUs. This provides guest with full flexibility
>> > about memory which is readable or write able by each device.
>>
>> I assume that you meant VFIO only for virtio by "use of VFIO".  To get
>> VFIO working for general direct-I/O (including VFs) in guests, as you
>> know, we need to virtualize IOMMU (e.g. VT-d) and the interrupt
>> remapping table on x86 (i.e. nested VT-d).
>
> Not necessarily: if pmd is used, mappings stay mostly static,
> and there are no interrupts, so existing IOMMU emulation in qemu
> will do the job.

OK. It would work, although we need to engage additional/complex code
in the guests when we are making just memory operations under the
hood.

>> > By setting up a virtio device for each other VM we need to
>> > communicate to, guest gets full control of its security, from
>> > mapping all memory (like with current vhost-user) to only
>> > mapping buffers used for networking (like ivshmem) to
>> > transient mappings for the duration of data transfer only.
>>
>> And I think that we can use VMFUNC to have such transient mappings.
>
> Interesting. There are two points to make here:
>
>
> 1. To create transient mappings, VMFUNC isn't strictly required.
> Instead, mappings can be created when first access by VM2
> within BAR triggers a page fault.
> I guess VMFUNC could remove this first pagefault by hypervisor mapping
> host PTE into the alternative view, then VMFUNC making
> VM2 PTE valid - might be important if mappings are very dynamic
> so there are many pagefaults.

I agree that VMFUNC isn't strictly required. It would provide
performance optimization.
And I think it can add some level of protection as well because you
might want to keep mapping guest physical memory (which is partial or
entire VM1's memory) at BAR of VM2 all the time. IOMMU on VM1 can
limit the address ranges accessed by VM2, but such restriction becomes
loose  as you want them static and thus large enough.

>
> 2. To invalidate mappings, VMFUNC isn't sufficient since
> translation cache of other CPUs needs to be invalidated.
> I don't think VMFUNC can do this.

I don't think we need to invalidate mappings often. And if we do, we
need to invalidate EPT anyway.

>>
>> Also, the ivshmem functionality could be implemented by this proposal:
>> - vswitch (or some VM) allocates memory regions in its address space, and
>> - it sets up that IOMMU mappings on the VMs be translated into the regions
>
> I agree it's possible, but that's not something that exists on real
> hardware. It's not clear to me what are the security implications
> of having VM2 control IOMMU of VM1. Having each VM control its own IOMMU
> seems more straight-forward.

I meant the vswitch's IOMMU. It can a bare-metal (or host) process or
VM. For a bare-metal process, it's basically VFIO, where virtual
address is used as bus address. Each VM accesses the shared memory
using vhost-pci BAR + bus (i.e. virtual) address.


-- 
Jun
Intel Open Source Technology Center
