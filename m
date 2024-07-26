Received: from elephant.ash.relay.mailchannels.net (elephant.ash.relay.mailchannels.net [23.83.222.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C95748A
	for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722029234; cv=pass; b=usGnYH3kFd2tLkGYbgkXi6B8jMsKOCOfK2fW5f0Dmz8HfrMe9NO0OV15HSR6HhGtgJGSpzek8VVRnqZ+U9wLqgEHezxyU30u8+hovIgQfmfsGEQ7UOMQ0aKddNkDVu+e9BOb6TQZPnNI4532cEmD0jF5oiJxlQdRhMdi4ngp19E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722029234; c=relaxed/simple;
	bh=waFkxlcuaM3LbjUGyKxddzSAcpx/twXJqPqFgjfIYbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgyu1q+jX5r9OPvq2kNqq7SixTMxXiLyV4h0CmW4+k/2RkP7Rpy0tODchXx8f8kz144/+gI2GAVCg/XDMT5yNvCIjgZvMt9MEAX+Da/X5AH0cVJQY1moz1r5LNSg+Nh++zSNxaG5YQ/jAzNzBdoDcZ6WU5SMt3ky/MKub9hqUGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=UxpEjF3b; arc=pass smtp.client-ip=23.83.222.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="UxpEjF3b"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6BFFF144B92;
	Fri, 26 Jul 2024 21:08:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E8BB3144F2F;
	Fri, 26 Jul 2024 21:08:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1722028104; a=rsa-sha256;
	cv=none;
	b=LZTJwaPrgzQwwM2sgDw9QDGJPlX597wlfbbRl79c1EKzTfWITGbiMoW9/yJ4734k5NxOa7
	iA69TdNd4fqrKZ6Ui0NYl5S9NhvQJHC6gzHMkA/BHl2vBIDVZG/QDwYalMVvLPxPFVdRD5
	NjfntOYG7Gg5ifPv1PxoS5ipQW5W91Eony/eg+Dlu2oYTjchFOclhrHaH3IyaaLjSVhpl0
	pf/hKMYW1cAi3bT6454qTxOHn/3e2dhmW2/MfTaBU+EEhYp9NKhIbUZwIwfjIrgHq2SITU
	7LtvWncp9jH1dyOBnWp3AST0x98s1qYJcz1NtnQsb/maxtNlJGKuWpPyvbms5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1722028104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=C/UUV8Pwaly5m7expdcVhsl9qGLrZb+mf5zUcZao9m8=;
	b=c3Qk7/K0kx1ypufDyZ52YVyHLe5t/aY3od8gFEPnqZcKlTrMHjThBYTk1aSSwYOfZr6Svb
	qks4mIhE//Poacpkv5/6PXD9Hv1h4ukMC9Ulm3lHyDkueV2dd89axaxr3lR3D8XJ6qZ8L3
	BXzV/rczTaur6HzLssAcUPHts+cM+OlijWTnUKRpZP9PFHxmJ4d2lXVuD/QI35nw/laKOK
	IYjWei2rsB9ylqS4Av0vmq67EVGwqHm0izpRAk6fepCYpBylBh4iHlzUNheft7p1ozDpYe
	/PtQNpeQ1p6eY7GQWyOgZ186/UQqglzrGRPhQg02wi+XXU8x+arRm7KGEAxVJg==
ARC-Authentication-Results: i=1;
	rspamd-7f77fccf7d-9ph87;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fumbling-Harbor: 01b5a16b7727c345_1722028104322_804868711
X-MC-Loop-Signature: 1722028104322:3351102329
X-MC-Ingress-Time: 1722028104322
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.163.137 (trex/7.0.2);
	Fri, 26 Jul 2024 21:08:24 +0000
Received: from offworld (unknown [172.56.179.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4WW0j23PdKz1q;
	Fri, 26 Jul 2024 14:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1722028103;
	bh=C/UUV8Pwaly5m7expdcVhsl9qGLrZb+mf5zUcZao9m8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=UxpEjF3bCnY35+US8hdzYoksiVVUTQf5saY0UP8s0Iw2DAMEwidX0RCCKYlHruhhJ
	 cxlEbiQ8/KspaFZF3sgLrp9N0OfVLMcuvywucJyk7yAxz9M0iXjtqjnxM1QvrOFa03
	 Xzz28M0kG0mXwqp+lddG5L1hUV2soEnQc+OM0h/ZBNqdffGSafhKdNVhmej9oRqMYd
	 N2hpAvHkQVaG2+73O5gVTQSerfwjvnl7pG7qD655lT4Ptr9C2cL1L52XsfV0Fju4+j
	 tBidCT2oetvRPLqTZVptlxBF01fp6mc00rWEeTg4+lFuj0WXbm4mbiTt0NEYpQF53p
	 d/Q7wAMjWMYmg==
Date: Fri, 26 Jul 2024 14:08:18 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Michal Hocko <mhocko@suse.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, lstoakes@gmail.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	virtualization@lists.linux.dev, hailong.liu@oppo.com, torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <l47ief3pnjdymvciylpnzkiuto7tsth6bc3q2mum3l42queggg@q573yeen4a5s>
Mail-Followup-To: Michal Hocko <mhocko@suse.com>, 
	Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	lstoakes@gmail.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz, 
	virtualization@lists.linux.dev, hailong.liu@oppo.com, torvalds@linux-foundation.org
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <ZqDw7qoaopnYt3-P@tiehlicka>
 <CAGsJ_4x1k-z7OcQPSgqXhxTM8Z_D3Og6mGkC1pWu2+pR3YRKvw@mail.gmail.com>
 <ZqHtwqyj4seB-eut@tiehlicka>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZqHtwqyj4seB-eut@tiehlicka>
User-Agent: NeoMutt/20240425

On Thu, 25 Jul 2024, Michal Hocko wrote:\n
>On Thu 25-07-24 13:38:50, Barry Song wrote:
>> On Thu, Jul 25, 2024 at 12:17???AM Michal Hocko <mhocko@suse.com> wrote:
>> >
>> > On Wed 24-07-24 20:55:44, Barry Song wrote:
>> > > From: Barry Song <v-songbaohua@oppo.com>
>> > >
>> > > GFP_NOFAIL includes the meaning of block and direct reclamation, which
>> > > is essential for a true no-fail allocation. We are gradually starting
>> > > to enforce this block semantics to prevent the potential misuse of
>> > > __GFP_NOFAIL in atomic contexts in the future.
>> > >
>> > > A typical example of incorrect usage is in VDPA, where GFP_ATOMIC
>> > > and __GFP_NOFAIL are used together.
>> >
>> > Ohh, so you have done the migration. Please squash those two patches.
>> > Also if we want to preserve clean __GFP_NOFAIL for internal MM use then it
>> > should be moved away from include/linux/gfp_types.h. But is there any
>> > real use for that?
>>
>> yes. currently i got two,
>>
>> lib/rhashtable.c
>>
>> static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
>>                                                size_t nbuckets,
>>                                                gfp_t gfp)
>> {
>>         struct bucket_table *tbl = NULL;
>>         size_t size;
>>         int i;
>>         static struct lock_class_key __key;
>>
>>         tbl = alloc_hooks_tag(ht->alloc_tag,
>>                         kvmalloc_node_noprof(struct_size(tbl, buckets,
>> nbuckets),
>>                                              gfp|__GFP_ZERO, NUMA_NO_NODE));
>>
>>         size = nbuckets;
>>
>>         if (tbl == NULL && (gfp & ~__GFP_NOFAIL) != GFP_KERNEL) {
>>                 tbl = nested_bucket_table_alloc(ht, nbuckets, gfp);
>>                 nbuckets = 0;
>>         }
>>
>>         ...
>>
>>         return tbl;
>> }
>
>Ugh. OK this is a weird allocation fallback strategy 2d22ecf6db1c
>("lib/rhashtable: guarantee initial hashtable allocation"). Maybe the
>code should be just simplified and GFP_NOFAIL used from the begining?
>Davidlohr WDYT? For your context Barry tries to drop all the
>__GFP_NOFAIL use and replace it by GFP_NOFAIL which enforces
>__GFP_DIRECT_RECLAIM so that people cannot request atomic NOFAIL.

Why is it so weird? Perhaps I'm missing your point, but the fallback
introduced in that commit attempts to avoid abusing nofail semantics
and only ask with a smaller size.

In any case, would the following be better (and also silences smatch)?
Disregarding the initial nofail request, rhashtable allocations are
always either regular GFP_KERNEL or GFP_ATOMIC (for the nested and
some insertion cases).

-----8<-----
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index dbbed19f8fff..c9f9cce4a3c1 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -184,12 +184,12 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
  	static struct lock_class_key __key;
  
  	tbl = alloc_hooks_tag(ht->alloc_tag,
-			kvmalloc_node_noprof(struct_size(tbl, buckets, nbuckets),
-					     gfp|__GFP_ZERO, NUMA_NO_NODE));
+			kvmalloc_noprof(struct_size(tbl, buckets, nbuckets),
+					gfp|__GFP_ZERO));
  
  	size = nbuckets;
  
-	if (tbl == NULL && (gfp & ~__GFP_NOFAIL) != GFP_KERNEL) {
+	if (tbl == NULL && (gfp & GFP_ATOMIC)) {
  		tbl = nested_bucket_table_alloc(ht, nbuckets, gfp);
  		nbuckets = 0;
  	}




