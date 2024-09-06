Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAAC1C870C
	for <virtualization@lists.linux.dev>; Fri,  6 Sep 2024 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617574; cv=none; b=f5TkVLyk8FHNQxGmolTKmdyPUZbFONqt9IjNQN/nLu88zfK++Jt0/j1sMMqM7LdcIJUHX3NMBE9XzcyvLW3MK8+iKNOm9EEqiZQb1ogoLWc69Rfy0FBDagdyY7oN5JTDiGtPWNB+sjf3jQtvW9J/bR/ntdIILAtODwcGQ5VqYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617574; c=relaxed/simple;
	bh=Q9TXSvDsVrJJkjBOgWLMxDjKglYwFps2Xb2s+cWc8UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pcs+lWqCxllkVxhmXdkjPv30WLvzu0zTFXKw6cq8I7ik79yPzqGcueGab636vDheoP22+uOgn5mv7Xr0M/iWz1O9Fc71rgi80UG0jcY3kOJ5E8Y2PoX5t0qy6OOd/e8lYHGkZ2/doCsYGJitbx8YfY1ZU9xchgmNOvkr5VfWNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jwbw/oJc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jwbw/oJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725617570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NHoMcpM/TTdua1Refqr6XchkQxlkBGAth1WdrFW7wCs=;
	b=Jwbw/oJcPaLzZ/Ty2pESd+mwxnlyUiBlHnJCL/Vm0vqUZcaMVkrO8bFsjneq7oE57VJoQi
	ETgtlL/YQk5I4nxVkbTR9JOpQFAp7rPky4/28fquCCBYZgCjLgNNg1lYgrge4U8IpAig3n
	SPDemFtJrQQDIMy3ZrSjMi23bGJCp7o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1--4IsVfdhMeumIsw4BOlkmQ-1; Fri, 06 Sep 2024 06:12:49 -0400
X-MC-Unique: -4IsVfdhMeumIsw4BOlkmQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42c7b39e953so9888385e9.0
        for <virtualization@lists.linux.dev>; Fri, 06 Sep 2024 03:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725617568; x=1726222368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHoMcpM/TTdua1Refqr6XchkQxlkBGAth1WdrFW7wCs=;
        b=NNBjlbtRd2jG3bIsKgYpf2P5yv+OWuO3FdQ4/OP2qZNiRT+R4uLPud5pCJLcR4ji/0
         LLgRroldR9JU5Yhx5loGuaUP8F3iyJMTQjDw41HlxTR4ezBYiY+wTRLVUQFM/70iem51
         VlORpUndCbmWYy2d14F9lVVyPzLJsXxg4Iz6X/4884LbfjOWlxV1nazOYKQordfTfbOz
         N4LyfIUZ+G0SrY02Duvs6ciCx7kXk25osMIfuwT5OfQB/qBJcsTtTBSQyE3+CSGMDrX0
         fO+u4Xo6bpGYa9Lpaz0XuCfsT6QG92PA/S5hQjs9di/MCkkCXFYlZTMRHTbL4RjmfL+z
         pbHA==
X-Forwarded-Encrypted: i=1; AJvYcCWdh3YETq6khWWB5ad3RuMcX0mGlglwL+kYQXtyOK5A3zBc2RL59MXtjjDfXZengwcU4V7+7LxWcQ3RnMB57Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywpd8s5MbljHaNRiUhgZvnJ+S14hG8XGPwBXcmCvlhd4V/3yV1e
	Xsupr8N7bGCOeOsv/akRZpsY+l9RwGiauWT0kEUtloFjk5j4234knoTOO+/VI4iMGsKOK0TCkAI
	gmfXz32Dkq690Cs+4XaKQ/hJ9w7DT76/sGrD9OuEISIx2RgOCdhLYawphobVUel9F
X-Received: by 2002:a05:600c:4f53:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-42c95af7f2fmr53544625e9.6.1725617568311;
        Fri, 06 Sep 2024 03:12:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMfGZxhbaSheOh3dZIC/k+Wm9PeRBDxUi0/bTiDhPKgwP4ARFmRyEdrGyTRIlflMDP6BaG0A==
X-Received: by 2002:a05:600c:4f53:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-42c95af7f2fmr53544195e9.6.1725617567652;
        Fri, 06 Sep 2024 03:12:47 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ccaa4sm15146275e9.14.2024.09.06.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:12:47 -0700 (PDT)
Date: Fri, 6 Sep 2024 06:12:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/7] Revert "virtio_net: rx remove premapped
 failover code"
Message-ID: <20240906061055-mutt-send-email-mst@kernel.org>
References: <cover.1725616135.git.mst@redhat.com>
 <69d3032b6560323844d6d9fb0ac4f832ed87f13d.1725616135.git.mst@redhat.com>
 <1725616970.1687496-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1725616970.1687496-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 06, 2024 at 06:02:50PM +0800, Xuan Zhuo wrote:
