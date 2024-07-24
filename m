Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2E15A848
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831955; cv=none; b=avIXUb61xEVElP93mXUwt+5PiWo3Y+w4cgFz/VupY9CDmxBBYYa/djzo7ee2X9ubRozJQVRUpEQh9UuMbVKBLpqgfW0PhejoO/033o/Yi7yoz1YnQynqzlM4uPL3DQsdQyf7ypQvKqYE7kkCO5/tbjmY6BGPYvtksRux5hj6VIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831955; c=relaxed/simple;
	bh=r5/vCYqMd2kgEc9pelg0D+jZrYZRD3r53vTJ9wWx2wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqAJPsOvbU5qrDG/tgsDqr1lPhNJ4J0CwcaoJ+E6G1zMbFsX29ECGl6R84p5R6hRwBQ18qaR7HkdfULiEZZUS7p/nxHE/T9cw7M0Ut8mn0qrx3TDyVstBs201HQoAG/TefOry2FAv9Fu22sVTA3Y7WK2jS67gGE0qcr73G+yo7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RYG7ewe8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pxcZCNGr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E7mKmzrk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dzNXbAPp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RYG7ewe8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pxcZCNGr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E7mKmzrk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dzNXbAPp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF7C921B28;
	Wed, 24 Jul 2024 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721831952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cJ+73etKYh5Jxji2UyicILi9TzDCdDcVgYTTiBitHTs=;
	b=RYG7ewe8UzLNdaH5NdrlBCDeqIitvFnxHZw01Wts5JpE51g6aY4G6L+28y0mHm2mzz4Y2m
	TKtD70ZkQT/GcOY95VifwDaeVGqp1pln+DtGWcpLkwZOXOKwq2fFfFES7HknchJAqWwuSq
	3oFJUgHCHWLzBJGp3nlZW4/yVLG2/Vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721831952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cJ+73etKYh5Jxji2UyicILi9TzDCdDcVgYTTiBitHTs=;
	b=pxcZCNGr47cVwOMvXJz8eu+5HFHocFvNWNJZjCVSbPNdJTyMYZLQdzL04pRN0CsuuovvoP
	4puITBf7cT+HgxBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E7mKmzrk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dzNXbAPp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721831951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cJ+73etKYh5Jxji2UyicILi9TzDCdDcVgYTTiBitHTs=;
	b=E7mKmzrkGyFrtmIIay/7cx3cI6OTvSXSkZKfzcrNXzrwr3JQLI0QZTi/yRyeyV61Rxvexr
	0W/+PebLhZV9kv4rFEAFfeNBDXiEGeOw0kN5k+YblJy72rYmcwElywHmG4GFupqs635Mr7
	SHrqnlNQa6SBfIwy083NV4jxvUuR80A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721831951;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cJ+73etKYh5Jxji2UyicILi9TzDCdDcVgYTTiBitHTs=;
	b=dzNXbAPpYOkbXfB5SGvAYi7TXtYuAak8abuHzO9dfZJl8k1Y01y5wNhupqAWMPRv/Dyv6n
	TryLc3mbYWpGDFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB9FF13411;
	Wed, 24 Jul 2024 14:39:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wgwyKQ8SoWY2KQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 24 Jul 2024 14:39:11 +0000
Message-ID: <5b9fa06a-bcef-447c-899b-fe3fb10315bf@suse.cz>
Date: Wed, 24 Jul 2024 16:39:11 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>, Michal Hocko <mhocko@suse.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
 iamjoonsoo.kim@lge.com, lstoakes@gmail.com, penberg@kernel.org,
 rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com,
 v-songbaohua@oppo.com, virtualization@lists.linux.dev, hailong.liu@oppo.com,
 torvalds@linux-foundation.org
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
 <ZqD9-yzGxQIFlxGQ@infradead.org> <ZqD_ydjhUI_GCgSg@tiehlicka>
 <ZqEAUbtkIMCwVpgB@infradead.org> <ZqECPiU-3fJozzpB@tiehlicka>
 <400b2f6f-f7f0-4888-99ee-7327faad7e5c@suse.cz>
 <ZqED4bEIJGGHxsHY@infradead.org> <ZqEGAh6R7yoR5L1n@tiehlicka>
 <ZqEHuaUGuuUaL_AY@infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <ZqEHuaUGuuUaL_AY@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kvack.org,linux.com,lge.com,kernel.org,google.com,linux.dev,oppo.com,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Rspamd-Queue-Id: CF7C921B28

On 7/24/24 3:55 PM, Christoph Hellwig wrote:
> On Wed, Jul 24, 2024 at 03:47:46PM +0200, Michal Hocko wrote:
>> OK, now it makes more sense ;) I have absolutely no objections to
>> prefering scoped NO{FS,IO} interfaces of course. And that would indeed
>> eliminate a need for defining GFP_NO{FS,IO}_NOFAIL alternatives.
> 
> Yes.  My proposal would be:
> 
> GFP_NOFAIL without any modifiers it the only valid nofail API.

Where GFP_NOFAIL is GFP_KERNEL | __GFP_NOFAIL (and not the more limited one
as defined in patch 4/5).

> File systems / drivers can combine іt with the scoped nofs/noio if
> needed.

Sounds good, how quickly we can convert existing __GFP_NOFAIL users remains
to be seen...
