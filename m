From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC 1/4] virtio: Define virtio_direct_dma_ops structure
Date: Tue, 31 Jul 2018 09:31:33 +0530
Message-ID: <fd5738a9-163c-f1ab-c646-12b6367eeded__10458.3623506644$1533009587$gmane$org@linux.vnet.ibm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180720035941.6844-2-khandual@linux.vnet.ibm.com>
	<20180730092419.GA26245@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180730092419.GA26245@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mst@redhat.com, benh@kernel.crashing.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, paulus@samba.org, mpe@ellerman.id.au, joe@perches.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

On 07/30/2018 02:54 PM, Christoph Hellwig wrote:
>> +/*
>> + * Virtio direct mapping DMA API operations structure
>> + *
>> + * This defines DMA API structure for all virtio devices which would not
>> + * either bring in their own DMA OPS from architecture or they would not
>> + * like to use architecture specific IOMMU based DMA OPS because QEMU
>> + * expects GPA instead of an IOVA in absence of VIRTIO_F_IOMMU_PLATFORM.
>> + */
>> +dma_addr_t virtio_direct_map_page(struct device *dev, struct page *page,
>> +			    unsigned long offset, size_t size,
>> +			    enum dma_data_direction dir,
>> +			    unsigned long attrs)
> 
> All these functions should probably be marked static.

Sure.

> 
>> +void virtio_direct_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>> +			size_t size, enum dma_data_direction dir,
>> +			unsigned long attrs)
>> +{
>> +}
> 
> No need to implement no-op callbacks in struct dma_map_ops.

Okay.

> 
>> +
>> +int virtio_direct_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
>> +{
>> +	return 0;
>> +}
> 
> Including this one.
> 
>> +void *virtio_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>> +		gfp_t gfp, unsigned long attrs)
>> +{
>> +	void *queue = alloc_pages_exact(PAGE_ALIGN(size), gfp);
>> +
>> +	if (queue) {
>> +		phys_addr_t phys_addr = virt_to_phys(queue);
>> +		*dma_handle = (dma_addr_t)phys_addr;
>> +
>> +		if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
>> +			free_pages_exact(queue, PAGE_ALIGN(size));
>> +			return NULL;
>> +		}
>> +	}
>> +	return queue;
> 
> queue is a very odd name in a generic memory allocator.

Will change it to addr.

> 
>> +void virtio_direct_free(struct device *dev, size_t size, void *vaddr,
>> +		dma_addr_t dma_addr, unsigned long attrs)
>> +{
>> +	free_pages_exact(vaddr, PAGE_ALIGN(size));
>> +}
>> +
>> +const struct dma_map_ops virtio_direct_dma_ops = {
>> +	.alloc			= virtio_direct_alloc,
>> +	.free			= virtio_direct_free,
>> +	.map_page		= virtio_direct_map_page,
>> +	.unmap_page		= virtio_direct_unmap_page,
>> +	.mapping_error		= virtio_direct_mapping_error,
>> +};
> 
> This is missing a dma_map_sg implementation.  In general this is
> mandatory for dma_ops.  So either you implement it or explain in
> a common why you think you can skip it.

Hmm. IIUC virtio core never used dma_map_sg(). Am I missing something
here ? The only reference to dma_map_sg() is inside a comment.

$git grep dma_map_sg drivers/virtio/
drivers/virtio/virtio_ring.c:    * We can't use dma_map_sg, because we don't use scatterlists in

> 
>> +EXPORT_SYMBOL(virtio_direct_dma_ops);
> 
> EXPORT_SYMBOL_GPL like all virtio symbols, please.

I am planning to drop EXPORT_SYMBOL from virtio_direct_dma_ops structure.
