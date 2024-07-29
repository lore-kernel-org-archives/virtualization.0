Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6E1422A2
	for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247392; cv=none; b=bRA6P6kxX3QTQ15nVfTG6QVX1Kkj8xQ1WgCCnVVAJB6Gd59pisU8a9Ubb91Lep5tVPCTi16uQI04tFQBS1+KZgeu0YzoEMbjeE1cCquhAwGW8I/yMvLNzcCvdwH8FO5sjEn2G1DHHQjLByXcfeFdpGKNuXOgr/EZ2ybkA/+jBas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247392; c=relaxed/simple;
	bh=sDCI7sykzYG0pcqU9AXz+c3J3rcxGYUg9rGy5sZ97Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9SElu+bFP4G+i0tErDH5beCTePs3OUpIWQqZRvHGbPphABtjZDNLUMUXvkbcm2JwVQaLmv6zt6uz+AGf7SlbaDgRUsL5J/XYRT/qLFPOuNp0LpM9iPsTEJuk1cbuWnJ8PFFW7dsXsrpvETu+melYubfOLRa3oZlEWTtHi2RSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QoAxB2hP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kzEXxFpK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QoAxB2hP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kzEXxFpK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QoAxB2hP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kzEXxFpK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QoAxB2hP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kzEXxFpK"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E55D1F78C;
	Mon, 29 Jul 2024 10:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722247388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c72NiUMllkAjqYeKR+3W5ydnZ8umaPIRwnENiRuiyTY=;
	b=QoAxB2hP14KL+mqEMSi7kKX3DsoifOfjzul0oM5SUwOqTP9Ogd6VmwFddBP8u5H1+9tdZ1
	nQD4LYlhrv/2eZMtnoGBS+fIZ0DXPeuA5+K+QqauK3AGwnytleWKrObyK0rd1DunmdTWq7
	PM55yNMm8i0/gWJW2KNzO5Yd7HHNT5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722247388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c72NiUMllkAjqYeKR+3W5ydnZ8umaPIRwnENiRuiyTY=;
	b=kzEXxFpKcs1Fw10lfnVqkZDEh6xb0C9a8bYGxsEfW3Bba9jC4Hkj3pPMrd4G+bHR+dPuPP
	q10Ar+A9RD6ElRBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722247388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c72NiUMllkAjqYeKR+3W5ydnZ8umaPIRwnENiRuiyTY=;
	b=QoAxB2hP14KL+mqEMSi7kKX3DsoifOfjzul0oM5SUwOqTP9Ogd6VmwFddBP8u5H1+9tdZ1
	nQD4LYlhrv/2eZMtnoGBS+fIZ0DXPeuA5+K+QqauK3AGwnytleWKrObyK0rd1DunmdTWq7
	PM55yNMm8i0/gWJW2KNzO5Yd7HHNT5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722247388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c72NiUMllkAjqYeKR+3W5ydnZ8umaPIRwnENiRuiyTY=;
	b=kzEXxFpKcs1Fw10lfnVqkZDEh6xb0C9a8bYGxsEfW3Bba9jC4Hkj3pPMrd4G+bHR+dPuPP
	q10Ar+A9RD6ElRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23D72138A7;
	Mon, 29 Jul 2024 10:03:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C3wVCNxop2YVFwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 29 Jul 2024 10:03:08 +0000
Message-ID: <c7296bf6-e730-4a75-bf16-825a2dedb3bc@suse.cz>
Date: Mon, 29 Jul 2024 12:03:07 +0200
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
To: Barry Song <21cnbao@gmail.com>, Christoph Hellwig <hch@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
 iamjoonsoo.kim@lge.com, lstoakes@gmail.com, penberg@kernel.org,
 rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com,
 v-songbaohua@oppo.com, virtualization@lists.linux.dev, hailong.liu@oppo.com,
 torvalds@linux-foundation.org
