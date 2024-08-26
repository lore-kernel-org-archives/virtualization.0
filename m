Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6318CC0B
	for <virtualization@lists.linux.dev>; Mon, 26 Aug 2024 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674252; cv=none; b=j0yHmICqEWzlLYLQbtbeqAyK7ZpDnbhbQTBnqsu6ZLrfuyT5Ocm0ZelldP/BKgFqqTIHK/lxoPHpJaP1LzTdQjFjaApy6xGapmMq2YXXlIv8ocymQD0kOq8HHsi6RBLZClxDF9wApqEZENyk50/2WSjSpJ4k+YoJdYgFlYleL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674252; c=relaxed/simple;
	bh=R4AhUliLQ0XTOaeOPv6HvsMSyxSwplPAASsuw8h0ISM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXV91v6/OSGeRefcBe5GeYC/wI1RrQxq+Bkll8HVRiYv4B/4noyFISdDXhUB33gWxmvvfdqs+U3ldIqac+rbaioC9GjKm3kv+dWLRrP0QpWAQFCvI5yo/1FM3T5ucKnR2YrKJTi/OBRZffK25rukQCq2Bt3Z31YkWC6gSevS3xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nBaNdRWM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E2DmYrpI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nBaNdRWM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E2DmYrpI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nBaNdRWM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E2DmYrpI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nBaNdRWM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E2DmYrpI"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B10F21F855;
	Mon, 26 Aug 2024 12:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724674248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZCtIjjrAmITyqwuCw1IT7gRKA2nB6TNPwhjXE7+PFBI=;
	b=nBaNdRWM3771YAcHzERz9XUa/b0ssoI2rsKs9kj0w++xbn3KeQBmiOr85SrXMDmh28TUYq
	2o3/7kqDdeU3ga7W008u89R40rcvCMptwYHlZOHYKWmm4UhI5sWGBKJA5gWl2QnN5XlfOx
	/SUQ/g8xSKtyUh2bSvRgy6Uyy3xuTw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724674248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZCtIjjrAmITyqwuCw1IT7gRKA2nB6TNPwhjXE7+PFBI=;
	b=E2DmYrpIDSUER4bhx9vK+KdQGQZtSIjMrbZuPL1Uumd3D1ZLQPKOFLIxofgWZVCbuyYQYy
	COPMhPF+QOJBGGBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724674248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZCtIjjrAmITyqwuCw1IT7gRKA2nB6TNPwhjXE7+PFBI=;
	b=nBaNdRWM3771YAcHzERz9XUa/b0ssoI2rsKs9kj0w++xbn3KeQBmiOr85SrXMDmh28TUYq
	2o3/7kqDdeU3ga7W008u89R40rcvCMptwYHlZOHYKWmm4UhI5sWGBKJA5gWl2QnN5XlfOx
	/SUQ/g8xSKtyUh2bSvRgy6Uyy3xuTw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724674248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZCtIjjrAmITyqwuCw1IT7gRKA2nB6TNPwhjXE7+PFBI=;
	b=E2DmYrpIDSUER4bhx9vK+KdQGQZtSIjMrbZuPL1Uumd3D1ZLQPKOFLIxofgWZVCbuyYQYy
	COPMhPF+QOJBGGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D0EF1398D;
	Mon, 26 Aug 2024 12:10:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 26K5IchwzGbLJQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Aug 2024 12:10:48 +0000
Message-ID: <be4c9110-72d0-4749-941e-797a861d8319@suse.cz>
Date: Mon, 26 Aug 2024 14:10:48 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Linus Torvalds <torvalds@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Barry Song <21cnbao@gmail.com>,
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
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,linux-foundation.org,kvack.org,linux.com,oppo.com,infradead.org,lge.com,kernel.org,google.com,linux.dev,lists.linux.dev];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 8/22/24 11:34, Linus Torvalds wrote:
> On Thu, 22 Aug 2024 at 17:27, David Hildenbrand <david@redhat.com> wrote:
>>
>> To me, that implies that if you pass in MAX_ORDER+1 the VM will "retry
>> infinitely". if that implies just OOPSing or actually be in a busy loop,
>> I don't care. It could effectively happen with MAX_ORDER as well, as
>> stated. But certainly not BUG_ON.
> 
> No BUG_ON(), but also no endless loop.
> 
> Just return NULL for bogus users. Really. Give a WARN_ON_ONCE() to
> make it easy to find offenders, and then let them deal with it.

Right now we give the WARN_ON_ONCE() (for !can_direct_reclaim) only when
we're about to actually return NULL, so the memory has to be depleted
already. To make it easier to find the offenders much more reliably, we
should consider doing it sooner, but also not add unnecessary overhead to
allocator fastpaths just because of the potentially buggy users. So either
always in __alloc_pages_slowpath(), which should be often enough (unless the
system never needs to wake up kswapd to reclaim) but with negligible enough
overhead, or on every allocation but only with e.g. CONFIG_DEBUG_VM?

> Don't take it upon yourself to say "we have to deal with any amount of
> stupidity".
> 
> The MM layer is not some slave to users. The MM layer is one of the
> most core pieces of code in the kernel, and as such the MM layer is
> damn well in charge.
> 
> Nobody has the right to say "I will not deal with allocation
> failures". The MM should not bend over backwards over something like
> that.
> 
> Seriously. Get a spine already, people. Tell random drivers that claim
> that they cannot deal with errors to just f-ck off.
> 
> And you don't do it by looping forever, and you don't do it by killing
> the kernel. You do it by ignoring their bullying tactics.
> 
> Then you document the *LIMITED* cases where you actually will try forever.
> 
> This discussion has gone on for too damn long.
> 
>               Linus

