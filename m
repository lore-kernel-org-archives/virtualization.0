Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952A143752
	for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253849; cv=none; b=FblyBgdxXyuLknxFQz8Fn9vW73A9GLdD1dXnR+LeTJJLk9dVjt+2UR8s8B9iBR/23+uu9RZXx4uG634O2zVmpJwRWC2EB7tUWP3gDSJJM1vuCLQ2GVU1cDaTM4yF3QkquC5OFvgO5/3csR4kU+cO2Zjq6JCYWBxc2h7emz748Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253849; c=relaxed/simple;
	bh=fApbmsGaYkmfbKVxx/lYpNh3RkCD7DV/la0VpKi1iOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx6UA4F0zTa7SmbJwsR0auyPwZnMiEumM00Kox1+ru37+zKzTUIJ4Yj7fc5bz5Esa7vZn7PHP/T9hNpDkcA+/2JSJr4ZlscPCsomNd6o25zkg+oDaDXuDU6b2Uk0ffURTW4QQF1ZDQzYwISyrf3PUACkBDLClID4mXuSMJK11M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CaN9z3x2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CaN9z3x2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281abc64dfso8804685e9.3
        for <virtualization@lists.linux.dev>; Mon, 29 Jul 2024 04:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722253846; x=1722858646; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rIAQEHHkyBJQhspmcQ3i+mn3+W1JL08Gv46aDz1iGa8=;
        b=CaN9z3x2CSkiNVyyMr9gVmS66Y7gsam4iRWBOXijMi5w4c9QDKE6eIxzvCMLdBT4Ar
         0mWnz9ds1xXkX3uJZKJis/VkEdJ7byih/aZZkX6xuLBYq8AuST6zDocM+yYOMI+e/c09
         1rTOTP6NMMs0qRmTeX6gIu9GwWcNKttFmOeCbwkSHiuzwUNht8MlGNujdBZw7Q4nNtSt
         Fq7XdRUp/oCqzmYNnISwJQhgGon7xzMllGfoXOfV1VWXrBnXwRpNUOo8H/tQgY+59zLo
         NmwPFFV29WgC3ZnKDc91mOOBQ+2zPV4wL3vgPPh9uhTLR0CWePCOo56k7ohV3PN58rc5
         Mlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722253846; x=1722858646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIAQEHHkyBJQhspmcQ3i+mn3+W1JL08Gv46aDz1iGa8=;
        b=KjawuSZ4mr90iZryz3xFKgbSJlAxfMSW6PH2pXgfXu3d7pp6LBR2rvKHqT4BATQgZQ
         eKUmm4KbVd+z3Tz72o9QiK/TCcZ0voUiKC8rnRfZPew5Qxpx4Kwh8RUJMMYu9f2Zsi+U
         vebARxPAVttgIoymeUc3KB7S3zcdSnOi+1wYNlwu1fpV5hrdQqJKbyTAAU/UiVjBRQrx
         w3REn5sMTqMCdwTRKZBzLt5tISxQfEn6JM04h5UmdkUj39G/PaoyTeMVQn+1dSJl1z3j
         Nkx4QS8aFDl/NEDeOW6qqF+4AuZZIym6HuXPmsNcJzEIhPqV0MQypEhw/Zj0MWOJWho4
         l9ow==
X-Forwarded-Encrypted: i=1; AJvYcCUNwY62e/8Fesr27lzGIAtrXgxAdr1P1bNne+YGLOSkkP+GzQ/5aeLw7pEUQqUIVjUfMCz/Uov3JLG8Ghlj7tEzOS2Uhx7Hfl0/OUHI3Uo=
X-Gm-Message-State: AOJu0YwSh3wa4R8hlfs4L8kRrbl/uyglkaM6BQ/uPP9huTa+LlRQ6Rqk
	Sx4TS0AoCjIM4eQX//auWuUJhzCkGhhUlzjqCJyGzP6AK3MRzW2eMKnSIq4JY7c=
X-Google-Smtp-Source: AGHT+IFTIg6oHrd/ToypjKjcKs3tnNa2XWpb4cIs4Dkl4KzITSykcMA/gcRN2x6qJs+XzLC2L+YGxA==
X-Received: by 2002:a05:600c:3b99:b0:427:ac40:d4b1 with SMTP id 5b1f17b1804b1-42811e12d36mr55021055e9.27.1722253845798;
        Mon, 29 Jul 2024 04:50:45 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730d5bsm180974675e9.8.2024.07.29.04.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:50:45 -0700 (PDT)
Date: Mon, 29 Jul 2024 13:50:44 +0200
From: Michal Hocko <mhocko@suse.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev, hailong.liu@oppo.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <ZqeCFLykU059gNmN@tiehlicka>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <ZqDw7qoaopnYt3-P@tiehlicka>
 <CAGsJ_4x1k-z7OcQPSgqXhxTM8Z_D3Og6mGkC1pWu2+pR3YRKvw@mail.gmail.com>
 <ZqHtwqyj4seB-eut@tiehlicka>
 <l47ief3pnjdymvciylpnzkiuto7tsth6bc3q2mum3l42queggg@q573yeen4a5s>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l47ief3pnjdymvciylpnzkiuto7tsth6bc3q2mum3l42queggg@q573yeen4a5s>

