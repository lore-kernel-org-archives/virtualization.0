From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 06/12] drm/virtio: drop no_wait argument from
	virtio_gpu_object_reserve
Date: Wed, 19 Jun 2019 12:55:44 +0200
Message-ID: <20190619105543.GN12905__26470.4034243309$1560941759$gmane$org@phenom.ffwll.local>
References: <20190619090420.6667-1-kraxel@redhat.com>
	<20190619090420.6667-7-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190619090420.6667-7-kraxel@redhat.com>
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

On Wed, Jun 19, 2019 at 11:04:14AM +0200, Gerd Hoffmann wrote:
> All callers pass no_wait = false.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   | 5 ++---
>  drivers/gpu/drm/virtio/virtgpu_gem.c   | 4 ++--
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 ++--
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 2cd96256ba37..06cc0e961df6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -398,12 +398,11 @@ static inline u64 virtio_gpu_object_mmap_offset(struct virtio_gpu_object *bo)
>  	return drm_vma_node_offset_addr(&bo->tbo.vma_node);
>  }
>  
> -static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo,
> -					 bool no_wait)
> +static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
>  {
>  	int r;
>  
> -	r = ttm_bo_reserve(&bo->tbo, true, no_wait, NULL);
> +	r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
>  	if (unlikely(r != 0)) {
>  		if (r != -ERESTARTSYS) {
>  			struct virtio_gpu_device *qdev =
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 1e49e08dd545..9c9ad3b14080 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -140,7 +140,7 @@ int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
>  	if (!vgdev->has_virgl_3d)
>  		return 0;
>  
> -	r = virtio_gpu_object_reserve(qobj, false);
> +	r = virtio_gpu_object_reserve(qobj);
>  	if (r)
>  		return r;
>  
> @@ -161,7 +161,7 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
>  	if (!vgdev->has_virgl_3d)
>  		return;
>  
> -	r = virtio_gpu_object_reserve(qobj, false);
> +	r = virtio_gpu_object_reserve(qobj);
>  	if (r)
>  		return;
>  
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 313c770ea2c5..5cffd2e54c04 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -375,7 +375,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
>  
>  	qobj = gem_to_virtio_gpu_obj(gobj);
>  
> -	ret = virtio_gpu_object_reserve(qobj, false);
> +	ret = virtio_gpu_object_reserve(qobj);
>  	if (ret)
>  		goto out;
>  
> @@ -425,7 +425,7 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
>  
>  	qobj = gem_to_virtio_gpu_obj(gobj);
>  
> -	ret = virtio_gpu_object_reserve(qobj, false);
> +	ret = virtio_gpu_object_reserve(qobj);
>  	if (ret)
>  		goto out;
>  
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