> On Fri, 6 Sep 2024 05:52:36 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > This reverts commit defd28aa5acb0fd7c15adc6bc40a8ac277d04dea.
> >
> > leads to crashes with no ACCESS_PLATFORM when
> > sysctl net.core.high_order_alloc_disable=1
> >
> > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 89 +++++++++++++++++++++++-----------------
> >  1 file changed, 52 insertions(+), 37 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0944430dfb1f..0a2ec9570521 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -348,6 +348,9 @@ struct receive_queue {
> >
> >  	/* Record the last dma info to free after new pages is allocated. */
> >  	struct virtnet_rq_dma *last_dma;
> > +
> > +	/* Do dma by self */
> > +	bool do_dma;
> >  };
> >
> >  /* This structure can contain rss message with maximum settings for indirection table and keysize
> > @@ -867,7 +870,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
> >  	void *buf;
> >
> >  	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > -	if (buf)
> > +	if (buf && rq->do_dma)
> >  		virtnet_rq_unmap(rq, buf, *len);
> >
> >  	return buf;
> > @@ -880,6 +883,11 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
> >  	u32 offset;
> >  	void *head;
> >
> > +	if (!rq->do_dma) {
> > +		sg_init_one(rq->sg, buf, len);
> > +		return;
> > +	}
> > +
> >  	head = page_address(rq->alloc_frag.page);
> >
> >  	offset = buf - head;
> > @@ -905,42 +913,44 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> >
> >  	head = page_address(alloc_frag->page);
> >
> > -	dma = head;
> > +	if (rq->do_dma) {
> > +		dma = head;
> >
> > -	/* new pages */
> > -	if (!alloc_frag->offset) {
> > -		if (rq->last_dma) {
> > -			/* Now, the new page is allocated, the last dma
> > -			 * will not be used. So the dma can be unmapped
> > -			 * if the ref is 0.
> > +		/* new pages */
> > +		if (!alloc_frag->offset) {
> > +			if (rq->last_dma) {
> > +				/* Now, the new page is allocated, the last dma
> > +				 * will not be used. So the dma can be unmapped
> > +				 * if the ref is 0.
> > +				 */
> > +				virtnet_rq_unmap(rq, rq->last_dma, 0);
> > +				rq->last_dma = NULL;
> > +			}
> > +
> > +			dma->len = alloc_frag->size - sizeof(*dma);
> > +
> > +			addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
> > +							      dma->len, DMA_FROM_DEVICE, 0);
> > +			if (virtqueue_dma_mapping_error(rq->vq, addr))
> > +				return NULL;
> > +
> > +			dma->addr = addr;
> > +			dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
> > +
> > +			/* Add a reference to dma to prevent the entire dma from
> > +			 * being released during error handling. This reference
> > +			 * will be freed after the pages are no longer used.
> >  			 */
> > -			virtnet_rq_unmap(rq, rq->last_dma, 0);
> > -			rq->last_dma = NULL;
> > +			get_page(alloc_frag->page);
> > +			dma->ref = 1;
> > +			alloc_frag->offset = sizeof(*dma);
> > +
> > +			rq->last_dma = dma;
> >  		}
> >
> > -		dma->len = alloc_frag->size - sizeof(*dma);
> > -
> > -		addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
> > -						      dma->len, DMA_FROM_DEVICE, 0);
> > -		if (virtqueue_dma_mapping_error(rq->vq, addr))
> > -			return NULL;
> > -
> > -		dma->addr = addr;
> > -		dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
> > -
> > -		/* Add a reference to dma to prevent the entire dma from
> > -		 * being released during error handling. This reference
> > -		 * will be freed after the pages are no longer used.
> > -		 */
> > -		get_page(alloc_frag->page);
> > -		dma->ref = 1;
> > -		alloc_frag->offset = sizeof(*dma);
> > -
> > -		rq->last_dma = dma;
> > +		++dma->ref;
> >  	}
> >
> > -	++dma->ref;
> > -
> >  	buf = head + alloc_frag->offset;
> >
> >  	get_page(alloc_frag->page);
> > @@ -957,9 +967,12 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> >  	if (!vi->mergeable_rx_bufs && vi->big_packets)
> >  		return;
> >
> > -	for (i = 0; i < vi->max_queue_pairs; i++)
> > -		/* error should never happen */
> > -		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
> > +	for (i = 0; i < vi->max_queue_pairs; i++) {
> > +		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > +			continue;
> > +
> > +		vi->rq[i].do_dma = true;
> > +	}
> 
> This is too much code to revert. We can just revert this and next one.
> And add a patch to turn off the default premapped setting (return from this
> function directly). Otherwise, we will have to do all the work again in the
> future.
> 
> There is no need to revert xsk related code, xsk function cannot be enabled, in
> the case that premapped mode is not turned on. There is no direct impact itself.
> 
> Thanks.

I tried but quickly got lost as the automatic
revert did not work, and it's very close to release, so
I wanted to be sure it's right.

Post your own version of a revert for testing then please.


> 
> >  }
> >
> >  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> > @@ -2107,7 +2120,8 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> >
> >  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
> >  	if (err < 0) {
> > -		virtnet_rq_unmap(rq, buf, 0);
> > +		if (rq->do_dma)
> > +			virtnet_rq_unmap(rq, buf, 0);
> >  		put_page(virt_to_head_page(buf));
> >  	}
> >
> > @@ -2221,7 +2235,8 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> >  	ctx = mergeable_len_to_ctx(len + room, headroom);
> >  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
> >  	if (err < 0) {
> > -		virtnet_rq_unmap(rq, buf, 0);
> > +		if (rq->do_dma)
> > +			virtnet_rq_unmap(rq, buf, 0);
> >  		put_page(virt_to_head_page(buf));
> >  	}
> >
> > @@ -5392,7 +5407,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
> >  	int i;
> >  	for (i = 0; i < vi->max_queue_pairs; i++)
> >  		if (vi->rq[i].alloc_frag.page) {
> > -			if (vi->rq[i].last_dma)
> > +			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
> >  				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
> >  			put_page(vi->rq[i].alloc_frag.page);
> >  		}
> > --
> > MST
> >

