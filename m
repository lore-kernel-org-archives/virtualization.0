From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/cirrus: Let DRM core send VBLANK events
Date: Mon, 13 Jan 2020 00:00:45 +0100
Message-ID: <20200112230045.GE5340@dvetter-linux.ger.corp.intel.com>
References: <20200110115707.14080-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200110115707.14080-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@redhat.com, dri-devel@lists.freedesktop.org, kraxel@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 10, 2020 at 12:57:07PM +0100, Thomas Zimmermann wrote:
> In drm_atomic_helper_fake_vblank() the DRM core sends out VBLANK
> events if struct drm_crtc_state.no_vblank is enabled. Replace cirrus'
> VBLANK events with the DRM core's functionality.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/cirrus/cirrus.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
> index 248c9f765c45..4a1729aa7e53 100644
> --- a/drivers/gpu/drm/cirrus/cirrus.c
> +++ b/drivers/gpu/drm/cirrus/cirrus.c
> @@ -38,7 +38,6 @@
>  #include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
> -#include <drm/drm_vblank.h>
>  
>  #define DRIVER_NAME "cirrus"
>  #define DRIVER_DESC "qemu cirrus vga"
> @@ -415,6 +414,8 @@ static void cirrus_pipe_enable(struct drm_simple_display_pipe *pipe,
>  {
>  	struct cirrus_device *cirrus = pipe->crtc.dev->dev_private;
>  
> +	crtc_state->no_vblank = true;

Huh, nice untended use of this stuff ... We've added this for writeback,
but I guess it can be used for anything that's a virtual connector ...

I've also spotted that you've done this same trick for ast & udl already.
But I think before we roll this out massively we should make this
official. Can you pls do a patch to update the kerneldoc for @no_vblank
that virtual hw can also use this stuff?

Also, computing state values in atomic_commit code is kinda uncool and
fraught with peril - design assumption is that with some very few
exceptions (which are kinda awkward, would be nice to make state pointers
const) all the core and helper codes that state structures stay unchanged
after atomic_check completed. This should be computed in atomic_check (like vc4
does). Can you pls also include patches to update ast and udl in this
series?

Thanks, Daniel


> +
>  	cirrus_mode_set(cirrus, &crtc_state->mode, plane_state->fb);
>  	cirrus_fb_blit_fullscreen(plane_state->fb);
>  }
> @@ -434,13 +435,6 @@ static void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
>  
>  	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
>  		cirrus_fb_blit_rect(pipe->plane.state->fb, &rect);
> -
> -	if (crtc->state->event) {
> -		spin_lock_irq(&crtc->dev->event_lock);
> -		drm_crtc_send_vblank_event(crtc, crtc->state->event);
> -		crtc->state->event = NULL;
> -		spin_unlock_irq(&crtc->dev->event_lock);
> -	}
>  }
>  
>  static const struct drm_simple_display_pipe_funcs cirrus_pipe_funcs = {
> -- 
> 2.24.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
