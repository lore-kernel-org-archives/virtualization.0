Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12F1823C3
	for <virtualization@lists.linux.dev>; Thu,  3 Oct 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968066; cv=none; b=RiBWAeyNqITpxOIl+mOtUE6pAPOVKru5179mW5f3G73umsjsPB2SQ/TDNStvqCs0DMMTidj1otFUjS3Pb23NwlCTIe7FP6rv7mCg9cMzhxwA1kqiR8kRe44XacjAmED/Aesb97wA/RcBcROtmn1pqbBhlobnPqh2G1sk59Rkh30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968066; c=relaxed/simple;
	bh=8K5zO35qb+9a+p5HcRNJdxg6gd7eSj+Mb5wBQZ7rcXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/I7BtsgsQVegOyg0tyeJNy7OJMgLIwMOSjmBx6jpoO2rX7psMgNE+rL/HGPPRm58XEpWF8QsYSr6FBSK0q8mKwYxWEONP92zCDg1Yl6/2URsLiyy9fO8+zUcVZfhYpBsv3i17jPmwTkK+4zH4UVGcR1jXckL2pU+FpwkUPcNuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YEH2YnPw; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YEH2YnPw"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 11E6024000C;
	Thu,  3 Oct 2024 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727968061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZElLwQ5mHYReOaSmSvT7278JqqhnnyULQk+/1+1kJk=;
	b=YEH2YnPwiMskls9hd/gfzbIgYfC1qkcLesGnJNkrsmHEe3zu8VFZWm6BdgmnrnZ2Qgf6Mu
	rl3svRb/4mCMycfcmpARRBvji7+Ry/w2vzIC3T393ERmy9UbpVYnNhM87rfFxR4CxUfMDQ
	ksrKmVA99rcw5b1jA2ZNxjOLpTc24XkDfONA9tFeR45nmPl6UkQuJxTG6VYt19wt2k0OWd
	ly5GPToqHmZiL+uWVlGQozyWeIO9rxeLv5puwAjVLmo/Jys8TaMxMe0xWkBxg30yo2dr0e
	+qHYoE0Ir3I/BslTW53FebEDYX6GCccBs1oOkCfEqWwDeCFPtxDgi2SkeFavmA==
Date: Thu, 3 Oct 2024 17:07:35 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Liviu Dudau <liviu.dudau@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Inki Dae <inki.dae@samsung.com>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Sandy Huang <hjc@rock-chips.com>, Jyri Sarha <jyri.sarha@iki.fi>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Zack Rusin <zack.rusin@broadcom.com>, amd-gfx@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/2] drm: Move crtc->{x, y, mode, enabled} to legacy
 sub-structure
Message-ID: <Zv6zN7Go_XG44P2-@louis-chauvet-laptop>
Mail-Followup-To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Liviu Dudau <liviu.dudau@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Inki Dae <inki.dae@samsung.com>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Sandy Huang <hjc@rock-chips.com>, Jyri Sarha <jyri.sarha@iki.fi>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Zack Rusin <zack.rusin@broadcom.com>, amd-gfx@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20241002182200.15363-1-ville.syrjala@linux.intel.com>
 <20241002182200.15363-3-ville.syrjala@linux.intel.com>
 <Zv6QF2EmIcogtlLA@louis-chauvet-laptop>
 <Zv6gSGMXZZARf3oV@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv6gSGMXZZARf3oV@intel.com>
X-GND-Sasl: louis.chauvet@bootlin.com


> > > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > index a40295c18b48..780681ea77e4 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > @@ -64,7 +64,7 @@ static int vkms_enable_vblank(struct drm_crtc *crtc)
> > >  	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
> > >  	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
> > >  
> > > -	drm_calc_timestamping_constants(crtc, &crtc->mode);
> > > +	drm_calc_timestamping_constants(crtc, &crtc->legacy.mode);
> > 
> > 	drm_calc_timestamping_constants(crtc, &crtc->state->mode);
> 
> This one doesn't look safe. You want to call that during your atomic
> commit already.
> 

This was already not safe with the previous implementation? Or it is only 
unsafe because now I use state->mode instead of legacy.mode?

After inspecting the code, I think I don't need to call it as:

In `vkms_atomic_commit_tail` (used in 
`@vkms_mode_config_helpers.atomic_commit_tail`), we call 
`drm_atomic_helper_commit_modeset_disables`, which call 
`drm_atomic_helper_calc_timestamping_constants` which call 
`drm_calc_timestamping_constants` for every CRTC.

I tested kms_vblank, all of them are SUCCESS/SKIP, do you know other tests 
that can trigger bugs?

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
