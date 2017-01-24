From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 2/2] vring: Force use of DMA API for ARM-based systems
Date: Tue, 24 Jan 2017 16:04:11 +0000
Message-ID: <5ad8ce42-a469-7417-d2c5-58cc0da89e8d__6406.66576005078$1485277082$gmane$org@arm.com>
References: <20170113092522.GB22538@arm.com>
	<20170113183222-mutt-send-email-mst@kernel.org>
	<20170113172154.GL3253@arm.com>
	<20170113201933-mutt-send-email-mst@kernel.org>
	<20170116104028.GA1510@arm.com>
	<20170116161639-mutt-send-email-mst@kernel.org>
	<20170116142103.GF1510@arm.com>
	<20170116162225-mutt-send-email-mst@kernel.org>
	<20170116143408.GG1510@arm.com>
	<20170119234852-mutt-send-email-mst@kernel.org>
	<20170120103332.GA1277@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170120103332.GA1277@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will.deacon@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>, luto@kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 20/01/17 10:33, Will Deacon wrote:
> On Thu, Jan 19, 2017 at 11:51:06PM +0200, Michael S. Tsirkin wrote:
>> On Mon, Jan 16, 2017 at 02:34:08PM +0000, Will Deacon wrote:
>>> On Mon, Jan 16, 2017 at 04:27:28PM +0200, Michael S. Tsirkin wrote:
>>>> On Mon, Jan 16, 2017 at 02:21:03PM +0000, Will Deacon wrote:
>>>>> On Mon, Jan 16, 2017 at 04:18:03PM +0200, Michael S. Tsirkin wrote:
>>>>>> On Mon, Jan 16, 2017 at 10:40:28AM +0000, Will Deacon wrote:
>>>>>>> On Fri, Jan 13, 2017 at 08:23:35PM +0200, Michael S. Tsirkin wrote:
>>>>>>>> On Fri, Jan 13, 2017 at 05:21:54PM +0000, Will Deacon wrote:
>>>>>>>>> On Fri, Jan 13, 2017 at 06:46:32PM +0200, Michael S. Tsirkin wrote:
>>>>>>>>>> On Fri, Jan 13, 2017 at 09:25:22AM +0000, Will Deacon wrote:
>>>>>>>>>>> On Fri, Jan 13, 2017 at 12:12:56AM +0200, Michael S. Tsirkin wrote:
>>>>>>>>>>>> I'd rather people didn't use SMMU with legacy devices.
>>>>>>>>>>>
>>>>>>>>>>> I'm afraid we've been doing that for two years and the model already
>>>>>>>>>>> exists in a mature state, being actively used for development and
>>>>>>>>>>> validation by ARM and our partners. One of the big things its used for
>>>>>>>>>>> is to develop SMMU and GIC (our interrupt controller) code with PCI, so
>>>>>>>>>>> dropping the SMMU from the picture isn't an option.
>>>>>>>>>>
>>>>>>>>>> Oh so this fixes a regression?  This is something I didn't realize.
>>>>>>>>>
>>>>>>>>> Yes, thanks. The regression came about because we implemented SMMU-backed
>>>>>>>>> DMA ops and only then was it apparent that the virtio stuff was bypassing
>>>>>>>>> even with translation enabled (because it wasn't using the DMA API).
>>>>>>>>
>>>>>>>> Could you point out a commit ID?
>>>>>>>
>>>>>>> There has been a fair amount of work in this area recently, but you're
>>>>>>> probably after something like 876945dbf649 ("arm64: Hook up IOMMU dma_ops")
>>>>>>> as the culprit, which is the point at which we started to swizzle DMA
>>>>>>> ops for devices upstream of an SMMU automatically.
>>>>>>>
>>>>>>>>>> A "Fixes:" tag can't hurt here.  I then wonder
>>>>>>>>>> might DMA ops ever use a DMA address which isn't a physical address
>>>>>>>>>> from QEMU point of view? If that happens, this hack breaks
>>>>>>>>>> because in legacy mode QEMU still uses the GPA.
>>>>>>>>>
>>>>>>>>> If QEMU doesn't advertise an SMMU, then it will work fine with the GPA,
>>>>>>>>> because we won't swizzle the DMA ops for the master device. If QEMU does
>>>>>>>>> advertise an SMMU, then we'll allocate DMA addresses to fit within the
>>>>>>>>> the intersection of the SMMU aperture and device's DMA mask.
>>>>>>>>
>>>>>>>>
>>>>>>>> Right but doesn't just poking from qemu into phys addresses work
>>>>>>>> anymore? It used to ...
>>>>>>>
>>>>>>> Provided that there's no SMMU, then it will continue to work. and my
>>>>>>> understanding (from talking to Peter Maydell) is that qemu doesn't model
>>>>>>> an SMMU for ARM-based machines.
>>>>>>>
>>>>>>
>>>>>> So how come people report failures due to presence of SMMU?
>>>>>> Using some other hypervisor?
>>>>>
>>>>> The failures are reported on the ARM fastmodel (a complete system
>>>>> emulation that runs on an x86 box), where an SMMU *is* present
>>>>> downstream of the virtio-pci masters. There's no qemu involved there.
>>>>>
>>>> I see. And this hypervisor actually coded up looking up
>>>> translations in the SMMU unconditionally for legacy devices,
>>>> and this worked as long as guest didn't touch the SMMU?
>>>
>>> Well, the fastmodel isn't a hypervisor really. It's a full system emulation,
>>> so it's better to think of it like a piece of hardware. For example, you
>>> could run KVM on the fastmodel. But yes, when Linux didn't swizzle the
>>> DMA ops to point at the SMMU, then everything defaults to bypass (because
>>> that's the default behaviour of the SMMU driver -- this is configurable
>>> on the command line) which is why things used to work.
>>>
>> I would be a bit happier if Linux checked virtio iommu quirk and skipped
>> the DMA ops thing then. It's a bit ugly but at least it's consistently
>> ugly.  To get clean emulation you would then use a modern device.
> 
> Sorry, but I'm not sure I follow your suggestion here. If you're talking
> about the DMA ops themselves, they are assigned in arch_setup_dma_ops long
> before the virtio layer gets involved, so we really can't figure out
> whether the device has a virtio iommu quirk at that point.
> 
> I've reworked the patch (see below) so that we unconditionally set the
> DMA ops for arm-based legacy devices, but I can't really tell what you're
> after here.
> 
> Will
> 
> --->8
> 
> From 213bad7fdb8e4f45a7724be169cda292bbb50d2b Mon Sep 17 00:00:00 2001
> From: Will Deacon <will.deacon@arm.com>
> Date: Tue, 20 Dec 2016 12:12:49 +0000
> Subject: [PATCH] vring: Force use of DMA API for ARM-based systems with legacy
>  devices
> 
> Booting Linux on an ARM fastmodel containing an SMMU emulation results
> in an unexpected I/O page fault from the legacy virtio-blk PCI device:
> 
> [    1.211721] arm-smmu-v3 2b400000.smmu: event 0x10 received:
> [    1.211800] arm-smmu-v3 2b400000.smmu:	0x00000000fffff010
> [    1.211880] arm-smmu-v3 2b400000.smmu:	0x0000020800000000
> [    1.211959] arm-smmu-v3 2b400000.smmu:	0x00000008fa081002
> [    1.212075] arm-smmu-v3 2b400000.smmu:	0x0000000000000000
> [    1.212155] arm-smmu-v3 2b400000.smmu: event 0x10 received:
> [    1.212234] arm-smmu-v3 2b400000.smmu:	0x00000000fffff010
> [    1.212314] arm-smmu-v3 2b400000.smmu:	0x0000020800000000
> [    1.212394] arm-smmu-v3 2b400000.smmu:	0x00000008fa081000
> [    1.212471] arm-smmu-v3 2b400000.smmu:	0x0000000000000000
> 
> <system hangs failing to read partition table>
> 
> This is because the legacy virtio-blk device is behind an SMMU, so we
> have consequently swizzled its DMA ops and configured the SMMU to
> translate accesses. This then requires the vring code to use the DMA API
> to establish translations, otherwise all transactions will result in
> fatal faults and termination.
> 
> Given that ARM-based systems only see an SMMU if one is really present
> (the topology is all described by firmware tables such as device-tree or
> IORT), then we can safely use the DMA API for all legacy virtio devices.
> Modern devices can advertise the prescense of an IOMMU using the
> VIRTIO_F_IOMMU_PLATFORM feature flag.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 876945dbf649 ("arm64: Hook up IOMMU dma_ops")
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/virtio/virtio_ring.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 409aeaa49246..7e38ed79c3fc 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -159,6 +159,13 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	if (xen_domain())
>  		return true;
>  
> +	/*
> +	 * On ARM-based machines, the DMA ops will do the right thing,
> +	 * so always use them with legacy devices.
> +	 */
> +	if (IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_ARM64))
> +		return !virtio_has_feature(vdev, VIRTIO_F_VERSION_1);
> +
>  	return false;
>  }
>  
> 

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Any chance this fix (or anything with similar effects) gets applied
sometime soon? I cannot use the model without using a similar workaround:

http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=kvm-arm64/gicv4-wip&id=622ff1190890c0ae60d57e76a7c2f3e6fb27e25d

and I suspect that other users of the same system are carrying their own
version of the fix. Something in mainline would be infinitely better.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
