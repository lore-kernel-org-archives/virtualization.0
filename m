From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 3/4] drm/virtio: simplify cursor updates
Date: Mon, 17 Jun 2019 16:18:06 +0200
Message-ID: <20190617141806.GG12905__18314.8047000699$1560781100$gmane$org@phenom.ffwll.local>
References: <20190617111406.14765-1-kraxel@redhat.com>
	<20190617111406.14765-4-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190617111406.14765-4-kraxel@redhat.com>
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

On Mon, Jun 17, 2019 at 01:14:05PM +0200, Gerd Hoffmann wrote:
> No need to do the reservation dance,
> we can just wait on the fence directly.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index 024c2aa0c929..4b805bf466d3 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -184,7 +184,6 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
>  	struct virtio_gpu_framebuffer *vgfb;
>  	struct virtio_gpu_object *bo = NULL;
>  	uint32_t handle;
> -	int ret = 0;
>  
>  	if (plane->state->crtc)
>  		output = drm_crtc_to_virtio_gpu_output(plane->state->crtc);
> @@ -208,15 +207,9 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
>  			 cpu_to_le32(plane->state->crtc_w),
>  			 cpu_to_le32(plane->state->crtc_h),
>  			 0, 0, vgfb->fence);
> -		ret = virtio_gpu_object_reserve(bo, false);
> -		if (!ret) {
> -			reservation_object_add_excl_fence(bo->tbo.resv,
> -							  &vgfb->fence->f);
> -			dma_fence_put(&vgfb->fence->f);
> -			vgfb->fence = NULL;
> -			virtio_gpu_object_unreserve(bo);
> -			virtio_gpu_object_wait(bo, false);
> -		}
> +		dma_fence_wait(&vgfb->fence->f, true);
> +		dma_fence_put(&vgfb->fence->f);
> +		vgfb->fence = NULL;

Even nicer would be to add the fence using
drm_atomic_set_fence_for_plane() in the prepare_fb hook. Assuming this
isn't necessary for correctness (but then I kinda have questions about
races and stuff).

But this gets the job done too I think, so:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  	}
>  
>  	if (plane->state->fb != old_state->fb) {
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
