From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 07/12] drm/virtio: remove ttm calls from in
	virtio_gpu_object_{reserve,unreserve}
Date: Wed, 19 Jun 2019 11:57:08 +0200
Message-ID: <20190619095708.GL12905__9843.21745797701$1560938249$gmane$org@phenom.ffwll.local>
References: <20190619090420.6667-1-kraxel@redhat.com>
	<20190619090420.6667-8-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190619090420.6667-8-kraxel@redhat.com>
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

On Wed, Jun 19, 2019 at 11:04:15AM +0200, Gerd Hoffmann wrote:
> Call reservation_object_* directly instead
> of using ttm_bo_{reserve,unreserve}.
> 
> v3: check for EINTR too.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 06cc0e961df6..77ac69a8e6cc 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -402,9 +402,9 @@ static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
>  {
>  	int r;
>  
> -	r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
> +	r = reservation_object_lock_interruptible(bo->gem_base.resv, NULL);
>  	if (unlikely(r != 0)) {
> -		if (r != -ERESTARTSYS) {
> +		if (r != -ERESTARTSYS && r != -EINTR) {

You only need to check for EINTR I think. ttm_bo_reserv does the EINVAL ->
ERESTARTSYS remapping.
-Daniel

>  			struct virtio_gpu_device *qdev =
>  				bo->gem_base.dev->dev_private;
>  			dev_err(qdev->dev, "%p reserve failed\n", bo);
> @@ -416,7 +416,7 @@ static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
>  
>  static inline void virtio_gpu_object_unreserve(struct virtio_gpu_object *bo)
>  {
> -	ttm_bo_unreserve(&bo->tbo);
> +	reservation_object_unlock(bo->gem_base.resv);
>  }
>  
>  /* virgl debufs */
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
