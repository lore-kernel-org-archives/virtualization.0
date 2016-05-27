From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] Add virtio gpu driver.
Date: Fri, 27 May 2016 11:03:13 +0200
Message-ID: <20160527090313.GX27098__48760.2778514431$1464339813$gmane$org@phenom.ffwll.local>
References: <1427213239-8775-1-git-send-email-kraxel@redhat.com>
	<20150324165057.GN1349@phenom.ffwll.local>
	<1427718227.3372.33.camel@nilsson.home.kraxel.org>
	<20150330144927.GN23521@phenom.ffwll.local>
	<CAKMK7uFUNT193f5djZD6T8cgRxxnZL73yrqbupPHOd2P-+Y=pQ@mail.gmail.com>
	<1464335302.10663.10.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1464335302.10663.10.camel@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, "open list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 27, 2016 at 09:48:22AM +0200, Gerd Hoffmann wrote:
> > I guess I didn't do a good job at looking at your v2: Cursor is still
> > using legacy interfaces and not a proper plane. Would be awesome if
> > you could fix that up. Atomic drivers really shouldn't use the legacy
> > cursor interfaces any more at all.
> > -Daniel
> 
> Figured that one for the most part, see attached draft.
> 
> The only thing I'm wondering is how the hotspot is handled.
> drm_mode_cursor_universal doesn't even look at req->hot_{x,y}.
> 
> /me looks confused.

No need to, you're simply the first virtual driver to wire up atomic
cursors. Hence some gaps to be filled out.

First we need to wire up the state tracking scaffolding for atomic:
- add hot_x/y to drm_plane_state
- add property pointers for hot_x/y to dev->mode_config (like we have for
  all the other atomic props like "SRC_X").
- add encode/decode support for these properties to
  drm_atomic_plane_get_property and drm_atomic_plane_set_property, similar
  again to "SRC_X" and friends
