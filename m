Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18102F25EF
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606881; cv=none; b=ItL+KEZyzPxgBFPBI6quOvoS03mL5MZIOIFtowh1saqQ0MkwFNcKEOh9CCg/+OvQgscQxkHOsrx8QvHicHiwS3bsxCLOOEICDWmpsAGLt+30BJvmGJm1JOYkLZ6mj7nLKxQFpRrFD6KXFcyCPnlKZkREavxL5Gp4s6lAioFf4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606881; c=relaxed/simple;
	bh=wXFmNIC/qDvBQEFG+wgffuOhNELOXXRRjb7mFhAEKgs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbvYouJoMKIdWIYF6S5tmiOFQG82Jg3nApDr3pvDeQ161z/klUGaUYUdE0TRu42iex7hF1CQbJM2ubVMtWElL/qpGZxi+igPJ77FsEZLzmcMyk9/65yGNvrVNrH9ccPpdIDPao8ge+o1fk44HiiX/SsqklZaP1704re75XxRYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fdSCfjY9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fdSCfjY9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779d8286d8so10366475e9.0
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 01:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767606876; x=1768211676; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krMWk6w/ET9jlziL1ByZGuECNStB5raCBd10vVl3Cwk=;
        b=fdSCfjY9uKEtuRG/dnseY+cRzwY8OHhjEqRO3GQQM9UrWDAcBGtuCCqUKyjfZhVOdN
         zme9ptf385gBZ0bGUidt3TOCwNtCrLvOeSJR2jhFtUnfoXsOvXy5BrzNShlxMNlLiYb0
         B1yqP5m/Z6d01ynWR2Ki6tenPyc6VNlaOrqFlYTL+hoI82LEarWN7bl8cTBLICEpkG9B
         jpC4yBQ55UlOxRcNbv0mXEXRaNr4+QpszzOV4dkS4sKkFlXbL6HIJy4GvTPwG7TOePCj
         ZiLqNUXQrI0uJCe6ZJ/LP6ltIfR00O3sXIv0ri9+XbH7G1qynd7fIHikRWBc//8tIf7W
         nU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767606876; x=1768211676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=krMWk6w/ET9jlziL1ByZGuECNStB5raCBd10vVl3Cwk=;
        b=cvbeW0zw8FgH/X8HtwoBmUailfe4xmpOTwemKt/5FI+yElHr+wnAp5TErU+gmAoUn7
         pp5ARFjoKZyodeP+l8JQLpDvlNcVMMRA8FLincEdsFx/62ZXaZ7MqFiw/MydV9sqzQba
         fX2YATdOuKroftwjSq75QGf+5bpPs5l2489+YjiJdnjvnM0XgyBypnebVVubPjbPqQ4h
         i0dCyLn0JuB8DYyf82lDBzq37Z8Rerh7Po+UosuIn3U87Knge0Ss2fyy9Bf6p/lXayu9
         vKduWQSDeqsWMRaeilWcT3zMdnV+nBWdHKa0GSSY4mbSF3Ls7vNL01VIMoQ+4Cyji4Jl
         ElLw==
X-Forwarded-Encrypted: i=1; AJvYcCWg/UuIWH01IfMqWiXCw8+s500ezhkL7uc6SOLBbMcQa7rInW90/EP9uFlU0aqjCZXbVh/m6FOgOOnzyas76g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFPiA4F7H2T3NnAvUc8Oped/jIN0ubCBbOPGDgv4YtEX7W/ySj
	/jq4yIMzQM2l0jLdS8b2JDO+2ke/lFMnUrBOO8pDAVt/2aG9YVk7Chx0C/kPJ0LKW6Q=
X-Gm-Gg: AY/fxX70mqSpiikytm54l+iLXWL6/DNpegXzFdcbl7JWnMd25o2l7i6FOBzfG2mSGmv
	cGW7sxwnangQS6+OiQOtmGckAMBsmvTub1dCUu53aoImlW8G/Wj/eo8LGb3LnOiHRgJlABRjnX5
	vQh+9vlB7Xdvdlh1C43itdZIPO8eJxBoPc+BqeSFuErYhOR3mr+qHXZSGrdTrjQ5S7TjD7LqMZ2
	lYqI0dVbLbACTo/FCOBaiophLudv2jtbiOrLk+C3VUJYelsSEYjuCRPmQx1Hp/IcEldykiN7vFD
	TXxKeYXJa9+8HMYJMQu+Mdg+x5lbnXFUkLM2NkWWJE64O3qc4ayvdYELKZfyZDWAklvlkpZe7Or
	kBPVeiGCbPXbXYpiXMl+TfuSeZdFF4jJXi5aC9ukk52yLX+h0NYjERvBWLQ24TmixS+8stOaR/U
	uLXbScyfczBeqnZZGSGZidGyfCIFQRqr8Y6deqvAF9DzIpXtQ6BqiBulNAaBZyIZ4O5eAVjpz14
	reb
