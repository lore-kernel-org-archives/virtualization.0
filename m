Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12B22FDEC
	for <virtualization@lists.linux.dev>; Fri, 30 May 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624071; cv=none; b=TZn1d+EnT4e/J74oO7cKH1AfBkVQ8xR+ZANOYJUarCuWGRuGhzoBCq0dWhhgRi6a3XHc1KvhyGSADiChEbf/7X8Kuv7UgptwZ9vGPa9kUT0+LtRt15ZlXts4gr9+bcFzjhpWTi1A0UmVw8fOJDjqI6BRPy9QVVB6rTW2EC0JFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624071; c=relaxed/simple;
	bh=RXLmFWxoFIJycLMgEmUPoFkj2rLa+5V5ozpa6WNzSX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M95ddOLjonBtZ/qkLprc19npKswuBdcCYwiC8iwhhiaI/5aPEbhZEklcJAhi1j7PIx0FwwWJe+mMSeIGERaoIG93LtVniwHy0aGrk9EHKHXSKeIH4ptv+nTp1VRQe0rLxErg6hCRu9GYp/bCo9PDxGRPkFCbR3CtXl1nZnIBjeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V8BjR+1i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P+Z/dvim; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V8BjR+1i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P+Z/dvim; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V8BjR+1i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P+Z/dvim";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V8BjR+1i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P+Z/dvim"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ACFCB1F791;
	Fri, 30 May 2025 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748624065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S9NNRjMCeuQEBzBHlmjDA51y656c4U2QaDFVTqvP2PE=;
	b=V8BjR+1i179CcI3Oa3VQkZtxvSCHAND0N9Vhr3cJ2KIEVQOsqzZUbfUp55cce7uX86ifJY
	svqSJsSmVzjFZfBraq7Y00L4oTE9i1EIHSYWvCM1On1Y1FaTMc9N1aMuJ888jhVKsWBPr0
	VzRut4TXjoYFAaARQi/dp+AKDqgUmSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748624065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S9NNRjMCeuQEBzBHlmjDA51y656c4U2QaDFVTqvP2PE=;
	b=P+Z/dvimtiPDMUbz9O1pgXi/YXKGJOI5gf0eNtiGXXyCjNcVkbqgKZpGdAlPKEjeJdeuu9
	dzfdNDvqyjO2JJDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=V8BjR+1i;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="P+Z/dvim"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748624065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S9NNRjMCeuQEBzBHlmjDA51y656c4U2QaDFVTqvP2PE=;
	b=V8BjR+1i179CcI3Oa3VQkZtxvSCHAND0N9Vhr3cJ2KIEVQOsqzZUbfUp55cce7uX86ifJY
	svqSJsSmVzjFZfBraq7Y00L4oTE9i1EIHSYWvCM1On1Y1FaTMc9N1aMuJ888jhVKsWBPr0
	VzRut4TXjoYFAaARQi/dp+AKDqgUmSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748624065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S9NNRjMCeuQEBzBHlmjDA51y656c4U2QaDFVTqvP2PE=;
	b=P+Z/dvimtiPDMUbz9O1pgXi/YXKGJOI5gf0eNtiGXXyCjNcVkbqgKZpGdAlPKEjeJdeuu9
	dzfdNDvqyjO2JJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E5D9132D8;
	Fri, 30 May 2025 16:54:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y78YHsHiOWipcQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 30 May 2025 16:54:25 +0000
Message-ID: <d3336028-174f-4312-864c-2b1e1b736e07@suse.cz>
Date: Fri, 30 May 2025 18:54:25 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/memory_hotplug: PG_offline_skippable for
 offlining memory blocks with PageOffline pages
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20250520164216.866543-1-david@redhat.com>
 <20250520164216.866543-2-david@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250520164216.866543-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,suse.cz:dkim,suse.cz:mid,suse.cz:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: ACFCB1F791
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 5/20/25 18:42, David Hildenbrand wrote:
> A long-term goal is supporting frozen PageOffline pages, and later
> PageOffline pages that don't have a refcount at all. Some more work for

Looking forward to that :)

