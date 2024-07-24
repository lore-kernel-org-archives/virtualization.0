Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A38152160
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814833; cv=none; b=YV39fGp8662KPKaSFbOt/GgcOForx0x4XqFiSH0cLDXiusB5mLolzqr8uSjh8KK/pSKvt7/L72EoI0VqzI0mxm9/DX/CkMuvqBiL1d8DDLFODpqbVgyiBv5hkCT3tBVWCa1N2SyuPPTReYRUDUuLpLR46stMneT7rn8kEyP/M4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814833; c=relaxed/simple;
	bh=3hKs8qkZ7dSI34464b8YTrEM3SgEJMphgQC/Q5KdptM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqoJnHlFJw/w1DM2tiiGRWia433ne7vbBb2mXrJlO1kGkb3oaHVHRt7ozBN/IrhBO/KxP82TTdE23q/U7aeofg8ebtuVpA2raY5OREz5xqNen/bn/em3dNGNDlTnZ/PUdD4qjtFkQ5AWSUAwhV25TQhXontwHiO4Lf4XSkl9zfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NoY1JBHc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2inUGRgU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NoY1JBHc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2inUGRgU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NoY1JBHc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2inUGRgU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NoY1JBHc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2inUGRgU"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF9591FBDB;
	Wed, 24 Jul 2024 09:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721814829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ukbFH+e+pXQ4MTnJHDhHEER+BkVPnLM4dfSIAkEL3vk=;
	b=NoY1JBHcOGhG6Sl7+a3rwqwkXr7v2gKjjauS8/zEpaWGTmkTHDjuRAIB5LX7ImGgZvx8nb
	K94e8V1q3zmJkc71fLPinxiSTJWCHUS9Y3hdyYKGVRIxbOu86pwJKPAoEu4sCjjt0Dolzd
	ymt79f6qyir5YZkPp+ikDyh2YqhX1L8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721814829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ukbFH+e+pXQ4MTnJHDhHEER+BkVPnLM4dfSIAkEL3vk=;
	b=2inUGRgUvLJtXBnpU/j/PhLAR6tk2lKr9B2tyQzAfpyGyw4OF4a4aGqthc/XySnXWfY3lZ
	cIChn6M10kuDo6Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NoY1JBHc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2inUGRgU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721814829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ukbFH+e+pXQ4MTnJHDhHEER+BkVPnLM4dfSIAkEL3vk=;
	b=NoY1JBHcOGhG6Sl7+a3rwqwkXr7v2gKjjauS8/zEpaWGTmkTHDjuRAIB5LX7ImGgZvx8nb
	K94e8V1q3zmJkc71fLPinxiSTJWCHUS9Y3hdyYKGVRIxbOu86pwJKPAoEu4sCjjt0Dolzd
	ymt79f6qyir5YZkPp+ikDyh2YqhX1L8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721814829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ukbFH+e+pXQ4MTnJHDhHEER+BkVPnLM4dfSIAkEL3vk=;
	b=2inUGRgUvLJtXBnpU/j/PhLAR6tk2lKr9B2tyQzAfpyGyw4OF4a4aGqthc/XySnXWfY3lZ
	cIChn6M10kuDo6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AE4413411;
	Wed, 24 Jul 2024 09:53:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z+pxIS3PoGbiXAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 24 Jul 2024 09:53:49 +0000
Message-ID: <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
Date: Wed, 24 Jul 2024 11:53:49 +0200
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
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: 42.hyeyoo@gmail.com, cl@linux.com, hch@infradead.org,
 iamjoonsoo.kim@lge.com, lstoakes@gmail.com, mhocko@suse.com,
 penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
 urezki@gmail.com, v-songbaohua@oppo.com, virtualization@lists.linux.dev,
 hailong.liu@oppo.com, torvalds@linux-foundation.org
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240724085544.299090-6-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AF9591FBDB
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
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org,kvack.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux.com,infradead.org,lge.com,suse.com,kernel.org,google.com,linux.dev,oppo.com,lists.linux.dev,linux-foundation.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]

On 7/24/24 10:55 AM, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> GFP_NOFAIL includes the meaning of block and direct reclamation, which
> is essential for a true no-fail allocation. We are gradually starting
> to enforce this block semantics to prevent the potential misuse of
> __GFP_NOFAIL in atomic contexts in the future.
> 
> A typical example of incorrect usage is in VDPA, where GFP_ATOMIC
> and __GFP_NOFAIL are used together.
> 
> [RFC]: This patch seems quite large; I don't mind splitting it into
> multiple patches for different subsystems after patches 1 ~ 4 have
> been applied.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> 
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index fa01818c1972..29eaf8b84b52 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -1146,7 +1146,7 @@ static int __init xive_init_ipis(void)
>  	if (!ipi_domain)
>  		goto out_free_fwnode;
>  
> -	xive_ipis = kcalloc(nr_node_ids, sizeof(*xive_ipis), GFP_KERNEL | __GFP_NOFAIL);
> +	xive_ipis = kcalloc(nr_node_ids, sizeof(*xive_ipis), GFP_KERNEL | GFP_NOFAIL);

This (and others) doesn't look great. Normally there's just one GFP_MAIN
that combines several commonly used together flags internally, with possibly
some | __GFP_EXTRA addition for less common modifications. Now you're
combining two GFP_MAIN's and that's just confusing.

So if we want to go this way, you'd need e.g.

GFP_KERNEL_NOFAIL which is GFP_KERNEL | __GFP_NOFAIL

And probably also GFP_NOFS_NOFAIL and GFP_NOIO_NOFAIL (sigh).

>  	if (!xive_ipis)
>  		goto out_free_domain;

