From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/2] drm: Add drm_gem_vram_{pin/unpin}_reserved() and
	convert mgag200
Date: Mon, 20 May 2019 21:26:24 +0200
Message-ID: <CAKMK7uF51rBURbo=9OtVSP4XQkh5mw9F7oSdjs6=RH1UZb2jzA@mail.gmail.com>
References: <20190516162746.11636-1-tzimmermann@suse.de>
	<20190516162746.11636-2-tzimmermann@suse.de>
	<20190520161900.GB21222@phenom.ffwll.local>
	<20190520162615.GD21222@phenom.ffwll.local>
	<2192d545-47ef-ccd8-d0b9-44f42b55e8d2@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2192d545-47ef-ccd8-d0b9-44f42b55e8d2@amd.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "noralf@tronnes.org" <noralf@tronnes.org>, "airlied@linux.ie" <airlied@linux.ie>, "puck.chen@hisilicon.com" <puck.chen@hisilicon.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "z.liuxinliang@hisilicon.com" <z.liuxinliang@hisilicon.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "kong.kongxinwei@hisilicon.com" <kong.kongxinwei@hisilicon.com>, "Huang, Ray" <Ray.Huang@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>, "zourongrong@gmail.com" <zourongrong@gmail.com>, "sam@ravnborg.org" <sam@ravnborg.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 20, 2019 at 9:24 PM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 20.05.19 um 18:26 schrieb Daniel Vetter:
