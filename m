Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375283;
	b=vzwDH4DugFvk53ApVTrltfR1obu7Z5vX0k1PkKmIMk3yl8ikVADe+LuwvexJZDfi+wr6
	 IRvvaeIIzndSuxv7kIkRedTurbE/1PP6GrKiV6NvwD0ssQQqzy9NdPPYYuTpB4sVux5Ln
	 Epp9GUKfDXnpruHmBXvoxsI+wye5S7sZeKFLL2GnI2k9/qV62+vhH4BBLhN2dXzfbdVR7
	 vuF4t9tLi4DDPw+Zmiv91BoQzTN5gtOXEUlc0ZWYN4+NuTErQiuNbR7aTbnDOSTBsP299
	 SdaBxJpyusHpdQxG2AxjF1OYrXUlJROQSc1qEAdrTveC/zF5+uxntXfNNnYRB+dDSWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375283;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J3bVKsks7pyKFVvk9JtMtXMGrb2wOY8qlEZRfHknQY0=;
	b=CdscqemJ21wE6Qn4n0NRF5+iU8krslaaRCLus73tj9E09xI52Rteso1AEtGLewq+/d8L
	 HPQB3l17Pltv6ZkS++OXCJjiJXRuN+yRtgOahWcAuAeKOxynNKGpGvCYevjZfKbgnCd84
	 hmVuHQGozOneURAT34K6+cZSpuSG63cbpKF6mnhyIU6aUnHDeRXBM3HEooH70LRGSkTGB
	 vZc3dNW1aaoAgL0DhZIsFTh8j5pQBrwl7xWSclMb1RqtpVcsJ3q06EoQLBLSNnhU4gSXQ
	 tZp4aJs90RIOLmS4k9MXNTc3IH8mL74mxIgswl3kHvDFpuTvBSRzgqkNOlMYjvc/NkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e8OolOZc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5B606A31A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e8OolOZc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77CC1F000C1;
	Fri, 30 Oct 2026 15:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793375282;
	bh=J3bVKsks7pyKFVvk9JtMtXMGrb2wOY8qlEZRfHknQY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e8OolOZcf1JUpeMYWDvO33MhcefEW9VeEkZybUIOuO1iy/HsdTtzqUFxpljfxpse2
	 bQQMO5EfdQDcB8dKQxlt5HN3TgU3JFJVCtncAmo6Bpg571c++gZeCgBSaSV9+zinKd
	 dfQbVd/KTfwp3V725Fd0SB3JOGLZ8yzFV2upsOWfUM90rGgL81jJOqkqr2brcjvCvm
	 irOQ68NUDI9FrSyfRtBMxAEQ8UCfh7nvAfA653RA1VCL5lC83W8VJdztUshNGlVTnX
	 zktuLS6p8Xq4L+zQr5XukmMR2TCEXndLztYgYJPy/tpH8w1z/dZB8GG3AN6YW2mqHO
	 u4RtChgNYI8vQ==
Message-ID: <sashiko-outbox-191191@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/vblank: Don't arm vblank timer with invalid
 frame duration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <c874d311-f7b1-4a24-ab75-b502ba1c5e58@suse.de>
References: <20260914110004.211027-1-tzimmermann@suse.de>
 <auIMt8XmmaVykZTC@intel.com> <2c2f33cf-da6f-4e31-84bb-768778d7b063@suse.de>
 <auSIZNhP4DTj8Nb2@intel.com> <be8e41da-5ef1-4c37-a044-171ab1f32c6d@suse.de>
 <auSgII_W-FJJz44W@intel.com> <f406b2f6-cad9-411f-941a-7e4f26af3947@suse.de>
 <c874d311-f7b1-4a24-ab75-b502ba1c5e58@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:48:01 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/vblank: inverted check_mul_overflow() in drm_crtc_vblank_mode_=
fixup()
- [High] drm/vblank: drm_crtc_vblank_start_timer() overwrites fixed-up fram=
edur_ns
- [High] drm/atomic-helper: premature drm_crtc_vblank_mode_fixup() in mode_=
fixup()
- [Low] drm/vblank: uncleaned email reply, revert notes, and missing author=
 sign-off
