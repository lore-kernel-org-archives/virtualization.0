Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA82032A
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262837; cv=none; b=UK8q4is7jeajy0hMResqWhoeo+brkKHQ/+1tqyffwvj4Em8Ei4EURy2SmBDxQ8ryur5xhX85e5eJ0BQLDluUAkGODI7QtlHQWCQlMLoVk5cXzbJ5mVh2Xnw7YL/CG1KfD7EhBICfDdOT5HVCGHKx5tmVig7HmJ7ENC89djq2svc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262837; c=relaxed/simple;
	bh=AjFvTf3x2+VfQZt9f+jWClmlAcOUHGXZcQKLDGudNXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urruShzwX8RRuMs4jh9xitK3JWpZE4yQGQYuwP3te6XH+mPZtzKdOOLTyzt9PK3FS0SPgPp72C+cm8y9DTWRxkJkZcSRo4LHcxVkoSGofkiJlYohe4Sg+OVPy+RTLDg7GLu7RIYwuf1eid7HLnENUgrCwysiCdQBSsOLQk/3mS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/w5+9h+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/w5+9h+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725262835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0uOSldje/qVqa/NGnBKLq11MajuN7BF28459LMKmYqU=;
	b=I/w5+9h+m9uUJ0pmYx1/4u8MJCIJehZpteXiD8bCgpyCHDxxx60F1EUc/totQPnbqTViHS
	0atJVkRTNCLnBb977kAwH6h38V7/gE2fYdBiUGz+lbT8IYHUvLKFCYWtWxJgYs2CwUwW/Z
	oJZfPCzkkOm8E681N9TYIjaJ/EXHSzg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-rS6GoNxrNjiOfwS-hfVpRw-1; Mon, 02 Sep 2024 03:40:32 -0400
X-MC-Unique: rS6GoNxrNjiOfwS-hfVpRw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428ea5b1479so35104745e9.0
        for <virtualization@lists.linux.dev>; Mon, 02 Sep 2024 00:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725262831; x=1725867631;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0uOSldje/qVqa/NGnBKLq11MajuN7BF28459LMKmYqU=;
        b=qCMjVaM3pwORSodtvnGUWLjYIWS+iTPU4NQojCu1xi8680c6Xiuf5TIZKxmDAd3FYv
         uZbqAk6YoL72cpVCLuRx3E/MIQRVuczmrgUKQMrOJKpFjottuvfmoyxGTTlkndh2iyib
         +cXm4LedsnNc2+NBieKNiFCM96TcHIsRulzFuXN9bV8/bLwvvGbORpcSmVnI8Q8XL7/f
         Y7L/L8WLK/I4ui6hknn8FDmhySmXcF/yzubsL3B4icJzQWao5XWOnBJfNSVjs26312YW
         eSwbjQn4iXnkPnSQN2Q1pMCclgozcqC5KE9xXYurHbxtnh7rnQIWoyafGGW5wJXfhj5u
         NcAg==
X-Forwarded-Encrypted: i=1; AJvYcCWV/PuHJAB4aKev5Zlf9lQt/1YZhmDy9qXl+P5HZGZ+MDnL8ERWR3wLASddsHXT/mXmfm0gY4DjRFFtQevkKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAleE2cIIA2lzmGt7a6nK9XLsoOh/cQWTYoQMBqNHz6qEcJsaB
	yYOptghVesfzayDIgFH4msRfU8qiy6orVzRM7cQZd8BsPEN+CqmT+j0tYpTWZjkNnMvOShZq9Qc
	UmA+HlVcZU6pKoHUvX1s99t3tsFQ/3JZNfNH/7QBpPHMr53Ge6wFXWUkVV57EAWbt
X-Received: by 2002:a05:600c:474c:b0:426:6e95:78d6 with SMTP id 5b1f17b1804b1-42bb01aa1fdmr106163485e9.4.1725262830708;
        Mon, 02 Sep 2024 00:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGhHjnvubvEVnp9yuDOruH0S9h75FYgk3lFU+Cch18GncGJlds7/Jk70WnkQ9WWVxBlPSP1A==
X-Received: by 2002:a05:600c:474c:b0:426:6e95:78d6 with SMTP id 5b1f17b1804b1-42bb01aa1fdmr106163135e9.4.1725262829851;
        Mon, 02 Sep 2024 00:40:29 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba642593asm163335275e9.39.2024.09.02.00.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 00:40:29 -0700 (PDT)
Message-ID: <6f14bc6d-f01b-48ad-b928-1dc2c7e43ec5@redhat.com>
Date: Mon, 2 Sep 2024 09:40:28 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] mm: warn about illegal __GFP_NOFAIL usage in a
 more appropriate location and manner
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, mhocko@suse.com,
 penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
 torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com,
 vbabka@suse.cz, laoar.shao@gmail.com
References: <20240830202823.21478-1-21cnbao@gmail.com>
 <20240830202823.21478-4-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240830202823.21478-4-21cnbao@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.08.24 22:28, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Three points for this change:
> 
> 1. We should consolidate all warnings in one place. Currently, the
>     order > 1 warning is in the hotpath, while others are in less
>     likely scenarios. Moving all warnings to the slowpath will reduce
>     the overhead for order > 1 and increase the visibility of other
>     warnings.
> 
> 2. We currently have two warnings for order: one for order > 1 in
>     the hotpath and another for order > costly_order in the laziest
>     path. I suggest standardizing on order > 1 since it’s been in
>     use for a long time.
> 
> 3. We don't need to check for __GFP_NOWARN in this case. __GFP_NOWARN
>     is meant to suppress allocation failure reports, but here we're
>     dealing with bug detection, not allocation failures. So replace
>     WARN_ON_ONCE_GFP by WARN_ON_ONCE.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   mm/page_alloc.c | 50 ++++++++++++++++++++++++-------------------------
>   1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c81ee5662cc7..e790b4227322 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3033,12 +3033,6 @@ struct page *rmqueue(struct zone *preferred_zone,
>   {
>   	struct page *page;
>   
> -	/*
> -	 * We most definitely don't want callers attempting to
> -	 * allocate greater than order-1 page units with __GFP_NOFAIL.
> -	 */
> -	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> -
>   	if (likely(pcp_allowed_order(order))) {
>   		page = rmqueue_pcplist(preferred_zone, zone, order,
>   				       migratetype, alloc_flags);
> @@ -4175,6 +4169,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>   {
>   	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
>   	bool can_compact = gfp_compaction_allowed(gfp_mask);
> +	bool nofail = gfp_mask & __GFP_NOFAIL;
>   	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
>   	struct page *page = NULL;
>   	unsigned int alloc_flags;
> @@ -4187,6 +4182,25 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>   	unsigned int zonelist_iter_cookie;
>   	int reserve_flags;
>   
> +	if (unlikely(nofail)) {
> +		/*
> +		 * We most definitely don't want callers attempting to
> +		 * allocate greater than order-1 page units with __GFP_NOFAIL.
> +		 */

Acked-by: David Hildenbrand <david@redhat.com>

Should we also clarify that in the docs? Currently we have "Using this 
flag for costly allocations is _highly_ discouraged."

We'd likely want to say something like "Allocating pages from the buddy 
with __GFP_NOFAIL and order > 1 is not supported."

-- 
Cheers,

David / dhildenb

