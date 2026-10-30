Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368107;
	b=KzP9hYSSUnueq7N4BnDkhOQYdBlYtAMraGVe2IHc90809wv+40HHveshGbtohch4u+tJ
	 DuOknWwm0tzpVZBgrrKx7A6qwzMBHyAyzem/3wV4P9dwEP0HHCYXGpCAXYPknmyUtIg0f
	 T76SVi0gRnYWsg+Lvhi608cVBddZkgy5tSIi7xezbYmYDa6VILlxEUX8DSmIfWUE9n1gV
	 wZNjTBPxFYTjClu+bb+pHQohnC56lAiDVITWlzTuk4XZv9KVpOc80n97cdvIykE+Bxwkw
	 Vc79YxgOcr+QOhO5fLt4SmSCk7DaxrNV/5zGI9NArSaByTnJ8B0gNAWXhn9qmwGnkCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368107;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Patchwork-Hint:Organization;
	bh=5YfIsuwddGxI+iekiL/8URL9NdQlgKbZTe8WaVFLnf0=;
	b=DLJT2Fi9bYG2FFpWPEvfafvePsmNOhFDzeZfG5ra9y4spVp4D2A2lrvSoKZDQ9i0knRf
	 X9QSK11Ob5v4wnSV+1hrYcrG5qG7x9/GL+u+bGmqc78uVuRdY1v4yOmideq9eGEGxtJqi
	 nA3tfRHWD4sJMqve5Tb3fzJVA6Err6KOaOOmJkna/tiUBxfdcSxs4gGuZ+TN/h+Jl+1Da
	 PO8lu/Z9HhprWwfOaI3i/ky9r+6S46XxtFukT1P9/BGryswG+i3aJLiUvFjFZG3ZPJOHR
	 aq6BTReUC/SHV6uuBqvuXLW6/DGyooZuCMeNFcpnk2xEBouoz3xkMjqyFY6x1qKGucw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n8MJwoIv;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C2606A31D;
	Fri, 30 Oct 2026 13:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA7C2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n8MJwoIv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793368104; x=1824904104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lRE801LG5zFeShKamMVpX/KPV+Q7QsI/34y80GuciNQ=;
  b=n8MJwoIvNlJGpTdsk3/ApbPW0cANe4uXNgLm5tYXzFewbhIUaqGN9+Jr
   nEkWWgd3Aq/8ovkyYfvJw8cul7FLeqR7PGpDC3JF6t2AEOZp9jwFPncpZ
   CY/NuDkmzIEEemqSuSvyjgq6i3uWSXjVsgR+iXIEOd5escO01AkhJxRG7
   PErEQFIBIM5GM14p6+f8O3GohVq1SuUKZdVex3zgUlkx+1H7SiP/vJuuj
   a9BUvdM3caFOGJj/fFsEfaIuq1uIFeANyV/eVK6hfGRMU+cGGik6h/DZ5
   Rd9kSZBWEsObDBmLuAPVsOXRj79z1rHxj1hpAi7ccuhvbtKTSN4omQu1Y
   g==;
