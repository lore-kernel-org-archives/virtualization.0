Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362029;
	b=2kQ4haYrqaT2j+nDiw4NXTh4lC5RM+Mg4REcpKLH1ah+SMN1G7+HVB4J+SiTCXOPVrdU
	 3pOAwebgUKE7JCL5JXmnyBQN2DtIXRg00kUWdsjFqa67J80HJ9RCHLgTKLE/42KHeUIex
	 4YGKsJ63GabVzL5RkmYy9F5Lr4T/1sOIfzOPHHFVmF8EUm7DFUJ3mx60+XpN11xFbOY+9
	 1UEDU1yduJTJUQY9n2f2dTqF7J7xn3Uab8gc3gNl9N2RbYh9lOCXRWRlYAo3k4vVf9mdR
	 ExlAeNWjbfIC4m6SLxmyqYovCUnUTKNapD4AB7rc4DRicQYkaSNVzMwiQTAM8960D2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362029;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Patchwork-Hint:Organization;
	bh=CPjArYl8G+Am8obLm7Z4sPZiszqq47ElsfbPQXkLSFI=;
	b=AotEV3QFML+CBwd4HEIMTOWTt21G9m+huqna4JY9fnWnqWh1O4Br9T3B7ZIQpM48wGO7
	 E8Bd0TWhBmSoAP6ctlpFUmgLr6vxiyKqRWzT71y5v7Bw1PBGsKt4128g4kiVlrAWtoybo
	 TUvyNHaT3G1cUBd4K8FvwGelZgxAdpn5hbNtrFM2JqhrpNDz0vgaDykvBhzFVrbnf5WHw
	 vzXLOnF9QkUuxQYv3lHm30n7GrQP8qb4OVc8TmRPae0S9X//gbafRBDZDN0zkCPRmcWQS
	 1mFGud2D2JYYEV1CH2EXMuq+d3DERvFSrj0pM365FlkGGD5CFkCt4mEUHyst19EKhFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lrw3qPpR;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC926606A321;
	Fri, 30 Oct 2026 12:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC926606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lrw3qPpR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793362028; x=1824898028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Rlbhsc63UiMYZbt/HRcuVNEnIcavNe8xmS+iPQ01Y/4=;
  b=lrw3qPpRacNOarQWqd9MHLlosJt3AI51DPVIuUffYRxnN2HUuSdilEnO
   MrFJkedfDjQPO8NwSNfl+gxzLewSlmZHCuKXAzMCOtkdv9SjERgnqQB5L
   LdNQszkQ9GYSsPWHNh34/6CfbcJAethEzmu8hu039YmK0UY1Y1hdt1kie
   i8AZdQe0m+0TyIidoWpSLsaKDmgBGhV8/4dSBAyR1ThJbkJewWmlBH2yd
   yMaM+9A310nzcVjMywuJY3OMTVtRfcPiij1CUXJxwvDowSOx5v0fNAiyV
   LXc8L6wbeO/0pc1OpbyVrU/yG0zbGJ6eCjrPMLmCvfPnWEKiQtu0A2E9j
   A==;
X-CSE-ConnectionGUID: qPlrI986QcCS3/ur9XoAsA==
X-CSE-MsgGUID: N2AMSLg0TI2jyDKsbBCWEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2010400"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2010400"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 05:07:07 -0700
X-CSE-ConnectionGUID: SFofencFTlCRv2jth9NNtA==
X-CSE-MsgGUID: buWd7vpfS8uqIjV9zBOT4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5763461"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.58])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 05:07:03 -0700
Date: Fri, 30 Oct 2026 14:07:00 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: me@romanilin.is, louis.chauvet@bootlin.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	airlied@gmail.com, simona@ffwll.ch, javierm@redhat.com,
	dmitry.osipenko@collabora.com, regressions@leemhuis.info,
	peter.m.arnesen@gmail.com, dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v4] drm/vblank: Don't arm vblank timer with invalid frame
 duration
