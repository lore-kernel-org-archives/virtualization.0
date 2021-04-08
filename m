Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55872C433ED
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 09:50:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF4961157
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 09:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF4961157
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 537B941904;
	Thu,  8 Apr 2021 09:50:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gmUqNbl0wnrW; Thu,  8 Apr 2021 09:50:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CF2F406A4;
	Thu,  8 Apr 2021 09:50:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30BF6C000B;
	Thu,  8 Apr 2021 09:50:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18DC7C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 01B5E41466
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yM8HIkbQ5sjQ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:50:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0B25406A4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:50:37 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id i18so1434153wrm.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Apr 2021 02:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XT6Uvr6QxDSjDPt6uf2/aqkiGCAGwLiMoyrjM1HFV1k=;
 b=ewZibRRwK495FacAf3sa9RYv2FlsuUOYMcPv8IK3dalmsr76Zjbf6gBRyqKZ5wmcSH
 Qwsz52Tm/BmfqfDy1VLbAlC2SAEFSX0KStNfA7I+l8iilgVqTBohToRwlFJ86JjJd3HL
 lHnv/NV37spEQ86MWEQbmhLuB6iNBMIDmdLhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XT6Uvr6QxDSjDPt6uf2/aqkiGCAGwLiMoyrjM1HFV1k=;
 b=bAwG0c9QUkP2C9crzkKFwvwYbL9QzW6SN5wcWjbKusnBF714R0duPi7A19vFIP1xH3
 WjqScV9dfKLL7hVQ8f81HpSEHmxK6Z7phsFf9CC26nf1EgWXplPKMM7gv3fSR1SIsB05
 FsbFSrzfRRmWf+O+eqasQtzDFb7bxuJEVpBTwsArXljaqeybTWj8LybtjkU7vcpYiS/L
 WynDt9lvw/aaP/RDEtxFt9s43WFRtnoPd3imE2rmocY5jt0Mr206sg6FLLJTyLO78Lul
 FXrU+5lqhwIvuowbm1xmGaAWJsTuJS1VBsU3CIV2ltSwJV5BPEpUOgvdg/siI3cwm1EE
 8aUA==
X-Gm-Message-State: AOAM532vo4OW7P59UVSgWFG+fYZibEd1yh6MXOa/atQIFLtXxCBeciyh
 PRfPMoftbLL4tGHKu56KgCalOQ==
X-Google-Smtp-Source: ABdhPJxffYDZUd9071tZ4d+tqTzCVAunQxs0iLn8FQb+kLIa1NQUkLsX04goCXfhBdGiY7Cqviqvlw==
X-Received: by 2002:adf:84e6:: with SMTP id 93mr9469514wrg.376.1617875435720; 
 Thu, 08 Apr 2021 02:50:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id k3sm25768727wrc.67.2021.04.08.02.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 02:50:35 -0700 (PDT)
Date: Thu, 8 Apr 2021 11:50:33 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 03/10] drm/aperture: Move fbdev conflict helpers into
 drm_aperture.h
Message-ID: <YG7R6ZkVNwrYaUWX@phenom.ffwll.local>
References: <20210318102921.21536-1-tzimmermann@suse.de>
 <20210318102921.21536-4-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210318102921.21536-4-tzimmermann@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: robh@kernel.org, bluescreen_avenger@verizon.net, geert+renesas@glider.be,
 corbet@lwn.net, airlied@linux.ie, emil.l.velikov@gmail.com,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, lgirdwood@gmail.com, mripard@kernel.org,
 virtualization@lists.linux-foundation.org, hdegoede@redhat.com,
 broonie@kernel.org, daniel@ffwll.ch, sam@ravnborg.org
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

