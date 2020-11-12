Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59E6C2D0A3
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:27:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3189D20A8B
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuQBexc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3189D20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7EAC487173;
	Thu, 12 Nov 2020 15:27:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MUtJygOnbIMH; Thu, 12 Nov 2020 15:27:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D99D987160;
	Thu, 12 Nov 2020 15:27:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9DA8C088B;
	Thu, 12 Nov 2020 15:27:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07CCDC016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ECF7A87132
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:27:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IBdpAat2-W0J
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:27:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 23D9F87088
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605194839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EToCEhKZCbY5qYquKZLEYM9Zxm5PVC8drZdaa3o0iK0=;
 b=PuQBexc5JbCrk+JoA+JCE26rlSNwjZWYKXfp2JIqlFW2U0Q+t88K8pzkGhK0ymQVlV/tGX
 guXj3F218sMNcTOKRsrx1mh+KaLBihj3UZTh1BqNRC8pfLV3oX1fsv7nFVCpwN4Qbmje18
 0roGsJf6NJ9LJngCi4+ySlIWN2/yKyM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-FKQHAsR0NFqyeDywu1br7g-1; Thu, 12 Nov 2020 10:27:17 -0500
X-MC-Unique: FKQHAsR0NFqyeDywu1br7g-1
Received: by mail-wr1-f72.google.com with SMTP id 67so2096798wra.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 07:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=EToCEhKZCbY5qYquKZLEYM9Zxm5PVC8drZdaa3o0iK0=;
 b=B+iGOqQzJiKcquSIfgbw6PK4LoDoXdaJI8eDl6OhZFAQjb9Cji42Zfy8b5PiQD/viz
 TAwzNkX1kvVQLJP2ET5nBLgUGzlVCR5UXVtgafCi+ep34sDumPm719RXasbH+tKfiQEJ
 GMOeubOqmeyA2t1jfYpsGu8s4hTlTWKNPDeIrjM9o2jP1yKg3T5V37Y275U5L6BeEkjD
 LpTNeg5aUWN/C7OP/ZSFjZmu2GN8BayftxD4XAVgmhYEPEwuiv4tTi+WnUfnVuHRxHrZ
 7IO9fnsyiAmV4qHSyVnOQLFg8thqLdIvhCTyksh/pxIuNaPNKwSF7wBqy+pmnx5N6aGY
 EAtA==
X-Gm-Message-State: AOAM532bOgDH9p3vB4txihLK20J9iEAhVdiXICrAlzMcsffvg/lGNeQg
 1/iVhGfq+7xbRJA9J9Urs60l2byAyXmx1J13EdzdnGoYC2qi+dIEFUaOcEHinp4oAtuuBSQ2gty
 sDH1cl93K8sn0iIpZYCDIJlqUFzLRxA3pi9PDfvnCKA==
X-Received: by 2002:adf:e44f:: with SMTP id t15mr57359wrm.380.1605194836254;
 Thu, 12 Nov 2020 07:27:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAEjBmoTH4/mr7/4f2REbvjuU/hHE1H+2TbgcnFk0M+o34TM33nSDmKd9yjYVLC54SujLB8w==
X-Received: by 2002:adf:e44f:: with SMTP id t15mr57335wrm.380.1605194836113;
 Thu, 12 Nov 2020 07:27:16 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id a9sm7378333wrp.21.2020.11.12.07.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 07:27:15 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2 04/17] iommu/hyperv: don't setup IRQ remapping when
 running as root
In-Reply-To: <20201105165814.29233-5-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-5-wei.liu@kernel.org>
Date: Thu, 12 Nov 2020 16:27:14 +0100
Message-ID: <87ft5ey4rx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>, "open list:IOMMU
 DRIVERS" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>, Joerg Roedel <joro@8bytes.org>
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

Wei Liu <wei.liu@kernel.org> writes:

> The IOMMU code needs more work. We're sure for now the IRQ remapping
> hooks are not applicable when Linux is the root.

Super-nitpick: I would suggest we always say 'root partition' as 'root'
has a 'slightly different' meaning in Linux and this commit message may
sound confusing to an unprepared reader.

>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/hyperv-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index e09e2d734c57..8d3ce3add57d 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -20,6 +20,7 @@
>  #include <asm/io_apic.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
>  
>  #include "irq_remapping.h"
>  
> @@ -143,7 +144,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>  	int i;
>  
>  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
> -	    !x2apic_supported())
> +	    !x2apic_supported() || hv_root_partition)
>  		return -ENODEV;
>  
>  	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
