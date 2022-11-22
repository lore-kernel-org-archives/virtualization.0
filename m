Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6F4C4332F
	for <virtualization@archiver.kernel.org>; Tue, 22 Nov 2022 14:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B060C81242;
	Tue, 22 Nov 2022 14:43:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B060C81242
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=eDHpO2xZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zkIfkxx4kh0E; Tue, 22 Nov 2022 14:43:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1EA8680BF9;
	Tue, 22 Nov 2022 14:43:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1EA8680BF9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2630C0032;
	Tue, 22 Nov 2022 14:43:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C619C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 14:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5085F6066D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 14:43:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5085F6066D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch
 header.a=rsa-sha256 header.s=google header.b=eDHpO2xZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tn8Q8bw8cO2T
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 14:43:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CD2460644
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CD2460644
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 14:43:28 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id g12so25005844wrs.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 06:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5305HPbjgdhR9APP4kslH8qxIGFeTQxvTrwWO5ecL8E=;
 b=eDHpO2xZH90C9tSYiGp/VaeIYNk7SELP4zYB3v0ZnLO91VIr60q8AIA0T0weqhrFmX
 9cANAWd6I3OfEiR3chhjESDJ87d7gVTnMmlH2Hfurpcj9+yu97xE3GPFvS90jYfVg8MZ
 dhT2iZB+YNELe44lAno6s+XzxLch3rRJp9a4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5305HPbjgdhR9APP4kslH8qxIGFeTQxvTrwWO5ecL8E=;
 b=wNUPeM8qWSNtpPyyMd1zvSwP3a7/GEaoHSN+sMjeQ14+Zcw0wYx1DT74Au2yRm6QSA
 hJ0xJ8Yh/zqTd+ErEhsMo4KziFuY/atFNdVPSecUuMfMKGVilQyH942cKVLlt7mcJya9
 iwqKqx0yQarDs6MZ5I1WgP3tB6UBkGQSqU+nJkJzI+yxhl/rOnj01e7CAreq/oUGBLj1
 0msaVSbuaSaNkxYQNSbuye/q/+vR9E3rrmddB2zwjLcIXDXa4vABoW6n2P8S5fZPaqwF
 U2x6XGEa1jXy6x/ZX84xACgTQg6NwodDZRd8ykHafGXviMZPCq9Kxyl/wkmoUG6H3oWh
 pFlw==
X-Gm-Message-State: ANoB5pnqyawtctO6dxb54W9ETdMxlsm1k2u/jbyU4aiW9ZP852oKNlXe
 TYjKXxZjcRiBqQyirvjRXet6Hg==
X-Google-Smtp-Source: AA0mqf5p5031i4/gZ7vbmNi+kg6/HSsefbvTuVhKj2CHt8oUSHevTCwEottLqtsRvXgdvXHrT4ezYw==
X-Received: by 2002:adf:e105:0:b0:236:73af:f9ad with SMTP id
 t5-20020adfe105000000b0023673aff9admr13918380wrz.225.1669128206350; 
 Tue, 22 Nov 2022 06:43:26 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net.
 [212.51.149.33]) by smtp.gmail.com with ESMTPSA id
 l18-20020a05600c4f1200b003c6f3f6675bsm24249904wmq.26.2022.11.22.06.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Nov 2022 06:43:25 -0800 (PST)
Date: Tue, 22 Nov 2022 15:43:23 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 7/7] drm/fb-helper: Don't use the preferred depth for the
 BPP default
Message-ID: <Y3zgC4Vp6YivHrG0@phenom.ffwll.local>
References: <20221116160917.26342-1-tzimmermann@suse.de>
 <20221116160917.26342-8-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116160917.26342-8-tzimmermann@suse.de>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
Cc: xinliang.liu@linaro.org, puck.chen@hisilicon.com,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 javierm@redhat.com, mripard@kernel.org,
 virtualization@lists.linux-foundation.org, paul.kocialkowski@bootlin.com,
 kong.kongxinwei@hisilicon.com, jstultz@google.com, daniel@ffwll.ch,
 airlied@redhat.com, tiantao6@hisilicon.com, airlied@gmail.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Nov 16, 2022 at 05:09:17PM +0100, Thomas Zimmermann wrote:
> If no preferred value for bits-per-pixel has been given, fall back
> to 32. Never use the preferred depth. The color depth is the number
> of color/alpha bits per pixel, while bpp is the overall number of
> bits in most cases.
> 
> Most noteworthy, XRGB8888 has a depth of 24 and a bpp value of 32.
> Using depth for bpp would make the value 24 as well and format
> selection in fbdev helpers fails. Unfortunately XRGB8888 is the most
> common format and the old heuristic therefore fails for most of
> the drivers (unless they implement the 24-bit RGB888 format).
> 
> Picking a bpp of 32 will lateron result in a default depth of 24
> and the format XRGB8888. As XRGB8888 is the default format for most
> of the current and legacy graphics stack, all drivers must support
> it. So it is the safe choice.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_fbdev_generic.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
> index ab86956692795..0a4c160e0e58a 100644
> --- a/drivers/gpu/drm/drm_fbdev_generic.c
> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
> @@ -431,7 +431,6 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
>   * drm_fbdev_generic_setup() - Setup generic fbdev emulation
>   * @dev: DRM device
>   * @preferred_bpp: Preferred bits per pixel for the device.
> - *                 @dev->mode_config.preferred_depth is used if this is zero.
>   *
>   * This function sets up generic fbdev emulation for drivers that supports
>   * dumb buffers with a virtual address and that can be mmap'ed.
> @@ -475,12 +474,16 @@ void drm_fbdev_generic_setup(struct drm_device *dev,
>  	}
>  
>  	/*
> -	 * FIXME: This mixes up depth with bpp, which results in a glorious
> -	 * mess, resulting in some drivers picking wrong fbdev defaults and
> -	 * others wrong preferred_depth defaults.
> +	 * Pick a preferred bpp of 32 if no value has been given. This
> +	 * will select XRGB8888 for the framebuffer formats. All drivers
> +	 * have to support XRGB8888 for backwards compatibility with legacy
> +	 * userspace, so it's the safe choice here.
> +	 *
> +	 * TODO: Replace struct drm_mode_config.preferred_depth and this
> +	 *       bpp value with a preferred format that is given as struct
> +	 *       drm_format_info. Then derive all other values from the
> +	 *       format.

I concur on this being the right design. What I've attempted years ago,
but never managed to finish, is sort the formats list on the primary plane
in preference order (since that seems useful for other reasons), and then
let everyone derive the preferred_whatever from the first format of the
first primary plane automatically.

But doing that is a pretty huge refactor, since you get to audit every
driver. So I kinda gave up on that. But I still thing something in that
direction would be a good design overall, since then userspace could also
use the same trick to infer format preferences ...

Anyway on the series, since it pushes in a direction I wanted to fix years
ago but gave up because too ambitious :-)

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  	 */
> -	if (!preferred_bpp)
> -		preferred_bpp = dev->mode_config.preferred_depth;
>  	if (!preferred_bpp)
>  		preferred_bpp = 32;
>  	fb_helper->preferred_bpp = preferred_bpp;
> -- 
> 2.38.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
