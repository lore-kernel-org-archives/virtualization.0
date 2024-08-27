Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52585747F
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744335; cv=none; b=fAv/CxVDkGSUn9daJY+/MKJsvGGpi04ktbvWsEQzf4q9gCIGGNuzFKDAXEDSmXpJm2Z+ejzJVGJJ0luyHRS2w+BIG+NkERYLyxYe4UYcVPFD/As6jJRSEQ98BinUlMYfWDk9X3fVwNORN+1wk6iQ/Yks3X8nn0Tt7hMIpeDWCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744335; c=relaxed/simple;
	bh=XSpU8pWWgy1Vt7KqvcZqhh1xcuTDx8xvFLSF2633VY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=teoGeY+bWjmwFXQ+j6Fuz2LA8w0tYS1i4VKApkEkhtukmLkXgWl9SaYj8s0SmnHATqIBJjvjta8yvlmc3vCywDzY/Va6+om0tz9h8zqyXtrW3Xi05IjbOi6pXAp1Y6KudU/X1qw6tZ5d0vUCXyYmYBz/Izi3VBwQJ2CP0s50rjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mw+10Zne; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=voy0EpCD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mw+10Zne; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=voy0EpCD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mw+10Zne";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="voy0EpCD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mw+10Zne";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="voy0EpCD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75BD821B07;
	Tue, 27 Aug 2024 07:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724744331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9xOpYhsvJDLKARD1MYOOuGWdxCA0HLemjilzwpAeaXI=;
	b=mw+10ZneMRHGVdSQ+4mKMzq0+jqAAC97jDGdNPXTbaU8yQfQdprXzbYTz3/6OoSPmhkhtP
	j8T3Soxlg5PWBaSmkjxYRjMdH3GHgxaLx4sCawzlcX1ZabgIhbp5bLTqWnZoJnl7Y2E3l+
	GVJAr5SrY7OkPQdFpaGnLdWE5a6lVP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724744331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9xOpYhsvJDLKARD1MYOOuGWdxCA0HLemjilzwpAeaXI=;
	b=voy0EpCDVStftd/ZW5bDjVlijSJw29TB3bs2uhVun2fcpeyJx/LpgDo9UMSPbQtsPbxwG7
	pJcrpjhh3VaOfWAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724744331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9xOpYhsvJDLKARD1MYOOuGWdxCA0HLemjilzwpAeaXI=;
	b=mw+10ZneMRHGVdSQ+4mKMzq0+jqAAC97jDGdNPXTbaU8yQfQdprXzbYTz3/6OoSPmhkhtP
	j8T3Soxlg5PWBaSmkjxYRjMdH3GHgxaLx4sCawzlcX1ZabgIhbp5bLTqWnZoJnl7Y2E3l+
	GVJAr5SrY7OkPQdFpaGnLdWE5a6lVP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724744331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9xOpYhsvJDLKARD1MYOOuGWdxCA0HLemjilzwpAeaXI=;
	b=voy0EpCDVStftd/ZW5bDjVlijSJw29TB3bs2uhVun2fcpeyJx/LpgDo9UMSPbQtsPbxwG7
	pJcrpjhh3VaOfWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EE5B13A44;
	Tue, 27 Aug 2024 07:38:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aqHPEouCzWYZfgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 27 Aug 2024 07:38:51 +0000
Message-ID: <c258403c-afc5-4969-b7c5-fa2a6c257371@suse.cz>
Date: Tue, 27 Aug 2024 09:38:50 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>,
 Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org,
 rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com,
 v-songbaohua@oppo.com, virtualization@lists.linux.dev
References: <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka>
 <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka>
 <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka>
 <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka>
 <59e90825-4efa-4384-8286-06c0235304dc@redhat.com>
 <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com>
 <be4c9110-72d0-4749-941e-797a861d8319@suse.cz>
 <CAGsJ_4znRBscU8FWMZL7Z9qLUMxCPtupRcJqu+PXz260p-S6MA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAGsJ_4znRBscU8FWMZL7Z9qLUMxCPtupRcJqu+PXz260p-S6MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,redhat.com,suse.com,gmail.com,kvack.org,linux.com,oppo.com,infradead.org,lge.com,kernel.org,google.com,linux.dev,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 8/27/24 09:15, Barry Song wrote:
> On Tue, Aug 27, 2024 at 12:10 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 8/22/24 11:34, Linus Torvalds wrote:
>> > On Thu, 22 Aug 2024 at 17:27, David Hildenbrand <david@redhat.com> wrote:
>> >>
>> >> To me, that implies that if you pass in MAX_ORDER+1 the VM will "retry
>> >> infinitely". if that implies just OOPSing or actually be in a busy loop,
>> >> I don't care. It could effectively happen with MAX_ORDER as well, as
>> >> stated. But certainly not BUG_ON.
>> >
>> > No BUG_ON(), but also no endless loop.
>> >
>> > Just return NULL for bogus users. Really. Give a WARN_ON_ONCE() to
>> > make it easy to find offenders, and then let them deal with it.
>>
>> Right now we give the WARN_ON_ONCE() (for !can_direct_reclaim) only when
>> we're about to actually return NULL, so the memory has to be depleted
>> already. To make it easier to find the offenders much more reliably, we
>> should consider doing it sooner, but also not add unnecessary overhead to
>> allocator fastpaths just because of the potentially buggy users. So either
>> always in __alloc_pages_slowpath(), which should be often enough (unless the
>> system never needs to wake up kswapd to reclaim) but with negligible enough
>> overhead, or on every allocation but only with e.g. CONFIG_DEBUG_VM?
> 
> We already have a WARN_ON for order > 1 in rmqueue. we might extend
> the condition there to include checking flags as well?

Ugh, wasn't aware, well spotted. So it means there at least shouldn't be
existing users of __GFP_NOFAIL with order > 1 :)

But also the check is in the hotpath, even before trying the pcplists, so we
could move it to __alloc_pages_slowpath() while extending it?

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7dcb0713eb57..b5717c6569f9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3071,8 +3071,11 @@ struct page *rmqueue(struct zone *preferred_zone,
>   /*
>   * We most definitely don't want callers attempting to
>   * allocate greater than order-1 page units with __GFP_NOFAIL.
> + * Also we don't support __GFP_NOFAIL without __GFP_DIRECT_RECLAIM,
> + * which can result in a lockup
>   */
> - WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> + WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) &&
> +     (order > 1 || !(gfp_flags & __GFP_DIRECT_RECLAIM)));
> 
>   if (likely(pcp_allowed_order(order))) {
>   page = rmqueue_pcplist(preferred_zone, zone, order,
> 
>>
>> > Don't take it upon yourself to say "we have to deal with any amount of
>> > stupidity".
>> >
>> > The MM layer is not some slave to users. The MM layer is one of the
>> > most core pieces of code in the kernel, and as such the MM layer is
>> > damn well in charge.
>> >
>> > Nobody has the right to say "I will not deal with allocation
>> > failures". The MM should not bend over backwards over something like
>> > that.
>> >
>> > Seriously. Get a spine already, people. Tell random drivers that claim
>> > that they cannot deal with errors to just f-ck off.
>> >
>> > And you don't do it by looping forever, and you don't do it by killing
>> > the kernel. You do it by ignoring their bullying tactics.
>> >
>> > Then you document the *LIMITED* cases where you actually will try forever.
>> >
>> > This discussion has gone on for too damn long.
>> >
>> >               Linus
>>

