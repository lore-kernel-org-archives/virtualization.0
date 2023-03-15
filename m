Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6BDC6FD1D
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 11:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE62641797;
	Wed, 15 Mar 2023 11:55:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE62641797
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b4aiPWVf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3AzfaOL2Al72; Wed, 15 Mar 2023 11:55:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BE8904177E;
	Wed, 15 Mar 2023 11:55:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE8904177E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 882A7C0071;
	Wed, 15 Mar 2023 11:55:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 003DFC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 11:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC1DE81E28
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 11:55:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC1DE81E28
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=b4aiPWVf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J3JBryciN2TN
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 11:55:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1446281E26
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1446281E26
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 11:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1678881318; x=1710417318;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=oPJSnVJBwKqGK8ZAqvFY8WXT8H4giRQeUz42yfh764o=;
 b=b4aiPWVfAd2Nzy7BsvgEqXB0kYHfsIA32kllsnMrQZRf7+NVndSC1odD
 XLYw39y3KJf6N30IR+wb+HT52ctFJ1WUV/gaG36SHivMnDT3bC5XoNnU7
 xrQu40E8k61GHOSdoz9/JKhpgTg8SkKWPlUgIeAiVK296uhcsY83gLLzZ
 XU/ahKSF4FaMac+ts2dmq8v+fXue+CtyqRGSoftfs9miuiEbGocRQtm2D
 cMQBVPH4UHDeNsmURTnzreSb/uoQG+DFz9h43mnlWKvbFUO7/v0lhatEZ
 z8eO4iQHHAmvvRZ3IV9on+cAwWzkNMN1QJoSKo+Ngz7sYHvPixpnxGcVk w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="335166527"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; d="scan'208";a="335166527"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2023 04:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="803256923"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; d="scan'208";a="803256923"
Received: from wujunyox-mobl.ger.corp.intel.com (HELO localhost)
 ([10.252.59.32])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2023 04:54:52 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 07/38] drm: handle HAS_IOPORT dependencies
In-Reply-To: <20230314121216.413434-8-schnelle@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-8-schnelle@linux.ibm.com>
Date: Wed, 15 Mar 2023 13:54:49 +0200
Message-ID: <87fsa65iwm.fsf@intel.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Alan Stern <stern@rowland.harvard.edu>,
 Paul Walmsley <paul.walmsley@sifive.com>, Bjorn Helgaas <bhelgaas@google.com>,
 spice-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
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

On Tue, 14 Mar 2023, Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them. In the bochs driver there is optional MMIO
> support detected at runtime, warn if this isn't taken when
> HAS_IOPORT is not defined.

Not that I care a whole lot, but there should really only be one warning
or even failure to probe at bochs_hw_init() for !bochs->mmio &&
!IS_ENABLED(CONFIG_HAS_IOPORT), not warnings all over the place.

Moreover, the config macro is CONFIG_HAS_IOPORT instead of HAS_IOPORT
that you check for below.

BR,
Jani.

> There is also a direct and hard coded use in cirrus.c which according to
> the comment is only necessary during resume.  Let's just skip this as
> for example s390 which doesn't have I/O port support also doesen't
> support suspend/resume.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/gpu/drm/qxl/Kconfig   |  1 +
>  drivers/gpu/drm/tiny/bochs.c  | 19 +++++++++++++++++++
>  drivers/gpu/drm/tiny/cirrus.c |  2 ++
>  3 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/qxl/Kconfig b/drivers/gpu/drm/qxl/Kconfig
> index ca3f51c2a8fe..d0e0d440c8d9 100644
> --- a/drivers/gpu/drm/qxl/Kconfig
> +++ b/drivers/gpu/drm/qxl/Kconfig
> @@ -2,6 +2,7 @@
>  config DRM_QXL
>  	tristate "QXL virtual GPU"
>  	depends on DRM && PCI && MMU
> +	depends on HAS_IOPORT
>  	select DRM_KMS_HELPER
>  	select DRM_TTM
>  	select DRM_TTM_HELPER
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index 024346054c70..da4a5d53b003 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -2,6 +2,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <asm/bug.h>
>  
>  #include <drm/drm_aperture.h>
>  #include <drm/drm_atomic_helper.h>
> @@ -105,7 +106,11 @@ static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
>  
>  		writeb(val, bochs->mmio + offset);
>  	} else {
> +#ifdef HAS_IOPORT
>  		outb(val, ioport);
> +#else
> +		WARN_ONCE(1, "Non-MMIO bochs device needs HAS_IOPORT");
> +#endif
>  	}
>  }
>  
> @@ -119,7 +124,12 @@ static u8 bochs_vga_readb(struct bochs_device *bochs, u16 ioport)
>  
>  		return readb(bochs->mmio + offset);
>  	} else {
> +#ifdef HAS_IOPORT
>  		return inb(ioport);
> +#else
> +		WARN_ONCE(1, "Non-MMIO bochs device needs HAS_IOPORT");
> +		return 0xff;
> +#endif
>  	}
>  }
>  
> @@ -132,8 +142,13 @@ static u16 bochs_dispi_read(struct bochs_device *bochs, u16 reg)
>  
>  		ret = readw(bochs->mmio + offset);
>  	} else {
> +#ifdef HAS_IOPORT
>  		outw(reg, VBE_DISPI_IOPORT_INDEX);
>  		ret = inw(VBE_DISPI_IOPORT_DATA);
> +#else
> +		WARN_ONCE(1, "Non-MMIO bochs device needs HAS_IOPORT");
> +		ret = 0xffff;
> +#endif
>  	}
>  	return ret;
>  }
> @@ -145,8 +160,12 @@ static void bochs_dispi_write(struct bochs_device *bochs, u16 reg, u16 val)
>  
>  		writew(val, bochs->mmio + offset);
>  	} else {
> +#ifdef HAS_IOPORT
>  		outw(reg, VBE_DISPI_IOPORT_INDEX);
>  		outw(val, VBE_DISPI_IOPORT_DATA);
> +#else
> +		WARN_ONCE(1, "Non-MMIO bochs device needs HAS_IOPORT");
> +#endif
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
> index accfa52e78c5..9da89732c5ac 100644
> --- a/drivers/gpu/drm/tiny/cirrus.c
> +++ b/drivers/gpu/drm/tiny/cirrus.c
> @@ -308,8 +308,10 @@ static int cirrus_mode_set(struct cirrus_device *cirrus,
>  
>  	cirrus_set_start_address(cirrus, 0);
>  
> +#ifdef CONFIG_HAS_IOPORT
>  	/* Unblank (needed on S3 resume, vgabios doesn't do it then) */
>  	outb(0x20, 0x3c0);
> +#endif
>  
>  	drm_dev_exit(idx);
>  	return 0;

-- 
Jani Nikula, Intel Open Source Graphics Center
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
