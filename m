Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53572DF131
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538104; cv=none; b=FZqTTVkeyEE3CdpRIRx8+re6MeJqtbbfL3d2e5Qzn+dZc8Bi/nJNn96p5xOiozW/XniZoX0Ge0AWH58Iie4U1LTNWRhD+yhN2Z7SnOi9ma7UaeD5gLqs7K1urCSf6PNJh6lcX3MZRvPUW6r1nvY68QrgANgKjQ095D5OozuRowU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538104; c=relaxed/simple;
	bh=Rduaa7CN9Qw5BaMjtN4lzqTBc8GdxZg1gPgXNcu1FIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Pp3qQbilfpBWntk1sk2NXvPTCwyxTySMAGcJrji55pdQYQigW7W3ejv/it/HltJDuZ7z60yGCcpHlQVLThxWABEUwFv/Mz8twfltVNNTQDvgV7MUlsDRQ400t1UMQwE7Am6g4r1h8DG8JZWItOTvNPeFpc1LS8XnHnJZcZKlPW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBpkLD8D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBpkLD8D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763538100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNw+TI8JRzSFMPaBmMloxZr+ia2tyTaUh+yioCK5LjQ=;
	b=HBpkLD8DDX3RUZAcQFljwwr8kKadXyF5ZM5646ytRHXPoksoRFdi3hxIzPCLU/ciNGUVc3
	WcxvP/8GtzHLasKGTUDGEJsT9WUhjUJFYE/IYnlTF93bLleaTIi4AsGUC6SbpxTj+KfVan
	U8jcVLO/GOkQy/Iz9ueoUVru+/kK/+s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-ht3TXxfCMLSFjW5WEukUGA-1; Wed, 19 Nov 2025 02:41:39 -0500
X-MC-Unique: ht3TXxfCMLSFjW5WEukUGA-1
X-Mimecast-MFC-AGG-ID: ht3TXxfCMLSFjW5WEukUGA_1763538098
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so30326425e9.2
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 23:41:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538098; x=1764142898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNw+TI8JRzSFMPaBmMloxZr+ia2tyTaUh+yioCK5LjQ=;
        b=hUGxxq2pK4ShrO7sPzWmq7sPeQUD9wpJgc+GSJvoah64Lv0PrD7x/rPG2m1vBUiFOM
         KlrY/gO1ffSWRsMSy2Yh6vlOwJ9WjkHO6R1fsSUG67bfZolxaade2Bi3AGoyCwdwf7St
         RhybfZ91At4mxo/acDcgof/8I10fUq+paXimscQhUDOkEB1a2QFuR+XlGF6cu96jysYc
         mtvpW6Ye/05247UyUDF7Nr0qdvM9tzJRRZKbq6N/WNJ29ZB2enDq+mBNKnv+NkEQjLH4
         YaAbdaiPZoW6mqopn7Z/qB40C9CY8tPvAiJZBuP4ZkU71hqiogjsYyxPg3afrsgcVxeY
         OvTw==
X-Forwarded-Encrypted: i=1; AJvYcCU4FbEIos8h9eAwuPAu6l3lFyvszLwIrzfmUcDerb6emIlizRNlvWTHWQxf8eDGG5dkPCazp0ZsqQ0CYr4PPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYGhcY0ZGTe73VDMyhJW71cisvYwXyp3PfO3+fQ2w9lCLasT7m
	ejqdcMc90TljEOUY351d+YBTZl6dFwD10phG9rElV1/5KppisGnoPpuPRhe3Ugfsbg10H4FnQAu
	V5JqEcXXYulQZduG2KKyxl9NUsk+PmVs2zgqU5hkH+rxQ2rDBZK0xj82VBUJgpEwbEuL52VHVN7
	8/
