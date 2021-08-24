Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C27C4320A
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 18:08:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF0F611AF
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 18:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADF0F611AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 755546063E;
	Tue, 24 Aug 2021 18:08:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QZfuY6BJob6L; Tue, 24 Aug 2021 18:08:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0EBA3606D0;
	Tue, 24 Aug 2021 18:08:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91DC9C0020;
	Tue, 24 Aug 2021 18:08:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C527DC0010
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 18:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5BC081A16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 18:08:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pQAfNYdcwuIJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 18:08:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6545181971
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 18:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629828521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wf/taVlZFNs0ougRCLlTYVmNw738QSiSdoCHx8OR6ig=;
 b=OaBhncK3OkMt0iQW1wbKSWlrzuyIK4RzdLEEyCOnADDe3fZMcr0Znmr9gTeNX+qdzHGCUD
 isQ96y/EyQfvQgIIc+2/XmjMkJbJWtKDq2aOr9nuZzoqSKk49+kZzeBnujzedBG7NszFI5
 g8HQ9CwLSe2ibjWvIjh7UEILuTWngCM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-4f2fhW2VPWOP5VDLTryFUg-1; Tue, 24 Aug 2021 14:08:39 -0400
X-MC-Unique: 4f2fhW2VPWOP5VDLTryFUg-1
Received: by mail-wr1-f72.google.com with SMTP id
 o9-20020a5d6849000000b001574518a85aso2605727wrw.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wf/taVlZFNs0ougRCLlTYVmNw738QSiSdoCHx8OR6ig=;
 b=Kd/6LqTBAQ9FGZ9fQ5S20KLNtN2a/slEwlRXj5n5z9qyN5V3Di1yIVX4vk0agQ1nxU
 NdPH7d9AhM5JRNzb5wq+xhTdOnZ27hLSyEBtyUwVHxwbaZWtoISUh4thN3cgKG4EGsmD
 ZCroqz+rcsMFCjLJOkdY5GvjQp+p0KLgZ7Mp3LINgnzzEK/zh1xBTBbH9S7ab1IiCVAx
 dOLU8B+CqYjOB2WhNZQPN944OvTEN8rSktB4bYwefdiD9HEfU3GElLhjbzH9xevDljvz
 cs4lr0wuuVjIo5J6oV/Eedz8droOuNdGmO+GOxDDyPuhnHZela/Ef5rwgoHlcJIU+XY6
 Z+iw==
X-Gm-Message-State: AOAM533Ofd2lhGzyn/GspjBTTd8nDKlxTVK6UnvhT+5+rzrxGWLu3ns8
 grCD62tdQF6lIkhU4sFAzUuDhHo1t1O7wbNSkvhtowRak5DGdSphjeUPrYQa1Z86RPT7+4Jf0Bp
 LxMVCVHcQm8gFThVLg+sBr6Hjc6+lD2i9nQZb2zXFjA==
X-Received: by 2002:adf:f541:: with SMTP id j1mr20290143wrp.180.1629828518663; 
 Tue, 24 Aug 2021 11:08:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfDkwHQb1CTI5AdZfg7DL+P9GYpcylznvSa7+7v+ifINTac25O0lU3KK9ol/wm7Mi5FZusQw==
X-Received: by 2002:adf:f541:: with SMTP id j1mr20290112wrp.180.1629828518469; 
 Tue, 24 Aug 2021 11:08:38 -0700 (PDT)
Received: from redhat.com ([212.116.168.114])
 by smtp.gmail.com with ESMTPSA id l187sm327519wml.39.2021.08.24.11.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 11:08:37 -0700 (PDT)
Date: Tue, 24 Aug 2021 14:08:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v11 01/12] iova: Export alloc_iova_fast() and
 free_iova_fast()
Message-ID: <20210824140758-mutt-send-email-mst@kernel.org>
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-2-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-2-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 christian.brauner@canonical.com, Will Deacon <will@kernel.org>, corbet@lwn.net,
 joro@8bytes.org, willy@infradead.org, hch@infradead.org,
 dan.carpenter@oracle.com, xiaodong.liu@intel.com,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 songmuchun@bytedance.com, axboe@kernel.dk, zhe.he@windriver.com,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, bcrl@kvack.org,
 netdev@vger.kernel.org, joe@perches.com, robin.murphy@arm.com,
 mika.penttila@nextfour.com
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

On Wed, Aug 18, 2021 at 08:06:31PM +0800, Xie Yongji wrote:
> Export alloc_iova_fast() and free_iova_fast() so that
> some modules can make use of the per-CPU cache to get
> rid of rbtree spinlock in alloc_iova() and free_iova()
> during IOVA allocation.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


This needs ack from iommu maintainers. Guys?

> ---
>  drivers/iommu/iova.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index b6cf5f16123b..3941ed6bb99b 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -521,6 +521,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>  
>  	return new_iova->pfn_lo;
>  }
> +EXPORT_SYMBOL_GPL(alloc_iova_fast);
>  
>  /**
>   * free_iova_fast - free iova pfn range into rcache
> @@ -538,6 +539,7 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
>  
>  	free_iova(iovad, pfn);
>  }
> +EXPORT_SYMBOL_GPL(free_iova_fast);
>  
>  #define fq_ring_for_each(i, fq) \
>  	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
> -- 
> 2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
