Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A642A1531F9
	for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003431; cv=none; b=ED05Gr5EXLHPqbyN+3UXtLZUpvDkTIm5t4KtsxNKK9NHniJLbwRDlTPIJo0vEWo+AQhHgXuevqfvlm3akuzT3jmovdlRG1JgM1LEy05BrGnAY0YBOc+t8koi8/j5mrp1d31DpP6Iixv4Qu2xtb5VZEA8L1kTCBSRxFiQrUcHqho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003431; c=relaxed/simple;
	bh=Mgz236nwb47JoZubCtUF7zziZDvN9noKRFPicSZLkvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4mFty3gVElJAyi9BQSeL8mnmXtaXcVlmQuznVzK2ye4t+X56hgJXywGzZIcz99KwzunR+x0wgfCe1l5m6AGdOcxnZOccz53NSe6Bb3bA0YwLvYn+XgujRriUorawIciXuDKWkmtZEjFazcLmMtNHGhTO2InK5AboUNw/lTPlQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xaP3m1Xi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xpdWArRV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jY7DUhZL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WkiNOTsi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xaP3m1Xi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xpdWArRV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jY7DUhZL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WkiNOTsi"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA97A21964;
	Fri, 30 Aug 2024 07:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725003427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8RvRQT1in+MKT1pbHTjb0EBgbra8YJnvLq2oWynNJOI=;
	b=xaP3m1XiRbUpeBwraTVkQF4rF0iUpJPpOjmUJ7D5wVehNvxI4sEkxENFJp51v8OLxpqjo1
	3jw2A+AFhsYEWgNnUVZf7w6J1LcuIJL2LAIqGHx9sy/oaeZwXo2/cmgcYXgvbZisb7PqjE
	1DXb2LS1F5CiiycrT8CdaaUoK+d5HAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725003427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8RvRQT1in+MKT1pbHTjb0EBgbra8YJnvLq2oWynNJOI=;
	b=xpdWArRVlt0zD0goI6nDm/3Eq5bO8LUVTCbtkMP47eSYLGk4j+BNQn+paYGPryK5uQnfkB
	PfXJL1SHrgVdq3Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jY7DUhZL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WkiNOTsi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725003426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8RvRQT1in+MKT1pbHTjb0EBgbra8YJnvLq2oWynNJOI=;
	b=jY7DUhZLl9dLxCHAEDyMQ2vwUdZ38uUr7HjSJ0pK2ybbZVB4+Rs3ekXU++5+nssZCU+Hti
	gn4IjQB5ozPqSIoYC0qhn54f+9iqXte61YG+L5r2bH5kOQ02pJ5nRRbRwFRPz04KfVCS3F
	nEH1d5erlJVMNrGviveyIHH0JteH+T8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725003426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8RvRQT1in+MKT1pbHTjb0EBgbra8YJnvLq2oWynNJOI=;
	b=WkiNOTsidrbYTaEqmjoashrQJdolyQ3JQK8JFfJzwXgbSCav7EaYEg2pFtYsjF0md6DA3H
	Yf7RxhtIZ07NgpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63E0F13A44;
	Fri, 30 Aug 2024 07:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tJy7F6J20WbuZAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 30 Aug 2024 07:37:06 +0000
Message-ID: <1c0e3013-2016-491d-97b0-6c1b25c9a3eb@suse.cz>
Date: Fri, 30 Aug 2024 09:37:05 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Michal Hocko <mhocko@suse.com>, Barry Song <21cnbao@gmail.com>
Cc: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com,
 david@redhat.com, hailong.liu@oppo.com, hch@infradead.org,
 iamjoonsoo.kim@lge.com, laoar.shao@gmail.com,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org, penberg@kernel.org,
 rientjes@google.com, roman.gushchin@linux.dev,
 torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com,
 virtualization@lists.linux.dev
References: <CAGsJ_4wZiE08XDjNAPENwH=KQEzdm2FB_bMDi0b7PJx+e7ydrA@mail.gmail.com>
 <20240829223114.1102-1-21cnbao@gmail.com> <ZtFzvU1wiBSlhzzY@tiehlicka>
