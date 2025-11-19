Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CC4329E43
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567930; cv=none; b=PrZ1fP4sXLrJ8OrJcXQQoaud8rQgUXeZNSiT9WM40Ry4g1cV5BFs5Ldwy8bToAgvHmzjc04s+5lYg3W3yyzk4Wxc6nqR8q2cWE0402z1R01HahNMdFyeuD9JZExlLXEKRwaTc8VHy3oB47VO54VeclTdWt5edsO1lovWuCEFGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567930; c=relaxed/simple;
	bh=X4udLAHwgPyvvaRrmhlRMNdE0d5tTRvL7IqLthLvERk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KfmmDVdle3VmwRlttFM6xdhym8LD2cwrlLfnpv/F8J+yLsk9DwgLL7SBcr82YLiBmjjd0efHlDmDsuOpHQ1cVR6wY4woA2tOoy562JUAAbb88z9Yazi7XfjE11grC6JwsPwDBrUstCTcA66QwZDKRR3QrP/n8gtwT9uJzeI6/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faijzjwT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faijzjwT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763567926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+84WrDN67gNDUwrYEwopUhwZ+peiqwEB+pp0DqzG0k=;
	b=faijzjwTLig1erSjXR3rfO9uK2Rjkl5WPNrhI3ckabpGZybQr2krArv2NOCDIqEjYPN5TL
	/3zuz2Zgk2/X5FTqnRlN0If1jamdsGEj9PWaQA/SCzc6Rh3e7QkxA42V/N5FstmllMLq2Y
	m6D55uhv3OVVSN4l6fjtYq5aANLE+SA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-5pUv799PPj24bEIEQlPsng-1; Wed, 19 Nov 2025 10:58:45 -0500
X-MC-Unique: 5pUv799PPj24bEIEQlPsng-1
X-Mimecast-MFC-AGG-ID: 5pUv799PPj24bEIEQlPsng_1763567924
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477563a0c75so41203645e9.1
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567924; x=1764172724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+84WrDN67gNDUwrYEwopUhwZ+peiqwEB+pp0DqzG0k=;
        b=ndp/GCw8q/cl6RH6Bujl9yQvY3I+9fZkXFTeC+bMohDUMWKHnQX+M/Qiyd3kVIaDcx
         E+M4KCckJP2hlqlv0deIOE/o2+nrh+u8miHEAiCaHK72lOsHtW+8iRvlG7PT9BEOm2MP
         BMqqeY+5hcadJ/WlOwN9Ahi0gjt02mjqffnZGsCrNJpNYEIZY423BWBgnxD/l+Yd/yZU
         907j3t4TYuC39nMm965g/GoXMvnzaCTBg4LoO+LqUaoL9Jih1ODvAoZYe7nMhySom2pb
         SE6gUSS5kCL5lwAQ90fcgOxawRs6FMP57dLoNG0Vi91ebviK3IOPW4Qv4Lcp0H1oAIb+
         5WgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3vP/A2W2HihUtHdm83naKRCeIcC592LpNccONMGXz6Cl4ULLbswLrCMPYmsttxZOxfm7MCZ8+JaABUQOj2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXpFsZiUxDV85wx769zW2LagVT6OalUXjsTGFLXr/Jh0xEJBKf
	TamAZGb/B9fEovB+lGOUsLnTWqi5NNnvSNj2wIGFVXJ/11/r4ZCkqG8z6ZJSW0oauItiH7mBL04
	O9GCh2tQvUl0Xc7d7gvDJQhPLdgHeA/NFRtQy6nA4fkKhCvNFDAz0xW4LSoaqFHZfQstF
X-Gm-Gg: ASbGncudXfhTi0HB1Iowa8s5Fb4x3vNJWGQ7OctCZpcolcXma5oJddpQ/Yby0rOqtNE
	DuJfG8PZZFOepBKNpRUGLbVvLBNJ98Y6X0GGG6cRDpavk6Y5uAvPNOz6tJFfpgXODXIYoisdyAh
	NCRgZpOKcxzikCuH2zD9tjBooXNP4XnWPWIPdFwA2FUVuU7Qmg+EI0fr8JJbc6FeKje8cNb232a
	QnqoJqLtZDNwYuphzxvU2FdhOJnAaayXPYHE4L2yGooKQSeYYJf3IM8MsWwLpamgpbPs+hNAFgw
	G0GbGmxfWjUN4FNEbCIsAsIGWFt84pQ2O4RLen18J/SQgs6VAFZ0iZGmAM9Z+ei34F+72cFNBF2
	uIpVd+R+umKB1x7Y0HoP1dS6zhZETJQ==