On Fri 26-07-24 14:08:18, Davidlohr Bueso wrote:
> On Thu, 25 Jul 2024, Michal Hocko wrote:\n
> > On Thu 25-07-24 13:38:50, Barry Song wrote:
> > > On Thu, Jul 25, 2024 at 12:17???AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Wed 24-07-24 20:55:44, Barry Song wrote:
> > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > >
> > > > > GFP_NOFAIL includes the meaning of block and direct reclamation, which
> > > > > is essential for a true no-fail allocation. We are gradually starting
> > > > > to enforce this block semantics to prevent the potential misuse of
> > > > > __GFP_NOFAIL in atomic contexts in the future.
> > > > >
> > > > > A typical example of incorrect usage is in VDPA, where GFP_ATOMIC
> > > > > and __GFP_NOFAIL are used together.
> > > >
> > > > Ohh, so you have done the migration. Please squash those two patches.
> > > > Also if we want to preserve clean __GFP_NOFAIL for internal MM use then it
> > > > should be moved away from include/linux/gfp_types.h. But is there any
> > > > real use for that?
> > > 
> > > yes. currently i got two,
> > > 
> > > lib/rhashtable.c
> > > 
> > > static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
> > >                                                size_t nbuckets,
> > >                                                gfp_t gfp)
> > > {
> > >         struct bucket_table *tbl = NULL;
> > >         size_t size;
> > >         int i;
> > >         static struct lock_class_key __key;
> > > 
> > >         tbl = alloc_hooks_tag(ht->alloc_tag,
> > >                         kvmalloc_node_noprof(struct_size(tbl, buckets,
> > > nbuckets),
> > >                                              gfp|__GFP_ZERO, NUMA_NO_NODE));
> > > 
> > >         size = nbuckets;
> > > 
> > >         if (tbl == NULL && (gfp & ~__GFP_NOFAIL) != GFP_KERNEL) {
> > >                 tbl = nested_bucket_table_alloc(ht, nbuckets, gfp);
> > >                 nbuckets = 0;
> > >         }
> > > 
> > >         ...
> > > 
> > >         return tbl;
> > > }
> > 
> > Ugh. OK this is a weird allocation fallback strategy 2d22ecf6db1c
> > ("lib/rhashtable: guarantee initial hashtable allocation"). Maybe the
> > code should be just simplified and GFP_NOFAIL used from the begining?
> > Davidlohr WDYT? For your context Barry tries to drop all the
> > __GFP_NOFAIL use and replace it by GFP_NOFAIL which enforces
> > __GFP_DIRECT_RECLAIM so that people cannot request atomic NOFAIL.
> 
> Why is it so weird?

Because it is really hard to figure out what it is supposed to mean.
If the caller uses __GFP_NOFAIL then it is (should be) impossible and if
NOFAIL is not used then why does it need to check for 
	(gfp & ~__GFP_NOFAIL) != GFP_KERNEL?
this could be GFP_NO{IO,FS} but also GFP_ATOMIC. So what is it supposed
to mean even?

> Perhaps I'm missing your point, but the fallback
> introduced in that commit attempts to avoid abusing nofail semantics
> and only ask with a smaller size.
> 
> In any case, would the following be better (and also silences smatch)?
> Disregarding the initial nofail request, rhashtable allocations are
> always either regular GFP_KERNEL or GFP_ATOMIC (for the nested and
> some insertion cases).
> 
> -----8<-----
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index dbbed19f8fff..c9f9cce4a3c1 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -184,12 +184,12 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
>  	static struct lock_class_key __key;
>  	tbl = alloc_hooks_tag(ht->alloc_tag,
> -			kvmalloc_node_noprof(struct_size(tbl, buckets, nbuckets),
> -					     gfp|__GFP_ZERO, NUMA_NO_NODE));
> +			kvmalloc_noprof(struct_size(tbl, buckets, nbuckets),
> +					gfp|__GFP_ZERO));
>  	size = nbuckets;
> -	if (tbl == NULL && (gfp & ~__GFP_NOFAIL) != GFP_KERNEL) {
> +	if (tbl == NULL && (gfp & GFP_ATOMIC)) {

I have really hard time to follow what that is supposed to mean. First
GFP_ATOMIC is not a mask usable for this kind of tests as it is
	__GFP_HIGH|__GFP_KSWAPD_RECLAIM

so GFP_KERNEL & GFP_ATOMIC is true. If you want to explicitly ask for a
sleepable allocation then use gfpflags_allow_blocking but fundamentally
why you simply do not do
	if (!tlb)
  		tbl = nested_bucket_table_alloc(ht, nbuckets, gfp);

Why does gfp flags play any role here?
-- 
Michal Hocko
SUSE Labs
