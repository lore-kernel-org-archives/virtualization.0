Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DE81AC432
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421093; cv=none; b=gqL+44WgN+Tw/Z69TTQ8QCBwZtg+pERa+AMBDWLZ98OdfjBh3L9juVCC+2uhQ8WPIcv3MPB3QmmyC2SuvtCPUMs4c9/erhG4RuQKVlGx6eyRSXaq+GpAk3VyOZlLxC0QExW0fK6xEdbVetty/JnbpWeqrLrml4zlPnNrFQV/rlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421093; c=relaxed/simple;
	bh=SkurDBU9GoE98rcgcI2fvwuisFE0N+GGr3AgZb4Qlio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTDWZQYG8jDJ5CDu0Rw5GsuTAW1FMhrxD6Uk9OEwzqUHT4H8FBOO9E7TMz0jBjKuG+Sl2fIsOyX8wgeqBcHSS5heUGFNyUsOef1eDfgtkB9gN+vd/liwBUcPJZi7b4byVADglHquS4X+bJ/WG+G//ahtAldsPslEyX9iQo3NDLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CwLk7OIL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pqIKw7mj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CwLk7OIL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pqIKw7mj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CwLk7OIL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pqIKw7mj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CwLk7OIL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pqIKw7mj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3A5A21C74;
	Wed, 31 Jul 2024 10:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722421088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ErpJeAZgl9yTNOSDVqhx7qLsNam3QLLe1W44joaSZQM=;
	b=CwLk7OILlxktlyaPrtiCniKgmDj8qyzr8pf6D2fkVP8PfK84E3/Dxn/6PwUmykGrrlj4xe
	7ktXfTJe9/lLeQahCgLONylCFRcC5zxk/O/hScumeU+EywccCWfokBq/z3pbTL5A8fbE6X
	16cCuQL/9rwkVOn9s88j5QeOrh1UNsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722421088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ErpJeAZgl9yTNOSDVqhx7qLsNam3QLLe1W44joaSZQM=;
	b=pqIKw7mj8Labl0i+OH9cOMrTxFt1l2lvxfvhPNcRg9nG9e9YRa88YnI+P5hYlY/r9eVUFJ
	wqs1OHbkDwTIw2Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722421088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ErpJeAZgl9yTNOSDVqhx7qLsNam3QLLe1W44joaSZQM=;
	b=CwLk7OILlxktlyaPrtiCniKgmDj8qyzr8pf6D2fkVP8PfK84E3/Dxn/6PwUmykGrrlj4xe
	7ktXfTJe9/lLeQahCgLONylCFRcC5zxk/O/hScumeU+EywccCWfokBq/z3pbTL5A8fbE6X
	16cCuQL/9rwkVOn9s88j5QeOrh1UNsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722421088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ErpJeAZgl9yTNOSDVqhx7qLsNam3QLLe1W44joaSZQM=;
	b=pqIKw7mj8Labl0i+OH9cOMrTxFt1l2lvxfvhPNcRg9nG9e9YRa88YnI+P5hYlY/r9eVUFJ
	wqs1OHbkDwTIw2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE5AF13297;
	Wed, 31 Jul 2024 10:18:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4dcSMl8PqmZxKQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 31 Jul 2024 10:18:07 +0000
Message-ID: <c1318686-5c58-4c05-ab33-0fb9bae6cf1a@suse.cz>
Date: Wed, 31 Jul 2024 12:18:07 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm: Document __GFP_NOFAIL must be blockable
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com,
 mhocko@suse.com, penberg@kernel.org, rientjes@google.com,
 roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com,
 v-songbaohua@oppo.com, virtualization@lists.linux.dev
References: <20240731000155.109583-1-21cnbao@gmail.com>
 <20240731000155.109583-3-21cnbao@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240731000155.109583-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.59 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.com,oppo.com,infradead.org,lge.com,suse.com,kernel.org,google.com,linux.dev,linux-foundation.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.59

On 7/31/24 2:01 AM, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Non-blocking allocation with __GFP_NOFAIL is not supported and may
> still result in NULL pointers (if we don't return NULL, we result
> in busy-loop within non-sleepable contexts):
> 
> static inline struct page *
> __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> 						struct alloc_context *ac)
> {
> 	...
> 	/*
> 	 * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
> 	 * we always retry
> 	 */
> 	if (gfp_mask & __GFP_NOFAIL) {
> 		/*
> 		 * All existing users of the __GFP_NOFAIL are blockable, so warn
> 		 * of any new users that actually require GFP_NOWAIT
> 		 */
> 		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> 			goto fail;
> 		...
> 	}
> 	...
> fail:
> 	warn_alloc(gfp_mask, ac->nodemask,
> 			"page allocation failure: order:%u", order);
> got_pg:
> 	return page;
> }
> 
> Highlight this in the documentation of __GFP_NOFAIL so that non-mm
> subsystems can reject any illegal usage of __GFP_NOFAIL with
> GFP_ATOMIC, GFP_NOWAIT, etc.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/gfp_types.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index 313be4ad79fd..4a1fa7706b0c 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -215,7 +215,8 @@ enum {
>   * the caller still has to check for failures) while costly requests try to be
>   * not disruptive and back off even without invoking the OOM killer.
>   * The following three modifiers might be used to override some of these
> - * implicit rules.
> + * implicit rules. Please note that all of them must be used along with
> + * %__GFP_DIRECT_RECLAIM flag.
>   *
>   * %__GFP_NORETRY: The VM implementation will try only very lightweight
>   * memory direct reclaim to get some memory under memory pressure (thus
> @@ -246,6 +247,8 @@ enum {
>   * cannot handle allocation failures. The allocation could block
>   * indefinitely but will never return with failure. Testing for
>   * failure is pointless.
> + * It _must_ be blockable and used together with __GFP_DIRECT_RECLAIM.
> + * It should _never_ be used in non-sleepable contexts.

So this second line is a bit redundant as you can't use __GFP_DIRECT_RECLAIM
in non-sleepable contexts. But can't hurt so not a objection.

>   * New users should be evaluated carefully (and the flag should be
>   * used only when there is no reasonable failure policy) but it is
>   * definitely preferable to use the flag rather than opencode endless

