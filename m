Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90F0C433EF
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 10:54:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0E0583E8C;
	Wed, 12 Jan 2022 10:54:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ct3aAu0UtTeq; Wed, 12 Jan 2022 10:54:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 324AA83F5D;
	Wed, 12 Jan 2022 10:54:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E066AC0030;
	Wed, 12 Jan 2022 10:54:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32391C001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 10:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0AEFC409A9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 10:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fkfTz6dxzLtc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 10:54:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A90D40169
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 10:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641984893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1nXDaBEqSwcubb9UAlItnBJ/49dksDZCXM8chYBVKNM=;
 b=eaOidEo6xZ3TEaF50RWiokNJKpMsPxk2vRYtsgJI6pAwkcpJ/8nwbE1TBOygi293chaXaK
 GCwKWV2vyZDvtetMzX6yS0Ef7tCsOEqM9XAVnzIRjCUGLHeiFmZt2ep/7mqA8o4+NRTn9C
 X8eBduQyEzvTi7y6JkFep/IDPJ95giI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-sqIJPIFXNwGmHSeF9_4mRw-1; Wed, 12 Jan 2022 05:54:52 -0500
X-MC-Unique: sqIJPIFXNwGmHSeF9_4mRw-1
Received: by mail-ed1-f72.google.com with SMTP id
 s7-20020a056402520700b003f841380832so1941871edd.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=1nXDaBEqSwcubb9UAlItnBJ/49dksDZCXM8chYBVKNM=;
 b=y5mg63TgNmydnF6PSinLmh7ZzT9egXjhvp/MvcKNFIQTE/ipuVLPBfVlLeJOxWW4jo
 5WIuJwllRKyxTIgDg95TYl4xFDqnLZotQ69ldKjbQDUJWLh5ytf1SgT9gcVEqhCOgcIn
 FHUnn1xj1IDPISMQUurIPSThgsqnt2wfymEwXxzrtkmCHgriig0gcE0vSiINx5Yalr8B
 CWxdQlVnymwrWoMOd9sYjnI2PH3g+w6MeEpMllD7CXUwHDBwLYwywRKrKddmiYS5aHzK
 yDNs8y8g1JsD7NXfDGB3zSEAn0uDn5YHghUwBxyVr+HxObiBXWmUa0aMWizMacYvGMEj
 4bGg==
X-Gm-Message-State: AOAM53170FKUmSM2hXwhWY/C0ZqBvzRncsCzGaAJlevxbS0v6KUdhraz
 qh3v2YYBfxk1oPZcr6ieKrJ5YdVT2pMg+KgMRWfwgswUPmMsfCTzx/rdHds/UFblIqWynqo5cmZ
 F/W/isvm7eOI7sNvAiQQ6yX7v5vF9IsrUJs7NEx1sCA==
X-Received: by 2002:a17:906:3052:: with SMTP id
 d18mr7112124ejd.675.1641984891159; 
 Wed, 12 Jan 2022 02:54:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyn5fswqQ0dOEoBSWPUJo6KSN9+8h4kCBAhgFotHJOoSPil79OW088szvXQNfhv7fsGVeMxSQ==
X-Received: by 2002:a17:906:3052:: with SMTP id
 d18mr7112100ejd.675.1641984890940; 
 Wed, 12 Jan 2022 02:54:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:4700:e25f:39eb:3cb8:1dec?
 (p200300cbc7024700e25f39eb3cb81dec.dip0.t-ipconnect.de.
 [2003:cb:c702:4700:e25f:39eb:3cb8:1dec])
 by smtp.gmail.com with ESMTPSA id hc40sm1981993ejc.72.2022.01.12.02.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jan 2022 02:54:50 -0800 (PST)
Message-ID: <7dc078ef-70f4-159e-b928-34f0fb0ffaea@redhat.com>
Date: Wed, 12 Jan 2022 11:54:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-2-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v3 1/8] mm: page_alloc: avoid merging non-fallbackable
 pageblocks with others.
In-Reply-To: <20220105214756.91065-2-zi.yan@sent.com>
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

