Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3353C433F5
	for <virtualization@archiver.kernel.org>; Fri, 10 Dec 2021 18:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EDEA426C2;
	Fri, 10 Dec 2021 18:36:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kg0yeROCwTyL; Fri, 10 Dec 2021 18:36:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1D274426C0;
	Fri, 10 Dec 2021 18:36:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0D09C001E;
	Fri, 10 Dec 2021 18:36:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78D56C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 18:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5AAAA426C0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 18:36:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id THwHu98AtOL3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 18:36:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87BC9426BE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 18:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639161392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UuZMXUxnRYoJ6fczszwwZGhWUdbXILWisTJH5f1GF3o=;
 b=h6NhXiAshx8h8AMhcEyh3d83NUqUTc3SmcpEn9D/1fotKZTJDAhrUEBFZcmGXn6gJtY7jh
 4VQ4adoG4pSeupPe7G/RAT8PRGQgHnzvhDOqQIjGMkSPxM30LQTBlDb7kUrbJpVjbvmEa5
 1cTohojE+8jZ45ix+/DCBS4+vG0nGNo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-pklioMshPNixHZwcqleqpA-1; Fri, 10 Dec 2021 13:36:31 -0500
X-MC-Unique: pklioMshPNixHZwcqleqpA-1
Received: by mail-wm1-f69.google.com with SMTP id
 l6-20020a05600c4f0600b0033321934a39so4072544wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 10:36:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=UuZMXUxnRYoJ6fczszwwZGhWUdbXILWisTJH5f1GF3o=;
 b=5W949eHKcI/ggTsQXT85sQRSdM61BtuLBgYpZoQscQscaXX8DHVCeqgNfJc3EqeZ3l
 6Rh+Vhmh99CuBNZ2rnPLN59rumBNyhmTbZIgiOHgoNs2uBBK9M45QPCm/Y2EPeXCN7gC
 p7XWJvfc6Kqu6jxFIFuYqgavCsN5vgv3UAThtJaKroCYEdg1nd9lE5xrdPmSfdTq5VKr
 gWAGzngcESZau4/HbxNng42pEdFJBCTRw3NrDgiHX1eeZjlswuB5neHXAjXR2dZanmB2
 wVQZdP/F4HPh3dIsSEkYb1ZF0Zfv7b8UyfZjDN2sXj8JAhMBq6A91fe+wyrghnKrAtXd
 osGQ==
X-Gm-Message-State: AOAM532aiCQdgPo3V5ZJVFOTViFEd1Q/4SP2ZDx+/Eh29QnPO8cO3237
 l+FseZZq+5OGnrF2uIjJTqgW/GQ9HB6k7mQx/lvSgfSifDFstkdu5eZugBM/a4rSzhoJu1E2SSg
 lEr4Ruo3aJvS+BoM3aDkHGSSlHiQp8PaoHhrjI8FhiA==
X-Received: by 2002:a1c:2397:: with SMTP id
 j145mr18630577wmj.113.1639161389972; 
 Fri, 10 Dec 2021 10:36:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnE6mECpT6/x+6acEXXbzAagez4dMgCo4uhwD9w2DwYFQ/4FPaugRFXQx4gh8a1gwW+xf9tQ==
X-Received: by 2002:a1c:2397:: with SMTP id
 j145mr18630532wmj.113.1639161389702; 
 Fri, 10 Dec 2021 10:36:29 -0800 (PST)
Received: from [192.168.3.132] (p5b0c60f8.dip0.t-ipconnect.de. [91.12.96.248])
 by smtp.gmail.com with ESMTPSA id
 v8sm3098510wrd.84.2021.12.10.10.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Dec 2021 10:36:29 -0800 (PST)
Message-ID: <19404189-3bee-c02a-a596-2e5564e0f8f5@redhat.com>
Date: Fri, 10 Dec 2021 19:36:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH v2 0/7] Use pageblock_order for cma and
 alloc_contig_range alignment.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20211209230414.2766515-1-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211209230414.2766515-1-zi.yan@sent.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Mel Gorman <mgorman@techsingularity.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Eric Ren <renzhengeek@gmail.com>, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Vlastimil Babka <vbabka@suse.cz>, Marek Szyprowski <m.szyprowski@samsung.com>
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

On 10.12.21 00:04, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,

Hi,

thanks for working on that!

> 
> This patchset tries to remove the MAX_ORDER - 1 alignment requirement for CMA
> and alloc_contig_range(). It prepares for my upcoming changes to make MAX_ORDER
> adjustable at boot time[1].
> 
> The MAX_ORDER - 1 alignment requirement comes from that alloc_contig_range()
> isolates pageblocks to remove free memory from buddy allocator but isolating
> only a subset of pageblocks within a page spanning across multiple pageblocks
> causes free page accounting issues. Isolated page might not be put into the
> right free list, since the code assumes the migratetype of the first pageblock
> as the whole free page migratetype. This is based on the discussion at [2].
> 
> To remove the requirement, this patchset:
> 1. still isolates pageblocks at MAX_ORDER - 1 granularity;
> 2. but saves the pageblock migratetypes outside the specified range of
>    alloc_contig_range() and restores them after all pages within the range
>    become free after __alloc_contig_migrate_range();
> 3. splits free pages spanning multiple pageblocks at the beginning and the end
>    of the range and puts the split pages to the right migratetype free lists
>    based on the pageblock migratetypes;
> 4. returns pages not in the range as it did before this patch.
> 
> Isolation needs to happen at MAX_ORDER - 1 granularity, because otherwise
> 1) extra code is needed to detect pages (free, PageHuge, THP, or PageCompound)
> to make sure all pageblocks belonging to a single page are isolated together 
> and later pageblocks outside the range need to have their migratetypes restored;
> or 2) extra logic will need to be added during page free time to split a free
> page with multi-migratetype pageblocks.
> 
> Two optimizations might come later:
> 1. only check unmovable pages within the range instead of MAX_ORDER - 1 aligned
>    range during isolation to increase successful rate of alloc_contig_range().

The issue with virtio-mem is that we'll need that as soon as we change
the granularity to pageblocks, because otherwise, you can heavily
degrade unplug reliably in sane setups:

Previous:
* Try unplug free 4M range (2 pageblocks): succeeds

Now:
* Try unplug 2M range (first pageblock): succeeds.
* Try unplug next 2M range (second pageblock): fails because first
contains unmovable allcoations.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
