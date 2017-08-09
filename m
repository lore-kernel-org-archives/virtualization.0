From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH libdrm] drm: Remove create_handle() drm_framebuffer
	"virtual".
Date: Wed, 9 Aug 2017 21:14:48 +0200
Message-ID: <8a7bf59a-0f58-21ba-8b82-78e6ba873065__1769.68877572126$1509078998$gmane$org@tronnes.org>
References: <20170808234237.62051-1-djmk@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Joe Kniss <djmk@chromium.org>, dri-devel@lists.freedesktop.org
Cc: heiko@sntech.de, airlied@linux.ie, michel.daenzer@amd.com, virtualization@lists.linux-foundation.org, Jerry.Zhang@amd.com, thierry.reding@gmail.com, daniel.vetter@intel.com, baoyou.xie@linaro.org, ville.syrjala@linux.intel.com, AlexBin.Xie@amd.com, tom.stdenis@amd.com, David1.Zhou@amd.com, mario.kleiner.de@gmail.com, krzk@kernel.org, joe@perches.com, jy0922.shim@samsung.com, linux-rockchip@lists.infradead.org, linux-mediatek@lists.infradead.org, linux@armlinux.org.uk, patrik.r.jakobsson@gmail.com, jonathanh@nvidia.com, linux-samsung-soc@vger.kernel.org, tomi.valkeinen@ti.com, bskeggs@redhat.com, nouveau@lists.freedesktop.org, ck.hu@mediatek.com, kyungmin.park@samsung.com, Xiaojie.Yuan@amd.com, harry.wentland@amd.com, alexandre.f.demers@gmail.com, Andrey.Grodzovsky@amd.com, linux-tegra@vger.kernel.org, Joe Kniss <djmk@google.com>, linux-arm-msm@vger.kernel.org, intel-gf
List-Id: virtualization@lists.linuxfoundation.org


Den 09.08.2017 01.42, skrev Joe Kniss:
> Because all drivers currently use gem objects for framebuffer planes,
> the virtual create_handle() is not required.  This change adds a
> struct drm_gem_object *gems[4] field to drm_framebuffer and removes
> create_handle() function pointer from drm_framebuffer_funcs.  The
> corresponding *_create_handle() function is removed from each driver.
>
> In many cases this change eliminates a struct *_framebuffer object,
> as the only need for the derived struct is the addition of the gem
> object pointer.
>
> TESTED: compiled: allyesconfig ARCH=x86,arm platforms:i915, rockchip
>
> Signed-off-by: Joe Kniss <djmk@google.com>
> ---

Hi Joe,

I'm also looking into adding gem objs to drm_framebuffer in this patch:
[PATCH v2 01/22] drm: Add GEM backed framebuffer library
https://lists.freedesktop.org/archives/dri-devel/2017-August/149782.html

[...]

> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
> index ade319d10e70..f5f011b910b1 100644
> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> @@ -31,14 +31,9 @@
>   
>   #define DEFAULT_FBDEFIO_DELAY_MS 50
>   
> -struct drm_fb_cma {
> -	struct drm_framebuffer		fb;
> -	struct drm_gem_cma_object	*obj[4];
> -};
> -
>   struct drm_fbdev_cma {
>   	struct drm_fb_helper	fb_helper;
> -	struct drm_fb_cma	*fb;
> +	struct drm_framebuffer	*fb;

This fb pointer isn't necessary, since fb_helper already has one.

Noralf.

>   	const struct drm_framebuffer_funcs *fb_funcs;
>   };
>   
> @@ -72,7 +67,6 @@ struct drm_fbdev_cma {
>    *
>    *     static struct drm_framebuffer_funcs driver_fb_funcs = {
>    *         .destroy       = drm_fb_cma_destroy,
> - *         .create_handle = drm_fb_cma_create_handle,
>    *         .dirty         = driver_fb_dirty,
>    *     };
>    *
> @@ -90,67 +84,50 @@ static inline struct drm_fbdev_cma *to_fbdev_cma(struct drm_fb_helper *helper)
>   	return container_of(helper, struct drm_fbdev_cma, fb_helper);
>   }
>   
> -static inline struct drm_fb_cma *to_fb_cma(struct drm_framebuffer *fb)
> -{
> -	return container_of(fb, struct drm_fb_cma, fb);
> -}
> -
>   void drm_fb_cma_destroy(struct drm_framebuffer *fb)
>   {
> -	struct drm_fb_cma *fb_cma = to_fb_cma(fb);
>   	int i;
>   
>   	for (i = 0; i < 4; i++) {
> -		if (fb_cma->obj[i])
> -			drm_gem_object_put_unlocked(&fb_cma->obj[i]->base);
> +		if (fb->gem_objs[i])
> +			drm_gem_object_put_unlocked(fb->gem_objs[i]);
>   	}
>   
>   	drm_framebuffer_cleanup(fb);
> -	kfree(fb_cma);
> +	kfree(fb);
>   }
>   EXPORT_SYMBOL(drm_fb_cma_destroy);
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
>   static struct drm_framebuffer_funcs drm_fb_cma_funcs = {
>   	.destroy	= drm_fb_cma_destroy,
> -	.create_handle	= drm_fb_cma_create_handle,
>   };
>   
> -static struct drm_fb_cma *drm_fb_cma_alloc(struct drm_device *dev,
> +static struct drm_framebuffer *drm_fb_cma_alloc(struct drm_device *dev,
>   	const struct drm_mode_fb_cmd2 *mode_cmd,
>   	struct drm_gem_cma_object **obj,
>   	unsigned int num_planes, const struct drm_framebuffer_funcs *funcs)
>   {
> -	struct drm_fb_cma *fb_cma;
> +	struct drm_framebuffer *fb;
>   	int ret;
>   	int i;
>   
> -	fb_cma = kzalloc(sizeof(*fb_cma), GFP_KERNEL);
> -	if (!fb_cma)
> +	fb = kzalloc(sizeof(*fb), GFP_KERNEL);
> +	if (!fb)
>   		return ERR_PTR(-ENOMEM);
>   
> -	drm_helper_mode_fill_fb_struct(dev, &fb_cma->fb, mode_cmd);
> +	drm_helper_mode_fill_fb_struct(dev, fb, mode_cmd);
>   
>   	for (i = 0; i < num_planes; i++)
> -		fb_cma->obj[i] = obj[i];
> +		fb->gem_objs[i] = &obj[i]->base;
>   
> -	ret = drm_framebuffer_init(dev, &fb_cma->fb, funcs);
> +	ret = drm_framebuffer_init(dev, fb, funcs);
>   	if (ret) {
>   		dev_err(dev->dev, "Failed to initialize framebuffer: %d\n", ret);
> -		kfree(fb_cma);
> +		kfree(fb);
>   		return ERR_PTR(ret);
>   	}
>   
> -	return fb_cma;
> +	return fb;
>   }
>   
>   /**
> @@ -171,7 +148,7 @@ struct drm_framebuffer *drm_fb_cma_create_with_funcs(struct drm_device *dev,
>   	const struct drm_framebuffer_funcs *funcs)
>   {
>   	const struct drm_format_info *info;
> -	struct drm_fb_cma *fb_cma;
> +	struct drm_framebuffer *fb;
>   	struct drm_gem_cma_object *objs[4];
>   	struct drm_gem_object *obj;
>   	int ret;
> @@ -205,13 +182,13 @@ struct drm_framebuffer *drm_fb_cma_create_with_funcs(struct drm_device *dev,
>   		objs[i] = to_drm_gem_cma_obj(obj);
>   	}
>   
> -	fb_cma = drm_fb_cma_alloc(dev, mode_cmd, objs, i, funcs);
> -	if (IS_ERR(fb_cma)) {
> -		ret = PTR_ERR(fb_cma);
> +	fb = drm_fb_cma_alloc(dev, mode_cmd, objs, i, funcs);
> +	if (IS_ERR(fb)) {
> +		ret = PTR_ERR(fb);
>   		goto err_gem_object_put;
>   	}
>   
> -	return &fb_cma->fb;
> +	return fb;
>   
>   err_gem_object_put:
>   	for (i--; i >= 0; i--)
> @@ -250,12 +227,10 @@ EXPORT_SYMBOL_GPL(drm_fb_cma_create);
>   struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct drm_framebuffer *fb,
>   						  unsigned int plane)
>   {
> -	struct drm_fb_cma *fb_cma = to_fb_cma(fb);
> -
>   	if (plane >= 4)
>   		return NULL;
>   
> -	return fb_cma->obj[plane];
> +	return to_drm_gem_cma_obj(fb->gem_objs[plane]);
>   }
>   EXPORT_SYMBOL_GPL(drm_fb_cma_get_gem_obj);
>   
> @@ -272,13 +247,13 @@ dma_addr_t drm_fb_cma_get_gem_addr(struct drm_framebuffer *fb,
>   				   struct drm_plane_state *state,
>   				   unsigned int plane)
>   {
> -	struct drm_fb_cma *fb_cma = to_fb_cma(fb);
> +	struct drm_gem_cma_object *cma_bo = drm_fb_cma_get_gem_obj(fb, plane);
>   	dma_addr_t paddr;
>   
> -	if (plane >= 4)
> +	if (!cma_bo)
>   		return 0;
>   
> -	paddr = fb_cma->obj[plane]->paddr + fb->offsets[plane];
> +	paddr = cma_bo->paddr + fb->offsets[plane];
>   	paddr += fb->format->cpp[plane] * (state->src_x >> 16);
>   	paddr += fb->pitches[plane] * (state->src_y >> 16);
>   
> @@ -321,7 +296,6 @@ EXPORT_SYMBOL_GPL(drm_fb_cma_prepare_fb);
>   #ifdef CONFIG_DEBUG_FS
>   static void drm_fb_cma_describe(struct drm_framebuffer *fb, struct seq_file *m)
>   {
> -	struct drm_fb_cma *fb_cma = to_fb_cma(fb);
>   	int i;
>   
>   	seq_printf(m, "fb: %dx%d@%4.4s\n", fb->width, fb->height,
> @@ -330,7 +304,7 @@ static void drm_fb_cma_describe(struct drm_framebuffer *fb, struct seq_file *m)
>   	for (i = 0; i < fb->format->num_planes; i++) {
>   		seq_printf(m, "   %d: offset=%d pitch=%d, obj: ",
>   				i, fb->offsets[i], fb->pitches[i]);
> -		drm_gem_cma_describe(fb_cma->obj[i], m);
> +		drm_gem_cma_describe(drm_fb_cma_get_gem_obj(fb, i), m);
>   	}
>   }
>   
> @@ -472,7 +446,7 @@ drm_fbdev_cma_create(struct drm_fb_helper *helper,
>   		goto err_fb_info_destroy;
>   	}
>   
> -	fb = &fbdev_cma->fb->fb;
> +	fb = fbdev_cma->fb;
>   	helper->fb = fb;
>   
>   	fbi->par = helper;
> @@ -500,7 +474,7 @@ drm_fbdev_cma_create(struct drm_fb_helper *helper,
>   	return 0;
>   
>   err_cma_destroy:
> -	drm_framebuffer_remove(&fbdev_cma->fb->fb);
> +	drm_framebuffer_remove(fbdev_cma->fb);
>   err_fb_info_destroy:
>   	drm_fb_helper_fini(helper);
>   err_gem_free_object:
> @@ -598,7 +572,7 @@ void drm_fbdev_cma_fini(struct drm_fbdev_cma *fbdev_cma)
>   		drm_fbdev_cma_defio_fini(fbdev_cma->fb_helper.fbdev);
>   
>   	if (fbdev_cma->fb)
> -		drm_framebuffer_remove(&fbdev_cma->fb->fb);
> +		drm_framebuffer_remove(fbdev_cma->fb);
>   
>   	drm_fb_helper_fini(&fbdev_cma->fb_helper);
>   	kfree(fbdev_cma);