Message-ID: <auSIZNhP4DTj8Nb2@intel.com>
References: <20260914110004.211027-1-tzimmermann@suse.de>
 <auIMt8XmmaVykZTC@intel.com>
 <2c2f33cf-da6f-4e31-84bb-768778d7b063@suse.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c2f33cf-da6f-4e31-84bb-768778d7b063@suse.de>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Thu, Oct 29, 2026 at 12:35:52PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 28.10.26 um 15:54 schrieb Ville Syrjälä:
> > On Mon, Sep 14, 2026 at 12:57:26PM +0200, Thomas Zimmermann wrote:
> >> From: Roman Ilin <me@romanilin.is>
> >>
> >> When a CRTC's display mode carries a too small pixel clock,
> >> drm_calc_timestamping_constants() computes a frame duration that
> >> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
> >> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
> >> interval, after which vblank events are no longer delivered. Pending
> >> page flips never complete and the display appears frozen.
> >>
> >> This could be triggered on virtio-gpu guests that have dynamic resolution
> >> enabled: when the SPICE agent or the X server resizes the output, it
> >> submits a mode whose pixel clock is off by a factor of 1000, e.g.:
> >>
> >>      clock = 406 kHz, htotal = 3152, vtotal = 2148
> > How about actually "fixing" the clock in the driver?
> 
> It's not a broken driver, but user space. There is a bug report open for 
> spice to replace the incorrect units with correct ones. [1] The fix here 
> is supposed to resolve the kernel problem this triggers.

Life becomes much simpler if you don't let garbage userspace input
past some initial sanity checks. So technically the driver should
just reject these modes. But in this case since you need to keep
the broken userspace working the driver should just fix it up,
and do so early so you don't have to deal with it anywhere else.

