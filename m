Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16365C433EF
	for <virtualization@archiver.kernel.org>; Wed,  2 Feb 2022 12:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A935C41656;
	Wed,  2 Feb 2022 12:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uTGDqgIAAS2L; Wed,  2 Feb 2022 12:25:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6303241666;
	Wed,  2 Feb 2022 12:25:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48DCBC001A;
	Wed,  2 Feb 2022 12:25:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60B78C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 12:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 419B682951
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 12:25:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n74aTdtrMakm
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 12:25:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 37C72829FD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 12:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643804734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Riry/Ie+x1sinW7wNxc+GkihNaf8lfeZqesrgvEVnb0=;
 b=AqwCR030tDw/K0se68lSDFLy7TxWSXS61Pk250F0vlbsvHOiBevkhtedxrZox6J0gFxBGC
 tRS2I+3Cu9+BpMMT9QCwzVp2bhaYadXzeU+s5JSeEnNDTxEVhHd0ZlaXB/GCk5NG+wjrot
 Z9AsQb4NGz92hZbWb25DefHJ57qJsYo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-aEi33FlQM7eT43lC_XY8wg-1; Wed, 02 Feb 2022 07:25:31 -0500
X-MC-Unique: aEi33FlQM7eT43lC_XY8wg-1
Received: by mail-ej1-f71.google.com with SMTP id
 r18-20020a17090609d200b006a6e943d09eso8031929eje.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Feb 2022 04:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=Riry/Ie+x1sinW7wNxc+GkihNaf8lfeZqesrgvEVnb0=;
 b=pw30VrgioqcBcZ1xp1cJ7stF4cDJUVgtvh9HvceY5ILlOSdrm8JPm5Kcy0UX2tCuqK
 b2qzViOry6lsRgDq90/WlkA+z2/X6kUJmIUoKkLZTfhU5/AIWaogeggsIqdFWCF9CZa1
 ye8ymWohVG4jS+y6SOpvMOPNd45rBca6nO6i91EKLXl6arxIh3xZQF26bzYP7hlSr/+X
 +beGeilRMjQJgAlS2GLonlTZXP+br865oehhz6Yq3KzRDd555oitnyL1+TDNi88HKWg6
 n0+60zDaG8tMjFnnYWN+zL1ByOeSHFvJwXInHx0J8gtLOaRV75HZdxshvwd02C8bBmoz
 OKxg==
X-Gm-Message-State: AOAM531JcyLTmkx2Ar82cbRfrsCdscPTDwLEcJOlzTThryHwnqb1NEGD
 +hzpWYPNq5qhDFkVLiNux2RiBcTKxpMGr25/AG/lk4AchRtP0HLJLQF4ysiyJXALQFSRnJ41xaO
 jzbR7pl6s4SS3TfehI0mHVTPJsvxdJ9olsAor3Svopw==
X-Received: by 2002:a05:6402:7d0:: with SMTP id
 u16mr30060274edy.9.1643804730536; 
 Wed, 02 Feb 2022 04:25:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgTNVg4PsKEjgBZhYvXrFMFKGRSAUL0S3jbEcFB9ylZ3e4FOsTEFQdbkPIWl6zZX7rsjy0bA==
X-Received: by 2002:a05:6402:7d0:: with SMTP id
 u16mr30060236edy.9.1643804730176; 
 Wed, 02 Feb 2022 04:25:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:f800:a55c:e484:3cd9:3632?
 (p200300cbc709f800a55ce4843cd93632.dip0.t-ipconnect.de.
 [2003:cb:c709:f800:a55c:e484:3cd9:3632])
 by smtp.gmail.com with ESMTPSA id f6sm20889436edy.18.2022.02.02.04.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Feb 2022 04:25:29 -0800 (PST)
Message-ID: <21c196f8-18ca-d720-4241-00c9461854d3@redhat.com>
Date: Wed, 2 Feb 2022 13:25:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
To: Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>
References: <20220119190623.1029355-1-zi.yan@sent.com>
 <20220119190623.1029355-4-zi.yan@sent.com>
 <Yfp2rv0K6d3cNmwg@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 3/7] mm: page_isolation: check specified range for
 unmovable pages
In-Reply-To: <Yfp2rv0K6d3cNmwg@localhost.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Mel Gorman <mgorman@techsingularity.net>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Eric Ren <renzhengeek@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, Vlastimil Babka <vbabka@suse.cz>,
 Marek Szyprowski <m.szyprowski@samsung.com>
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

On 02.02.22 13:18, Oscar Salvador wrote:
> On Wed, Jan 19, 2022 at 02:06:19PM -0500, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Enable set_migratetype_isolate() to check specified sub-range for
>> unmovable pages during isolation. Page isolation is done
>> at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
>> pages within that granularity are intended to be isolated. For example,
>> alloc_contig_range(), which uses page isolation, allows ranges without
>> alignment. This commit makes unmovable page check only look for
>> interesting pages, so that page isolation can succeed for any
>> non-overlapping ranges.
> 
> Another thing that came to my mind.
> Prior to this patch, has_unmovable_pages() was checking on pageblock
> granularity, starting at pfn#0 of the pageblock.
> With this patch, you no longer check on pageblock granularity, which
> means you might isolate a pageblock, but some pages that sneaked in
> might actually be unmovable.
> 
> E.g:
> 
> Let's say you have a pageblock that spans (pfn#512,pfn#1024),
> and you pass alloc_contig_range() (pfn#514,pfn#1024).
> has_unmovable_pages() will start checking the pageblock at pfn#514,
> and so it will mis pfn#512 and pfn#513. Isn't that a problem, if those
> pfn turn out to be actually unmovable?

That's the whole idea for being able to allocate parts of an unmovable
pageblock that are movable.

If the first part is unmovable but the second part is movable, nothing
should stop us from trying to allocate the second part.

Of course, we want to remember the original migratetype of the
pageblock, to restore that after isolation -- otherwise we'll end up
converting all such pageblocks to MIGRATE_MOVABLE. The next patch does
that IIRC.

However, devil is in the detail, and I still have to review those parts
of this series.


Note that there are no current users of alloc_contig_range() that
allocate < MAX_ORDER - 1 -- except CMA, but for CMA we immediately exit
has_unmovable_pages() either way.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
