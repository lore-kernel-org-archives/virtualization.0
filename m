From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
Date: Mon, 22 Jul 2019 11:33:35 -0400
Message-ID: <20190722112704-mutt-send-email-mst__2819.45291660435$1563809654$gmane$org@kernel.org>
References: <20190722145509.1284-1-eric.auger@redhat.com>
	<20190722145509.1284-3-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190722145509.1284-3-eric.auger@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Auger <eric.auger@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com, robin.murphy@arm.com, hch@lst.de, m.szyprowski@samsung.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 22, 2019 at 04:55:09PM +0200, Eric Auger wrote:
> Do not call dma_max_mapping_size for devices that have no DMA
> mask set, otherwise we can hit a NULL pointer dereference.
> 
> This occurs when a virtio-blk-pci device is protected with
> a virtual IOMMU.
> 
> Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Christoph Hellwig <hch@lst.de>

Christoph, I wonder why did you suggest this?
The connection between dma_mask and dma_max_mapping_size
is far from obvious.  The documentation doesn't exist.
Do we really have to teach all users about this hack?
Why not just make dma_max_mapping_size DTRT?

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c8be1c4f5b55..37c143971211 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -262,7 +262,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
>  {
>  	size_t max_segment_size = SIZE_MAX;
>  
> -	if (vring_use_dma_api(vdev))
> +	if (vring_use_dma_api(vdev) && vdev->dev.dma_mask)
>  		max_segment_size = dma_max_mapping_size(&vdev->dev);
>  
>  	return max_segment_size;
> -- 
> 2.20.1
