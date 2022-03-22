Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E38C433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 16:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E37F140A7A;
	Tue, 22 Mar 2022 16:42:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uvB6pwTTI7WV; Tue, 22 Mar 2022 16:42:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 147B640463;
	Tue, 22 Mar 2022 16:42:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC2BCC001A;
	Tue, 22 Mar 2022 16:42:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AEC8C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 16:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B4D48483D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 16:42:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yiBp7rUIGiVh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 16:42:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 908B384828
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 16:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647967367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pbDUOeqShz33twUSi6DXosV6ZkPSPlcuLCDCl6mkuQM=;
 b=EYbTL9R7TnzKT4gsxy6tcAafTOhUMr7S7FMxuIAKKlHIA4Jyo+/lCPTTsOxbAlFBfBo++U
 UoL8E/Ap0Lrm1EMSFZ1rGLg8W5X280bsDJVXu0Cti95G//s1LXR/hUmkuKqywQmevlkT+Q
 ofPIg4XobF5WOvdhjk52Krn6DDNHBh4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-tAFHh75XN8iGRu-_PqG3NQ-1; Tue, 22 Mar 2022 12:42:44 -0400
X-MC-Unique: tAFHh75XN8iGRu-_PqG3NQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 p16-20020adfc390000000b00204006989c2so1529761wrf.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 09:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=pbDUOeqShz33twUSi6DXosV6ZkPSPlcuLCDCl6mkuQM=;
 b=oMHehBEj77xH+/5U11Wzdq2CpNuRZYh3FvGz1yTw4QeSoaxGzKEQzMOQVgW4Q06VY5
 6wnedFWpwE96W6cXUyQQZYmp85FVgybeG6eAjOopdqkj11HSTnaixY7rKXIdEjiFXrZb
 4LDQBPiQuzY+nT/J1AWcuicnEpo7Jjv9lmUoF+PewtX9I0jPUc3C4kRV/NCYfzrbXW0I
 TQ7+tLpxtFYRExJagx3822tEaDKKh+y2UalmxZ7po0HCLHIegqmKnO/u5rNx6BsmKA7Q
 7CXvYWgq2DPHbxmTwv4ZmjvtPBNSEj5zRoCd1/JYmiz4q+koIZ4t919en9e8zKd52liQ
 ztuQ==
X-Gm-Message-State: AOAM530QVTrSh6PK/1HCJNgVXjoPoQdpNjvpryW9Rp7im3Owmz2rxZR/
 AS+utia1gUU+8NEQqLYYFLHgmlAOXGttgUJU2lDOt3A3NRQ/PHQ3UwzmrXMf6SvB79DUj02HEVU
 trPzKm1MIgS/Qo/2CMlXNH03Bn/6xfjpU7wd4EdvQ4A==
X-Received: by 2002:adf:f192:0:b0:203:e38f:afa1 with SMTP id
 h18-20020adff192000000b00203e38fafa1mr22986513wro.120.1647967362977; 
 Tue, 22 Mar 2022 09:42:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd4H5zsnoSZNx8cpL6j2SFxZOQKMbrXPFzGhHlMfw61cH0xjGomBTtGVrnNwirsHukscpKkQ==
X-Received: by 2002:adf:f192:0:b0:203:e38f:afa1 with SMTP id
 h18-20020adff192000000b00203e38fafa1mr22986485wro.120.1647967362657; 
 Tue, 22 Mar 2022 09:42:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:de00:549e:e4e4:98df:ff72?
 (p200300cbc708de00549ee4e498dfff72.dip0.t-ipconnect.de.
 [2003:cb:c708:de00:549e:e4e4:98df:ff72])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a1cf30e000000b0038986a18ec8sm2243869wmq.46.2022.03.22.09.42.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Mar 2022 09:42:42 -0700 (PDT)
Message-ID: <a4c81f17-b32c-8873-ff73-a8729171e93f@redhat.com>
Date: Tue, 22 Mar 2022 17:42:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
To: Zi Yan <ziy@nvidia.com>
References: <20220317153733.2171277-1-zi.yan@sent.com>
 <20220317153733.2171277-3-zi.yan@sent.com>
 <44a512ba-1707-d9c7-7df3-b81af9b5f0fb@redhat.com>
 <3379379B-489B-460F-8B01-9A1D584A5036@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 2/5] mm: page_isolation: check specified range for
 unmovable pages
In-Reply-To: <3379379B-489B-460F-8B01-9A1D584A5036@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Mike Rapoport <rppt@kernel.org>, Eric Ren <renzhengeek@gmail.com>,
 Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>,
 Oscar Salvador <osalvador@suse.de>
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

