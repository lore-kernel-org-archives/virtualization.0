Received: from mail.romanilin.is (mail.romanilin.is [146.185.235.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BAF31F9B5
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.235.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016587; cv=none; b=BuAhlYOnlNHJsP8LjkWtKwORDCbZtAooj1VuJ+MWd8y37QxxcaZIlnRORrpCq68vtkueC82qw1jGMXRo7waexS8T7qujwj9tC75hI4uzaZn300oEkUBeoWDk5wJXvSUVadEPRh99TRj88tgHoHz5N6g2tYxr2UGx+EPDB5QweLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016587; c=relaxed/simple;
	bh=8R6itA/UqOjlnEbqchL79WKL61ANAx65Dw0l3FjG+ls=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nJSN8B5m3zHAQmOdxWe0dZdZ3wNSX2BHd2czD64drIxUGmuXos9g0Wf6jC5Wb7/+BrHT1vEji1Gimsve0klVE4Vjo9bl/cJedXJOWoi52Abp5G9hvZ+KgPYPeP+Uz27e4UABy9eRqS2n6Yrhd/fMQEAmqC7cJZHt6RctJICcaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=romanilin.is; spf=pass smtp.mailfrom=romanilin.is; dkim=pass (2048-bit key) header.d=romanilin.is header.i=@romanilin.is header.b=Au0yVDvk; arc=none smtp.client-ip=146.185.235.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=romanilin.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanilin.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=romanilin.is header.i=@romanilin.is header.b="Au0yVDvk"
Received: from smtpclient.apple (unknown [188.134.85.196])
	by mail.romanilin.is (Postfix) with ESMTPSA id 7293D600D0;
	Thu,  2 Jul 2026 21:23:01 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=romanilin.is;
	s=default; t=1783016581;
	bh=TJZHJ2lItDnmrmXplUKEWZ+YkwqEOkOypk8rxLxs++A=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=Au0yVDvkleYpQpfeZvIhcVsp5ebvXoY2zFNxC5Q8OZgdNFCxvrwj/XztRM2UNQglj
	 EabRo7YzPVn0FV3o/2rxu6pPbTf3krXBbk2P0khpzsIwmwpo1knUSgCGLxBMyvKxnA
	 f87ffBVnh6U8RmlcIGRv8o6icAwB0/cuLIJp0gbzPsgUoQzA6YGx78OV23kueQ3e07
	 b+BFO+in+JLcOaOlhMOamkRLBYnMNsp7LnJzsJ56deYxV/pk+KXH0p3vrf/o/xDCHx
	 f6SspR9SIfdZ9T14tfmHyCnAOvqJs/lqQMDy3EX/CcIlhEYil1sTI1HW+UulXzbgbT
	 sgK1NFeFuXRSQ==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3] drm/vblank: Don't arm vblank timer with invalid frame
 duration
From: Roman Ilin <me@romanilin.is>
In-Reply-To: <20260702181027.98526-1-me@romanilin.is>
Date: Thu, 2 Jul 2026 21:23:02 +0300
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Peter Arnesen <peter.m.arnesen@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E697A2AE-5413-48AE-BFD6-3383819B388B@romanilin.is>
References: <20260613224434.96501-1-me@romanilin.is>
 <20260702181027.98526-1-me@romanilin.is>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Apologies, I accidentally fired off send-email before saving my final
changelog notes. Please ignore the changelog and notes in the original
v3 email.

The actual changes in v3 are:

- Changed the WARN_ON_ONCE to drm_dbg_kms (to avoid user-triggerable
  panics).
- Updated drm_calc_timestamping_constants with the goto error fallback
  to clear the stale state.

Also, an automated review bot pointed out an AB-BA deadlock in
drm_crtc_vblank_start_timer(). But I am leaving this out of the patch to
keep the fixes orthogonal.

Sorry for the noise.

> On Jul 2, 2026, at 21:10, Roman Ilin <me@romanilin.is> wrote:
>=20
> When a CRTC's display mode carries a too small pixel clock,
> drm_calc_timestamping_constants() computes a frame duration that
> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
> interval, after which vblank events are no longer delivered. Pending
> page flips never complete and the display appears frozen.
>=20
> This could be triggered on virtio-gpu guests that have dynamic =
resolution
> enabled: when the SPICE agent or the X server resizes the output, it
> submits a mode whose pixel clock is off by a factor of 1000, e.g.:
>=20
>    clock =3D 406 kHz, htotal =3D 3152, vtotal =3D 2148
>=20
>    framedur_ns =3D 3152 * 2148 * 1000000 / 406 =3D 16675852216 ns =
(~16.7 s)
>=20
> 16675852216 does not fit into an int and wraps to roughly -504000000.
> ns_to_ktime() then yields a negative interval and the timer stops =
working.
>=20
> Found by bisection, which pointed at commit a036f5fceedb =
("drm/virtgpu:
> Use vblank timer"). That commit merely made virtio-gpu use the vblank
> timer and thereby exposed the pre-existing problem in the timer setup
> added by commit 74afeb812850 ("drm/vblank: Add vblank timer").
>=20
> To fix this, modify drm_calc_timestamping_constants() to use u64 for
> calculations, check for INT_MAX overflows, and return an error code.
> drm_crtc_vblank_start_timer() will then propagate the error, enabling
> the driver to fall back to immediate vblank events. Valid modes are
> unaffected, and the timer self-heals on the next mode with a sane =
clock.
>=20
> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Roman Ilin <me@romanilin.is>
> ---
> Changes in v3:
>=20
> - Changed the WARN_ON_ONCE to drm_err_once
>=20
> Notes:
>=20
>=20
>=20
> drivers/gpu/drm/drm_vblank.c | 71 +++++++++++++++++++++++-------------
> include/drm/drm_vblank.h     |  4 +-
> 2 files changed, 48 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_vblank.c =
b/drivers/gpu/drm/drm_vblank.c
> index f90fb2d13..629b9fcc7 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -631,42 +631,51 @@ EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
>  * drm_crtc_vblank_helper_get_vblank_timestamp(). They are derived =
from
>  * CRTC's true scanout timing, so they take things like panel scaling =
or
>  * other adjustments into account.
> + *
> + * Returns:
> + * 0 on success, or a negative errno code otherwise.
>  */
> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
> -     const struct drm_display_mode *mode)
> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
> +    const struct drm_display_mode *mode)
> {
> struct drm_device *dev =3D crtc->dev;
> unsigned int pipe =3D drm_crtc_index(crtc);
> struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
> - int linedur_ns =3D 0, framedur_ns =3D 0;
> + u64 linedur_ns, framedur_ns;
> int dotclock =3D mode->crtc_clock;
> + unsigned int frame_size;
>=20
> if (!drm_dev_has_vblank(dev))
> - return;
> + return 0;
>=20
> if (drm_WARN_ON(dev, pipe >=3D dev->num_crtcs))
> - return;
> + return -EINVAL;
>=20
> - /* Valid dotclock? */
> - if (dotclock > 0) {
> - int frame_size =3D mode->crtc_htotal * mode->crtc_vtotal;
> + if (dotclock <=3D 0) {
> + drm_err(dev, "crtc %u: Can't calculate constants, dotclock =3D =
%d!\n",
> + crtc->base.id, dotclock);
> + goto error;
> + }
>=20
> - /*
> - * Convert scanline length in pixels and video
> - * dot clock to line duration and frame duration
> - * in nanoseconds:
> - */
> - linedur_ns  =3D div_u64((u64) mode->crtc_htotal * 1000000, =
dotclock);
> - framedur_ns =3D div_u64((u64) frame_size * 1000000, dotclock);
> + frame_size =3D (unsigned int)mode->crtc_htotal * (unsigned =
int)mode->crtc_vtotal;
>=20
> - /*
> - * Fields of interlaced scanout modes are only half a frame duration.
> - */
> - if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> - framedur_ns /=3D 2;
> - } else {
> - drm_err(dev, "crtc %u: Can't calculate constants, dotclock =3D =
0!\n",
> - crtc->base.id);
> + /*
> + * Convert scanline length in pixels and video dot clock to line =
duration
> + * and frame duration in nanoseconds.
> + */
> + linedur_ns  =3D div_u64((u64)mode->crtc_htotal * 1000000, dotclock);
> + framedur_ns =3D div_u64((u64)frame_size * 1000000, dotclock);
> +
> + /*
> + * Fields of interlaced scanout modes are only half a frame duration.
> + */
> + if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> + framedur_ns /=3D 2;
> +
> + if (linedur_ns > INT_MAX || framedur_ns > INT_MAX) {
> + drm_dbg_kms(dev, "crtc %u: Can't calculate constants, mode clock too =
small!\n",
> +    crtc->base.id);
> + goto error;
> }
>=20
> vblank->linedur_ns  =3D linedur_ns;
> @@ -678,7 +687,16 @@ void drm_calc_timestamping_constants(struct =
drm_crtc *crtc,
>     crtc->base.id, mode->crtc_htotal,
>     mode->crtc_vtotal, mode->crtc_vdisplay);
> drm_dbg_core(dev, "crtc %u: clock %d kHz framedur %d linedur %d\n",
> -     crtc->base.id, dotclock, framedur_ns, linedur_ns);
> +     crtc->base.id, dotclock,
> +     vblank->framedur_ns, vblank->linedur_ns);
> +
> + return 0;
> +
> +error:
> + vblank->linedur_ns  =3D 0;
> + vblank->framedur_ns =3D 0;
> + drm_mode_copy(&vblank->hwmode, mode);
> + return -EINVAL;
> }
> EXPORT_SYMBOL(drm_calc_timestamping_constants);
>=20
> @@ -2221,6 +2239,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc =
*crtc)
> struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
> struct drm_vblank_crtc_timer *vtimer =3D &vblank->vblank_timer;
> unsigned long flags;
> + int ret;
>=20
> if (!vtimer->crtc) {
> /*
> @@ -2239,7 +2258,9 @@ int drm_crtc_vblank_start_timer(struct drm_crtc =
*crtc)
> hrtimer_try_to_cancel(&vtimer->timer);
> }
>=20
> - drm_calc_timestamping_constants(crtc, &crtc->mode);
> + ret =3D drm_calc_timestamping_constants(crtc, &crtc->mode);
> + if (ret)
> + return ret;
>=20
> spin_lock_irqsave(&vtimer->interval_lock, flags);
> vtimer->interval =3D ns_to_ktime(vblank->framedur_ns);
> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
> index 2fcef9c0f..d99772dfa 100644
> --- a/include/drm/drm_vblank.h
> +++ b/include/drm/drm_vblank.h
> @@ -311,8 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
> u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
> void drm_crtc_vblank_restore(struct drm_crtc *crtc);
>=20
> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
> -     const struct drm_display_mode *mode);
> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
> +    const struct drm_display_mode *mode);
> wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
> void drm_crtc_set_max_vblank_count(struct drm_crtc *crtc,
>   u32 max_vblank_count);
> --=20
> 2.54.0
>=20