X-Received: by 2002:a05:600c:8b21:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-4778fea84f0mr197459215e9.19.1763567924218;
        Wed, 19 Nov 2025 07:58:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMAURnwpj6ZTjgxBRwe6+8Xyy9ZKG8ZdRRqABNi1mzDn3MCPcvLn2k8HQ1gtbcXROoEePaxw==
X-Received: by 2002:a05:600c:8b21:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-4778fea84f0mr197458765e9.19.1763567923712;
        Wed, 19 Nov 2025 07:58:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1037d32sm52400545e9.12.2025.11.19.07.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:58:42 -0800 (PST)
Date: Wed, 19 Nov 2025 10:58:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 08/12] virtio_net: Use existing classifier
 if possible
Message-ID: <20251119105743-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-9-danielj@nvidia.com>
 <20251118164952-mutt-send-email-mst@kernel.org>
 <cb64732c-294e-49e7-aeb5-f8f2f082837e@nvidia.com>
 <20251119013423-mutt-send-email-mst@kernel.org>
 <e23b94ab-35f6-41fb-91f9-1ba9260fc0ed@nvidia.com>
 <20251119022119-mutt-send-email-mst@kernel.org>
 <e80a7828-f42f-4263-89c1-66512b2dde6e@nvidia.com>
 <20251119023904-mutt-send-email-mst@kernel.org>
 <c88f7798-996e-402c-97fe-1f8cc8ec172c@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c88f7798-996e-402c-97fe-1f8cc8ec172c@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tbbvrKRThWcMq-pCLuYPsp_cyCqqhORcXYyIyPzoq0k_1763567924
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 09:45:15AM -0600, Dan Jurgens wrote:
> On 11/19/25 1:41 AM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 01:33:31AM -0600, Dan Jurgens wrote:
> >> On 11/19/25 1:23 AM, Michael S. Tsirkin wrote:
> >>> On Wed, Nov 19, 2025 at 01:18:56AM -0600, Dan Jurgens wrote:
> >>>> On 11/19/25 12:35 AM, Michael S. Tsirkin wrote:
> >>>>> On Wed, Nov 19, 2025 at 12:26:23AM -0600, Dan Jurgens wrote:
> >>>>>> On 11/18/25 3:55 PM, Michael S. Tsirkin wrote:
> >>>>>>> On Tue, Nov 18, 2025 at 08:38:58AM -0600, Daniel Jurgens wrote:
> >>>>>>>> Classifiers can be used by more than one rule. If there is an existing
> >>>>>>>> classifier, use it instead of creating a new one.
> >>>>>>
> >>>>>>>> +	struct virtnet_classifier *tmp;
> >>>>>>>> +	unsigned long i;
> >>>>>>>>  	int err;
> >>>>>>>>  
> >>>>>>>> -	err = xa_alloc(&ff->classifiers, &c->id, c,
> >>>>>>>> +	xa_for_each(&ff->classifiers, i, tmp) {
> >>>>>>>> +		if ((*c)->size == tmp->size &&
> >>>>>>>> +		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
> >>>>>>>
> >>>>>>> note that classifier has padding bytes.
> >>>>>>> comparing these with memcmp is not safe, is it?
> >>>>>>
> >>>>>> The reserved bytes are set to 0, this is fine.
> >>>>>
> >>>>> I mean the compiler padding.  set to 0 where?
> >>>>
> >>>> There's no compiler padding in virtio_net_ff_selector. There are
> >>>> reserved fields between the count and selector array.
> >>>
> >>> I might be missing something here, but are not the
> >>> structures this code compares of the type struct virtnet_classifier
> >>> not virtio_net_ff_selector ?
> >>>
> >>> and that one is:
> >>>
> >>>  struct virtnet_classifier {
> >>>         size_t size;
> >>> +       refcount_t refcount;
> >>>         u32 id;
> >>>         struct virtio_net_resource_obj_ff_classifier classifier;
> >>>  };
> >>>
> >>>
> >>> which seems to have some padding depending on the architecture.
> >>
> >> We're only comparing the ->classifier part of that, which is pad free.
> > 
> > Oh I see a classifier has a classifer inside :(
> > 
> > Should be something else, e.g. ff_classifier to avoid confusion I think.
> > 
> > Or resource_obj since it's the resource object. Or even obj.
> > 
> > But
> > 
> 
> Did you have more to say after that "But"?

Ugh ... donnu how this got here.

> I did this, also updated the
> commit messages and included refcount.h.

thanks.

> > 
> >>>
> >>>
> >>>
> > 

