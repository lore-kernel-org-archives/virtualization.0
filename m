From: Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH libdrm] drm: Remove create_handle() drm_framebuffer
	"virtual".
Date: Wed, 9 Aug 2017 14:27:03 -0400
Message-ID: <20170809182703.3a2dp3q2gtqio3vi__11077.7987436906$1509078999$gmane$org@art_vandelay>
References: <20170808234237.62051-1-djmk@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170808234237.62051-1-djmk@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Kniss <djmk@chromium.org>
Cc: heiko@sntech.de, airlied@linux.ie, michel.daenzer@amd.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Jerry.Zhang@amd.com, thierry.reding@gmail.com, daniel.vetter@intel.com, baoyou.xie@linaro.org, ville.syrjala@linux.intel.com, AlexBin.Xie@amd.com, tom.stdenis@amd.com, David1.Zhou@amd.com, mario.kleiner.de@gmail.com, linux-samsung-soc@vger.kernel.org, joe@perches.com, jy0922.shim@samsung.com, linux-mediatek@lists.infradead.org, linux@armlinux.org.uk, krzk@kernel.org, jonathanh@nvidia.com, linux-rockchip@lists.infradead.org, tomi.valkeinen@ti.com, bskeggs@redhat.com, nouveau@lists.freedesktop.org, ck.hu@mediatek.com, kyungmin.park@samsung.com, Xiaojie.Yuan@amd.com, harry.wentland@amd.com, alexandre.f.demers@gmail.com, Andrey.Grodzovsky@amd.com, linux-tegra@vger.kernel.org, Joe Kniss <djmk@google.com>, linux-arm-msm@vger.kernel.orginte
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 08, 2017 at 04:42:37PM -0700, Joe Kniss wrote:
> Because all drivers currently use gem objects for framebuffer planes,
> the virtual create_handle() is not required.  This change adds a
> struct drm_gem_object *gems[4] field to drm_framebuffer and removes
> create_handle() function pointer from drm_framebuffer_funcs.  The
> corresponding *_create_handle() function is removed from each driver.
> 
> In many cases this change eliminates a struct *_framebuffer object,
> as the only need for the derived struct is the addition of the gem
> object pointer.

Hi Joe,
Thank you for the patch.

I think this would be easier to review if it were in 3 pieces:
1/3- add gem_objs to fb
2/3- driver conversion to gem_objs
3/3- remove create_handle()
> 
> TESTED: compiled: allyesconfig ARCH=x86,arm platforms:i915, rockchip

Aside from Dave's comment about vmwgfx, I'm also getting link errors:
ERROR: "mtk_fb_get_gem_obj" [drivers/gpu/drm/mediatek/mediatek-drm.ko] undefined!

Consider using the drm-misc configs located here for your compile tests:
https://cgit.freedesktop.org/drm/drm-tip/tree/?h=rerere-cache