X-Gm-Gg: ASbGncu7HbHHK63e7HumGuWdHKb5Hv5THpg2zCFxh7b4BhEDkYWER1/jG/6TulftQzt
	z6/Aud2/gJcquHKis8vmT0JBHFzwONvbX5GUaAFiP0AGfzjhpw3AgXaTD6Pi3JKvZSs5V2xjKuf
	Swa2gOqy6ZB751NI4o0bic0cC/31oWz2XzPuA3r/4dIkHrVoeJ8Q032ZwWCH8P64JrL+pN6bczM
	NSDhNwnsBl+foC17P6oeZNA1YvveyohfGXHOEE3mix67faz6QWNpHoVrUofzWIJV4ZTFdd5ItPn
	uqR1u47e70Qg2yO7aofm+5LpYERKIoHbpBgvZjUmXmBN4PCVhn1GFeidXoPa1eRZni90z3YSeFy
	m2xyJb9+mVkvtFOOd+iz2ufF/SfHNeA==
X-Received: by 2002:a05:600c:4fcf:b0:471:1717:411 with SMTP id 5b1f17b1804b1-4778fe9b299mr193383235e9.24.1763538098127;
        Tue, 18 Nov 2025 23:41:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsA1eiU5vS1jcJpwG7e4L/TuGO11v1CAxE8UCnKZxrzTCuQDYJ7t3csAArneU0iBm5h3nt7w==
X-Received: by 2002:a05:600c:4fcf:b0:471:1717:411 with SMTP id 5b1f17b1804b1-4778fe9b299mr193383025e9.24.1763538097716;
        Tue, 18 Nov 2025 23:41:37 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10804c8sm32620725e9.15.2025.11.18.23.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:41:37 -0800 (PST)
Date: Wed, 19 Nov 2025 02:41:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251119023904-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
 <20251118164952-mutt-send-email-mst@kernel.org>
 <cb64732c-294e-49e7-aeb5-f8f2f082837e@nvidia.com>
 <20251119013423-mutt-send-email-mst@kernel.org>
 <e23b94ab-35f6-41fb-91f9-1ba9260fc0ed@nvidia.com>
 <20251119022119-mutt-send-email-mst@kernel.org>
 <e80a7828-f42f-4263-89c1-66512b2dde6e@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e80a7828-f42f-4263-89c1-66512b2dde6e@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OjlEDmcrovS2tw607aREPZMcbVl3YduFkFRHS7iktgk_1763538098
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:33:31AM -0600, Dan Jurgens wrote:
> On 11/19/25 1:23 AM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 01:18:56AM -0600, Dan Jurgens wrote:
> >> On 11/19/25 12:35 AM, Michael S. Tsirkin wrote:
> >>> On Wed, Nov 19, 2025 at 12:26:23AM -0600, Dan Jurgens wrote:
> >>>> On 11/18/25 3:55 PM, Michael S. Tsirkin wrote:
> >>>>> On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
> >>>>>> Classifiers can be used by more than one rule. If there is an existing
> >>>>>> classifier, use it instead of creating a new one.
> >>>>
> >>>>>> +	struct virtnet_classifier *tmp;
> >>>>>> +	unsigned long i;
> >>>>>>  	int err;
> >>>>>>  
> >>>>>> -	err = xa_alloc(&ff->classifiers, &c->id, c,
> >>>>>> +	xa_for_each(&ff->classifiers, i, tmp) {
> >>>>>> +		if ((*c)->size == tmp->size &&
> >>>>>> +		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
> >>>>>
> >>>>> note that classifier has padding bytes.
> >>>>> comparing these with memcmp is not safe, is it?
> >>>>
> >>>> The reserved bytes are set to 0, this is fine.
> >>>
> >>> I mean the compiler padding.  set to 0 where?
> >>
> >> There's no compiler padding in virtio_net_ff_selector. There are
> >> reserved fields between the count and selector array.
> > 
> > I might be missing something here, but are not the
> > structures this code compares of the type struct virtnet_classifier
> > not virtio_net_ff_selector ?
> > 
> > and that one is:
> > 
> >  struct virtnet_classifier {
> >         size_t size;
> > +       refcount_t refcount;
> >         u32 id;
> >         struct virtio_net_resource_obj_ff_classifier classifier;
> >  };
> > 
> > 
> > which seems to have some padding depending on the architecture.
> 
> We're only comparing the ->classifier part of that, which is pad free.

Oh I see a classifier has a classifer inside :(

Should be something else, e.g. ff_classifier to avoid confusion I think.

Or resource_obj since it's the resource object. Or even obj.

But


> > 
> > 
> >

