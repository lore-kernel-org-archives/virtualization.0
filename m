From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 3/6] drm/fb-helper: Instanciate shadow FB if
	configured in device's mode_config
Date: Wed, 10 Jul 2019 17:34:10 +0200
Message-ID: <20190710153410.GU15868__32799.1785061144$1562773395$gmane$org@phenom.ffwll.local>
References: <20190705092613.7621-1-tzimmermann@suse.de>
	<20190705092613.7621-4-tzimmermann@suse.de>
	<68f5783f-8022-3238-a6d9-c6a774b39633@tronnes.org>
	<59111691-5283-fb50-94a9-6960c425e81c@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <59111691-5283-fb50-94a9-6960c425e81c@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: yc_chen@aspeedtech.com, maxime.ripard@bootlin.com, sam@ravnborg.org, maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, daniel@ffwll.ch, airlied@redhat.com, sean@poorly.run
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jul 07, 2019 at 06:14:50PM +0200, Thomas Zimmermann wrote:
> Hi
> =

> Am 07.07.19 um 16:37 schrieb Noralf Tr=F8nnes:
> > =

> > =

> > Den 05.07.2019 11.26, skrev Thomas Zimmermann:
> >> Generic framebuffer emulation uses a shadow buffer for framebuffers wi=
th
> >> dirty() function. If drivers want to use the shadow FB without such a
> >> function, they can now set prefer_shadow or prefer_shadow_fbdev in the=
ir
> >> mode_config structures. The former flag is exported to userspace, the =
latter
> >> flag is fbdev-only.
> >>
> >> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> ---
> >>  drivers/gpu/drm/drm_fb_helper.c | 19 ++++++++++++++-----
> >>  include/drm/drm_mode_config.h   |  5 +++++
> >>  2 files changed, 19 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_=
helper.c
> >> index 7ba6a0255821..56ef169e1814 100644
> >> --- a/drivers/gpu/drm/drm_fb_helper.c
> >> +++ b/drivers/gpu/drm/drm_fb_helper.c
> >> @@ -421,7 +421,9 @@ static void drm_fb_helper_dirty_work(struct work_s=
truct *work)
> >>  				return;
> >>  			drm_fb_helper_dirty_blit_real(helper, &clip_copy);
> >>  		}
> >> -		helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, &clip_copy, 1);
> >> +		if (helper->fb->funcs->dirty)
> >> +			helper->fb->funcs->dirty(helper->fb, NULL, 0, 0,
> >> +						 &clip_copy, 1);
> >>  =

> >>  		if (helper->buffer)
> >>  			drm_client_buffer_vunmap(helper->buffer);
> >> @@ -620,9 +622,6 @@ static void drm_fb_helper_dirty(struct fb_info *in=
fo, u32 x, u32 y,
> >>  	struct drm_clip_rect *clip =3D &helper->dirty_clip;
> >>  	unsigned long flags;
> >>  =

> >> -	if (!helper->fb->funcs->dirty)
> >> -		return;
> > =

> > drm_fb_helper_dirty() is called unconditionally by
> > drm_fb_helper_sys_imageblit() et al, so we need check with
> > drm_fbdev_use_shadow_fb() here.
> > =

> >> -
> >>  	spin_lock_irqsave(&helper->dirty_lock, flags);
> >>  	clip->x1 =3D min_t(u32, clip->x1, x);
> >>  	clip->y1 =3D min_t(u32, clip->y1, y);
> >> @@ -2166,6 +2165,16 @@ static struct fb_deferred_io drm_fbdev_defio =
=3D {
> >>  	.deferred_io	=3D drm_fb_helper_deferred_io,
> >>  };
> >>  =

> >> +static bool drm_fbdev_use_shadow_fb(struct drm_fb_helper *fb_helper)
> >> +{
> >> +	struct drm_device *dev =3D fb_helper->dev;
> >> +	struct drm_framebuffer *fb =3D fb_helper->fb;
> >> +
> >> +	return dev->mode_config.prefer_shadow_fbdev |
> >> +	       dev->mode_config.prefer_shadow |
> > =

> > Use logical OR here
> > =

> >> +	       !!fb->funcs->dirty;
> > =

> > and you can drop the the double NOT here.
> > =

> >> +}
> >> +
> >>  /**
> >>   * drm_fb_helper_generic_probe - Generic fbdev emulation probe helper
> >>   * @fb_helper: fbdev helper structure
> >> @@ -2213,7 +2222,7 @@ int drm_fb_helper_generic_probe(struct drm_fb_he=
lper *fb_helper,
> >>  =

> >>  	drm_fb_helper_fill_info(fbi, fb_helper, sizes);
> >>  =

> >> -	if (fb->funcs->dirty) {
> >> +	if (drm_fbdev_use_shadow_fb(fb_helper)) {
> >>  		struct fb_ops *fbops;
> >>  		void *shadow;
> >>  =

> >> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_conf=
ig.h
> >> index 759d462d028b..e1c751aca353 100644
> >> --- a/include/drm/drm_mode_config.h
> >> +++ b/include/drm/drm_mode_config.h
> >> @@ -347,6 +347,8 @@ struct drm_mode_config_funcs {
> >>   * @output_poll_work: delayed work for polling in process context
> >>   * @preferred_depth: preferred RBG pixel depth, used by fb helpers
> >>   * @prefer_shadow: hint to userspace to prefer shadow-fb rendering
> >> + * @prefer_shadow_fbdev: hint to framebuffer emulation to prefer shad=
ow-fb \
> >> +	rendering
> > =

> > It's preferred to have the doc together with the struct member.
> =

> I just tried to follow the file's existing style, but OK, I don't mind.

If it annoys you too much, convert all the member docs in the header
comment into the inline style. That's what I usually do when the first
inline kerneldoc comment is warranted (like here), but not yet rolled out.

Or just mix&match if you feel like not doing that, we have lots of that
already :-)
-Daniel

> =

> > it's less likely to be forgotten when things change. And we don't use
> > line cont. when the doc line is too long. Just continue on the next line
> > after an asterix.
> > =

> >>   * @cursor_width: hint to userspace for max cursor width
> >>   * @cursor_height: hint to userspace for max cursor height
> >>   * @helper_private: mid-layer private data
> >> @@ -852,6 +854,9 @@ struct drm_mode_config {
> >>  	/* dumb ioctl parameters */
> >>  	uint32_t preferred_depth, prefer_shadow;
> >>  =

> >> +	/* fbdev parameters */
> > =

> > No need for this comment.
> > =

> > Doc can look like this, I've done s/framebuffer/fbdev/:
> > 	/**
> > 	 * @prefer_shadow_fbdev:
> > 	 *
> > 	 * Hint to fbdev emulation to prefer shadow-fb rendering.
> > 	 */
> > =

> >> +	uint32_t prefer_shadow_fbdev;
> > =

> > Use bool here.
> > =

> > With that:
> > =

> > Reviewed-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> > =

> > I have tested this on 2 drivers that use generic fbdev: vc4 (no shadow
> > buf) and mi0283qt which has a dirty callback.
> > =

> > Tested-by: Noralf Tr=F8nnes <noralf@tronnes.org>
> =

> Thanks for reviewing and testing the patches.
> =

> Best regards
> Thomas
> =

> > =

> >> +
> >>  	/**
> >>  	 * @quirk_addfb_prefer_xbgr_30bpp:
> >>  	 *
> >>
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > =

> =

> -- =

> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
> GF: Felix Imend=F6rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N=FCrnberg)
> =





-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