X-CSE-ConnectionGUID: PmJmWL2MSj6oA27vNRtw8w==
X-CSE-MsgGUID: JCiGqL0hREyfLj48RpMTHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2024005"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2024005"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 06:48:23 -0700
X-CSE-ConnectionGUID: bJvCEOFWS8qQHDqp75BJhw==
X-CSE-MsgGUID: QbNCNDPYQQSoKlfBHgeYVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5565207"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.58])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 06:48:21 -0700
Date: Fri, 30 Oct 2026 15:48:16 +0200
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
Message-ID: <auSgII_W-FJJz44W@intel.com>
References: <20260914110004.211027-1-tzimmermann@suse.de>
 <auIMt8XmmaVykZTC@intel.com>
 <2c2f33cf-da6f-4e31-84bb-768778d7b063@suse.de>
 <auSIZNhP4DTj8Nb2@intel.com>
 <be8e41da-5ef1-4c37-a044-171ab1f32c6d@suse.de>
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
In-Reply-To: <be8e41da-5ef1-4c37-a044-171ab1f32c6d@suse.de>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Fri, Oct 30, 2026 at 02:04:04PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 30.10.26 um 13:07 schrieb Ville Syrjälä:
> > On Thu, Oct 29, 2026 at 12:35:52PM +0100, Thomas Zimmermann wrote:
> >> Hi
> >>
> >> Am 28.10.26 um 15:54 schrieb Ville Syrjälä:
> >>> On Mon, Sep 14, 2026 at 12:57:26PM +0200, Thomas Zimmermann wrote:
> >>>> From: Roman Ilin <me@romanilin.is>
> >>>>
> >>>> When a CRTC's display mode carries a too small pixel clock,
> >>>> drm_calc_timestamping_constants() computes a frame duration that
> >>>> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
> >>>> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
> >>>> interval, after which vblank events are no longer delivered. Pending
> >>>> page flips never complete and the display appears frozen.
> >>>>
> >>>> This could be triggered on virtio-gpu guests that have dynamic resolution
> >>>> enabled: when the SPICE agent or the X server resizes the output, it
> >>>> submits a mode whose pixel clock is off by a factor of 1000, e.g.:
> >>>>
> >>>>       clock = 406 kHz, htotal = 3152, vtotal = 2148
> >>> How about actually "fixing" the clock in the driver?
> >> It's not a broken driver, but user space. There is a bug report open for
> >> spice to replace the incorrect units with correct ones. [1] The fix here
> >> is supposed to resolve the kernel problem this triggers.
> > Life becomes much simpler if you don't let garbage userspace input
> > past some initial sanity checks. So technically the driver should
> > just reject these modes. But in this case since you need to keep
> > the broken userspace working the driver should just fix it up,
> > and do so early so you don't have to deal with it anywhere else.
> 
> Not that I disagree, with the statement in general. But doing this here 
> seems like whack-a-mole if we leave it to individual drivers.

I think you're just trading that whack-a-mole for a worse one
where you now have to make all kinds of low level functions
deal with the garbage input.

This particular function is never expected to fail, which is
why it returns void. And where it gets called in i915 we
can't even handle the failure, so changing the return type
to int is making the whole thing confusing.

One driver independent solution would be to have 
drm_mode_validate_basic() validate the dotclock a bit hadder,
but that will not work for this case because you need to keep
allowing these bogus modes to reach the driver.

Just the other day I was actually thinking of adding some basic
frame duration checks into drm_mode_validate_basic(), but I guess
I can't do that given this userspace bug.

> And the 
> userspace is already dis-functional, no need to keep supporting it, I think.
> 
> And how would drivers know that the values are garbage before processing 
> them? 

That's why I added the device wide mode_valid hook. Drivers can
use that to reject garbage before it reaches anything more
sensitive. I have somewhat hard time believing a mode that is
acceptable/reasonable to some real world hardware would fail 
in the vblank calculations.

Hmm, and I just realized that I haven't actually added any low limit
for the dotclock in i915. I'll go do that now. I think ~10 MHz is
probably a reasonable enough number I can use there.

> Even if a driver could program them to hardware, the vblank 
> helpers could still not process them correctly. Thus leaving the 
> userspace dis-functional.
> 
> I see that we might want a common test function 
> drm_vblank_check_display_mode() and put it in some central place in the 
> atomic_check pipeline. At least we'd separate the testing from the 
> calculation.

Yeah, something like that could work. Though I still
think it'd be better to do it from the driver's mode_valid
hook to reject the bogus stuff even earlier.

That would also filter them out from the connectors' mode
lists. But I suppose you could do the vblank check in
the connector mode filtering unconditionally without
having the driver do it. Or does the buggy userspace also
need the kernel to return bogus modes from getconnector?

-- 
Ville Syrjälä
Intel
