From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 01/11] drm/fb-helper: do a generic fb_setcmap helper in
	terms of crtc .gamma_set
Date: Wed, 21 Jun 2017 09:38:05 +0200
Message-ID: <20170621073804.akyg4rxvoavjjt2v__40891.96971986$1498030701$gmane$org@phenom.ffwll.local>
References: <1497986735-14418-1-git-send-email-peda@axentia.se>
	<1497986735-14418-2-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1497986735-14418-2-git-send-email-peda@axentia.se>
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
Cc: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Philippe Cornu <philippe.cornu@st.com>, Yannick Fertre <yannick.fertre@st.com>, Ben Skeggs <bskeggs@redhat.com>, amd-gfx@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, virtualization@lists.linux-foundation.org, Vincent Abriou <vincent.abriou@st.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 20, 2017 at 09:25:25PM +0200, Peter Rosin wrote:
> This makes the redundant fb helpers .load_lut, .gamma_set and .gamma_get
> totally obsolete.
> =

> I think the gamma_store can end up invalid on error. But the way I read
> it, that can happen in drm_mode_gamma_set_ioctl as well, so why should
> this pesky legacy fbdev stuff be any better?
> =

> drm_fb_helper_save_lut_atomic justs saves the gamma lut for later. Howeve=
r,
> it saves it to the gamma_store which should already be up to date with wh=
at
> .gamma_get would return and is thus a nop. So, zap it.

Removing drm_fb_helper_save_lut_atomic should be a separate patch I
think.
 =

> Signed-off-by: Peter Rosin <peda@axentia.se>

> ---
>  drivers/gpu/drm/drm_fb_helper.c | 131 ++++++++++++----------------------=
------
>  1 file changed, 40 insertions(+), 91 deletions(-)
> =

> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_hel=
per.c
> index 574af01..cc2d55d 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -229,22 +229,6 @@ int drm_fb_helper_remove_one_connector(struct drm_fb=
_helper *fb_helper,
>  }
>  EXPORT_SYMBOL(drm_fb_helper_remove_one_connector);
>  =

