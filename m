From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 14/15] drm/virtio: Remove unecessary dma_fence_ops
Date: Tue, 3 Jul 2018 13:14:45 +0200
Message-ID: <20180703111445.GA3891__19226.9438798123$1530616372$gmane$org@phenom.ffwll.local>
References: <20180503142603.28513-1-daniel.vetter@ffwll.ch>
	<20180503142603.28513-15-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180503142603.28513-15-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 03, 2018 at 04:26:02PM +0200, Daniel Vetter wrote:
> dma_fence_default_wait is the default now, same for the trivial
> enable_signaling implementation.
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org

Ok pulled in the remaining patches here with acks/r-bs, will resend the
others.
-Daniel

> ---
>  drivers/gpu/drm/virtio/virtgpu_fence.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
> index 23353521f903..00c742a441bf 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_fence.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
> @@ -36,11 +36,6 @@ static const char *virtio_get_timeline_name(struct dma_fence *f)
>  	return "controlq";
>  }
>  
> -static bool virtio_enable_signaling(struct dma_fence *f)
> -{
> -	return true;
> -}
> -
>  static bool virtio_signaled(struct dma_fence *f)
>  {
>  	struct virtio_gpu_fence *fence = to_virtio_fence(f);
> @@ -67,9 +62,7 @@ static void virtio_timeline_value_str(struct dma_fence *f, char *str, int size)
>  static const struct dma_fence_ops virtio_fence_ops = {
>  	.get_driver_name     = virtio_get_driver_name,
>  	.get_timeline_name   = virtio_get_timeline_name,
> -	.enable_signaling    = virtio_enable_signaling,
>  	.signaled            = virtio_signaled,
> -	.wait                = dma_fence_default_wait,
>  	.fence_value_str     = virtio_fence_value_str,
>  	.timeline_value_str  = virtio_timeline_value_str,
>  };
> -- 
> 2.17.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
