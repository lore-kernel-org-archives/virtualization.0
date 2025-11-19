Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430131A547
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537016; cv=none; b=C/Qim0j0ijDHEHfJvPC8rYG2QspQfBD16j3Ar7Lm3IPDgOkMvTpVXz0G4m4vf8IQ8PMisR5KbZvMipSNtVcQxVDeRf3/pXFwh/0CyNCp8t4Bi12vdJsI5zfOoZUxwIw9o5E55K09E+6j52qajnET8TMZAYM0gBvZYkoXAtYwYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537016; c=relaxed/simple;
	bh=UeoKVaThpoIS0BmQUgkdNS7le0YO6IkTWg/xw+UNc34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uPnWPZTtnI8kFn7YKQFJJQf6syIT+rNPKvWc9w5kiF8N8LVMeFbVhtwjV9GkP3Yt0vSk7Nh1M6cjBkhm+LNnZEaiQ3XqPg7X7ZMII/jsBytly8e1zQXU8hZs8x2CKdFxJwAPIZv862yWyZtVIKvGDPvkyYMhoizdbNIUnq0w6BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXhrE29j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXhrE29j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763537013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=23htjdzLd7CrFgq1C+mI1+9hYzAjOf3Xisff2Ra8ZMM=;
	b=OXhrE29jSwdzy+Ioz9+aTQ9qRD5X/vqU4gkwkLNBb5fOXjOhDhmX1eol0/KylvoDzsmAeq
	FzwRL41RgFMl/M4TjGX+zoV9HkwfnZ7C5fu6boH3Lh+P4V0RhqJwzD+UcpA0k6TsPz3KKQ
	xADv1wmZVQ4b+N0Xm4ojTj+rExMe+Dw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-MqpuimxZPuWsI0dtJj4SxA-1; Wed, 19 Nov 2025 02:23:32 -0500
X-MC-Unique: MqpuimxZPuWsI0dtJj4SxA-1
X-Mimecast-MFC-AGG-ID: MqpuimxZPuWsI0dtJj4SxA_1763537011
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4776b0ada3dso2932805e9.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 23:23:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763537011; x=1764141811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23htjdzLd7CrFgq1C+mI1+9hYzAjOf3Xisff2Ra8ZMM=;
        b=t6LOyqDh01rA178Rkoo6Og3JenvExvF/y2LeNPgUiABFjiDEXr1FchTKoM2WuUYWZj
         ja/ZBM07J7KcvGzt+BCEWE/LRUCQ3vGU3cwkKBvhW5J3jajxivPowQMh9taWKRcbgU4O
         VvGPUo3++Q+WCiPiTIC3eYaGLms5ssyME4wel0UW92lLNYttnhZ8aHJBQqViVetzIyrt
         V1LRAad7K6F6Dm5E7xMiQpV5qISRJ7HfgznLNSXApE2NtQZojO0E4jSask5M69qeiHH1
         Qgjv3Q9A87x4tMiGWI21J59+BLapISIgsfydEvBVj1ZZHXN49F7QB9TODx2KASmMjFuy
         3+3w==
X-Forwarded-Encrypted: i=1; AJvYcCXGfJNbvQ8A+F8UqC0jhcF2vKu6cl9igglfWg7+NwFuj3mP16xCwPUX4tmETBt60zb5jPBvFeIVK3r+gnEdag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4nlnBcz8exDZha1fxpV/HfvwHuZdJ4hkmS3nNAhV7wOvHUas3
	NnvdCOOt/nZ4/XgTiTpBzlWgVAvyCfhCi4F0ZhmO3/7FK4WY9R5iPmX8mk65vg6ZT2XsoOLawHJ
	RAX81Db4x49GxvTMbf+d2GvAdrneO3pEZbWOlzM2sdENnIg+0TLxNo6YikBy/bObbntTHofe6Y3
	QF
X-Gm-Gg: ASbGnctu3dQPO5vLYYGs1/MXTkLR4+9Sx3rlbEYt48AoIbTEwX3ZmetVEswVI/W59cQ
	cj7IIcDpV9lEZRxU257jRwGAU8gxxsABNUvzBfuZ+vYHtAFbgw8xZttGfJi21LBUWTfjeQr1Rmn
	LxS17pdNzbbkAvMDmpYWBmVyJvqD92i+mTTnQ7dF9m5OqH2XRq/uSnHLXNByNKEwwGf/DuIcYNe
	Vh/p/swodWrv7o4ucI0iCIT3256LgDPkNeUhR8/BHpIu5OGDgkuVvSlC87hZKZPRyRpXOi5+EC6
	1pMf+yHN8ot0caD9m7TXhX3Dxs6B4/8qApG+X5yTFqf8ItZOeanjhxf9QVEtI0nnJDKZvj3ReOa
	PX1W5sB/raqGdruzdPVGJh29U0JaAJg==