--

commit a8f16692f361f62f9c1ca7a34a1c2c7c62ba5c70
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/vblank: Don't arm vblank timer with invalid frame duration

This commit introduces drm_crtc_vblank_mode_fixup() and calls it from
mode_fixup() in drm_atomic_helper.c to validate and adjust display mode
dotclocks that would otherwise overflow the frame duration calculation in
drm_calc_timestamping_constants().

>     drm/vblank: Don't arm vblank timer with invalid frame duration
>    =20
>     Am 30.10.26 um 15:25 schrieb Thomas Zimmermann:
>     [...]
>     > How about we add a dedicated mode_fixup helper for vblank validatio=
n?
>     > It would run after new CRTC's mode_fixup callback. [1] There we cou=
ld
>     > try to adapt the CRTC's adjusted_mode.  Since we know the bug exact=
ly,
>     > we can try to detect it, fix it, and document it.
>     >
>    =20
>     The attached patch implements this idea. It does work in the sense th=
at
>     it doesn't immediately break my testing setup.
>    =20
>     Thorsten (or anyone else) could you please test if this patch also
>     resolve the bug with SPICE?
>    =20
>     >>
>     >
>    =20
>     --
>     --
>     Thomas Zimmermann
>     Graphics Driver Developer
>     SUSE Software Solutions Germany GmbH
>     Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
>     GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG N=C3=BC=
rnberg)
>    =20
>     When a CRTC's display mode carries a too small pixel clock,
>     drm_calc_timestamping_constants() computes a frame duration that
>     exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
>     drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
>     interval, after which vblank events are no longer delivered. Pending
>     page flips never complete and the display appears frozen.
>    =20
>     This could be triggered on virtio-gpu guests that have dynamic resolu=
tion
>     enabled: when the SPICE agent or the X server resizes the output, it
>     submits a mode whose pixel clock is off by a factor of 1000, e.g.:
>    =20
>         clock =3D 406 kHz, htotal =3D 3152, vtotal =3D 2148
>    =20
>         framedur_ns =3D 3152 * 2148 * 1000000 / 406 =3D 16675852216 ns (~=
16.7 s)
>    =20
>     16675852216 does not fit into an int and wraps to roughly -504000000.
>     ns_to_ktime() then yields a negative interval and the timer stops wor=
king.
>    =20
>     Found by bisection, which pointed at commit a036f5fceedb ("drm/virtgp=
u:
>     Use vblank timer"). That commit merely made virtio-gpu use the vblank
>     timer and thereby exposed the pre-existing problem in the timer setup
>     added by commit 74afeb812850 ("drm/vblank: Add vblank timer").
>    =20
>     To fix this, introduce drm_crtc_vblank_mode_fixup() to detect and adj=
ust
>     the bogus pixel clock. The helper runs unconditionally at the beginni=
ng
>     of the mode-fixup code. Drivers still have the opportunity to detect =
bogus
>     adjustments in later mode-fixup steps.
>    =20
>     v5:
>     - fix up the broken pixel clock beforehand (Ville)
>     v4:
>     - avoid log spamming with drm_warn_once()
>    =20
>     Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
>     Signed-off-by: Roman Ilin <me@romanilin.is>
>    =20
>     mode_fixup
>    =20
>     Revert "drm/vblank: Don't arm vblank timer with invalid frame duratio=
n"
>    =20
>     This reverts commit f3ca78682a4f9607444a3dafbe12ab6acdb1fa2f.

[Severity: Low]
This isn't a bug in the code, but the commit message includes an uncleaned
email reply header and signature block at the top, trailing git squash and
revert scratch notes at the bottom, and is missing a Signed-off-by tag from
the commit author. Should the commit message be cleaned up and include the
author's sign-off?

> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_at=
omic_helper.c
> index 9d006f98413a5..6a0f04a72292b 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -432,6 +432,17 @@ mode_fixup(struct drm_atomic_commit *state)
>  			continue;
> =20
>  		drm_mode_copy(&new_crtc_state->adjusted_mode, &new_crtc_state->mode);
> +
> +		if (!new_crtc_state->enable)
> +			continue;
> +
> +		ret =3D drm_crtc_vblank_mode_fixup(crtc, &new_crtc_state->mode,
> +						 &new_crtc_state->adjusted_mode);
> +		if (!ret) {
> +			drm_dbg_atomic(crtc->dev, "[CRTC:%d:%s] vblank fixup failed\n",
> +				       crtc->base.id, crtc->name);
> +			return -EINVAL;
> +		}
>  	}

