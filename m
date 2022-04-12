Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0196C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 15:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55B7E416E9;
	Tue, 12 Apr 2022 15:06:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C9-FC1ewB5LU; Tue, 12 Apr 2022 15:06:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4E3F640994;
	Tue, 12 Apr 2022 15:06:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1988FC0033;
	Tue, 12 Apr 2022 15:06:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B06CDC002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 15:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D2E5409EE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 15:06:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LMJk9D7UfG83
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 15:06:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46B4340994
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 15:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649775970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcMg4A6w1yZzg9wuJ8koxUDNZ+ppyVYaFpMl0UYBBWU=;
 b=gYQRy7lnKGUmRYZQvr8N2Yjf7jS6x0Z72BhOIuMFt4eS48JXLntTIt7ftF6vJSPCAa5Sch
 sxqC8B9G/eJL1KFTbLqKAVs33dw7k6nGGOrZpfPp9EQverq49LOrpaiIbP50aL+IbZZuO4
 m+2cLPmtWsWQvN5dxHBKY9B0splgv/A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-VAC8CjSgO1qfJGQrHgiRXQ-1; Tue, 12 Apr 2022 11:06:04 -0400
X-MC-Unique: VAC8CjSgO1qfJGQrHgiRXQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 46-20020adf8031000000b00207ad3febaeso564586wrk.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 08:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=XcMg4A6w1yZzg9wuJ8koxUDNZ+ppyVYaFpMl0UYBBWU=;
 b=AnnunQWxSgl19Tiz9bn7ZKFYoMirQ5xBcORMvoQXn7zmMxC8cWyx32N0zRTCbf4ky9
 FZGETE9Td+k9LKX9QfOtb0U+a8UOaUFWTiCaHjBVYrAxDP4WyaC0yWMIH5ZX8mWoanEj
 NzVtkHt0+HHx7sQKvimjkMZmpEtAYqCi1JnqW2lxLzTaJMDu9Tb18I8jRVFvd6EN2s8p
 WMWtpG2raHxnrYBJ0C6a70GS7NvUuYIv0IvZOcllk1z2o7C+TERnZmKn+ABXtreh7hJP
 an81kESOH3tT26Beof+jVdrJkRczynKXCRIC+oz/4mCKxiVyBu8so5snNqVLwrqUbeEl
 Wr/g==
X-Gm-Message-State: AOAM5307BqWP0p/EG6roBSc8m2QRgKhdxHU0Ql/28qN2vpRT0/tgQhjF
 ivn8aJhNjilJjRjDpkn+gxQ/5CNy1xtcAiXMPODf2gpuKqKeyTJypJ5O6u1A3Kv0e1MDcPhyqQY
 +ivhzFKYpMKvdopJlxV7GAQ5rF+1HGP02T9RlAYV0Gg==
X-Received: by 2002:adf:c188:0:b0:1e6:8ecb:ea5a with SMTP id
 x8-20020adfc188000000b001e68ecbea5amr28432440wre.711.1649775963502; 
 Tue, 12 Apr 2022 08:06:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUf6mPkR4HTFyBmy700+AFHseZaInznKf5AOScugwmvW/0QoMnFDweHlOBb+4v1i50K+KUow==
X-Received: by 2002:adf:c188:0:b0:1e6:8ecb:ea5a with SMTP id
 x8-20020adfc188000000b001e68ecbea5amr28432412wre.711.1649775963050; 
 Tue, 12 Apr 2022 08:06:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1800:7c14:16cc:5291:a9f3?
 (p200300cbc70718007c1416cc5291a9f3.dip0.t-ipconnect.de.
 [2003:cb:c707:1800:7c14:16cc:5291:a9f3])
 by smtp.gmail.com with ESMTPSA id
 7-20020a05600c024700b0038ec0c4a2e7sm2522715wmj.11.2022.04.12.08.06.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 08:06:02 -0700 (PDT)
Message-ID: <afa115e6-d2ae-eeff-ba31-f8b2a5715b95@redhat.com>
Date: Tue, 12 Apr 2022 17:06:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v10 2/5] mm: page_isolation: check specified range for
 unmovable pages
To: Zi Yan <ziy@nvidia.com>
References: <20220406151858.3149821-1-zi.yan@sent.com>
 <20220406151858.3149821-3-zi.yan@sent.com>
 <ccae12f9-a452-95a8-f404-3398dcdf5bdf@redhat.com>
 <039317AF-985C-43D7-BB99-714DD6022B5C@nvidia.com>
 <428828e1-6b59-8db7-62e0-1429863cb13f@redhat.com>
 <B4336C2E-E728-49E2-B84B-5728B9A1EA69@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <B4336C2E-E728-49E2-B84B-5728B9A1EA69@nvidia.com>
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

