From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/virtio: Remove open-coded commit-tail function
Date: Tue, 14 Jul 2020 11:13:35 +0200
Message-ID: <20200714091335.GY3278063@phenom.ffwll.local>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <20200709123339.547390-2-daniel.vetter@ffwll.ch>
 <20200709140531.GA220817@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-rdma-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200709140531.GA220817-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-rdma-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Intel Graphics Development <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 09, 2020 at 04:05:31PM +0200, Sam Ravnborg wrote:
> On Thu, Jul 09, 2020 at 02:33:39PM +0200, Daniel Vetter wrote:
> > Exactly matches the one in the helpers.
> > 
> > This avoids me having to roll out dma-fence critical section
> > annotations to this copy.
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>
> > Cc: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_display.c | 20 --------------------
> >  1 file changed, 20 deletions(-)
> Very nice catch:
> Reviewed-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>

Patch applied, thanks for reviewing.

> > 
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> > index f3ce49c5a34c..af55b334be2f 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> > @@ -314,25 +314,6 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
> >  	return &virtio_gpu_fb->base;
> >  }
> >  
> > -static void vgdev_atomic_commit_tail(struct drm_atomic_state *state)
> > -{
> > -	struct drm_device *dev = state->dev;
> > -
> > -	drm_atomic_helper_commit_modeset_disables(dev, state);
> > -	drm_atomic_helper_commit_modeset_enables(dev, state);
> > -	drm_atomic_helper_commit_planes(dev, state, 0);
> > -
> > -	drm_atomic_helper_fake_vblank(state);
> > -	drm_atomic_helper_commit_hw_done(state);
> > -
> > -	drm_atomic_helper_wait_for_vblanks(dev, state);
> > -	drm_atomic_helper_cleanup_planes(dev, state);
> > -}
> > -
> > -static const struct drm_mode_config_helper_funcs virtio_mode_config_helpers = {
> > -	.atomic_commit_tail = vgdev_atomic_commit_tail,
> > -};
> > -
> >  static const struct drm_mode_config_funcs virtio_gpu_mode_funcs = {
> >  	.fb_create = virtio_gpu_user_framebuffer_create,
> >  	.atomic_check = drm_atomic_helper_check,
> > @@ -346,7 +327,6 @@ void virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
> >  	drm_mode_config_init(vgdev->ddev);
> >  	vgdev->ddev->mode_config.quirk_addfb_prefer_host_byte_order = true;
> >  	vgdev->ddev->mode_config.funcs = &virtio_gpu_mode_funcs;
> > -	vgdev->ddev->mode_config.helper_private = &virtio_mode_config_helpers;
> >  
> >  	/* modes will be validated against the framebuffer size */
> >  	vgdev->ddev->mode_config.min_width = XRES_MIN;
> > -- 
> > 2.27.0
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
