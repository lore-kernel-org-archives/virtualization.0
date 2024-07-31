Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869D8801
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421778; cv=none; b=teQrpfNjD82jhWn/GveHUXjyASfsnuNjDB8JwG0PDxOEpo8LAXHPOIl/3eScQuEd8PEnhkZzb+S8x5mliZ+xBnNdY255YjHB4eJxpQS1TuG3zQEOZiRv5I5YcJnwxC9nhCxRTYSPECe8LdIVdWMbk0bc9M17DmyWzwsmiqzluhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421778; c=relaxed/simple;
	bh=Pu1uFJQhzUMuWcXH+D9TqOhjEvM8dCVc3hZIxsPifOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ag0diGDkI7BMaoAc+Q6ymn1nQnNMhzuP0+EFY44qxCM8TRBicR12IKpLZ7dsUE94x8BCUWRYs2W75DFJ4F1oZ+0F/bY9HHZ8QA2Hm0pBqjmaRzt88gDHtjY8WLNb/8gHPFuQuZgowbNHg5mEvO+6jQphaMF4kRFsRCa/X+eQYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y066VhuU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qQ3Oh+9s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xi7d/ImM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NLYqfMvu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y066VhuU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qQ3Oh+9s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xi7d/ImM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NLYqfMvu"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 25D4D1F833;
	Wed, 31 Jul 2024 10:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722421774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7z+sLFcN7YP8/dng3MgGo233JmqunRrZ5Hv/2AG1uxk=;
	b=Y066VhuU6npSiFfBUvxZr+7cn5cRASPI9sCuLUDne+PkW2OGdjZbRIoOUd7bAlSscX/UWu
	cv/71d4Z0Mf4bIogfxQonz3lO1X0UO9Onwdxv+ycCJcIzu9rCK1YXblCt7ndMknOuJf4+2
	NhvxZuMDJVxIr70Uynbho+ppjUnukFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722421774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7z+sLFcN7YP8/dng3MgGo233JmqunRrZ5Hv/2AG1uxk=;
	b=qQ3Oh+9sUQ0ThYFNtR1/eFjxrsfr9uwkU0cEoOkwus3QbLukagXT6bqdy2wqZlk5+nfi+b
	9pYnC7UWa5L5tfDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="xi7d/ImM";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NLYqfMvu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722421773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7z+sLFcN7YP8/dng3MgGo233JmqunRrZ5Hv/2AG1uxk=;
	b=xi7d/ImMUFXjg2HAy3FUr4O7ynJPrfp3K27ndkYYRA8anpmkw57zg49w9EdzoBRiYw2aYI
	viwEJQrzjX0MgFefcrGpLC83xUt6A6xz6476VewRK0Da1lyX+lOY9X4ILf2wsU5tTUsRlC
	ztHrLEDa1nN5Pq9xm3pzntjmwnt0afI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722421773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7z+sLFcN7YP8/dng3MgGo233JmqunRrZ5Hv/2AG1uxk=;
	b=NLYqfMvut9HNiNRFjg1Mi+EYnf+fRkwtWcKGPy2Isq9IxDRhXxrQ6ZK3wyURwOc0hrqEH5
	MZQRXKeRQok/XdDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F337413297;
	Wed, 31 Jul 2024 10:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dWUPOwwSqmazLAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 31 Jul 2024 10:29:32 +0000
Message-ID: <b1f4d2eb-ad6d-4ddf-91f5-f1ad0171789a@suse.cz>
Date: Wed, 31 Jul 2024 12:29:32 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com,
 mhocko@suse.com, penberg@kernel.org, rientjes@google.com,
 roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com,
 v-songbaohua@oppo.com, virtualization@lists.linux.dev,
 Kees Cook <kees@kernel.org>
References: <20240731000155.109583-1-21cnbao@gmail.com>
 <20240731000155.109583-4-21cnbao@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240731000155.109583-4-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 25D4D1F833
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org,kvack.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux.com,oppo.com,infradead.org,lge.com,suse.com,kernel.org,google.com,linux.dev,linux-foundation.org,lists.linux.dev];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oppo.com:email,suse.cz:email,suse.cz:dkim,linux-foundation.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,infradead.org:email,suse.com:email]

On 7/31/24 2:01 AM, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> We have cases we still fail though callers might have __GFP_NOFAIL.
> Since they don't check the return, we are exposed to the security
> risks for NULL deference.
> 
> Though BUG_ON() is not encouraged by Linus, this is an unrecoverable
> situation.
> 
> Christoph Hellwig:
> The whole freaking point of __GFP_NOFAIL is that callers don't handle
> allocation failures.  So in fact a straight BUG is the right thing
> here.
> 
> Vlastimil Babka:
> It's just not a recoverable situation (WARN_ON is for recoverable
> situations). The caller cannot handle allocation failure and at the same
> time asked for an impossible allocation. BUG_ON() is a guaranteed oops
> with stracktrace etc. We don't need to hope for the later NULL pointer
> dereference (which might if really unlucky happen from a different
> context where it's no longer obvious what lead to the allocation failing).
> 
> Michal Hocko:
> Linus tends to be against adding new BUG() calls unless the failure is
> absolutely unrecoverable (e.g. corrupted data structures etc.). I am
> not sure how he would look at simply incorrect memory allocator usage to
> blow up the kernel. Now the argument could be made that those failures
> could cause subtle memory corruptions or even be exploitable which might
> be a sufficient reason to stop them early.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Kees Cook <kees@kernel.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/slab.h | 4 +++-
>  mm/page_alloc.c      | 4 +++-
>  mm/util.c            | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index c9cb42203183..4a4d1fdc2afe 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -827,8 +827,10 @@ kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
>  {
>  	size_t bytes;
>  
> -	if (unlikely(check_mul_overflow(n, size, &bytes)))
> +	if (unlikely(check_mul_overflow(n, size, &bytes))) {
> +		BUG_ON(flags & __GFP_NOFAIL);

Shouldn't we produce some kind of warning also in the no-NOFAIL case?
Returning a NULL completely silently feels wrong.

>  		return NULL;
> +	}
>  
>  	return kvmalloc_node_noprof(bytes, flags, node);
>  }
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c700d2598a26..cc179c3e68df 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4708,8 +4708,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
>  	 * There are several places where we assume that the order value is sane
>  	 * so bail out early if the request is out of bound.
>  	 */
> -	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
> +	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)) {

Because here we do warn (although I'd argue even __GFP_NOWARN shouldn't
suppress a warning for such a reason).

> +		BUG_ON(gfp & __GFP_NOFAIL);
>  		return NULL;
> +	}
>  
>  	gfp &= gfp_allowed_mask;
>  	/*
> diff --git a/mm/util.c b/mm/util.c
> index 0ff5898cc6de..bad3258523b6 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -667,6 +667,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
>  
>  	/* Don't even allow crazy sizes */
>  	if (unlikely(size > INT_MAX)) {
> +		BUG_ON(flags & __GFP_NOFAIL);
>  		WARN_ON_ONCE(!(flags & __GFP_NOWARN));

And here, would argue the same. But maybe there's code that relies on this
so dunno. In that case we could at least convert to WARN_ON_ONCE_GFP.


>  		return NULL;
>  	}

