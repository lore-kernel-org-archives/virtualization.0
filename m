Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508ECC433F5
	for <virtualization@archiver.kernel.org>; Mon,  2 May 2022 16:06:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 010CC81395;
	Mon,  2 May 2022 16:06:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6xKlqiBZXMkt; Mon,  2 May 2022 16:06:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 67EDB81363;
	Mon,  2 May 2022 16:06:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AC98C0039;
	Mon,  2 May 2022 16:06:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76587C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 May 2022 16:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D0C681395
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 May 2022 16:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2AndwNAb_r9h
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 May 2022 16:06:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69CD781363
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 May 2022 16:06:41 +0000 (UTC)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi
 [62.78.145.57])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id AD64E474;
 Mon,  2 May 2022 18:06:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1651507597;
 bh=aabGl3GzSk94KKGc7OXE2SaovEGKFkQ64Px+ktw/wOs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=czFQIBTu+DGi0WBWJyKysjh14KAYvcNHHtRoLgVMTh3FtfmMrb5Q4qseexYQxcL75
 +2rWUtoLDmoHKWm0mRf/79t4OiRp80rMiKA1VSpBCzjrzWjbVnQ2b0o+AnVsURc2lj
 oX7m4tYokxNipuE1HEvXWxyiQudkQdcaEVf1gvMs=
Date: Mon, 2 May 2022 19:06:37 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v2 1/3] drm: Remove superfluous arg when calling to
 drm_fbdev_generic_setup()
Message-ID: <YnABjdpGC166yIY7@pendragon.ideasonboard.com>
References: <20220502153900.408522-1-javierm@redhat.com>
 <20220502153900.408522-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220502153900.408522-2-javierm@redhat.com>
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

Hi Javier,

Thank you for the patch.

On Mon, May 02, 2022 at 05:38:58PM +0200, Javier Martinez Canillas wrote:
> The drm_fbdev_generic_setup() function already sets the preferred bits per
> pixel for the device to dev->mode_config.preferred_depth, if preferred_bpp
> value is zero.
> 
> Passing the same value to the function is unnecessary. Let's cleanup that
> in the two drivers that do it.

This looks fine, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

but why do we have two different mechanisms to set the preferred depth ?
Could we get all drivers to set dev->mode_config.preferred_depth and
drop the depth option to drm_fbdev_generic_setup() ? There's a FIXME
comment in drm_fbdev_generic_setup() that could be related.

> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 2 +-
>  drivers/gpu/drm/tiny/cirrus.c                   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index fe4269c5aa0a..ace92459e462 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -349,7 +349,7 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>  		goto err_unload;
>  	}
>  
> -	drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
> +	drm_fbdev_generic_setup(dev, 0);
>  
>  	return 0;
>  
> diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
> index c8e791840862..ed5a2e14894a 100644
> --- a/drivers/gpu/drm/tiny/cirrus.c
> +++ b/drivers/gpu/drm/tiny/cirrus.c
> @@ -601,7 +601,7 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
>  	if (ret)
>  		return ret;
>  
> -	drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
> +	drm_fbdev_generic_setup(dev, 0);
>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
