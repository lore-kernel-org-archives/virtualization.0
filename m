From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm: virtio: use kmem_cache
Date: Wed, 1 Mar 2017 16:00:27 +0100
Message-ID: <20170301150027.6nbakw5frva7tbqv__17901.336894329$1488380442$gmane$org@phenom.ffwll.local>
References: <1488377348-5006-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1488377348-5006-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 01, 2017 at 03:09:08PM +0100, Gerd Hoffmann wrote:
> Just use kmem_cache instead of rolling
> our own, limited implementation.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Looks very reasonable.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h |  4 +--
>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 57 +++++++-----------------------------
>  2 files changed, 11 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 2f76673..4e66e35 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -178,9 +178,7 @@ struct virtio_gpu_device {
>  
>  	struct virtio_gpu_queue ctrlq;
>  	struct virtio_gpu_queue cursorq;
> -	struct list_head free_vbufs;
> -	spinlock_t free_vbufs_lock;
> -	void *vbufs;
> +	struct kmem_cache *vbufs;
>  	bool vqs_ready;
>  
>  	struct idr	resource_idr;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 43ea0dc..472e349 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -74,51 +74,19 @@ void virtio_gpu_cursor_ack(struct virtqueue *vq)
>  
>  int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev)
>  {
> -	struct virtio_gpu_vbuffer *vbuf;
> -	int i, size, count = 16;
> -	void *ptr;
> -
> -	INIT_LIST_HEAD(&vgdev->free_vbufs);
> -	spin_lock_init(&vgdev->free_vbufs_lock);
> -	count += virtqueue_get_vring_size(vgdev->ctrlq.vq);
> -	count += virtqueue_get_vring_size(vgdev->cursorq.vq);
> -	size = count * VBUFFER_SIZE;
> -	DRM_INFO("virtio vbuffers: %d bufs, %zdB each, %dkB total.\n",
> -		 count, VBUFFER_SIZE, size / 1024);
> -
> -	vgdev->vbufs = kzalloc(size, GFP_KERNEL);
> +	vgdev->vbufs = kmem_cache_create("virtio-gpu-vbufs",
> +					 VBUFFER_SIZE,
> +					 __alignof__(struct virtio_gpu_vbuffer),
> +					 0, NULL);
>  	if (!vgdev->vbufs)
>  		return -ENOMEM;
> -
> -	for (i = 0, ptr = vgdev->vbufs;
> -	     i < count;
> -	     i++, ptr += VBUFFER_SIZE) {
> -		vbuf = ptr;
> -		list_add(&vbuf->list, &vgdev->free_vbufs);
> -	}
>  	return 0;
>  }
>  
>  void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev)
>  {
> -	struct virtio_gpu_vbuffer *vbuf;
> -	int i, count = 0;
> -
> -	count += virtqueue_get_vring_size(vgdev->ctrlq.vq);
> -	count += virtqueue_get_vring_size(vgdev->cursorq.vq);
> -
> -	spin_lock(&vgdev->free_vbufs_lock);
> -	for (i = 0; i < count; i++) {
> -		if (WARN_ON(list_empty(&vgdev->free_vbufs))) {
> -			spin_unlock(&vgdev->free_vbufs_lock);
> -			return;
> -		}
> -		vbuf = list_first_entry(&vgdev->free_vbufs,
> -					struct virtio_gpu_vbuffer, list);
> -		list_del(&vbuf->list);
> -	}
> -	spin_unlock(&vgdev->free_vbufs_lock);
> -	kfree(vgdev->vbufs);
> +	kmem_cache_destroy(vgdev->vbufs);
> +	vgdev->vbufs = NULL;
>  }
>  
>  static struct virtio_gpu_vbuffer*
> @@ -128,12 +96,9 @@ void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev)
>  {
>  	struct virtio_gpu_vbuffer *vbuf;
>  
> -	spin_lock(&vgdev->free_vbufs_lock);
> -	BUG_ON(list_empty(&vgdev->free_vbufs));
> -	vbuf = list_first_entry(&vgdev->free_vbufs,
> -				struct virtio_gpu_vbuffer, list);
> -	list_del(&vbuf->list);
> -	spin_unlock(&vgdev->free_vbufs_lock);
> +	vbuf = kmem_cache_alloc(vgdev->vbufs, GFP_KERNEL);
> +	if (IS_ERR(vbuf))
> +		return ERR_CAST(vbuf);
>  	memset(vbuf, 0, VBUFFER_SIZE);
>  
>  	BUG_ON(size > MAX_INLINE_CMD_SIZE);
> @@ -208,9 +173,7 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
>  	if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
>  		kfree(vbuf->resp_buf);
>  	kfree(vbuf->data_buf);
> -	spin_lock(&vgdev->free_vbufs_lock);
> -	list_add(&vbuf->list, &vgdev->free_vbufs);
> -	spin_unlock(&vgdev->free_vbufs_lock);
> +	kmem_cache_free(vgdev->vbufs, vbuf);
>  }
>  
>  static void reclaim_vbufs(struct virtqueue *vq, struct list_head *reclaim_list)
> -- 
> 1.8.3.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
