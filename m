Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2868AC433EF
	for <virtualization@archiver.kernel.org>; Mon,  2 May 2022 18:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8C7181D0C;
	Mon,  2 May 2022 18:36:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QEKfpQ5JwQ4k; Mon,  2 May 2022 18:36:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F20781BC6;
	Mon,  2 May 2022 18:36:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24A47C0039;
	Mon,  2 May 2022 18:36:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAD1AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 May 2022 18:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1C5F6080A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 May 2022 18:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ideasonboard.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DEJzba6SWSnr
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 May 2022 18:36:53 +0000 (UTC)
X-Greylist: delayed 07:02:35 by SQLgrey-1.8.0
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD6B260767
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 May 2022 18:36:53 +0000 (UTC)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi
 [62.78.145.57])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 169A5484;
 Mon,  2 May 2022 20:36:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1651516610;
 bh=yaoaNhOAhbbsbhLLMHBGWoGvporF5ND1Yq8X+9irqbw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uY4m9h5inCrZ1g09AnkLj5YrOdPggXhfWf6LuWwcQk8AGinR5Uhfe1vHnUYY+i2QJ
 ftm1w2Dugb49XtnuH9+62iewsyI/iXtGXZ0wRhKnq6Zm9lQxeUq99el/FEdH2rvuUZ
 4hX/7H0ZU9x2SoQFz2VJNwjQxp0r7vwwcMAhgMIY=
Date: Mon, 2 May 2022 21:36:49 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v2 1/3] drm: Remove superfluous arg when calling to
 drm_fbdev_generic_setup()
Message-ID: <YnAkwRL7b++a0omG@pendragon.ideasonboard.com>
References: <20220502153900.408522-1-javierm@redhat.com>
 <20220502153900.408522-2-javierm@redhat.com>
 <YnABjdpGC166yIY7@pendragon.ideasonboard.com>
 <5dd80287-1b09-d02c-9f67-5a0bb0a4566c@redhat.com>
 <bc6b6598-0e09-1a43-4086-e4164ab42a20@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc6b6598-0e09-1a43-4086-e4164ab42a20@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 virtualization@lists.linux-foundation.org
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

On Mon, May 02, 2022 at 07:15:16PM +0200, Javier Martinez Canillas wrote:
> On 5/2/22 18:55, Javier Martinez Canillas wrote:
> 
> [snip]
> 
> >> drop the depth option to drm_fbdev_generic_setup() ? There's a FIXME
> >> comment in drm_fbdev_generic_setup() that could be related.
> > 
> > A FIXME makes sense, I'll add that to when posting a v3.
> 
> There's actually a FIXME already in drm_fbdev_generic_setup(), so it's
> a documented issue [0]:

That's what I meant by "there's a FIXME" :-) It doesn't have to be
addressed by this series, but it would be good to fix it.

> void drm_fbdev_generic_setup(struct drm_device *dev,
> 			     unsigned int preferred_bpp)
> {
> ...
> 	/*
> 	 * FIXME: This mixes up depth with bpp, which results in a glorious
> 	 * mess, resulting in some drivers picking wrong fbdev defaults and
> 	 * others wrong preferred_depth defaults.
> 	 */
> 	if (!preferred_bpp)
> 		preferred_bpp = dev->mode_config.preferred_depth;
> 	if (!preferred_bpp)
> 		preferred_bpp = 32;
> 	fb_helper->preferred_bpp = preferred_bpp;
> ...
> }
> 
> [0]: https://elixir.bootlin.com/linux/v5.18-rc5/source/drivers/gpu/drm/drm_fb_helper.c#L2553

-- 
Regards,

Laurent Pinchart
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
