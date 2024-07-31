Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C581AC434
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423361; cv=none; b=f/EtSgyCkYckzyi/THp1tIbzJIbyWaoEHAymZ37ELEG5V/177gTAfxEqyq2hz8X0s+pI4oIdG3K+sfNXPE9OMH26R0RdG3fGo/Qg/PZ7no+FOuaoti7i4Hmv5zh1F1Up/TKnRGS3Ybv4ygOpIwqEMbBqwpyzwy16CGoFw2DkCFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423361; c=relaxed/simple;
	bh=iy/kP4dPf0Ywwr3D0TENsKie5NxjDtaKtfyz5CQ3pmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTEIT+uh0S6mIRFZWqkPs0dZ+UtGCyC+Ja7UjUOHBAxrW2Ojcm3gfbkwATXD1/EFXSU+TpYAOVZ6zJQPnjmZxOIQI1MGDUjMg0tnXsvRxl1PZtuq/EMqctUSCb6iLT6aWLWLG2bRwGDRK0qthRI6PKWQgA3/YmLtBDS07vKwRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bGWGX0Rh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=48k6HJ9B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bGWGX0Rh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=48k6HJ9B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bGWGX0Rh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="48k6HJ9B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bGWGX0Rh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="48k6HJ9B"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C9FE71F833;
	Wed, 31 Jul 2024 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722423357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x2eufugl6JPtMDb75b7WK7LBenki8NzUMhj+piOZtAs=;
	b=bGWGX0RhDJglVDkBItM6dUCPHeKgbw7DQ9AAFRpGOSQBHe/kQYpTdBdB9Z4e8yjjRPUH8x
	GUeAJqu/DDXX6pi6uykrEI4qTCHF+V7p709II9wrXTriaKdaqSUeWiQXm7kB9K8AJuc8Fl
	iXG8oNwFVlaOWrqcswb5/yOjZRYYU2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722423357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x2eufugl6JPtMDb75b7WK7LBenki8NzUMhj+piOZtAs=;
	b=48k6HJ9Bi1FVEHZKkySzL9AJjb589qX5zquYysxm7GEwdW84raNKd88N81NLr/yQ7RSrQx
	zJnqZLnhLtuKXCBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722423357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x2eufugl6JPtMDb75b7WK7LBenki8NzUMhj+piOZtAs=;
	b=bGWGX0RhDJglVDkBItM6dUCPHeKgbw7DQ9AAFRpGOSQBHe/kQYpTdBdB9Z4e8yjjRPUH8x
	GUeAJqu/DDXX6pi6uykrEI4qTCHF+V7p709II9wrXTriaKdaqSUeWiQXm7kB9K8AJuc8Fl
	iXG8oNwFVlaOWrqcswb5/yOjZRYYU2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722423357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x2eufugl6JPtMDb75b7WK7LBenki8NzUMhj+piOZtAs=;
	b=48k6HJ9Bi1FVEHZKkySzL9AJjb589qX5zquYysxm7GEwdW84raNKd88N81NLr/yQ7RSrQx
	zJnqZLnhLtuKXCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FA6513297;
	Wed, 31 Jul 2024 10:55:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +M49Jj0YqmYxNAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 31 Jul 2024 10:55:57 +0000
Message-ID: <19981556-cecd-4f58-8b3b-bc3bb85a6ac4@suse.cz>
Date: Wed, 31 Jul 2024 12:55:57 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
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
 <20240731000155.109583-5-21cnbao@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240731000155.109583-5-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.41 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org,kvack.org];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux.com,oppo.com,infradead.org,lge.com,suse.com,kernel.org,google.com,linux.dev,linux-foundation.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,oppo.com:email]
X-Spam-Flag: NO
X-Spam-Score: 0.41

On 7/31/24 2:01 AM, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> When users allocate memory with the __GFP_NOFAIL flag, they might
> incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc. This kind
> of non-blockable __GFP_NOFAIL is not supported and is pointless. If
> we attempt and still fail to allocate memory for these users, we have
> two choices:
> 
>     1. We could busy-loop and hope that some other direct reclamation or
>     kswapd rescues the current process. However, this is unreliable
>     and could ultimately lead to hard or soft lockups, which might not
>     be well supported by some architectures.
> 
>     2. We could use BUG_ON to trigger a reliable system crash, avoiding
>     exposing NULL dereference.
> 
> This patch chooses the second option because the first is unreliable. Even
> if the process incorrectly using __GFP_NOFAIL is sometimes rescued, the
> long latency might be unacceptable, especially considering that misusing
> GFP_ATOMIC and __GFP_NOFAIL is likely to occur in atomic contexts with
> strict timing requirements.
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
> ---
>  mm/page_alloc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cc179c3e68df..ed1bd8f595bd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4439,11 +4439,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	 */
>  	if (gfp_mask & __GFP_NOFAIL) {
>  		/*
> -		 * All existing users of the __GFP_NOFAIL are blockable, so warn
> -		 * of any new users that actually require GFP_NOWAIT
> +		 * All existing users of the __GFP_NOFAIL are blockable
> +		 * otherwise we introduce a busy loop with inside the page
> +		 * allocator from non-sleepable contexts
>  		 */
> -		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> -			goto fail;
> +		BUG_ON(!can_direct_reclaim);

We might get more useful output if here we did just "if
(!can_direct_reclaim) goto fail; and let warn_alloc() print it, and then
there would be a BUG_ON(gfp_mask & __GFP_NOFAIL)?
Additionally we could mask out __GFP_NOWARN from gfp_mask before the goto,
as a __GFP_NOWARN would suppress the output in a non-recoverable situation
so it would be wrong.

>  
>  		/*
>  		 * PF_MEMALLOC request from this context is rather bizarre
> @@ -4474,7 +4474,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		cond_resched();
>  		goto retry;
>  	}
> -fail:
> +
>  	warn_alloc(gfp_mask, ac->nodemask,
>  			"page allocation failure: order:%u", order);
>  got_pg:

