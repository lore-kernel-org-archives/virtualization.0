Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFFF3112D3
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616664; cv=none; b=Ly2hx73Sckh5uYbUYNSlUtYwv3kQfNUi5jdra8TQ7LVgtd07pQymTPC21jT0Nl7dw9OvMNPMZAhm6vWy7sHTfqaQTZA2jQIEm9rBYvHLCTTCTNzd6LrbY3Am0UECGO+eyd+HBm0oJ3lsyykThOOFDKWulymavTRAWFWlV+QAGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616664; c=relaxed/simple;
	bh=wLc+K6BlGcNsSRvAX+itXhvo8Atf/pzYe91W0J7xGew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tKafzhrQreMHBkRdcXxs7AOPB/St/zB/6I4EHJx6N4n4YrAtObKV1wDMxXYZOzm2u1oxvnfEFKx2+9L7d1DqgSFL90u3I4BlV3mhsSKcw3gX62I5n8n91DHvQIIYjc0+1e7R2e5LgpP4dv9CmEn8MFw0i7AwOvs8UMjIPIzJ4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgOV14XP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgOV14XP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767616661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v0XYhWIefjZGWouNSFIeJyo4tnXXaglCJukd6oVTUw8=;
	b=AgOV14XPQywVhLAeb8Ydqmzp3O7in+TSs32uRpY9uAT79H86TDSTRo8osr9Ebww1xRSCOa
	XLmjDNr/omuz1whrFUzmD5gcU0dJ/DzE59igDwFZ695yBYt3nulHMMpG1GGkq+Yn9KG21A
	O2qsp3tmrzq/jE3+0LQJzhAr89EQbT0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-14D7ruv6NyO9cMkAmcXEdA-1; Mon, 05 Jan 2026 07:37:38 -0500
X-MC-Unique: 14D7ruv6NyO9cMkAmcXEdA-1
X-Mimecast-MFC-AGG-ID: 14D7ruv6NyO9cMkAmcXEdA_1767616657
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43284f60a8aso4208521f8f.3
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 04:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767616657; x=1768221457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0XYhWIefjZGWouNSFIeJyo4tnXXaglCJukd6oVTUw8=;
        b=BICBmPBnpQqBlrCu8Ds1oA/LNFec3J6vBoizI1x1yIDEVdj+HeiorRAyUV5MvCPYPR
         2FmVeHvlfVV+x3UkHJKvEmWv64PmU1N0uFVgE3AqK7PZqVSTsrzsQ1B7CliFeLFBjdtv
         q/gStlMrxUBIjARBSGZYsLZQ6Kt8L4c8LZ7FoZcTynr/iN6NinrU0juFhS4KgkWn7Vrf
         Wb1sgroZaIgBzgghXLNlaN0q8gE6B+U9mM9UlV/u+Ff84Z/8JT0UY41haB87yRNH7UFI
         9uMsQ6XdrohLSl1IWuD5zUSAkGh8NrF8nIyfejjjRlYb2IF6Dn22YTTMGMiPumrFDl9f
         wO/A==
X-Forwarded-Encrypted: i=1; AJvYcCX/TAlLn8LgAo0WJq/9Rvk5N2cx9/Deqs4NHo5om+Tg+TSn6aCVx7ayoGFZW2frPF+zsq+WlboPwFg2LsCSuw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4Hq9/k7isAi8Hc/VxUSwi+W8Q+4XIynJTRKdUr0c3e6cv3cEl
	hNS3tdW0eE566tr7HlDVoFPWATK+r5uMv827ZZ5mi9quWQRRkOb9a0ghMy1zy3e+0AaL3bZPZzI
	BSMldI06W5NvBXeQdmYB9SZMUFRfN3DxXcPeILM39DENb/qJBn3UX5lrjGSKunBLRiW5V
X-Gm-Gg: AY/fxX6zqnOCguvpNqjxZEZca81nLOq+/JOg6WmNIZiT8MCr4OrjPwvk7/nKd0iAci4
	3E61T8NUH5P1vOaKhkNALtxu2x2davaxlVO3TdkE+8nUryuv50YikZ6gV+KpheqR1XhGohDChvM
	bYMIT9Kdq/AOMxBPoEuQibLxJp2YOTSVgmE7heYl8CIOPc9RV7hQArejgubkWiDtWc7e/ia9L1Q
	oTntQ6Sw0L5/DHJ5qNoh7Ys5H+TQ1pVw86fVR7t0jInHeiln1YfuoS8G/+wV0h1JR2nICNv3pb8
	6E6hywe8LEB7ObpxEApc0GCxdS0ppmWRwRanlY7baJkAl0c+9B7SjGHHEK5q+lJZh1V1VfH8jzl
	8P7jUdzKnIxBvUrl/OAjnZEHwxyGOwuw0Ww==
X-Received: by 2002:a05:600c:6388:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-47d1953345cmr554872795e9.6.1767616657317;
        Mon, 05 Jan 2026 04:37:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5CrfHKpTC4/iHV/NtFp0xVhQZAcSLZVRFoYkUoGChs4u9sh46HLHw+pax4aqs2/BHfMQ+jQ==
X-Received: by 2002:a05:600c:6388:b0:477:7b16:5f88 with SMTP id 5b1f17b1804b1-47d1953345cmr554872465e9.6.1767616656787;
        Mon, 05 Jan 2026 04:37:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4327791d2f3sm69930171f8f.11.2026.01.05.04.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:37:35 -0800 (PST)