> -static void drm_fb_helper_save_lut_atomic(struct drm_crtc *crtc, struct =
drm_fb_helper *helper)
> -{
> -	uint16_t *r_base, *g_base, *b_base;
> -	int i;
> -
> -	if (helper->funcs->gamma_get =3D=3D NULL)
> -		return;
> -
> -	r_base =3D crtc->gamma_store;
> -	g_base =3D r_base + crtc->gamma_size;
> -	b_base =3D g_base + crtc->gamma_size;
> -
> -	for (i =3D 0; i < crtc->gamma_size; i++)
> -		helper->funcs->gamma_get(crtc, &r_base[i], &g_base[i], &b_base[i], i);
> -}
> -
>  static void drm_fb_helper_restore_lut_atomic(struct drm_crtc *crtc)
>  {
>  	uint16_t *r_base, *g_base, *b_base;
> @@ -285,7 +269,6 @@ int drm_fb_helper_debug_enter(struct fb_info *info)
>  			if (drm_drv_uses_atomic_modeset(mode_set->crtc->dev))
>  				continue;
>  =

> -			drm_fb_helper_save_lut_atomic(mode_set->crtc, helper);
>  			funcs->mode_set_base_atomic(mode_set->crtc,
>  						    mode_set->fb,
>  						    mode_set->x,
> @@ -1167,50 +1150,6 @@ void drm_fb_helper_set_suspend_unlocked(struct drm=
_fb_helper *fb_helper,
>  }
>  EXPORT_SYMBOL(drm_fb_helper_set_suspend_unlocked);
>  =

> -static int setcolreg(struct drm_crtc *crtc, u16 red, u16 green,
> -		     u16 blue, u16 regno, struct fb_info *info)
> -{
> -	struct drm_fb_helper *fb_helper =3D info->par;
> -	struct drm_framebuffer *fb =3D fb_helper->fb;
> -
> -	if (info->fix.visual =3D=3D FB_VISUAL_TRUECOLOR) {

This case here seems gone, and it was also the pi=E8ce de r=E9sistance when=
 I
tried tackling fbdev lut support. As far as I understand this stuff we do
not support FB_VISUAL_TRUECOLOR palette, and all that bitshifting here is
pointless. But I'm honestly not really clear.

I think removing this case should also be a separate patch, and I'd very
much prefer that someone with some fbdev-clue would ack it.

> -		u32 *palette;
> -		u32 value;
> -		/* place color in psuedopalette */
> -		if (regno > 16)
> -			return -EINVAL;
> -		palette =3D (u32 *)info->pseudo_palette;
> -		red >>=3D (16 - info->var.red.length);
> -		green >>=3D (16 - info->var.green.length);
> -		blue >>=3D (16 - info->var.blue.length);
> -		value =3D (red << info->var.red.offset) |
> -			(green << info->var.green.offset) |
> -			(blue << info->var.blue.offset);
> -		if (info->var.transp.length > 0) {
> -			u32 mask =3D (1 << info->var.transp.length) - 1;
> -
> -			mask <<=3D info->var.transp.offset;
> -			value |=3D mask;
> -		}
> -		palette[regno] =3D value;
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
> -	WARN_ON(fb->format->cpp[0] !=3D 1);
> -
> -	fb_helper->funcs->gamma_set(crtc, red, green, blue, regno);
> -
> -	return 0;
> -}
> -
>  /**
>   * drm_fb_helper_setcmap - implementation for &fb_ops.fb_setcmap
>   * @cmap: cmap to set
> @@ -1220,51 +1159,61 @@ int drm_fb_helper_setcmap(struct fb_cmap *cmap, s=
truct fb_info *info)
>  {
>  	struct drm_fb_helper *fb_helper =3D info->par;
>  	struct drm_device *dev =3D fb_helper->dev;
> -	const struct drm_crtc_helper_funcs *crtc_funcs;
> -	u16 *red, *green, *blue, *transp;
> +	struct drm_modeset_acquire_ctx ctx;
>  	struct drm_crtc *crtc;
> -	int i, j, rc =3D 0;
> -	int start;
> +	u16 *r, *g, *b;
> +	int i, ret;
>  =

>  	if (oops_in_progress)
>  		return -EBUSY;
>  =

> -	drm_modeset_lock_all(dev);
> +	if (cmap->start + cmap->len < cmap->start)
> +		return -EINVAL;
> +
> +	drm_modeset_acquire_init(&ctx, 0);
> +retry:
> +	ret =3D drm_modeset_lock_all_ctx(dev, &ctx);
> +	if (ret)
> +		goto out;
>  	if (!drm_fb_helper_is_bound(fb_helper)) {
> -		drm_modeset_unlock_all(dev);
> -		return -EBUSY;
> +		ret =3D -EBUSY;
> +		goto out;
>  	}
>  =

>  	for (i =3D 0; i < fb_helper->crtc_count; i++) {
>  		crtc =3D fb_helper->crtc_info[i].mode_set.crtc;
> -		crtc_funcs =3D crtc->helper_private;
> -
> -		red =3D cmap->red;
> -		green =3D cmap->green;
> -		blue =3D cmap->blue;
> -		transp =3D cmap->transp;
> -		start =3D cmap->start;
> +		if (!crtc->funcs->gamma_set || !crtc->gamma_size) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
>  =

> -		for (j =3D 0; j < cmap->len; j++) {
> -			u16 hred, hgreen, hblue, htransp =3D 0xffff;
> +		if (cmap->start + cmap->len > crtc->gamma_size) {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
>  =

> -			hred =3D *red++;
> -			hgreen =3D *green++;
> -			hblue =3D *blue++;
> +		r =3D crtc->gamma_store;
> +		g =3D r + crtc->gamma_size;
> +		b =3D g + crtc->gamma_size;
>  =

> -			if (transp)
> -				htransp =3D *transp++;
> +		memcpy(r + cmap->start, cmap->red, cmap->len * sizeof(u16));
> +		memcpy(g + cmap->start, cmap->green, cmap->len * sizeof(u16));
> +		memcpy(b + cmap->start, cmap->blue, cmap->len * sizeof(u16));
>  =

> -			rc =3D setcolreg(crtc, hred, hgreen, hblue, start++, info);
> -			if (rc)
> -				goto out;
> -		}
> -		if (crtc_funcs->load_lut)
> -			crtc_funcs->load_lut(crtc);
> +		ret =3D crtc->funcs->gamma_set(crtc, r, g, b,
> +					     crtc->gamma_size, &ctx);
> +		if (ret)
> +			break;
>  	}
> - out:
> -	drm_modeset_unlock_all(dev);
> -	return rc;
> +out:
> +	if (ret =3D=3D -EDEADLK) {
> +		drm_modeset_backoff(&ctx);
> +		goto retry;
> +	}
> +	drm_modeset_drop_locks(&ctx);
> +	drm_modeset_acquire_fini(&ctx);
> +
> +	return ret;

It's a pre-existing bug, but should we also try to restore the fbdev lut
in drm_fb_helper_restore_fbdev_mode_unlocked()? Would be yet another bug,
but might be relevant for your use-case. Just try to run both an fbdev
application and some kms-native thing, and then SIGKILL the native kms
app.

But since pre-existing not really required, and probably too much effort.

Thanks, Daniel

>  }
>  EXPORT_SYMBOL(drm_fb_helper_setcmap);
>  =

> -- =

> 2.1.4
> =

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
