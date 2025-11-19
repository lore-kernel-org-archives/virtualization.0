Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D2B2FD7B8
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763534132; cv=none; b=l5WXjVlcfYplLD59GPh7GXiotmO0cP9xl302zTfbrqtZKWBi1XmC9+P4BqgFjORH0sC2MMSIqaM+4D2NNmpRXJy6PZVxbr9vx8sQUkCSYUB3QQdHT0OxOl0F63Nyw1dBWzDbTv3XcQs62T3vEMCGaoXjR+C7/m4/qqVktX90X7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763534132; c=relaxed/simple;
	bh=+oVkQPTDHbvSsq1poNKexqrG7BwcA2w2R129KKd8llI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VWaO2kIassYeIaY+iY2U/GAba3DuWiNPhBKjHMAW6q541Qe/T+c/f3Dnw+d7GxvdF4qzsR4RKz+nmGZDcOf/9f0hCxmtGqLMsRbqVl1oEUOVl0MIh4XbS1F8NRm6BWn7yxra9hn1uyRTQf+hrS4fDmTZRauscVQZyZvsl7p9WTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQpV2Bgy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQpV2Bgy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763534128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ueGpvfIJmvL+t0ATYLIghMNkOHkFd1Xmr1KQZsIHm5s=;
	b=CQpV2BgyzyrCB9W0+/FPWv9cusJ0xfrlHaw75hJlbshDSD6jAznlzWY9nEOygL0iX3sKcm
	7kg1SIrDULtcWA2Vj/18J2eDEDgAnafeEeF09YQ5JU+fMTkSmKQnA+tbZEsEjd298/d2aZ
	UZ6ldKPu0ZIcI7U0+jHIPKWjLh3VXeM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-sjxgts9HM_2Ah9WMC2dB_g-1; Wed, 19 Nov 2025 01:35:27 -0500
X-MC-Unique: sjxgts9HM_2Ah9WMC2dB_g-1
X-Mimecast-MFC-AGG-ID: sjxgts9HM_2Ah9WMC2dB_g_1763534126
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775d110fabso48595695e9.1
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 22:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763534126; x=1764138926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueGpvfIJmvL+t0ATYLIghMNkOHkFd1Xmr1KQZsIHm5s=;
        b=ikwZLaguVLRwwzsRgd+xUDI9j6u9QsD4lqyddaM3oCFHunuZveU06hS0mvfJURmOkO
         K1NLSvAiB8CJR3TQ99a2vCYOy0beLhxn/R50EJl+LIVwewjZyZBNPGE9Se4aVaqdPb0B
         ZOwlKcv4nd1GDy4KmB/edvDUl0Y6klF0gY8zsCLsNm/Bkom4Bg3P+3bTpUMcTH1VGpDo
         pRgs/Y6bzhTPemLux5HgXM0NPUW4oGDvZrkESbnmIBpB3MtxUN8sPQqQM30qP6/YhUKZ
         jDVrsgixSnvaG3r5E3FnSJawSP1uI0w6/eBr08lR+dVs/Et7EXaaUrr14A9kSdP8O6pN
         og+A==
X-Forwarded-Encrypted: i=1; AJvYcCXxV62YDm0uHIo5fLpuU8Ao1F8Gn4uRQpGDCcvItnoWEhYKpUhwFC7AmD231xZ2UlS/jMktECzYqe+JZP2CYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwK+KPP/mp5Mq+pW3llTzI83xH88x8I9M4b1lu2zB72LDTwbvPU
	i9uscJBCyzl+fRPmsuESG8ZvmeTfjMBjRzB8OdEO+ZO96Vwfmt/DeDZUFAxR1FWIsC8Q3AqmRxW
	iXgySanihrT/ysAAdp91V0nZucbrmkdoMADf95yVQy3Er/BTGROAO37OLo1Z56eh9oK/E
