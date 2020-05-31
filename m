From: Sidong Yang <realwakka@gmail.com>
Subject: Re: [PATCH] drm/qxl: Replace deprecated function in qxl_display
Date: Sun, 31 May 2020 17:13:39 +0900
Message-ID: <20200531081339.GA16336@realwakka-Lenovo-IdeaPad-S340-14API>
References: <20200523160156.32511-1-realwakka@gmail.com>
 <CAMwc25pf=wmtQcog7D8GUJ6zz6ascFkExS+bsyA2E4chz-UcuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMwc25pf=wmtQcog7D8GUJ6zz6ascFkExS+bsyA2E4chz-UcuQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, May 24, 2020 at 07:42:25AM +1000, David Airlie wrote:
> On Sun, May 24, 2020 at 2:02 AM Sidong Yang <realwakka@gmail.com> wrote:
> >
> > Hi, Dave.
> >
> > I'm a newbie kernel developer interested in qxl driver. And I want to participate in
> > contributing for QXL module.
> > I wrote some simple patch for refactoring task found in todos in gpu documentation.
> > I want to know it's okay to contribute and write some patch for qxl module.
> > If this patch is wrong, please give me some advice for me.
> > Or if you have some simple task for me, I'll be glad to do it.
> > Thanks.
> 
> Hi Sidong,
> 
> The best way to start is probably to email dri-devel list rather than
> just me, there are a few more people there who can help with
> onboarding and accepting patches.
> 
> For QXL, Gerd Hoffmann (kraxel@redhat.com) is also worth cc'ing as he
> is mostly maintaining it at the moment.
> 
> Dave.
>

Thanks so much for advice Dave.
I'll add cc for qxl maintainer and dri-devel in next patch.

Sidong.
> 
> >
> > Sincerely,
> > Sidong.
> >
> > Replace deprecated function drm_modeset_lock/unlock_all with
> > helper function DRM_MODESET_LOCK_ALL_BEGIN/END.
> >
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >  drivers/gpu/drm/qxl/qxl_display.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> > index 1082cd5d2fd4..07e164cee868 100644
> > --- a/drivers/gpu/drm/qxl/qxl_display.c
> > +++ b/drivers/gpu/drm/qxl/qxl_display.c
> > @@ -162,7 +162,8 @@ static void qxl_update_offset_props(struct qxl_device *qdev)
> >  void qxl_display_read_client_monitors_config(struct qxl_device *qdev)
> >  {
> >         struct drm_device *dev = &qdev->ddev;
> > -       int status, retries;
> > +       struct drm_modeset_acquire_ctx ctx;
> > +       int status, retries, ret;
> >
> >         for (retries = 0; retries < 10; retries++) {
> >                 status = qxl_display_copy_rom_client_monitors_config(qdev);
> > @@ -183,9 +184,9 @@ void qxl_display_read_client_monitors_config(struct qxl_device *qdev)
> >                 return;
> >         }
> >
> > -       drm_modeset_lock_all(dev);
> > +       DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE, ret);
> >         qxl_update_offset_props(qdev);
> > -       drm_modeset_unlock_all(dev);
> > +       DRM_MODESET_LOCK_ALL_END(ctx, ret);
> >         if (!drm_helper_hpd_irq_event(dev)) {
> >                 /* notify that the monitor configuration changed, to
> >                    adjust at the arbitrary resolution */
> > @@ -403,18 +404,17 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
> >         struct qxl_device *qdev = to_qxl(fb->dev);
> >         struct drm_clip_rect norect;
> >         struct qxl_bo *qobj;
> > +       struct drm_modeset_acquire_ctx ctx;
> >         bool is_primary;
> > -       int inc = 1;
> > +       int inc = 1, ret;
> >
> > -       drm_modeset_lock_all(fb->dev);
> > +       DRM_MODESET_LOCK_ALL_BEGIN(fb->dev, ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE, ret);
> >
> >         qobj = gem_to_qxl_bo(fb->obj[0]);
> >         /* if we aren't primary surface ignore this */
> >         is_primary = qobj->shadow ? qobj->shadow->is_primary : qobj->is_primary;
> > -       if (!is_primary) {
> > -               drm_modeset_unlock_all(fb->dev);
> > -               return 0;
> > -       }
> > +       if (!is_primary)
> > +               goto out_lock_end;
> >
> >         if (!num_clips) {
> >                 num_clips = 1;
> > @@ -430,7 +430,8 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
> >         qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
> >                           clips, num_clips, inc, 0);
> >
> > -       drm_modeset_unlock_all(fb->dev);
> > +out_lock_end:
> > +       DRM_MODESET_LOCK_ALL_END(ctx, ret);
> >
> >         return 0;
> >  }
> > --
> > 2.17.1
> >
> 
