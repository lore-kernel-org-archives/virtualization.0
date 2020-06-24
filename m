From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Date: Wed, 24 Jun 2020 05:06:48 -0400
Message-ID: <20200624050355-mutt-send-email-mst@kernel.org>
References: <20200624091732.23944-1-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200624091732.23944-1-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Fan <peng.fan@nxp.com>
Cc: sstabellini@kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, konrad.wilk@oracle.com, jasowang@redhat.com, x86@kernel.org, xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-imx@nxp.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> Export xen_swiotlb for all platforms using xen swiotlb
> 
> Use xen_swiotlb to determine when vring should use dma APIs to map the
> ring: when xen_swiotlb is enabled the dma API is required. When it is
> disabled, it is not required.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
Xen was there first, but everyone else is using that now.


> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a2de775801af..768afd79f67a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -252,7 +252,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	 * the DMA API if we're a Xen guest, which at least allows
>  	 * all of the sensible Xen configurations to work correctly.
>  	 */
> -	if (xen_domain())
> +	if (xen_vring_use_dma())
>  		return true;
>  
>  	return false;


The comment above this should probably be fixed.

-- 
MST
