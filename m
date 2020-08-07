Return-Path: <SRS0=Ra46=BR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06F5C433E0
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 13:12:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77242224D
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 13:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="N78Hjx0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77242224D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 976A48737E;
	Fri,  7 Aug 2020 13:12:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BrjBGg4WeiCv; Fri,  7 Aug 2020 13:12:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E246F872B5;
	Fri,  7 Aug 2020 13:12:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA41DC0051;
	Fri,  7 Aug 2020 13:12:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 341CAC004C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 13:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 28B59872B5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 13:12:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XrAakMx1vEPH
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 13:12:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C0E2687273
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 13:12:11 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id k20so1798086wmi.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Aug 2020 06:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=EEI1Q+fppn24GUPwdHUe/rrjbN2XPprAGHaCmC9qOCk=;
 b=N78Hjx0pAcuP2VQLKJkukTxDF+52k9EvIjw1q3rhWkg1C+u2aeSRZYWPwPKisJXP8Q
 Dbx7yoJIM1L5p+lScZJ5ji9JdlO60MwT7urL//OWbV4LZewRq5sblDIb7zYNecfVdw7+
 j2I7l6qqQeMtKspM19SnVntRgx2QpvKM/9eAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=EEI1Q+fppn24GUPwdHUe/rrjbN2XPprAGHaCmC9qOCk=;
 b=V6M6QVOP7bYrLzwcxUDSBP+FC56xVFg8c77ZAgWC8FBrHztBAW+XZWDAk0c030p8rB
 2kaWYXdVA5j5adWLHQVOMein91REi2FNWznXCMwu9KuBKcvHB2+ahCZp6SC6ZIoBACGz
 lwOFZxzUEyGnVuFUpuT0Ow5Vw0KDfg2AgspwMCE8szy9sqM3tI+7Ua8S3kLHIGYaDGl/
 Mx2/nicncd8cFVo0ix3cVrdoDhG9Z0ECLJB1H1utR5baY0VoYJm/MjLptyRsS9x7TNuM
 ACaE95M23g9PkRchSfdOkX3te4lVsTXwD3cGtcwnnpcUG4eJ32l1G8z2dMR1irdFW3wb
 K3Uw==
X-Gm-Message-State: AOAM533fRZw/GjBCdVIXvB615hd9SIvHH5jmTa7Xrf9FaDhmk2cAhDGn
 2hLjsiAt0op61hkXltok3uti5A==
X-Google-Smtp-Source: ABdhPJyD5OPGKoTthEZngYIDRYz+e6OwbxqKcFkbXwnJNTrU9Di7izRE54UTv2wtNjkvOJXMA2srGQ==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr12470414wmj.122.1596805924546; 
 Fri, 07 Aug 2020 06:12:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id l11sm9904436wme.11.2020.08.07.06.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 06:12:03 -0700 (PDT)
Date: Fri, 7 Aug 2020 15:12:01 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2] drm/qxl: don't take vga ports on rev5+
Message-ID: <20200807131201.GF2352366@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
 dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
 David Airlie <airlied@linux.ie>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, 
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20200807105501.24599-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200807105501.24599-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@redhat.com>
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

On Fri, Aug 07, 2020 at 12:55:01PM +0200, Gerd Hoffmann wrote:
> qemu 5.0 introduces a new qxl hardware revision 5.  Unlike revision 4
> (and below) the device doesn't switch back into vga compatibility mode
> when someone touches the vga ports.  So we don't have to reserve the
> vga ports any more to avoid that happening.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Does what it says on the label.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 13872b882775..6e7f16f4cec7 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -96,7 +96,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (ret)
>  		goto disable_pci;
>  
> -	if (is_vga(pdev)) {
> +	if (is_vga(pdev) && pdev->revision < 5) {
>  		ret = vga_get_interruptible(pdev, VGA_RSRC_LEGACY_IO);
>  		if (ret) {
>  			DRM_ERROR("can't get legacy vga ioports\n");
> @@ -127,7 +127,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  unload:
>  	qxl_device_fini(qdev);
>  put_vga:
> -	if (is_vga(pdev))
> +	if (is_vga(pdev) && pdev->revision < 5)
>  		vga_put(pdev, VGA_RSRC_LEGACY_IO);
>  disable_pci:
>  	pci_disable_device(pdev);
> @@ -155,7 +155,7 @@ qxl_pci_remove(struct pci_dev *pdev)
>  
>  	drm_dev_unregister(dev);
>  	drm_atomic_helper_shutdown(dev);
> -	if (is_vga(pdev))
> +	if (is_vga(pdev) && pdev->revision < 5)
>  		vga_put(pdev, VGA_RSRC_LEGACY_IO);
>  }
>  
> -- 
> 2.18.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
