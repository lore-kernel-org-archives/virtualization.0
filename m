Return-Path: <SRS0=5KLU=JN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7990BC433ED
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 18:30:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D783B610FC
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 18:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D783B610FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A34CE41904;
	Fri, 16 Apr 2021 18:30:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ep7kSrw2tW9k; Fri, 16 Apr 2021 18:30:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A15C41873;
	Fri, 16 Apr 2021 18:30:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53088C000B;
	Fri, 16 Apr 2021 18:30:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC970C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 18:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 907AD60617
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 18:30:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ujCsLskT8HCe
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 18:30:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B437C60614
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 18:30:17 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id u16so11465096oiu.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 11:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2URQPxDc6xW1AaRajqTpp369cvO98uJ1uS2r5+fbu3k=;
 b=bvGRbApMkBauGUNafe/fhcXAyutILbCc9hjQGaXx7Y/ch2K9GsqGKMPlGE8C+YQN/G
 WO9/tFzpbpG7buc8WnD3yg4kA2pbNAfOl5i9iiCic9ohQgHlA2cczv2atpvGoEoGyfGz
 nCmk+k2ijBj3kd6i5KA+nB4lBrk4UcrY3460U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2URQPxDc6xW1AaRajqTpp369cvO98uJ1uS2r5+fbu3k=;
 b=WqiYkRpgR+6jnvtLyhMOMJDUkDLbE0IRfNtXOnnmcdrQXNiUVyQ17Ikq6az5/rPkot
 aa+7LOi4wGy1RnL4frLgr0SvOmQnvXov8VjnkX0sGZtJu9agK0VwG1W/GB5xUpJXMZon
 zsuChymZBj7IZCIORCoAA4WOiYAsR7b1PCLe9hLQtr68JIIxl0lqtE3ty2DAc6l4oPY5
 rQC42ScEflIrFsDjlGaTrItmL8WtKxmfrCE8Z0gwpUOrsrlWVYzHpvVNDrYUpWpKYvTS
 fa3+78yI1vNbNkROlijXY7FwDYr9iN6swRfP616N3HbPTvEwKGqvWSVqrVeH7stex6Jh
 JpcA==
X-Gm-Message-State: AOAM5331nd32T7YdMG+aSYcHS3+Rp7yekOcrtWm8tNbYfuDHoEOeA1p7
 Dkr0l1erOdGwCrALNsTUbKCWBTCOYoo4ACvGNrTcpQ==
X-Google-Smtp-Source: ABdhPJxb+g8k8UtLxPTQIoGSCy7z9ew4ioxyVJ0PqTXAZcDjJdOEUwcZL52fZgJet2zQ8R1syVlj3BNmMPeyowrEYIM=
X-Received: by 2002:a05:6808:699:: with SMTP id
 k25mr2828361oig.101.1618597816597; 
 Fri, 16 Apr 2021 11:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210416125344.13550-1-tiwai@suse.de>
In-Reply-To: <20210416125344.13550-1-tiwai@suse.de>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 16 Apr 2021 20:30:05 +0200
Message-ID: <CAKMK7uH4Cc-nEAa3CcYTAtq8nh0HHTQNvGNZSZyzB7U-EWae2Q@mail.gmail.com>
Subject: Re: [PATCH] drm: Fix fbcon blank on QEMU graphics drivers
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
 NET..." <virtualization@lists.linux-foundation.org>
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

On Fri, Apr 16, 2021 at 2:53 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> Currently the DRM fbcon helper for console blank,
> drm_fb_helper_blank(), simply calls drm_fb_helper_dpms() and always
> returns zero, supposing the driver dealing with DPMS or atomic
> crtc->active flip to handle blanking the screen.  It works on most of
> devices, but broken on most of KVM/QEMU graphics: bochs, qxl and
> cirrus drivers just ignore crtc->active state change as blanking (or
> cirrus ignoring DPMS).  In practice, when you run like
>   % setterm --blank force
> on a VT console, the screen freezes without actually blanking.
>
> A simple fix for this problem would be not to rely on DPMS but let
> fbcon performs the generic blank code.  This can be achieved just by
> returning an error from drm_fb_helper_blank().
>
> In this patch, we add a flag, no_dpms_blank, to drm_fb_helper for
> indicating that the driver doesn't handle blank via DPMS or
> crtc->active flip.  When this flag is set, drm_fb_helper_blank()
> simply returns an error, so that fbcon falls back to its generic blank
> handler.  The flag is set to both bochs and qxl drivers in this patch,
> while cirrus is left untouched as it's declared as to-be-deprecated.
>
> Link: https://lore.kernel.org/dri-devel/20170726205636.19144-1-tiwai@suse.de/
> BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1095700
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Uh we're supposed to fix these drivers to actually blank (scan out
black, worst case), not paper over it in higher levels. Atomic kms is
meant to be a somewhat useful abstraction. So now fbcon blanks, but
your desktop still just freezes.

> ---
>
> Here I whip a dead horse again, revisiting the long-standing issue
> stated in the previous patch set in 2017:
>   https://lore.kernel.org/dri-devel/20170726205636.19144-1-tiwai@suse.de/
>
> I thought to refresh the previous patch set at first, but it seems
> invalid for the atomic modeset case.  And for the atomic, it's even
> more difficult to propagate the return from the bottom to up.
> So I ended up with this approach as it's much simpler.

Yeah that's because atomic assume you can at least blank your screen to black.
-Daniel

> But if there is any better way (even simpler or more robust), I'd
> happily rewrite, too.
>
> ---
>  drivers/gpu/drm/bochs/bochs_drv.c | 3 +++
>  drivers/gpu/drm/drm_fb_helper.c   | 5 +++++
>  drivers/gpu/drm/qxl/qxl_drv.c     | 3 +++
>  include/drm/drm_fb_helper.h       | 8 ++++++++
>  4 files changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index b469624fe40d..816899a266ff 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -132,6 +132,9 @@ static int bochs_pci_probe(struct pci_dev *pdev,
>                 goto err_unload;
>
>         drm_fbdev_generic_setup(dev, 32);
> +       if (dev->fb_helper)
> +               dev->fb_helper->no_dpms_blank = true;
> +
>         return ret;
>
>  err_unload:
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index f6baa2046124..b892f02ff2f1 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -332,9 +332,14 @@ static void drm_fb_helper_dpms(struct fb_info *info, int dpms_mode)
>   */
>  int drm_fb_helper_blank(int blank, struct fb_info *info)
>  {
> +       struct drm_fb_helper *fb_helper = info->par;
> +
>         if (oops_in_progress)
>                 return -EBUSY;
>
> +       if (fb_helper->no_dpms_blank)
> +               return -EINVAL;
> +
>         switch (blank) {
>         /* Display: On; HSync: On, VSync: On */
>         case FB_BLANK_UNBLANK:
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 1864467f1063..58ecfaeed7c1 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -120,6 +120,9 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>                 goto modeset_cleanup;
>
>         drm_fbdev_generic_setup(&qdev->ddev, 32);
> +       if (qdev->fb_helper)
> +               qdev->fb_helper->no_dpms_blank = true;
> +
>         return 0;
>
>  modeset_cleanup:
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index 3b273f9ca39a..151be4219c32 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -176,6 +176,14 @@ struct drm_fb_helper {
>          */
>         bool deferred_setup;
>
> +       /**
> +        * @no_dpms_blank:
> +        *
> +        * A flag indicating that the driver doesn't support blanking.
> +        * Then fbcon core code falls back to its generic handler.
> +        */
> +       bool no_dpms_blank;
> +
>         /**
>          * @preferred_bpp:
>          *
> --
> 2.26.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
