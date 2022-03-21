Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539A1C433FE
	for <virtualization@archiver.kernel.org>; Mon, 21 Mar 2022 17:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF63860F3E;
	Mon, 21 Mar 2022 17:30:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6-UrqYbZxPHi; Mon, 21 Mar 2022 17:30:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 123A960F03;
	Mon, 21 Mar 2022 17:30:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7772C001A;
	Mon, 21 Mar 2022 17:30:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A448CC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 17:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9FF364015A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 17:30:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wC3damfuxHpo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 17:30:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF8C54013B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 17:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647883808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NlV9jHxSF3Ib5TOatOCVcnKctI6qsGmDrK+z6mtlA4I=;
 b=Q5Esf0B7i/ksGZ5HXYY/MvlhTb6dqv9y6FL1ohADmC97wJ9IymmkDQIt55sm9mB2+k+PsV
 MYLV+vc8Uy1rGKD70gUt81Rf3zEjXX5L1zIZ/i/V2gS4akTnhhP+CwdcDatkINzZxkaKuD
 4ISbLMr7ONnsKb12Y+BGe6HnLDtr16o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-1J5EtqCjOVWo19_0Y62jnw-1; Mon, 21 Mar 2022 13:30:06 -0400
X-MC-Unique: 1J5EtqCjOVWo19_0Y62jnw-1
Received: by mail-wr1-f71.google.com with SMTP id
 k20-20020adfc714000000b001e305cd1597so3284996wrg.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 10:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=NlV9jHxSF3Ib5TOatOCVcnKctI6qsGmDrK+z6mtlA4I=;
 b=Hx6eKO7n+0AneEO6qZOHl2JaKb9Kt9pEzcjL5yqw9iqlc4MkU4N9tLiezdqnzTcUrD
 EA+cY65thPJ1tX7GfjNqsBgESWHIruU1ndo+cqp4UIYqzAPJabmG1wJ9zI7khLco+fJC
 dA5HDib9Dtb6I2SgXhS7MJzMSCYNKL9oMMeFEhWMfMq68g95nu2Uc/lZprrJOZ51eFwS
 qo1b9OsDr9PSgi5oUMT7qKnlSI8rlDGrd9T0jspopw+xK8DsoL6KN2XEC03U6jXQB1bP
 HGehe0C8bf74wL+mkRo2UDrr3HXBC8tj2sXRpvNOUyb8O6RWxX141rWHajy5poNDyK+v
 Bq5g==
X-Gm-Message-State: AOAM530gXDwIleCBVVzPXKgjVxlbwEB5k/DKiQbzTR/WUayprtpIe3Lc
 igPrqSxuEuOlNH5a6Na71MadXl0RKFnlWnPcOmValk+3MZv3gsBc8gE9IBw0eEtwjxET6r6oPQK
 LAncRZ4vyxYhz0DqauzYB80XUDjIsuF9uJa1C7GFnew==
X-Received: by 2002:adf:fa48:0:b0:1f0:d71:f9a with SMTP id
 y8-20020adffa48000000b001f00d710f9amr18490528wrr.50.1647883805451; 
 Mon, 21 Mar 2022 10:30:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYz2NV6cPW/UKXwtVAymCN+7Gymo2gqLNLS9v0lWJ/iSz7O2RDgrimNHZ2Vt90Dk0VjLP16Q==
X-Received: by 2002:adf:fa48:0:b0:1f0:d71:f9a with SMTP id
 y8-20020adffa48000000b001f00d710f9amr18490499wrr.50.1647883805091; 
 Mon, 21 Mar 2022 10:30:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:4900:849b:f76e:5e1f:ff95?
 (p200300cbc7044900849bf76e5e1fff95.dip0.t-ipconnect.de.
 [2003:cb:c704:4900:849b:f76e:5e1f:ff95])
 by smtp.gmail.com with ESMTPSA id
 i74-20020adf90d0000000b0020373ba7beesm20068021wri.0.2022.03.21.10.30.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Mar 2022 10:30:04 -0700 (PDT)
Message-ID: <44a512ba-1707-d9c7-7df3-b81af9b5f0fb@redhat.com>
Date: Mon, 21 Mar 2022 18:30:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20220317153733.2171277-1-zi.yan@sent.com>
 <20220317153733.2171277-3-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 2/5] mm: page_isolation: check specified range for
 unmovable pages
