Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482E8C433FE
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 02:07:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E379E60ED7
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 02:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E379E60ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0B38402A2;
	Mon, 11 Oct 2021 02:07:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4E8mCkY2NZ3I; Mon, 11 Oct 2021 02:07:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B3B840385;
	Mon, 11 Oct 2021 02:07:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2C40C0021;
	Mon, 11 Oct 2021 02:07:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08B51C0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 02:07:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 00CBD401D5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 02:07:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YxEqaqV8rvQi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 02:07:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2E90401D1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 02:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633918022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ENeVT4EJ4HhfdzKw1adhLhObafui60u3kBaV6BSYZzQ=;
 b=RJ6biJLY6OL0VJZOMN5+Yt5GC/Y8BXYGm85+tGM3fGo1/jzISbYewuYayrf8KtRFEBEEKv
 EIQHhtjTwXDfTVWZdrU0sVwQr1f8NeDB4jApwOw0sHHzNVWirnBy6k80kXnuHRU/9pQ0Sv
 McgMAHgWZjmyLLmpo9nj9z2fmQA4dmM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-wmcmYxfjPsGXeSXDi1NrWA-1; Sun, 10 Oct 2021 22:07:01 -0400
X-MC-Unique: wmcmYxfjPsGXeSXDi1NrWA-1
Received: by mail-lf1-f71.google.com with SMTP id
 bt36-20020a056512262400b003fd7e6a96e8so2878232lfb.19
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 19:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ENeVT4EJ4HhfdzKw1adhLhObafui60u3kBaV6BSYZzQ=;
 b=iSBakFiDLESJBX4yC0hE2Ch68eztgSothYSOKgKehf1yGcKRN3NO0GspPMiSlyFYCg
 Ew2AL6U/KMzsVtshIJV8WVqQOPde4jCmQe6KQi1Im1EG+aW3Oq2TY4cZrLQ9w9i1P2m+
 xL2rEvicfnOeMxoIYCMZgQigygvjUWDcxJPJqBxGg/Q2dsICrxqUQBjJIL2L8Lp+r/Cv
 RfnqGdL/SmHLTObgQuXO9kLfhR7qRl0VhofBj3ypEwzVJt3OuGnmHGjc2iRIquutUsTx
 UNkCyyzx390AuYc6NnTpwuJgnFi1a7fAYCEaqVJEe3bgFDJpTm/wJ9cbRuC+LFmQga6u
 B5HA==
X-Gm-Message-State: AOAM530/MU7i9zm1un0+xnAhqU3r4Yj8SFUiYl2HbFCiAkNqjV6wmkBH
 DNakATlJw/2TLPwW7vxdAMpqhpRRwTgyBNryiez+14mLrgMiQkj8Gl1yBfe5lm/Yn0DVHEZ5BaM
 ljOUeOl/CcV3AJUGUV2qbHQEAV2KTfOW8O1kpWQfMGg0kVph9TTLtyNDfjA==
X-Received: by 2002:a05:6512:3d29:: with SMTP id
 d41mr12508869lfv.481.1633918019933; 
 Sun, 10 Oct 2021 19:06:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz14BTo20ifNpNLBzaLU+yNKHq7V7P/zv03+clH5xHZcu/iFJWoObufgdo9Yiy21rVk+IBUQO3NHQ409rBQPsA=
X-Received: by 2002:a05:6512:3d29:: with SMTP id
 d41mr12508845lfv.481.1633918019761; 
 Sun, 10 Oct 2021 19:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1632477717-5254-2-git-send-email-john.garry@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Oct 2021 10:06:48 +0800
Message-ID: <CACGkMEt8FcoJ4zMXFZzmrFjm=ynWfr5yLfvSHCckawpa3FvhkA@mail.gmail.com>
Subject: Re: [PATCH 1/5] iova: Move fast alloc size roundup into
 alloc_iova_fast()
To: John Garry <john.garry@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linuxarm@huawei.com,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, iommu@lists.linux-foundation.org,
 thunder.leizhen@huawei.com, Robin Murphy <robin.murphy@arm.com>,
 Lu Baolu <baolu.lu@linux.intel.com>
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

On Fri, Sep 24, 2021 at 6:07 PM John Garry <john.garry@huawei.com> wrote:
>
> It really is a property of the IOVA rcache code that we need to alloc a
> power-of-2 size, so relocate the functionality to resize into
> alloc_iova_fast(), rather than the callsites.
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/iommu/dma-iommu.c            | 8 --------
>  drivers/iommu/iova.c                 | 9 +++++++++
>  drivers/vdpa/vdpa_user/iova_domain.c | 8 --------
>  3 files changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 896bea04c347..a99b3445fef8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -444,14 +444,6 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>
>         shift = iova_shift(iovad);
>         iova_len = size >> shift;
> -       /*
> -        * Freeing non-power-of-two-sized allocations back into the IOVA caches
> -        * will come back to bite us badly, so we have to waste a bit of space
> -        * rounding up anything cacheable to make sure that can't happen. The
> -        * order of the unadjusted size will still match upon freeing.
> -        */
> -       if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> -               iova_len = roundup_pow_of_two(iova_len);
>
>         dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
>
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 9e8bc802ac05..ff567cbc42f7 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -497,6 +497,15 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
>         unsigned long iova_pfn;
>         struct iova *new_iova;
>
> +       /*
> +        * Freeing non-power-of-two-sized allocations back into the IOVA caches
> +        * will come back to bite us badly, so we have to waste a bit of space
> +        * rounding up anything cacheable to make sure that can't happen. The
> +        * order of the unadjusted size will still match upon freeing.
> +        */
> +       if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> +               size = roundup_pow_of_two(size);
> +
>         iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
>         if (iova_pfn)
>                 return iova_pfn;
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 1daae2608860..2b1143f11d8f 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -292,14 +292,6 @@ vduse_domain_alloc_iova(struct iova_domain *iovad,
>         unsigned long iova_len = iova_align(iovad, size) >> shift;
>         unsigned long iova_pfn;
>
> -       /*
> -        * Freeing non-power-of-two-sized allocations back into the IOVA caches
> -        * will come back to bite us badly, so we have to waste a bit of space
> -        * rounding up anything cacheable to make sure that can't happen. The
> -        * order of the unadjusted size will still match upon freeing.
> -        */
> -       if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> -               iova_len = roundup_pow_of_two(iova_len);
>         iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true);
>
>         return iova_pfn << shift;
> --
> 2.26.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