[Severity: High]
Could running drm_crtc_vblank_mode_fixup() at the beginning of mode_fixup()
before bridge, encoder, and CRTC callbacks cause regressions for callers th=
at
populate or recompute crtc_clock later in the atomic check?

For example, in-kernel callers and KUnit tests such as
vc4_mock_atomic_add_output() in drivers/gpu/drm/vc4/tests/vc4_mock_output.c
set up a mode with DRM_SIMPLE_MODE() where crtc_clock is 0:

drivers/gpu/drm/vc4/tests/vc4_mock_output.c:vc4_mock_atomic_add_output() {
	...
	ret =3D drm_atomic_set_mode_for_crtc(crtc_state, &default_mode);
	if (ret)
		return ret;
	...
}

Similarly, vmw_du_crtc_atomic_check() in drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
populates adjusted_mode.crtc_clock during crtc->atomic_check(), which runs =
in
drm_atomic_helper_check_planes() after mode_fixup():

drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:vmw_du_crtc_atomic_check() {
	...
	if (new_state->mode.crtc_clock =3D=3D 0)
		new_state->adjusted_mode.crtc_clock =3D new_state->mode.clock;
	...
}

Because adjusted_mode.crtc_clock is still 0 at the start of mode_fixup(),
drm_vblank_validate_dotclock() will return -EINVAL and fail the check before
those callbacks run.

In addition, drm_crtc_vblank_mode_fixup() only adjusts
adjusted_mode->crtc_clock while leaving adjusted_mode->clock unchanged. If a
subsequent bridge, encoder, or CRTC mode_fixup() callback calls
drm_mode_set_crtcinfo(adjusted_mode, ...), won't that overwrite
adjusted_mode->crtc_clock with the unadjusted adjusted_mode->clock and leave
any driver-adjusted timings unvalidated?

> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f90fb2d13e423..6e826c3b6c425 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -620,6 +620,74 @@ wait_queue_head_t *drm_crtc_vblank_waitqueue(struct =
drm_crtc *crtc)
>  }
>  EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
> =20
> +static int drm_vblank_validate_dotclock(u16 crtc_htotal, u16 crtc_vtotal=
, u32 flags, int dotclock)
> +{
> +	unsigned int frame_size;
> +	u64 linedur_ns, framedur_ns;
> +
> +	if (dotclock <=3D 0)
> +		return -EINVAL;
> +
> +	frame_size =3D (unsigned int)crtc_htotal * (unsigned int)crtc_vtotal;
> +
> +	/*
> +	 * Convert scanline length in pixels and video dot clock to line durati=
on
> +	 * and frame duration in nanoseconds.
> +	 */
> +	linedur_ns  =3D div_u64((u64)crtc_htotal * 1000000, dotclock);
> +	framedur_ns =3D div_u64((u64)frame_size * 1000000, dotclock);
> +
> +	/*
> +	 * Fields of interlaced scanout modes are only half a frame duration.
> +	 */
> +	if (flags & DRM_MODE_FLAG_INTERLACE)
> +		framedur_ns /=3D 2;
> +
> +	if (linedur_ns > INT_MAX || framedur_ns > INT_MAX)
> +		return -ERANGE; /* dot clock too low */
> +
> +	return 0;
> +}
> +
> +bool drm_crtc_vblank_mode_fixup(struct drm_crtc *crtc, const struct drm_=
display_mode *mode,
> +				struct drm_display_mode *adjusted_mode)
> +{
> +	struct drm_device *dev =3D crtc->dev;
> +	unsigned int pipe =3D drm_crtc_index(crtc);
> +	int dotclock =3D adjusted_mode->crtc_clock;
> +	int ret;
> +
> +	if (!drm_dev_has_vblank(dev))
> +		return true;
> +
> +	if (drm_WARN_ON(dev, pipe >=3D dev->num_crtcs))
> +		return false;
> +
> +	ret =3D drm_vblank_validate_dotclock(adjusted_mode->crtc_htotal,
> +					   adjusted_mode->crtc_vtotal,
> +					   adjusted_mode->flags, dotclock);
> +	if (ret =3D=3D -ERANGE) {
> +		int dotclock_1000;
> +
> +		/*
> +		 * SPICE' vd_agent has a bug where it specifies the dot clock in kHz
> +		 * instead of Hz. Setting up a vblank interrupt or timer for such a
> +		 * mode overflows the calculation in drm_calc_timestamping_constants().
> +		 * An errno code of ERANGE specifically points to this problem. Try
> +		 * converting the dot clock to Hz and validate again.
> +		 */
> +		if (check_mul_overflow(dotclock, 1000, &dotclock_1000)) {

[Severity: High]
Is the check_mul_overflow() condition inverted here?

check_mul_overflow() returns true when the multiplication overflows and fal=
se
when it succeeds without overflow. When SPICE vd_agent passes a small
dotclock such as 406, multiplying 406 by 1000 does not overflow, so
check_mul_overflow(dotclock, 1000, &dotclock_1000) returns false. As a
result, the fixup block is skipped, ret remains -ERANGE,
drm_crtc_vblank_mode_fixup() returns false, and mode_fixup() rejects the
modeset with -EINVAL.

> +			ret =3D drm_vblank_validate_dotclock(adjusted_mode->crtc_htotal,
> +							   adjusted_mode->crtc_vtotal,
> +							   adjusted_mode->flags, dotclock_1000);
> +			if (!ret)
> +				adjusted_mode->crtc_clock =3D dotclock_1000;

[Severity: High]
Even if adjusted_mode->crtc_clock is updated here, won't
drm_crtc_vblank_start_timer() later overwrite vblank->framedur_ns using the
unadjusted crtc->mode?

During an atomic commit, drm_atomic_helper_update_legacy_modeset_state() in
drivers/gpu/drm/drm_atomic_helper.c copies the unadjusted mode into
crtc->mode:

drivers/gpu/drm/drm_atomic_helper.c:drm_atomic_helper_update_legacy_modeset=
_state() {
	...
	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
		...
		crtc->mode =3D new_crtc_state->mode;
		crtc->enabled =3D new_crtc_state->enable;
		...
	}
}

Although drm_atomic_helper_calc_timestamping_constants() calculates
vblank->framedur_ns from new_crtc_state->adjusted_mode, whenever vblank is
subsequently enabled on the CRTC via
drm_crtc_vblank_get()->drm_vblank_enable()->__enable_vblank()->drm_crtc_vbl=
ank_helper_enable_vblank_timer()->drm_crtc_vblank_start_timer(),
drm_crtc_vblank_start_timer() recomputes the timestamping constants from
&crtc->mode:

drivers/gpu/drm/drm_vblank.c:drm_crtc_vblank_start_timer() {
	...
	drm_calc_timestamping_constants(crtc, &crtc->mode);

	spin_lock_irqsave(&vtimer->interval_lock, flags);
	vtimer->interval =3D ns_to_ktime(vblank->framedur_ns);
	spin_unlock_irqrestore(&vtimer->interval_lock, flags);

	hrtimer_start(&vtimer->timer, vtimer->interval, HRTIMER_MODE_REL);
	...
}

Since crtc->mode still holds the unadjusted crtc_clock, won't this clobber
vblank->framedur_ns with the overflowed negative duration and arm the timer
with a negative interval anyway?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/c874d311-f7b1-4a24-=
ab75-b502ba1c5e58@suse.de?part=3D1