References: <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
 <ZqD9-yzGxQIFlxGQ@infradead.org> <ZqD_ydjhUI_GCgSg@tiehlicka>
 <ZqEAUbtkIMCwVpgB@infradead.org> <ZqECPiU-3fJozzpB@tiehlicka>
 <400b2f6f-f7f0-4888-99ee-7327faad7e5c@suse.cz>
 <ZqED4bEIJGGHxsHY@infradead.org> <ZqEGAh6R7yoR5L1n@tiehlicka>
 <ZqEHuaUGuuUaL_AY@infradead.org>
 <5b9fa06a-bcef-447c-899b-fe3fb10315bf@suse.cz>
 <ZqESn11SG7fU4cG-@infradead.org>
 <CAGsJ_4w5Ypv7qOmibB6g1zw_hdvG-ijsM=QtM8=YiybUqxdh2A@mail.gmail.com>
 <CAGsJ_4zqW=P6gPTtzT5_E-5ry2xQSCKfPNpcvbmApregUofVbw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAGsJ_4zqW=P6gPTtzT5_E-5ry2xQSCKfPNpcvbmApregUofVbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.41 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,linux-foundation.org,kvack.org,gmail.com,linux.com,lge.com,kernel.org,google.com,linux.dev,oppo.com,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,infradead.org:email]
X-Spam-Flag: NO
X-Spam-Score: 0.41

On 7/29/24 11:56 AM, Barry Song wrote:
> On Thu, Jul 25, 2024 at 1:47 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Thu, Jul 25, 2024 at 2:41 AM Christoph Hellwig <hch@infradead.org> wrote:
>> >
>> > On Wed, Jul 24, 2024 at 04:39:11PM +0200, Vlastimil Babka wrote:
>> > > On 7/24/24 3:55 PM, Christoph Hellwig wrote:
>> > > > On Wed, Jul 24, 2024 at 03:47:46PM +0200, Michal Hocko wrote:
>> > > >> OK, now it makes more sense ;) I have absolutely no objections to
>> > > >> prefering scoped NO{FS,IO} interfaces of course. And that would indeed
>> > > >> eliminate a need for defining GFP_NO{FS,IO}_NOFAIL alternatives.
>> > > >
>> > > > Yes.  My proposal would be:
>> > > >
>> > > > GFP_NOFAIL without any modifiers it the only valid nofail API.
>> > >
>> > > Where GFP_NOFAIL is GFP_KERNEL | __GFP_NOFAIL (and not the more limited one
>> > > as defined in patch 4/5).
>> >
>> > Yes.
>> >
>> > > > File systems / drivers can combine іt with the scoped nofs/noio if
>> > > > needed.
>> > >
>> > > Sounds good, how quickly we can convert existing __GFP_NOFAIL users remains
>> > > to be seen...
>> >
>> > I took a quick look at the file system ones and they look pretty easy.  I
>> > think it would be good to a quick scriped run for everything that does
>> > GFP_KERNEL | __GFP_NOFAIL right now, and then spend a little time on
>> > the rest.
> 
> I assume you mean something as the below?

This would work but looks too much like a workaround to fit with the new
rules without actually fulfiling the purpose of the scopes. I.e. it's
possible this allocation is in fact part of a larger NOIO scope that should
be marked accordingly, and not just wrap this single kmalloc.

> diff --git a/drivers/md/dm-region-hash.c b/drivers/md/dm-region-hash.c
> index a4550975c27d..b90ef94b1a09 100644
> --- a/drivers/md/dm-region-hash.c
> +++ b/drivers/md/dm-region-hash.c
> @@ -291,10 +291,13 @@ static void __rh_insert(struct dm_region_hash
> *rh, struct dm_region *reg)
>  static struct dm_region *__rh_alloc(struct dm_region_hash *rh, region_t region)
>  {
>         struct dm_region *reg, *nreg;
> +       int orig_flags;
> 
>         nreg = mempool_alloc(&rh->region_pool, GFP_ATOMIC);
> +       orig_flags = memalloc_noio_save();
>         if (unlikely(!nreg))
> -               nreg = kmalloc(sizeof(*nreg), GFP_NOIO | __GFP_NOFAIL);
> +               nreg = kmalloc(sizeof(*nreg), GFP_NOFAIL);
> +       memalloc_noio_restore(orig_flags);
> 
>         nreg->state = rh->log->type->in_sync(rh->log, region, 1) ?
>                       DM_RH_CLEAN : DM_RH_NOSYNC;

