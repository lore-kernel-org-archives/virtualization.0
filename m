From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio_pci: Limit DMA mask to 44 bits for legacy
	virtio devices
Date: Wed, 14 Sep 2016 15:42:25 +0300
Message-ID: <20160914154034-mutt-send-email-mst@kernel.org>
References: <1473851788-31504-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1473851788-31504-1-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 14, 2016 at 12:16:28PM +0100, Will Deacon wrote:
> Legacy virtio defines the virtqueue base using a 32-bit PFN field, with
> a read-only register indicating a fixed page size of 4k.
> 
> This can cause problems for DMA allocators that allocate top down from
> the DMA mask, which is set to 64 bits. In this case, the addresses are
> silently truncated to 44-bit, leading to IOMMU faults, failure to read
> from the queue or data corruption.
> 
> This patch restricts the DMA mask for legacy PCI virtio devices to
> 44 bits, which matches the specification.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Benjamin Serebrin <serebrin@google.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/virtio/virtio_pci_legacy.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 8c4e61783441..efb3f5dff4b7 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -212,12 +212,17 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
>  		return -ENODEV;
>  	}
>  
> -	rc = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
> +	/*
> +	 * The virtio ring base address is expressed as a 32-bit PFN, with a
> +	 * page size of 1 << VIRTIO_PCI_QUEUE_ADDR_SHIFT.
> +	 */
> +	rc = dma_set_mask_and_coherent(&pci_dev->dev,
> +				DMA_BIT_MASK(32 + VIRTIO_PCI_QUEUE_ADDR_SHIFT));

So why not limit just the coherent mask, as I suggested in a comment on v1?

>  	if (rc)
>  		rc = dma_set_mask_and_coherent(&pci_dev->dev,
>  						DMA_BIT_MASK(32));
>  	if (rc)
> -		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> +		dev_warn(&pci_dev->dev, "Failed to enable %d-bit or 32-bit DMA.  Trying to continue, but this might not work.\n", 32 + VIRTIO_PCI_QUEUE_ADDR_SHIFT);


I'd rather we split this.

>  
>  	rc = pci_request_region(pci_dev, 0, "virtio-pci-legacy");
>  	if (rc)
> -- 
> 2.1.4
