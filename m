From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
Date: Mon, 22 Jul 2019 16:36:09 +0100
Message-ID: <e4a288f2-a93a-5ce4-32da-f5434302551f__48780.5329541274$1563809794$gmane$org@arm.com>
References: <20190722145509.1284-1-eric.auger@redhat.com>
	<20190722145509.1284-3-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190722145509.1284-3-eric.auger@redhat.com>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, hch@lst.de, m.szyprowski@samsung.com, mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 22/07/2019 15:55, Eric Auger wrote:
> Do not call dma_max_mapping_size for devices that have no DMA
> mask set, otherwise we can hit a NULL pointer dereference.
> 
> This occurs when a virtio-blk-pci device is protected with
> a virtual IOMMU.
> 
> Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/virtio/virtio_ring.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c8be1c4f5b55..37c143971211 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -262,7 +262,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
>   {
>   	size_t max_segment_size = SIZE_MAX;
>   
> -	if (vring_use_dma_api(vdev))
> +	if (vring_use_dma_api(vdev) && vdev->dev.dma_mask)

Hmm, might it make sense to roll that check up into vring_use_dma_api() 
itself? After all, if the device has no mask then it's likely that other 
DMA API ops wouldn't really work as expected either.

Robin.

>   		max_segment_size = dma_max_mapping_size(&vdev->dev);
>   
>   	return max_segment_size;
> 
