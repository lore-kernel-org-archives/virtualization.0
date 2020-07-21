From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio_ring: use alloc_pages_node for NUMA-aware
 allocation
Date: Tue, 21 Jul 2020 04:18:51 -0400
Message-ID: <20200721041550-mutt-send-email-mst@kernel.org>
References: <20200721070013.62894-1-shile.zhang@linux.alibaba.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200721070013.62894-1-shile.zhang@linux.alibaba.com>
Sender: linux-pci-owner@vger.kernel.org
To: Shile Zhang <shile.zhang@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, Jiang Liu <liuj97@gmail.com>, linux-pci@vger.kernel.org, bhelgaas@google.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 21, 2020 at 03:00:13PM +0800, Shile Zhang wrote:
> Use alloc_pages_node() allocate memory for vring queue with proper
> NUMA affinity.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Jiang Liu <liuj97@gmail.com>
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>

Do you observe any performance gains from this patch?

I also wonder why isn't the probe code run on the correct numa node?
That would fix a wide class of issues like this without need to tweak
drivers.

Bjorn, what do you think? Was this considered?

> ---
> Changelog
> v1 -> v2:
> - fixed compile warning reported by LKP.
> ---
>  drivers/virtio/virtio_ring.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 58b96baa8d48..d38fd6872c8c 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -276,9 +276,11 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
>  		return dma_alloc_coherent(vdev->dev.parent, size,
>  					  dma_handle, flag);
>  	} else {
> -		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
> -
> -		if (queue) {
> +		void *queue = NULL;
> +		struct page *page = alloc_pages_node(dev_to_node(vdev->dev.parent),
> +						     flag, get_order(size));
> +		if (page) {
> +			queue = page_address(page);
>  			phys_addr_t phys_addr = virt_to_phys(queue);
>  			*dma_handle = (dma_addr_t)phys_addr;
>  
> @@ -308,7 +310,7 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
>  	if (vring_use_dma_api(vdev))
>  		dma_free_coherent(vdev->dev.parent, size, queue, dma_handle);
>  	else
> -		free_pages_exact(queue, PAGE_ALIGN(size));
> +		free_pages((unsigned long)queue, get_order(size));
>  }
>  
>  /*
> -- 
> 2.24.0.rc2
