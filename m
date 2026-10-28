Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199297;
	b=M1jBv9vnr6mQG0C8YDs6zonCOqKKr+SPCAwJBEjryuRItefx77lzDKi1ucF3lWzX52Nz
	 iSInq0zKbautAfJqB5WJvBdThU13a5xPj4bzdT7Rksynj+t7j642phIf2yEVMVsNIU9ag
	 vWYpcQ4K+rICB2KHWaJCR4mrtUlIYjIg8gUpqPCDxjppjKtzvls6P7AFHPYU3M2Wesofl
	 2dhrK5yvwRls3zTENjRupwnQmr9VfN7f5iqqHfDZjVf1pWQeJjRtKK1EVFAq9s1DT3zNG
	 pux3eN3yByIxP4824nTh+M3YQFRCQNVhS8B676lqNbMnjGXdeN95itcbQO7PU0JwcYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199297;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Patchwork-Hint:Organization;
	bh=ZUJDRffYG+F6VqBe9IuaWee5oSe7laDQj682WBe/luI=;
	b=O20AMsO9jopXXYktA/YguW4KOsEsHHBAdT8q6/v6hMpL0tIWsTBJxI/77IJvoNpdrevP
	 088FNXqZ2ZZnruhVEympLVdLIwJJiK835Ik10t7GtgkIcyWKkfYrHEtRUPzXT3/a0i7my
	 Ssq8nzXdRuK5Nhj/O5n1+CDvWNR/WXkIM/Xkm/FwB8gwncIRn7PNCFpU6QjtwqD5HS17D
	 jLzEcSlUaSqDVEejOV7/ei4CObBjomE+yw6l/v9p0CFeNxoeAREHxrn88Acr0DyKEmvac
	 IwtVSppXb6YLtr+54rdLClJxFnjlDjBAtwk5ZCd8iD+nQhQzI2bfGDxwvlKTDS2cj1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FadSoElj;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D053606A31A;
	Wed, 28 Oct 2026 14:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D053606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FadSoElj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793199296; x=1824735296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3QGgfxy0F3MoGDBYlG7hgql2ytqZHCT/J2EbJReQvdA=;
  b=FadSoEljR9RzdN4jSw9uSnKKpoArfX1HjtOau4mHbKJBme8WVTzp6Z+P
   43ObLWbuHsG2fB5xuuQky4P4DxluJrHcz75GFhWJdeAt5qNyTkW+PzOuM
   94ovUP83zTPXwd8Aw99Q1NHBI6rkYV+5KdBNU63V1u5HY5JgcWHUXsoHP
   VetBQvmtRmaMD03SGJ+GnbFq0DsU6Ola4zmH3dUKSFSLXOTDWbztl/5yL
   vJDDxE6w1+AV2xAPWwnBvl9WPR6Np9GFsjdfMT+kLUoFJwlc0Kn5DXo8e
   N3y031XedTpgMEn872+jzKWEgOiA763+TTkQ3ITIdRGEO7xIEjZz+t+2N
   Q==;
X-CSE-ConnectionGUID: 8Ghp7xbJTGGfSH36SoROmQ==
X-CSE-MsgGUID: rthn4g0fRKaBFiRltagvRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1801606"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1801606"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 07:54:55 -0700
X-CSE-ConnectionGUID: wTPHqoAtST+Db7n4VEF56Q==
X-CSE-MsgGUID: lw25RvjpTBq8S8w2BQPFzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4719568"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.233])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 07:54:51 -0700
Date: Wed, 28 Oct 2026 16:54:47 +0200
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
Message-ID: <auIMt8XmmaVykZTC@intel.com>
References: <20260914110004.211027-1-tzimmermann@suse.de>
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
In-Reply-To: <20260914110004.211027-1-tzimmermann@suse.de>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Mon, Sep 14, 2026 at 12:57:26PM +0200, Thomas Zimmermann wrote:
> From: Roman Ilin <me@romanilin.is>
> 
> When a CRTC's display mode carries a too small pixel clock,
> drm_calc_timestamping_constants() computes a frame duration that
> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
> interval, after which vblank events are no longer delivered. Pending
> page flips never complete and the display appears frozen.
> 
> This could be triggered on virtio-gpu guests that have dynamic resolution
> enabled: when the SPICE agent or the X server resizes the output, it
> submits a mode whose pixel clock is off by a factor of 1000, e.g.:
> 
>     clock = 406 kHz, htotal = 3152, vtotal = 2148

