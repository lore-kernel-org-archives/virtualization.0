Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29610C64E8A
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 08:10:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB96221FA
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 08:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB96221FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DE2B488213;
	Wed,  2 Dec 2020 08:10:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4j+MzXbdGYrb; Wed,  2 Dec 2020 08:10:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3D6CC87C15;
	Wed,  2 Dec 2020 08:10:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 239FDC163C;
	Wed,  2 Dec 2020 08:10:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D55B6C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 08:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BEE8F88212
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 08:10:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5uP9OTbaZp3E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 08:10:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ACC0987C15
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 08:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606896640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jnrzBwJgZU4I6Ezb6wFlxH0LO8dBB+DAYJtdnW/WoCA=;
 b=IBqFdzp1OAkCYrpYG7pX3pMmy6bYyhNr/6Hcw1YNyuCBbrX+2e05rA7Zuy/FV0zbwineTM
 JD7Yv9IPmtAk3qJTInPR37EP5mvt0tAQCkpNpNy1h1fH0rQ2AA+9hFUYKPDCIixbb+g4Xz
 j23vHCRiDIZSoQbU60dWvC7hTGdgSEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-CJ8zpBFONVCUPmqBiVyXjw-1; Wed, 02 Dec 2020 03:10:36 -0500
X-MC-Unique: CJ8zpBFONVCUPmqBiVyXjw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8509457240;
 Wed,  2 Dec 2020 08:10:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-94.ams2.redhat.com
 [10.36.112.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED5B660BFA;
 Wed,  2 Dec 2020 08:10:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7382416E31; Wed,  2 Dec 2020 09:10:31 +0100 (CET)
Date: Wed, 2 Dec 2020 09:10:31 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 04/20] drm/bochs: Remove references to struct
 drm_device.pdev
Message-ID: <20201202081031.o63hddrz3gccbzvt@sirius.home.kraxel.org>
References: <20201201103542.2182-1-tzimmermann@suse.de>
 <20201201103542.2182-5-tzimmermann@suse.de>
MIME-Version: 1.0
In-Reply-To: <20201201103542.2182-5-tzimmermann@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Sam Ravnborg <sam@ravnborg.org>, airlied@linux.ie,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch,
 spice-devel@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org
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

On Tue, Dec 01, 2020 at 11:35:26AM +0100, Thomas Zimmermann wrote:
> Using struct drm_device.pdev is deprecated. Convert bochs to struct
> drm_device.dev. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

> ---
>  drivers/gpu/drm/bochs/bochs_drv.c | 1 -
>  drivers/gpu/drm/bochs/bochs_hw.c  | 4 ++--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index fd454225fd19..b469624fe40d 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -121,7 +121,6 @@ static int bochs_pci_probe(struct pci_dev *pdev,
>  	if (ret)
>  		goto err_free_dev;
>  
> -	dev->pdev = pdev;
>  	pci_set_drvdata(pdev, dev);
>  
>  	ret = bochs_load(dev);
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index dce4672e3fc8..2d7380a9890e 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -110,7 +110,7 @@ int bochs_hw_load_edid(struct bochs_device *bochs)
>  int bochs_hw_init(struct drm_device *dev)
>  {
>  	struct bochs_device *bochs = dev->dev_private;
> -	struct pci_dev *pdev = dev->pdev;
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  	unsigned long addr, size, mem, ioaddr, iosize;
>  	u16 id;
>  
> @@ -201,7 +201,7 @@ void bochs_hw_fini(struct drm_device *dev)
>  		release_region(VBE_DISPI_IOPORT_INDEX, 2);
>  	if (bochs->fb_map)
>  		iounmap(bochs->fb_map);
> -	pci_release_regions(dev->pdev);
> +	pci_release_regions(to_pci_dev(dev->dev));
>  	kfree(bochs->edid);
>  }
>  
> -- 
> 2.29.2
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
