From: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v5] drm/virtio: use virtio_max_dma_size
Date: Thu, 22 Aug 2019 13:33:37 +0200
Message-ID: <2e6eba7b-5f46-e9e8-f6b2-3e80e95754e9@redhat.com>
References: <20190821111210.27165-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190821111210.27165-1-kraxel@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 08/21/19 13:12, Gerd Hoffmann wrote:
> We must make sure our scatterlist segments are not too big, otherwise
> we might see swiotlb failures (happens with sev, also reproducable with
> swiotlb=force).
> 
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index b2da31310d24..09b526518f5a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -204,6 +204,7 @@ int virtio_gpu_object_get_sg_table(struct virtio_gpu_device *qdev,
>  		.interruptible = false,
>  		.no_wait_gpu = false
>  	};
> +	size_t max_segment;
>  
>  	/* wtf swapping */
>  	if (bo->pages)
> @@ -215,8 +216,13 @@ int virtio_gpu_object_get_sg_table(struct virtio_gpu_device *qdev,
>  	if (!bo->pages)
>  		goto out;
>  
> -	ret = sg_alloc_table_from_pages(bo->pages, pages, nr_pages, 0,
> -					nr_pages << PAGE_SHIFT, GFP_KERNEL);
> +	max_segment = virtio_max_dma_size(qdev->vdev);
> +	max_segment &= PAGE_MASK;
> +	if (max_segment > SCATTERLIST_MAX_SEGMENT)
> +		max_segment = SCATTERLIST_MAX_SEGMENT;
> +	ret = __sg_alloc_table_from_pages(bo->pages, pages, nr_pages, 0,
> +					  nr_pages << PAGE_SHIFT,
> +					  max_segment, GFP_KERNEL);
>  	if (ret)
>  		goto out;
>  	return 0;
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo
