Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CD5C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 23:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EC25040448;
	Mon, 13 Dec 2021 23:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cb25r8Y9SK1L; Mon, 13 Dec 2021 23:55:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 499A1403FC;
	Mon, 13 Dec 2021 23:55:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1882BC001E;
	Mon, 13 Dec 2021 23:55:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3312DC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 137DA60B5F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w-I8lN6a7JG1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:55:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 83C3D60B4A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639439750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FVJn8jwHDo/cZGCCQ5V+Thn/N1ZbGdPrh27DtsiDMDk=;
 b=cBj8/WJLI4cj/tWEFbYlR/+le7i7X7S7KNs0KRoRA2xw9Rbka5Mljfxqm2GAyY8JctFySR
 0DRJsqJrf/WXZ8NLMt+JmXcyfgNskQJwY5oaTKGPwQCVMtQQ3mpDp3WGpZQOo2rpQ5NChr
 z6V97L9W16sr4qOMYJdn5xKFV827Qcs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-zb8x-cGmNCq2EFBNobyTyA-1; Mon, 13 Dec 2021 18:55:49 -0500
X-MC-Unique: zb8x-cGmNCq2EFBNobyTyA-1
Received: by mail-wm1-f69.google.com with SMTP id
 ay17-20020a05600c1e1100b0033f27b76819so10415634wmb.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 15:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FVJn8jwHDo/cZGCCQ5V+Thn/N1ZbGdPrh27DtsiDMDk=;
 b=sBqF54YIRoRyFJD8ag3qDoPaRh+k+77LAnksJWbRYjvxlydwAZ8rW20LuRq1cBzvrt
 7/pmbEfEDDHsCP75POIkI5wH6w/bo+ODXj5zdh1pE4/80BQzVP8CQVLSUCBRmdQBrPFN
 RmwdQlO3h7K9yTGlSeHV+Ak66J3p7yRJ1ElwY4aKOvFTp3icjQxPtYvzbWizDjEnfaaY
 lnsrvj59rlCtEaHP7iHN3UK1PmHxXekj14ux4C4Oc8lwtpkJ0BduaJJnHqrtcekPgmrE
 ValA+Ju8ymjJb968FWPNDEb5P1LMaZY3Qy3ZrX6kM3nfewoh9EfTDffppPZ749vHju61
 Jdbw==
X-Gm-Message-State: AOAM531aiN1nDYbAp6rA2IZ7hRJ210yuRXLU0fHx0Oco1yyzAbKpLv0W
 mWUZFaHaaftFED7ZmRTlIKhMfmV+rJzww5eciHHCudpT9GLbCWeZH0rrv63dNUkImltYOscbmFY
 KY4s2NaGGaZPNT6x6QpCAI3w94OwY97175/A0cymXJw==
X-Received: by 2002:a05:6000:250:: with SMTP id
 m16mr1830930wrz.459.1639439748403; 
 Mon, 13 Dec 2021 15:55:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRuduDc4gHi1E9c1BxySUihdpD8sKyFElGW2gb5/RJfnRnGzyG7IjozaxundgzWnwsMzmibw==
X-Received: by 2002:a05:6000:250:: with SMTP id
 m16mr1830918wrz.459.1639439748269; 
 Mon, 13 Dec 2021 15:55:48 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207d:b931:2ce5:ef76:2d17:5466])
 by smtp.gmail.com with ESMTPSA id f1sm10050910wrh.116.2021.12.13.15.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Dec 2021 15:55:47 -0800 (PST)
Date: Mon, 13 Dec 2021 18:55:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [PATCH] virtio_mmio: pm: Add notification handlers for restore
 and freeze
Message-ID: <20211213185317-mutt-send-email-mst@kernel.org>
References: <20211213160002.GA202134@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20211213160002.GA202134@opensynergy.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Dec 13, 2021 at 05:00:08PM +0100, Mikhail Golubev wrote:
> From: Yurii Danilovskyi <glyd@opensynergy.com>
> 
> Handle restore and freeze notifications from the PM core. Expose
> these to individual virtio drivers that can quiesce and resume vq
> operations.
> 
> Signed-off-by: Yurii Danilovskyi <glyd@opensynergy.com>
> Signed-off-by: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
> ---
>  drivers/virtio/virtio_mmio.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 56128b9c46eb..af79f8c2a2f2 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -762,6 +762,24 @@ static void vm_unregister_cmdline_devices(void)
>  
>  #endif
>  
> +static int __maybe_unused virtio_mmio_freeze(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
> +
> +	return virtio_device_freeze(&vm_dev->vdev);
> +}
> +
> +static int __maybe_unused virtio_mmio_restore(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
> +
> +	return virtio_device_restore(&vm_dev->vdev);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(virtio_mmio_pm_ops, virtio_mmio_freeze, virtio_mmio_restore);
> +
>  /* Platform driver */
>  
>  static const struct of_device_id virtio_mmio_match[] = {
> @@ -785,6 +803,7 @@ static struct platform_driver virtio_mmio_driver = {
>  		.name	= "virtio-mmio",
>  		.of_match_table	= virtio_mmio_match,
>  		.acpi_match_table = ACPI_PTR(virtio_mmio_acpi_match),
> +		.pm = &virtio_mmio_pm_ops,
>  	},
>  };

All this code needs to be within ifdef CONFIG_PM_SLEEP.  Alternatively,
tweak virtio.h to expose virtio_device_freeze/virtio_device_restore
unconditionally.


>  
> -- 
> 2.34.1
> 
> 
> -- 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