> 
> [1] https://gitlab.freedesktop.org/spice/linux/vd_agent/-/work_items/52
> 
> Best regards
> Thomas
> 
> 
> >
> >>      framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns (~16.7 s)
> >>
> >> 16675852216 does not fit into an int and wraps to roughly -504000000.
> >> ns_to_ktime() then yields a negative interval and the timer stops working.
> >>
> >> Found by bisection, which pointed at commit a036f5fceedb ("drm/virtgpu:
> >> Use vblank timer"). That commit merely made virtio-gpu use the vblank
> >> timer and thereby exposed the pre-existing problem in the timer setup
> >> added by commit 74afeb812850 ("drm/vblank: Add vblank timer").
> >>
> >> To fix this, modify drm_calc_timestamping_constants() to use u64 for
> >> calculations, check for INT_MAX overflows, and return an error code.
> >> drm_crtc_vblank_start_timer() will then propagate the error, enabling
> >> the driver to fall back to immediate vblank events. Valid modes are
> >> unaffected, and the timer self-heals on the next mode with a sane clock.
> >>
> >> v4:
> >> - avoid log spamming with drm_warn_once()
> >>
> >> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
> >> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> Signed-off-by: Roman Ilin <me@romanilin.is>
> >> ---
> >> I took Roman's patch from [1] and replaced the error messages with
> >> warn_once, as suggestde in my review.
> >>
> >> [1] https://lore.kernel.org/dri-devel/20260702181027.98526-1-me@romanilin.is/
> >> ---
> >>   drivers/gpu/drm/drm_vblank.c | 73 +++++++++++++++++++++++-------------
> >>   include/drm/drm_vblank.h     |  4 +-
> >>   2 files changed, 49 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> >> index f90fb2d13e42..72b543bca9e3 100644
> >> --- a/drivers/gpu/drm/drm_vblank.c
> >> +++ b/drivers/gpu/drm/drm_vblank.c
> >> @@ -631,45 +631,54 @@ EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
> >>    * drm_crtc_vblank_helper_get_vblank_timestamp(). They are derived from
> >>    * CRTC's true scanout timing, so they take things like panel scaling or
> >>    * other adjustments into account.
> >> + *
> >> + * Returns:
> >> + * 0 on success, or a negative errno code otherwise.
> >>    */
> >> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
> >> -				     const struct drm_display_mode *mode)
> >> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
> >> +				    const struct drm_display_mode *mode)
> >>   {
> >>   	struct drm_device *dev = crtc->dev;
> >>   	unsigned int pipe = drm_crtc_index(crtc);
> >>   	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
> >> -	int linedur_ns = 0, framedur_ns = 0;
> >> +	u64 linedur_ns, framedur_ns;
> >>   	int dotclock = mode->crtc_clock;
> >> +	unsigned int frame_size;
> >>   
> >>   	if (!drm_dev_has_vblank(dev))
> >> -		return;
> >> +		return 0;
> >>   
> >>   	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
> >> -		return;
> >> +		return -EINVAL;
> >>   
> >> -	/* Valid dotclock? */
> >> -	if (dotclock > 0) {
> >> -		int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
> >> +	if (dotclock <= 0) {
> >> +		drm_err_once(dev, "crtc %u: Can't calculate constants, dotclock = %d!\n",
> >> +			     crtc->base.id, dotclock);
> >> +		goto error;
> >> +	}
> >>   
> >> -		/*
> >> -		 * Convert scanline length in pixels and video
> >> -		 * dot clock to line duration and frame duration
> >> -		 * in nanoseconds:
> >> -		 */
> >> -		linedur_ns  = div_u64((u64) mode->crtc_htotal * 1000000, dotclock);
> >> -		framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
> >> +	frame_size = (unsigned int)mode->crtc_htotal * (unsigned int)mode->crtc_vtotal;
> >>   
> >> -		/*
> >> -		 * Fields of interlaced scanout modes are only half a frame duration.
> >> -		 */
> >> -		if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> >> -			framedur_ns /= 2;
> >> -	} else {
> >> -		drm_err(dev, "crtc %u: Can't calculate constants, dotclock = 0!\n",
> >> -			crtc->base.id);
> >> +	/*
> >> +	 * Convert scanline length in pixels and video dot clock to line duration
> >> +	 * and frame duration in nanoseconds.
> >> +	 */
> >> +	linedur_ns  = div_u64((u64)mode->crtc_htotal * 1000000, dotclock);
> >> +	framedur_ns = div_u64((u64)frame_size * 1000000, dotclock);
> >> +
> >> +	/*
> >> +	 * Fields of interlaced scanout modes are only half a frame duration.
> >> +	 */
> >> +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> >> +		framedur_ns /= 2;
> >> +
> >> +	if (linedur_ns > INT_MAX || framedur_ns > INT_MAX) {
> >> +		drm_err_once(dev, "crtc %u: Can't calculate constants, mode clock too small!\n",
> >> +			     crtc->base.id);
> >> +		goto error;
> >>   	}
> >>   
> >> -	vblank->linedur_ns  = linedur_ns;
> >> +	vblank->linedur_ns = linedur_ns;
> >>   	vblank->framedur_ns = framedur_ns;
> >>   	drm_mode_copy(&vblank->hwmode, mode);
> >>   
> >> @@ -678,7 +687,16 @@ void drm_calc_timestamping_constants(struct drm_crtc *crtc,
> >>   		     crtc->base.id, mode->crtc_htotal,
> >>   		     mode->crtc_vtotal, mode->crtc_vdisplay);
> >>   	drm_dbg_core(dev, "crtc %u: clock %d kHz framedur %d linedur %d\n",
> >> -		     crtc->base.id, dotclock, framedur_ns, linedur_ns);
> >> +		     crtc->base.id, dotclock,
> >> +		     vblank->framedur_ns, vblank->linedur_ns);
> >> +
> >> +	return 0;
> >> +
> >> +error:
> >> +	vblank->linedur_ns = 0;
> >> +	vblank->framedur_ns = 0;
> >> +	drm_mode_copy(&vblank->hwmode, mode);
> >> +	return -EINVAL;
> >>   }
> >>   EXPORT_SYMBOL(drm_calc_timestamping_constants);
> >>   
> >> @@ -2221,6 +2239,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
> >>   	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
> >>   	struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
> >>   	unsigned long flags;
> >> +	int ret;
> >>   
> >>   	if (!vtimer->crtc) {
> >>   		/*
> >> @@ -2239,7 +2258,9 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
> >>   			hrtimer_try_to_cancel(&vtimer->timer);
> >>   	}
> >>   
> >> -	drm_calc_timestamping_constants(crtc, &crtc->mode);
> >> +	ret = drm_calc_timestamping_constants(crtc, &crtc->mode);
> >> +	if (ret)
> >> +		return ret;
> >>   
> >>   	spin_lock_irqsave(&vtimer->interval_lock, flags);
> >>   	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
> >> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
> >> index 2fcef9c0f5b1..d99772dfa034 100644
> >> --- a/include/drm/drm_vblank.h
> >> +++ b/include/drm/drm_vblank.h
> >> @@ -311,8 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
> >>   u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
> >>   void drm_crtc_vblank_restore(struct drm_crtc *crtc);
> >>   
> >> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
> >> -				     const struct drm_display_mode *mode);
> >> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
> >> +				    const struct drm_display_mode *mode);
> >>   wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
> >>   void drm_crtc_set_max_vblank_count(struct drm_crtc *crtc,
> >>   				   u32 max_vblank_count);
> >>
> >> base-commit: 06576c2b43750d990297b8ff1989b94ac72e855f
> >> prerequisite-patch-id: 6729bb10d5e338678e78ccda2dd24f232a13cd22
> >> prerequisite-patch-id: 9d94d20bd45967493b4dc339b58082e1c8da0f4f
> >> prerequisite-patch-id: 6ac8d22df34db9e7d467b1ab95ad30f94841d5db
> >> prerequisite-patch-id: f548dbde3f944ca3415c808be628719acebe898a
> >> prerequisite-patch-id: 2ae91ee8e2bbcd33b8325be046e7214185aba6aa
> >> prerequisite-patch-id: f97bbde08a9996d7c62ca3e3ebfcd387e50bc5c3
> >> prerequisite-patch-id: ecc3c825277bc9978c6979455517249a074c0cb1
> >> prerequisite-patch-id: 0449925cca36664b566f614bfb7d573a11f0575f
> >> prerequisite-patch-id: 9fb2c2787244e9621847af09bea03e575e6276c7
> >> prerequisite-patch-id: eb4384d581805e1178d22e7df45f134223c38305
> >> prerequisite-patch-id: 1a7a529e4b2864abe8071aa44598d28ce72483f4
> >> prerequisite-patch-id: 844a85f4c2fe2f72209b82d46614004c3cfe4123
> >> prerequisite-patch-id: 13f7cb22114c648d35f8c9fa74e9165656ce31eb
> >> prerequisite-patch-id: 20ee46bd6fdd91e39f71d22f52ef6682a4e41512
> >> prerequisite-patch-id: 1d26c0ff91796ff1e62d3831d00bee18723788ef
> >> prerequisite-patch-id: 007f6ea0d09bef54b689bae0eb5abeb497bdfaad
> >> prerequisite-patch-id: 2d89c1507c909520adf9bfb1a137d458a819ae8f
> >> prerequisite-patch-id: d90dc4134468870ab8ccbd71547c9552dff74fbd
> >> prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
> >> prerequisite-patch-id: a5a973e527c88a5b47053d7a72aefe0b550197cb
> >> prerequisite-patch-id: b9adc9622920a3e70168e672c2c92795b3e3a106
> >> prerequisite-patch-id: 5030de433a01c2e99056cadb676a8e2ba35f055a
> >> -- 
> >> 2.55.0
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
> 

-- 
Ville Syrjälä
Intel