On 05.01.22 22:47, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.
> It prepares for the upcoming removal of the MAX_ORDER-1 alignment
> requirement for CMA and alloc_contig_range().
> 
> MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
> MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.
> Also add MIGRARTE_HIGHATOMIC to fallbacks array for completeness.
> 
> [1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.net/
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/mmzone.h |  6 ++++++
>  mm/page_alloc.c        | 28 ++++++++++++++++++----------
>  2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index aed44e9b5d89..0aa549653e4e 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -83,6 +83,12 @@ static inline bool is_migrate_movable(int mt)
>  	return is_migrate_cma(mt) || mt == MIGRATE_MOVABLE;
>  }
>  
> +/* See fallbacks[MIGRATE_TYPES][3] in page_alloc.c */
> +static inline bool migratetype_has_fallback(int mt)
> +{
> +	return mt < MIGRATE_PCPTYPES;
> +}
> +
>  #define for_each_migratetype_order(order, type) \
>  	for (order = 0; order < MAX_ORDER; order++) \
>  		for (type = 0; type < MIGRATE_TYPES; type++)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8dd6399bafb5..5193c953dbf8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1042,6 +1042,12 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
>  	return page_is_buddy(higher_page, higher_buddy, order + 1);
>  }
>  
> +static inline bool has_non_fallback_pageblock(struct zone *zone)
> +{
> +	return has_isolate_pageblock(zone) || zone_cma_pages(zone) != 0 ||
> +		zone->nr_reserved_highatomic != 0;
> +}

Due to zone_cma_pages(), the unlikely() below will be very wrong on many
setups. Previously, isolation really was a corner case. CMA and
highatomic are less of a corner case ...

I'm not even sure if this check is worth having around anymore at all,
or if it would be easier and cheaper to just always check the both
migration types unconditionally. Would certainly simplify the code.

Side node: we actually care about has_free_non_fallback_pageblock(), we
can only merge with free pageblocks. But that might not necessarily be
cheaper to test/track/check.

> +
>  /*
>   * Freeing function for a buddy system allocator.
>   *
> @@ -1117,14 +1123,15 @@ static inline void __free_one_page(struct page *page,
>  	}
>  	if (order < MAX_ORDER - 1) {
>  		/* If we are here, it means order is >= pageblock_order.
> -		 * We want to prevent merge between freepages on isolate
> -		 * pageblock and normal pageblock. Without this, pageblock
> -		 * isolation could cause incorrect freepage or CMA accounting.
> +		 * We want to prevent merge between freepages on pageblock
> +		 * without fallbacks and normal pageblock. Without this,
> +		 * pageblock isolation could cause incorrect freepage or CMA
> +		 * accounting or HIGHATOMIC accounting.
>  		 *
>  		 * We don't want to hit this code for the more frequent
>  		 * low-order merging.
>  		 */
> -		if (unlikely(has_isolate_pageblock(zone))) {
> +		if (unlikely(has_non_fallback_pageblock(zone))) {
>  			int buddy_mt;
>  
>  			buddy_pfn = __find_buddy_pfn(pfn, order);
> @@ -1132,8 +1139,8 @@ static inline void __free_one_page(struct page *page,
>  			buddy_mt = get_pageblock_migratetype(buddy);
>  
>  			if (migratetype != buddy_mt
> -					&& (is_migrate_isolate(migratetype) ||
> -						is_migrate_isolate(buddy_mt)))
> +					&& (!migratetype_has_fallback(migratetype) ||
> +						!migratetype_has_fallback(buddy_mt)))
>  				goto done_merging;
>  		}
>  		max_order = order + 1;
> @@ -2484,6 +2491,7 @@ static int fallbacks[MIGRATE_TYPES][3] = {
>  	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRATE_TYPES },
>  	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_TYPES },
>  	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRATE_TYPES },
> +	[MIGRATE_HIGHATOMIC] = { MIGRATE_TYPES }, /* Never used */
>  #ifdef CONFIG_CMA
>  	[MIGRATE_CMA]         = { MIGRATE_TYPES }, /* Never used */
>  #endif
> @@ -2795,8 +2803,8 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone,
>  
>  	/* Yoink! */
>  	mt = get_pageblock_migratetype(page);
> -	if (!is_migrate_highatomic(mt) && !is_migrate_isolate(mt)
> -	    && !is_migrate_cma(mt)) {
> +	/* Only reserve normal pageblock */
> +	if (migratetype_has_fallback(mt)) {
>  		zone->nr_reserved_highatomic += pageblock_nr_pages;
>  		set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
>  		move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
> @@ -3545,8 +3553,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
>  		struct page *endpage = page + (1 << order) - 1;
>  		for (; page < endpage; page += pageblock_nr_pages) {
>  			int mt = get_pageblock_migratetype(page);
> -			if (!is_migrate_isolate(mt) && !is_migrate_cma(mt)
> -			    && !is_migrate_highatomic(mt))
> +			/* Only change normal pageblock */
> +			if (migratetype_has_fallback(mt))
>  				set_pageblock_migratetype(page,
>  							  MIGRATE_MOVABLE);
>  		}

That part is a nice cleanup IMHO. Although the "has fallback" part is a
bit imprecise. "migratetype_is_mergable()" might be a bit clearer.
ideally "migratetype_is_mergable_with_other_types()". Can we come up
with a nice name for that?

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
