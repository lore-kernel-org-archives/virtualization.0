Return-Path: <SRS0=KYCx=IQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4E5C433E0
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 18:28:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8386064F2A
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 18:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8386064F2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4662B432AB;
	Thu, 18 Mar 2021 18:28:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Awjg747jNi27; Thu, 18 Mar 2021 18:28:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id ED7C3432B1;
	Thu, 18 Mar 2021 18:28:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC975C000A;
	Thu, 18 Mar 2021 18:28:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E077C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 18:28:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 002886FACA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 18:28:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YYXpRtF2MmA1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 18:28:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 49BE260605
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 18:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616092091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tnHnMyJqosN4g4HqZoYksr2OdNUO3XXErmR0Dj0ujns=;
 b=Z1+sHGPPfD7W0EDFTFAfu8yMWbZoLTVtI2KEojJfJWp53w+m8ctWm9Pta7iCXRy62vk4d6
 YTF3iZ5VH181dD2VBtlDsrwbcROEUdjowXwWiWWgMGJquHt3CUIIfKXFLDVjQYrWDWp8b2
 OeTPiu/YVs142AZgCtFK3y8Ccym1s0I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-aw2HuDbKO8WqqHlL01IOpw-1; Thu, 18 Mar 2021 14:28:07 -0400
X-MC-Unique: aw2HuDbKO8WqqHlL01IOpw-1
Received: by mail-wr1-f72.google.com with SMTP id h30so20547318wrh.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 11:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tnHnMyJqosN4g4HqZoYksr2OdNUO3XXErmR0Dj0ujns=;
 b=JJblTEzDlG0qU0VY+m0rp6vw2mFqvRWi8UcMIuClgHfL88Z+/R6KrfRwbV4TJkZza4
 RZEZ7craiH7ure/h1oE3ZpRN7npmKDUQimqx9/866/dmSt/qtDd+OntfVZhZxgMEjoeF
 oqz4/gOQ7YdOFd2b/mX5pjH5ncElptg/rRUzlu+p+bsLDpo7//O8EicR4ArRkFbdbH92
 IFa+q23QiLUoHJRbnqNTvkNKxDPa3d6m4xHWOxzWW1kNg0tg36Q5QFroOhnNCPFLPCiH
 u0UED1hEZ7+8vQdu9GQi6ruI7wpfEcKHlw19t0DXP+aj/GVoKkgLqCawjpSwJPQNzjk1
 goUw==
X-Gm-Message-State: AOAM531CQ7yHMLeqy0hv+Cv2KHbLHDUhzlu3RNaI5bWBDzDIX4JEGk4I
 12Jwqho64QLNmA0+w6dL/bj4b0IjeKrT4R4qWC6FeikYRSHW9h2h6ryeAUdV4gLW6BvyLLKtCL/
 uiBNOgkGYZnuIzJd9eXHdU/DW98TRB8MgygnQzf+Aqw==
X-Received: by 2002:a1c:4e07:: with SMTP id g7mr445901wmh.29.1616092086185;
 Thu, 18 Mar 2021 11:28:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAhfnko6xreV0Aev/lGLY50U+s9V+kNR5evCF+1y99zRAKKI8v26JTFwGZ8CX5kgIkHS1h+g==
X-Received: by 2002:a1c:4e07:: with SMTP id g7mr445882wmh.29.1616092086000;
 Thu, 18 Mar 2021 11:28:06 -0700 (PDT)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id z7sm4007814wrt.70.2021.03.18.11.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Mar 2021 11:28:05 -0700 (PDT)
Date: Thu, 18 Mar 2021 14:28:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Message-ID: <20210318142709-mutt-send-email-mst@kernel.org>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-4-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20210316191652.3401335-4-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lorenzo.pieralisi@arm.com, eric.auger@redhat.com, robin.murphy@arm.com,
 joro@8bytes.org, rjw@rjwysocki.net, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, will@kernel.org, lenb@kernel.org
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

On Tue, Mar 16, 2021 at 08:16:54PM +0100, Jean-Philippe Brucker wrote:
> With the VIOT support in place, x86 platforms can now use the
> virtio-iommu.
> 
> The arm64 Kconfig selects IOMMU_DMA, while x86 IOMMU drivers select it
> themselves.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/iommu/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 2819b5c8ec30..ccca83ef2f06 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -400,8 +400,9 @@ config HYPERV_IOMMU
>  config VIRTIO_IOMMU
>  	tristate "Virtio IOMMU driver"
>  	depends on VIRTIO
> -	depends on ARM64
> +	depends on (ARM64 || X86)
>  	select IOMMU_API
> +	select IOMMU_DMA if X86

Would it hurt to just select unconditionally? Seems a bit cleaner
...

>  	select INTERVAL_TREE
>  	select ACPI_VIOT if ACPI
>  	help
> -- 
> 2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
