From: Claudio Fontana <claudio.fontana@huawei.com>
Subject: Re: rfc: vhost user enhancements for vm2vm communication
Date: Fri, 11 Sep 2015 17:39:07 +0200
Message-ID: <55F2F59B.4030401@huawei.com>
References: <20150831160655-mutt-send-email-mst@redhat.com>
	<55ED854A.1080804@huawei.com>
	<20150909095258-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150909095258-mutt-send-email-mst@redhat.com>
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
Cc: opnfv-tech-discuss@lists.opnfv.org, virtio-dev@lists.oasis-open.org, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 09.09.2015 09:06, Michael S. Tsirkin wrote:
> On Mon, Sep 07, 2015 at 02:38:34PM +0200, Claudio Fontana wrote:
>> Coming late to the party, 
>>
>> On 31.08.2015 16:11, Michael S. Tsirkin wrote:
>>> Hello!
>>> During the KVM forum, we discussed supporting virtio on top
>>> of ivshmem. I have considered it, and came up with an alternative
>>> that has several advantages over that - please see below.
>>> Comments welcome.
>>
>> as Jan mentioned we actually discussed a virtio-shmem device which would incorporate the advantages of ivshmem (so no need for a separate ivshmem device), which would use the well known virtio interface, taking advantage of the new virtio-1 virtqueue layout to split r/w and read-only rings as seen from the two sides, and make use also of BAR0 which has been freed up for use by the device.
>>
>> This way it would be possible to share the rings and the actual memory for the buffers in the PCI bars. The guest VMs could decide to use the shared memory regions directly as prepared by the hypervisor (in the jailhouse case) or QEMU/KVM, or perform their own validation on the input depending on the use case.
>>
>> Of course the communication between VMs needs in this case to be pre-configured and is quite static (which is actually beneficial in our use case).
>>
>> But still in your proposed solution, each VM needs to be pre-configured to communicate with a specific other VM using a separate device right?
>>
>> But I wonder if we are addressing the same problem.. in your case you are looking at having a shared memory pool for all VMs potentially visible to all VMs (the vhost-user case), while in the virtio-shmem proposal we discussed we were assuming specific different regions for every channel.
>>
>> Ciao,
>>
>> Claudio
> 
> The problem, as I see it, is to allow inter-vm communication with
> polling (to get very low latencies) but polling within VMs only, without
> need to run a host thread (which when polling uses up a host CPU).
> 
> What was proposed was to simply change virtio to allow
> "offset within BAR" instead of PA.

There are many consequences to this, offset within BAR alone is not enough, there are multiple things at the virtio level that need sorting out.
Also we need to consider virtio-mmio etc.

> This would allow VM2VM communication if there are only 2 VMs,
> but if data needs to be sent to multiple VMs, you
> must copy it.

Not necessarily, however getting it to work (sharing the backend window and arbitrating the multicast) is really hard.

> 
> Additionally, it's a single-purpose feature: you can use it from
> a userspace PMD but linux will never use it.
> 
> 
> My proposal is a superset: don't require that BAR memory is
> used, use IOMMU translation tables.
> This way, data can be sent to multiple VMs by sharing the same
> memory with them all.

Can you describe in detail how your proposal deals with the arbitration necessary for multicast handling?

> 
> It is still possible to put data in some device BAR if that's
> what the guest wants to do: just program the IOMMU to limit
> virtio to the memory range that is within this BAR.
> 
> Another advantage here is that the feature is more generally useful.
> 
> 
>>>
>>> -----
>>>
>>> Existing solutions to userspace switching between VMs on the
>>> same host are vhost-user and ivshmem.
>>>
>>> vhost-user works by mapping memory of all VMs being bridged into the
>>> switch memory space.
>>>
>>> By comparison, ivshmem works by exposing a shared region of memory to all VMs.
>>> VMs are required to use this region to store packets. The switch only
>>> needs access to this region.
>>>
>>> Another difference between vhost-user and ivshmem surfaces when polling
>>> is used. With vhost-user, the switch is required to handle
>>> data movement between VMs, if using polling, this means that 1 host CPU
>>> needs to be sacrificed for this task.
>>>
>>> This is easiest to understand when one of the VMs is
>>> used with VF pass-through. This can be schematically shown below:
>>>
>>> +-- VM1 --------------+            +---VM2-----------+
>>> | virtio-pci          +-vhost-user-+ virtio-pci -- VF | -- VFIO -- IOMMU -- NIC
>>> +---------------------+            +-----------------+
>>>
>>>
>>> With ivshmem in theory communication can happen directly, with two VMs
>>> polling the shared memory region.
>>>
>>>
>>> I won't spend time listing advantages of vhost-user over ivshmem.
>>> Instead, having identified two advantages of ivshmem over vhost-user,
>>> below is a proposal to extend vhost-user to gain the advantages
>>> of ivshmem.
>>>
>>>
>>> 1: virtio in guest can be extended to allow support
>>> for IOMMUs. This provides guest with full flexibility
>>> about memory which is readable or write able by each device.
>>> By setting up a virtio device for each other VM we need to
>>> communicate to, guest gets full control of its security, from
>>> mapping all memory (like with current vhost-user) to only
>>> mapping buffers used for networking (like ivshmem) to
>>> transient mappings for the duration of data transfer only.
>>> This also allows use of VFIO within guests, for improved
>>> security.
>>>
>>> vhost user would need to be extended to send the
>>> mappings programmed by guest IOMMU.
>>>
>>> 2. qemu can be extended to serve as a vhost-user client:
>>> remote VM mappings over the vhost-user protocol, and
>>> map them into another VM's memory.
>>> This mapping can take, for example, the form of
>>> a BAR of a pci device, which I'll call here vhost-pci - 
>>> with bus address allowed
>>> by VM1's IOMMU mappings being translated into
>>> offsets within this BAR within VM2's physical
>>> memory space.
>>>
>>> Since the translation can be a simple one, VM2
>>> can perform it within its vhost-pci device driver.
>>>
>>> While this setup would be the most useful with polling,
>>> VM1's ioeventfd can also be mapped to
>>> another VM2's irqfd, and vice versa, such that VMs
>>> can trigger interrupts to each other without need
>>> for a helper thread on the host.
>>>
>>>
>>> The resulting channel might look something like the following:
>>>
>>> +-- VM1 --------------+  +---VM2-----------+
>>> | virtio-pci -- iommu +--+ vhost-pci -- VF | -- VFIO -- IOMMU -- NIC
>>> +---------------------+  +-----------------+
>>>
>>> comparing the two diagrams, a vhost-user thread on the host is
>>> no longer required, reducing the host CPU utilization when
>>> polling is active.  At the same time, VM2 can not access all of VM1's
>>> memory - it is limited by the iommu configuration setup by VM1.
>>>
>>>
>>> Advantages over ivshmem:
>>>
>>> - more flexibility, endpoint VMs do not have to place data at any
>>>   specific locations to use the device, in practice this likely
>>>   means less data copies.
>>> - better standardization/code reuse
>>>   virtio changes within guests would be fairly easy to implement
>>>   and would also benefit other backends, besides vhost-user
>>>   standard hotplug interfaces can be used to add and remove these
>>>   channels as VMs are added or removed.
>>> - migration support
>>>   It's easy to implement since ownership of memory is well defined.
>>>   For example, during migration VM2 can notify hypervisor of VM1
>>>   by updating dirty bitmap each time is writes into VM1 memory.
>>>
>>> Thanks,
>>>
>>
>>
