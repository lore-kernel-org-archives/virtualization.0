From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 2/2] vring: Force use of DMA API for ARM-based systems
Date: Tue, 24 Jan 2017 16:10:08 +0000
Message-ID: <0dd38b20-33fe-f912-cf1b-8328c53734a5__23838.7122670703$1485277095$gmane$org@arm.com>
References: <20170113172154.GL3253@arm.com>
	<20170113201933-mutt-send-email-mst@kernel.org>
	<20170116104028.GA1510@arm.com>
	<20170116161639-mutt-send-email-mst@kernel.org>
	<20170116142103.GF1510@arm.com>
	<20170116162225-mutt-send-email-mst@kernel.org>
	<20170116143408.GG1510@arm.com>
	<20170119234852-mutt-send-email-mst@kernel.org>
	<20170120103332.GA1277@arm.com>
	<5ad8ce42-a469-7417-d2c5-58cc0da89e8d@arm.com>
	<20170124180542-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170124180542-mutt-send-email-mst@kernel.org>
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
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, luto@kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 24/01/17 16:06, Michael S. Tsirkin wrote:
> On Tue, Jan 24, 2017 at 04:04:11PM +0000, Marc Zyngier wrote:
>> On 20/01/17 10:33, Will Deacon wrote:
>>> From 213bad7fdb8e4f45a7724be169cda292bbb50d2b Mon Sep 17 00:00:00 2001
>>> From: Will Deacon <will.deacon@arm.com>
>>> Date: Tue, 20 Dec 2016 12:12:49 +0000
>>> Subject: [PATCH] vring: Force use of DMA API for ARM-based systems with legacy
>>>  devices
>>>
>>> Booting Linux on an ARM fastmodel containing an SMMU emulation results
>>> in an unexpected I/O page fault from the legacy virtio-blk PCI device:
>>>
>>> [    1.211721] arm-smmu-v3 2b400000.smmu: event 0x10 received:
>>> [    1.211800] arm-smmu-v3 2b400000.smmu:	0x00000000fffff010
>>> [    1.211880] arm-smmu-v3 2b400000.smmu:	0x0000020800000000
>>> [    1.211959] arm-smmu-v3 2b400000.smmu:	0x00000008fa081002
>>> [    1.212075] arm-smmu-v3 2b400000.smmu:	0x0000000000000000
>>> [    1.212155] arm-smmu-v3 2b400000.smmu: event 0x10 received:
>>> [    1.212234] arm-smmu-v3 2b400000.smmu:	0x00000000fffff010
>>> [    1.212314] arm-smmu-v3 2b400000.smmu:	0x0000020800000000
>>> [    1.212394] arm-smmu-v3 2b400000.smmu:	0x00000008fa081000
>>> [    1.212471] arm-smmu-v3 2b400000.smmu:	0x0000000000000000
>>>
>>> <system hangs failing to read partition table>
>>>
>>> This is because the legacy virtio-blk device is behind an SMMU, so we
>>> have consequently swizzled its DMA ops and configured the SMMU to
>>> translate accesses. This then requires the vring code to use the DMA API
>>> to establish translations, otherwise all transactions will result in
>>> fatal faults and termination.
>>>
>>> Given that ARM-based systems only see an SMMU if one is really present
>>> (the topology is all described by firmware tables such as device-tree or
>>> IORT), then we can safely use the DMA API for all legacy virtio devices.
>>> Modern devices can advertise the prescense of an IOMMU using the
>>> VIRTIO_F_IOMMU_PLATFORM feature flag.
>>>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Cc: <stable@vger.kernel.org>
>>> Fixes: 876945dbf649 ("arm64: Hook up IOMMU dma_ops")
>>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>>> ---
>>>  drivers/virtio/virtio_ring.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>> index 409aeaa49246..7e38ed79c3fc 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -159,6 +159,13 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>>>  	if (xen_domain())
>>>  		return true;
>>>  
>>> +	/*
>>> +	 * On ARM-based machines, the DMA ops will do the right thing,
>>> +	 * so always use them with legacy devices.
>>> +	 */
>>> +	if (IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_ARM64))
>>> +		return !virtio_has_feature(vdev, VIRTIO_F_VERSION_1);
>>> +
>>>  	return false;
>>>  }
>>>  
>>>
>>
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Any chance this fix (or anything with similar effects) gets applied
>> sometime soon? I cannot use the model without using a similar
>> workaround:
>>
>> http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/?h=kvm-arm64/gicv4-wip&id=622ff1190890c0ae60d57e76a7c2f3e6fb27e25d
>>
>> and I suspect that other users of the same system are carrying their own
>> version of the fix. Something in mainline would be infinitely better.
>>
>> Thanks,
>>
>> 	M.
> 
> I'll merge this in the next pull.

Awesome, thanks a lot.

	M.
-- 
Jazz is not dead. It just smells funny...