Sean
> 
> Signed-off-by: Joe Kniss <djmk@google.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  6 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c  | 50 +++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c       | 20 +++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h     |  8 +--
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c       | 19 +++----
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c       | 19 +++----
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c        | 19 +++----
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c        | 19 +++----
>  drivers/gpu/drm/amd/amdgpu/dce_virtual.c     |  6 +--
>  drivers/gpu/drm/armada/armada_crtc.c         |  2 +-
>  drivers/gpu/drm/armada/armada_fb.c           | 13 ++---
>  drivers/gpu/drm/armada/armada_fb.h           |  2 -
>  drivers/gpu/drm/drm_fb_cma_helper.c          | 78 ++++++++++------------------
>  drivers/gpu/drm/drm_framebuffer.c            | 27 +++++-----
>  drivers/gpu/drm/exynos/exynos_drm_fb.c       | 61 +++++++---------------
>  drivers/gpu/drm/gma500/accel_2d.c            |  2 +-
>  drivers/gpu/drm/gma500/framebuffer.c         | 40 +++-----------
>  drivers/gpu/drm/gma500/framebuffer.h         |  3 +-
>  drivers/gpu/drm/gma500/gma_display.c         |  8 +--
>  drivers/gpu/drm/gma500/mdfld_intel_display.c |  2 +-
>  drivers/gpu/drm/gma500/oaktrail_crtc.c       |  2 +-
>  drivers/gpu/drm/i915/i915_debugfs.c          |  4 +-
>  drivers/gpu/drm/i915/intel_display.c         | 47 ++++++-----------
>  drivers/gpu/drm/i915/intel_drv.h             |  3 +-
>  drivers/gpu/drm/i915/intel_fbdev.c           | 10 ++--
>  drivers/gpu/drm/mediatek/mtk_drm_fb.c        | 66 ++++++-----------------
>  drivers/gpu/drm/msm/msm_fb.c                 | 41 ++++-----------
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c      | 10 ++--
>  drivers/gpu/drm/nouveau/dispnv04/overlay.c   | 19 +++----
>  drivers/gpu/drm/nouveau/nouveau_display.c    | 45 +++++++---------
>  drivers/gpu/drm/nouveau/nouveau_display.h    |  1 -
>  drivers/gpu/drm/nouveau/nouveau_fbcon.c      | 31 ++++++-----
>  drivers/gpu/drm/nouveau/nv50_display.c       | 22 ++++----
>  drivers/gpu/drm/omapdrm/omap_fb.c            | 54 ++++++++-----------
>  drivers/gpu/drm/qxl/qxl_display.c            | 73 ++++++++++++--------------
>  drivers/gpu/drm/qxl/qxl_draw.c               |  6 +--
>  drivers/gpu/drm/qxl/qxl_drv.h                | 12 ++---
>  drivers/gpu/drm/qxl/qxl_fb.c                 | 24 ++++-----
>  drivers/gpu/drm/radeon/atombios_crtc.c       | 22 +++-----
>  drivers/gpu/drm/radeon/radeon_device.c       |  6 +--
>  drivers/gpu/drm/radeon/radeon_display.c      | 50 +++++++-----------
>  drivers/gpu/drm/radeon/radeon_fb.c           | 20 +++----
>  drivers/gpu/drm/radeon/radeon_legacy_crtc.c  | 16 +++---
>  drivers/gpu/drm/radeon/radeon_mode.h         |  8 +--
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c   | 65 ++++++++---------------
>  drivers/gpu/drm/tegra/drm.h                  |  8 +--
>  drivers/gpu/drm/tegra/fb.c                   | 64 +++++++----------------
>  drivers/gpu/drm/tinydrm/mipi-dbi.c           |  1 -
>  drivers/gpu/drm/tinydrm/repaper.c            |  1 -
>  include/drm/drm_framebuffer.h                | 26 ++--------
>  50 files changed, 420 insertions(+), 741 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6279956e92a4..6d7995c1a8f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2421,7 +2421,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool suspend, bool fbcon)
>  	/* unpin the front buffers and cursors */
>  	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
>  		struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
> -		struct amdgpu_framebuffer *rfb = to_amdgpu_framebuffer(crtc->primary->fb);
> +		struct drm_framebuffer *fb = crtc->primary->fb;
>  		struct amdgpu_bo *robj;
>  
>  		if (amdgpu_crtc->cursor_bo) {
> @@ -2433,10 +2433,10 @@ int amdgpu_device_suspend(struct drm_device *dev, bool suspend, bool fbcon)
>  			}
>  		}
>  
> -		if (rfb == NULL || rfb->obj == NULL) {
> +		if (fb == NULL || fb->gem_objs[0] == NULL) {
>  			continue;
>  		}
> -		robj = gem_to_amdgpu_bo(rfb->obj);
> +		robj = gem_to_amdgpu_bo(fb->gem_objs[0]);
>  		/* don't unpin kernel fb objects */
>  		if (!amdgpu_fbdev_robj_is_fb(adev, robj)) {
>  			r = amdgpu_bo_reserve(robj, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index cdf2ab20166a..0fd57b0d9571 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -147,8 +147,8 @@ int amdgpu_crtc_page_flip_target(struct drm_crtc *crtc,
>  	struct drm_device *dev = crtc->dev;
>  	struct amdgpu_device *adev = dev->dev_private;
>  	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
> -	struct amdgpu_framebuffer *old_amdgpu_fb;
> -	struct amdgpu_framebuffer *new_amdgpu_fb;
> +	struct drm_framebuffer *old_fb;
> +	struct drm_framebuffer *new_fb;
>  	struct drm_gem_object *obj;
>  	struct amdgpu_flip_work *work;
>  	struct amdgpu_bo *new_abo;
> @@ -170,15 +170,15 @@ int amdgpu_crtc_page_flip_target(struct drm_crtc *crtc,
>  	work->async = (page_flip_flags & DRM_MODE_PAGE_FLIP_ASYNC) != 0;
>  
>  	/* schedule unpin of the old buffer */
> -	old_amdgpu_fb = to_amdgpu_framebuffer(crtc->primary->fb);
> -	obj = old_amdgpu_fb->obj;
> +	old_fb = crtc->primary->fb;
> +	obj = old_fb->gem_objs[0];
>  
>  	/* take a reference to the old object */
>  	work->old_abo = gem_to_amdgpu_bo(obj);
>  	amdgpu_bo_ref(work->old_abo);
>  
> -	new_amdgpu_fb = to_amdgpu_framebuffer(fb);
> -	obj = new_amdgpu_fb->obj;
> +	new_fb = fb;
> +	obj = new_fb->gem_objs[0];
>  	new_abo = gem_to_amdgpu_bo(obj);
>  
>  	/* pin the new buffer */
> @@ -480,39 +480,27 @@ bool amdgpu_ddc_probe(struct amdgpu_connector *amdgpu_connector,
>  
>  static void amdgpu_user_framebuffer_destroy(struct drm_framebuffer *fb)
>  {
> -	struct amdgpu_framebuffer *amdgpu_fb = to_amdgpu_framebuffer(fb);
> -
> -	drm_gem_object_unreference_unlocked(amdgpu_fb->obj);
> +	drm_gem_object_unreference_unlocked(fb->gem_objs[0]);
>  	drm_framebuffer_cleanup(fb);
> -	kfree(amdgpu_fb);
> -}
> -
> -static int amdgpu_user_framebuffer_create_handle(struct drm_framebuffer *fb,
> -						  struct drm_file *file_priv,
> -						  unsigned int *handle)
> -{
> -	struct amdgpu_framebuffer *amdgpu_fb = to_amdgpu_framebuffer(fb);
> -
> -	return drm_gem_handle_create(file_priv, amdgpu_fb->obj, handle);
> +	kfree(fb);
>  }
>  
>  static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
>  	.destroy = amdgpu_user_framebuffer_destroy,
> -	.create_handle = amdgpu_user_framebuffer_create_handle,
>  };
>  
>  int
>  amdgpu_framebuffer_init(struct drm_device *dev,
> -			struct amdgpu_framebuffer *rfb,
> +			struct drm_framebuffer *fb,
>  			const struct drm_mode_fb_cmd2 *mode_cmd,
>  			struct drm_gem_object *obj)
>  {
>  	int ret;
> -	rfb->obj = obj;
> -	drm_helper_mode_fill_fb_struct(dev, &rfb->base, mode_cmd);
> -	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
> +	fb->gem_objs[0] = obj;
> +	drm_helper_mode_fill_fb_struct(dev, fb, mode_cmd);
> +	ret = drm_framebuffer_init(dev, fb, &amdgpu_fb_funcs);
>  	if (ret) {
> -		rfb->obj = NULL;
> +		fb->gem_objs[0] = NULL;
>  		return ret;
>  	}
>  	return 0;
> @@ -524,7 +512,7 @@ amdgpu_user_framebuffer_create(struct drm_device *dev,
>  			       const struct drm_mode_fb_cmd2 *mode_cmd)
>  {
>  	struct drm_gem_object *obj;
> -	struct amdgpu_framebuffer *amdgpu_fb;
> +	struct drm_framebuffer *fb;
>  	int ret;
>  
>  	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
> @@ -540,20 +528,20 @@ amdgpu_user_framebuffer_create(struct drm_device *dev,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	amdgpu_fb = kzalloc(sizeof(*amdgpu_fb), GFP_KERNEL);
> -	if (amdgpu_fb == NULL) {
> +	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
> +	if (fb == NULL) {
>  		drm_gem_object_unreference_unlocked(obj);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> -	ret = amdgpu_framebuffer_init(dev, amdgpu_fb, mode_cmd, obj);
> +	ret = amdgpu_framebuffer_init(dev, fb, mode_cmd, obj);
>  	if (ret) {
> -		kfree(amdgpu_fb);
> +		kfree(fb);
>  		drm_gem_object_unreference_unlocked(obj);
>  		return ERR_PTR(ret);
>  	}
>  
> -	return &amdgpu_fb->base;
> +	return fb;
>  }
>  
>  static void amdgpu_output_poll_changed(struct drm_device *dev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> index 1c57fefc364c..a83455d23888 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> @@ -44,7 +44,7 @@
>  */
>  struct amdgpu_fbdev {
>  	struct drm_fb_helper helper;
> -	struct amdgpu_framebuffer rfb;
> +	struct drm_framebuffer rfb;
>  	struct amdgpu_device *adev;
>  };
>  
> @@ -236,7 +236,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
>  		goto out;
>  	}
>  
> -	fb = &rfbdev->rfb.base;
> +	fb = &rfbdev->rfb;
>  
>  	/* setup helper */
>  	rfbdev->helper.fb = fb;
> @@ -296,17 +296,17 @@ void amdgpu_fb_output_poll_changed(struct amdgpu_device *adev)
>  
>  static int amdgpu_fbdev_destroy(struct drm_device *dev, struct amdgpu_fbdev *rfbdev)
>  {
> -	struct amdgpu_framebuffer *rfb = &rfbdev->rfb;
> +	struct drm_framebuffer *rfb = &rfbdev->rfb;
>  
>  	drm_fb_helper_unregister_fbi(&rfbdev->helper);
>  
> -	if (rfb->obj) {
> -		amdgpufb_destroy_pinned_object(rfb->obj);
> -		rfb->obj = NULL;
> +	if (rfb->gem_objs[0]) {
> +		amdgpufb_destroy_pinned_object(rfb->gem_objs[0]);
> +		rfb->gem_objs[0] = NULL;
>  	}
>  	drm_fb_helper_fini(&rfbdev->helper);
> -	drm_framebuffer_unregister_private(&rfb->base);
> -	drm_framebuffer_cleanup(&rfb->base);
> +	drm_framebuffer_unregister_private(rfb);
> +	drm_framebuffer_cleanup(rfb);
>  
>  	return 0;
>  }
> @@ -408,7 +408,7 @@ int amdgpu_fbdev_total_size(struct amdgpu_device *adev)
>  	if (!adev->mode_info.rfbdev)
>  		return 0;
>  
> -	robj = gem_to_amdgpu_bo(adev->mode_info.rfbdev->rfb.obj);
> +	robj = gem_to_amdgpu_bo(adev->mode_info.rfbdev->rfb.gem_objs[0]);
>  	size += amdgpu_bo_size(robj);
>  	return size;
>  }
> @@ -417,7 +417,7 @@ bool amdgpu_fbdev_robj_is_fb(struct amdgpu_device *adev, struct amdgpu_bo *robj)
>  {
>  	if (!adev->mode_info.rfbdev)
>  		return false;
> -	if (robj == gem_to_amdgpu_bo(adev->mode_info.rfbdev->rfb.obj))
> +	if (robj == gem_to_amdgpu_bo(adev->mode_info.rfbdev->rfb.gem_objs[0]))
>  		return true;
>  	return false;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index b8abd4e18d51..02f3bebb56eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -52,7 +52,6 @@ struct amdgpu_hpd;
>  #define to_amdgpu_crtc(x) container_of(x, struct amdgpu_crtc, base)
>  #define to_amdgpu_connector(x) container_of(x, struct amdgpu_connector, base)
>  #define to_amdgpu_encoder(x) container_of(x, struct amdgpu_encoder, base)
> -#define to_amdgpu_framebuffer(x) container_of(x, struct amdgpu_framebuffer, base)
>  
>  #define AMDGPU_MAX_HPD_PINS 6
>  #define AMDGPU_MAX_CRTCS 6
> @@ -513,11 +512,6 @@ struct amdgpu_connector {
>  	unsigned pixelclock_for_modeset;
>  };
>  
> -struct amdgpu_framebuffer {
> -	struct drm_framebuffer base;
> -	struct drm_gem_object *obj;
> -};
> -
>  #define ENCODER_MODE_IS_DP(em) (((em) == ATOM_ENCODER_MODE_DP) || \
>  				((em) == ATOM_ENCODER_MODE_DP_MST))
>  
> @@ -550,7 +544,7 @@ int amdgpu_get_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
>  			       const struct drm_display_mode *mode);
>  
>  int amdgpu_framebuffer_init(struct drm_device *dev,
> -			     struct amdgpu_framebuffer *rfb,
> +			     struct drm_framebuffer *fb,
>  			     const struct drm_mode_fb_cmd2 *mode_cmd,
>  			     struct drm_gem_object *obj);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index 4b6e2f7bfec9..0798f551458a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -1883,7 +1883,6 @@ static int dce_v10_0_crtc_do_set_base(struct drm_crtc *crtc,
>  	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
>  	struct drm_device *dev = crtc->dev;
>  	struct amdgpu_device *adev = dev->dev_private;
> -	struct amdgpu_framebuffer *amdgpu_fb;
>  	struct drm_framebuffer *target_fb;
>  	struct drm_gem_object *obj;
>  	struct amdgpu_bo *abo;
> @@ -1902,18 +1901,15 @@ static int dce_v10_0_crtc_do_set_base(struct drm_crtc *crtc,
>  		return 0;
>  	}
>  
> -	if (atomic) {
> -		amdgpu_fb = to_amdgpu_framebuffer(fb);
> +	if (atomic)
>  		target_fb = fb;
> -	} else {
> -		amdgpu_fb = to_amdgpu_framebuffer(crtc->primary->fb);
> +	else
>  		target_fb = crtc->primary->fb;
> -	}
>  
>  	/* If atomic, assume fb object is pinned & idle & fenced and
>  	 * just update base pointers
>  	 */
> -	obj = amdgpu_fb->obj;
> +	obj = target_fb->gem_objs[0];
>  	abo = gem_to_amdgpu_bo(obj);
>  	r = amdgpu_bo_reserve(abo, false);
>  	if (unlikely(r != 0))
> @@ -2103,8 +2099,7 @@ static int dce_v10_0_crtc_do_set_base(struct drm_crtc *crtc,
>  	WREG32(mmMASTER_UPDATE_MODE + amdgpu_crtc->crtc_offset, 0);
>  
>  	if (!atomic && fb && fb != crtc->primary->fb) {
> -		amdgpu_fb = to_amdgpu_framebuffer(fb);
> -		abo = gem_to_amdgpu_bo(amdgpu_fb->obj);
> +		abo = gem_to_amdgpu_bo(fb->gem_objs[0]);
>  		r = amdgpu_bo_reserve(abo, true);
>  		if (unlikely(r != 0))
>  			return r;
> @@ -2590,11 +2585,11 @@ static void dce_v10_0_crtc_disable(struct drm_crtc *crtc)
>  	dce_v10_0_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
>  	if (crtc->primary->fb) {
>  		int r;
> -		struct amdgpu_framebuffer *amdgpu_fb;
> +		struct drm_framebuffer *fb;
>  		struct amdgpu_bo *abo;
>  
> -		amdgpu_fb = to_amdgpu_framebuffer(crtc->primary->fb);
> -		abo = gem_to_amdgpu_bo(amdgpu_fb->obj);
> +		fb = crtc->primary->fb;
> +		abo = gem_to_amdgpu_bo(fb->gem_objs[0]);
>  		r = amdgpu_bo_reserve(abo, true);
>  		if (unlikely(r))
>  			DRM_ERROR("failed to reserve abo before unpin\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> index 6af489872ffd..495271ad6409 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> @@ -1922,7 +1922,6 @@ static int dce_v11_0_crtc_do_set_base(struct drm_crtc *crtc,
>  	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
>  	struct drm_device *dev = crtc->dev;
>  	struct amdgpu_device *adev = dev->dev_private;
> -	struct amdgpu_framebuffer *amdgpu_fb;
>  	struct drm_framebuffer *target_fb;
>  	struct drm_gem_object *obj;
>  	struct amdgpu_bo *abo;
> @@ -1941,18 +1940,15 @@ static int dce_v11_0_crtc_do_set_base(struct drm_crtc *crtc,
>  		return 0;
>  	}
>  
> -	if (atomic) {
> -		amdgpu_fb = to_amdgpu_framebuffer(fb);
> +	if (atomic)
>  		target_fb = fb;
> -	} else {
> -		amdgpu_fb = to_amdgpu_framebuffer(crtc->primary->fb);
> +	else
>  		target_fb = crtc->primary->fb;
> -	}
>  
>  	/* If atomic, assume fb object is pinned & idle & fenced and
>  	 * just update base pointers
>  	 */
> -	obj = amdgpu_fb->obj;
> +	obj = target_fb->gem_objs[0];
>  	abo = gem_to_amdgpu_bo(obj);
>  	r = amdgpu_bo_reserve(abo, false);
>  	if (unlikely(r != 0))
> @@ -2142,8 +2138,7 @@ static int dce_v11_0_crtc_do_set_base(struct drm_crtc *crtc,
>  	WREG32(mmCRTC_MASTER_UPDATE_MODE + amdgpu_crtc->crtc_offset, 0);
>  
>  	if (!atomic && fb && fb != crtc->primary->fb) {
> -		amdgpu_fb = to_amdgpu_framebuffer(fb);
> -		abo = gem_to_amdgpu_bo(amdgpu_fb->obj);
> +		abo = gem_to_amdgpu_bo(fb->gem_objs[0]);
>  		r = amdgpu_bo_reserve(abo, true);
>  		if (unlikely(r != 0))
>  			return r;
> @@ -2665,11 +2660,11 @@ static void dce_v11_0_crtc_disable(struct drm_crtc *crtc)
>  	dce_v11_0_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
>  	if (crtc->primary->fb) {
>  		int r;
> -		struct amdgpu_framebuffer *amdgpu_fb;
> +		struct drm_framebuffer *fb;
>  		struct amdgpu_bo *abo;
>  
> -		amdgpu_fb = to_amdgpu_framebuffer(crtc->primary->fb);
> -		abo = gem_to_amdgpu_bo(amdgpu_fb->obj);
> +		fb = crtc->primary->fb;
> +		abo = gem_to_amdgpu_bo(fb->gem_objs[0]);
>  		r = amdgpu_bo_reserve(abo, true);
>  		if (unlikely(r))
>  			DRM_ERROR("failed to reserve abo before unpin\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index 126c5e4e7733..bd53bce33353 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -1837,7 +1837,6 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
>  	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
>  	struct drm_device *dev = crtc->dev;
>  	struct amdgpu_device *adev = dev->dev_private;
> -	struct amdgpu_framebuffer *amdgpu_fb;
>  	struct drm_framebuffer *target_fb;
>  	struct drm_gem_object *obj;
>  	struct amdgpu_bo *abo;
> @@ -1855,18 +1854,15 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
>  		return 0;
>  	}
>  
> -	if (atomic) {
> -		amdgpu_fb = to_amdgpu_framebuffer(fb);
> +	if (atomic)
>  		target_fb = fb;
> -	} else {
> -		amdgpu_fb = to_amdgpu_framebuffer(crtc->primary->fb);
> +	else
>  		target_fb = crtc->primary->fb;
> -	}
>  
>  	/* If atomic, assume fb object is pinned & idle & fenced and
>  	 * just update base pointers
>  	 */
> -	obj = amdgpu_fb->obj;
> +	obj = target_fb->gem_objs[0];
>  	abo = gem_to_amdgpu_bo(obj);
>  	r = amdgpu_bo_reserve(abo, false);
>  	if (unlikely(r != 0))
> @@ -2035,8 +2031,7 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
>  	WREG32(mmMASTER_UPDATE_MODE + amdgpu_crtc->crtc_offset, 0);
>  
>  	if (!atomic && fb && fb != crtc->primary->fb) {
> -		amdgpu_fb = to_amdgpu_framebuffer(fb);
> -		abo = gem_to_amdgpu_bo(amdgpu_fb->obj);
> +		abo = gem_to_amdgpu_bo(fb->gem_objs[0]);
>  		r = amdgpu_bo_reserve(abo, true);
>  		if (unlikely(r != 0))
>  			return r;
> @@ -2475,11 +2470,11 @@ static void dce_v6_0_crtc_disable(struct drm_crtc *crtc)
>  	dce_v6_0_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
>  	if (crtc->primary->fb) {
>  		int r;
> -		struct amdgpu_framebuffer *amdgpu_fb;
> +		struct drm_framebuffer *fb;
>  		struct amdgpu_bo *abo;
>  
> -		amdgpu_fb = to_amdgpu_framebuffer(crtc->primary->fb);
> -		abo = gem_to_amdgpu_bo(amdgpu_fb->obj);
> +		fb = crtc->primary->fb;
> +		abo = gem_to_amdgpu_bo(fb->gem_objs[0]);
>  		r = amdgpu_bo_reserve(abo, true);
>  		if (unlikely(r))
>  			DRM_ERROR("failed to reserve abo before unpin\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index c0740adee46f..158b985086e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -1814,7 +1814,6 @@ static int dce_v8_0_crtc_do_set_base(struct drm_crtc *crtc,
>  	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
>  	struct drm_device *dev = crtc->dev;
>  	struct amdgpu_device *adev = dev->dev_private;
> -	struct amdgpu_framebuffer *amdgpu_fb;
>  	struct drm_framebuffer *target_fb;
>  	struct drm_gem_object *obj;
>  	struct amdgpu_bo *abo;
> @@ -1833,18 +1832,15 @@ static int dce_v8_0_crtc_do_set_base(struct drm_crtc *crtc,
>  		return 0;
>  	}
>  
> -	if (atomic) {
> -		amdgpu_fb = to_amdgpu_framebuffer(fb);
> +	if (atomic)
>  		target_fb = fb;
> -	} else {
> -		amdgpu_fb = to_amdgpu_framebuffer(crtc->primary->fb);
> +	else
>  		target_fb = crtc->primary->fb;
> -	}
>  
>  	/* If atomic, assume fb object is pinned & idle & fenced and
>  	 * just update base pointers
>  	 */
> -	obj = amdgpu_fb->obj;
> +	obj = target_fb->gem_objs[0];
>  	abo = gem_to_amdgpu_bo(obj);
>  	r = amdgpu_bo_reserve(abo, false);
>  	if (unlikely(r != 0))
> @@ -2015,8 +2011,7 @@ static int dce_v8_0_crtc_do_set_base(struct drm_crtc *crtc,
>  	WREG32(mmMASTER_UPDATE_MODE + amdgpu_crtc->crtc_offset, 0);
>  
>  	if (!atomic && fb && fb != crtc->primary->fb) {
> -		amdgpu_fb = to_amdgpu_framebuffer(fb);
> -		abo = gem_to_amdgpu_bo(amdgpu_fb->obj);
> +		abo = gem_to_amdgpu_bo(fb->gem_objs[0]);
>  		r = amdgpu_bo_reserve(abo, true);
>  		if (unlikely(r != 0))
>  			return r;
> @@ -2494,11 +2489,11 @@ static void dce_v8_0_crtc_disable(struct drm_crtc *crtc)
>  	dce_v8_0_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
>  	if (crtc->primary->fb) {
>  		int r;
> -		struct amdgpu_framebuffer *amdgpu_fb;
> +		struct drm_framebuffer *fb;
>  		struct amdgpu_bo *abo;
>  
> -		amdgpu_fb = to_amdgpu_framebuffer(crtc->primary->fb);
> -		abo = gem_to_amdgpu_bo(amdgpu_fb->obj);
> +		fb = crtc->primary->fb;
> +		abo = gem_to_amdgpu_bo(fb->gem_objs[0]);
>  		r = amdgpu_bo_reserve(abo, true);
>  		if (unlikely(r))
>  			DRM_ERROR("failed to reserve abo before unpin\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> index 0d2f060206dc..6033eacf7fce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> @@ -187,11 +187,11 @@ static void dce_virtual_crtc_disable(struct drm_crtc *crtc)
>  	dce_virtual_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
>  	if (crtc->primary->fb) {
>  		int r;
> -		struct amdgpu_framebuffer *amdgpu_fb;
> +		struct drm_framebuffer *fb;
>  		struct amdgpu_bo *abo;
>  
> -		amdgpu_fb = to_amdgpu_framebuffer(crtc->primary->fb);
> -		abo = gem_to_amdgpu_bo(amdgpu_fb->obj);
> +		fb = crtc->primary->fb;
> +		abo = gem_to_amdgpu_bo(fb->gem_objs[0]);
>  		r = amdgpu_bo_reserve(abo, true);
>  		if (unlikely(r))
>  			DRM_ERROR("failed to reserve abo before unpin\n");
> diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
> index 1ffba91fbaae..d3360d02f3c7 100644
> --- a/drivers/gpu/drm/armada/armada_crtc.c
> +++ b/drivers/gpu/drm/armada/armada_crtc.c
> @@ -168,7 +168,7 @@ static void armada_drm_crtc_update(struct armada_crtc *dcrtc)
>  void armada_drm_plane_calc_addrs(u32 *addrs, struct drm_framebuffer *fb,
>  	int x, int y)
>  {
> -	u32 addr = drm_fb_obj(fb)->dev_addr;
> +	u32 addr = drm_to_armada_gem(fb->gem_objs[0])->dev_addr;
>  	int num_planes = fb->format->num_planes;
>  	int i;
>  
> diff --git a/drivers/gpu/drm/armada/armada_fb.c b/drivers/gpu/drm/armada/armada_fb.c
> index 92e6b08ea64a..b7fd50b347d5 100644
> --- a/drivers/gpu/drm/armada/armada_fb.c
> +++ b/drivers/gpu/drm/armada/armada_fb.c
> @@ -18,20 +18,12 @@ static void armada_fb_destroy(struct drm_framebuffer *fb)
>  	struct armada_framebuffer *dfb = drm_fb_to_armada_fb(fb);
>  
>  	drm_framebuffer_cleanup(&dfb->fb);
> -	drm_gem_object_unreference_unlocked(&dfb->obj->obj);
> +	drm_gem_object_unreference_unlocked(fb->gem_objs[0]);
>  	kfree(dfb);
>  }
>  
> -static int armada_fb_create_handle(struct drm_framebuffer *fb,
> -	struct drm_file *dfile, unsigned int *handle)
> -{
> -	struct armada_framebuffer *dfb = drm_fb_to_armada_fb(fb);
> -	return drm_gem_handle_create(dfile, &dfb->obj->obj, handle);
> -}
> -
>  static const struct drm_framebuffer_funcs armada_fb_funcs = {
>  	.destroy	= armada_fb_destroy,
> -	.create_handle	= armada_fb_create_handle,
>  };
>  
>  struct armada_framebuffer *armada_framebuffer_create(struct drm_device *dev,
> @@ -79,10 +71,11 @@ struct armada_framebuffer *armada_framebuffer_create(struct drm_device *dev,
>  
>  	dfb->fmt = format;
>  	dfb->mod = config;
> -	dfb->obj = obj;
>  
>  	drm_helper_mode_fill_fb_struct(dev, &dfb->fb, mode);
>  
> +	dfb->fb.gem_objs[0] = &obj->obj;
> +
>  	ret = drm_framebuffer_init(dev, &dfb->fb, &armada_fb_funcs);
>  	if (ret) {
>  		kfree(dfb);
> diff --git a/drivers/gpu/drm/armada/armada_fb.h b/drivers/gpu/drm/armada/armada_fb.h
> index 48073c4f54d8..8f8718e5318b 100644
> --- a/drivers/gpu/drm/armada/armada_fb.h
> +++ b/drivers/gpu/drm/armada/armada_fb.h
> @@ -10,13 +10,11 @@
>  
>  struct armada_framebuffer {
>  	struct drm_framebuffer	fb;
> -	struct armada_gem_object *obj;
>  	uint8_t			fmt;
>  	uint8_t			mod;
>  };
>  #define drm_fb_to_armada_fb(dfb) \
>  	container_of(dfb, struct armada_framebuffer, fb)
> -#define drm_fb_obj(fb) drm_fb_to_armada_fb(fb)->obj
>  
>  struct armada_framebuffer *armada_framebuffer_create(struct drm_device *,
>  	const struct drm_mode_fb_cmd2 *, struct armada_gem_object *);
> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
> index ade319d10e70..f5f011b910b1 100644
> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> @@ -31,14 +31,9 @@
>  
>  #define DEFAULT_FBDEFIO_DELAY_MS 50
>  
> -struct drm_fb_cma {
> -	struct drm_framebuffer		fb;
> -	struct drm_gem_cma_object	*obj[4];
> -};
> -
>  struct drm_fbdev_cma {
>  	struct drm_fb_helper	fb_helper;
> -	struct drm_fb_cma	*fb;
> +	struct drm_framebuffer	*fb;
>  	const struct drm_framebuffer_funcs *fb_funcs;
>  };
>  
> @@ -72,7 +67,6 @@ struct drm_fbdev_cma {
>   *
>   *     static struct drm_framebuffer_funcs driver_fb_funcs = {
>   *         .destroy       = drm_fb_cma_destroy,
> - *         .create_handle = drm_fb_cma_create_handle,
>   *         .dirty         = driver_fb_dirty,
>   *     };
>   *
> @@ -90,67 +84,50 @@ static inline struct drm_fbdev_cma *to_fbdev_cma(struct drm_fb_helper *helper)
>  	return container_of(helper, struct drm_fbdev_cma, fb_helper);
>  }
>  
> -static inline struct drm_fb_cma *to_fb_cma(struct drm_framebuffer *fb)
> -{
> -	return container_of(fb, struct drm_fb_cma, fb);
> -}
> -
>  void drm_fb_cma_destroy(struct drm_framebuffer *fb)
>  {
> -	struct drm_fb_cma *fb_cma = to_fb_cma(fb);
>  	int i;
>  
>  	for (i = 0; i < 4; i++) {
> -		if (fb_cma->obj[i])
> -			drm_gem_object_put_unlocked(&fb_cma->obj[i]->base);
> +		if (fb->gem_objs[i])
> +			drm_gem_object_put_unlocked(fb->gem_objs[i]);
>  	}
>  
>  	drm_framebuffer_cleanup(fb);
> -	kfree(fb_cma);
> +	kfree(fb);
>  }
>  EXPORT_SYMBOL(drm_fb_cma_destroy);
>  
> -int drm_fb_cma_create_handle(struct drm_framebuffer *fb,
> -	struct drm_file *file_priv, unsigned int *handle)
> -{
> -	struct drm_fb_cma *fb_cma = to_fb_cma(fb);
> -
> -	return drm_gem_handle_create(file_priv,
> -			&fb_cma->obj[0]->base, handle);
> -}
> -EXPORT_SYMBOL(drm_fb_cma_create_handle);
> -
>  static struct drm_framebuffer_funcs drm_fb_cma_funcs = {
>  	.destroy	= drm_fb_cma_destroy,
> -	.create_handle	= drm_fb_cma_create_handle,
>  };
>  
> -static struct drm_fb_cma *drm_fb_cma_alloc(struct drm_device *dev,
> +static struct drm_framebuffer *drm_fb_cma_alloc(struct drm_device *dev,
>  	const struct drm_mode_fb_cmd2 *mode_cmd,
>  	struct drm_gem_cma_object **obj,
>  	unsigned int num_planes, const struct drm_framebuffer_funcs *funcs)
>  {
> -	struct drm_fb_cma *fb_cma;
> +	struct drm_framebuffer *fb;
>  	int ret;
>  	int i;
>  
> -	fb_cma = kzalloc(sizeof(*fb_cma), GFP_KERNEL);
> -	if (!fb_cma)
> +	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
> +	if (!fb)
>  		return ERR_PTR(-ENOMEM);
>  
> -	drm_helper_mode_fill_fb_struct(dev, &fb_cma->fb, mode_cmd);
> +	drm_helper_mode_fill_fb_struct(dev, fb, mode_cmd);
>  
>  	for (i = 0; i < num_planes; i++)
> -		fb_cma->obj[i] = obj[i];
> +		fb->gem_objs[i] = &obj[i]->base;
>  
> -	ret = drm_framebuffer_init(dev, &fb_cma->fb, funcs);
> +	ret = drm_framebuffer_init(dev, fb, funcs);
>  	if (ret) {
>  		dev_err(dev->dev, "Failed to initialize framebuffer: %d\n", ret);
> -		kfree(fb_cma);
> +		kfree(fb);
>  		return ERR_PTR(ret);
>  	}
>  
> -	return fb_cma;
> +	return fb;
>  }
>  
>  /**
> @@ -171,7 +148,7 @@ struct drm_framebuffer *drm_fb_cma_create_with_funcs(struct drm_device *dev,
>  	const struct drm_framebuffer_funcs *funcs)
>  {
>  	const struct drm_format_info *info;
> -	struct drm_fb_cma *fb_cma;
> +	struct drm_framebuffer *fb;
>  	struct drm_gem_cma_object *objs[4];
>  	struct drm_gem_object *obj;
>  	int ret;
> @@ -205,13 +182,13 @@ struct drm_framebuffer *drm_fb_cma_create_with_funcs(struct drm_device *dev,
>  		objs[i] = to_drm_gem_cma_obj(obj);
>  	}
>  
> -	fb_cma = drm_fb_cma_alloc(dev, mode_cmd, objs, i, funcs);
> -	if (IS_ERR(fb_cma)) {
> -		ret = PTR_ERR(fb_cma);
> +	fb = drm_fb_cma_alloc(dev, mode_cmd, objs, i, funcs);
> +	if (IS_ERR(fb)) {
> +		ret = PTR_ERR(fb);
>  		goto err_gem_object_put;
>  	}
>  
> -	return &fb_cma->fb;
> +	return fb;
>  
>  err_gem_object_put:
>  	for (i--; i >= 0; i--)
> @@ -250,12 +227,10 @@ EXPORT_SYMBOL_GPL(drm_fb_cma_create);
>  struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct drm_framebuffer *fb,
>  						  unsigned int plane)
>  {
> -	struct drm_fb_cma *fb_cma = to_fb_cma(fb);
> -
>  	if (plane >= 4)
>  		return NULL;
>  
> -	return fb_cma->obj[plane];
> +	return to_drm_gem_cma_obj(fb->gem_objs[plane]);
>  }
>  EXPORT_SYMBOL_GPL(drm_fb_cma_get_gem_obj);
>  
> @@ -272,13 +247,13 @@ dma_addr_t drm_fb_cma_get_gem_addr(struct drm_framebuffer *fb,
>  				   struct drm_plane_state *state,
>  				   unsigned int plane)
>  {
> -	struct drm_fb_cma *fb_cma = to_fb_cma(fb);
> +	struct drm_gem_cma_object *cma_bo = drm_fb_cma_get_gem_obj(fb, plane);
>  	dma_addr_t paddr;
>  
> -	if (plane >= 4)
> +	if (!cma_bo)
>  		return 0;
>  
> -	paddr = fb_cma->obj[plane]->paddr + fb->offsets[plane];
> +	paddr = cma_bo->paddr + fb->offsets[plane];
>  	paddr += fb->format->cpp[plane] * (state->src_x >> 16);
>  	paddr += fb->pitches[plane] * (state->src_y >> 16);
>  
> @@ -321,7 +296,6 @@ EXPORT_SYMBOL_GPL(drm_fb_cma_prepare_fb);
>  #ifdef CONFIG_DEBUG_FS
>  static void drm_fb_cma_describe(struct drm_framebuffer *fb, struct seq_file *m)
>  {
> -	struct drm_fb_cma *fb_cma = to_fb_cma(fb);
>  	int i;
>  
>  	seq_printf(m, "fb: %dx%d@%4.4s\n", fb->width, fb->height,
> @@ -330,7 +304,7 @@ static void drm_fb_cma_describe(struct drm_framebuffer *fb, struct seq_file *m)
>  	for (i = 0; i < fb->format->num_planes; i++) {
>  		seq_printf(m, "   %d: offset=%d pitch=%d, obj: ",
>  				i, fb->offsets[i], fb->pitches[i]);
> -		drm_gem_cma_describe(fb_cma->obj[i], m);
> +		drm_gem_cma_describe(drm_fb_cma_get_gem_obj(fb, i), m);
>  	}
>  }
>  
> @@ -472,7 +446,7 @@ drm_fbdev_cma_create(struct drm_fb_helper *helper,
>  		goto err_fb_info_destroy;
>  	}
>  
> -	fb = &fbdev_cma->fb->fb;
> +	fb = fbdev_cma->fb;
>  	helper->fb = fb;
>  
>  	fbi->par = helper;
> @@ -500,7 +474,7 @@ drm_fbdev_cma_create(struct drm_fb_helper *helper,
>  	return 0;
>  
>  err_cma_destroy:
> -	drm_framebuffer_remove(&fbdev_cma->fb->fb);
> +	drm_framebuffer_remove(fbdev_cma->fb);
>  err_fb_info_destroy:
>  	drm_fb_helper_fini(helper);
>  err_gem_free_object:
> @@ -598,7 +572,7 @@ void drm_fbdev_cma_fini(struct drm_fbdev_cma *fbdev_cma)
>  		drm_fbdev_cma_defio_fini(fbdev_cma->fb_helper.fbdev);
>  
>  	if (fbdev_cma->fb)
> -		drm_framebuffer_remove(&fbdev_cma->fb->fb);
> +		drm_framebuffer_remove(fbdev_cma->fb);
>  
>  	drm_fb_helper_fini(&fbdev_cma->fb_helper);
>  	kfree(fbdev_cma);
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index af279844d7ce..23b6f841ae99 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -25,6 +25,7 @@
>  #include <drm/drm_auth.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_atomic.h>
> +#include <drm/drm_gem.h>
>  
>  #include "drm_crtc_internal.h"
>  
> @@ -459,22 +460,18 @@ int drm_mode_getfb(struct drm_device *dev,
>  	r->depth = fb->format->depth;
>  	r->bpp = fb->format->cpp[0] * 8;
>  	r->pitch = fb->pitches[0];
> -	if (fb->funcs->create_handle) {
> -		if (drm_is_current_master(file_priv) || capable(CAP_SYS_ADMIN) ||
> -		    drm_is_control_client(file_priv)) {
> -			ret = fb->funcs->create_handle(fb, file_priv,
> -						       &r->handle);
> -		} else {
> -			/* GET_FB() is an unprivileged ioctl so we must not
> -			 * return a buffer-handle to non-master processes! For
> -			 * backwards-compatibility reasons, we cannot make
> -			 * GET_FB() privileged, so just return an invalid handle
> -			 * for non-masters. */
> -			r->handle = 0;
> -			ret = 0;
> -		}
> +	if (drm_is_current_master(file_priv) || capable(CAP_SYS_ADMIN) ||
> +	    drm_is_control_client(file_priv)) {
> +		ret = drm_gem_handle_create(file_priv, fb->gem_objs[0],
> +					    &r->handle);
>  	} else {
> -		ret = -ENODEV;
> +		/* GET_FB() is an unprivileged ioctl so we must not
> +		 * return a buffer-handle to non-master processes! For
> +		 * backwards-compatibility reasons, we cannot make
> +		 * GET_FB() privileged, so just return an invalid handle
> +		 * for non-masters. */
> +		r->handle = 0;
> +		ret = 0;
>  	}
>  
>  	drm_framebuffer_put(fb);
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
> index ed1a648d518c..5eba0d3fc6a3 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
> @@ -26,19 +26,6 @@
>  #include "exynos_drm_iommu.h"
>  #include "exynos_drm_crtc.h"
>  
> -#define to_exynos_fb(x)	container_of(x, struct exynos_drm_fb, fb)
> -
> -/*
> - * exynos specific framebuffer structure.
> - *
> - * @fb: drm framebuffer obejct.
> - * @exynos_gem: array of exynos specific gem object containing a gem object.
> - */
> -struct exynos_drm_fb {
> -	struct drm_framebuffer	fb;
> -	struct exynos_drm_gem	*exynos_gem[MAX_FB_BUFFER];
> -	dma_addr_t			dma_addr[MAX_FB_BUFFER];
> -};
>  
>  static int check_fb_gem_memory_type(struct drm_device *drm_dev,
>  				    struct exynos_drm_gem *exynos_gem)
> @@ -68,38 +55,26 @@ static int check_fb_gem_memory_type(struct drm_device *drm_dev,
>  
>  static void exynos_drm_fb_destroy(struct drm_framebuffer *fb)
>  {
> -	struct exynos_drm_fb *exynos_fb = to_exynos_fb(fb);
>  	unsigned int i;
>  
>  	drm_framebuffer_cleanup(fb);
>  
> -	for (i = 0; i < ARRAY_SIZE(exynos_fb->exynos_gem); i++) {
> +	for (i = 0; i < ARRAY_SIZE(fb->gem_objs); i++) {
>  		struct drm_gem_object *obj;
>  
> -		if (exynos_fb->exynos_gem[i] == NULL)
> +		if (fb->gem_objs[i] == NULL)
>  			continue;
>  
> -		obj = &exynos_fb->exynos_gem[i]->base;
> +		obj = fb->gem_objs[i];
>  		drm_gem_object_unreference_unlocked(obj);
>  	}
>  
> -	kfree(exynos_fb);
> -	exynos_fb = NULL;
> -}
> -
> -static int exynos_drm_fb_create_handle(struct drm_framebuffer *fb,
> -					struct drm_file *file_priv,
> -					unsigned int *handle)
> -{
> -	struct exynos_drm_fb *exynos_fb = to_exynos_fb(fb);
> -
> -	return drm_gem_handle_create(file_priv,
> -				     &exynos_fb->exynos_gem[0]->base, handle);
> +	kfree(fb);
> +	fb = NULL;
>  }
>  
>  static const struct drm_framebuffer_funcs exynos_drm_fb_funcs = {
>  	.destroy	= exynos_drm_fb_destroy,
> -	.create_handle	= exynos_drm_fb_create_handle,
>  };
>  
>  struct drm_framebuffer *
> @@ -108,12 +83,12 @@ exynos_drm_framebuffer_init(struct drm_device *dev,
>  			    struct exynos_drm_gem **exynos_gem,
>  			    int count)
>  {
> -	struct exynos_drm_fb *exynos_fb;
> +	struct drm_framebuffer *fb;
>  	int i;
>  	int ret;
>  
> -	exynos_fb = kzalloc(sizeof(*exynos_fb), GFP_KERNEL);
> -	if (!exynos_fb)
> +	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
> +	if (!fb)
>  		return ERR_PTR(-ENOMEM);
>  
>  	for (i = 0; i < count; i++) {
> @@ -121,23 +96,21 @@ exynos_drm_framebuffer_init(struct drm_device *dev,
>  		if (ret < 0)
>  			goto err;
>  
> -		exynos_fb->exynos_gem[i] = exynos_gem[i];
> -		exynos_fb->dma_addr[i] = exynos_gem[i]->dma_addr
> -						+ mode_cmd->offsets[i];
> +		fb->gem_objs[i] = &exynos_gem[i]->base;
>  	}
>  
> -	drm_helper_mode_fill_fb_struct(dev, &exynos_fb->fb, mode_cmd);
> +	drm_helper_mode_fill_fb_struct(dev, fb, mode_cmd);
>  
> -	ret = drm_framebuffer_init(dev, &exynos_fb->fb, &exynos_drm_fb_funcs);
> +	ret = drm_framebuffer_init(dev, fb, &exynos_drm_fb_funcs);
>  	if (ret < 0) {
>  		DRM_ERROR("failed to initialize framebuffer\n");
>  		goto err;
>  	}
>  
> -	return &exynos_fb->fb;
> +	return fb;
>  
>  err:
> -	kfree(exynos_fb);
> +	kfree(fb);
>  	return ERR_PTR(ret);
>  }
>  
> @@ -179,12 +152,16 @@ exynos_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
>  
>  dma_addr_t exynos_drm_fb_dma_addr(struct drm_framebuffer *fb, int index)
>  {
> -	struct exynos_drm_fb *exynos_fb = to_exynos_fb(fb);
> +	struct exynos_drm_gem *exynos_gem;
>  
>  	if (WARN_ON_ONCE(index >= MAX_FB_BUFFER))
>  		return 0;
>  
> -	return exynos_fb->dma_addr[index];
> +	exynos_gem = to_exynos_gem(fb->gem_objs[index]);
> +	if (!exynos_gem)
> +		return 0;
> +
> +	return exynos_gem->dma_addr + fb->offsets[index];
>  }
>  
>  static struct drm_mode_config_helper_funcs exynos_drm_mode_config_helpers = {
> diff --git a/drivers/gpu/drm/gma500/accel_2d.c b/drivers/gpu/drm/gma500/accel_2d.c
> index c51d9259c7a7..b33f80b9178c 100644
> --- a/drivers/gpu/drm/gma500/accel_2d.c
> +++ b/drivers/gpu/drm/gma500/accel_2d.c
> @@ -251,7 +251,7 @@ static void psbfb_copyarea_accel(struct fb_info *info,
>  	if (!fb)
>  		return;
>  
> -	offset = psbfb->gtt->offset;
> +	offset = get_gtt_range(psbfb)->offset;
>  	stride = fb->pitches[0];
>  
>  	switch (fb->format->depth) {
> diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
> index 7da70b6c83f0..bd563ec39a2c 100644
> --- a/drivers/gpu/drm/gma500/framebuffer.c
> +++ b/drivers/gpu/drm/gma500/framebuffer.c
> @@ -41,13 +41,9 @@
>  #include "gtt.h"
>  
>  static void psb_user_framebuffer_destroy(struct drm_framebuffer *fb);
> -static int psb_user_framebuffer_create_handle(struct drm_framebuffer *fb,
> -					      struct drm_file *file_priv,
> -					      unsigned int *handle);
>  
>  static const struct drm_framebuffer_funcs psb_fb_funcs = {
>  	.destroy = psb_user_framebuffer_destroy,
> -	.create_handle = psb_user_framebuffer_create_handle,
>  };
>  
>  #define CMAP_TOHW(_val, _width) ((((_val) << (_width)) + 0x7FFF - (_val)) >> 16)
> @@ -102,11 +98,11 @@ static int psbfb_pan(struct fb_var_screeninfo *var, struct fb_info *info)
>  	 *	panning is part of the hardware that can be invoked before
>  	 *	the actual fb is mapped. In our case that isn't quite true.
>  	 */
> -	if (psbfb->gtt->npage) {
> +	if (get_gtt_range(psbfb)->npage) {
>  		/* GTT roll shifts in 4K pages, we need to shift the right
>  		   number of pages */
>  		int pages = info->fix.line_length >> 12;
> -		psb_gtt_roll(dev, psbfb->gtt, var->yoffset * pages);
> +		psb_gtt_roll(dev, get_gtt_range(psbfb), var->yoffset * pages);
>  	}
>          return 0;
>  }
> @@ -123,7 +119,7 @@ static int psbfb_vm_fault(struct vm_fault *vmf)
>  	int ret;
>  	unsigned long pfn;
>  	unsigned long phys_addr = (unsigned long)dev_priv->stolen_base +
> -				  psbfb->gtt->offset;
> +			get_gtt_range(psbfb)->offset;
>  
>  	page_num = vma_pages(vma);
>  	address = vmf->address - (vmf->pgoff << PAGE_SHIFT);
> @@ -246,7 +242,7 @@ static int psb_framebuffer_init(struct drm_device *dev,
>  		return -EINVAL;
>  
>  	drm_helper_mode_fill_fb_struct(dev, &fb->base, mode_cmd);
> -	fb->gtt = gt;
> +	fb->base.gem_objs[0] = &gt->gem;
>  	ret = drm_framebuffer_init(dev, &fb->base, &psb_fb_funcs);
>  	if (ret) {
>  		dev_err(dev->dev, "framebuffer init failed: %d\n", ret);
> @@ -540,8 +536,8 @@ static int psb_fbdev_destroy(struct drm_device *dev, struct psb_fbdev *fbdev)
>  	drm_framebuffer_unregister_private(&psbfb->base);
>  	drm_framebuffer_cleanup(&psbfb->base);
>  
> -	if (psbfb->gtt)
> -		drm_gem_object_unreference_unlocked(&psbfb->gtt->gem);
> +	if (psbfb->base.gem_objs[0])
> +		drm_gem_object_unreference_unlocked(psbfb->base.gem_objs[0]);
>  	return 0;
>  }
>  
> @@ -605,25 +601,6 @@ static void psbfb_output_poll_changed(struct drm_device *dev)
>  	drm_fb_helper_hotplug_event(&fbdev->psb_fb_helper);
>  }
>  
> -/**
> - *	psb_user_framebuffer_create_handle - add hamdle to a framebuffer
> - *	@fb: framebuffer
> - *	@file_priv: our DRM file
> - *	@handle: returned handle
> - *
> - *	Our framebuffer object is a GTT range which also contains a GEM
> - *	object. We need to turn it into a handle for userspace. GEM will do
> - *	the work for us
> - */
> -static int psb_user_framebuffer_create_handle(struct drm_framebuffer *fb,
> -					      struct drm_file *file_priv,
> -					      unsigned int *handle)
> -{
> -	struct psb_framebuffer *psbfb = to_psb_fb(fb);
> -	struct gtt_range *r = psbfb->gtt;
> -	return drm_gem_handle_create(file_priv, &r->gem, handle);
> -}
> -
>  /**
>   *	psb_user_framebuffer_destroy	-	destruct user created fb
>   *	@fb: framebuffer
> @@ -633,13 +610,10 @@ static int psb_user_framebuffer_create_handle(struct drm_framebuffer *fb,
>   */
>  static void psb_user_framebuffer_destroy(struct drm_framebuffer *fb)
>  {
> -	struct psb_framebuffer *psbfb = to_psb_fb(fb);
> -	struct gtt_range *r = psbfb->gtt;
> -
>  	/* Let DRM do its clean up */
>  	drm_framebuffer_cleanup(fb);
>  	/*  We are no longer using the resource in GEM */
> -	drm_gem_object_unreference_unlocked(&r->gem);
> +	drm_gem_object_unreference_unlocked(fb->gem_objs[0]);
>  	kfree(fb);
>  }
>  
> diff --git a/drivers/gpu/drm/gma500/framebuffer.h b/drivers/gpu/drm/gma500/framebuffer.h
> index 395f20b07aab..e9c8aa754505 100644
> --- a/drivers/gpu/drm/gma500/framebuffer.h
> +++ b/drivers/gpu/drm/gma500/framebuffer.h
> @@ -31,7 +31,6 @@ struct psb_framebuffer {
>  	struct drm_framebuffer base;
>  	struct address_space *addr_space;
>  	struct fb_info *fbdev;
> -	struct gtt_range *gtt;
>  };
>  
>  struct psb_fbdev {
> @@ -40,8 +39,8 @@ struct psb_fbdev {
>  };
>  
>  #define to_psb_fb(x) container_of(x, struct psb_framebuffer, base)
> +#define get_gtt_range(x) container_of(x->base.gem_objs[0], struct gtt_range, gem)
>  
>  extern int gma_connector_clones(struct drm_device *dev, int type_mask);
>  
>  #endif
> -
> diff --git a/drivers/gpu/drm/gma500/gma_display.c b/drivers/gpu/drm/gma500/gma_display.c
> index e7fd356acf2e..ce856a65c2c8 100644
> --- a/drivers/gpu/drm/gma500/gma_display.c
> +++ b/drivers/gpu/drm/gma500/gma_display.c
> @@ -78,10 +78,10 @@ int gma_pipe_set_base(struct drm_crtc *crtc, int x, int y,
>  
>  	/* We are displaying this buffer, make sure it is actually loaded
>  	   into the GTT */
> -	ret = psb_gtt_pin(psbfb->gtt);
> +	ret = psb_gtt_pin(get_gtt_range(psbfb));
>  	if (ret < 0)
>  		goto gma_pipe_set_base_exit;
> -	start = psbfb->gtt->offset;
> +	start = get_gtt_range(psbfb)->offset;
>  	offset = y * fb->pitches[0] + x * fb->format->cpp[0];
>  
>  	REG_WRITE(map->stride, fb->pitches[0]);
> @@ -129,7 +129,7 @@ int gma_pipe_set_base(struct drm_crtc *crtc, int x, int y,
>  gma_pipe_cleaner:
>  	/* If there was a previous display we can now unpin it */
>  	if (old_fb)
> -		psb_gtt_unpin(to_psb_fb(old_fb)->gtt);
> +		psb_gtt_unpin(get_gtt_range(to_psb_fb(old_fb)));
>  
>  gma_pipe_set_base_exit:
>  	gma_power_end(dev);
> @@ -501,7 +501,7 @@ void gma_crtc_disable(struct drm_crtc *crtc)
>  	crtc_funcs->dpms(crtc, DRM_MODE_DPMS_OFF);
>  
>  	if (crtc->primary->fb) {
> -		gt = to_psb_fb(crtc->primary->fb)->gtt;
> +		gt = get_gtt_range(to_psb_fb(crtc->primary->fb));
>  		psb_gtt_unpin(gt);
>  	}
>  }
> diff --git a/drivers/gpu/drm/gma500/mdfld_intel_display.c b/drivers/gpu/drm/gma500/mdfld_intel_display.c
> index 531e4450c000..3311a1cd55ad 100644
> --- a/drivers/gpu/drm/gma500/mdfld_intel_display.c
> +++ b/drivers/gpu/drm/gma500/mdfld_intel_display.c
> @@ -196,7 +196,7 @@ static int mdfld__intel_pipe_set_base(struct drm_crtc *crtc, int x, int y,
>  	if (!gma_power_begin(dev, true))
>  		return 0;
>  
> -	start = psbfb->gtt->offset;
> +	start = get_gtt_range(psbfb)->offset;
>  	offset = y * fb->pitches[0] + x * fb->format->cpp[0];
>  
>  	REG_WRITE(map->stride, fb->pitches[0]);
> diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> index 0fff269d3fe6..6d61355cc5b8 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> @@ -617,7 +617,7 @@ static int oaktrail_pipe_set_base(struct drm_crtc *crtc,
>  	if (!gma_power_begin(dev, true))
>  		return 0;
>  
> -	start = psbfb->gtt->offset;
> +	start = get_gtt_range(psbfb)->offset;
>  	offset = y * fb->pitches[0] + x * fb->format->cpp[0];
>  
>  	REG_WRITE(map->stride, fb->pitches[0]);
> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> index 2ef75c1a6119..cd5722fdd82d 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.c
> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> @@ -1945,7 +1945,7 @@ static int i915_gem_framebuffer_info(struct seq_file *m, void *data)
>  			   fbdev_fb->base.format->cpp[0] * 8,
>  			   fbdev_fb->base.modifier,
>  			   drm_framebuffer_read_refcount(&fbdev_fb->base));
> -		describe_obj(m, fbdev_fb->obj);
> +		describe_obj(m, to_intel_bo(fbdev_fb->base.gem_objs[0]));
>  		seq_putc(m, '\n');
>  	}
>  #endif
> @@ -1963,7 +1963,7 @@ static int i915_gem_framebuffer_info(struct seq_file *m, void *data)
>  			   fb->base.format->cpp[0] * 8,
>  			   fb->base.modifier,
>  			   drm_framebuffer_read_refcount(&fb->base));
> -		describe_obj(m, fb->obj);
> +		describe_obj(m, to_intel_bo(fb->base.gem_objs[0]));
>  		seq_putc(m, '\n');
>  	}
>  	mutex_unlock(&dev->mode_config.fb_lock);
> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> index e92fd14c06c7..f6790253a103 100644
> --- a/drivers/gpu/drm/i915/intel_display.c
> +++ b/drivers/gpu/drm/i915/intel_display.c
> @@ -2134,7 +2134,7 @@ intel_pin_and_fence_fb_obj(struct drm_framebuffer *fb, unsigned int rotation)
>  {
>  	struct drm_device *dev = fb->dev;
>  	struct drm_i915_private *dev_priv = to_i915(dev);
> -	struct drm_i915_gem_object *obj = intel_fb_obj(fb);
> +	struct drm_i915_gem_object *obj = to_intel_bo(fb->gem_objs[0]);
>  	struct i915_ggtt_view view;
>  	struct i915_vma *vma;
>  	u32 alignment;
> @@ -2465,7 +2465,7 @@ intel_fill_fb_info(struct drm_i915_private *dev_priv,
>  		 * fb layout agrees with the fence layout. We already check that the
>  		 * fb stride matches the fence stride elsewhere.
>  		 */
> -		if (i915_gem_object_is_tiled(intel_fb->obj) &&
> +		if (i915_gem_object_is_tiled(to_intel_bo(intel_fb->base.gem_objs[0])) &&
>  		    (x + width) * cpp > fb->pitches[i]) {
>  			DRM_DEBUG_KMS("bad fb plane %d offset: 0x%x\n",
>  				      i, fb->offsets[i]);
> @@ -2550,9 +2550,9 @@ intel_fill_fb_info(struct drm_i915_private *dev_priv,
>  		max_size = max(max_size, offset + size);
>  	}
>  
> -	if (max_size * tile_size > intel_fb->obj->base.size) {
> +	if (max_size * tile_size > fb->gem_objs[0]->size) {
>  		DRM_DEBUG_KMS("fb too big for bo (need %u bytes, have %zu bytes)\n",
> -			      max_size * tile_size, intel_fb->obj->base.size);
> +			      max_size * tile_size, fb->gem_objs[0]->size);
>  		return -EINVAL;
>  	}
>  
> @@ -9672,7 +9672,7 @@ mode_fits_in_fbdev(struct drm_device *dev,
>  	if (!dev_priv->fbdev->fb)
>  		return NULL;
>  
> -	obj = dev_priv->fbdev->fb->obj;
> +	obj = to_intel_bo(dev_priv->fbdev->fb->base.gem_objs[0]);
>  	BUG_ON(!obj);
>  
>  	fb = &dev_priv->fbdev->fb->base;
> @@ -10641,7 +10641,7 @@ static void intel_mmio_flip_work_func(struct work_struct *w)
>  	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
>  	struct intel_framebuffer *intel_fb =
>  		to_intel_framebuffer(crtc->base.primary->fb);
> -	struct drm_i915_gem_object *obj = intel_fb->obj;
> +	struct drm_i915_gem_object *obj = to_intel_bo(intel_fb->base.gem_objs[0]);
>  
>  	WARN_ON(i915_gem_object_wait(obj, 0, MAX_SCHEDULE_TIMEOUT, NULL) < 0);
>  
> @@ -10741,7 +10741,7 @@ static int intel_crtc_page_flip(struct drm_crtc *crtc,
>  	struct drm_device *dev = crtc->dev;
>  	struct drm_i915_private *dev_priv = to_i915(dev);
>  	struct drm_framebuffer *old_fb = crtc->primary->fb;
> -	struct drm_i915_gem_object *obj = intel_fb_obj(fb);
> +	struct drm_i915_gem_object *obj = to_intel_bo(fb->gem_objs[0]);
>  	struct intel_crtc *intel_crtc = to_intel_crtc(crtc);
>  	struct drm_plane *primary = crtc->primary;
>  	enum pipe pipe = intel_crtc->pipe;
> @@ -13697,7 +13697,8 @@ intel_legacy_cursor_update(struct drm_plane *plane,
>  	old_fb = old_plane_state->fb;
>  	old_vma = to_intel_plane_state(old_plane_state)->vma;
>  
> -	i915_gem_track_fb(intel_fb_obj(old_fb), intel_fb_obj(fb),
> +	i915_gem_track_fb(intel_fb_obj(old_fb),
> +			  intel_fb_obj(fb),
>  			  intel_plane->frontbuffer_bit);
>  
>  	/* Swap plane state */
> @@ -14345,40 +14346,25 @@ static void intel_setup_outputs(struct drm_i915_private *dev_priv)
>  static void intel_user_framebuffer_destroy(struct drm_framebuffer *fb)
>  {
>  	struct intel_framebuffer *intel_fb = to_intel_framebuffer(fb);
> -
> +	struct drm_i915_gem_object *bo = to_intel_bo(fb->gem_objs[0]);
>  	drm_framebuffer_cleanup(fb);
>  
> -	i915_gem_object_lock(intel_fb->obj);
> -	WARN_ON(!intel_fb->obj->framebuffer_references--);
> -	i915_gem_object_unlock(intel_fb->obj);
> +	i915_gem_object_lock(bo);
> +	WARN_ON(!bo->framebuffer_references--);
> +	i915_gem_object_unlock(bo);
>  
> -	i915_gem_object_put(intel_fb->obj);
> +	i915_gem_object_put(bo);
>  
>  	kfree(intel_fb);
>  }
>  
> -static int intel_user_framebuffer_create_handle(struct drm_framebuffer *fb,
> -						struct drm_file *file,
> -						unsigned int *handle)
> -{
> -	struct intel_framebuffer *intel_fb = to_intel_framebuffer(fb);
> -	struct drm_i915_gem_object *obj = intel_fb->obj;
> -
> -	if (obj->userptr.mm) {
> -		DRM_DEBUG("attempting to use a userptr for a framebuffer, denied\n");
> -		return -EINVAL;
> -	}
> -
> -	return drm_gem_handle_create(file, &obj->base, handle);
> -}
> -
>  static int intel_user_framebuffer_dirty(struct drm_framebuffer *fb,
>  					struct drm_file *file,
>  					unsigned flags, unsigned color,
>  					struct drm_clip_rect *clips,
>  					unsigned num_clips)
>  {
> -	struct drm_i915_gem_object *obj = intel_fb_obj(fb);
> +	struct drm_i915_gem_object *obj = to_intel_bo(fb->gem_objs[0]);
>  
>  	i915_gem_object_flush_if_display(obj);
>  	intel_fb_obj_flush(obj, ORIGIN_DIRTYFB);
> @@ -14388,7 +14374,6 @@ static int intel_user_framebuffer_dirty(struct drm_framebuffer *fb,
>  
>  static const struct drm_framebuffer_funcs intel_fb_funcs = {
>  	.destroy = intel_user_framebuffer_destroy,
> -	.create_handle = intel_user_framebuffer_create_handle,
>  	.dirty = intel_user_framebuffer_dirty,
>  };
>  
> @@ -14574,7 +14559,7 @@ static int intel_framebuffer_init(struct intel_framebuffer *intel_fb,
>  		goto err;
>  	}
>  
> -	intel_fb->obj = obj;
> +	intel_fb->base.gem_objs[0] = &obj->base;
>  
>  	ret = intel_fill_fb_info(dev_priv, &intel_fb->base);
>  	if (ret)
> diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
> index d17a32437f07..7390a737feb1 100644
> --- a/drivers/gpu/drm/i915/intel_drv.h
> +++ b/drivers/gpu/drm/i915/intel_drv.h
> @@ -187,7 +187,6 @@ enum intel_output_type {
>  
>  struct intel_framebuffer {
>  	struct drm_framebuffer base;
> -	struct drm_i915_gem_object *obj;
>  	struct intel_rotation_info rot_info;
>  
>  	/* for each plane in the normal GTT view */
> @@ -896,7 +895,7 @@ struct cxsr_latency {
>  #define to_intel_framebuffer(x) container_of(x, struct intel_framebuffer, base)
>  #define to_intel_plane(x) container_of(x, struct intel_plane, base)
>  #define to_intel_plane_state(x) container_of(x, struct intel_plane_state, base)
> -#define intel_fb_obj(x) (x ? to_intel_framebuffer(x)->obj : NULL)
> +#define intel_fb_obj(x) (x ? to_intel_bo(x->gem_objs[0]) : NULL)
>  
>  struct intel_hdmi {
>  	i915_reg_t hdmi_reg;
> diff --git a/drivers/gpu/drm/i915/intel_fbdev.c b/drivers/gpu/drm/i915/intel_fbdev.c
> index b953365a3eec..63eee6e41f48 100644
> --- a/drivers/gpu/drm/i915/intel_fbdev.c
> +++ b/drivers/gpu/drm/i915/intel_fbdev.c
> @@ -47,7 +47,8 @@
>  
>  static void intel_fbdev_invalidate(struct intel_fbdev *ifbdev)
>  {
> -	struct drm_i915_gem_object *obj = ifbdev->fb->obj;
> +	struct drm_i915_gem_object *obj =
> +			to_intel_bo(ifbdev->fb->base.gem_objs[0]);
>  	unsigned int origin = ifbdev->vma->fence ? ORIGIN_GTT : ORIGIN_CPU;
>  
>  	intel_fb_obj_invalidate(obj, origin);
> @@ -192,7 +193,7 @@ static int intelfb_create(struct drm_fb_helper *helper,
>  		drm_framebuffer_unreference(&intel_fb->base);
>  		intel_fb = ifbdev->fb = NULL;
>  	}
> -	if (!intel_fb || WARN_ON(!intel_fb->obj)) {
> +	if (!intel_fb || WARN_ON(!intel_fb->base.gem_objs[0])) {
>  		DRM_DEBUG_KMS("no BIOS fb, allocating a new one\n");
>  		ret = intelfb_alloc(helper, sizes);
>  		if (ret)
> @@ -260,7 +261,7 @@ static int intelfb_create(struct drm_fb_helper *helper,
>  	 * If the object is stolen however, it will be full of whatever
>  	 * garbage was left in there.
>  	 */
> -	if (intel_fb->obj->stolen && !prealloc)
> +	if (to_intel_bo(intel_fb->base.gem_objs[0])->stolen && !prealloc)
>  		memset_io(info->screen_base, 0, info->screen_size);
>  
>  	/* Use default scratch pixmap (info->pixmap.flags = FB_PIXMAP_SYSTEM) */
> @@ -809,7 +810,8 @@ void intel_fbdev_set_suspend(struct drm_device *dev, int state, bool synchronous
>  	 * been restored from swap. If the object is stolen however, it will be
>  	 * full of whatever garbage was left in there.
>  	 */
> -	if (state == FBINFO_STATE_RUNNING && ifbdev->fb->obj->stolen)
> +	if (state == FBINFO_STATE_RUNNING &&
> +	    to_intel_bo(ifbdev->fb->base.gem_objs[0])->stolen)
>  		memset_io(info->screen_base, 0, info->screen_size);
>  
>  	drm_fb_helper_set_suspend(&ifbdev->helper, state);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.c b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
> index d4246c9dceae..aa670279d5b2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_fb.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
> @@ -22,78 +22,46 @@
>  #include "mtk_drm_fb.h"
>  #include "mtk_drm_gem.h"
>  
> -/*
> - * mtk specific framebuffer structure.
> - *
> - * @fb: drm framebuffer object.
> - * @gem_obj: array of gem objects.
> - */
> -struct mtk_drm_fb {
> -	struct drm_framebuffer	base;
> -	/* For now we only support a single plane */
> -	struct drm_gem_object	*gem_obj;
> -};
> -
> -#define to_mtk_fb(x) container_of(x, struct mtk_drm_fb, base)
> -
> -struct drm_gem_object *mtk_fb_get_gem_obj(struct drm_framebuffer *fb)
> -{
> -	struct mtk_drm_fb *mtk_fb = to_mtk_fb(fb);
> -
> -	return mtk_fb->gem_obj;
> -}
> -
> -static int mtk_drm_fb_create_handle(struct drm_framebuffer *fb,
> -				    struct drm_file *file_priv,
> -				    unsigned int *handle)
> -{
> -	struct mtk_drm_fb *mtk_fb = to_mtk_fb(fb);
> -
> -	return drm_gem_handle_create(file_priv, mtk_fb->gem_obj, handle);
> -}
>  
>  static void mtk_drm_fb_destroy(struct drm_framebuffer *fb)
>  {
> -	struct mtk_drm_fb *mtk_fb = to_mtk_fb(fb);
> -
>  	drm_framebuffer_cleanup(fb);
>  
> -	drm_gem_object_unreference_unlocked(mtk_fb->gem_obj);
> +	drm_gem_object_unreference_unlocked(fb->gem_objs[0]);
>  
> -	kfree(mtk_fb);
> +	kfree(fb);
>  }
>  
>  static const struct drm_framebuffer_funcs mtk_drm_fb_funcs = {
> -	.create_handle = mtk_drm_fb_create_handle,
>  	.destroy = mtk_drm_fb_destroy,
>  };
>  
> -static struct mtk_drm_fb *mtk_drm_framebuffer_init(struct drm_device *dev,
> +static struct drm_framebuffer *mtk_drm_framebuffer_init(struct drm_device *dev,
>  					const struct drm_mode_fb_cmd2 *mode,
>  					struct drm_gem_object *obj)
>  {
> -	struct mtk_drm_fb *mtk_fb;
> +	struct drm_framebuffer *fb;
>  	int ret;
>  
>  	if (drm_format_num_planes(mode->pixel_format) != 1)
>  		return ERR_PTR(-EINVAL);
>  
> -	mtk_fb = kzalloc(sizeof(*mtk_fb), GFP_KERNEL);
> -	if (!mtk_fb)
> +	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
> +	if (!fb)
>  		return ERR_PTR(-ENOMEM);
>  
> -	drm_helper_mode_fill_fb_struct(dev, &mtk_fb->base, mode);
> +	drm_helper_mode_fill_fb_struct(dev, fb, mode);
>  
> -	mtk_fb->gem_obj = obj;
> +	fb->gem_objs[0] = obj;
>  
> -	ret = drm_framebuffer_init(dev, &mtk_fb->base, &mtk_drm_fb_funcs);
> +	ret = drm_framebuffer_init(dev, fb, &mtk_drm_fb_funcs);
>  	if (ret) {
>  		DRM_ERROR("failed to initialize framebuffer\n");
> -		kfree(mtk_fb);
> +		kfree(fb);
>  		return ERR_PTR(ret);
>  	}
>  
> -	return mtk_fb;
> +	return fb;
>  }
>  
>  /*
> @@ -110,7 +78,7 @@ int mtk_fb_wait(struct drm_framebuffer *fb)
>  	if (!fb)
>  		return 0;
>  
> -	gem = mtk_fb_get_gem_obj(fb);
> +	gem = fb->gem_objs[0];
>  	if (!gem || !gem->dma_buf || !gem->dma_buf->resv)
>  		return 0;
>  
> @@ -128,7 +96,7 @@ struct drm_framebuffer *mtk_drm_mode_fb_create(struct drm_device *dev,
>  					       struct drm_file *file,
>  					       const struct drm_mode_fb_cmd2 *cmd)
>  {
> -	struct mtk_drm_fb *mtk_fb;
> +	struct drm_framebuffer *fb;
>  	struct drm_gem_object *gem;
>  	unsigned int width = cmd->width;
>  	unsigned int height = cmd->height;
> @@ -151,13 +119,13 @@ struct drm_framebuffer *mtk_drm_mode_fb_create(struct drm_device *dev,
>  		goto unreference;
>  	}
>  
> -	mtk_fb = mtk_drm_framebuffer_init(dev, cmd, gem);
> -	if (IS_ERR(mtk_fb)) {
> -		ret = PTR_ERR(mtk_fb);
> +	fb = mtk_drm_framebuffer_init(dev, cmd, gem);
> +	if (IS_ERR(fb)) {
> +		ret = PTR_ERR(fb);
>  		goto unreference;
>  	}
>  
> -	return &mtk_fb->base;
> +	return fb;
>  
>  unreference:
>  	drm_gem_object_unreference_unlocked(gem);
> diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
> index 6ecb7b170316..9c702546a870 100644
> --- a/drivers/gpu/drm/msm/msm_fb.c
> +++ b/drivers/gpu/drm/msm/msm_fb.c
> @@ -24,23 +24,11 @@
>  struct msm_framebuffer {
>  	struct drm_framebuffer base;
>  	const struct msm_format *format;
> -	struct drm_gem_object *planes[MAX_PLANE];
>  };
>  #define to_msm_framebuffer(x) container_of(x, struct msm_framebuffer, base)
>  
> -
> -static int msm_framebuffer_create_handle(struct drm_framebuffer *fb,
> -		struct drm_file *file_priv,
> -		unsigned int *handle)
> -{
> -	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
> -	return drm_gem_handle_create(file_priv,
> -			msm_fb->planes[0], handle);
> -}
> -
>  static void msm_framebuffer_destroy(struct drm_framebuffer *fb)
>  {
> -	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
>  	int i, n = fb->format->num_planes;
>  
>  	DBG("destroy: FB ID: %d (%p)", fb->base.id, fb);
> @@ -48,23 +36,20 @@ static void msm_framebuffer_destroy(struct drm_framebuffer *fb)
>  	drm_framebuffer_cleanup(fb);
>  
>  	for (i = 0; i < n; i++) {
> -		struct drm_gem_object *bo = msm_fb->planes[i];
> -
> +		struct drm_gem_object *bo = fb->gem_objs[i];
>  		drm_gem_object_unreference_unlocked(bo);
>  	}
>  
> -	kfree(msm_fb);
> +	kfree(fb);
>  }
>  
>  static const struct drm_framebuffer_funcs msm_framebuffer_funcs = {
> -	.create_handle = msm_framebuffer_create_handle,
>  	.destroy = msm_framebuffer_destroy,
>  };
>  
>  #ifdef CONFIG_DEBUG_FS
>  void msm_framebuffer_describe(struct drm_framebuffer *fb, struct seq_file *m)
>  {
> -	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
>  	int i, n = fb->format->num_planes;
>  
>  	seq_printf(m, "fb: %dx%d@%4.4s (%2d, ID:%d)\n",
> @@ -74,7 +59,7 @@ void msm_framebuffer_describe(struct drm_framebuffer *fb, struct seq_file *m)
>  	for (i = 0; i < n; i++) {
>  		seq_printf(m, "   %d: offset=%d pitch=%d, obj: ",
>  				i, fb->offsets[i], fb->pitches[i]);
> -		msm_gem_describe(msm_fb->planes[i], m);
> +		msm_gem_describe(fb->gem_objs[i], m);
>  	}
>  }
>  #endif
> @@ -87,13 +72,12 @@ void msm_framebuffer_describe(struct drm_framebuffer *fb, struct seq_file *m)
>  int msm_framebuffer_prepare(struct drm_framebuffer *fb,
>  		struct msm_gem_address_space *aspace)
>  {
> -	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
>  	int ret, i, n = fb->format->num_planes;
>  	uint64_t iova;
>  
>  	for (i = 0; i < n; i++) {
> -		ret = msm_gem_get_iova(msm_fb->planes[i], aspace, &iova);
> -		DBG("FB[%u]: iova[%d]: %08llx (%d)", fb->base.id, i, iova, ret);
> +		ret = msm_gem_get_iova(fb->gem_objs[i], aspace, &iova);
> +		DBG("FB: iova[%d]: %08llx (%d)", i, iova, ret);
>  		if (ret)
>  			return ret;
>  	}
> @@ -104,26 +88,23 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb,
>  void msm_framebuffer_cleanup(struct drm_framebuffer *fb,
>  		struct msm_gem_address_space *aspace)
>  {
> -	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
>  	int i, n = fb->format->num_planes;
>  
>  	for (i = 0; i < n; i++)
> -		msm_gem_put_iova(msm_fb->planes[i], aspace);
> +		msm_gem_put_iova(fb->gem_objs[i], aspace);
>  }
>  
>  uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb,
>  		struct msm_gem_address_space *aspace, int plane)
>  {
> -	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
> -	if (!msm_fb->planes[plane])
> +	if (!fb->gem_objs[plane])
>  		return 0;
> -	return msm_gem_iova(msm_fb->planes[plane], aspace) + fb->offsets[plane];
> +	return msm_gem_iova(fb->gem_objs[plane], aspace) + fb->offsets[plane];
>  }
>  
>  struct drm_gem_object *msm_framebuffer_bo(struct drm_framebuffer *fb, int plane)
>  {
> -	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
> -	return msm_fb->planes[plane];
> +	return fb->gem_objs[plane];
>  }
>  
>  const struct msm_format *msm_framebuffer_format(struct drm_framebuffer *fb)
> @@ -198,7 +179,7 @@ struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
>  
>  	msm_fb->format = format;
>  
> -	if (n > ARRAY_SIZE(msm_fb->planes)) {
> +	if (n > ARRAY_SIZE(fb->gem_objs)) {
>  		ret = -EINVAL;
>  		goto fail;
>  	}
> @@ -217,7 +198,7 @@ struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
>  			goto fail;
>  		}
>  
> -		msm_fb->planes[i] = bos[i];
> +		fb->gem_objs[i] = bos[i];
>  	}
>  
>  	drm_helper_mode_fill_fb_struct(dev, fb, mode_cmd);
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> index 4b4b0b496262..9b791ce79eac 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> @@ -605,15 +605,15 @@ static int
>  nv_crtc_swap_fbs(struct drm_crtc *crtc, struct drm_framebuffer *old_fb)
>  {
>  	struct nv04_display *disp = nv04_display(crtc->dev);
> -	struct nouveau_framebuffer *nvfb = nouveau_framebuffer(crtc->primary->fb);
> +	struct nouveau_bo *nv_bo = nouveau_gem_object(crtc->primary->fb->gem_objs[0]);
>  	struct nouveau_crtc *nv_crtc = nouveau_crtc(crtc);
>  	int ret;
>  
> -	ret = nouveau_bo_pin(nvfb->nvbo, TTM_PL_FLAG_VRAM, false);
> +	ret = nouveau_bo_pin(nv_bo, TTM_PL_FLAG_VRAM, false);
>  	if (ret == 0) {
>  		if (disp->image[nv_crtc->index])
>  			nouveau_bo_unpin(disp->image[nv_crtc->index]);
> -		nouveau_bo_ref(nvfb->nvbo, &disp->image[nv_crtc->index]);
> +		nouveau_bo_ref(nv_bo, &disp->image[nv_crtc->index]);
>  	}
>  
>  	return ret;
> @@ -826,6 +826,7 @@ nv04_crtc_do_mode_set_base(struct drm_crtc *crtc,
>  	struct nv04_crtc_reg *regp = &nv04_display(dev)->mode_reg.crtc_reg[nv_crtc->index];
>  	struct drm_framebuffer *drm_fb;
>  	struct nouveau_framebuffer *fb;
> +	struct nouveau_bo *nv_bo;
>  	int arb_burst, arb_lwm;
>  
>  	NV_DEBUG(drm, "index %d\n", nv_crtc->index);
> @@ -847,7 +848,8 @@ nv04_crtc_do_mode_set_base(struct drm_crtc *crtc,
>  		fb = nouveau_framebuffer(crtc->primary->fb);
>  	}
>  
> -	nv_crtc->fb.offset = fb->nvbo->bo.offset;
> +	nv_bo = nouveau_gem_object(fb->base.gem_objs[0]);
> +	nv_crtc->fb.offset = nv_bo->bo.offset;
>  
>  	if (nv_crtc->lut.depth != drm_fb->format->depth) {
>  		nv_crtc->lut.depth = drm_fb->format->depth;
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/overlay.c b/drivers/gpu/drm/nouveau/dispnv04/overlay.c
> index e54944d23268..79301eee346a 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/overlay.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/overlay.c
> @@ -32,6 +32,7 @@
>  #include "nouveau_bo.h"
>  #include "nouveau_connector.h"
>  #include "nouveau_display.h"
> +#include "nouveau_gem.h"
>  #include "nvreg.h"
>  #include "disp.h"
>  
> @@ -101,7 +102,7 @@ nv10_update_plane(struct drm_plane *plane, struct drm_crtc *crtc,
>  	struct nvif_object *dev = &drm->client.device.object;
>  	struct nouveau_plane *nv_plane =
>  		container_of(plane, struct nouveau_plane, base);
> -	struct nouveau_framebuffer *nv_fb = nouveau_framebuffer(fb);
> +	struct nouveau_bo *nv_bo = nouveau_gem_object(fb->gem_objs[0]);
>  	struct nouveau_crtc *nv_crtc = nouveau_crtc(crtc);
>  	struct nouveau_bo *cur = nv_plane->cur;
>  	bool flip = nv_plane->flip;
> @@ -128,17 +129,17 @@ nv10_update_plane(struct drm_plane *plane, struct drm_crtc *crtc,
>  			return -ERANGE;
>  	}
>  
> -	ret = nouveau_bo_pin(nv_fb->nvbo, TTM_PL_FLAG_VRAM, false);
> +	ret = nouveau_bo_pin(nv_bo, TTM_PL_FLAG_VRAM, false);
>  	if (ret)
>  		return ret;
>  
> -	nv_plane->cur = nv_fb->nvbo;
> +	nv_plane->cur = nv_bo;
>  
>  	nvif_mask(dev, NV_PCRTC_ENGINE_CTRL + soff, NV_CRTC_FSEL_OVERLAY, NV_CRTC_FSEL_OVERLAY);
>  	nvif_mask(dev, NV_PCRTC_ENGINE_CTRL + soff2, NV_CRTC_FSEL_OVERLAY, 0);
>  
>  	nvif_wr32(dev, NV_PVIDEO_BASE(flip), 0);
> -	nvif_wr32(dev, NV_PVIDEO_OFFSET_BUFF(flip), nv_fb->nvbo->bo.offset);
> +	nvif_wr32(dev, NV_PVIDEO_OFFSET_BUFF(flip), nv_bo->bo.offset);
>  	nvif_wr32(dev, NV_PVIDEO_SIZE_IN(flip), src_h << 16 | src_w);
>  	nvif_wr32(dev, NV_PVIDEO_POINT_IN(flip), src_y << 16 | src_x);
>  	nvif_wr32(dev, NV_PVIDEO_DS_DX(flip), (src_w << 20) / crtc_w);
> @@ -158,7 +159,7 @@ nv10_update_plane(struct drm_plane *plane, struct drm_crtc *crtc,
>  	if (fb->format->format == DRM_FORMAT_NV12) {
>  		nvif_wr32(dev, NV_PVIDEO_UVPLANE_BASE(flip), 0);
>  		nvif_wr32(dev, NV_PVIDEO_UVPLANE_OFFSET_BUFF(flip),
> -			nv_fb->nvbo->bo.offset + fb->offsets[1]);
> +			nv_bo->bo.offset + fb->offsets[1]);
>  	}
>  	nvif_wr32(dev, NV_PVIDEO_FORMAT(flip), format);
>  	nvif_wr32(dev, NV_PVIDEO_STOP, 0);
> @@ -353,7 +354,7 @@ nv04_update_plane(struct drm_plane *plane, struct drm_crtc *crtc,
>  	struct nvif_object *dev = &nouveau_drm(plane->dev)->client.device.object;
>  	struct nouveau_plane *nv_plane =
>  		container_of(plane, struct nouveau_plane, base);
> -	struct nouveau_framebuffer *nv_fb = nouveau_framebuffer(fb);
> +	struct nouveau_bo *nv_bo = nouveau_gem_object(fb->gem_objs[0]);
>  	struct nouveau_bo *cur = nv_plane->cur;
>  	uint32_t overlay = 1;
>  	int brightness = (nv_plane->brightness - 512) * 62 / 512;
> @@ -377,11 +378,11 @@ nv04_update_plane(struct drm_plane *plane, struct drm_crtc *crtc,
>  	if (crtc_w < src_w || crtc_h < src_h)
>  		return -ERANGE;
>  
> -	ret = nouveau_bo_pin(nv_fb->nvbo, TTM_PL_FLAG_VRAM, false);
> +	ret = nouveau_bo_pin(nv_bo, TTM_PL_FLAG_VRAM, false);
>  	if (ret)
>  		return ret;
>  
> -	nv_plane->cur = nv_fb->nvbo;
> +	nv_plane->cur = nv_bo;
>  
>  	nvif_wr32(dev, NV_PVIDEO_OE_STATE, 0);
>  	nvif_wr32(dev, NV_PVIDEO_SU_STATE, 0);
> @@ -389,7 +390,7 @@ nv04_update_plane(struct drm_plane *plane, struct drm_crtc *crtc,
>  
>  	for (i = 0; i < 2; i++) {
>  		nvif_wr32(dev, NV_PVIDEO_BUFF0_START_ADDRESS + 4 * i,
> -			nv_fb->nvbo->bo.offset);
> +			nv_bo->bo.offset);
>  		nvif_wr32(dev, NV_PVIDEO_BUFF0_PITCH_LENGTH + 4 * i, pitch);
>  		nvif_wr32(dev, NV_PVIDEO_BUFF0_OFFSET + 4 * i, 0);
>  	}
> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
> index b9a109be989c..c1fac658ec94 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
> @@ -202,27 +202,17 @@ static void
>  nouveau_user_framebuffer_destroy(struct drm_framebuffer *drm_fb)
>  {
>  	struct nouveau_framebuffer *fb = nouveau_framebuffer(drm_fb);
> +	struct nouveau_bo *nv_bo = nouveau_gem_object(drm_fb->gem_objs[0]);
>  
> -	if (fb->nvbo)
> -		drm_gem_object_unreference_unlocked(&fb->nvbo->gem);
> +	if (nv_bo)
> +		drm_gem_object_unreference_unlocked(&nv_bo->gem);
>  
>  	drm_framebuffer_cleanup(drm_fb);
>  	kfree(fb);
>  }
>  
> -static int
> -nouveau_user_framebuffer_create_handle(struct drm_framebuffer *drm_fb,
> -				       struct drm_file *file_priv,
> -				       unsigned int *handle)
> -{
> -	struct nouveau_framebuffer *fb = nouveau_framebuffer(drm_fb);
> -
> -	return drm_gem_handle_create(file_priv, &fb->nvbo->gem, handle);
> -}
> -
>  static const struct drm_framebuffer_funcs nouveau_framebuffer_funcs = {
>  	.destroy = nouveau_user_framebuffer_destroy,
> -	.create_handle = nouveau_user_framebuffer_create_handle,
>  };
>  
>  int
> @@ -238,7 +228,7 @@ nouveau_framebuffer_new(struct drm_device *dev,
>  		return -ENOMEM;
>  
>  	drm_helper_mode_fill_fb_struct(dev, &fb->base, mode_cmd);
> -	fb->nvbo = nvbo;
> +	fb->base.gem_objs[0] = &nvbo->gem;
>  
>  	ret = drm_framebuffer_init(dev, &fb->base, &nouveau_framebuffer_funcs);
>  	if (ret)
> @@ -625,13 +615,13 @@ nouveau_display_suspend(struct drm_device *dev, bool runtime)
>  	nouveau_display_fini(dev, true);
>  
>  	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> -		struct nouveau_framebuffer *nouveau_fb;
> -
> -		nouveau_fb = nouveau_framebuffer(crtc->primary->fb);
> -		if (!nouveau_fb || !nouveau_fb->nvbo)
> +		struct nouveau_bo *nv_bo;
> +		if (!crtc->primary->fb)
>  			continue;
> -
> -		nouveau_bo_unpin(nouveau_fb->nvbo);
> +		nv_bo = nouveau_gem_object(crtc->primary->fb->gem_objs[0]);
> +		if (!nv_bo)
> +			continue;
> +		nouveau_bo_unpin(nv_bo);
>  	}
>  
>  	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> @@ -665,13 +655,14 @@ nouveau_display_resume(struct drm_device *dev, bool runtime)
>  
>  	/* re-pin fb/cursors */
>  	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> -		struct nouveau_framebuffer *nouveau_fb;
> +		struct nouveau_bo *nv_bo;
>  
> -		nouveau_fb = nouveau_framebuffer(crtc->primary->fb);
> -		if (!nouveau_fb || !nouveau_fb->nvbo)
> +		if (!crtc->primary->fb)
>  			continue;
> -
> -		ret = nouveau_bo_pin(nouveau_fb->nvbo, TTM_PL_FLAG_VRAM, true);
> +		nv_bo = nouveau_gem_object(crtc->primary->fb->gem_objs[0]);
> +		if (!nv_bo)
> +			continue;
> +		ret = nouveau_bo_pin(nv_bo, TTM_PL_FLAG_VRAM, true);
>  		if (ret)
>  			NV_ERROR(drm, "Could not pin framebuffer\n");
>  	}
> @@ -771,8 +762,8 @@ nouveau_crtc_page_flip(struct drm_crtc *crtc, struct drm_framebuffer *fb,
>  	const int swap_interval = (flags & DRM_MODE_PAGE_FLIP_ASYNC) ? 0 : 1;
>  	struct drm_device *dev = crtc->dev;
>  	struct nouveau_drm *drm = nouveau_drm(dev);
> -	struct nouveau_bo *old_bo = nouveau_framebuffer(crtc->primary->fb)->nvbo;
> -	struct nouveau_bo *new_bo = nouveau_framebuffer(fb)->nvbo;
> +	struct nouveau_bo *old_bo = nouveau_gem_object(crtc->primary->fb->gem_objs[0]);
> +	struct nouveau_bo *new_bo = nouveau_gem_object(fb->gem_objs[0]);
>  	struct nouveau_page_flip_state *s;
>  	struct nouveau_channel *chan;
>  	struct nouveau_cli *cli;
> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.h b/drivers/gpu/drm/nouveau/nouveau_display.h
> index 201aec2ea5b8..a6ae824bb6e1 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.h
> @@ -7,7 +7,6 @@
>  
>  struct nouveau_framebuffer {
>  	struct drm_framebuffer base;
> -	struct nouveau_bo *nvbo;
>  	struct nvkm_vma vma;
>  	u32 r_handle;
>  	u32 r_format;
> diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
> index 2665a078b6da..cd7a26c45148 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
> @@ -395,12 +395,12 @@ nouveau_fbcon_create(struct drm_fb_helper *helper,
>  			      FBINFO_HWACCEL_IMAGEBLIT;
>  	info->flags |= FBINFO_CAN_FORCE_OUTPUT;
>  	info->fbops = &nouveau_fbcon_sw_ops;
> -	info->fix.smem_start = fb->nvbo->bo.mem.bus.base +
> -			       fb->nvbo->bo.mem.bus.offset;
> -	info->fix.smem_len = fb->nvbo->bo.mem.num_pages << PAGE_SHIFT;
> +	info->fix.smem_start = nvbo->bo.mem.bus.base +
> +			       nvbo->bo.mem.bus.offset;
> +	info->fix.smem_len = nvbo->bo.mem.num_pages << PAGE_SHIFT;
>  
> -	info->screen_base = nvbo_kmap_obj_iovirtual(fb->nvbo);
> -	info->screen_size = fb->nvbo->bo.mem.num_pages << PAGE_SHIFT;
> +	info->screen_base = nvbo_kmap_obj_iovirtual(nvbo);
> +	info->screen_size = nvbo->bo.mem.num_pages << PAGE_SHIFT;
>  
>  	drm_fb_helper_fill_fix(info, fb->base.pitches[0],
>  			       fb->base.format->depth);
> @@ -414,19 +414,19 @@ nouveau_fbcon_create(struct drm_fb_helper *helper,
>  
>  	/* To allow resizeing without swapping buffers */
>  	NV_INFO(drm, "allocated %dx%d fb: 0x%llx, bo %p\n",
> -		fb->base.width, fb->base.height, fb->nvbo->bo.offset, nvbo);
> +		fb->base.width, fb->base.height, nvbo->bo.offset, nvbo);
>  
>  	vga_switcheroo_client_fb_set(dev->pdev, info);
>  	return 0;
>  
>  out_unlock:
>  	if (chan)
> -		nouveau_bo_vma_del(fb->nvbo, &fb->vma);
> -	nouveau_bo_unmap(fb->nvbo);
> +		nouveau_bo_vma_del(nvbo, &fb->vma);
> +	nouveau_bo_unmap(nvbo);
>  out_unpin:
> -	nouveau_bo_unpin(fb->nvbo);
> +	nouveau_bo_unpin(nvbo);
>  out_unref:
> -	nouveau_bo_ref(NULL, &fb->nvbo);
> +	nouveau_bo_ref(NULL, &nvbo);
>  out:
>  	return ret;
>  }
> @@ -443,15 +443,18 @@ static int
>  nouveau_fbcon_destroy(struct drm_device *dev, struct nouveau_fbdev *fbcon)
>  {
>  	struct nouveau_framebuffer *nouveau_fb = nouveau_framebuffer(fbcon->helper.fb);
> +	struct nouveau_bo *nv_bo = nouveau_gem_object(fbcon->helper.fb->gem_objs[0]);
>  
>  	drm_fb_helper_unregister_fbi(&fbcon->helper);
>  	drm_fb_helper_fini(&fbcon->helper);
>  
> -	if (nouveau_fb->nvbo) {
> -		nouveau_bo_vma_del(nouveau_fb->nvbo, &nouveau_fb->vma);
> -		nouveau_bo_unmap(nouveau_fb->nvbo);
> -		nouveau_bo_unpin(nouveau_fb->nvbo);
> +	if (nv_bo) {
> +		nouveau_bo_vma_del(nv_bo, &nouveau_fb->vma);
> +		nouveau_bo_unmap(nv_bo);
> +		nouveau_bo_unpin(nv_bo);
> +		drm_gem_object_unreference_unlocked(&nv_bo->gem);
>  		drm_framebuffer_unreference(&nouveau_fb->base);
> +		fbcon->helper.fb->gem_objs[0] = NULL;
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/nouveau/nv50_display.c b/drivers/gpu/drm/nouveau/nv50_display.c
> index 747c99c1e474..49880dd20892 100644
> --- a/drivers/gpu/drm/nouveau/nv50_display.c
> +++ b/drivers/gpu/drm/nouveau/nv50_display.c
> @@ -424,7 +424,8 @@ nv50_dmac_ctxdma_new(struct nv50_dmac *dmac, struct nouveau_framebuffer *fb)
>  {
>  	struct nouveau_drm *drm = nouveau_drm(fb->base.dev);
>  	struct nv50_dmac_ctxdma *ctxdma;
> -	const u8    kind = (fb->nvbo->tile_flags & 0x0000ff00) >> 8;
> +	struct nouveau_bo *nv_bo = nouveau_gem_object(fb->base.gem_objs[0]);
> +	const u8    kind = (nv_bo->tile_flags & 0x0000ff00) >> 8;
>  	const u32 handle = 0xfb000000 | kind;
>  	struct {
>  		struct nv_dma_v0 base;
> @@ -837,6 +838,7 @@ nv50_wndw_atomic_check_acquire(struct nv50_wndw *wndw,
>  {
>  	struct nouveau_framebuffer *fb = nouveau_framebuffer(asyw->state.fb);
>  	struct nouveau_drm *drm = nouveau_drm(wndw->plane.dev);
> +	struct nouveau_bo *nv_bo = nouveau_gem_object(fb->base.gem_objs[0]);
>  	int ret;
>  
>  	NV_ATOMIC(drm, "%s acquire\n", wndw->plane.name);
> @@ -847,7 +849,7 @@ nv50_wndw_atomic_check_acquire(struct nv50_wndw *wndw,
>  
>  	asyw->image.w = fb->base.width;
>  	asyw->image.h = fb->base.height;
> -	asyw->image.kind = (fb->nvbo->tile_flags & 0x0000ff00) >> 8;
> +	asyw->image.kind = (nv_bo->tile_flags & 0x0000ff00) >> 8;
>  
>  	if (asyh->state.pageflip_flags & DRM_MODE_PAGE_FLIP_ASYNC)
>  		asyw->interval = 0;
> @@ -857,9 +859,9 @@ nv50_wndw_atomic_check_acquire(struct nv50_wndw *wndw,
>  	if (asyw->image.kind) {
>  		asyw->image.layout = 0;
>  		if (drm->client.device.info.chipset >= 0xc0)
> -			asyw->image.block = fb->nvbo->tile_mode >> 4;
> +			asyw->image.block = nv_bo->tile_mode >> 4;
>  		else
> -			asyw->image.block = fb->nvbo->tile_mode;
> +			asyw->image.block = nv_bo->tile_mode;
>  		asyw->image.pitch = (fb->base.pitches[0] / 4) << 4;
>  	} else {
>  		asyw->image.layout = 1;
> @@ -940,12 +942,13 @@ nv50_wndw_cleanup_fb(struct drm_plane *plane, struct drm_plane_state *old_state)
>  {
>  	struct nouveau_framebuffer *fb = nouveau_framebuffer(old_state->fb);
>  	struct nouveau_drm *drm = nouveau_drm(plane->dev);
> +	struct nouveau_bo *nv_bo = nouveau_gem_object(fb->base.gem_objs[0]);
>  
>  	NV_ATOMIC(drm, "%s cleanup: %p\n", plane->name, old_state->fb);
>  	if (!old_state->fb)
>  		return;
>  
> -	nouveau_bo_unpin(fb->nvbo);
> +	nouveau_bo_unpin(nv_bo);
>  }
>  
>  static int
> @@ -953,6 +956,7 @@ nv50_wndw_prepare_fb(struct drm_plane *plane, struct drm_plane_state *state)
>  {
>  	struct nouveau_framebuffer *fb = nouveau_framebuffer(state->fb);
>  	struct nouveau_drm *drm = nouveau_drm(plane->dev);
> +	struct nouveau_bo *nv_bo = nouveau_gem_object(fb->base.gem_objs[0]);
>  	struct nv50_wndw *wndw = nv50_wndw(plane);
>  	struct nv50_wndw_atom *asyw = nv50_wndw_atom(state);
>  	struct nv50_head_atom *asyh;
> @@ -963,19 +967,19 @@ nv50_wndw_prepare_fb(struct drm_plane *plane, struct drm_plane_state *state)
>  	if (!asyw->state.fb)
>  		return 0;
>  
> -	ret = nouveau_bo_pin(fb->nvbo, TTM_PL_FLAG_VRAM, true);
> +	ret = nouveau_bo_pin(nv_bo, TTM_PL_FLAG_VRAM, true);
>  	if (ret)
>  		return ret;
>  
>  	ctxdma = nv50_dmac_ctxdma_new(wndw->dmac, fb);
>  	if (IS_ERR(ctxdma)) {
> -		nouveau_bo_unpin(fb->nvbo);
> +		nouveau_bo_unpin(nv_bo);
>  		return PTR_ERR(ctxdma);
>  	}
>  
> -	asyw->state.fence = reservation_object_get_excl_rcu(fb->nvbo->bo.resv);
> +	asyw->state.fence = reservation_object_get_excl_rcu(nv_bo->bo.resv);
>  	asyw->image.handle = ctxdma->object.handle;
> -	asyw->image.offset = fb->nvbo->bo.offset;
> +	asyw->image.offset = nv_bo->bo.offset;
>  
>  	if (wndw->func->prepare) {
>  		asyh = nv50_head_atom_get(asyw->state.state, asyw->state.crtc);
> diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
> index ddf7a457951b..5db4130af522 100644
> --- a/drivers/gpu/drm/omapdrm/omap_fb.c
> +++ b/drivers/gpu/drm/omapdrm/omap_fb.c
> @@ -53,7 +53,6 @@ static const u32 formats[] = {
>  
>  /* per-plane info for the fb: */
>  struct plane {
> -	struct drm_gem_object *bo;
>  	uint32_t pitch;
>  	uint32_t offset;
>  	dma_addr_t dma_addr;
> @@ -70,18 +69,8 @@ struct omap_framebuffer {
>  	struct mutex lock;
>  };
>  
> -static int omap_framebuffer_create_handle(struct drm_framebuffer *fb,
> -		struct drm_file *file_priv,
> -		unsigned int *handle)
> -{
> -	struct omap_framebuffer *omap_fb = to_omap_framebuffer(fb);
> -	return drm_gem_handle_create(file_priv,
> -			omap_fb->planes[0].bo, handle);
> -}
> -
>  static void omap_framebuffer_destroy(struct drm_framebuffer *fb)
>  {
> -	struct omap_framebuffer *omap_fb = to_omap_framebuffer(fb);
>  	int i, n = fb->format->num_planes;
>  
>  	DBG("destroy: FB ID: %d (%p)", fb->base.id, fb);
> @@ -89,16 +78,14 @@ static void omap_framebuffer_destroy(struct drm_framebuffer *fb)
>  	drm_framebuffer_cleanup(fb);
>  
>  	for (i = 0; i < n; i++) {
> -		struct plane *plane = &omap_fb->planes[i];
> -
> -		drm_gem_object_unreference_unlocked(plane->bo);
> +		if (fb->gem_objs[i])
> +			drm_gem_object_unreference_unlocked(fb->gem_objs[i]);
>  	}
>  
> -	kfree(omap_fb);
> +	kfree(fb);
>  }
>  
>  static const struct drm_framebuffer_funcs omap_framebuffer_funcs = {
> -	.create_handle = omap_framebuffer_create_handle,
>  	.destroy = omap_framebuffer_destroy,
>  };
>  
> @@ -116,10 +103,7 @@ static uint32_t get_linear_addr(struct plane *plane,
>  
>  bool omap_framebuffer_supports_rotation(struct drm_framebuffer *fb)
>  {
> -	struct omap_framebuffer *omap_fb = to_omap_framebuffer(fb);
> -	struct plane *plane = &omap_fb->planes[0];
> -
> -	return omap_gem_flags(plane->bo) & OMAP_BO_TILED;
> +	return omap_gem_flags(fb->gem_objs[0]) & OMAP_BO_TILED;
>  }
>  
>  /* Note: DRM rotates counter-clockwise, TILER & DSS rotates clockwise */
> @@ -160,6 +144,7 @@ void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
>  	struct omap_framebuffer *omap_fb = to_omap_framebuffer(fb);
>  	const struct drm_format_info *format = omap_fb->format;
>  	struct plane *plane = &omap_fb->planes[0];
> +	struct drm_gem_object *bo = fb->gem_objs[0];
>  	uint32_t x, y, orient = 0;
>  
>  	info->fourcc = fb->format->format;
> @@ -178,7 +163,7 @@ void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
>  	x = state->src_x >> 16;
>  	y = state->src_y >> 16;
>  
> -	if (omap_gem_flags(plane->bo) & OMAP_BO_TILED) {
> +	if (omap_gem_flags(bo) & OMAP_BO_TILED) {
>  		uint32_t w = state->src_w >> 16;
>  		uint32_t h = state->src_h >> 16;
>  
> @@ -203,12 +188,11 @@ void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
>  			x += w - 1;
>  
>  		/* Note: x and y are in TILER units, not pixels */
> -		omap_gem_rotated_dma_addr(plane->bo, orient, x, y,
> -					  &info->paddr);
> +		omap_gem_rotated_dma_addr(bo, orient, x, y, &info->paddr);
>  		info->rotation_type = OMAP_DSS_ROT_TILER;
>  		info->rotation = state->rotation ?: DRM_MODE_ROTATE_0;
>  		/* Note: stride in TILER units, not pixels */
> -		info->screen_width  = omap_gem_tiled_stride(plane->bo, orient);
> +		info->screen_width  = omap_gem_tiled_stride(bo, orient);
>  	} else {
>  		switch (state->rotation & DRM_MODE_ROTATE_MASK) {
>  		case 0:
> @@ -234,10 +218,10 @@ void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
>  
>  	if (fb->format->format == DRM_FORMAT_NV12) {
>  		plane = &omap_fb->planes[1];
> -
> +		bo = fb->gem_objs[1];
>  		if (info->rotation_type == OMAP_DSS_ROT_TILER) {
> -			WARN_ON(!(omap_gem_flags(plane->bo) & OMAP_BO_TILED));
> -			omap_gem_rotated_dma_addr(plane->bo, orient, x/2, y/2,
> +			WARN_ON(!(omap_gem_flags(bo) & OMAP_BO_TILED));
> +			omap_gem_rotated_dma_addr(bo, orient, x/2, y/2,
>  						  &info->p_uv_addr);
>  		} else {
>  			info->p_uv_addr = get_linear_addr(plane, format, 1, x, y);
> @@ -263,10 +247,11 @@ int omap_framebuffer_pin(struct drm_framebuffer *fb)
>  
>  	for (i = 0; i < n; i++) {
>  		struct plane *plane = &omap_fb->planes[i];
> -		ret = omap_gem_pin(plane->bo, &plane->dma_addr);
> +		struct drm_gem_object *bo = fb->gem_objs[i];
> +		ret = omap_gem_pin(bo, &plane->dma_addr);
>  		if (ret)
>  			goto fail;
> -		omap_gem_dma_sync_buffer(plane->bo, DMA_TO_DEVICE);
> +		omap_gem_dma_sync_buffer(bo, DMA_TO_DEVICE);
>  	}
>  
>  	omap_fb->pin_count++;
> @@ -278,7 +263,8 @@ int omap_framebuffer_pin(struct drm_framebuffer *fb)
>  fail:
>  	for (i--; i >= 0; i--) {
>  		struct plane *plane = &omap_fb->planes[i];
> -		omap_gem_unpin(plane->bo);
> +		struct drm_gem_object *bo = fb->gem_objs[i];
> +		omap_gem_unpin(bo);
>  		plane->dma_addr = 0;
>  	}
>  
> @@ -304,7 +290,8 @@ void omap_framebuffer_unpin(struct drm_framebuffer *fb)
>  
>  	for (i = 0; i < n; i++) {
>  		struct plane *plane = &omap_fb->planes[i];
> -		omap_gem_unpin(plane->bo);
> +		struct drm_gem_object *bo = fb->gem_objs[i];
> +		omap_gem_unpin(bo);
>  		plane->dma_addr = 0;
>  	}
>  
> @@ -349,9 +336,10 @@ void omap_framebuffer_describe(struct drm_framebuffer *fb, struct seq_file *m)
>  
>  	for (i = 0; i < n; i++) {
>  		struct plane *plane = &omap_fb->planes[i];
> +		struct drm_gem_object *bo = fb->gem_objs[i];
>  		seq_printf(m, "   %d: offset=%d pitch=%d, obj: ",
>  				i, plane->offset, plane->pitch);
> -		omap_gem_describe(plane->bo, m);
> +		omap_gem_describe(bo, m);
>  	}
>  }
>  #endif
> @@ -456,7 +444,7 @@ struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
>  			goto fail;
>  		}
>  
> -		plane->bo     = bos[i];
> +		fb->gem_objs[i]     = bos[i];
>  		plane->offset = mode_cmd->offsets[i];
>  		plane->pitch  = pitch;
>  		plane->dma_addr  = 0;
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index 5eeae89c138d..54d739214383 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -304,11 +304,10 @@ static const struct drm_crtc_funcs qxl_crtc_funcs = {
>  
>  void qxl_user_framebuffer_destroy(struct drm_framebuffer *fb)
>  {
> -	struct qxl_framebuffer *qxl_fb = to_qxl_framebuffer(fb);
> -
> -	drm_gem_object_unreference_unlocked(qxl_fb->obj);
> +	if (fb->gem_objs[0])
> +		drm_gem_object_unreference_unlocked(fb->gem_objs[0]);
>  	drm_framebuffer_cleanup(fb);
> -	kfree(qxl_fb);
> +	kfree(fb);
>  }
>  
>  static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
> @@ -318,15 +317,14 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
>  					 unsigned num_clips)
>  {
>  	/* TODO: vmwgfx where this was cribbed from had locking. Why? */
> -	struct qxl_framebuffer *qxl_fb = to_qxl_framebuffer(fb);
> -	struct qxl_device *qdev = qxl_fb->base.dev->dev_private;
> +	struct qxl_device *qdev = fb->dev->dev_private;
>  	struct drm_clip_rect norect;
>  	struct qxl_bo *qobj;
>  	int inc = 1;
>  
>  	drm_modeset_lock_all(fb->dev);
>  
> -	qobj = gem_to_qxl_bo(qxl_fb->obj);
> +	qobj = gem_to_qxl_bo(fb->gem_objs[0]);
>  	/* if we aren't primary surface ignore this */
>  	if (!qobj->is_primary) {
>  		drm_modeset_unlock_all(fb->dev);
> @@ -344,7 +342,7 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
>  		inc = 2; /* skip source rects */
>  	}
>  
> -	qxl_draw_dirty_fb(qdev, qxl_fb, qobj, flags, color,
> +	qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
>  			  clips, num_clips, inc);
>  
>  	drm_modeset_unlock_all(fb->dev);
> @@ -355,24 +353,22 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
>  static const struct drm_framebuffer_funcs qxl_fb_funcs = {
>  	.destroy = qxl_user_framebuffer_destroy,
>  	.dirty = qxl_framebuffer_surface_dirty,
> -/*	TODO?
> - *	.create_handle = qxl_user_framebuffer_create_handle, */
>  };
>  
>  int
>  qxl_framebuffer_init(struct drm_device *dev,
> -		     struct qxl_framebuffer *qfb,
> +		     struct drm_framebuffer *fb,
>  		     const struct drm_mode_fb_cmd2 *mode_cmd,
>  		     struct drm_gem_object *obj,
>  		     const struct drm_framebuffer_funcs *funcs)
>  {
>  	int ret;
>  
> -	qfb->obj = obj;
> -	drm_helper_mode_fill_fb_struct(dev, &qfb->base, mode_cmd);
> -	ret = drm_framebuffer_init(dev, &qfb->base, funcs);
> +	drm_helper_mode_fill_fb_struct(dev, fb, mode_cmd);
> +	fb->gem_objs[0] = obj;
> +	ret = drm_framebuffer_init(dev, fb, &qxl_fb_funcs);
>  	if (ret) {
> -		qfb->obj = NULL;
> +		fb->gem_objs[0] = NULL;
>  		return ret;
>  	}
>  	return 0;
> @@ -476,14 +472,12 @@ static int qxl_primary_atomic_check(struct drm_plane *plane,
>  				    struct drm_plane_state *state)
>  {
>  	struct qxl_device *qdev = plane->dev->dev_private;
> -	struct qxl_framebuffer *qfb;
>  	struct qxl_bo *bo;
>  
>  	if (!state->crtc || !state->fb)
>  		return 0;
>  
> -	qfb = to_qxl_framebuffer(state->fb);
> -	bo = gem_to_qxl_bo(qfb->obj);
> +	bo = gem_to_qxl_bo(state->fb->gem_objs[0]);
>  
>  	if (bo->surf.stride * bo->surf.height > qdev->vram_size) {
>  		DRM_ERROR("Mode doesn't fit in vram size (vgamem)");
> @@ -497,16 +491,15 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
>  				      struct drm_plane_state *old_state)
>  {
>  	struct qxl_device *qdev = plane->dev->dev_private;
> -	struct qxl_framebuffer *qfb =
> -		to_qxl_framebuffer(plane->state->fb);
> -	struct qxl_framebuffer *qfb_old;
> -	struct qxl_bo *bo = gem_to_qxl_bo(qfb->obj);
> +	struct drm_framebuffer *fb = plane->state->fb;
> +	struct drm_framebuffer *fb_old;
> +	struct qxl_bo *bo = gem_to_qxl_bo(fb->gem_objs[0]);
>  	struct qxl_bo *bo_old;
>  	struct drm_clip_rect norect = {
>  	    .x1 = 0,
>  	    .y1 = 0,
> -	    .x2 = qfb->base.width,
> -	    .y2 = qfb->base.height
> +	    .x2 = fb->width,
> +	    .y2 = fb->height
>  	};
>  
>  	if (!old_state->fb) {
> @@ -520,13 +513,13 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
>  		return;
>  
>  	} else {
> -		qfb_old = to_qxl_framebuffer(old_state->fb);
> -		bo_old = gem_to_qxl_bo(qfb_old->obj);
> +		fb_old = old_state->fb;
> +		bo_old = gem_to_qxl_bo(fb_old->gem_objs[0]);
>  		bo_old->is_primary = false;
>  	}
>  
>  	bo->is_primary = true;
> -	qxl_draw_dirty_fb(qdev, qfb, bo, 0, 0, &norect, 1, 1);
> +	qxl_draw_dirty_fb(qdev, fb, bo, 0, 0, &norect, 1, 1);
>  }
>  
>  static void qxl_primary_atomic_disable(struct drm_plane *plane,
> @@ -534,10 +527,9 @@ static void qxl_primary_atomic_disable(struct drm_plane *plane,
>  {
>  	struct qxl_device *qdev = plane->dev->dev_private;
>  
> -	if (old_state->fb)
> -	{	struct qxl_framebuffer *qfb =
> -			to_qxl_framebuffer(old_state->fb);
> -		struct qxl_bo *bo = gem_to_qxl_bo(qfb->obj);
> +	if (old_state->fb) {
> +		struct drm_framebuffer *fb = old_state->fb;
> +		struct qxl_bo *bo = gem_to_qxl_bo(fb->gem_objs[0]);
>  
>  		qxl_io_destroy_primary(qdev);
>  		bo->is_primary = false;
> @@ -572,7 +564,7 @@ static void qxl_cursor_atomic_update(struct drm_plane *plane,
>  		return;
>  
>  	if (fb != old_state->fb) {
> -		obj = to_qxl_framebuffer(fb)->obj;
> +		obj = fb->gem_objs[0];
>  		user_bo = gem_to_qxl_bo(obj);
>  
>  		/* pinning is done in the prepare/cleanup framevbuffer */
> @@ -682,7 +674,7 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
>  	if (!new_state->fb)
>  		return 0;
>  
> -	obj = to_qxl_framebuffer(new_state->fb)->obj;
> +	obj = new_state->fb->gem_objs[0];
>  	user_bo = gem_to_qxl_bo(obj);
>  
>  	ret = qxl_bo_pin(user_bo, QXL_GEM_DOMAIN_CPU, NULL);
> @@ -705,7 +697,7 @@ static void qxl_plane_cleanup_fb(struct drm_plane *plane,
>  		return;
>  	}
>  
> -	obj = to_qxl_framebuffer(plane->state->fb)->obj;
> +	obj = plane->state->fb->gem_objs[0];
>  	user_bo = gem_to_qxl_bo(obj);
>  	qxl_bo_unpin(user_bo);
>  }
> @@ -1092,25 +1084,26 @@ qxl_user_framebuffer_create(struct drm_device *dev,
>  			    const struct drm_mode_fb_cmd2 *mode_cmd)
>  {
>  	struct drm_gem_object *obj;
> -	struct qxl_framebuffer *qxl_fb;
> +	struct drm_framebuffer *fb;
>  	int ret;
>  
>  	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
>  	if (!obj)
>  		return NULL;
>  
> -	qxl_fb = kzalloc(sizeof(*qxl_fb), GFP_KERNEL);
> -	if (qxl_fb == NULL)
> +	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
> +	if (fb == NULL)
>  		return NULL;
>  
> -	ret = qxl_framebuffer_init(dev, qxl_fb, mode_cmd, obj, &qxl_fb_funcs);
> +	ret = qxl_framebuffer_init(dev, fb, mode_cmd, obj, &qxl_fb_funcs);
> +
>  	if (ret) {
> -		kfree(qxl_fb);
> +		kfree(fb);
>  		drm_gem_object_unreference_unlocked(obj);
>  		return NULL;
>  	}
>  
> -	return &qxl_fb->base;
> +	return fb;
>  }
>  
>  static const struct drm_mode_config_funcs qxl_mode_funcs = {
> diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
> index 4d8681e84e68..cc5b32e749ce 100644
> --- a/drivers/gpu/drm/qxl/qxl_draw.c
> +++ b/drivers/gpu/drm/qxl/qxl_draw.c
> @@ -262,7 +262,7 @@ void qxl_draw_opaque_fb(const struct qxl_fb_image *qxl_fb_image,
>   * by treating them differently in the server.
>   */
>  void qxl_draw_dirty_fb(struct qxl_device *qdev,
> -		       struct qxl_framebuffer *qxl_fb,
> +		       struct drm_framebuffer *fb,
>  		       struct qxl_bo *bo,
>  		       unsigned flags, unsigned color,
>  		       struct drm_clip_rect *clips,
> @@ -281,9 +281,9 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
>  	struct qxl_drawable *drawable;
>  	struct qxl_rect drawable_rect;
>  	struct qxl_rect *rects;
> -	int stride = qxl_fb->base.pitches[0];
> +	int stride = fb->pitches[0];
>  	/* depth is not actually interesting, we don't mask with it */
> -	int depth = qxl_fb->base.format->cpp[0] * 8;
> +	int depth = fb->format->cpp[0] * 8;
>  	uint8_t *surface_base;
>  	struct qxl_release *release;
>  	struct qxl_bo *clips_bo;
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
> index 3397a1907336..187bba7b8c4b 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.h
> +++ b/drivers/gpu/drm/qxl/qxl_drv.h
> @@ -141,15 +141,9 @@ struct qxl_output {
>  	struct drm_encoder enc;
>  };
>  
> -struct qxl_framebuffer {
> -	struct drm_framebuffer base;
> -	struct drm_gem_object *obj;
> -};
> -
>  #define to_qxl_crtc(x) container_of(x, struct qxl_crtc, base)
>  #define drm_connector_to_qxl_output(x) container_of(x, struct qxl_output, base)
>  #define drm_encoder_to_qxl_output(x) container_of(x, struct qxl_output, enc)
> -#define to_qxl_framebuffer(x) container_of(x, struct qxl_framebuffer, base)
>  
>  struct qxl_mman {
>  	struct ttm_bo_global_ref        bo_global_ref;
> @@ -254,7 +248,7 @@ struct qxl_device {
>  	struct qxl_mode_info mode_info;
>  
>  	struct fb_info			*fbdev_info;
> -	struct qxl_framebuffer	*fbdev_qfb;
> +	struct drm_framebuffer	*fbdev_qfb;
>  	void *ram_physical;
>  
>  	struct qxl_ring *release_ring;
> @@ -380,7 +374,7 @@ void qxl_fbdev_set_suspend(struct qxl_device *qdev, int state);
>  void qxl_user_framebuffer_destroy(struct drm_framebuffer *fb);
>  int
>  qxl_framebuffer_init(struct drm_device *dev,
> -		     struct qxl_framebuffer *rfb,
> +		     struct drm_framebuffer *rfb,
>  		     const struct drm_mode_fb_cmd2 *mode_cmd,
>  		     struct drm_gem_object *obj,
>  		     const struct drm_framebuffer_funcs *funcs);
> @@ -493,7 +487,7 @@ void qxl_draw_opaque_fb(const struct qxl_fb_image *qxl_fb_image,
>  			int stride /* filled in if 0 */);
>  
>  void qxl_draw_dirty_fb(struct qxl_device *qdev,
> -		       struct qxl_framebuffer *qxl_fb,
> +		       struct drm_framebuffer *fb,
>  		       struct qxl_bo *bo,
>  		       unsigned flags, unsigned color,
>  		       struct drm_clip_rect *clips,
> diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
> index 844c4a31ca13..3a26a969f2d6 100644
> --- a/drivers/gpu/drm/qxl/qxl_fb.c
> +++ b/drivers/gpu/drm/qxl/qxl_fb.c
> @@ -39,7 +39,7 @@
>  
>  struct qxl_fbdev {
>  	struct drm_fb_helper helper;
> -	struct qxl_framebuffer	qfb;
> +	struct drm_framebuffer	fb;
>  	struct qxl_device	*qdev;
>  
>  	spinlock_t delayed_ops_lock;
> @@ -103,7 +103,7 @@ int qxl_get_handle_for_primary_fb(struct qxl_device *qdev,
>  				  uint32_t *handle)
>  {
>  	int r;
> -	struct drm_gem_object *gobj = qdev->fbdev_qfb->obj;
> +	struct drm_gem_object *gobj = qdev->fbdev_qfb->gem_objs[0];
>  
>  	BUG_ON(!gobj);
>  	/* drm_get_handle_create adds a reference - good */
> @@ -180,7 +180,7 @@ static int qxlfb_framebuffer_dirty(struct drm_framebuffer *fb,
>  	struct fb_image *image = &qxl_fb_image.fb_image;
>  
>  	/* TODO: hard coding 32 bpp */
> -	int stride = qfbdev->qfb.base.pitches[0];
> +	int stride = qfbdev->fb.pitches[0];
>  
>  	/*
>  	 * we are using a shadow draw buffer, at qdev->surface0_shadow
> @@ -262,10 +262,10 @@ static int qxlfb_create(struct qxl_fbdev *qfbdev,
>  
>  	info->par = qfbdev;
>  
> -	qxl_framebuffer_init(&qdev->ddev, &qfbdev->qfb, &mode_cmd, gobj,
> +	qxl_framebuffer_init(&qdev->ddev, &qfbdev->fb, &mode_cmd, gobj,
>  			     &qxlfb_fb_funcs);
>  
> -	fb = &qfbdev->qfb.base;
> +	fb = &qfbdev->fb;
>  
>  	/* setup helper with fb data */
>  	qfbdev->helper.fb = fb;
> @@ -307,7 +307,7 @@ static int qxlfb_create(struct qxl_fbdev *qfbdev,
>  #endif
>  
>  	qdev->fbdev_info = info;
> -	qdev->fbdev_qfb = &qfbdev->qfb;
> +	qdev->fbdev_qfb = &qfbdev->fb;
>  	DRM_INFO("fb mappable at 0x%lX, size %lu\n",  info->fix.smem_start, (unsigned long)info->screen_size);
>  	DRM_INFO("fb: depth %d, pitch %d, width %d, height %d\n",
>  		 fb->format->depth, fb->pitches[0], fb->width, fb->height);
> @@ -347,17 +347,17 @@ static int qxl_fb_find_or_create_single(
>  
>  static int qxl_fbdev_destroy(struct drm_device *dev, struct qxl_fbdev *qfbdev)
>  {
> -	struct qxl_framebuffer *qfb = &qfbdev->qfb;
> +	struct drm_framebuffer *fb = &qfbdev->fb;
>  
>  	drm_fb_helper_unregister_fbi(&qfbdev->helper);
>  
> -	if (qfb->obj) {
> -		qxlfb_destroy_pinned_object(qfb->obj);
> -		qfb->obj = NULL;
> +	if (fb->gem_objs[0]) {
> +		qxlfb_destroy_pinned_object(fb->gem_objs[0]);
> +		fb->gem_objs[0] = NULL;
>  	}
>  	drm_fb_helper_fini(&qfbdev->helper);
>  	vfree(qfbdev->shadow);
> -	drm_framebuffer_cleanup(&qfb->base);
> +	drm_framebuffer_cleanup(fb);
>  
>  	return 0;
>  }
> @@ -430,7 +430,7 @@ void qxl_fbdev_set_suspend(struct qxl_device *qdev, int state)
>  
>  bool qxl_fbdev_qobj_is_fb(struct qxl_device *qdev, struct qxl_bo *qobj)
>  {
> -	if (qobj == gem_to_qxl_bo(qdev->mode_info.qfbdev->qfb.obj))
> +	if (qobj == gem_to_qxl_bo(qdev->mode_info.qfbdev->fb.gem_objs[0]))
>  		return true;
>  	return false;
>  }
> diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
> index 3c492a0aa6bd..2534d0ae073e 100644
> --- a/drivers/gpu/drm/radeon/atombios_crtc.c
> +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
> @@ -1145,7 +1145,6 @@ static int dce4_crtc_do_set_base(struct drm_crtc *crtc,
>  	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
>  	struct drm_device *dev = crtc->dev;
>  	struct radeon_device *rdev = dev->dev_private;
> -	struct radeon_framebuffer *radeon_fb;
>  	struct drm_framebuffer *target_fb;
>  	struct drm_gem_object *obj;
>  	struct radeon_bo *rbo;
> @@ -1165,18 +1164,16 @@ static int dce4_crtc_do_set_base(struct drm_crtc *crtc,
>  	}
>  
>  	if (atomic) {
> -		radeon_fb = to_radeon_framebuffer(fb);
>  		target_fb = fb;
>  	}
>  	else {
> -		radeon_fb = to_radeon_framebuffer(crtc->primary->fb);
>  		target_fb = crtc->primary->fb;
>  	}
>  
>  	/* If atomic, assume fb object is pinned & idle & fenced and
>  	 * just update base pointers
>  	 */
> -	obj = radeon_fb->obj;
> +	obj = target_fb->gem_objs[0];
>  	rbo = gem_to_radeon_bo(obj);
>  	r = radeon_bo_reserve(rbo, false);
>  	if (unlikely(r != 0))
> @@ -1441,8 +1438,7 @@ static int dce4_crtc_do_set_base(struct drm_crtc *crtc,
>  	WREG32(EVERGREEN_MASTER_UPDATE_MODE + radeon_crtc->crtc_offset, 0);
>  
>  	if (!atomic && fb && fb != crtc->primary->fb) {
> -		radeon_fb = to_radeon_framebuffer(fb);
> -		rbo = gem_to_radeon_bo(radeon_fb->obj);
> +		rbo = gem_to_radeon_bo(fb->gem_objs[0]);
>  		r = radeon_bo_reserve(rbo, false);
>  		if (unlikely(r != 0))
>  			return r;
> @@ -1463,7 +1459,6 @@ static int avivo_crtc_do_set_base(struct drm_crtc *crtc,
>  	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
>  	struct drm_device *dev = crtc->dev;
>  	struct radeon_device *rdev = dev->dev_private;
> -	struct radeon_framebuffer *radeon_fb;
>  	struct drm_gem_object *obj;
>  	struct radeon_bo *rbo;
>  	struct drm_framebuffer *target_fb;
> @@ -1482,15 +1477,13 @@ static int avivo_crtc_do_set_base(struct drm_crtc *crtc,
>  	}
>  
>  	if (atomic) {
> -		radeon_fb = to_radeon_framebuffer(fb);
>  		target_fb = fb;
>  	}
>  	else {
> -		radeon_fb = to_radeon_framebuffer(crtc->primary->fb);
>  		target_fb = crtc->primary->fb;
>  	}
>  
> -	obj = radeon_fb->obj;
> +	obj = target_fb->gem_objs[0];
>  	rbo = gem_to_radeon_bo(obj);
>  	r = radeon_bo_reserve(rbo, false);
>  	if (unlikely(r != 0))
> @@ -1641,8 +1634,7 @@ static int avivo_crtc_do_set_base(struct drm_crtc *crtc,
>  	WREG32(AVIVO_D1MODE_MASTER_UPDATE_MODE + radeon_crtc->crtc_offset, 3);
>  
>  	if (!atomic && fb && fb != crtc->primary->fb) {
> -		radeon_fb = to_radeon_framebuffer(fb);
> -		rbo = gem_to_radeon_bo(radeon_fb->obj);
> +		rbo = gem_to_radeon_bo(fb->gem_objs[0]);
>  		r = radeon_bo_reserve(rbo, false);
>  		if (unlikely(r != 0))
>  			return r;
> @@ -2149,11 +2141,11 @@ static void atombios_crtc_disable(struct drm_crtc *crtc)
>  	atombios_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
>  	if (crtc->primary->fb) {
>  		int r;
> -		struct radeon_framebuffer *radeon_fb;
> +		struct drm_framebuffer *fb;
>  		struct radeon_bo *rbo;
>  
> -		radeon_fb = to_radeon_framebuffer(crtc->primary->fb);
> -		rbo = gem_to_radeon_bo(radeon_fb->obj);
> +		fb = crtc->primary->fb;
> +		rbo = gem_to_radeon_bo(fb->gem_objs[0]);
>  		r = radeon_bo_reserve(rbo, false);
>  		if (unlikely(r))
>  			DRM_ERROR("failed to reserve rbo before unpin\n");
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 997131d58c7f..058ff536cb82 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1613,7 +1613,7 @@ int radeon_suspend_kms(struct drm_device *dev, bool suspend,
>  	/* unpin the front buffers and cursors */
>  	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
>  		struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
> -		struct radeon_framebuffer *rfb = to_radeon_framebuffer(crtc->primary->fb);
> +		struct drm_framebuffer *fb = crtc->primary->fb;
>  		struct radeon_bo *robj;
>  
>  		if (radeon_crtc->cursor_bo) {
> @@ -1625,10 +1625,10 @@ int radeon_suspend_kms(struct drm_device *dev, bool suspend,
>  			}
>  		}
>  
> -		if (rfb == NULL || rfb->obj == NULL) {
> +		if (fb == NULL || fb->gem_objs[0] == NULL) {
>  			continue;
>  		}
> -		robj = gem_to_radeon_bo(rfb->obj);
> +		robj = gem_to_radeon_bo(fb->gem_objs[0]);
>  		/* don't unpin kernel fb objects */
>  		if (!radeon_fbdev_robj_is_fb(rdev, robj)) {
>  			r = radeon_bo_reserve(robj, false);
> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
> index f339c1c10fa1..71aea3193139 100644
> --- a/drivers/gpu/drm/radeon/radeon_display.c
> +++ b/drivers/gpu/drm/radeon/radeon_display.c
> @@ -492,8 +492,8 @@ static int radeon_crtc_page_flip_target(struct drm_crtc *crtc,
>  	struct drm_device *dev = crtc->dev;
>  	struct radeon_device *rdev = dev->dev_private;
>  	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
> -	struct radeon_framebuffer *old_radeon_fb;
> -	struct radeon_framebuffer *new_radeon_fb;
> +	struct drm_framebuffer *old_fb;
> +	struct drm_framebuffer *new_fb;
>  	struct drm_gem_object *obj;
>  	struct radeon_flip_work *work;
>  	struct radeon_bo *new_rbo;
> @@ -515,15 +515,15 @@ static int radeon_crtc_page_flip_target(struct drm_crtc *crtc,
>  	work->async = (page_flip_flags & DRM_MODE_PAGE_FLIP_ASYNC) != 0;
>  
>  	/* schedule unpin of the old buffer */
> -	old_radeon_fb = to_radeon_framebuffer(crtc->primary->fb);
> -	obj = old_radeon_fb->obj;
> +	old_fb = crtc->primary->fb;
> +	obj = old_fb->gem_objs[0];
>  
>  	/* take a reference to the old object */
>  	drm_gem_object_reference(obj);
>  	work->old_rbo = gem_to_radeon_bo(obj);
>  
> -	new_radeon_fb = to_radeon_framebuffer(fb);
> -	obj = new_radeon_fb->obj;
> +	new_fb = fb;
> +	obj = new_fb->gem_objs[0];
>  	new_rbo = gem_to_radeon_bo(obj);
>  
>  	/* pin the new buffer */
> @@ -1301,39 +1301,27 @@ void radeon_compute_pll_legacy(struct radeon_pll *pll,
>  
>  static void radeon_user_framebuffer_destroy(struct drm_framebuffer *fb)
>  {
> -	struct radeon_framebuffer *radeon_fb = to_radeon_framebuffer(fb);
> -
> -	drm_gem_object_unreference_unlocked(radeon_fb->obj);
> +	drm_gem_object_unreference_unlocked(fb->gem_objs[0]);
>  	drm_framebuffer_cleanup(fb);
> -	kfree(radeon_fb);
> -}
> -
> -static int radeon_user_framebuffer_create_handle(struct drm_framebuffer *fb,
> -						  struct drm_file *file_priv,
> -						  unsigned int *handle)
> -{
> -	struct radeon_framebuffer *radeon_fb = to_radeon_framebuffer(fb);
> -
> -	return drm_gem_handle_create(file_priv, radeon_fb->obj, handle);
> +	kfree(fb);
>  }
>  
>  static const struct drm_framebuffer_funcs radeon_fb_funcs = {
>  	.destroy = radeon_user_framebuffer_destroy,
> -	.create_handle = radeon_user_framebuffer_create_handle,
>  };
>  
>  int
>  radeon_framebuffer_init(struct drm_device *dev,
> -			struct radeon_framebuffer *rfb,
> +			struct drm_framebuffer *fb,
>  			const struct drm_mode_fb_cmd2 *mode_cmd,
>  			struct drm_gem_object *obj)
>  {
>  	int ret;
> -	rfb->obj = obj;
> -	drm_helper_mode_fill_fb_struct(dev, &rfb->base, mode_cmd);
> -	ret = drm_framebuffer_init(dev, &rfb->base, &radeon_fb_funcs);
> +	drm_helper_mode_fill_fb_struct(dev, fb, mode_cmd);
> +	fb->gem_objs[0] = obj;
> +	ret = drm_framebuffer_init(dev, fb, &radeon_fb_funcs);
>  	if (ret) {
> -		rfb->obj = NULL;
> +		fb->gem_objs[0] = NULL;
>  		return ret;
>  	}
>  	return 0;
> @@ -1345,7 +1333,7 @@ radeon_user_framebuffer_create(struct drm_device *dev,
>  			       const struct drm_mode_fb_cmd2 *mode_cmd)
>  {
>  	struct drm_gem_object *obj;
> -	struct radeon_framebuffer *radeon_fb;
> +	struct drm_framebuffer *fb;
>  	int ret;
>  
>  	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
> @@ -1361,20 +1349,20 @@ radeon_user_framebuffer_create(struct drm_device *dev,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	radeon_fb = kzalloc(sizeof(*radeon_fb), GFP_KERNEL);
> -	if (radeon_fb == NULL) {
> +	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
> +	if (fb == NULL) {
>  		drm_gem_object_unreference_unlocked(obj);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> -	ret = radeon_framebuffer_init(dev, radeon_fb, mode_cmd, obj);
> +	ret = radeon_framebuffer_init(dev, fb, mode_cmd, obj);
>  	if (ret) {
> -		kfree(radeon_fb);
> +		kfree(fb);
>  		drm_gem_object_unreference_unlocked(obj);
>  		return ERR_PTR(ret);
>  	}
>  
> -	return &radeon_fb->base;
> +	return fb;
>  }
>  
>  static void radeon_output_poll_changed(struct drm_device *dev)
> diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
> index 7fc63fecb8c1..8a5aa57835c5 100644
> --- a/drivers/gpu/drm/radeon/radeon_fb.c
> +++ b/drivers/gpu/drm/radeon/radeon_fb.c
> @@ -43,7 +43,7 @@
>   */
>  struct radeon_fbdev {
>  	struct drm_fb_helper helper;
> -	struct radeon_framebuffer rfb;
> +	struct drm_framebuffer fb;
>  	struct radeon_device *rdev;
>  };
>  
> @@ -247,13 +247,13 @@ static int radeonfb_create(struct drm_fb_helper *helper,
>  	info->par = rfbdev;
>  	info->skip_vt_switch = true;
>  
> -	ret = radeon_framebuffer_init(rdev->ddev, &rfbdev->rfb, &mode_cmd, gobj);
> +	ret = radeon_framebuffer_init(rdev->ddev, &rfbdev->fb, &mode_cmd, gobj);
>  	if (ret) {
>  		DRM_ERROR("failed to initialize framebuffer %d\n", ret);
>  		goto out;
>  	}
>  
> -	fb = &rfbdev->rfb.base;
> +	fb = &rfbdev->fb;
>  
>  	/* setup helper */
>  	rfbdev->helper.fb = fb;
> @@ -315,17 +315,17 @@ void radeon_fb_output_poll_changed(struct radeon_device *rdev)
>  
>  static int radeon_fbdev_destroy(struct drm_device *dev, struct radeon_fbdev *rfbdev)
>  {
> -	struct radeon_framebuffer *rfb = &rfbdev->rfb;
> +	struct drm_framebuffer *fb = &rfbdev->fb;
>  
>  	drm_fb_helper_unregister_fbi(&rfbdev->helper);
>  
> -	if (rfb->obj) {
> -		radeonfb_destroy_pinned_object(rfb->obj);
> -		rfb->obj = NULL;
> +	if (fb->gem_objs[0]) {
> +		radeonfb_destroy_pinned_object(fb->gem_objs[0]);
> +		fb->gem_objs[0] = NULL;
>  	}
>  	drm_fb_helper_fini(&rfbdev->helper);
> -	drm_framebuffer_unregister_private(&rfb->base);
> -	drm_framebuffer_cleanup(&rfb->base);
> +	drm_framebuffer_unregister_private(fb);
> +	drm_framebuffer_cleanup(fb);
>  
>  	return 0;
>  }
> @@ -409,7 +409,7 @@ bool radeon_fbdev_robj_is_fb(struct radeon_device *rdev, struct radeon_bo *robj)
>  	if (!rdev->mode_info.rfbdev)
>  		return false;
>  
> -	if (robj == gem_to_radeon_bo(rdev->mode_info.rfbdev->rfb.obj))
> +	if (robj == gem_to_radeon_bo(rdev->mode_info.rfbdev->fb.gem_objs[0]))
>  		return true;
>  	return false;
>  }
> diff --git a/drivers/gpu/drm/radeon/radeon_legacy_crtc.c b/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
> index ce6cb6666212..7dbe2d091b08 100644
> --- a/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
> +++ b/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
> @@ -374,7 +374,6 @@ int radeon_crtc_do_set_base(struct drm_crtc *crtc,
>  	struct drm_device *dev = crtc->dev;
>  	struct radeon_device *rdev = dev->dev_private;
>  	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
> -	struct radeon_framebuffer *radeon_fb;
>  	struct drm_framebuffer *target_fb;
>  	struct drm_gem_object *obj;
>  	struct radeon_bo *rbo;
> @@ -394,11 +393,9 @@ int radeon_crtc_do_set_base(struct drm_crtc *crtc,
>  	}
>  
>  	if (atomic) {
> -		radeon_fb = to_radeon_framebuffer(fb);
>  		target_fb = fb;
>  	}
>  	else {
> -		radeon_fb = to_radeon_framebuffer(crtc->primary->fb);
>  		target_fb = crtc->primary->fb;
>  	}
>  
> @@ -423,7 +420,7 @@ int radeon_crtc_do_set_base(struct drm_crtc *crtc,
>  	}
>  
>  	/* Pin framebuffer & get tilling informations */
> -	obj = radeon_fb->obj;
> +	obj = target_fb->gem_objs[0];
>  	rbo = gem_to_radeon_bo(obj);
>  retry:
>  	r = radeon_bo_reserve(rbo, false);
> @@ -451,7 +448,7 @@ int radeon_crtc_do_set_base(struct drm_crtc *crtc,
>  			struct radeon_bo *old_rbo;
>  			unsigned long nsize, osize;
>  
> -			old_rbo = gem_to_radeon_bo(to_radeon_framebuffer(fb)->obj);
> +			old_rbo = gem_to_radeon_bo(fb->gem_objs[0]);
>  			osize = radeon_bo_size(old_rbo);
>  			nsize = radeon_bo_size(rbo);
>  			if (nsize <= osize && !radeon_bo_reserve(old_rbo, false)) {
> @@ -558,8 +555,7 @@ int radeon_crtc_do_set_base(struct drm_crtc *crtc,
>  	WREG32(RADEON_CRTC_PITCH + radeon_crtc->crtc_offset, crtc_pitch);
>  
>  	if (!atomic && fb && fb != crtc->primary->fb) {
> -		radeon_fb = to_radeon_framebuffer(fb);
> -		rbo = gem_to_radeon_bo(radeon_fb->obj);
> +		rbo = gem_to_radeon_bo(fb->gem_objs[0]);
>  		r = radeon_bo_reserve(rbo, false);
>  		if (unlikely(r != 0))
>  			return r;
> @@ -1093,11 +1089,11 @@ static void radeon_crtc_disable(struct drm_crtc *crtc)
>  	radeon_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
>  	if (crtc->primary->fb) {
>  		int r;
> -		struct radeon_framebuffer *radeon_fb;
> +		struct drm_framebuffer *fb;
>  		struct radeon_bo *rbo;
>  
> -		radeon_fb = to_radeon_framebuffer(crtc->primary->fb);
> -		rbo = gem_to_radeon_bo(radeon_fb->obj);
> +		fb = crtc->primary->fb;
> +		rbo = gem_to_radeon_bo(fb->gem_objs[0]);
>  		r = radeon_bo_reserve(rbo, false);
>  		if (unlikely(r))
>  			DRM_ERROR("failed to reserve rbo before unpin\n");
> diff --git a/drivers/gpu/drm/radeon/radeon_mode.h b/drivers/gpu/drm/radeon/radeon_mode.h
> index 00f5ec5c12c7..0dfe9d7eb281 100644
> --- a/drivers/gpu/drm/radeon/radeon_mode.h
> +++ b/drivers/gpu/drm/radeon/radeon_mode.h
> @@ -46,7 +46,6 @@ struct radeon_device;
>  #define to_radeon_crtc(x) container_of(x, struct radeon_crtc, base)
>  #define to_radeon_connector(x) container_of(x, struct radeon_connector, base)
>  #define to_radeon_encoder(x) container_of(x, struct radeon_encoder, base)
> -#define to_radeon_framebuffer(x) container_of(x, struct radeon_framebuffer, base)
>  
>  #define RADEON_MAX_HPD_PINS 7
>  #define RADEON_MAX_CRTCS 6
> @@ -574,11 +573,6 @@ struct radeon_connector {
>  	int enabled_attribs;
>  };
>  
> -struct radeon_framebuffer {
> -	struct drm_framebuffer base;
> -	struct drm_gem_object *obj;
> -};
> -
>  #define ENCODER_MODE_IS_DP(em) (((em) == ATOM_ENCODER_MODE_DP) || \
>  				((em) == ATOM_ENCODER_MODE_DP_MST))
>  
> @@ -940,7 +934,7 @@ extern void radeon_crtc_fb_gamma_set(struct drm_crtc *crtc, u16 red, u16 green,
>  extern void radeon_crtc_fb_gamma_get(struct drm_crtc *crtc, u16 *red, u16 *green,
>  				     u16 *blue, int regno);
>  int radeon_framebuffer_init(struct drm_device *dev,
> -			     struct radeon_framebuffer *rfb,
> +			     struct drm_framebuffer *fb,
>  			     const struct drm_mode_fb_cmd2 *mode_cmd,
>  			     struct drm_gem_object *obj);
>  
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> index 8a0f75612d4b..0225065ffcf7 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
> @@ -24,44 +24,24 @@
>  #include "rockchip_drm_gem.h"
>  #include "rockchip_drm_psr.h"
>  
> -#define to_rockchip_fb(x) container_of(x, struct rockchip_drm_fb, fb)
> -
> -struct rockchip_drm_fb {
> -	struct drm_framebuffer fb;
> -	struct drm_gem_object *obj[ROCKCHIP_MAX_FB_BUFFER];
> -};
> -
>  struct drm_gem_object *rockchip_fb_get_gem_obj(struct drm_framebuffer *fb,
>  					       unsigned int plane)
>  {
> -	struct rockchip_drm_fb *rk_fb = to_rockchip_fb(fb);
> -
>  	if (plane >= ROCKCHIP_MAX_FB_BUFFER)
>  		return NULL;
>  
> -	return rk_fb->obj[plane];
> +	return fb->gem_objs[plane];
>  }
>  
>  static void rockchip_drm_fb_destroy(struct drm_framebuffer *fb)
>  {
> -	struct rockchip_drm_fb *rockchip_fb = to_rockchip_fb(fb);
>  	int i;
>  
>  	for (i = 0; i < ROCKCHIP_MAX_FB_BUFFER; i++)
> -		drm_gem_object_unreference_unlocked(rockchip_fb->obj[i]);
> +		drm_gem_object_unreference_unlocked(fb->gem_objs[i]);
>  
>  	drm_framebuffer_cleanup(fb);
> -	kfree(rockchip_fb);
> -}
> -
> -static int rockchip_drm_fb_create_handle(struct drm_framebuffer *fb,
> -					 struct drm_file *file_priv,
> -					 unsigned int *handle)
> -{
> -	struct rockchip_drm_fb *rockchip_fb = to_rockchip_fb(fb);
> -
> -	return drm_gem_handle_create(file_priv,
> -				     rockchip_fb->obj[0], handle);
> +	kfree(fb);
>  }
>  
>  static int rockchip_drm_fb_dirty(struct drm_framebuffer *fb,
> @@ -76,44 +56,43 @@ static int rockchip_drm_fb_dirty(struct drm_framebuffer *fb,
>  
>  static const struct drm_framebuffer_funcs rockchip_drm_fb_funcs = {
>  	.destroy	= rockchip_drm_fb_destroy,
> -	.create_handle	= rockchip_drm_fb_create_handle,
>  	.dirty		= rockchip_drm_fb_dirty,
>  };
>  
> -static struct rockchip_drm_fb *
> +static struct drm_framebuffer *
>  rockchip_fb_alloc(struct drm_device *dev, const struct drm_mode_fb_cmd2 *mode_cmd,
>  		  struct drm_gem_object **obj, unsigned int num_planes)
>  {
> -	struct rockchip_drm_fb *rockchip_fb;
> +	struct drm_framebuffer *fb;
>  	int ret;
>  	int i;
>  
> -	rockchip_fb = kzalloc(sizeof(*rockchip_fb), GFP_KERNEL);
> -	if (!rockchip_fb)
> +	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
> +	if (!fb)
>  		return ERR_PTR(-ENOMEM);
>  
> -	drm_helper_mode_fill_fb_struct(dev, &rockchip_fb->fb, mode_cmd);
> +	drm_helper_mode_fill_fb_struct(dev, fb, mode_cmd);
>  
>  	for (i = 0; i < num_planes; i++)
> -		rockchip_fb->obj[i] = obj[i];
> +		fb->gem_objs[i] = obj[i];
>  
> -	ret = drm_framebuffer_init(dev, &rockchip_fb->fb,
> +	ret = drm_framebuffer_init(dev, fb,
>  				   &rockchip_drm_fb_funcs);
>  	if (ret) {
>  		dev_err(dev->dev, "Failed to initialize framebuffer: %d\n",
>  			ret);
> -		kfree(rockchip_fb);
> +		kfree(fb);
>  		return ERR_PTR(ret);
>  	}
>  
> -	return rockchip_fb;
> +	return fb;
>  }
>  
>  static struct drm_framebuffer *
>  rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
>  			const struct drm_mode_fb_cmd2 *mode_cmd)
>  {
> -	struct rockchip_drm_fb *rockchip_fb;
> +	struct drm_framebuffer *fb;
>  	struct drm_gem_object *objs[ROCKCHIP_MAX_FB_BUFFER];
>  	struct drm_gem_object *obj;
>  	unsigned int hsub;
> @@ -151,13 +130,13 @@ rockchip_user_fb_create(struct drm_device *dev, struct drm_file *file_priv,
>  		objs[i] = obj;
>  	}
>  
> -	rockchip_fb = rockchip_fb_alloc(dev, mode_cmd, objs, i);
> -	if (IS_ERR(rockchip_fb)) {
> -		ret = PTR_ERR(rockchip_fb);
> +	fb = rockchip_fb_alloc(dev, mode_cmd, objs, i);
> +	if (IS_ERR(fb)) {
> +		ret = PTR_ERR(fb);
>  		goto err_gem_object_unreference;
>  	}
>  
> -	return &rockchip_fb->fb;
> +	return fb;
>  
>  err_gem_object_unreference:
>  	for (i--; i >= 0; i--)
> @@ -188,13 +167,13 @@ rockchip_drm_framebuffer_init(struct drm_device *dev,
>  			      const struct drm_mode_fb_cmd2 *mode_cmd,
>  			      struct drm_gem_object *obj)
>  {
> -	struct rockchip_drm_fb *rockchip_fb;
> +	struct drm_framebuffer *fb;
>  
> -	rockchip_fb = rockchip_fb_alloc(dev, mode_cmd, &obj, 1);
> -	if (IS_ERR(rockchip_fb))
> -		return ERR_CAST(rockchip_fb);
> +	fb = rockchip_fb_alloc(dev, mode_cmd, &obj, 1);
> +	if (IS_ERR(fb))
> +		return ERR_CAST(fb);
>  
> -	return &rockchip_fb->fb;
> +	return fb;
>  }
>  
>  void rockchip_drm_mode_config_init(struct drm_device *dev)
> diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
> index 6d6da01282f3..f5078e06ad40 100644
> --- a/drivers/gpu/drm/tegra/drm.h
> +++ b/drivers/gpu/drm/tegra/drm.h
> @@ -26,16 +26,10 @@
>  
>  struct reset_control;
>  
> -struct tegra_fb {
> -	struct drm_framebuffer base;
> -	struct tegra_bo **planes;
> -	unsigned int num_planes;
> -};
> -
>  #ifdef CONFIG_DRM_FBDEV_EMULATION
>  struct tegra_fbdev {
>  	struct drm_fb_helper base;
> -	struct tegra_fb *fb;
> +	struct drm_framebuffer *fb;
>  };
>  #endif
>  
> diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
> index 25acb73ee728..81e82ddbe748 100644
> --- a/drivers/gpu/drm/tegra/fb.c
> +++ b/drivers/gpu/drm/tegra/fb.c
> @@ -15,11 +15,6 @@
>  #include "drm.h"
>  #include "gem.h"
>  
> -static inline struct tegra_fb *to_tegra_fb(struct drm_framebuffer *fb)
> -{
> -	return container_of(fb, struct tegra_fb, base);
> -}
> -
>  #ifdef CONFIG_DRM_FBDEV_EMULATION
>  static inline struct tegra_fbdev *to_tegra_fbdev(struct drm_fb_helper *helper)
>  {
> @@ -30,19 +25,17 @@ static inline struct tegra_fbdev *to_tegra_fbdev(struct drm_fb_helper *helper)
>  struct tegra_bo *tegra_fb_get_plane(struct drm_framebuffer *framebuffer,
>  				    unsigned int index)
>  {
> -	struct tegra_fb *fb = to_tegra_fb(framebuffer);
> -
>  	if (index >= framebuffer->format->num_planes)
>  		return NULL;
>  
> -	return fb->planes[index];
> +	return container_of(framebuffer->gem_objs[index], struct tegra_bo, gem);
>  }
>  
>  bool tegra_fb_is_bottom_up(struct drm_framebuffer *framebuffer)
>  {
> -	struct tegra_fb *fb = to_tegra_fb(framebuffer);
> +	struct tegra_bo *bo = tegra_fb_get_plane(framebuffer, 0);
>  
> -	if (fb->planes[0]->flags & TEGRA_BO_BOTTOM_UP)
> +	if (bo->flags & TEGRA_BO_BOTTOM_UP)
>  		return true;
>  
>  	return false;
> @@ -51,8 +44,7 @@ bool tegra_fb_is_bottom_up(struct drm_framebuffer *framebuffer)
>  int tegra_fb_get_tiling(struct drm_framebuffer *framebuffer,
>  			struct tegra_bo_tiling *tiling)
>  {
> -	struct tegra_fb *fb = to_tegra_fb(framebuffer);
> -	uint64_t modifier = fb->base.modifier;
> +	uint64_t modifier = framebuffer->modifier;
>  
>  	switch (fourcc_mod_tegra_mod(modifier)) {
>  	case NV_FORMAT_MOD_TEGRA_TILED:
> @@ -69,7 +61,7 @@ int tegra_fb_get_tiling(struct drm_framebuffer *framebuffer,
>  
>  	default:
>  		/* TODO: handle YUV formats? */
> -		*tiling = fb->planes[0]->tiling;
> +		*tiling = tegra_fb_get_plane(framebuffer, 0)->tiling;
>  		break;
>  	}
>  
> @@ -78,11 +70,10 @@ int tegra_fb_get_tiling(struct drm_framebuffer *framebuffer,
>  
>  static void tegra_fb_destroy(struct drm_framebuffer *framebuffer)
>  {
> -	struct tegra_fb *fb = to_tegra_fb(framebuffer);
>  	unsigned int i;
>  
> -	for (i = 0; i < fb->num_planes; i++) {
> -		struct tegra_bo *bo = fb->planes[i];
> +	for (i = 0; i < framebuffer->format->num_planes; i++) {
> +		struct tegra_bo *bo = tegra_fb_get_plane(framebuffer, i);
>  
>  		if (bo) {
>  			if (bo->pages)
> @@ -93,29 +84,19 @@ static void tegra_fb_destroy(struct drm_framebuffer *framebuffer)
>  	}
>  
>  	drm_framebuffer_cleanup(framebuffer);
> -	kfree(fb->planes);
> -	kfree(fb);
> -}
> -
> -static int tegra_fb_create_handle(struct drm_framebuffer *framebuffer,
> -				  struct drm_file *file, unsigned int *handle)
> -{
> -	struct tegra_fb *fb = to_tegra_fb(framebuffer);
> -
> -	return drm_gem_handle_create(file, &fb->planes[0]->gem, handle);
> +	kfree(framebuffer);
>  }
>  
>  static const struct drm_framebuffer_funcs tegra_fb_funcs = {
>  	.destroy = tegra_fb_destroy,
> -	.create_handle = tegra_fb_create_handle,
>  };
>  
> -static struct tegra_fb *tegra_fb_alloc(struct drm_device *drm,
> +static struct drm_framebuffer *tegra_fb_alloc(struct drm_device *drm,
>  				       const struct drm_mode_fb_cmd2 *mode_cmd,
>  				       struct tegra_bo **planes,
>  				       unsigned int num_planes)
>  {
> -	struct tegra_fb *fb;
> +	struct drm_framebuffer *fb;
>  	unsigned int i;
>  	int err;
>  
> @@ -123,24 +104,15 @@ static struct tegra_fb *tegra_fb_alloc(struct drm_device *drm,
>  	if (!fb)
>  		return ERR_PTR(-ENOMEM);
>  
> -	fb->planes = kzalloc(num_planes * sizeof(*planes), GFP_KERNEL);
> -	if (!fb->planes) {
> -		kfree(fb);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	fb->num_planes = num_planes;
> -
> -	drm_helper_mode_fill_fb_struct(drm, &fb->base, mode_cmd);
> +	drm_helper_mode_fill_fb_struct(drm, fb, mode_cmd);
>  
> -	for (i = 0; i < fb->num_planes; i++)
> -		fb->planes[i] = planes[i];
> +	for (i = 0; i < fb->format->num_planes; i++)
> +		fb->gem_objs[i] = &planes[i]->gem;
>  
> -	err = drm_framebuffer_init(drm, &fb->base, &tegra_fb_funcs);
> +	err = drm_framebuffer_init(drm, fb, &tegra_fb_funcs);
>  	if (err < 0) {
>  		dev_err(drm->dev, "failed to initialize framebuffer: %d\n",
>  			err);
> -		kfree(fb->planes);
>  		kfree(fb);
>  		return ERR_PTR(err);
>  	}
> @@ -155,7 +127,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
>  	unsigned int hsub, vsub, i;
>  	struct tegra_bo *planes[4];
>  	struct drm_gem_object *gem;
> -	struct tegra_fb *fb;
> +	struct drm_framebuffer *fb;
>  	int err;
>  
>  	hsub = drm_format_horz_chroma_subsampling(cmd->pixel_format);
> @@ -191,7 +163,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
>  		goto unreference;
>  	}
>  
> -	return &fb->base;
> +	return fb;
>  
>  unreference:
>  	while (i--)
> @@ -255,7 +227,7 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
>  		return PTR_ERR(fbdev->fb);
>  	}
>  
> -	fb = &fbdev->fb->base;
> +	fb = fbdev->fb;
>  	helper->fb = fb;
>  	helper->fbdev = info;
>  
> @@ -356,7 +328,7 @@ static void tegra_fbdev_exit(struct tegra_fbdev *fbdev)
>  	drm_fb_helper_unregister_fbi(&fbdev->base);
>  
>  	if (fbdev->fb)
> -		drm_framebuffer_remove(&fbdev->fb->base);
> +		drm_framebuffer_remove(fbdev->fb);
>  
>  	drm_fb_helper_fini(&fbdev->base);
>  	tegra_fbdev_free(fbdev);
> diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> index c83eeb7a34b0..35eda5d04605 100644
> --- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
> +++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> @@ -254,7 +254,6 @@ static int mipi_dbi_fb_dirty(struct drm_framebuffer *fb,
>  
>  static const struct drm_framebuffer_funcs mipi_dbi_fb_funcs = {
>  	.destroy	= drm_fb_cma_destroy,
> -	.create_handle	= drm_fb_cma_create_handle,
>  	.dirty		= mipi_dbi_fb_dirty,
>  };
>  
> diff --git a/drivers/gpu/drm/tinydrm/repaper.c b/drivers/gpu/drm/tinydrm/repaper.c
> index 3343d3f15a90..c05815f28874 100644
> --- a/drivers/gpu/drm/tinydrm/repaper.c
> +++ b/drivers/gpu/drm/tinydrm/repaper.c
> @@ -615,7 +615,6 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb,
>  
>  static const struct drm_framebuffer_funcs repaper_fb_funcs = {
>  	.destroy	= drm_fb_cma_destroy,
> -	.create_handle	= drm_fb_cma_create_handle,
>  	.dirty		= repaper_fb_dirty,
>  };
>  
> diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
> index 5244f059d23a..450a2e35fd32 100644
> --- a/include/drm/drm_framebuffer.h
> +++ b/include/drm/drm_framebuffer.h
> @@ -46,28 +46,6 @@ struct drm_framebuffer_funcs {
>  	 * framebuffer.
>  	 */
>  	void (*destroy)(struct drm_framebuffer *framebuffer);
> -
> -	/**
> -	 * @create_handle:
> -	 *
> -	 * Create a buffer handle in the driver-specific buffer manager (either
> -	 * GEM or TTM) valid for the passed-in &struct drm_file. This is used by
> -	 * the core to implement the GETFB IOCTL, which returns (for
> -	 * sufficiently priviledged user) also a native buffer handle. This can
> -	 * be used for seamless transitions between modesetting clients by
> -	 * copying the current screen contents to a private buffer and blending
> -	 * between that and the new contents.
> -	 *
> -	 * GEM based drivers should call drm_gem_handle_create() to create the
> -	 * handle.
> -	 *
> -	 * RETURNS:
> -	 *
> -	 * 0 on success or a negative error code on failure.
> -	 */
> -	int (*create_handle)(struct drm_framebuffer *fb,
> -			     struct drm_file *file_priv,
> -			     unsigned int *handle);
>  	/**
>  	 * @dirty:
>  	 *
> @@ -129,6 +107,10 @@ struct drm_framebuffer {
>  	 * @funcs: framebuffer vfunc table
>  	 */
>  	const struct drm_framebuffer_funcs *funcs;
> +	/**
> +	 *@gems: GEM object for each buffer.
> +	 */
> +	struct drm_gem_object *gem_objs[4];
>  	/**
>  	 * @pitches: Line stride per buffer. For userspace created object this
>  	 * is copied from drm_mode_fb_cmd2.
> -- 
> 2.14.0.434.g98096fd7a8-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
