Return-Path: <SRS0=Mct1=QD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22352C433EF
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 08:58:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FD763212
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 08:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3FD763212
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 874DF401DB;
	Tue, 16 Nov 2021 08:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QZnINKMcLeaG; Tue, 16 Nov 2021 08:58:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F2DF4402CB;
	Tue, 16 Nov 2021 08:58:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73CFBC0033;
	Tue, 16 Nov 2021 08:58:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94F2CC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 08:58:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52801403F8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 08:58:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lgWQnjX0Vcyz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 08:58:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 83062400C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 08:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637053108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4284vAzYHLAxGcEEtHPUG4T3Bgo3Ms3nj1In/yM7t9U=;
 b=RilFCKKXJ+OsMz9k9GYBNHcHPqIPDy3vcSUG/1H52dpUpziF4YQFgvtTByCC8FlWxL/bmB
 3qxPjHJ3wVtq6DI/QSjoHJoB4qmZw1DbCMQhlAZfqAC6sXRgeJfpgVSNxvgyGSnq6oZlhA
 YeMaSXIUCBezI+YIy8pWcnoJCrBOnBs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-7eT500dPP7y2AegKoituSA-1; Tue, 16 Nov 2021 03:58:26 -0500
X-MC-Unique: 7eT500dPP7y2AegKoituSA-1
Received: by mail-wm1-f70.google.com with SMTP id
 144-20020a1c0496000000b003305ac0e03aso900141wme.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 00:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=4284vAzYHLAxGcEEtHPUG4T3Bgo3Ms3nj1In/yM7t9U=;
 b=a7m5cISSb9Ec/ABUcGOwNXv+OlKq/ir6QBlm5TuhSeKwqdxu34RfbJ7ygK2z2fAIGo
 LvddSunFc++qOm4KOxOXxlI1Go8h9VrcOIYqf26Ggou/aMre40wmQ9+35NmT120c/BJ9
 F9dG64lHVpr9Oa50nzie7ky3kWdMWmcVEJwNE3GYiTLTX3L6fIXwvjGD55t15aSmkN5I
 YP/zTmyKkok36/5NQR2TBvq+2R/ZL/nROp+PKroKnQiU8+vDy8qnaNvBLo5IKuWWTaHK
 XQjbFewZhd19ofb1EZyAcEK+2wRh/eBmvgJGvnQbcFzjXM+6aSP5QER2h2E7xoe3lDVX
 jCkw==
X-Gm-Message-State: AOAM531DUBA1DLhZ4iB0fPmu39KHn08k4GBXQqhAA/1RJ0lLcHNSiMQN
 sqPVSCSpW2oMYylc4TAPWBz7CRYukxIosMRx7OXhM2m/LEWfmJpL5T1owawB3qW71py+kvh7ctx
 OFDrEtNnf3dPcBwsd0WiQFYDnsghGhuxysDGynKVWTw==
X-Received: by 2002:adf:e8c8:: with SMTP id k8mr7111280wrn.135.1637053105661; 
 Tue, 16 Nov 2021 00:58:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNnhYnmoiEKmhWbgITaAMbH06RYzALBRVXN/xZ5keEiGtxNnsHeJdzCkwXHAfqWjFKt7cxCw==
X-Received: by 2002:adf:e8c8:: with SMTP id k8mr7111233wrn.135.1637053105277; 
 Tue, 16 Nov 2021 00:58:25 -0800 (PST)
Received: from [192.168.3.132] (p4ff23d3a.dip0.t-ipconnect.de. [79.242.61.58])
 by smtp.gmail.com with ESMTPSA id
 r17sm2015005wmq.11.2021.11.16.00.58.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Nov 2021 00:58:24 -0800 (PST)
Message-ID: <d19fb078-cb9b-f60f-e310-fdeea1b947d2@redhat.com>
Date: Tue, 16 Nov 2021 09:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20211115193725.737539-1-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/3] Use pageblock_order for cma and
 alloc_contig_range alignment.
In-Reply-To: <20211115193725.737539-1-zi.yan@sent.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
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

On 15.11.21 20:37, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi David,

Hi,

thanks for looking into this.

> 
> You suggested to make alloc_contig_range() deal with pageblock_order instead of
> MAX_ORDER - 1 and get rid of MAX_ORDER - 1 dependency in virtio_mem[1]. This
> patchset is my attempt to achieve that. Please take a look and let me know if
> I am doing it correctly or not.
> 
> From what my understanding, cma required alignment of
> max(MAX_ORDER - 1, pageblock_order), because when MIGRATE_CMA was introduced,
> __free_one_page() does not prevent merging two different pageblocks, when
> MAX_ORDER - 1 > pageblock_order. But current __free_one_page() implementation
> does prevent that. It should be OK to just align cma to pageblock_order.
> alloc_contig_range() relies on MIGRATE_CMA to get free pages, so it can use
> pageblock_order as alignment too.

I wonder if that's sufficient. Especially the outer_start logic in
alloc_contig_range() might be problematic. There are some ugly corner
cases with free pages/allocations spanning multiple pageblocks and we
only isolated a single pageblock.


Regarding CMA, we have to keep the following cases working:

a) Different pageblock types (MIGRATE_CMA and !MIGRATE_CMA) in MAX_ORDER
   - 1 page:
   [       MAX_ ORDER - 1     ]
   [ pageblock 0 | pageblock 1]

