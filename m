From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 03/14] drm/fb-helper: do a generic fb_setcmap helper
	in terms of crtc .gamma_set
Date: Mon, 26 Jun 2017 11:23:17 +0200
Message-ID: <20170626092317.wkwnvlvyaiv4uo2a__19597.6036870436$1498469011$gmane$org@phenom.ffwll.local>
References: <1498111597-10714-1-git-send-email-peda@axentia.se>
	<1498111597-10714-4-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1498111597-10714-4-git-send-email-peda@axentia.se>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Rosin <peda@axentia.se>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Philippe Cornu <philippe.cornu@st.com>, Russell King <linux@armlinux.org.uk>, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Yannick Fertre <yannick.fertre@st.com>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Vincent Abriou <vincent.abriou@st.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Ben Skeggs <bskeggs@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 22, 2017 at 08:06:26AM +0200, Peter Rosin wrote:
> This makes the redundant fb helpers .load_lut, .gamma_set and .gamma_get
> totally obsolete.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/drm_fb_helper.c | 154 ++++++++++++++++------------------------
>  1 file changed, 63 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 7ade384..58eb045 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -1150,50 +1150,6 @@ void drm_fb_helper_set_suspend_unlocked(struct drm_fb_helper *fb_helper,
>  }
>  EXPORT_SYMBOL(drm_fb_helper_set_suspend_unlocked);
>  
> -static int setcolreg(struct drm_crtc *crtc, u16 red, u16 green,
> -		     u16 blue, u16 regno, struct fb_info *info)
> -{
> -	struct drm_fb_helper *fb_helper = info->par;
> -	struct drm_framebuffer *fb = fb_helper->fb;
> -
> -	if (info->fix.visual == FB_VISUAL_TRUECOLOR) {
> -		u32 *palette;
> -		u32 value;
> -		/* place color in psuedopalette */
> -		if (regno > 16)
> -			return -EINVAL;
> -		palette = (u32 *)info->pseudo_palette;
> -		red >>= (16 - info->var.red.length);
> -		green >>= (16 - info->var.green.length);
> -		blue >>= (16 - info->var.blue.length);
> -		value = (red << info->var.red.offset) |
> -			(green << info->var.green.offset) |
> -			(blue << info->var.blue.offset);
> -		if (info->var.transp.length > 0) {
> -			u32 mask = (1 << info->var.transp.length) - 1;
> -
> -			mask <<= info->var.transp.offset;
> -			value |= mask;
> -		}
> -		palette[regno] = value;
> -		return 0;
> -	}
> -
> -	/*
> -	 * The driver really shouldn't advertise pseudo/directcolor
> -	 * visuals if it can't deal with the palette.
> -	 */
> -	if (WARN_ON(!fb_helper->funcs->gamma_set ||
> -		    !fb_helper->funcs->gamma_get))
> -		return -EINVAL;
> -
> -	WARN_ON(fb->format->cpp[0] != 1);
> -
> -	fb_helper->funcs->gamma_set(crtc, red, green, blue, regno);
> -
> -	return 0;
> -}
> -
>  /**
>   * drm_fb_helper_setcmap - implementation for &fb_ops.fb_setcmap
>   * @cmap: cmap to set
> @@ -1203,12 +1159,10 @@ int drm_fb_helper_setcmap(struct fb_cmap *cmap, struct fb_info *info)
>  {
>  	struct drm_fb_helper *fb_helper = info->par;
>  	struct drm_device *dev = fb_helper->dev;
> -	const struct drm_crtc_helper_funcs *crtc_funcs;
> -	u16 *red, *green, *blue, *transp;
> +	struct drm_modeset_acquire_ctx ctx;
>  	struct drm_crtc *crtc;
>  	u16 *r, *g, *b;
> -	int i, j, rc = 0;
> -	int start;
> +	int i, ret;
>  
>  	if (oops_in_progress)
>  		return -EBUSY;
> @@ -1216,65 +1170,83 @@ int drm_fb_helper_setcmap(struct fb_cmap *cmap, struct fb_info *info)
>  	if (cmap->start + cmap->len < cmap->start)
>  		return -EINVAL;
>  
> -	drm_modeset_lock_all(dev);
> +	drm_modeset_acquire_init(&ctx, 0);
> +retry:
> +	ret = drm_modeset_lock_all_ctx(dev, &ctx);
> +	if (ret)
> +		goto out;
>  	if (!drm_fb_helper_is_bound(fb_helper)) {
> -		drm_modeset_unlock_all(dev);
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto out;
>  	}
>  
>  	for (i = 0; i < fb_helper->crtc_count; i++) {
> -		crtc = fb_helper->crtc_info[i].mode_set.crtc;
> -		crtc_funcs = crtc->helper_private;
> -
> -		red = cmap->red;
> -		green = cmap->green;
> -		blue = cmap->blue;
> -		transp = cmap->transp;
> -		start = cmap->start;
> +		if (info->fix.visual == FB_VISUAL_TRUECOLOR) {
> +			u32 *palette;
> +			int j;
>  
> -		if (info->fix.visual != FB_VISUAL_TRUECOLOR) {
> -			if (!crtc->gamma_size) {
> -				rc = -EINVAL;
> +			if (cmap->start + cmap->len > 16) {
> +				ret = -EINVAL;
>  				goto out;
>  			}
>  
> -			if (cmap->start + cmap->len > crtc->gamma_size) {
> -				rc = -EINVAL;
> -				goto out;
> +			palette = (u32 *)info->pseudo_palette;
> +			for (j = 0; j < cmap->len; ++j) {
> +				u16 red = cmap->red[j];
> +				u16 green = cmap->green[j];
> +				u16 blue = cmap->blue[j];
> +				u32 value;
> +
> +				red >>= 16 - info->var.red.length;
> +				green >>= 16 - info->var.green.length;
> +				blue >>= 16 - info->var.blue.length;
> +				value = (red << info->var.red.offset) |
> +					(green << info->var.green.offset) |
> +					(blue << info->var.blue.offset);
> +				if (info->var.transp.length > 0) {
> +					u32 mask = (1 << info->var.transp.length) - 1;
> +
> +					mask <<= info->var.transp.offset;
> +					value |= mask;
> +				}
> +				palette[cmap->start + j] = value;
>  			}
> +			continue;

I think it'd be much cleaner if we handle the TRUECOLOR case as an early
return, before the crtc loop. Per-crtc is only needed when we have to
update the hw table (i.e. PSEUDOCOLOR stuff).

> +		}
>  
> -			r = crtc->gamma_store;
> -			g = r + crtc->gamma_size;
> -			b = g + crtc->gamma_size;
> -
> -			memcpy(r + cmap->start, cmap->red,
> -			       cmap->len * sizeof(u16));
> -			memcpy(g + cmap->start, cmap->green,
> -			       cmap->len * sizeof(u16));
> -			memcpy(b + cmap->start, cmap->blue,
> -			       cmap->len * sizeof(u16));
> +		crtc = fb_helper->crtc_info[i].mode_set.crtc;
> +		if (!crtc->funcs->gamma_set || !crtc->gamma_size) {
> +			ret = -EINVAL;
> +			goto out;
>  		}
>  
> -		for (j = 0; j < cmap->len; j++) {
> -			u16 hred, hgreen, hblue, htransp = 0xffff;
> +		if (cmap->start + cmap->len > crtc->gamma_size) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
>  
> -			hred = *red++;
> -			hgreen = *green++;
> -			hblue = *blue++;
> +		r = crtc->gamma_store;
> +		g = r + crtc->gamma_size;
> +		b = g + crtc->gamma_size;
>  
> -			if (transp)
> -				htransp = *transp++;
> +		memcpy(r + cmap->start, cmap->red, cmap->len * sizeof(u16));
> +		memcpy(g + cmap->start, cmap->green, cmap->len * sizeof(u16));
> +		memcpy(b + cmap->start, cmap->blue, cmap->len * sizeof(u16));
>  
> -			rc = setcolreg(crtc, hred, hgreen, hblue, start++, info);
> -			if (rc)
> -				goto out;
> -		}
> -		if (crtc_funcs->load_lut)
> -			crtc_funcs->load_lut(crtc);
> +		ret = crtc->funcs->gamma_set(crtc, r, g, b,
> +					     crtc->gamma_size, &ctx);

As discussed on earlier threads, I think the cleanest version here would
be 2 functions, one which does the crtc-loop like in your code here for
legacy drivers, and the 2nd one which does 1 atomic commit over all crtcs,
open-coding the gamma_set helper. For the legacy one you can also keep
using drm_modeset_lock_all if you want too.

And this will be all a bit easier on top of my branch, since then you can
untangle fbdev locking from the kms side better.
-Daniel

> +		if (ret)
> +			break;
>  	}
> - out:
> -	drm_modeset_unlock_all(dev);
> -	return rc;
> +out:
> +	if (ret == -EDEADLK) {
> +		drm_modeset_backoff(&ctx);
> +		goto retry;
> +	}
> +	drm_modeset_drop_locks(&ctx);
> +	drm_modeset_acquire_fini(&ctx);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(drm_fb_helper_setcmap);
>  
> -- 
> 2.1.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