Date: Mon, 5 Jan 2026 07:37:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 05/15] dma-debug: track cache clean flag in entries
Message-ID: <20260105073621-mutt-send-email-mst@kernel.org>
References: <cover.1767601130.git.mst@redhat.com>
 <0ffb3513d18614539c108b4548cdfbc64274a7d1.1767601130.git.mst@redhat.com>
 <20260105105433.5b875ce3@mordecai>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260105105433.5b875ce3@mordecai>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VzLvgLn_fUp58rV3ayGj682rPN7hYcb2T2IBjBm1gwY_1767616657
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2026 at 10:54:33AM +0100, Petr Tesarik wrote:
> On Mon, 5 Jan 2026 03:23:10 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > If a driver is buggy and has 2 overlapping mappings but only
> > sets cache clean flag on the 1st one of them, we warn.
> > But if it only does it for the 2nd one, we don't.
> > 
> > Fix by tracking cache clean flag in the entry.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  kernel/dma/debug.c | 27 ++++++++++++++++++++++-----
> >  1 file changed, 22 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> > index 7e66d863d573..43d6a996d7a7 100644
> > --- a/kernel/dma/debug.c
> > +++ b/kernel/dma/debug.c
> > @@ -63,6 +63,7 @@ enum map_err_types {
> >   * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
> >   * @paddr: physical start address of the mapping
> >   * @map_err_type: track whether dma_mapping_error() was checked
> > + * @is_cache_clean: driver promises not to write to buffer while mapped
> >   * @stack_len: number of backtrace entries in @stack_entries
> >   * @stack_entries: stack of backtrace history
> >   */
> > @@ -76,7 +77,8 @@ struct dma_debug_entry {
> >  	int		 sg_call_ents;
> >  	int		 sg_mapped_ents;
> >  	phys_addr_t	 paddr;
> > -	enum map_err_types  map_err_type;
> > +	enum map_err_types map_err_type;
> 
> *nitpick* unnecessary change in white space (breaks git-blame).
> 
> Other than that, LGTM. I'm not formally a reviewer, but FWIW:
> 
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> 
> Petr T


I mean, yes it's not really required here, but the padding we had before
was broken (two spaces not aligning to anything).

> > +	bool		 is_cache_clean;
> >  #ifdef CONFIG_STACKTRACE
> >  	unsigned int	stack_len;
> >  	unsigned long	stack_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
> > @@ -472,12 +474,15 @@ static int active_cacheline_dec_overlap(phys_addr_t cln)
> >  	return active_cacheline_set_overlap(cln, --overlap);
> >  }
> >  
> > -static int active_cacheline_insert(struct dma_debug_entry *entry)
> > +static int active_cacheline_insert(struct dma_debug_entry *entry,
> > +				   bool *overlap_cache_clean)
> >  {
> >  	phys_addr_t cln = to_cacheline_number(entry);
> >  	unsigned long flags;
> >  	int rc;
> >  
> > +	*overlap_cache_clean = false;
> > +
> >  	/* If the device is not writing memory then we don't have any
> >  	 * concerns about the cpu consuming stale data.  This mitigates
> >  	 * legitimate usages of overlapping mappings.
> > @@ -487,8 +492,16 @@ static int active_cacheline_insert(struct dma_debug_entry *entry)
> >  
> >  	spin_lock_irqsave(&radix_lock, flags);
> >  	rc = radix_tree_insert(&dma_active_cacheline, cln, entry);
> > -	if (rc == -EEXIST)
> > +	if (rc == -EEXIST) {
> > +		struct dma_debug_entry *existing;
> > +
> >  		active_cacheline_inc_overlap(cln);
> > +		existing = radix_tree_lookup(&dma_active_cacheline, cln);
> > +		/* A lookup failure here after we got -EEXIST is unexpected. */
> > +		WARN_ON(!existing);
> > +		if (existing)
> > +			*overlap_cache_clean = existing->is_cache_clean;
> > +	}
> >  	spin_unlock_irqrestore(&radix_lock, flags);
> >  
> >  	return rc;
> > @@ -583,20 +596,24 @@ DEFINE_SHOW_ATTRIBUTE(dump);
> >   */
> >  static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
> >  {
> > +	bool overlap_cache_clean;
> >  	struct hash_bucket *bucket;
> >  	unsigned long flags;
> >  	int rc;
> >  
> > +	entry->is_cache_clean = !!(attrs & DMA_ATTR_CPU_CACHE_CLEAN);
> > +
> >  	bucket = get_hash_bucket(entry, &flags);
> >  	hash_bucket_add(bucket, entry);
> >  	put_hash_bucket(bucket, flags);
> >  
> > -	rc = active_cacheline_insert(entry);
> > +	rc = active_cacheline_insert(entry, &overlap_cache_clean);
> >  	if (rc == -ENOMEM) {
> >  		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
> >  		global_disable = true;
> >  	} else if (rc == -EEXIST &&
> > -		   !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_CPU_CACHE_CLEAN)) &&
> > +		   !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> > +		   !(entry->is_cache_clean && overlap_cache_clean) &&
> >  		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
> >  		     is_swiotlb_active(entry->dev))) {
> >  		err_printk(entry->dev, entry,

