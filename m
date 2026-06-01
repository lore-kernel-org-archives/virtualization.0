Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF82DF128
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331093; cv=none; b=PMMFrQTX+WPWHET3/FuHWTmEbYxlCk6KUIpv9IY/CJ6o8fGs8E/CyKlfSXpKd4Sryh4ffvO4Pn8hZVsvf1nfRAMog9VB0L3RFlzrd8yhLTjdqn9udEqhMHiXZ6RZ/HjME4AwGkDseElNxiKoI2cLkVAhEzEJWdCrnVwEqTEWpTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331093; c=relaxed/simple;
	bh=lTqcQ7vXhybtp+gRQJBASUU6gtyRO//C/f9Qb+vt4dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emNc1g6iIF3vaEahGQo89dJ89F1qfviBeDJBDbcwxhOBmPizOAT7F0RsdsdkV4Z6IXwL4yPkhnjNGKrK1/J66rD7WfFb6ATY0pBBU/HDfC75gJhcJzQqzEoDf50WoqU0fcuKD1sp769gmPhzpAI1kXV61rrG5WNABfUFT5FvZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=axJheYgo; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="axJheYgo"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gTfSH35yzz9tlb;
	Mon,  1 Jun 2026 18:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780331087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OsG5f6qI2vpSgryFaskoOk1T0iCF3vYgd+hbVzXs7w=;
	b=axJheYgoGVCw7aFQMscciuscnXkGicoLCrAgNlvVujLfctHGliyJ6qY7RuZNShzQ+I842m
	H3a5EMHrlYlLgHizTV5zpBUckc0LfoJA/482VZxGuXsDWpNWsIMg75Cq3k6SzlNZsC+ZYK
	q2YMvmQn6DTH7x2d6Pe10Hp5k9SE8LxGEf6AideNgP5ki03Mb3nGkC0VoZSrMtKvnF9sGW
	j+JZ7tTqqrgZ0ugLmyVkgHXwtnd5GqjAs29lkp0c3L0gih3+0dB3eoxF8UxFsI74jskaNS
	Qc6zUCPwvN3sxHcpCudqOj/+sbkvEzLVrWwitJMu9sTCKg9W43P51b7gI4xTFg==
Message-ID: <c048fbcb-d318-414f-805f-18816cfa86f3@mailbox.org>
Date: Mon, 1 Jun 2026 18:24:43 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] drm/vblank: timer: Fix timestamp calculation
To: Thomas Zimmermann <tzimmermann@suse.de>, simona@ffwll.ch,
 louis.chauvet@bootlin.com, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, mhklkml@zohomail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux.dev
References: <20260601141922.91498-1-tzimmermann@suse.de>
 <20260601141922.91498-3-tzimmermann@suse.de>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20260601141922.91498-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9gxdnuy37fg41doyhfwinpnfmtkrkjuk
X-MBO-RS-ID: 9c17df5033fb181c77d

On 6/1/26 16:08, Thomas Zimmermann wrote:
> In drm_crtc_vblank_get_vblank_timeout(), return the timestamp of the
> first visible scanline after the last vblank timeout. This is what the
> caller expects.
> 
> A vblank phase starts with a vblank timeout. At this point the display
> is blanked for several scanlines. Afterwards the display is unblanked
> until the next vblank timeout occurs. The display content is only visible
> during that second part.
> 
> The current implementation of drm_crtc_vblank_get_vblank_timeout()
> returns the timestamp of the last vblank timeout that started the current
> vblank phase. But the display only unblanks after 20 to 30 percent of
> the overall frame duration. The returned timestamp is therefore too early.
> 
> The next vblank timeout is already known when calculating the returned
> timestamp. Instead of subtracting the duration of a full frame from the
> value, only subtract the duration of the active, visible part. The result
> is the timestamp of the first visible scanline, as expected by the caller.
> 
> This bug was not introduced by the generic vblank timer. It appears that
> the get_vblank_timeout logic has always been buggy since it was first
> added in commit 3a0709928b17 ("drm/vkms: Add vblank events simulated by
> hrtimers").
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_vblank.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 96d70c3d4522..d52df247d04e 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> [...]
> @@ -2312,17 +2321,26 @@ bool drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
>  		*vblank_time = READ_ONCE(vtimer->timer.node.expires);
>  	} while (cur_count != drm_crtc_vblank_count_and_time(crtc, &cur_time));
>  
> -	if (drm_WARN_ON(crtc->dev, !ktime_compare(*vblank_time, cur_time)))
> +	if (drm_WARN_ON(dev, !ktime_compare(*vblank_time, cur_time)))
>  		return false; /* Already expired */
>  
> +	framedur_ns = vblank->framedur_ns;
> +
>  	/*
> -	 * To prevent races we roll the hrtimer forward before we do any
> -	 * interrupt processing - this is how real hw works (the interrupt
> -	 * is only generated after all the vblank registers are updated)
> -	 * and what the vblank core expects. Therefore we need to always
> -	 * correct the timestamp by one frame.
> +	 * To prevent races we rolled the hrtimer forward before we did any
> +	 * timeout processing - this is how real hw works (the interrupt is
> +	 * only generated after all the vblank registers are updated) and what
> +	 * the vblank core expects.
> +	 *
> +	 * Therefore we always need to correct the timestamp. The returned
> +	 * time should be the time of the first active scanline after the
> +	 * previous vblank. Hence subtract the active phase's duration from
> +	 * the next expiration time.
>  	 */
> -	*vblank_time = ktime_sub(*vblank_time, vtimer->interval);
> +	if (drm_WARN_ON(dev, !mode->crtc_vtotal))
> +		return false;
> +	activedur_ns = div_s64(framedur_ns * mode->crtc_vdisplay, mode->crtc_vtotal);
> +	*vblank_time = ktime_sub_ns(*vblank_time, activedur_ns);

Normally the timestamp returned by drm_crtc_vblank_count_and_time is supposed to correspond to the end of vertical blank / start of active, in which case the new code here looks wrong.

Also, while the current time is inside an active area, it's supposed to return the timestamp corresponding to the start of the current active area, not the next one.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
