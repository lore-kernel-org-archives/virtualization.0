Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C88D154C15
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184558; cv=none; b=F/Jf5O/apcfWqaUHwvGrkXNxWsE/gPVVaSJFbw5566+jvIp3w0ARjqEQ4ngVXuNsFfoKIa3JAbrYNB1hOGHHQAkgwW7xHZamPZ5OJ4Sa2nUyY5roaCtfWp4Ziw1WHiXpDZYPXGVNllkZPG5cXkBThHLjicOCCC402NfBGS3xy90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184558; c=relaxed/simple;
	bh=ew/llD8fNewcZrcJgy3/KTKvi8LRuUziUqtu5X4Y9gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lyJsrB4AvG4TzEV9gO93zwsnKQtNdmU1R+w9iLx3QAji0Wj0Q87lHNB5tBc4nRwiEcxdDMEwBgO728DSqGDRCALCfLsfYdclqfNylSVinwoo0Y78Pbjz3DO6/tU3+873r7nDcmWROoae03hg7T0NO5vpqTPTbTN8TA5aYkJRahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a423YaST; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a423YaST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724184554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GvJphMfmz1khUnsod3XRUDT6Zfhn53SWcX8HNDUqauY=;
	b=a423YaSTuZtX45ha38b8/fkRRLr85h9BOFvOARm0zuE4+9lnx/QEjKuR+x5ujWpSui9r+/
	AcLTWqU5e81OvEYEo4lOinW7aDWdAKiavjMkKSu2G58uDUkTD8YlI/0SwAT+Foud5TXuq6
	2SKCfNmom3sh50tCDEtBhn7IymutXzM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-cxrvUG-_P2CrLAlsCmsX5w-1; Tue, 20 Aug 2024 16:09:13 -0400
X-MC-Unique: cxrvUG-_P2CrLAlsCmsX5w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-427ffa0c9c7so63845975e9.1
        for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 13:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724184552; x=1724789352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvJphMfmz1khUnsod3XRUDT6Zfhn53SWcX8HNDUqauY=;
        b=j7Xjx4CCF4WegclJ6kz0Xb/Ub1pAoVfSh16ca66Dt7os2mL4joA+fBiRn9KcKKsdkp
         cbOMsoR1Xcy5EE9HY2dLrnnPdECIXlZW8eiDkqsg1hmsmX33HtmmRuSqylt8oOtB4/h6
         P27O7fQHNc+/RbikdMH+wGd8p+lJDw+7SNL1dxnP+LitIa0o0xDIR/s+UEF+vbFJJe/8
         R6M8NN1rphrzxI5DbyI9Fu6psFMXrHNcKnIGGw+is3r+IGeNAMCFJxRoZNtoJPyXJGI8
         kAQ/gS3hxTQwt1Bwq2RI67wfRYcRihw6/9Gx++BmEXWXrbkY1/f3/ef2fzZAvoFj+qz3
         JsYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEpTyeePW6R2EAu4EZ5AxGOhwOmSAXU6oIaUQdmRX/veR1e+gXeV4+YD91cqM0esdJo3PWmpynUmwMDR8UoA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxjnw1wjqxpfY64K9iAP+3vWm6V0FmQrRdAJ8bgk7xCeBsqgneV
	ITM905oaBzpPL5QxdCjDTj8HlU/lEpXVuebIPkGShoRDGc0x5tvKnfBS4z/s2GXLC7JRAvORwjW
	GYGvLj+odEUoaCKOntfsIsShISLuoSOuFrErHfUIkKlvan0NI52lV+fcDv0EYUMje
X-Received: by 2002:a05:600c:3848:b0:425:81bd:e5ee with SMTP id 5b1f17b1804b1-42abd215555mr3249795e9.16.1724184551987;
        Tue, 20 Aug 2024 13:09:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1+zzzbO8FsPT4Z4pnzHZCzHrS5J8jTIMttdZ6FKfsjypmFekgzGHT4tNWTXEDFmsz39e9lQ==
X-Received: by 2002:a05:600c:3848:b0:425:81bd:e5ee with SMTP id 5b1f17b1804b1-42abd215555mr3249525e9.16.1724184551024;
        Tue, 20 Aug 2024 13:09:11 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:a812:cb6d:d20c:bd3b:58cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7bb5fsm210401065e9.40.2024.08.20.13.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 13:09:09 -0700 (PDT)
Date: Tue, 20 Aug 2024 16:09:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Message-ID: <20240820160342-mutt-send-email-mst@kernel.org>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <4df66dea-ee7d-640d-0e25-5e27a5ec8899@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4df66dea-ee7d-640d-0e25-5e27a5ec8899@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2024 at 12:44:46PM -0700, Si-Wei Liu wrote:
> 
> 
> On 8/20/2024 12:19 AM, Xuan Zhuo wrote:
> > leads to regression on VM with the sysctl value of:
> > 
> > - net.core.high_order_alloc_disable=1
> > 
> > which could see reliable crashes or scp failure (scp a file 100M in size
> > to VM):
> > 
> > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> > of a new frag. When the frag size is larger than PAGE_SIZE,
> > everything is fine. However, if the frag is only one page and the
> > total size of the buffer and virtnet_rq_dma is larger than one page, an
> > overflow may occur. In this case, if an overflow is possible, I adjust
> > the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> > the first buffer of the frag is affected.
> > 
> > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >   drivers/net/virtio_net.c | 12 +++++++++---
> >   1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c6af18948092..e5286a6da863 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> >   	void *buf, *head;
> >   	dma_addr_t addr;
> > -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> > -		return NULL;
> > -
> >   	head = page_address(alloc_frag->page);
> >   	dma = head;
> > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> >   	len = SKB_DATA_ALIGN(len) +
> >   	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> > +		return -ENOMEM;
> > +
> Do you want to document the assumption that small packet case won't end up
> crossing the page frag boundary unlike the mergeable case? Add a comment
> block to explain or a WARN_ON() check against potential overflow would work
> with me.
> 
> >   	buf = virtnet_rq_alloc(rq, len, gfp);
> >   	if (unlikely(!buf))
> >   		return -ENOMEM;
> > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> >   	 */
> >   	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> > +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> > +		return -ENOMEM;
> > +
> > +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> > +		len -= sizeof(struct virtnet_rq_dma);
> > +
> This could address my previous concern for possibly regressing every buffer
> size for the mergeable case, thanks. Though I still don't get why carving up
> a small chunk from page_frag for storing the virtnet_rq_dma metadata, this
> would cause perf regression on certain MTU size

4Kbyte MTU exactly?

> that happens to end up with
> one more base page (and an extra descriptor as well) to be allocated
> compared to the previous code without the extra virtnet_rq_dma content. How
> hard would it be to allocate a dedicated struct to store the related
> information without affecting the (size of) datapath pages?
> 
> FWIW, out of the code review perspective, I've looked up the past
> conversations but didn't see comprehensive benchmark was done before
> removing the old code and making premap the sole default mode. Granted this
> would reduce the footprint of additional code and the associated maintaining
> cost immediately, but I would assume at least there should have been
> thorough performance runs upfront to guarantee no regression is seen with
> every possible use case, or the negative effect is comparatively negligible
> even though there's slight regression in some limited case. If that kind of
> perf measurement hadn't been done before getting accepted/merged, I think at
> least it should allow both modes to coexist for a while such that every user
> could gauge the performance effect.
> 
> Thanks,
> -Siwei
> 
> >   	buf = virtnet_rq_alloc(rq, len + room, gfp);
> >   	if (unlikely(!buf))
> >   		return -ENOMEM;

