From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 08/12] drm/virtio: rework virtio_gpu_object_create
	fencing
Date: Tue, 18 Jun 2019 16:24:23 +0200
Message-ID: <20190618142423.GE12905__46586.1441729189$1560867879$gmane$org@phenom.ffwll.local>
References: <20190618135821.8644-1-kraxel@redhat.com>
	<20190618135821.8644-9-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190618135821.8644-9-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 18, 2019 at 03:58:16PM +0200, Gerd Hoffmann wrote:
> Use gem reservation helpers and direct reservation_object_* calls
> instead of ttm.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 28 +++++++------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 82bfbf983fd2..461f15f26517 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -141,34 +141,22 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  
>  	if (fence) {
>  		struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
> -		struct list_head validate_list;
> -		struct ttm_validate_buffer mainbuf;
> +		struct drm_gem_object *obj = &bo->gem_base;
>  		struct ww_acquire_ctx ticket;
>  		unsigned long irq_flags;
> -		bool signaled;
>  
> -		INIT_LIST_HEAD(&validate_list);
> -		memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
> -
> -		/* use a gem reference since unref list undoes them */
> -		drm_gem_object_get(&bo->gem_base);
> -		mainbuf.bo = &bo->tbo;
> -		list_add(&mainbuf.head, &validate_list);
> -
> -		ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
> +		drm_gem_object_get(obj);
> +		ret = drm_gem_lock_reservations(&obj, 1, &ticket);
>  		if (ret == 0) {
>  			spin_lock_irqsave(&drv->lock, irq_flags);
> -			signaled = virtio_fence_signaled(&fence->f);
> -			if (!signaled)
> +			if (!virtio_fence_signaled(&fence->f))
>  				/* virtio create command still in flight */
> -				ttm_eu_fence_buffer_objects(&ticket, &validate_list,
> -							    &fence->f);

Same issue with the refcounting gone wrong here as in the previous patch.
-Daniel

> +				reservation_object_add_excl_fence(obj->resv,
> +								  &fence->f);
>  			spin_unlock_irqrestore(&drv->lock, irq_flags);
> -			if (signaled)
> -				/* virtio create command finished */
> -				ttm_eu_backoff_reservation(&ticket, &validate_list);
>  		}
> -		virtio_gpu_unref_list(&validate_list);
> +		drm_gem_unlock_reservations(&obj, 1, &ticket);
> +		drm_gem_object_put_unlocked(obj);
>  	}
>  
>  	*bo_ptr = bo;
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
