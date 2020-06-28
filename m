From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 2/2] virtio: virtio_has_iommu_quirk ->
 virtio_has_dma_quirk
Date: Sun, 28 Jun 2020 14:21:17 +0800
Message-ID: <95941961-1c75-e2a5-d49b-7d7e204b7a41@redhat.com>
References: <20200624232035.704217-1-mst@redhat.com>
 <20200624232035.704217-3-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200624232035.704217-3-mst@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/6/25 上午7:21, Michael S. Tsirkin wrote:
> Now that the corresponding feature bit has been renamed,
> rename the quirk too - it's about special ways to
> do DMA, not necessarily about the IOMMU.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/gpu/drm/virtio/virtgpu_object.c | 2 +-
>   drivers/gpu/drm/virtio/virtgpu_vq.c     | 4 ++--
>   drivers/virtio/virtio_ring.c            | 2 +-
>   include/linux/virtio_config.h           | 4 ++--
>   tools/virtio/linux/virtio_config.h      | 4 ++--
>   5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 6ccbd01cd888..e8799ab0c753 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -141,7 +141,7 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>   					struct virtio_gpu_mem_entry **ents,
>   					unsigned int *nents)
>   {
> -	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
> +	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>   	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
>   	struct scatterlist *sg;
>   	int si, ret;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 9e663a5d9952..53af60d484a4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -599,7 +599,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>   	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
>   	struct virtio_gpu_transfer_to_host_2d *cmd_p;
>   	struct virtio_gpu_vbuffer *vbuf;
> -	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
> +	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>   	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
>   
>   	if (use_dma_api)
> @@ -1015,7 +1015,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
>   	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
>   	struct virtio_gpu_transfer_host_3d *cmd_p;
>   	struct virtio_gpu_vbuffer *vbuf;
> -	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
> +	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>   	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
>   
>   	if (use_dma_api)
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a1a5c2a91426..34253cb69cb8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -240,7 +240,7 @@ static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
>   
>   static bool vring_use_dma_api(struct virtio_device *vdev)
>   {
> -	if (!virtio_has_iommu_quirk(vdev))
> +	if (!virtio_has_dma_quirk(vdev))
>   		return true;
>   
>   	/* Otherwise, we are left to guess. */
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index f2cc2a0df174..3b4eae5ac5e3 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -162,10 +162,10 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
>   }
>   
>   /**
> - * virtio_has_iommu_quirk - determine whether this device has the iommu quirk
> + * virtio_has_dma_quirk - determine whether this device has the DMA quirk
>    * @vdev: the device
>    */
> -static inline bool virtio_has_iommu_quirk(const struct virtio_device *vdev)
> +static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
>   {
>   	/*
>   	 * Note the reverse polarity of the quirk feature (compared to most
> diff --git a/tools/virtio/linux/virtio_config.h b/tools/virtio/linux/virtio_config.h
> index f99ae42668e0..f2640e505c4e 100644
> --- a/tools/virtio/linux/virtio_config.h
> +++ b/tools/virtio/linux/virtio_config.h
> @@ -42,10 +42,10 @@ static inline void __virtio_clear_bit(struct virtio_device *vdev,
>   	(__virtio_test_bit((dev), feature))
>   
>   /**
> - * virtio_has_iommu_quirk - determine whether this device has the iommu quirk
> + * virtio_has_dma_quirk - determine whether this device has the DMA quirk
>    * @vdev: the device
>    */
> -static inline bool virtio_has_iommu_quirk(const struct virtio_device *vdev)
> +static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
>   {
>   	/*
>   	 * Note the reverse polarity of the quirk feature (compared to most


Acked-by: Jason Wang <jasowang@redhat.com>