X-Received: by 2002:a05:600c:4fc5:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-477b18bfd8cmr13534615e9.6.1763537010895;
        Tue, 18 Nov 2025 23:23:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQR3DkjRdizuys9xaYXsd7FSoVfMu1xxaJXLCWb85B3LwKqZ9YyACG2JrVZv0aHRQqlwGMfQ==
X-Received: by 2002:a05:600c:4fc5:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-477b18bfd8cmr13534285e9.6.1763537010412;
        Tue, 18 Nov 2025 23:23:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9741cbfsm34529655e9.6.2025.11.18.23.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:23:29 -0800 (PST)
Date: Wed, 19 Nov 2025 02:23:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251119022119-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
 <20251118164952-mutt-send-email-mst@kernel.org>
 <cb64732c-294e-49e7-aeb5-f8f2f082837e@nvidia.com>
 <20251119013423-mutt-send-email-mst@kernel.org>
 <e23b94ab-35f6-41fb-91f9-1ba9260fc0ed@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e23b94ab-35f6-41fb-91f9-1ba9260fc0ed@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hVDmUW9cA9fTy7qJJ4qI5zs-48lyCTmQ_NAOxNz8fXE_1763537011
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:18:56AM -0600, Dan Jurgens wrote:
> On 11/19/25 12:35 AM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 12:26:23AM -0600, Dan Jurgens wrote:
> >> On 11/18/25 3:55 PM, Michael S. Tsirkin wrote:
> >>> On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
> >>>> Classifiers can be used by more than one rule. If there is an existing
> >>>> classifier, use it instead of creating a new one.
> >>
> >>>> +	struct virtnet_classifier *tmp;
> >>>> +	unsigned long i;
> >>>>  	int err;
> >>>>  
> >>>> -	err = xa_alloc(&ff->classifiers, &c->id, c,
> >>>> +	xa_for_each(&ff->classifiers, i, tmp) {
> >>>> +		if ((*c)->size == tmp->size &&
> >>>> +		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
> >>>
> >>> note that classifier has padding bytes.
> >>> comparing these with memcmp is not safe, is it?
> >>
> >> The reserved bytes are set to 0, this is fine.
> > 
> > I mean the compiler padding.  set to 0 where?
> 
> There's no compiler padding in virtio_net_ff_selector. There are
> reserved fields between the count and selector array.

I might be missing something here, but are not the
structures this code compares of the type struct virtnet_classifier
not virtio_net_ff_selector ?

and that one is:

 struct virtnet_classifier {
        size_t size;
+       refcount_t refcount;
        u32 id;
        struct virtio_net_resource_obj_ff_classifier classifier;
 };


which seems to have some padding depending on the architecture.


> > 
> >>>
> >>>
> >>>> +			refcount_inc(&tmp->refcount);
> >>>> +			kfree(*c);
> >>>> +			*c = tmp;
> >>>> +			goto out;
> >>>> +		}
> >>>> +	}
> >>>> +
> >>>> +	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
> >>>>  		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
> >>>>  		       GFP_KERNEL);
> >>>>  	if (err)
> >>>
> >>> what kind of locking prevents two threads racing in this code?
> >>
> >> The ethtool calls happen under rtnl_lock.
> >>
> >>>
> >>>
> >>>> @@ -6932,29 +6945,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
> >>>>  		      (*c)->size);
> >>>>  	if (err)
> >>>>  		goto err_xarray;
> >>>>  
> >>>> +	refcount_set(&(*c)->refcount, 1);
> >>>
> >>>
> >>> so you insert uninitialized refcount? can't another thread find it
> >>> meanwhile?
> >>
> >> Again, rtnl_lock.
> >>
> >>
> >>>>  
> >>>>  	err = insert_rule(ff, eth_rule, c->id, key, key_size);
> >>>>  	if (err) {
> >>>>  		/* destroy_classifier will free the classifier */
> >>>
> >>> will free is no longer correct, is it?
> >>
> >> Clarified the comment.
> >>
> >>>
> >>>> -		destroy_classifier(ff, c->id);
> >>>> +		try_destroy_classifier(ff, c->id);
> >>>>  		goto err_key;
> >>>>  	}
> >>>>  
> >>>> -- 
> >>>> 2.50.1
> >>>
> > 