> > [CAUTION: External Email]
> >
> > On Mon, May 20, 2019 at 06:19:00PM +0200, Daniel Vetter wrote:
> >> On Thu, May 16, 2019 at 06:27:45PM +0200, Thomas Zimmermann wrote:
> >>> The new interfaces drm_gem_vram_{pin/unpin}_reserved() are variants of the
> >>> GEM VRAM pin/unpin functions that do not reserve the BO during validation.
> >>> The mgag200 driver requires this behavior for its cursor handling. The
> >>> patch also converts the driver to use the new interfaces.
> >>>
> >>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >>> ---
> >>>   drivers/gpu/drm/drm_gem_vram_helper.c    | 75 ++++++++++++++++++++++++
> >>>   drivers/gpu/drm/mgag200/mgag200_cursor.c | 18 +++---
> >>>   include/drm/drm_gem_vram_helper.h        |  3 +
> >>>   3 files changed, 88 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
> >>> index 8f142b810eb4..a002c03eaf4c 100644
> >>> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> >>> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> >>> @@ -254,6 +254,47 @@ int drm_gem_vram_pin(struct drm_gem_vram_object *gbo, unsigned long pl_flag)
> >>>   }
> >>>   EXPORT_SYMBOL(drm_gem_vram_pin);
> >>>
> >>> +/**
> >>> + * drm_gem_vram_pin_reserved() - Pins a GEM VRAM object in a region.
> >>> + * @gbo:   the GEM VRAM object
> >>> + * @pl_flag:       a bitmask of possible memory regions
> >>> + *
> >>> + * Pinning a buffer object ensures that it is not evicted from
> >>> + * a memory region. A pinned buffer object has to be unpinned before
> >>> + * it can be pinned to another region.
> >>> + *
> >>> + * This function pins a GEM VRAM object that has already been
> >>> + * reserved. Use drm_gem_vram_pin() if possible.
> >>> + *
> >>> + * Returns:
> >>> + * 0 on success, or
> >>> + * a negative error code otherwise.
> >>> + */
> >>> +int drm_gem_vram_pin_reserved(struct drm_gem_vram_object *gbo,
> >>> +                         unsigned long pl_flag)
> >>> +{
> >>> +   int i, ret;
> >>> +   struct ttm_operation_ctx ctx = { false, false };
> >> I think would be good to have a lockdep_assert_held here for the ww_mutex.
> >>
> >> Also general thing: _reserved is kinda ttm lingo, for dma-buf reservations
> >> we call the structure tracking the fences+lock the "reservation", but the
> >> naming scheme used is _lock/_unlock.
> >>
> >> I think would be good to be consistent with that, and use _locked here.
> >> Especially for a very simplified vram helper like this one I expect that's
> >> going to lead to less wtf moments by driver writers :-)
> >>
> >> Maybe we should also do a large-scale s/reserve/lock/ within ttm, to align
> >> more with what we now have in dma-buf.
> > More aside:
> >
> > Could be a good move to demidlayer this an essentially remove
> > ttm_bo_reserve as a wrapper around the linux/reservation.h functions. Not
> > sure whether that aligns with Christian's plans. TODO.rst patch might be a
> > good step to get that discussion started.
>
> Well what ttm_bo_reserve()/_unreserve() does is a) lock/unlock the
> reservation object and b) remove the BO from the LRU.
>
> Since I'm desperately trying to get rid of the LRU removal right now we
> sooner or later should be able to remove ttmo_bo_reserve()/_unreserve()
> as well (or at least replace them with tiny ttm_bo_lock() wrappers.

Yeah that's what I meant, would be nice to ditch that bit of
midlayering, at least from drivers.

I guess within ttm we'd still need ttm_bo_lock/unlock, since
interrupteble/timedout/lock modes in general is passed around
throughout the entire stack as parameters.
-Daniel

>
> Christian.
>
> > -Daniel
> >
> >> Cheers, Daniel
> >>
> >>> +
> >>> +   if (gbo->pin_count) {
> >>> +           ++gbo->pin_count;
> >>> +           return 0;
> >>> +   }
> >>> +
> >>> +   drm_gem_vram_placement(gbo, pl_flag);
> >>> +   for (i = 0; i < gbo->placement.num_placement; ++i)
> >>> +           gbo->placements[i].flags |= TTM_PL_FLAG_NO_EVICT;
> >>> +
> >>> +   ret = ttm_bo_validate(&gbo->bo, &gbo->placement, &ctx);
> >>> +   if (ret < 0)
> >>> +           return ret;
> >>> +
> >>> +   gbo->pin_count = 1;
> >>> +
> >>> +   return 0;
> >>> +}
> >>> +EXPORT_SYMBOL(drm_gem_vram_pin_reserved);
> >>> +
> >>>   /**
> >>>    * drm_gem_vram_unpin() - Unpins a GEM VRAM object
> >>>    * @gbo:   the GEM VRAM object
> >>> @@ -285,6 +326,40 @@ int drm_gem_vram_unpin(struct drm_gem_vram_object *gbo)
> >>>   }
> >>>   EXPORT_SYMBOL(drm_gem_vram_unpin);
> >>>
> >>> +/**
> >>> + * drm_gem_vram_unpin_reserved() - Unpins a GEM VRAM object
> >>> + * @gbo:   the GEM VRAM object
> >>> + *
> >>> + * This function unpins a GEM VRAM object that has already been
> >>> + * reserved. Use drm_gem_vram_unpin() if possible.
> >>> + *
> >>> + * Returns:
> >>> + * 0 on success, or
> >>> + * a negative error code otherwise.
> >>> + */
> >>> +int drm_gem_vram_unpin_reserved(struct drm_gem_vram_object *gbo)
> >>> +{
> >>> +   int i, ret;
> >>> +   struct ttm_operation_ctx ctx = { false, false };
> >>> +
> >>> +   if (WARN_ON_ONCE(!gbo->pin_count))
> >>> +           return 0;
> >>> +
> >>> +   --gbo->pin_count;
> >>> +   if (gbo->pin_count)
> >>> +           return 0;
> >>> +
> >>> +   for (i = 0; i < gbo->placement.num_placement ; ++i)
> >>> +           gbo->placements[i].flags &= ~TTM_PL_FLAG_NO_EVICT;
> >>> +
> >>> +   ret = ttm_bo_validate(&gbo->bo, &gbo->placement, &ctx);
> >>> +   if (ret < 0)
> >>> +           return ret;
> >>> +
> >>> +   return 0;
> >>> +}
> >>> +EXPORT_SYMBOL(drm_gem_vram_unpin_reserved);
> >>> +
> >>>   /**
> >>>    * drm_gem_vram_push_to_system() - \
> >>>      Unpins a GEM VRAM object and moves it to system memory
> >>> diff --git a/drivers/gpu/drm/mgag200/mgag200_cursor.c b/drivers/gpu/drm/mgag200/mgag200_cursor.c
> >>> index 6c1a9d724d85..1c4fc85315a0 100644
> >>> --- a/drivers/gpu/drm/mgag200/mgag200_cursor.c
> >>> +++ b/drivers/gpu/drm/mgag200/mgag200_cursor.c
> >>> @@ -23,9 +23,9 @@ static void mga_hide_cursor(struct mga_device *mdev)
> >>>      WREG8(MGA_CURPOSXL, 0);
> >>>      WREG8(MGA_CURPOSXH, 0);
> >>>      if (mdev->cursor.pixels_1->pin_count)
> >>> -           drm_gem_vram_unpin(mdev->cursor.pixels_1);
> >>> +           drm_gem_vram_unpin_reserved(mdev->cursor.pixels_1);
> >>>      if (mdev->cursor.pixels_2->pin_count)
> >>> -           drm_gem_vram_unpin(mdev->cursor.pixels_2);
> >>> +           drm_gem_vram_unpin_reserved(mdev->cursor.pixels_2);
> >>>   }
> >>>
> >>>   int mga_crtc_cursor_set(struct drm_crtc *crtc,
> >>> @@ -96,26 +96,28 @@ int mga_crtc_cursor_set(struct drm_crtc *crtc,
> >>>
> >>>      /* Move cursor buffers into VRAM if they aren't already */
> >>>      if (!pixels_1->pin_count) {
> >>> -           ret = drm_gem_vram_pin(pixels_1, DRM_GEM_VRAM_PL_FLAG_VRAM);
> >>> +           ret = drm_gem_vram_pin_reserved(pixels_1,
> >>> +                                           DRM_GEM_VRAM_PL_FLAG_VRAM);
> >>>              if (ret)
> >>>                      goto out1;
> >>>              gpu_addr = drm_gem_vram_offset(pixels_1);
> >>>              if (gpu_addr < 0) {
> >>> -                   drm_gem_vram_unpin(pixels_1);
> >>> +                   drm_gem_vram_unpin_reserved(pixels_1);
> >>>                      goto out1;
> >>>              }
> >>>              mdev->cursor.pixels_1_gpu_addr = gpu_addr;
> >>>      }
> >>>      if (!pixels_2->pin_count) {
> >>> -           ret = drm_gem_vram_pin(pixels_2, DRM_GEM_VRAM_PL_FLAG_VRAM);
> >>> +           ret = drm_gem_vram_pin_reserved(pixels_2,
> >>> +                                           DRM_GEM_VRAM_PL_FLAG_VRAM);
> >>>              if (ret) {
> >>> -                   drm_gem_vram_unpin(pixels_1);
> >>> +                   drm_gem_vram_unpin_reserved(pixels_1);
> >>>                      goto out1;
> >>>              }
> >>>              gpu_addr = drm_gem_vram_offset(pixels_2);
> >>>              if (gpu_addr < 0) {
> >>> -                   drm_gem_vram_unpin(pixels_1);
> >>> -                   drm_gem_vram_unpin(pixels_2);
> >>> +                   drm_gem_vram_unpin_reserved(pixels_1);
> >>> +                   drm_gem_vram_unpin_reserved(pixels_2);
> >>>                      goto out1;
> >>>              }
> >>>              mdev->cursor.pixels_2_gpu_addr = gpu_addr;
> >>> diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
> >>> index b056f189ba62..ff1a81761543 100644
> >>> --- a/include/drm/drm_gem_vram_helper.h
> >>> +++ b/include/drm/drm_gem_vram_helper.h
> >>> @@ -82,7 +82,10 @@ void drm_gem_vram_unreserve(struct drm_gem_vram_object *gbo);
> >>>   u64 drm_gem_vram_mmap_offset(struct drm_gem_vram_object *gbo);
> >>>   s64 drm_gem_vram_offset(struct drm_gem_vram_object *gbo);
> >>>   int drm_gem_vram_pin(struct drm_gem_vram_object *gbo, unsigned long pl_flag);
> >>> +int drm_gem_vram_pin_reserved(struct drm_gem_vram_object *gbo,
> >>> +                         unsigned long pl_flag);
> >>>   int drm_gem_vram_unpin(struct drm_gem_vram_object *gbo);
> >>> +int drm_gem_vram_unpin_reserved(struct drm_gem_vram_object *gbo);
> >>>   int drm_gem_vram_push_to_system(struct drm_gem_vram_object *gbo);
> >>>   void *drm_gem_vram_kmap_at(struct drm_gem_vram_object *gbo, bool map,
> >>>                         bool *is_iomem, struct ttm_bo_kmap_obj *kmap);
> >>> --
> >>> 2.21.0
> >>>
> >> --
> >> Daniel Vetter
> >> Software Engineer, Intel Corporation
> >> http://blog.ffwll.ch
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
