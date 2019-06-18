From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 07/12] drm/virtio: rework virtio_gpu_execbuffer_ioctl
	fencing
Date: Tue, 18 Jun 2019 16:16:04 +0200
Message-ID: <20190618141604.GC12905__14323.6877907597$1560867378$gmane$org@phenom.ffwll.local>
References: <20190618135821.8644-1-kraxel@redhat.com>
	<20190618135821.8644-8-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190618135821.8644-8-kraxel@redhat.com>
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

On Tue, Jun 18, 2019 at 03:58:15PM +0200, Gerd Hoffmann wrote:
> Use gem reservation helpers and direct reservation_object_* calls
> instead of ttm.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 36 ++++++++++++--------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 5cffd2e54c04..6db6a6e92dde 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -107,12 +107,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>  	struct virtio_gpu_fpriv *vfpriv = drm_file->driver_priv;
>  	struct drm_gem_object *gobj;
>  	struct virtio_gpu_fence *out_fence;
> -	struct virtio_gpu_object *qobj;
>  	int ret;
>  	uint32_t *bo_handles = NULL;
>  	void __user *user_bo_handles = NULL;
>  	struct list_head validate_list;
> -	struct ttm_validate_buffer *buflist = NULL;
> +	struct drm_gem_object **buflist = NULL;
>  	int i;
>  	struct ww_acquire_ctx ticket;
>  	struct sync_file *sync_file;
> @@ -157,12 +156,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>  
>  	INIT_LIST_HEAD(&validate_list);
>  	if (exbuf->num_bo_handles) {
> -
>  		bo_handles = kvmalloc_array(exbuf->num_bo_handles,
> -					   sizeof(uint32_t), GFP_KERNEL);
> +					    sizeof(uint32_t), GFP_KERNEL);
>  		buflist = kvmalloc_array(exbuf->num_bo_handles,
> -					   sizeof(struct ttm_validate_buffer),
> -					   GFP_KERNEL | __GFP_ZERO);
> +					 sizeof(struct drm_gem_object*),
> +					 GFP_KERNEL | __GFP_ZERO);
>  		if (!bo_handles || !buflist) {
>  			ret = -ENOMEM;
>  			goto out_unused_fd;
> @@ -181,19 +179,15 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>  				ret = -ENOENT;
>  				goto out_unused_fd;
>  			}
> -
> -			qobj = gem_to_virtio_gpu_obj(gobj);
> -			buflist[i].bo = &qobj->tbo;
> -
> -			list_add(&buflist[i].head, &validate_list);
> +			buflist[i] = gobj;

I didn't bother looking, but I guess there's some room for a
array-of-gem-id to gem_bo-pointers helper function? Would only make sense
if we can share it with panfrost/v3d maybe.

>  		}
>  		kvfree(bo_handles);
>  		bo_handles = NULL;
>  	}
>  
> -	ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
> +	ret = drm_gem_lock_reservations(buflist, exbuf->num_bo_handles, &ticket);
>  	if (ret)
> -		goto out_free;
> +		goto out_unused_fd;
>  
>  	buf = memdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
>  	if (IS_ERR(buf)) {
> @@ -222,21 +216,25 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>  	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
>  			      vfpriv->ctx_id, out_fence);
>  
> -	ttm_eu_fence_buffer_objects(&ticket, &validate_list, &out_fence->f);
> +	for (i = 0; i < exbuf->num_bo_handles; i++)
> +		reservation_object_add_excl_fence(buflist[i]->resv, &out_fence->f);

Helper to unref an array of gem bo? Probably also needed by other drivers.


> +	drm_gem_unlock_reservations(buflist, exbuf->num_bo_handles, &ticket);
>  
> -	/* fence the command bo */
> -	virtio_gpu_unref_list(&validate_list);
> +	for (i = 0; i < exbuf->num_bo_handles; i++)
> +		if (buflist[i])
> +			drm_gem_object_put_unlocked(buflist[i]);

I am left wondering who's holding references onto these buffers now? How
do you make sure they don't disappear untimely?

I think atm it's ttm making sure of that, but if you drop that completely
there needs to be something else.

>  	kvfree(buflist);
>  	return 0;
>  
>  out_memdup:
>  	kfree(buf);
>  out_unresv:
> -	ttm_eu_backoff_reservation(&ticket, &validate_list);
> -out_free:
> -	virtio_gpu_unref_list(&validate_list);
> +	drm_gem_unlock_reservations(buflist, exbuf->num_bo_handles, &ticket);
>  out_unused_fd:
>  	kvfree(bo_handles);
> +	for (i = 0; i < exbuf->num_bo_handles; i++)
> +		if (buflist && buflist[i])
> +			drm_gem_object_put_unlocked(buflist[i]);
>  	kvfree(buflist);
>  
>  	if (out_fence_fd >= 0)

Patch itself looks correct, just put down my thoughts while reviewing it.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