> that is needed -- in particular around non-folio page migration and
> memory ballooning drivers -- but let's start by handling PageOffline pages
> that can be skipped during memory offlining differently.
> 
> Note that PageOffline is used to mark pages that are logically offline
> in an otherwise online memory block (e.g., 128 MiB). If a memory
> block is offline, the memmap is considered compeltely uninitialized
> and stale (see pfn_to_online_page()).
> 
> Let's introduce a PageOffline specific page flag (PG_offline_skippable)
> that for now reuses PG_owner_2. In the memdesc future, it will be one of
> a small number of per-memdesc flags stored alongside the type.
> 
> By setting PG_offline_skippable, a driver indicates that it can
> restore the PageOffline state of these specific pages when re-onlining a
> memory block: it knows that these pages are supposed to be PageOffline()
> without the information in the vmemmap, so it can filter them out and
> not expose them to the buddy -> they stay PageOffline().
> 
> While PG_offline_offlineable might be clearer, it is also super
> confusing. Alternatives (PG_offline_sticky?) also don't quite feel right.
> So let's use "skippable" for now.
> 
> The flag is not supposed to be used for movable PageOffline pages as
> used for balloon compaction; movable PageOffline() pages can simply be
> migrated during the memory offlining stage, turning the migration
> destination page PageOffline() and turning the migration source page
> into a free buddy page.
> 
> Let's convert the single user from our MEM_GOING_OFFLINE approach
> to the new PG_offline_skippable approach: virtio-mem. Fortunately,
> this simplifies the code quite a lot. The only corner case we have to
> take care of is when force-unloading the virtio-mem driver: we have to
> prevent partially-plugged memory blocks from getting offlined by
> clearing PG_offline_skippable again.
> 
> What if someone decides to grab a reference on these pages although they
> really shouldn't? After all, we'll now keep the refcount at 1 (until we
> can properly stop using the refcount completely).
> 
> Well, less worse things will happen than would currently: currently,
> if someone would grab a reference to these pages, in MEM_GOING_OFFLINE
> we would run into the
> 		if (WARN_ON(!page_ref_dec_and_test(page)))
> 			dump_page(page, "fake-offline page referenced");
> 
> And once that unexpected reference would get dropped, we would end up
> freeing that page to the buddy: ouch.
> 
> Now, we'll allow for offlining that memory, and when that unexpected
> reference would get dropped, we would not end up freeing that page to
> the buddy. Once we have frozen PageOffline() pages, it will all get a
> lot cleaner.

Hmm, a question on that later in the code (assuming I identified the right
place).

> Note that we didn't see the existing WARN_ON so far, because nobody
> should ever be referencing such pages.

It's mostly a speculative refcount increase from a pfn walker, such as
compaction scanner, that can happen due to its inherent raciness.

> An alternative might be to have another callback chain from memory hotplug
> code, where a driver that owns that page could agree to skip the
> PageOffline() page. However, we would have to repeatedly issue these
> callbacks for individual PageOffline() pages, which does not sound
> compelling. As we have spare bits, let's use this simpler approach for
> now.
> 
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz> # page allocator

I'll leave hotplug to the experts :)

<snip>

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f6482223e28a2..7e4c41e46a911 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7023,12 +7023,12 @@ unsigned long __offline_isolated_pages(unsigned long start_pfn,
>  			continue;
>  		}
>  		/*
> -		 * At this point all remaining PageOffline() pages have a
> -		 * reference count of 0 and can simply be skipped.
> +		 * At this point all remaining PageOffline() pages must be
> +		 * "skippable" and have exactly one reference.
>  		 */
>  		if (PageOffline(page)) {
> -			BUG_ON(page_count(page));
> -			BUG_ON(PageBuddy(page));
> +			WARN_ON_ONCE(!PageOfflineSkippable(page));
> +			WARN_ON_ONCE(page_count(page) != 1);

So is this the part where an unexpected speculative refcount might be
detected? Should be harmless then as it will then decrease the refcount from
e.g. 2 to 1 and nothing will happen right.
That's assuming that once we pass __offline_isolated_pages(), the following
actions wont modify the refcount or the struct page won't be zeroed, or
removed completely (vmemmap). Probably something already prevents that...

>  			already_offline++;
>  			pfn++;
>  			continue;
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index b2fc5266e3d26..debd898b794ea 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -121,16 +121,11 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
>  			continue;
>  
>  		/*
> -		 * We treat all PageOffline() pages as movable when offlining
> -		 * to give drivers a chance to decrement their reference count
> -		 * in MEM_GOING_OFFLINE in order to indicate that these pages
> -		 * can be offlined as there are no direct references anymore.
> -		 * For actually unmovable PageOffline() where the driver does
> -		 * not support this, we will fail later when trying to actually
> -		 * move these pages that still have a reference count > 0.
> -		 * (false negatives in this function only)
> +		 * PageOffline() pages that are marked as "skippable"
> +		 * are treated like movable pages for memory offlining.
>  		 */
> -		if ((flags & MEMORY_OFFLINE) && PageOffline(page))
> +		if ((flags & MEMORY_OFFLINE) && PageOffline(page) &&
> +		    PageOfflineSkippable(page))
>  			continue;
>  
>  		if (__PageMovable(page) || PageLRU(page))
> @@ -577,11 +572,11 @@ __test_page_isolated_in_pageblock(unsigned long pfn, unsigned long end_pfn,
>  			/* A HWPoisoned page cannot be also PageBuddy */
>  			pfn++;
>  		else if ((flags & MEMORY_OFFLINE) && PageOffline(page) &&
> -			 !page_count(page))
> +			 PageOfflineSkippable(page))
>  			/*
> -			 * The responsible driver agreed to skip PageOffline()
> -			 * pages when offlining memory by dropping its
> -			 * reference in MEM_GOING_OFFLINE.
> +			 * If the page is a skippable PageOffline() page,
> +			 * we can offline the memory block, as the driver will
> +			 * re-discover them when re-onlining the memory.
>  			 */
>  			pfn++;
>  		else