On 12.04.22 17:01, Zi Yan wrote:
> On 12 Apr 2022, at 10:49, David Hildenbrand wrote:
> 
>> On 12.04.22 16:07, Zi Yan wrote:
>>> On 12 Apr 2022, at 9:10, David Hildenbrand wrote:
>>>
>>>> On 06.04.22 17:18, Zi Yan wrote:
>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>
>>>>> Enable set_migratetype_isolate() to check specified sub-range for
>>>>> unmovable pages during isolation. Page isolation is done
>>>>> at MAX_ORDER_NR_PAEGS granularity, but not all pages within that
>>>>> granularity are intended to be isolated. For example,
>>>>> alloc_contig_range(), which uses page isolation, allows ranges without
>>>>> alignment. This commit makes unmovable page check only look for
>>>>> interesting pages, so that page isolation can succeed for any
>>>>> non-overlapping ranges.
>>>>>
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>>  /*
>>>>> - * This function checks whether pageblock includes unmovable pages or not.
>>>>> + * This function checks whether the range [start_pfn, end_pfn) includes
>>>>> + * unmovable pages or not. The range must fall into a single pageblock and
>>>>> + * consequently belong to a single zone.
>>>>>   *
>>>>>   * PageLRU check without isolation or lru_lock could race so that
>>>>>   * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
>>>>> @@ -28,12 +30,14 @@
>>>>>   * cannot get removed (e.g., via memory unplug) concurrently.
>>>>>   *
>>>>>   */
>>>>> -static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>>> -				 int migratetype, int flags)
>>>>> +static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long end_pfn,
>>>>> +				int migratetype, int flags)
>>>>>  {
>>>>> -	unsigned long iter = 0;
>>>>> -	unsigned long pfn = page_to_pfn(page);
>>>>> -	unsigned long offset = pfn % pageblock_nr_pages;
>>>>> +	unsigned long pfn = start_pfn;
>>>>> +	struct page *page = pfn_to_page(pfn);
>>>>
>>>>
>>>> Just do
>>>>
>>>> struct page *page = pfn_to_page(start_pfn);
>>>> struct zone *zone = page_zone(page);
>>>>
>>>> here. No need to lookup the zone again in the loop because, as you
>>>> document "must ... belong to a single zone.".
>>>>
>>>> Then, there is also no need to initialize "pfn" here. In the loop header
>>>> is sufficient.
>>>>
>>>
>>> Sure.
>>>
>>>>> +
>>>>> +	VM_BUG_ON(ALIGN_DOWN(start_pfn, pageblock_nr_pages) !=
>>>>> +		  ALIGN_DOWN(end_pfn - 1, pageblock_nr_pages));
>>>>>
>>>>>  	if (is_migrate_cma_page(page)) {
>>>>>  		/*
>>>>> @@ -47,8 +51,11 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>>>  		return page;
>>>>>  	}
>>>>>
>>>>> -	for (; iter < pageblock_nr_pages - offset; iter++) {
>>>>> -		page = pfn_to_page(pfn + iter);
>>>>> +	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>>>>> +		struct zone *zone;
>>>>> +
>>>>> +		page = pfn_to_page(pfn);
>>>>> +		zone = page_zone(page);
>>>>>
>>>>>  		/*
>>>>>  		 * Both, bootmem allocations and memory holes are marked
>>>>> @@ -85,7 +92,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>>>  			}
>>>>>
>>>>>  			skip_pages = compound_nr(head) - (page - head);
>>>>> -			iter += skip_pages - 1;
>>>>> +			pfn += skip_pages - 1;
>>>>>  			continue;
>>>>>  		}
>>>>>
>>>>> @@ -97,7 +104,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>>>  		 */
>>>>>  		if (!page_ref_count(page)) {
>>>>>  			if (PageBuddy(page))
>>>>> -				iter += (1 << buddy_order(page)) - 1;
>>>>> +				pfn += (1 << buddy_order(page)) - 1;
>>>>>  			continue;
>>>>>  		}
>>>>>
>>>>> @@ -134,11 +141,18 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>>>>>  	return NULL;
>>>>>  }
>>>>>
>>>>> -static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
>>>>> +/*
>>>>> + * This function set pageblock migratetype to isolate if no unmovable page is
>>>>> + * present in [start_pfn, end_pfn). The pageblock must intersect with
>>>>> + * [start_pfn, end_pfn).
>>>>> + */
>>>>> +static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags,
>>>>> +			unsigned long start_pfn, unsigned long end_pfn)
>>>>
>>>> I think we might be able do better, eventually not passing start_pfn at
>>>> all. Hmm.
>>>
>>> IMHO, having start_pfn and end_pfn in the parameter list would make the
>>> interface easier to understand. Otherwise if we remove start_pfn,
>>> the caller needs to adjust @page to be within the range of [start_pfn,
>>> end_pfn)
>>>
>>>>
>>>> I think we want to pull out the
>>>> start_isolate_page_range()/undo_isolate_page_range() interface change
>>>> into a separate patch.
>>>
>>> You mean a patch just adding
>>>
>>> unsigned long isolate_start = pfn_max_align_down(start_pfn);
>>> unsigned long isolate_end = pfn_max_align_up(end_pfn);
>>>
>>> in start_isolate_page_range()/undo_isolate_page_range()?
>>>
>>> Yes I can do that.
>>
>> I think we have to be careful with memory onlining/offlining. There are
>> corner cases where we get called with only pageblock alignment and
>> must not adjust the range.
> 
> In the patch below, you added a new set of start_isolate_pageblocks()
> and undo_isolate_pageblocks(), where start_isolate_pageblocks() still
> calls set_migratetype_isolate() and noted their range should not be
> adjusted. But in my patch, set_migratetype_isolate() adjusts
> the range for has_unmovable_pages() check. Do you mean

Right, that's broken in your patch. Memory onlining/offlining behavior
changed recently when "vmemmap on memory" was added. The start range
might only be aligned to pageblocks but not MAX_ORDER -1 -- and we must
not align u..

The core thing is that there are two types of users: memory offlining
that knows what it's doing when it aligns to less then MAX_ORDER -1 ,
and range allocators, that just pass in the range of interest.

> start_isolate_pageblocks() should call a different version of
> set_migratetype_isolate() without range adjustment? That can be done
> with an additional parameter in start_isolate_page_range(), like
> bool strict, right?

Random boolean flags are in general frowned upon ;)

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