On 21.03.22 19:23, Zi Yan wrote:
> On 21 Mar 2022, at 13:30, David Hildenbrand wrote:
> 
>> On 17.03.22 16:37, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> Enable set_migratetype_isolate() to check specified sub-range for
>>> unmovable pages during isolation. Page isolation is done
>>> at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
>>> pages within that granularity are intended to be isolated. For example,
>>> alloc_contig_range(), which uses page isolation, allows ranges without
>>> alignment. This commit makes unmovable page check only look for
>>> interesting pages, so that page isolation can succeed for any
>>> non-overlapping ranges.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  include/linux/page-isolation.h | 10 +++++
>>>  mm/page_alloc.c                | 13 +------
>>>  mm/page_isolation.c            | 69 ++++++++++++++++++++--------------
>>>  3 files changed, 51 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
>>> index e14eddf6741a..eb4a208fe907 100644
>>> --- a/include/linux/page-isolation.h
>>> +++ b/include/linux/page-isolation.h
>>> @@ -15,6 +15,16 @@ static inline bool is_migrate_isolate(int migratetype)
>>>  {
>>>  	return migratetype == MIGRATE_ISOLATE;
>>>  }
>>> +static inline unsigned long pfn_max_align_down(unsigned long pfn)
>>> +{
>>> +	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
>>> +}
>>> +
>>> +static inline unsigned long pfn_max_align_up(unsigned long pfn)
>>> +{
>>> +	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
>>> +}
>>> +
>>>  #else
>>>  static inline bool has_isolate_pageblock(struct zone *zone)
>>>  {
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 6de57d058d3d..680580a40a35 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -8937,16 +8937,6 @@ void *__init alloc_large_system_hash(const char *tablename,
>>>  }
>>>
>>>  #ifdef CONFIG_CONTIG_ALLOC
>>> -static unsigned long pfn_max_align_down(unsigned long pfn)
>>> -{
>>> -	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
>>> -}
>>> -
>>> -static unsigned long pfn_max_align_up(unsigned long pfn)
>>> -{
>>> -	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
>>> -}
>>> -
>>>  #if defined(CONFIG_DYNAMIC_DEBUG) || \
>>>  	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
>>>  /* Usage: See admin-guide/dynamic-debug-howto.rst */
>>> @@ -9091,8 +9081,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>>>  	 * put back to page allocator so that buddy can use them.
>>>  	 */
>>>
>>> -	ret = start_isolate_page_range(pfn_max_align_down(start),
>>> -				       pfn_max_align_up(end), migratetype, 0);
>>> +	ret = start_isolate_page_range(start, end, migratetype, 0);
>>>  	if (ret)
>>>  		return ret;
>>
>> Shouldn't we similarly adjust undo_isolate_page_range()? IOW, all users
>> of pfn_max_align_down()/pfn_max_align_up(). would be gone from that file
>> and you can move these defines into mm/page_isolation.c instead of
>> include/linux/page-isolation.h?
> 
> undo_isolate_page_range() faces much simpler situation, just needing
> to unset migratetype. We can just pass pageblock_nr_pages aligned range
> to it. For start_isolate_page_range(), start and end are also used for
> has_unmovable_pages() for precise unmovable page identification, so
> they cannot be pageblock_nr_pages aligned. But for readability and symmetry,
> yes, I can change undo_isolate_page_range() too.
Yeah, we should call both with the same range and any extension of the
range should be handled internally.

I thought about some corner cases, especially once we relax some (CMA)
alignment thingies -- then, the CMA area might be placed at weird
locations. I haven't checked to which degree they apply, but we should
certainly keep them in mind whenever we're extending the isolation range.

We can assume that the contig range we're allocation
a) Belongs to a single zone
b) Does not contain any memory holes / mmap holes

Let's double check


1) Different zones in extended range

...   ZONE A  ][ ZONE B ....
[ Pageblock X ][ Pageblock Y ][ Pageblock Z ]
[        MAX_ORDER - 1       ]

We can never create a higher-order page between X and Y, because they
are in different zones. Most probably we should *not* extend the range
to cover pageblock X in case the zones don't match.

The same consideration applies to the end of the range, when extending
the isolation range.

But I wonder if we can have such a zone layout. At least
mm/page_alloc.c:find_zone_movable_pfns_for_nodes() makes sure to always
align the start of ZONE_MOVABLE to MAX_ORDER_NR_PAGES. I hope it applies
to all other zones as well? :/

Anyhow, it should be easy to check when isolating/un-isolating. Only
conditionally extend the range if the zones of both pageblocks match.


When eventually growing MAX_ORDER_NR_PAGES further, could we be in
trouble because we could suddenly span multiple zones with a single
MAX_ORDER - 1 page? Then we'd have to handle that I guess.


2) mmap holes

I think that's already covered by the existing __first_valid_page()
handling.


So, I feel like we might have to tackle the zones issue, especially when
extending MAX_ORDER_NR_PAGES?

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
