Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F8383A9
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828003; cv=none; b=hDEEFXGWLtlnnsTDtlfmQW15SQa2EJaUFk8KFxQTscyg59g6DeoMLZYSM+YLK+2Yv7IY5HaDRBqfqz6iSuArL/Fx1LaVy4Qu+mEI3BTwNAEjV36MWyVqCwkMA75DgFC3EXraU3sYCMp6Wc8xqo9LdRqOEQJGdtJNP9dTrqfJI60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828003; c=relaxed/simple;
	bh=UCeRE8QlEy+uujl8s9WFNedBT74dBejtETTm0EHDnU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQ4Y0mISb65u5mw2tJEQ/Hv0/yWLPxz8UY1FXtBb5qn9ADG6RfrCBbop/hAa5wi2OB1agcnplsqLZpIs9GtdHzsBcnqNQIqDFwnCmY//r8V0rEauU48gl5J0YpJfDKn5YS0aUkcAigcW1GdK+TRce5/gd9SMiXqgTDzFLd4rFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xXTtInqu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gTQgiuh+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xXTtInqu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gTQgiuh+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xXTtInqu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gTQgiuh+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xXTtInqu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gTQgiuh+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A22D1F7A2;
	Wed, 24 Jul 2024 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721827999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nzw8ylVgQX3QYVWofZjypvmx8UdO9MWNRn2TF9dUUc0=;
	b=xXTtInqu4sO+yCeKdyoyTM1Dsruffq1vltI4AA1QVSzAfvBXddq4OVnUX6Xhf8X+gSoL++
	ruDH6zyrexjutI2TNj8aA6sfGPhovZggo077dZ9YWN967SZLRruaY3jMsL0CIYNL1TtP75
	mxSAPiZJs14lbroz6gF49AOGpzSDErk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721827999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nzw8ylVgQX3QYVWofZjypvmx8UdO9MWNRn2TF9dUUc0=;
	b=gTQgiuh+7QCQ5VVEtSLgN7AoNMOhuDgnQ5jW6uPBLAkT7dkel3yYkbRaQzcU6Pe5SEAFoT
	K3y7gVuMSexgPFAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721827999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nzw8ylVgQX3QYVWofZjypvmx8UdO9MWNRn2TF9dUUc0=;
	b=xXTtInqu4sO+yCeKdyoyTM1Dsruffq1vltI4AA1QVSzAfvBXddq4OVnUX6Xhf8X+gSoL++
	ruDH6zyrexjutI2TNj8aA6sfGPhovZggo077dZ9YWN967SZLRruaY3jMsL0CIYNL1TtP75
	mxSAPiZJs14lbroz6gF49AOGpzSDErk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721827999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nzw8ylVgQX3QYVWofZjypvmx8UdO9MWNRn2TF9dUUc0=;
	b=gTQgiuh+7QCQ5VVEtSLgN7AoNMOhuDgnQ5jW6uPBLAkT7dkel3yYkbRaQzcU6Pe5SEAFoT
	K3y7gVuMSexgPFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70A161324F;
	Wed, 24 Jul 2024 13:33:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bVIlG58CoWYaGAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 24 Jul 2024 13:33:19 +0000
Message-ID: <400b2f6f-f7f0-4888-99ee-7327faad7e5c@suse.cz>
Date: Wed, 24 Jul 2024 15:33:19 +0200
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
To: Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@infradead.org>
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
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <ZqECPiU-3fJozzpB@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.59 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kvack.org,linux.com,lge.com,kernel.org,google.com,linux.dev,oppo.com,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.59

On 7/24/24 3:31 PM, Michal Hocko wrote:
> On Wed 24-07-24 06:23:29, Christoph Hellwig wrote:
>> On Wed, Jul 24, 2024 at 03:21:13PM +0200, Michal Hocko wrote:
>> > Scope API is tricky here. Exactly because the scope itself could have
>> > opportunistic GFP_NOWAIT allocations.
>> 
>> Really, where?  That just sounds f**cked up as callers using any kind
>> of nofail API can be broken by a caller higher in the stack.
> 
> I do not see this a problem. There is no real reason to have a NOWAIT
> allocation down the stack that has a different fallback strategy.
> I am not saying that this is the current practice because I do not know
> that but I am saying that this is not impossible to imagine and it makes
> scoped NOFAIL context subtle and error prone.

I don't think Christoph proposed scoped NOFAIL, just use scoped NOFS/NOIO
together with GFP_KERNEL_NOFAIL intead of introducing GFP_NOFS_NOFAIL.

>> And that's totally independ of adding a NOFS/NOIO helper, so it'll need
>> to be fixed.
>> 
>> Adding more NOFS/NOIO wrappers while we're trying to kill the flag just
>> is not helpful going forward.
> 
> NOFS, NOIO scopes are both compatible with NOFAIL and NOWAIT contexts.
> 

