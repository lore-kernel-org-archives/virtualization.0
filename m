From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH] vring: Force use of DMA API for ARM-based systems
Date: Tue, 10 Jan 2017 10:50:55 +0000
Message-ID: <8cb155ba-243d-80f6-4298-1c43266b3a5c__4520.30646051771$1484045341$gmane$org@arm.com>
References: <1482246864-16399-1-git-send-email-will.deacon@arm.com>
	<0b9a1f70-58fe-69c2-87db-d7773cb6a68c@arm.com>
	<cb98e455-bdee-19ab-8896-9123c6d12a26@arm.com>
	<CALCETrXMFHPxAx=ZTYLe9iKPNGfTPEEdis3mn3pphHYpD2h9+A@mail.gmail.com>
	<fbf1a09a-bdb2-504a-f4a7-56fa54b6292b@arm.com>
	<20170109145437.GF21398@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170109145437.GF21398@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On 09/01/17 14:54, Will Deacon wrote:
> On Mon, Jan 09, 2017 at 11:24:04AM +0000, Robin Murphy wrote:
>> On 06/01/17 21:51, Andy Lutomirski wrote:
>>> On Fri, Jan 6, 2017 at 10:32 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>>>> On 06/01/17 17:48, Jean-Philippe Brucker wrote:
>>>>> It used to work with 4.9, but since 9491ae4 ("mm: don't cap request size
>>>>> based on read-ahead setting") unlocked read-ahead, we quickly run into
>>>>> the limit of swiotlb and panic:
>>>>>
>>>>> [    5.382359] virtio-mmio 1c130000.virtio_block: swiotlb buffer is full
>>>>> (sz: 491520 bytes)
>>>>> [    5.382452] virtio-mmio 1c130000.virtio_block: DMA: Out of SW-IOMMU
>>>>> space for 491520 bytes
>>>>> [    5.382531] Kernel panic - not syncing: DMA: Random memory could be
>>>>> DMA written
>>>>> ...
>>>>> [    5.383148] [<ffff0000083ad754>] swiotlb_map_page+0x194/0x1a0
>>>>> [    5.383226] [<ffff000008096bb8>] __swiotlb_map_page+0x20/0x88
>>>>> [    5.383320] [<ffff0000084bf738>] vring_map_one_sg.isra.1+0x70/0x88
>>>>> [    5.383417] [<ffff0000084c04fc>] virtqueue_add_sgs+0x2ec/0x4e8
>>>>> [    5.383505] [<ffff00000856d99c>] __virtblk_add_req+0x9c/0x1a8
>>>>> ...
>>>>> [    5.384449] [<ffff0000081829c4>] ondemand_readahead+0xfc/0x2b8
>>>>>
>>>>> Commit 9491ae4 caps the read-ahead request to a limit set by the backing
>>>>> device. For virtio-blk, it is infinite (as set by the call to
>>>>> blk_queue_max_hw_sectors in virtblk_probe).
>>>>>
>>>>> I'm not sure how to fix this. Setting an arbitrary sector limit in the
>>>>> virtio-blk driver seems unfair to other users. Maybe we should check if
>>>>> the device is behind a hardware IOMMU before using the DMA API?
>>>>
>>>> Hmm, this looks more like the virtio_block device simply has the wrong
>>>> DMA mask to begin with. For virtio-pci we set the streaming DMA mask to
>>>> 64 bits - should a platform device not be similarly capable?
>>>
>>> If it's not, then turning off DMA API will cause random corruption.
>>> ISTM one way or another the bug is in either the DMA ops or in the
>>> driver initialization.
>>
>> OK, having looked a little deeper, I reckon virtio_mmio_probe() is
>> indeed missing a dma_set_mask() call compared to its PCI friends. The
>> only question then is where does virtio-mmio stand with respect to
>> legacy/modern/44-bit/64-bit etc.?
> 
> Legacy virtio-mmio has a variable page granule (GuestPageSize), so the
> 44-bit limitation shouldn't apply. The legacy spec doesn't actually
> initialise GuestPageSize in the example initialisation sequence, but
> Linux does. Non-legacy uses absolute, 64-bit addresses regardless of
> transport, so yes, it might be as simple as adding:
> 
> 	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> 
> to virtio_mmio_probe. Jean-Philippe -- does that fix things for you?

Yes, setting the DMA mask to 64 bits seems to fix my issue.

Thank,
Jean-Philippe
