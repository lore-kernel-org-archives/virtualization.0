From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 1/4] virtio: Define virtio_direct_dma_ops structure
Date: Mon, 30 Jul 2018 02:24:19 -0700
Message-ID: <20180730092419.GA26245@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180720035941.6844-2-khandual@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180720035941.6844-2-khandual@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mst@redhat.com, benh@kernel.crashing.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, paulus@samba.org, mpe@ellerman.id.au, joe@perches.com, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

> +/*
> + * Virtio direct mapping DMA API operations structure
> + *
> + * This defines DMA API structure for all virtio devices which would not
> + * either bring in their own DMA OPS from architecture or they would not
> + * like to use architecture specific IOMMU based DMA OPS because QEMU
> + * expects GPA instead of an IOVA in absence of VIRTIO_F_IOMMU_PLATFORM.
> + */
> +dma_addr_t virtio_direct_map_page(struct device *dev, struct page *page,
> +			    unsigned long offset, size_t size,
> +			    enum dma_data_direction dir,
> +			    unsigned long attrs)

All these functions should probably be marked static.

> +void virtio_direct_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
> +			size_t size, enum dma_data_direction dir,
> +			unsigned long attrs)
> +{
> +}

No need to implement no-op callbacks in struct dma_map_ops.

> +
> +int virtio_direct_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
> +{
> +	return 0;
> +}

Including this one.

> +void *virtio_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		gfp_t gfp, unsigned long attrs)
> +{
> +	void *queue = alloc_pages_exact(PAGE_ALIGN(size), gfp);
> +
> +	if (queue) {
> +		phys_addr_t phys_addr = virt_to_phys(queue);
> +		*dma_handle = (dma_addr_t)phys_addr;
> +
> +		if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
> +			free_pages_exact(queue, PAGE_ALIGN(size));
> +			return NULL;
> +		}
> +	}
> +	return queue;

queue is a very odd name in a generic memory allocator.

> +void virtio_direct_free(struct device *dev, size_t size, void *vaddr,
> +		dma_addr_t dma_addr, unsigned long attrs)
> +{
> +	free_pages_exact(vaddr, PAGE_ALIGN(size));
> +}
> +
> +const struct dma_map_ops virtio_direct_dma_ops = {
> +	.alloc			= virtio_direct_alloc,
> +	.free			= virtio_direct_free,
> +	.map_page		= virtio_direct_map_page,
> +	.unmap_page		= virtio_direct_unmap_page,
> +	.mapping_error		= virtio_direct_mapping_error,
> +};

This is missing a dma_map_sg implementation.  In general this is
mandatory for dma_ops.  So either you implement it or explain in
a common why you think you can skip it.

> +EXPORT_SYMBOL(virtio_direct_dma_ops);

EXPORT_SYMBOL_GPL like all virtio symbols, please.
