From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 4/5] virtio: Introduce virtio_max_dma_size()
Date: Wed, 30 Jan 2019 15:10:29 +0000
Message-ID: <e138b703-188c-59d2-edec-65fe3e76d229__22302.6204084576$1548873320$gmane$org@amd.com>
References: <20190129084342.26030-1-joro@8bytes.org>
	<20190129084342.26030-5-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190129084342.26030-5-joro@8bytes.org>
Content-Language: en-US
Content-ID: <DBE9E75945572C4BBDAC4F17E791DBD8@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joerg Roedel <joro@8bytes.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "jroedel@suse.de" <jroedel@suse.de>, "Singh,
	Brijesh" <brijesh.singh@amd.com>, "Grimm,
	Jon" <Jon.Grimm@amd.com>, "jfehlig@suse.com" <jfehlig@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 1/29/19 2:43 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> This function returns the maximum segment size for a single
> dma transaction of a virtio device. The possible limit comes
> from the SWIOTLB implementation in the Linux kernel, that
> has an upper limit of (currently) 256kb of contiguous
> memory it can map. Other DMA-API implementations might also
> have limits.
> 
> Use the new dma_max_mapping_size() function to determine the
> maximum mapping size when DMA-API is in use for virtio.
> 
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/virtio/virtio_ring.c | 10 ++++++++++
>  include/linux/virtio.h       |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cd7e755484e3..9ca3fe6af9fa 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -266,6 +266,16 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	return false;
>  }
>  
> +size_t virtio_max_dma_size(struct virtio_device *vdev)
> +{
> +	size_t max_segment_size = SIZE_MAX;
> +
> +	if (vring_use_dma_api(vdev))
> +		max_segment_size = dma_max_mapping_size(&vdev->dev);
> +
> +	return max_segment_size;
> +}

When I build with these patches and with the virtio devices as modules I
get a build failure. Looks like this needs an EXPORT_SYMBOL_GPL().

Thanks,
Tom

> +
>  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
>  			      dma_addr_t *dma_handle, gfp_t flag)
>  {
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index fa1b5da2804e..673fe3ef3607 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -157,6 +157,8 @@ int virtio_device_freeze(struct virtio_device *dev);
>  int virtio_device_restore(struct virtio_device *dev);
>  #endif
>  
> +size_t virtio_max_dma_size(struct virtio_device *vdev);
> +
>  #define virtio_device_for_each_vq(vdev, vq) \
>  	list_for_each_entry(vq, &vdev->vqs, list)
>  
> 
