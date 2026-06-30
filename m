Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646E9408631;
	Tue, 30 Jun 2026 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821217; cv=none; b=kC+zCSzQ+m5F6oRv7h6DPXgfw8TlV61d9iGIVbqcpzmx6ZtcP1Y0AL+xtt+z872Ww6/QqLgz3Bc5Wt5fsvcI8CDjEUpI1Crz7E7rZbAaMyh5UYt8KYHFdKbAZRFwOdE2XiSZyEIBkUJnRMi+K4RG4NyZlutFpXa8K4KGeXoODfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821217; c=relaxed/simple;
	bh=LGUC9N6dVaFtlLE612P6N/M6GpBTL5aRGEzwEqORrlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LK3eB2S4YT/d6hU2S9VLGwZSfCrcq62mc/Svs5ZvPnXgktvLFRZQMlNAIG1/PAgltFLieEDCISEkYiCbZdkX5kiJtrVLObhaFEPtpZmpWIIRw+uorhvvl3f6vJcKu7O30QbtPT+CsdQmlR66/qbcOPkfvT+Pi8gEvzS2LZsgvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=iidsFbJW; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="iidsFbJW"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4gqMLf6ntgz40y4;
	Tue, 30 Jun 2026 14:06:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1782821179;
	bh=LGUC9N6dVaFtlLE612P6N/M6GpBTL5aRGEzwEqORrlY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iidsFbJWKHihcFI+ixf0sM1k17MITwXDRq2klCgmcDI4rXOlBH+ixLofdzsOZU2Xv
	 hSi4qcwF0S3zaJ6nKsZu456ucEouSJhCbQoTQSXgLMGHK/gw+QpCi+Bso9LZEx9/AO
	 lvzyUxAWzjNkiC5Kr2UBaZwePd0i4eCVs2zmt2oKwSonJr39b7dTxlGiJPIbIUO6uD
	 y8F+N/Kyjk55YW+MINwOXiJAR0ADLxJiD8nOQGCdopJ8zCNA1tdEJpCl1A6LY9Tz4e
	 yc9/NajOFSe08Akg4UvDCSyUam1dq1ckGHTEh91EqfTzPoNIhrUP2vnwsAJAKsTu5c
	 oyCMB29I4kz4A==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4gqMLf61VSz40wT;
	Tue, 30 Jun 2026 14:06:18 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gqMLd3Q24z8sgS;
	Tue, 30 Jun 2026 14:06:17 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 6927A60320;
	Tue, 30 Jun 2026 14:06:11 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ef53342b-7c63-4681-8c5d-de86d9ee5541@leemhuis.info>
Date: Tue, 30 Jun 2026 14:06:11 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vblank: Don't arm vblank timer with invalid frame
 duration
To: Roman Ilin <me@romanilin.is>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Peter Arnesen <peter.m.arnesen@gmail.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260613224434.96501-1-me@romanilin.is>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260613224434.96501-1-me@romanilin.is>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178282117199.964836.384779074584851132@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 6927A60320
X-NC-CID: PEHjDG9j4m07s+AFumvcLECsmuNmFAU8/YnJczSQRwGqdMQNJ8g=

On 6/14/26 00:44, Roman Ilin wrote:
> When a CRTC's display mode carries a too small pixel clock,
> drm_calc_timestamping_constants() computes a frame duration that
> exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
> drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
> interval, after which vblank events are no longer delivered. Pending
> page flips never complete and the display appears frozen.

Roman, what's the status here? Does the problem still happen with
7.2-rc1? Sounds like it likely will, just want to make sure before
prodding Thomas about it, who authored and committed the change that
causes this regression.

Side note: CCing Peter Arnesen, who seems to be affected as well.
Quoting a message that was CCed to the regression list, but apparently
was rejected there:

"""
Hi everyone,

I am experiencing a similar Wayland display freeze on Kernel 7.0
described in Roman Ilin's recent patch thread ("drm/vblank: Don't arm
vblank timer with invalid frame duration").

Since my laptop consistently reproduces this freeze on boot, I am
reaching out to offer my hardware for testing if you need verification
that this patch resolves the issue on the newer Ryzen AI architectures.

My System:
* CPU / iGPU: AMD Ryzen AI 9 HX
* dGPU: NVIDIA GeForce RTX 5070
* OS: Fedora 44, Kubuntu 26.04 and Nobara Linux (Fedora-based) / Wayland
* Regression Status: Works perfectly on Kernel 6.19. Fails on Kernel 7.0.
* Tested Workarounds: Kernel parameters amdgpu.dcdebugmask=0x10, 0x410,
and amdgpu.sg_display=0 do not bypass the freeze.

Please let me know if you need me to pull specific dmesg logs or similar
from the frozen state, or if there is a specific patched branch you
would like me to compile and boot to verify the fix.

Regards

Peter
"""

Peter, would be great if you could test 7.2-rc1, too. And if you really
think the problem is the same, it might be worth trying Roman's patch.
Ciao, Thorsten

> This could be triggered on virtio-gpu guests that have dynamic resolution
> enabled: when the SPICE agent or the X server resizes the output, it
> submits a mode whose pixel clock is off by a factor of 1000, e.g.:
> 
>     clock = 406 kHz, htotal = 3152, vtotal = 2148
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
> Reject a non-positive frame duration in drm_crtc_vblank_start_timer() and
> return an error. enable_vblank then fails and the driver falls back to
> sending the vblank event immediately, as it did before the vblank timer
> was introduced. Valid modes are unaffected, and the timer self-heals on
> the next mode that has a sane clock.
> 
> Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Roman Ilin <me@romanilin.is>
> ---
> Notes:
> 
> Based on v7.1-rc7. Tested on 6.19 and 7.1-rc7.
> 
> Open questions:
> 
> This relies on the int overflow producing a negative value. The deeper
> issue is that drm_calc_timestamping_constants() truncates framedur_ns to
> int. Would you prefer to widen framedur_ns to s64, or to bound the
> interval here (e.g. reject framedur_ns above one second) so that any
> bogus interval is rejected regardless of sign?
> 
> Should virtio-gpu additionally sanitize the user-supplied clock in its
> atomic_check (similar to vmwgfx for the clock==0 case) so the
> vblank-timer throttling is preserved for these resizes, instead of
> falling back to immediate events?
> 
>  drivers/gpu/drm/drm_vblank.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index f78bf37f1..557cd0bc8 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -2235,7 +2235,13 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
>  
>  	drm_calc_timestamping_constants(crtc, &crtc->mode);
>  
> +	/*
> +	 * Return an error so the driver falls back to sending vblank events
> +	 * when a small mode clock yields a frame duration exceeding INT_MAX.
> +	 */
> +	if (vblank->framedur_ns <= 0)
> +		return -EINVAL;
> +
>  	spin_lock_irqsave(&vtimer->interval_lock, flags);
>  	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
>  	spin_unlock_irqrestore(&vtimer->interval_lock, flags);