Content-Language: en-US
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
In-Reply-To: <ZtFzvU1wiBSlhzzY@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA97A21964
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[suse.com,gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[19];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,linux.com,redhat.com,oppo.com,infradead.org,lge.com,vger.kernel.org,kvack.org,kernel.org,google.com,linux.dev,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 8/30/24 09:24, Michal Hocko wrote:
> On Fri 30-08-24 10:31:14, Barry Song wrote:
>> > > > Patch 4/4: We will move the order > 1 check from the current fast path
>> > > > to the slow path and extend
>> > > >                  the check of gfp_direct_reclaim flag also in the slow path.
>> > >
>> > > OK, let's have that go in now as well.
>> 
>> Hi Michal and Vlastimil,
>> Could you please review the changes below before I send v4 for patch 4/4?
>> 
>> 1. We should consolidate all warnings in one place. Currently, the order > 1 warning is
>> in the hotpath, while others are in less likely scenarios. Moving all warnings to the
>> slowpath will reduce the overhead for order > 1 and increase the visibility of other
>> warnings.
>> 
>> 2. We currently have two warnings for order: one for order > 1 in the hotpath and another
>> for order > costly_order in the laziest path. I suggest standardizing on order > 1 since
>> it’s been in use for a long time.
>> 
>> 3.I don't think we need to check for __GFP_NOWARN in this case. __GFP_NOWARN is
>> meant to suppress allocation failure reports, but here we're dealing with bug detection, not
>> allocation failures.

Ack. __GFP_NOWARN is to suppress warnings in case the allocation has a less
expensive fallback to the current attempt, which logically means the current
attempt can't be a __GFP_NOFAIL one. So having both is a bug itself (not
worth reporting) so we can just ignore __GFP_NOWARN.

>> So I'd rather use WARN_ON_ONCE than WARN_ON_ONCE_GFP.
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index c81ee5662cc7..0d3dd679d0ab 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3033,12 +3033,6 @@ struct page *rmqueue(struct zone *preferred_zone,
>>  {
>>  	struct page *page;
>>  
>> -	/*
>> -	 * We most definitely don't want callers attempting to
>> -	 * allocate greater than order-1 page units with __GFP_NOFAIL.
>> -	 */
>> -	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>> -
>>  	if (likely(pcp_allowed_order(order))) {
>>  		page = rmqueue_pcplist(preferred_zone, zone, order,
>>  				       migratetype, alloc_flags);
>> @@ -4174,6 +4168,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>>  						struct alloc_context *ac)
>>  {
>>  	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
>> +	bool nofail = gfp_mask & __GFP_DIRECT_RECLAIM;

__GFP_NOFAIL

>>  	bool can_compact = gfp_compaction_allowed(gfp_mask);
>>  	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
>>  	struct page *page = NULL;
>> @@ -4187,6 +4182,25 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>>  	unsigned int zonelist_iter_cookie;
>>  	int reserve_flags;
>>  
>> +	if (nofail) {

Could add unlikely() to put it off the instruction cache hotpath.

>> +		/*
>> +		 * We most definitely don't want callers attempting to
>> +		 * allocate greater than order-1 page units with __GFP_NOFAIL.
>> +		 */
>> +		WARN_ON_ONCE(order > 1);
>> +		/*
>> +		 * Also we don't support __GFP_NOFAIL without __GFP_DIRECT_RECLAIM,
>> +		 * otherwise, we may result in lockup.
>> +		 */
>> +		WARN_ON_ONCE(!can_direct_reclaim);
>> +		/*
>> +		 * PF_MEMALLOC request from this context is rather bizarre
>> +		 * because we cannot reclaim anything and only can loop waiting
>> +		 * for somebody to do a work for us.
>> +		 */
>> +		WARN_ON_ONCE(current->flags & PF_MEMALLOC);
>> +	}
> 
> Yes, this makes sense. Any reason you have not put that int the nofail
> branch below?

Because that branch is executed only when we're already so depleted we gave
up retrying, and we want to warn about the buggy users more reliably (see
point 1 above).

>> +
>>  restart:
>>  	compaction_retries = 0;
>>  	no_progress_loops = 0;
>> @@ -4404,29 +4418,15 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>>  	 * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
>>  	 * we always retry
>>  	 */
>> -	if (gfp_mask & __GFP_NOFAIL) {
>> +	if (nofail) {
>>  		/*
>> -		 * All existing users of the __GFP_NOFAIL are blockable, so warn
>> -		 * of any new users that actually require GFP_NOWAIT
>> +		 * Lacking direct_reclaim we can't do anything to reclaim memory,
>> +		 * we disregard these unreasonable nofail requests and still
>> +		 * return NULL
>>  		 */
>> -		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>> +		if (!can_direct_reclaim)
>>  			goto fail;
>>  
>> -		/*
>> -		 * PF_MEMALLOC request from this context is rather bizarre
>> -		 * because we cannot reclaim anything and only can loop waiting
>> -		 * for somebody to do a work for us
>> -		 */
>> -		WARN_ON_ONCE_GFP(current->flags & PF_MEMALLOC, gfp_mask);
>> -
>> -		/*
>> -		 * non failing costly orders are a hard requirement which we
>> -		 * are not prepared for much so let's warn about these users
>> -		 * so that we can identify them and convert them to something
>> -		 * else.
>> -		 */
>> -		WARN_ON_ONCE_GFP(costly_order, gfp_mask);
>> -
>>  		/*
>>  		 * Help non-failing allocations by giving some access to memory
>>  		 * reserves normally used for high priority non-blocking
>> 
>> > >
>> > > --
>> > > Michal Hocko
>> > > SUSE Labs
>> 
>> Thanks
>> Barry
> 