In-Reply-To: <20220317153733.2171277-3-zi.yan@sent.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 virtualization@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
 Eric Ren <renzhengeek@gmail.com>, Mel Gorman <mgorman@techsingularity.net>,
 Mike Rapoport <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>
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

On 17.03.22 16:37, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Enable set_migratetype_isolate() to check specified sub-range for
> unmovable pages during isolation. Page isolation is done
> at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
> pages within that granularity are intended to be isolated. For example,
> alloc_contig_range(), which uses page isolation, allows ranges without
> alignment. This commit makes unmovable page check only look for
> interesting pages, so that page isolation can succeed for any
> non-overlapping ranges.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/page-isolation.h | 10 +++++
>  mm/page_alloc.c                | 13 +------
>  mm/page_isolation.c            | 69 ++++++++++++++++++++--------------
>  3 files changed, 51 insertions(+), 41 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index e14eddf6741a..eb4a208fe907 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -15,6 +15,16 @@ static inline bool is_migrate_isolate(int migratetype)
>  {
>  	return migratetype == MIGRATE_ISOLATE;
>  }
> +static inline unsigned long pfn_max_align_down(unsigned long pfn)
> +{
> +	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
> +}
> +
> +static inline unsigned long pfn_max_align_up(unsigned long pfn)
> +{
> +	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
> +}
> +
>  #else
>  static inline bool has_isolate_pageblock(struct zone *zone)
>  {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6de57d058d3d..680580a40a35 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8937,16 +8937,6 @@ void *__init alloc_large_system_hash(const char *tablename,
>  }
>  
>  #ifdef CONFIG_CONTIG_ALLOC
> -static unsigned long pfn_max_align_down(unsigned long pfn)
> -{
> -	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
> -}
> -
> -static unsigned long pfn_max_align_up(unsigned long pfn)
> -{
> -	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
> -}
> -
>  #if defined(CONFIG_DYNAMIC_DEBUG) || \
>  	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
>  /* Usage: See admin-guide/dynamic-debug-howto.rst */
> @@ -9091,8 +9081,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  	 * put back to page allocator so that buddy can use them.
>  	 */
>  
> -	ret = start_isolate_page_range(pfn_max_align_down(start),
> -				       pfn_max_align_up(end), migratetype, 0);
> +	ret = start_isolate_page_range(start, end, migratetype, 0);
>  	if (ret)
>  		return ret;

Shouldn't we similarly adjust undo_isolate_page_range()? IOW, all users
of pfn_max_align_down()/pfn_max_align_up(). would be gone from that file
and you can move these defines into mm/page_isolation.c instead of
include/linux/page-isolation.h?

Maybe perform this change in a separate patch for
start_isolate_page_range() and undo_isolate_page_range() ?

>  
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index b34f1310aeaa..419c805dbdcd 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -16,7 +16,8 @@
>  #include <trace/events/page_isolation.h>
>  
>  /*
> - * This function checks whether pageblock includes unmovable pages or not.
> + * This function checks whether pageblock within [start_pfn, end_pfn) includes
> + * unmovable pages or not.

I think we still want to limit that to a single pageblock (see below),
as we're going to isolate individual pageblocks. Then an updated
description could be:

"This function checks whether the range [start_pfn, end_pfn) includes
unmovable pages or not. The range must fall into a single pageblock and
consequently belong to a single zone."

>   *
>   * PageLRU check without isolation or lru_lock could race so that
>   * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
> @@ -28,27 +29,26 @@
>   * cannot get removed (e.g., via memory unplug) concurrently.
>   *
>   */
> -static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
> -				 int migratetype, int flags)
> +static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long end_pfn,
> +				int migratetype, int flags)
>  {
> -	unsigned long iter = 0;
> -	unsigned long pfn = page_to_pfn(page);
> -	unsigned long offset = pfn % pageblock_nr_pages;
> +	unsigned long pfn = start_pfn;
>  
> -	if (is_migrate_cma_page(page)) {
> -		/*
> -		 * CMA allocations (alloc_contig_range) really need to mark
> -		 * isolate CMA pageblocks even when they are not movable in fact
> -		 * so consider them movable here.
> -		 */
> -		if (is_migrate_cma(migratetype))
> -			return NULL;

If we're really dealing with a range that falls into a single pageblock,
then you can leave the is_migrate_cma_page() in place and also lookup
the zone only once. That should speed up things and minimize the
required changes.

You can then further add VM_BUG_ON()s that make sure that start_pfn and
end_pfn-1 belong to a single pageblock.

> +	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> +		struct page *page = pfn_to_page(pfn);
> +		struct zone *zone = page_zone(page);
>  
> -		return page;
> -	}
> +		if (is_migrate_cma_page(page)) {
> +			/*
> +			 * CMA allocations (alloc_contig_range) really need to mark
> +			 * isolate CMA pageblocks even when they are not movable in fact
> +			 * so consider them movable here.
> +			 */
> +			if (is_migrate_cma(migratetype))
> +				return NULL;
>  
> -	for (; iter < pageblock_nr_pages - offset; iter++) {
> -		page = pfn_to_page(pfn + iter);
> +			return page;
> +		}
>  
>  		/*
>  		 * Both, bootmem allocations and memory holes are marked
> @@ -85,7 +85,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  			}
>  
>  			skip_pages = compound_nr(head) - (page - head);
> -			iter += skip_pages - 1;
> +			pfn += skip_pages - 1;
>  			continue;
>  		}
>  
> @@ -97,7 +97,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		 */
>  		if (!page_ref_count(page)) {
>  			if (PageBuddy(page))
> -				iter += (1 << buddy_order(page)) - 1;
> +				pfn += (1 << buddy_order(page)) - 1;
>  			continue;
>  		}
>  
> @@ -134,7 +134,13 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  	return NULL;
>  }
>  
> -static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
> +/*
> + * This function set pageblock migratetype to isolate if no unmovable page is
> + * present in [start_pfn, end_pfn). The pageblock must intersect with
> + * [start_pfn, end_pfn).
> + */
> +static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags,
> +			unsigned long start_pfn, unsigned long end_pfn)
>  {
>  	struct zone *zone = page_zone(page);
>  	struct page *unmovable;
> @@ -155,8 +161,13 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  	/*
>  	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
>  	 * We just check MOVABLE pages.
> +	 *
> +	 * Pass the intersection of [start_pfn, end_pfn) and the page's pageblock
> +	 * to avoid redundant checks.
>  	 */

I think I'd prefer some helper variables for readability.

> -	unmovable = has_unmovable_pages(zone, page, migratetype, isol_flags);
> +	unmovable = has_unmovable_pages(max(page_to_pfn(page), start_pfn),
> +			min(ALIGN(page_to_pfn(page) + 1, pageblock_nr_pages), end_pfn),
> +			migratetype, isol_flags);
>  	if (!unmovable) {
>  		unsigned long nr_pages;
>  		int mt = get_pageblock_migratetype(page);
> @@ -267,7 +278,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>   * be MIGRATE_ISOLATE.
>   * @start_pfn:		The lower PFN of the range to be isolated.
>   * @end_pfn:		The upper PFN of the range to be isolated.
> - *			start_pfn/end_pfn must be aligned to pageblock_order.
>   * @migratetype:	Migrate type to set in error recovery.
>   * @flags:		The following flags are allowed (they can be combined in
>   *			a bit mask)
> @@ -309,15 +319,16 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  	unsigned long pfn;
>  	struct page *page;
>  
> -	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
> -	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
> +	unsigned long isolate_start = pfn_max_align_down(start_pfn);
> +	unsigned long isolate_end = pfn_max_align_up(end_pfn);
>  
> -	for (pfn = start_pfn;
> -	     pfn < end_pfn;
> +	for (pfn = isolate_start;
> +	     pfn < isolate_end;
>  	     pfn += pageblock_nr_pages) {
>  		page = __first_valid_page(pfn, pageblock_nr_pages);
> -		if (page && set_migratetype_isolate(page, migratetype, flags)) {
> -			undo_isolate_page_range(start_pfn, pfn, migratetype);
> +		if (page && set_migratetype_isolate(page, migratetype, flags,
> +					start_pfn, end_pfn)) {
> +			undo_isolate_page_range(isolate_start, pfn, migratetype);
>  			return -EBUSY;
>  		}
>  	}


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