X-Gm-Gg: ASbGncuimNwKAuY7Vv5o3NZLVASP4w9OUSPCi1EnpkBEJ3QGf26AzivjzyF7S3i3J8u
	i5/maULjvjyvhzVAGQ3Bkt7oLQOYdCxa5ISX3jMEFNkqhE16oGLpggE2nZ3batR/FY0N6hH9ExQ
	OmNww9n4hPu+c8Dvkypjke7VCH7vExJPUf3wK0vfwPQWlMSmXc0Prod8CigpCUPT51E2JtA4aJZ
	qMfysUDaHHCQ+E1rT44/2vfBzd4g5Oc/nB5s1Zoc2w+BWk1+MYXafAfa7g214vwnCbWZs6Qmxdl
	oYt8Wpq2/8lXB4n5ahaqCM+pxK1otVdZ4zcXgY1aggl5/xMc9rQWblw2wEkmVI6BPW+7ViPs9mT
	MDfLrvGyIrPyhNEzqxjDbKsv9aUJThA==
X-Received: by 2002:a05:600c:4707:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-4779eb89abfmr113079795e9.8.1763534126074;
        Tue, 18 Nov 2025 22:35:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFAIsJXBhVayBFWWtgtLbt869+S8X6nXeewdbwIoRf0oNDair5E4OaoLGnaQ10CFIl/p4R4w==
X-Received: by 2002:a05:600c:4707:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-4779eb89abfmr113079575e9.8.1763534125670;
        Tue, 18 Nov 2025 22:35:25 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9d21591sm35170495e9.2.2025.11.18.22.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 22:35:24 -0800 (PST)
Date: Wed, 19 Nov 2025 01:35:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251119013423-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
 <20251118164952-mutt-send-email-mst@kernel.org>
 <cb64732c-294e-49e7-aeb5-f8f2f082837e@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cb64732c-294e-49e7-aeb5-f8f2f082837e@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PIMPUdHCRFgwwMMpVObpGN_dUYgj-x-ZLxC_oAoqnFA_1763534126
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 12:26:23AM -0600, Dan Jurgens wrote:
> On 11/18/25 3:55 PM, Michael S. Tsirkin wrote:
> > On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
> >> Classifiers can be used by more than one rule. If there is an existing
> >> classifier, use it instead of creating a new one.
> 
> >> +	struct virtnet_classifier *tmp;
> >> +	unsigned long i;
> >>  	int err;
> >>  
> >> -	err = xa_alloc(&ff->classifiers, &c->id, c,
> >> +	xa_for_each(&ff->classifiers, i, tmp) {
> >> +		if ((*c)->size == tmp->size &&
> >> +		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
> > 
> > note that classifier has padding bytes.
> > comparing these with memcmp is not safe, is it?
> 
> The reserved bytes are set to 0, this is fine.

I mean the compiler padding.  set to 0 where?

> > 
> > 
> >> +			refcount_inc(&tmp->refcount);
> >> +			kfree(*c);
> >> +			*c = tmp;
> >> +			goto out;
> >> +		}
> >> +	}
> >> +
> >> +	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
> >>  		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
> >>  		       GFP_KERNEL);
> >>  	if (err)
> > 
> > what kind of locking prevents two threads racing in this code?
> 
> The ethtool calls happen under rtnl_lock.
> 
> > 
> > 
> >> @@ -6932,29 +6945,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
> >>  		      (*c)->size);
> >>  	if (err)
> >>  		goto err_xarray;
> >>  
> >> +	refcount_set(&(*c)->refcount, 1);
> > 
> > 
> > so you insert uninitialized refcount? can't another thread find it
> > meanwhile?
> 
> Again, rtnl_lock.
> 
> 
> >>  
> >>  	err = insert_rule(ff, eth_rule, c->id, key, key_size);
> >>  	if (err) {
> >>  		/* destroy_classifier will free the classifier */
> > 
> > will free is no longer correct, is it?
> 
> Clarified the comment.
> 
> > 
> >> -		destroy_classifier(ff, c->id);
> >> +		try_destroy_classifier(ff, c->id);
> >>  		goto err_key;
> >>  	}
> >>  
> >> -- 
> >> 2.50.1
> > 

