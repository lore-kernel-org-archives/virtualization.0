From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] virtio_mmio: Set DMA masks appropriately
Date: Tue, 10 Jan 2017 13:44:37 +0000
Message-ID: <c62753e7-2530-6e23-5a6c-77cf8bc92860__16949.0431122997$1484064078$gmane$org@arm.com>
References: <50defbbe87d75db85a9d22f914258975d661208a.1484051089.git.robin.murphy@arm.com>
	<2220292.9CN9cxzsPe@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2220292.9CN9cxzsPe@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: mst@redhat.com, will.deacon@arm.com, luto@kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/01/17 13:15, Arnd Bergmann wrote:
> On Tuesday, January 10, 2017 12:26:01 PM CET Robin Murphy wrote:
>> @@ -548,6 +550,14 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>>         if (vm_dev->version == 1)
>>                 writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
>>  
>> +       rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>> +       if (rc)
>> +               rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> 
> You don't seem to do anything different when 64-bit DMA is unsupported.
> How do you prevent the use of kernel buffers that are above the first 4G
> here?

That's the token "give up and rely on SWIOTLB/IOMMU" point, which as we
already know won't necessarily work very well (because it's already the
situation without this patch), but is still arguably better than
nothing. As I've just replied elsewhere, I personally hate this idiom,
but it's the done thing given the current DMA mask API.

>> +       else if (vm_dev->version == 1)
>> +               dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32 + PAGE_SHIFT));
> 
> Why is this limitation only for the coherent mask?

AIUI, the "32-bit pointers to pages" limitation of legacy virtio only
applies to the location of the vring itself, which is allocated via
dma_alloc_coherent - the descriptors themselves hold full 64-bit
addresses pointing at the actual data, which is mapped using streaming
DMA. It relies on the API guarantee that if we've managed to set a
64-bit streaming mask, then setting a smaller coherent mask cannot fail
(DMA-API-HOWTO.txt:257)

This is merely an amalgamation of the logic already in place for
virtio-pci, I just skimped on duplicating all the rationale (I know
there's a mail thread somewhere I could probably dig up).

Robin.
