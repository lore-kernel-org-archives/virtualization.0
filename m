Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175C333123C
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711011; cv=none; b=G5u8GpPg1BcbfKoF+j/pH1dAH4Y/ilDO9hk5cZdI/3RelizwjQ+J6GzyBcnc5EvMbA88wfeCCI1zaZHxokdm0b0K9YZiQMHiBt1cJTlaPxHar16ne1ixxMvdSdYkXL++eCK37ymz/NDJazZqCRFdd/m0EQE1wkIRD6U+HsA9jPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711011; c=relaxed/simple;
	bh=RqfJjI32FdZ7MpeaFMqvXp4bO7LyOB4RofYVb7BWxmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YOQ3ddBhL0XDCC1xGBlzU7W+wXeltw5bsGORU+Hd7JHBJXFJAhPJwPfaV92YTvBLrCuxftksShlxWLADNAGYVYZHGOcptDHlQLyRiSFzSaEgYIN0G2g/gycteKrp+y0nODeTCkaNmV78PWUyAfhztwQEaBhP4EeM1BXHLdfsu3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6N9B7rq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6N9B7rq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767711008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0jRp3cPG5jRtvX04esVBCT8Xv2J8JEx5kZGeR0bhCr4=;
	b=Q6N9B7rqBOy0edULfnPlNXw7pyLqnuaZ2kNeNi/0yvEpuUlPAM74/ALShcP0D8LK8pl7aE
	RyAIL7DkJq/N2Ik4ubtpFZ3y3dt9u5EJyLMNZ0u8EGrDZmXZAP3Y4N4X5EElvXoGhAjASm
	9e+El8SlpopjnrZbBE0ZpFD7PJKDNUA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-QOrKQF9AOqqL7yexPyPZGQ-1; Tue, 06 Jan 2026 09:50:06 -0500
X-MC-Unique: QOrKQF9AOqqL7yexPyPZGQ-1
X-Mimecast-MFC-AGG-ID: QOrKQF9AOqqL7yexPyPZGQ_1767711006
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477c49f273fso10752865e9.3
        for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 06:50:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711005; x=1768315805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jRp3cPG5jRtvX04esVBCT8Xv2J8JEx5kZGeR0bhCr4=;
        b=ns9oJEP9bL0uZgUFt/t737v67c1/alSfVBXgFeELNdEMOB4oWYfdQvgYaQ+mBZkV91
         uCzEAnh6Fwl2s3OgIBvk+MDx/3FDP1BeYP/3mnCFxzng+85SqZTl6sCfbMiHSLHOZlLM
         mk5eu6x52fPLbOj5AMJ1mW/8bIF4PpDQzm4BA793PErKxgiXF/gzertKQnccKJ8YSkta
         1DAzoDFlkSuqCvuHYG1dOQSMYLgCIabVxy0+qf6zC8CMP5QIc32WCj0Z3EtSOWqNb2DV
         QNBNuOjbh6tJSN223uEId/2+m6Y3bwFzSn74oaGIw0pm/nM5grw3ScZU4h410MGsTdlz
         STJg==
X-Forwarded-Encrypted: i=1; AJvYcCUbXIowJVb7w9eqfBCdFEenQCx1fqbCLu1yhjhIv7x9i1uS1ZwefYxZ6dquTzWwancDLRYIxa7fEwBX1A0+BA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywer9+hZDdfQAKXilXqih8taSWX/s8+/F+yy6Nlq3wbqR4zQqWI
	a2qBwvzFEX2HJRDm+EdzmJGvP8zwEvKH3cnIQuqK8IZs14DlwUXoi4Fghsrde/WCFZN231IsluQ
	TzbZxNJI5iidXV1IJwikakNSu8ji5s4jD3+gwK1zTQBWfYSTyeUD9d9/LeM0+z6aDqPr3
X-Gm-Gg: AY/fxX6VWjwl4iMlPRcG0DF6/XzzBd8Rw+t7tonmqfrJQnOGmAxcxapOhrODwXVE7w3
	2JXDVeEoGn0UX/X/o/Rbbwr/exYkkb1WoDw0hFrY2359i1ikxYXF9YgjHaqfWWv9KDj9hrbzyJm
	3YWLi//Tabb1a9AmQreJIj5vbL17i5bXs0n4qsFrj4o7GRNjUDj0UnIRqX4I8IZWcejeXiEKpKy
	NKvi+HVXoWoLmN9lJy5Njf2bplh0YnX7vTb8ARcZhMShNRYKhbuB+iVFTJtorH5BmzUESwfbLuu
	sZQnxH9k08FadLUyay3Ejl/tz3+YGn3Rpje2F1SVqkLwLfJr3VA5LXYbbI9QtNd1WKqyheIFU+/
	J+T9aqPTMzxNcUTdldgwCpN8ujeCLHcfJWA==
X-Received: by 2002:a05:600c:c0c5:b0:47d:6856:9bd9 with SMTP id 5b1f17b1804b1-47d8383d75cmr7820835e9.23.1767711005516;
        Tue, 06 Jan 2026 06:50:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXHeGoEH1PxicAu3pvp2IKmLzneQBM5bSFfOKMFfLat4mQRdOWLJ6nIuVR4bStC0oG3LJdHw==
X-Received: by 2002:a05:600c:c0c5:b0:47d:6856:9bd9 with SMTP id 5b1f17b1804b1-47d8383d75cmr7820345e9.23.1767711004990;
        Tue, 06 Jan 2026 06:50:04 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f695956sm48129575e9.6.2026.01.06.06.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 06:50:04 -0800 (PST)
Date: Tue, 6 Jan 2026 09:50:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
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
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 10/15] virtio_scsi: fix DMA cacheline issues for events
Message-ID: <20260106094824-mutt-send-email-mst@kernel.org>
References: <cover.1767601130.git.mst@redhat.com>
 <8801aeef7576a155299f19b6887682dd3a272aba.1767601130.git.mst@redhat.com>
 <20260105181939.GA59391@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260105181939.GA59391@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QmqQCsMBB556dA0vzRwsOqPsd_4XlLPIrRlsAjbKjFE_1767711006
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2026 at 01:19:39PM -0500, Stefan Hajnoczi wrote:
> On Mon, Jan 05, 2026 at 03:23:29AM -0500, Michael S. Tsirkin wrote:
> > @@ -61,7 +62,7 @@ struct virtio_scsi_cmd {
> >  
> >  struct virtio_scsi_event_node {
> >  	struct virtio_scsi *vscsi;
> > -	struct virtio_scsi_event event;
> > +	struct virtio_scsi_event *event;
> >  	struct work_struct work;
> >  };
> >  
> > @@ -89,6 +90,11 @@ struct virtio_scsi {
> >  
> >  	struct virtio_scsi_vq ctrl_vq;
> >  	struct virtio_scsi_vq event_vq;
> > +
> > +	__dma_from_device_group_begin();
> > +	struct virtio_scsi_event events[VIRTIO_SCSI_EVENT_LEN];
> > +	__dma_from_device_group_end();
> 
> If the device emits two events in rapid succession, could the CPU see
> stale data for the second event because it already holds the cache line
> for reading the first event?

No because virtio does unmap and syncs the cache line.

In other words, CPU reads cause no issues.

The issues are exclusively around CPU writes dirtying the
cache and writeback overwriting DMA data.

> In other words, it's not obvious to me that the DMA warnings are indeed
> spurious and should be silenced here.
> 
> It seems safer and simpler to align and pad the struct virtio_scsi_event
> field in struct virtio_scsi_event_node rather than packing these structs
> into a single array here they might share cache lines.
> 
> Stefan


