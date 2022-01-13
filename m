Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B02C433EF
	for <virtualization@archiver.kernel.org>; Thu, 13 Jan 2022 12:28:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8EC3F404BB;
	Thu, 13 Jan 2022 12:28:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V-8JrtaJbO1O; Thu, 13 Jan 2022 12:28:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DEC6640124;
	Thu, 13 Jan 2022 12:28:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBE57C002F;
	Thu, 13 Jan 2022 12:28:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D8EBC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 12:28:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3991D84B67
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 12:28:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O8Egs1iUVvHs
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 12:28:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06ED984B5B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 12:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642076895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hnfVK2fyY9BtL+cahlLSPFYi/lDkJGG3ZpACsVHPbRc=;
 b=Ip5xELiBEHUKiYPVrIoC3pU9Z/VdsZP/Ndu+CaLS8NmmuiBVqmYRtTKxh3ZOzKgeBK4ZD9
 BXrdIpcfU8xyXxGzWOgybyIE+Y+4OksWe8NbK0Msw89j4cz5Y6M/+Ci7etCjwj3F2Hu668
 NWVtjvQupIg2STvodZ0P/ecMKizzKR4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-xLTKyTb4PfuHduIH3KJY6Q-1; Thu, 13 Jan 2022 07:28:14 -0500
X-MC-Unique: xLTKyTb4PfuHduIH3KJY6Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 g2-20020a056402424200b003f8ee03207eso5222682edb.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 04:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=hnfVK2fyY9BtL+cahlLSPFYi/lDkJGG3ZpACsVHPbRc=;
 b=GCu3xXoTMVFFKMZXSw+x80oVl4WCeYukmWEQaF7bTthaMSNax4fKDmAWazxYfBUOra
 JjsN7tMVZ+U5nP/nmJJQTpOsGAUE4o0VZ6418C1hc4atKRbPVP7IhvOEQ4BNOQwk3/el
 69HATy3lOorvnat0xASxZjVdaDGKo4dKdO1HTS7leHt1vCcKi2Jt1j92d3t5nLbaL+fc
 LdIMxOkiIJHBwNq+mDaSdhPf0XEwG8qaRB7XDT38Y0oVYGZe0kBQQn+tTfN6ZJWXaL4t
 O4l48z5UyveOb5CtUhtghD5d5OeCQFpegYCDyQ/owih8LE6EpgDQg7OMJQN5gGI1uffn
 dnvA==
X-Gm-Message-State: AOAM530kuWvcQ7ZAi5TjF7bngLa3t8NlEO4V5AXV8LlseVIMQA6GWAZ2
 8uwuFrKVwSeO1o2Zk4pqii9ZennLjpbyqOTKiKS63Lig7xEkoi2dQVqarlzqUD65H3IJhN91ium
 npAk8VWqDTkcZ82mBCVU+ZVQmrcEOW3RL6by3rqf4aw==
X-Received: by 2002:a50:8d16:: with SMTP id s22mr3857836eds.141.1642076893404; 
 Thu, 13 Jan 2022 04:28:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzDUme++gR+E7EfrqgLj1iyeR0r4RpB81KvaPod0mEHW3Q7ncqa9lY+1sUM8bAVvrgQ/bdNg==
X-Received: by 2002:a50:8d16:: with SMTP id s22mr3857806eds.141.1642076893116; 
 Thu, 13 Jan 2022 04:28:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:e200:8511:ed0f:ac2c:42f7?
 (p200300cbc703e2008511ed0fac2c42f7.dip0.t-ipconnect.de.
 [2003:cb:c703:e200:8511:ed0f:ac2c:42f7])
 by smtp.gmail.com with ESMTPSA id la21sm830830ejc.137.2022.01.13.04.28.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jan 2022 04:28:12 -0800 (PST)
Message-ID: <ae2862a0-c39c-ed2f-23fe-510c6c2fad5c@redhat.com>
Date: Thu, 13 Jan 2022 13:28:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 1/8] mm: page_alloc: avoid merging non-fallbackable
 pageblocks with others.
To: Mike Rapoport <rppt@kernel.org>
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-2-zi.yan@sent.com>
 <7dc078ef-70f4-159e-b928-34f0fb0ffaea@redhat.com>
 <YeAO0vtyjWWMRliF@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YeAO0vtyjWWMRliF@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Mel Gorman <mgorman@techsingularity.net>, Eric Ren <renzhengeek@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, Zi Yan <ziy@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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

On 13.01.22 12:36, Mike Rapoport wrote:
> On Wed, Jan 12, 2022 at 11:54:49AM +0100, David Hildenbrand wrote:
>> On 05.01.22 22:47, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.
>>> It prepares for the upcoming removal of the MAX_ORDER-1 alignment
>>> requirement for CMA and alloc_contig_range().
>>>
>>> MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
>>> MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.
>>> Also add MIGRARTE_HIGHATOMIC to fallbacks array for completeness.
>>>
>>> [1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.net/
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  include/linux/mmzone.h |  6 ++++++
>>>  mm/page_alloc.c        | 28 ++++++++++++++++++----------
>>>  2 files changed, 24 insertions(+), 10 deletions(-)
>>>
> 
> ...
> 
>>> @@ -3545,8 +3553,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
>>>  		struct page *endpage = page + (1 << order) - 1;
>>>  		for (; page < endpage; page += pageblock_nr_pages) {
>>>  			int mt = get_pageblock_migratetype(page);
>>> -			if (!is_migrate_isolate(mt) && !is_migrate_cma(mt)
>>> -			    && !is_migrate_highatomic(mt))
>>> +			/* Only change normal pageblock */
>>> +			if (migratetype_has_fallback(mt))
>>>  				set_pageblock_migratetype(page,
>>>  							  MIGRATE_MOVABLE);
>>>  		}
>>
>> That part is a nice cleanup IMHO. Although the "has fallback" part is a
>> bit imprecise. "migratetype_is_mergable()" might be a bit clearer.
>> ideally "migratetype_is_mergable_with_other_types()". Can we come up
>> with a nice name for that?
> 
> migratetype_is_mergable() kinda implies "_with_other_types", no?
> 
> I like migratetype_is_mergable() more than _has_fallback().
> 
> My $0.02 to bikeshedding :)

:)

Yeah, for me migratetype_is_mergable() would also be good enough. I
think I was at first thinking one could mistake it with a dedicated
migratetype. But such functions are historically called

is_migrate_cma/is_migrate_cma/....

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