- add a small core function to registerr HOT_X/HOT_Y for a (cursor) plane,
  e.g. drm_plane_register_hotspot(). That should allocate the properties
  (if they don't exist yet) and then attach those props to the cursor. We
  don't want those props everywhere, but only on drivers that support/need
  them, aka virtual hw.

With that a real atomic driver will be able to move the cursor and it's
hotspot around, all nicely done in an atomic commit. But it won't work yet
for userspace for legacy applications. For that we need a notch more:
- one option would be to add hot_x/hot_y to the ->update_plane hook, but
  that has massive trickling effects throughout the subsystem. Probably
  not what we want to do.
- 2nd option would be to add a DRIVER_ATOMIC check to
  drm_mode_cursor_common and call a new drm_mode_cursor_atomic in that
  case:

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 3e52a6ecf6c0..2f15ce2c6bf4 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -3046,7 +3046,10 @@ static int drm_mode_cursor_common(struct drm_device *dev,
 	 */
 	drm_modeset_lock_crtc(crtc, crtc->cursor);
 	if (crtc->cursor) {
-		ret = drm_mode_cursor_universal(crtc, req, file_priv);
+		if (drm_core_check_feature(DRIVER_ATOMIC))
+			ret = drm_mode_cursor_atomic(crtc, req, file_priv);
+		else
+			ret = drm_mode_cursor_universal(crtc, req, file_priv);
 		goto out;
 	}
 
  drm_mode_cursor_atomic would simply be a fusing of
  drm_mode_cursor_universal + drm_atomic_helper_update_plane (dump all the
  intermediate variables and store directly in the plane state), with the
  addition of also storing hot_x/y into the plane state.

Sorry that this turned into a bit of a project, I've forgotten that we
haven't wired up hot_x/y at all for atomic ...

If you don't want to bother with the atomic properties (only needed for
atomic userspace), then just adding hot_x/y to drm_plane_state is all you
need from the first group of tasks.

Your patch below to implement the atomic cursor looks reasonable. Although
personally I'd go with a separate vfunc table for the cursor so that you
can avoid that ugly switch in the atomic_update hook.

Cheers, Daniel

> 
> cheers,
>   Gerd
> 

> From fb1d0700a46d850ec9f931304a9e99854a3ce5e9 Mon Sep 17 00:00:00 2001
> From: Gerd Hoffmann <kraxel@redhat.com>
> Date: Thu, 26 May 2016 11:42:52 +0200
> Subject: [PATCH] [wip] virtio-gpu: switch to atomic cursor interfaces
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 102 +++-----------------------
>  drivers/gpu/drm/virtio/virtgpu_drv.h     |   1 +
>  drivers/gpu/drm/virtio/virtgpu_plane.c   | 122 ++++++++++++++++++++++++-------
>  3 files changed, 109 insertions(+), 116 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 5990cab..d6b16d1 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -29,8 +29,8 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_atomic_helper.h>
>  
> -#define XRES_MIN   320
> -#define YRES_MIN   200
> +#define XRES_MIN    32
> +#define YRES_MIN    32
>  
>  #define XRES_DEF  1024
>  #define YRES_DEF   768
> @@ -38,86 +38,6 @@
>  #define XRES_MAX  8192
>  #define YRES_MAX  8192
>  
> -static void
> -virtio_gpu_hide_cursor(struct virtio_gpu_device *vgdev,
> -		       struct virtio_gpu_output *output)
> -{
> -	output->cursor.hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_UPDATE_CURSOR);
> -	output->cursor.resource_id = 0;
> -	virtio_gpu_cursor_ping(vgdev, output);
> -}
> -
> -static int virtio_gpu_crtc_cursor_set(struct drm_crtc *crtc,
> -				      struct drm_file *file_priv,
> -				      uint32_t handle,
> -				      uint32_t width,
> -				      uint32_t height,
> -				      int32_t hot_x, int32_t hot_y)
> -{
> -	struct virtio_gpu_device *vgdev = crtc->dev->dev_private;
> -	struct virtio_gpu_output *output =
> -		container_of(crtc, struct virtio_gpu_output, crtc);
> -	struct drm_gem_object *gobj = NULL;
> -	struct virtio_gpu_object *qobj = NULL;
> -	struct virtio_gpu_fence *fence = NULL;
> -	int ret = 0;
> -
> -	if (handle == 0) {
> -		virtio_gpu_hide_cursor(vgdev, output);
> -		return 0;
> -	}
> -
> -	/* lookup the cursor */
> -	gobj = drm_gem_object_lookup(crtc->dev, file_priv, handle);
> -	if (gobj == NULL)
> -		return -ENOENT;
> -
> -	qobj = gem_to_virtio_gpu_obj(gobj);
> -
> -	if (!qobj->hw_res_handle) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> -	virtio_gpu_cmd_transfer_to_host_2d(vgdev, qobj->hw_res_handle, 0,
> -					   cpu_to_le32(64),
> -					   cpu_to_le32(64),
> -					   0, 0, &fence);
> -	ret = virtio_gpu_object_reserve(qobj, false);
> -	if (!ret) {
> -		reservation_object_add_excl_fence(qobj->tbo.resv,
> -						  &fence->f);
> -		fence_put(&fence->f);
> -		virtio_gpu_object_unreserve(qobj);
> -		virtio_gpu_object_wait(qobj, false);
> -	}
> -
> -	output->cursor.hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_UPDATE_CURSOR);
> -	output->cursor.resource_id = cpu_to_le32(qobj->hw_res_handle);
> -	output->cursor.hot_x = cpu_to_le32(hot_x);
> -	output->cursor.hot_y = cpu_to_le32(hot_y);
> -	virtio_gpu_cursor_ping(vgdev, output);
> -	ret = 0;
> -
> -out:
> -	drm_gem_object_unreference_unlocked(gobj);
> -	return ret;
> -}
> -
> -static int virtio_gpu_crtc_cursor_move(struct drm_crtc *crtc,
> -				    int x, int y)
> -{
> -	struct virtio_gpu_device *vgdev = crtc->dev->dev_private;
> -	struct virtio_gpu_output *output =
> -		container_of(crtc, struct virtio_gpu_output, crtc);
> -
> -	output->cursor.hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_MOVE_CURSOR);
> -	output->cursor.pos.x = cpu_to_le32(x);
> -	output->cursor.pos.y = cpu_to_le32(y);
> -	virtio_gpu_cursor_ping(vgdev, output);
> -	return 0;
> -}
> -
>  static int virtio_gpu_page_flip(struct drm_crtc *crtc,
>  				struct drm_framebuffer *fb,
>  				struct drm_pending_vblank_event *event,
> @@ -164,8 +84,6 @@ static int virtio_gpu_page_flip(struct drm_crtc *crtc,
>  }
>  
>  static const struct drm_crtc_funcs virtio_gpu_crtc_funcs = {
> -	.cursor_set2            = virtio_gpu_crtc_cursor_set,
> -	.cursor_move            = virtio_gpu_crtc_cursor_move,
>  	.set_config             = drm_atomic_helper_set_config,
>  	.destroy                = drm_crtc_cleanup,
>  
> @@ -406,7 +324,7 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
>  	struct drm_connector *connector = &output->conn;
>  	struct drm_encoder *encoder = &output->enc;
>  	struct drm_crtc *crtc = &output->crtc;
> -	struct drm_plane *plane;
> +	struct drm_plane *primary, *cursor;
>  
>  	output->index = index;
>  	if (index == 0) {
> @@ -415,14 +333,18 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
>  		output->info.r.height = cpu_to_le32(YRES_DEF);
>  	}
>  
> -	plane = virtio_gpu_plane_init(vgdev, index);
> -	if (IS_ERR(plane))
> -		return PTR_ERR(plane);
> -	drm_crtc_init_with_planes(dev, crtc, plane, NULL,
> +	primary = virtio_gpu_plane_init(vgdev, DRM_PLANE_TYPE_PRIMARY, index);
> +	if (IS_ERR(primary))
> +		return PTR_ERR(primary);
> +	cursor = virtio_gpu_plane_init(vgdev, DRM_PLANE_TYPE_CURSOR, index);
> +	if (IS_ERR(cursor))
> +		return PTR_ERR(cursor);
> +	drm_crtc_init_with_planes(dev, crtc, primary, cursor,
>  				  &virtio_gpu_crtc_funcs, NULL);
>  	drm_mode_crtc_set_gamma_size(crtc, 256);
>  	drm_crtc_helper_add(crtc, &virtio_gpu_crtc_helper_funcs);
> -	plane->crtc = crtc;
> +	primary->crtc = crtc;
> +	cursor->crtc = crtc;
>  
>  	drm_connector_init(dev, connector, &virtio_gpu_connector_funcs,
>  			   DRM_MODE_CONNECTOR_VIRTUAL);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 8f486f4..a1f7e9d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -335,6 +335,7 @@ void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
>  
>  /* virtio_gpu_plane.c */
>  struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
> +					enum drm_plane_type type,
>  					int index);
>  
>  /* virtio_gpu_ttm.c */
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index 70b44a2..d68270f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -38,6 +38,10 @@ static const uint32_t virtio_gpu_formats[] = {
>  	DRM_FORMAT_ABGR8888,
>  };
>  
> +static const uint32_t virtio_gpu_cursor_formats[] = {
> +	DRM_FORMAT_ARGB8888,
> +};
> +
>  static void virtio_gpu_plane_destroy(struct drm_plane *plane)
>  {
>  	kfree(plane);
> @@ -63,39 +67,97 @@ static void virtio_gpu_plane_atomic_update(struct drm_plane *plane,
>  {
>  	struct drm_device *dev = plane->dev;
>  	struct virtio_gpu_device *vgdev = dev->dev_private;
> -	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(plane->crtc);
> +	struct virtio_gpu_output *output = NULL;
>  	struct virtio_gpu_framebuffer *vgfb;
> -	struct virtio_gpu_object *bo;
> +	struct virtio_gpu_fence *fence = NULL;
> +	struct virtio_gpu_object *bo = NULL;
>  	uint32_t handle;
> +	int ret = 0;
> +
> +	if (plane->state->crtc)
> +		output = drm_crtc_to_virtio_gpu_output(plane->state->crtc);
> +	if (old_state->crtc)
> +		output = drm_crtc_to_virtio_gpu_output(old_state->crtc);
> +	WARN_ON(!output);
>  
>  	if (plane->state->fb) {
>  		vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
>  		bo = gem_to_virtio_gpu_obj(vgfb->obj);
>  		handle = bo->hw_res_handle;
> -		if (bo->dumb) {
> -			virtio_gpu_cmd_transfer_to_host_2d
> -				(vgdev, handle, 0,
> -				 cpu_to_le32(plane->state->crtc_w),
> -				 cpu_to_le32(plane->state->crtc_h),
> -				 plane->state->crtc_x, plane->state->crtc_y, NULL);
> -		}
>  	} else {
>  		handle = 0;
>  	}
>  
> -	DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d\n", handle,
> -		  plane->state->crtc_w, plane->state->crtc_h,
> -		  plane->state->crtc_x, plane->state->crtc_y);
> -	virtio_gpu_cmd_set_scanout(vgdev, output->index, handle,
> -				   plane->state->crtc_w,
> -				   plane->state->crtc_h,
> -				   plane->state->crtc_x,
> -				   plane->state->crtc_y);
> -	virtio_gpu_cmd_resource_flush(vgdev, handle,
> -				      plane->state->crtc_x,
> -				      plane->state->crtc_y,
> -				      plane->state->crtc_w,
> -				      plane->state->crtc_h);
> +	switch (plane->type) {
> +	case DRM_PLANE_TYPE_CURSOR:
> +		if (bo && bo->dumb && (plane->state->fb != old_state->fb)) {
> +			/* new cursor -- update & wait */
> +			virtio_gpu_cmd_transfer_to_host_2d
> +				(vgdev, handle, 0,
> +				 cpu_to_le32(plane->state->crtc_w),
> +				 cpu_to_le32(plane->state->crtc_h),
> +				 0, 0, &fence);
> +			ret = virtio_gpu_object_reserve(bo, false);
> +			if (!ret) {
> +				reservation_object_add_excl_fence(bo->tbo.resv,
> +								  &fence->f);
> +				fence_put(&fence->f);
> +				fence = NULL;
> +				virtio_gpu_object_unreserve(bo);
> +				virtio_gpu_object_wait(bo, false);
> +			}
> +		}
> +
> +		if (plane->state->fb != old_state->fb) {
> +			DRM_DEBUG("cursor update, handle %d, +%d+%d\n", handle,
> +				  plane->state->crtc_x,
> +				  plane->state->crtc_y);
> +			output->cursor.hdr.type =
> +				cpu_to_le32(VIRTIO_GPU_CMD_UPDATE_CURSOR);
> +			output->cursor.resource_id = cpu_to_le32(handle);
> +#if 0
> +			output->cursor.hot_x = cpu_to_le32(hot_x);
> +			output->cursor.hot_y = cpu_to_le32(hot_y);
> +#endif
> +		} else {
> +			DRM_DEBUG("cursor move +%d+%d\n",
> +				  plane->state->crtc_x,
> +				  plane->state->crtc_y);
> +			output->cursor.hdr.type =
> +				cpu_to_le32(VIRTIO_GPU_CMD_MOVE_CURSOR);
> +		}
> +		output->cursor.pos.x = cpu_to_le32(plane->state->crtc_x);
> +		output->cursor.pos.y = cpu_to_le32(plane->state->crtc_y);
> +		virtio_gpu_cursor_ping(vgdev, output);
> +		break;
> +
> +	case DRM_PLANE_TYPE_PRIMARY:
> +		DRM_DEBUG("primary, handle 0x%x, crtc %dx%d+%d+%d\n", handle,
> +			  plane->state->crtc_w, plane->state->crtc_h,
> +			  plane->state->crtc_x, plane->state->crtc_y);
> +		if (bo && bo->dumb) {
> +			virtio_gpu_cmd_transfer_to_host_2d
> +				(vgdev, handle, 0,
> +				 cpu_to_le32(plane->state->crtc_w),
> +				 cpu_to_le32(plane->state->crtc_h),
> +				 plane->state->crtc_x, plane->state->crtc_y,
> +				 &fence);
> +		}
> +		virtio_gpu_cmd_set_scanout(vgdev, output->index, handle,
> +					   plane->state->crtc_w,
> +					   plane->state->crtc_h,
> +					   plane->state->crtc_x,
> +					   plane->state->crtc_y);
> +		virtio_gpu_cmd_resource_flush(vgdev, handle,
> +					      plane->state->crtc_x,
> +					      plane->state->crtc_y,
> +					      plane->state->crtc_w,
> +					      plane->state->crtc_h);
> +		break;
> +
> +	default:
> +		WARN_ON(true);
> +	}
>  }
>  
>  
> @@ -105,21 +167,29 @@ static const struct drm_plane_helper_funcs virtio_gpu_plane_helper_funcs = {
>  };
>  
>  struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
> +					enum drm_plane_type type,
>  					int index)
>  {
>  	struct drm_device *dev = vgdev->ddev;
>  	struct drm_plane *plane;
> -	int ret;
> +	const uint32_t *formats;
> +	int ret, nformats;
>  
>  	plane = kzalloc(sizeof(*plane), GFP_KERNEL);
>  	if (!plane)
>  		return ERR_PTR(-ENOMEM);
>  
> +	if (type == DRM_PLANE_TYPE_CURSOR) {
> +		formats = virtio_gpu_cursor_formats;
> +		nformats = ARRAY_SIZE(virtio_gpu_cursor_formats);
> +	} else {
> +		formats = virtio_gpu_formats;
> +		nformats = ARRAY_SIZE(virtio_gpu_formats);
> +	}
>  	ret = drm_universal_plane_init(dev, plane, 1 << index,
>  				       &virtio_gpu_plane_funcs,
> -				       virtio_gpu_formats,
> -				       ARRAY_SIZE(virtio_gpu_formats),
> -				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +				       formats, nformats,
> +				       type, NULL);
>  	if (ret)
>  		goto err_plane_init;
>  
> -- 
> 1.8.3.1
> 


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