On Thu, Mar 18, 2021 at 11:29:14AM +0100, Thomas Zimmermann wrote:
> Fbdev's helpers for handling conflicting framebuffers are related to
> framebuffer apertures, not console emulation. Therefore move them into a
> drm_aperture.h, which will contain the interfaces for the new aperture
> helpers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Tested-by: nerdopolis <bluescreen_avenger@verizon.net>
> ---
>  Documentation/gpu/drm-internals.rst |  6 +++
>  include/drm/drm_aperture.h          | 60 +++++++++++++++++++++++++++++
>  include/drm/drm_fb_helper.h         | 56 ++-------------------------
>  3 files changed, 69 insertions(+), 53 deletions(-)
>  create mode 100644 include/drm/drm_aperture.h
> 
> diff --git a/Documentation/gpu/drm-internals.rst b/Documentation/gpu/drm-internals.rst
> index 12272b168580..4c7642d2ca34 100644
> --- a/Documentation/gpu/drm-internals.rst
> +++ b/Documentation/gpu/drm-internals.rst
> @@ -75,6 +75,12 @@ update it, its value is mostly useless. The DRM core prints it to the
>  kernel log at initialization time and passes it to userspace through the
>  DRM_IOCTL_VERSION ioctl.
>  
> +Managing Ownership of the Framebuffer Aperture
> +----------------------------------------------
> +
> +.. kernel-doc:: include/drm/drm_aperture.h
> +   :internal:
> +
>  Device Instance and Driver Handling
>  -----------------------------------
>  
> diff --git a/include/drm/drm_aperture.h b/include/drm/drm_aperture.h
> new file mode 100644
> index 000000000000..13766efe9517
> --- /dev/null
> +++ b/include/drm/drm_aperture.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: MIT */
> +
> +#ifndef _DRM_APERTURE_H_
> +#define _DRM_APERTURE_H_
> +
> +#include <linux/fb.h>
> +#include <linux/vgaarb.h>
> +
> +/**
> + * drm_fb_helper_remove_conflicting_framebuffers - remove firmware-configured framebuffers

Annoying bikeshed, but I'd give them drm_aperture_ prefixes, for ocd
consistency. Also make them real functions, they're quite big and will
grow more in the next patch.

I'm also not super happy about the naming here but oh well.

Either way: Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> + * @a: memory range, users of which are to be removed
> + * @name: requesting driver name
> + * @primary: also kick vga16fb if present
> + *
> + * This function removes framebuffer devices (initialized by firmware/bootloader)
> + * which use memory range described by @a. If @a is NULL all such devices are
> + * removed.
> + */
> +static inline int
> +drm_fb_helper_remove_conflicting_framebuffers(struct apertures_struct *a,
> +					      const char *name, bool primary)
> +{
> +#if IS_REACHABLE(CONFIG_FB)
> +	return remove_conflicting_framebuffers(a, name, primary);
> +#else
> +	return 0;
> +#endif
> +}
> +
> +/**
> + * drm_fb_helper_remove_conflicting_pci_framebuffers - remove firmware-configured
> + *                                                     framebuffers for PCI devices
> + * @pdev: PCI device
> + * @name: requesting driver name
> + *
> + * This function removes framebuffer devices (eg. initialized by firmware)
> + * using memory range configured for any of @pdev's memory bars.
> + *
> + * The function assumes that PCI device with shadowed ROM drives a primary
> + * display and so kicks out vga16fb.
> + */
> +static inline int
> +drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
> +						  const char *name)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
> +	 * otherwise the vga fbdev driver falls over.
> +	 */
> +#if IS_REACHABLE(CONFIG_FB)
> +	ret = remove_conflicting_pci_framebuffers(pdev, name);
> +#endif
> +	if (ret == 0)
> +		ret = vga_remove_vgacon(pdev);
> +	return ret;
> +}
> +
> +#endif
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index 3b273f9ca39a..d06a3942fddb 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -30,13 +30,13 @@
>  #ifndef DRM_FB_HELPER_H
>  #define DRM_FB_HELPER_H
>  
> -struct drm_fb_helper;
> -
> +#include <drm/drm_aperture.h>
>  #include <drm/drm_client.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_device.h>
>  #include <linux/kgdb.h>
> -#include <linux/vgaarb.h>
> +
> +struct drm_fb_helper;
>  
>  enum mode_set_atomic {
>  	LEAVE_ATOMIC_MODE_SET,
> @@ -451,54 +451,4 @@ drm_fbdev_generic_setup(struct drm_device *dev, unsigned int preferred_bpp)
>  
>  #endif
>  
> -/**
> - * drm_fb_helper_remove_conflicting_framebuffers - remove firmware-configured framebuffers
> - * @a: memory range, users of which are to be removed
> - * @name: requesting driver name
> - * @primary: also kick vga16fb if present
> - *
> - * This function removes framebuffer devices (initialized by firmware/bootloader)
> - * which use memory range described by @a. If @a is NULL all such devices are
> - * removed.
> - */
> -static inline int
> -drm_fb_helper_remove_conflicting_framebuffers(struct apertures_struct *a,
> -					      const char *name, bool primary)
> -{
> -#if IS_REACHABLE(CONFIG_FB)
> -	return remove_conflicting_framebuffers(a, name, primary);
> -#else
> -	return 0;
> -#endif
> -}
> -
> -/**
> - * drm_fb_helper_remove_conflicting_pci_framebuffers - remove firmware-configured framebuffers for PCI devices
> - * @pdev: PCI device
> - * @name: requesting driver name
> - *
> - * This function removes framebuffer devices (eg. initialized by firmware)
> - * using memory range configured for any of @pdev's memory bars.
> - *
> - * The function assumes that PCI device with shadowed ROM drives a primary
> - * display and so kicks out vga16fb.
> - */
> -static inline int
> -drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
> -						  const char *name)
> -{
> -	int ret = 0;
> -
> -	/*
> -	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
> -	 * otherwise the vga fbdev driver falls over.
> -	 */
> -#if IS_REACHABLE(CONFIG_FB)
> -	ret = remove_conflicting_pci_framebuffers(pdev, name);
> -#endif
> -	if (ret == 0)
> -		ret = vga_remove_vgacon(pdev);
> -	return ret;
> -}
> -
>  #endif
> -- 
> 2.30.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
