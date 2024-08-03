Received: from buffalo.birch.relay.mailchannels.net (buffalo.birch.relay.mailchannels.net [23.83.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7191D6A8
	for <virtualization@lists.linux.dev>; Sat,  3 Aug 2024 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722726564; cv=pass; b=cksp+Mze+76zyjvgMtHlJRR882ssaBM5YHfAytV0n3dKh+TNggjNDDMKSSCkQjgYfHkQ78J8lSukwVM9oIJZDB9EF1ELNyQQ07vVKmVvywncD7ROyEJPy8piY0npw0DvtyJg3PTIVu2/Q4a8Jp6LdjmpTwBUmtS/CLyRKN53MCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722726564; c=relaxed/simple;
	bh=N00HXZBCU1uS2CccAwIL1DT1xpQGRCnamcYVOl2v6Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOKGYQdafkmDB0CYNd4lnylSOqq4JcUL1LOuc1Oe+W7SQruP1Rv8p944zMP0XzKsvcY0ZasbeaUzhn02VO/KXMam/9WYetyV7zhCD8bKjCSvZ2IL0CX3SvSa/CTnJ59uYZJ7zQnf4iTRoddIj5eowBGEePZ7nMoJs8Iv3w/nWxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=k7eX7c7r; arc=pass smtp.client-ip=23.83.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="k7eX7c7r"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8534DC43C7;
	Sat,  3 Aug 2024 23:09:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a231.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0C024C4492;
	Sat,  3 Aug 2024 23:09:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1722726556; a=rsa-sha256;
	cv=none;
	b=5JDIy/qaERx9kIQG6zEdykwSlbkuBDUfw/3u0yZMWf0Vc50FbSZ52A66r7woT5BnUXSQtT
	7a40Ly7I7nei8wNeiz+aLfe/4N8XiXU76GMbvT4kapUq/YcvXSWPvwh/RKbbWWzS4acBcN
	iTHeEm6eABKK4Ktit64tY8YojewHLKhg6Q9o/vMXsivozlk84+w8zUbdXvbW1UwCvFaTAW
	pIJyvNEdV28+oZEHjCgf6yWQFhmEvHqTQBj4NM46q8t472rUWcNS3qW1HncLYjj71JBeFH
	LSlGx7ghCCoCcHSr8lLViwzUuipLMUCiyCyLRgLSRcBZZunyuXk8hUjAcpqTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1722726556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BSx4gKWGu87H42fwZ04zpF/2UtyzpgP11LfTvEbpceo=;
	b=OA1lb6t0917vT8GsyjDW8lsajtSsNsiry8ou0Zg+EBIURZlPDwewlto1u3woUn/R7JeHTw
	n0+OwBQT+vNk7H6srr8vg7gnuF1TEKh47QfA1bLEJdWOz6fSpA2GKsWmbl3MIAdO3byRnF
	+B9RnmYwLHhAAG3iWN12uLNjot7jnbmQnMZRw5juX0Lmj0CPt+6WEZNpk1hG//tHvKAD5i
	UwapzHiDEuLMuNTCVa9SaZ1ssnivG5WEPryrnkGmKjptD5rlLAU5PTbn12gHIvd1J1ZxMv
	jMTEbZjTdEMhtiisSZEGSBso1KoPv/I3KnxH8QznUht80sm3sVvomg/h/ZFQLA==
ARC-Authentication-Results: i=1;
	rspamd-6777b474b8-fpt5v;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Scare-Wipe: 284557606aa148b6_1722726556420_4172466276
X-MC-Loop-Signature: 1722726556420:2783883086
X-MC-Ingress-Time: 1722726556419
Received: from pdx1-sub0-mail-a231.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.111.74 (trex/7.0.2);
	Sat, 03 Aug 2024 23:09:16 +0000
Received: from offworld (unknown [104.36.30.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a231.dreamhost.com (Postfix) with ESMTPSA id 4Wbz0p6DZFzHZ;
	Sat,  3 Aug 2024 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1722726555;
	bh=BSx4gKWGu87H42fwZ04zpF/2UtyzpgP11LfTvEbpceo=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=k7eX7c7rHLiKXeWCkXHf3djxUWtKLGOeaDrlfO8fsGZEVSGu7PxHeOBlc9WlgmqeO
	 uZ1+QDCeEnyAdWK2Shl6u+bHPfjroCbpTs2ojW7Kt58JchGNvQB5coNmp2/7LFGomL
	 v2C5Ubdnz0V3oz4JOeYhvssJ4DoN/RVKTr/0RrGC1zcDYGyNyY7GMJREBnY44927to
	 Wd46B/rFr+6l6UOtbI5AWrehLgU836SJ8Xz+2xD9W3TZlA3d/OtZvGU+f+sO7ZVb//
	 8ww7PmE75yTZrC8A7D97dUq3LFHH5fTGS9BvJQRYALpWpAQjPuE2yj1Pbb9fSQUG8X
	 +pffunT0MHC6g==
Date: Sat, 3 Aug 2024 16:09:10 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, 
	cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	virtualization@lists.linux.dev, hailong.liu@oppo.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/5] mm: Document __GFP_NOFAIL must be blockable
Message-ID: <iyc24ihjji5vnr7in3sphucjgvurbuchwkkrcvvj3pzbet6gs7@kb7hlcazvrgq>
Mail-Followup-To: Barry Song <21cnbao@gmail.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com, mhocko@suse.com, 
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	hailong.liu@oppo.com, torvalds@linux-foundation.org
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-3-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240724085544.299090-3-21cnbao@gmail.com>
User-Agent: NeoMutt/20240425

On Wed, 24 Jul 2024, Barry Song wrote:\n
>From: Barry Song <v-songbaohua@oppo.com>
>
>Non-blocking allocation with __GFP_NOFAIL is not supported and may
>still result in NULL pointers (if we don't return NULL, we result
>in busy-loop within non-sleepable contexts):
>
>static inline struct page *
>__alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>						struct alloc_context *ac)
>{
>	...
>	/*
>	 * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
>	 * we always retry
>	 */
>	if (gfp_mask & __GFP_NOFAIL) {
>		/*
>		 * All existing users of the __GFP_NOFAIL are blockable, so warn
>		 * of any new users that actually require GFP_NOWAIT
>		 */
>		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>			goto fail;
>		...
>	}
>	...
>fail:
>	warn_alloc(gfp_mask, ac->nodemask,
>			"page allocation failure: order:%u", order);
>got_pg:
>	return page;
>}
>
>Highlight this in the documentation of __GFP_NOFAIL so that non-mm
>subsystems can reject any illegal usage of __GFP_NOFAIL with
>GFP_ATOMIC, GFP_NOWAIT, etc.
>

Acked-by: Davidlohr Bueso <dave@stgolabs.net>