X-Google-Smtp-Source: AGHT+IHQlDd3ApAqySAKrzOJImjG5fh/mxoydDR5ocBXIPbbqS40zRTIMIivPVO9L9JjpTgyuVG6FQ==
X-Received: by 2002:a05:600c:4447:b0:46f:ab96:58e9 with SMTP id 5b1f17b1804b1-47d194c27femr344501805e9.0.1767606876178;
        Mon, 05 Jan 2026 01:54:36 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d452be4sm144233885e9.10.2026.01.05.01.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:54:35 -0800 (PST)
Date: Mon, 5 Jan 2026 10:54:33 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Leon Romanovsky
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski
 <brgl@kernel.org>, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 05/15] dma-debug: track cache clean flag in entries
Message-ID: <20260105105433.5b875ce3@mordecai>
In-Reply-To: <0ffb3513d18614539c108b4548cdfbc64274a7d1.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
	<0ffb3513d18614539c108b4548cdfbc64274a7d1.1767601130.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 03:23:10 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> If a driver is buggy and has 2 overlapping mappings but only
> sets cache clean flag on the 1st one of them, we warn.
> But if it only does it for the 2nd one, we don't.
> 
> Fix by tracking cache clean flag in the entry.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  kernel/dma/debug.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 7e66d863d573..43d6a996d7a7 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -63,6 +63,7 @@ enum map_err_types {
>   * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
>   * @paddr: physical start address of the mapping
>   * @map_err_type: track whether dma_mapping_error() was checked
> + * @is_cache_clean: driver promises not to write to buffer while mapped
>   * @stack_len: number of backtrace entries in @stack_entries
>   * @stack_entries: stack of backtrace history
>   */
> @@ -76,7 +77,8 @@ struct dma_debug_entry {
>  	int		 sg_call_ents;
>  	int		 sg_mapped_ents;
>  	phys_addr_t	 paddr;
> -	enum map_err_types  map_err_type;
> +	enum map_err_types map_err_type;

*nitpick* unnecessary change in white space (breaks git-blame).

Other than that, LGTM. I'm not formally a reviewer, but FWIW:

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> +	bool		 is_cache_clean;
>  #ifdef CONFIG_STACKTRACE
>  	unsigned int	stack_len;
>  	unsigned long	stack_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
> @@ -472,12 +474,15 @@ static int active_cacheline_dec_overlap(phys_addr_t cln)
>  	return active_cacheline_set_overlap(cln, --overlap);
>  }
>  
> -static int active_cacheline_insert(struct dma_debug_entry *entry)
> +static int active_cacheline_insert(struct dma_debug_entry *entry,
> +				   bool *overlap_cache_clean)
>  {
>  	phys_addr_t cln = to_cacheline_number(entry);
>  	unsigned long flags;
>  	int rc;
>  
> +	*overlap_cache_clean = false;
> +
>  	/* If the device is not writing memory then we don't have any
>  	 * concerns about the cpu consuming stale data.  This mitigates
>  	 * legitimate usages of overlapping mappings.
> @@ -487,8 +492,16 @@ static int active_cacheline_insert(struct dma_debug_entry *entry)
>  
>  	spin_lock_irqsave(&radix_lock, flags);
>  	rc = radix_tree_insert(&dma_active_cacheline, cln, entry);
> -	if (rc == -EEXIST)
> +	if (rc == -EEXIST) {
> +		struct dma_debug_entry *existing;
> +
>  		active_cacheline_inc_overlap(cln);
> +		existing = radix_tree_lookup(&dma_active_cacheline, cln);
> +		/* A lookup failure here after we got -EEXIST is unexpected. */
> +		WARN_ON(!existing);
> +		if (existing)
> +			*overlap_cache_clean = existing->is_cache_clean;
> +	}
>  	spin_unlock_irqrestore(&radix_lock, flags);
>  
>  	return rc;
> @@ -583,20 +596,24 @@ DEFINE_SHOW_ATTRIBUTE(dump);
>   */
>  static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
>  {
> +	bool overlap_cache_clean;
>  	struct hash_bucket *bucket;
>  	unsigned long flags;
>  	int rc;
>  
> +	entry->is_cache_clean = !!(attrs & DMA_ATTR_CPU_CACHE_CLEAN);
> +
>  	bucket = get_hash_bucket(entry, &flags);
>  	hash_bucket_add(bucket, entry);
>  	put_hash_bucket(bucket, flags);
>  
> -	rc = active_cacheline_insert(entry);
> +	rc = active_cacheline_insert(entry, &overlap_cache_clean);
>  	if (rc == -ENOMEM) {
>  		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
>  		global_disable = true;
>  	} else if (rc == -EEXIST &&
> -		   !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_CPU_CACHE_CLEAN)) &&
> +		   !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> +		   !(entry->is_cache_clean && overlap_cache_clean) &&
>  		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
>  		     is_swiotlb_active(entry->dev))) {
>  		err_printk(entry->dev, entry,