Assume either pageblock 0 is MIGRATE_CMA or pageblock 1 is MIGRATE_CMA,
but not both. We have to make sure alloc_contig_range() keeps working
correctly. This should be the case even with your change, as we won't
merging pages accross differing migratetypes.

b) Migrating/freeing a MAX_ ORDER - 1 page while partially isolated:
   [       MAX_ ORDER - 1     ]
   [ pageblock 0 | pageblock 1]

Assume both are MIGRATE_CMA. Assume we want to either allocate from
pageblock 0 or pageblock 1. Especially, assume we want to allocate from
pageblock 1. While we would isolate pageblock 1, we wouldn't isolate
pageblock 0.

What happens if we either have a free page spanning the MAX_ORDER - 1
range already OR if we have to migrate a MAX_ORDER - 1 page, resulting
in a free MAX_ORDER - 1 page of which only the second pageblock is
isolated? We would end up essentially freeing a page that has mixed
pageblocks, essentially placing it in !MIGRATE_ISOLATE free lists ... I
might be wrong but I have the feeling that this would be problematic.

c) Concurrent allocations:
    [       MAX_ ORDER - 1     ]
    [ pageblock 0 | pageblock 1]

Assume b) but we have two concurrent CMA allocations to pageblock 0 and
pageblock 1, which would now be possible as start_isolate_page_range()
isolate would succeed on both.


Regarding virtio-mem, we care about the following cases:

a) Allocating parts from completely movable MAX_ ORDER - 1 page:
   [       MAX_ ORDER - 1     ]
   [ pageblock 0 | pageblock 1]

Assume pageblock 0 and pageblock 1 are either free or contain only
movable pages. Assume we allocated pageblock 0. We have to make sure we
can allocate pageblock 1. The other way around, assume we allocated
pageblock 1, we have to make sure we can allocate pageblock 0.

Free pages spanning both pageblocks might be problematic.

b) Allocate parts of partially movable MAX_ ORDER - 1 page:
   [       MAX_ ORDER - 1     ]
   [ pageblock 0 | pageblock 1]

Assume pageblock 0 contains unmovable data but pageblock 1 not: we have
to make sure we can allocate pageblock 1. Similarly, assume pageblock 1
contains unmovable data but pageblock 0 no: we have to make sure we can
allocate pageblock 1. has_unmovable_pages() might allow for that.

But, we want to fail early in case we want to allocate a single
pageblock but it contains unmovable data. This could be either directly
or indirectly.

If we have an unmovable (compound) MAX_ ORDER - 1 and we'd try isolating
pageblock 1, has_unmovable_pages() would always return "false" because
we'd simply be skiping over any tail pages, and not detect the
un-movability.

c) Migrating/freeing a MAX_ ORDER - 1 page while partially isolated:

Same concern as for CMA b)


So the biggest concern I have is dealing with migrating/freeing >
pageblock_order pages while only having isolated a single pageblock.

> 
> In terms of virtio_mem, if I understand correctly, it relies on
> alloc_contig_range() to obtain contiguous free pages and offlines them to reduce
> guest memory size. As the result of alloc_contig_range() alignment change,
> virtio_mem should be able to just align PFNs to pageblock_order.

For virtio-mem it will most probably be desirable to first try
allocating the MAX_ORDER -1 range if possible and then fallback to
pageblock_order. But that's an additional change on top in virtio-mem code.



My take to teach alloc_contig_range() to properly handle would be the
following:

a) Convert MIGRATE_ISOLATE into a separate pageblock flag

We would want to convert MIGRATE_ISOLATE into a separate pageblock
flags, such that when we isolate a page block we preserve the original
migratetype. While start_isolate_page_range() would set that bit,
undo_isolate_page_range() would simply clear that bit. The buddy would
use a single MIGRATE_ISOLATE queue as is: the original migratetype is
only used for restoring the correct migratetype. This would allow for
restoring e.g., MIGRATE_UNMOVABLE after isolating an unmovable pageblock
(below) and not simply setting all such pageblocks to MIGRATE_MOVABLE
when un-isolating.

Ideally, we'd get rid of the "migratetype" parameter for
alloc_contig_range(). However, even with the above change we have to
make sure that memory offlining and ordinary alloc_contig_range() users
will fail on MIGRATE_CMA pageblocks (has_unmovable_page() checks that as
of today). We could achieve that differently, though (e.g., bool
cma_alloc parameter instead).


b) Allow isolating pageblocks with unmovable pages

We'd pass the actual range of interest to start_isolate_page_range() and
rework the code to check has_unmovable_pages() only on the range of
interest, but considering overlapping larger allocations. E.g., if we
stumble over a compound page, lookup the head an test if that page is
movable/unmovable.

c) Change alloc_contig_range() to not "extend" the range of interest to
include pageblock of different type. Assume we're isolating a
MIGRATE_CMA pageblock, only isolate a neighboring MIGRATE_CMA pageblock,
not other pageblocks.


So we'd keep isolating complete MAX_ORDER - 1 pages unless c) prevents
it. We'd allow isolating even pageblocks that contain unmovable pages on
ZONE_NORMAL, and check via has_unmovable_pages() only if the range of
interest contains unmovable pages, not the whole MAX_ORDER -1 range or
even the whole pageblock. We'd not silently overwrite the pageblock type
when restoring but instead restore the old migratetype.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
