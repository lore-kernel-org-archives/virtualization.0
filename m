From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 4/4] drm/virtio: remove virtio_gpu_object_wait
Date: Mon, 17 Jun 2019 16:18:19 +0200
Message-ID: <20190617141819.GH12905@phenom.ffwll.local>
References: <20190617111406.14765-1-kraxel@redhat.com>
	<20190617111406.14765-5-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190617111406.14765-5-kraxel@redhat.com>
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

On Mon, Jun 17, 2019 at 01:14:06PM +0200, Gerd Hoffmann wrote:
> No users left.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    |  1 -
>  drivers/gpu/drm/virtio/virtgpu_object.c | 13 -------------
>  2 files changed, 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 9e2d3062b01d..2cd96256ba37 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -364,7 +364,6 @@ int virtio_gpu_object_kmap(struct virtio_gpu_object *bo);
>  int virtio_gpu_object_get_sg_table(struct virtio_gpu_device *qdev,
>  				   struct virtio_gpu_object *bo);
>  void virtio_gpu_object_free_sg_table(struct virtio_gpu_object *bo);
> -int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait);
>  
>  /* virtgpu_prime.c */
>  struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 242766d644a7..82bfbf983fd2 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -233,16 +233,3 @@ void virtio_gpu_object_free_sg_table(struct virtio_gpu_object *bo)
>  	kfree(bo->pages);
>  	bo->pages = NULL;
>  }
> -
> -int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait)
> -{
> -	int r;
> -
> -	r = ttm_bo_reserve(&bo->tbo, true, no_wait, NULL);
> -	if (unlikely(r != 0))
> -		return r;
> -	r = ttm_bo_wait(&bo->tbo, true, no_wait);
> -	ttm_bo_unreserve(&bo->tbo);
> -	return r;
> -}
> -
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