How about actually "fixing" the clock in the driver?

> 
>     framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns (~16.7 s)
> 
> 16675852216 does not fit into an int and wraps to roughly -504000000.
> ns_to_ktime() then yields a negative interval and the timer stops working.
> 
> Found by bisection, which pointed at commit a036f5fceedb ("drm/virtgpu:
> Use vblank timer"). That commit merely made virtio-gpu use the vblank
> timer and thereby exposed the pre-existing problem in the timer setup
> added by commit 74afeb812850 ("drm/vblank: Add vblank timer").
> 
> To fix this, modify drm_calc_timestamping_constants() to use u64 for
> calculations, check for INT_MAX overflows, and return an error code.
> drm_crtc_vblank_start_timer() will then propagate the error, enabling
> the driver to fall back to immediate vblank events. Valid modes are
> unaffected, and the timer self-heals on the next mode with a sane clock.
> 
> v4:
> - avoid log spamming with drm_warn_once()
> 
> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Roman Ilin <me@romanilin.is>
> ---
> I took Roman's patch from [1] and replaced the error messages with
> warn_once, as suggestde in my review.
> 
> [1] https://lore.kernel.org/dri-devel/20260702181027.98526-1-me@romanilin.is/
> ---
>  drivers/gpu/drm/drm_vblank.c | 73 +++++++++++++++++++++++-------------
>  include/drm/drm_vblank.h     |  4 +-
>  2 files changed, 49 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f90fb2d13e42..72b543bca9e3 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -631,45 +631,54 @@ EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
>   * drm_crtc_vblank_helper_get_vblank_timestamp(). They are derived from
>   * CRTC's true scanout timing, so they take things like panel scaling or
>   * other adjustments into account.
> + *
> + * Returns:
> + * 0 on success, or a negative errno code otherwise.
>   */
> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
> -				     const struct drm_display_mode *mode)
> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
> +				    const struct drm_display_mode *mode)
>  {
>  	struct drm_device *dev = crtc->dev;
>  	unsigned int pipe = drm_crtc_index(crtc);
>  	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
> -	int linedur_ns = 0, framedur_ns = 0;
> +	u64 linedur_ns, framedur_ns;
>  	int dotclock = mode->crtc_clock;
> +	unsigned int frame_size;
>  
>  	if (!drm_dev_has_vblank(dev))
> -		return;
> +		return 0;
>  
>  	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
> -		return;
> +		return -EINVAL;
>  
> -	/* Valid dotclock? */
> -	if (dotclock > 0) {
> -		int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
> +	if (dotclock <= 0) {
> +		drm_err_once(dev, "crtc %u: Can't calculate constants, dotclock = %d!\n",
> +			     crtc->base.id, dotclock);
> +		goto error;
> +	}
>  
> -		/*
> -		 * Convert scanline length in pixels and video
> -		 * dot clock to line duration and frame duration
> -		 * in nanoseconds:
> -		 */
> -		linedur_ns  = div_u64((u64) mode->crtc_htotal * 1000000, dotclock);
> -		framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
> +	frame_size = (unsigned int)mode->crtc_htotal * (unsigned int)mode->crtc_vtotal;
>  
> -		/*
> -		 * Fields of interlaced scanout modes are only half a frame duration.
> -		 */
> -		if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> -			framedur_ns /= 2;
> -	} else {
> -		drm_err(dev, "crtc %u: Can't calculate constants, dotclock = 0!\n",
> -			crtc->base.id);
> +	/*
> +	 * Convert scanline length in pixels and video dot clock to line duration
> +	 * and frame duration in nanoseconds.
> +	 */
> +	linedur_ns  = div_u64((u64)mode->crtc_htotal * 1000000, dotclock);
> +	framedur_ns = div_u64((u64)frame_size * 1000000, dotclock);
> +
> +	/*
> +	 * Fields of interlaced scanout modes are only half a frame duration.
> +	 */
> +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +		framedur_ns /= 2;
> +
> +	if (linedur_ns > INT_MAX || framedur_ns > INT_MAX) {
> +		drm_err_once(dev, "crtc %u: Can't calculate constants, mode clock too small!\n",
> +			     crtc->base.id);
> +		goto error;
>  	}
>  
> -	vblank->linedur_ns  = linedur_ns;
> +	vblank->linedur_ns = linedur_ns;
>  	vblank->framedur_ns = framedur_ns;
>  	drm_mode_copy(&vblank->hwmode, mode);
>  
> @@ -678,7 +687,16 @@ void drm_calc_timestamping_constants(struct drm_crtc *crtc,
>  		     crtc->base.id, mode->crtc_htotal,
>  		     mode->crtc_vtotal, mode->crtc_vdisplay);
>  	drm_dbg_core(dev, "crtc %u: clock %d kHz framedur %d linedur %d\n",
> -		     crtc->base.id, dotclock, framedur_ns, linedur_ns);
> +		     crtc->base.id, dotclock,
> +		     vblank->framedur_ns, vblank->linedur_ns);
> +
> +	return 0;
> +
> +error:
> +	vblank->linedur_ns = 0;
> +	vblank->framedur_ns = 0;
> +	drm_mode_copy(&vblank->hwmode, mode);
> +	return -EINVAL;
>  }
>  EXPORT_SYMBOL(drm_calc_timestamping_constants);
>  
> @@ -2221,6 +2239,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
>  	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>  	struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
>  	unsigned long flags;
> +	int ret;
>  
>  	if (!vtimer->crtc) {
>  		/*
> @@ -2239,7 +2258,9 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
>  			hrtimer_try_to_cancel(&vtimer->timer);
>  	}
>  
> -	drm_calc_timestamping_constants(crtc, &crtc->mode);
> +	ret = drm_calc_timestamping_constants(crtc, &crtc->mode);
> +	if (ret)
> +		return ret;
>  
>  	spin_lock_irqsave(&vtimer->interval_lock, flags);
>  	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
> diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
> index 2fcef9c0f5b1..d99772dfa034 100644
> --- a/include/drm/drm_vblank.h
> +++ b/include/drm/drm_vblank.h
> @@ -311,8 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
>  u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
>  void drm_crtc_vblank_restore(struct drm_crtc *crtc);
>  
> -void drm_calc_timestamping_constants(struct drm_crtc *crtc,
> -				     const struct drm_display_mode *mode);
> +int drm_calc_timestamping_constants(struct drm_crtc *crtc,
> +				    const struct drm_display_mode *mode);
>  wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
>  void drm_crtc_set_max_vblank_count(struct drm_crtc *crtc,
>  				   u32 max_vblank_count);
> 
> base-commit: 06576c2b43750d990297b8ff1989b94ac72e855f
> prerequisite-patch-id: 6729bb10d5e338678e78ccda2dd24f232a13cd22
> prerequisite-patch-id: 9d94d20bd45967493b4dc339b58082e1c8da0f4f
> prerequisite-patch-id: 6ac8d22df34db9e7d467b1ab95ad30f94841d5db
> prerequisite-patch-id: f548dbde3f944ca3415c808be628719acebe898a
> prerequisite-patch-id: 2ae91ee8e2bbcd33b8325be046e7214185aba6aa
> prerequisite-patch-id: f97bbde08a9996d7c62ca3e3ebfcd387e50bc5c3
> prerequisite-patch-id: ecc3c825277bc9978c6979455517249a074c0cb1
> prerequisite-patch-id: 0449925cca36664b566f614bfb7d573a11f0575f
> prerequisite-patch-id: 9fb2c2787244e9621847af09bea03e575e6276c7
> prerequisite-patch-id: eb4384d581805e1178d22e7df45f134223c38305
> prerequisite-patch-id: 1a7a529e4b2864abe8071aa44598d28ce72483f4
> prerequisite-patch-id: 844a85f4c2fe2f72209b82d46614004c3cfe4123
> prerequisite-patch-id: 13f7cb22114c648d35f8c9fa74e9165656ce31eb
> prerequisite-patch-id: 20ee46bd6fdd91e39f71d22f52ef6682a4e41512
> prerequisite-patch-id: 1d26c0ff91796ff1e62d3831d00bee18723788ef
> prerequisite-patch-id: 007f6ea0d09bef54b689bae0eb5abeb497bdfaad
> prerequisite-patch-id: 2d89c1507c909520adf9bfb1a137d458a819ae8f
> prerequisite-patch-id: d90dc4134468870ab8ccbd71547c9552dff74fbd
> prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
> prerequisite-patch-id: a5a973e527c88a5b47053d7a72aefe0b550197cb
> prerequisite-patch-id: b9adc9622920a3e70168e672c2c92795b3e3a106
> prerequisite-patch-id: 5030de433a01c2e99056cadb676a8e2ba35f055a
> -- 
> 2.55.0

-- 
Ville Syrjälä
Intel
