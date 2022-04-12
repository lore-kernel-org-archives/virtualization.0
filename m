Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE014C433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 13:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 778B7834AE;
	Tue, 12 Apr 2022 13:10:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pDkrrotKoOks; Tue, 12 Apr 2022 13:10:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 14BE7831DE;
	Tue, 12 Apr 2022 13:10:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E08AEC0033;
	Tue, 12 Apr 2022 13:10:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 035AEC002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 13:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5D11404A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 13:10:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id umhQjsZDS-sQ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 13:10:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F4A0403FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 13:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649769018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxNi3KUC9hG5+dIEHXwk8T0pk8dlLB9WdrbtBDd6QQY=;
 b=UmS2TfEHIr83TkGUTzkbo6DutbWGtW5sYkKIz6FX0776hPcWnjbJ3GHkFK9ObWdSamKWwQ
 LWoKn7DJm9+6NCkJrc2MOA1/+E8bUm3Rao+4vrI2Bu/kC7BuaB3KP9dZBpQqL56i4/Kps4
 rKwKfiuWSC9Ujzz3lMQZy+NfX2JnR3o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-WHGbOYylNvS5g9Lh5-Qt7g-1; Tue, 12 Apr 2022 09:10:15 -0400
X-MC-Unique: WHGbOYylNvS5g9Lh5-Qt7g-1
Received: by mail-wr1-f72.google.com with SMTP id
 q4-20020adfc504000000b002079c9cc1bfso1652292wrf.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=cxNi3KUC9hG5+dIEHXwk8T0pk8dlLB9WdrbtBDd6QQY=;
 b=meQ+m3wpbZYDGXacbWzKdCAhww8ns5QBC1rGR1iXZANu3YAMrcP1vUvyDw+gTlhB6J
 TOTBBf751qpJaoPi97vhtwatdZ53x4TB16R4cZJkJ10zPnCNg0kZf+8mj1lUjivDwSDR
 BbIYoQn5KmEyQXKBOAMGhzwQfUAhNpo6RI4kiMyIXijOIJDWuWzxKunl+1IsiYf+CtaF
 4yntL3orIcNeNXomC8T5zjthUFRpEKWBeaYT98Zje7ULaqfPJNevLXm6kXl+w7UuhbN6
 cSbZsjrqNk377hhaD2SN9Y0XRNSIFAom36Q+hcwbmd1MG7OZMTgv8QRfyuwv2iDeNhS4
 Tv+w==
X-Gm-Message-State: AOAM532ybuIx8H81o+S2k+vNtLgaGevDijtPc1kxsrcZnyS05BEYf7yC
 mFLtAe7O2yZQg3whgcH9GkzSvejlXW8j5Qu+QzY1fUAC5ehHoqp3Su4IXHS5gVbuEr9IihkTvGP
 NHcYXmOpmSJJ1HXGXZFWx4W2f0nUYtaSuDO8Q9Xh3/g==
X-Received: by 2002:a1c:ed12:0:b0:38e:9e4e:2db2 with SMTP id
 l18-20020a1ced12000000b0038e9e4e2db2mr4092006wmh.96.1649769014225; 
 Tue, 12 Apr 2022 06:10:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPO9VTOs/2MHLmQnUoLuhtZklz6TW1zHJj9EIuwagGg5Ey6vVOLVwIN01vt2AHQuMXqL4Efw==
X-Received: by 2002:a1c:ed12:0:b0:38e:9e4e:2db2 with SMTP id
 l18-20020a1ced12000000b0038e9e4e2db2mr4091971wmh.96.1649769013882; 
 Tue, 12 Apr 2022 06:10:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1800:7c14:16cc:5291:a9f3?
 (p200300cbc70718007c1416cc5291a9f3.dip0.t-ipconnect.de.
 [2003:cb:c707:1800:7c14:16cc:5291:a9f3])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a5d5587000000b00207a8cde900sm4506601wrv.19.2022.04.12.06.10.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 06:10:13 -0700 (PDT)
Message-ID: <ccae12f9-a452-95a8-f404-3398dcdf5bdf@redhat.com>
Date: Tue, 12 Apr 2022 15:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20220406151858.3149821-1-zi.yan@sent.com>
 <20220406151858.3149821-3-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v10 2/5] mm: page_isolation: check specified range for
 unmovable pages
In-Reply-To: <20220406151858.3149821-3-zi.yan@sent.com>
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

On 06.04.22 17:18, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Enable set_migratetype_isolate() to check specified sub-range for
> unmovable pages during isolation. Page isolation is done
> at MAX_ORDER_NR_PAEGS granularity, but not all pages within that
> granularity are intended to be isolated. For example,
> alloc_contig_range(), which uses page isolation, allows ranges without
> alignment. This commit makes unmovable page check only look for
> interesting pages, so that page isolation can succeed for any
> non-overlapping ranges.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

[...]

>  /*
> - * This function checks whether pageblock includes unmovable pages or not.
> + * This function checks whether the range [start_pfn, end_pfn) includes
> + * unmovable pages or not. The range must fall into a single pageblock and
> + * consequently belong to a single zone.
>   *
>   * PageLRU check without isolation or lru_lock could race so that
>   * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
> @@ -28,12 +30,14 @@
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
> +	struct page *page = pfn_to_page(pfn);


Just do

struct page *page = pfn_to_page(start_pfn);
struct zone *zone = page_zone(page);

here. No need to lookup the zone again in the loop because, as you
document "must ... belong to a single zone.".

Then, there is also no need to initialize "pfn" here. In the loop header
is sufficient.

> +
> +	VM_BUG_ON(ALIGN_DOWN(start_pfn, pageblock_nr_pages) !=
> +		  ALIGN_DOWN(end_pfn - 1, pageblock_nr_pages));
>  
>  	if (is_migrate_cma_page(page)) {
>  		/*
> @@ -47,8 +51,11 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		return page;
>  	}
>  
> -	for (; iter < pageblock_nr_pages - offset; iter++) {
> -		page = pfn_to_page(pfn + iter);
> +	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> +		struct zone *zone;
> +
> +		page = pfn_to_page(pfn);
> +		zone = page_zone(page);
>  
>  		/*
>  		 * Both, bootmem allocations and memory holes are marked
> @@ -85,7 +92,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  			}
>  
>  			skip_pages = compound_nr(head) - (page - head);
> -			iter += skip_pages - 1;
> +			pfn += skip_pages - 1;
>  			continue;
>  		}
>  
> @@ -97,7 +104,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		 */
>  		if (!page_ref_count(page)) {
>  			if (PageBuddy(page))
> -				iter += (1 << buddy_order(page)) - 1;
> +				pfn += (1 << buddy_order(page)) - 1;
>  			continue;
>  		}
>  
> @@ -134,11 +141,18 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
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

I think we might be able do better, eventually not passing start_pfn at
all. Hmm.

I think we want to pull out the
start_isolate_page_range()/undo_isolate_page_range() interface change
into a separate patch.

Let me try to give it a shot, I'll try hacking something up real quick
to see if we can do better.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
