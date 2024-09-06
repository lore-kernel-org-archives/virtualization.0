Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E121C7B88
	for <virtualization@lists.linux.dev>; Fri,  6 Sep 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613753; cv=none; b=tONBqZcsGYSwQFQmfcG/44jTUFZC314/GVH3sE1CvOMUsVx5SNeM0smUYWwHzvwEp9ogAwHI9iKPgdZtanrqdcBsZRyzSG3nz/zkyCCpR6/MhEfggPbQ/UKBx1tiR8Qo6zn0/sX0PyLXdJBggsByeB5JAJ6TtjStxNqGdJdQvtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613753; c=relaxed/simple;
	bh=kQnCn6UuRSmObUj2sDmdYIc+ehx2G6t88GoNv0oYrKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bmJXYSqlF3AuURoIQkoAvnLSL987yVyQLZtgFjLNbkpKJz1C6yo0QV9VJDOJMZf6djb/XWAgHT/4bPlnYbZyFhqfudlbCMpwHQh6/SyJsiWf9mBALeHr7U/GtHcL17hfGc5iJvgrPF1cw6N9DQycRUaoZWScs1rdwLEaZhKnp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSfyGlKO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSfyGlKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725613749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D24mRm5LrUYTcb7xHC0WCD/VrAupd5O09gSa9Wcuxe8=;
	b=JSfyGlKOUI/0Xm/9+FBTv0Pdp8obDSI4afbJHiULYbIciF+OAmqy4w4dMxcGcZSALfIC2s
	7UPAe1WLroMeSaQSR/9fZkEp1IOfCidlsTe9c6jhlOj/NfsLUuM/NfHOulR82YR0m8Jd3n
	3EBwl1CELNAA9vTxxnw1Prm/VuEha/s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-vX8uJShpOf6vP1-vuK5g4w-1; Fri, 06 Sep 2024 05:09:06 -0400
X-MC-Unique: vX8uJShpOf6vP1-vuK5g4w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374b35856aeso1129845f8f.3
        for <virtualization@lists.linux.dev>; Fri, 06 Sep 2024 02:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613745; x=1726218545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D24mRm5LrUYTcb7xHC0WCD/VrAupd5O09gSa9Wcuxe8=;
        b=sjzTw+Sl+iUNBAz3+cKGbz375an4iOqSbQPomMCxB60hqfqI95z+Gx/zbn7k01NKD+
         IbnvUrNLQzAJ+xjU/fKsCCzWLdKzGX7Dcrb0kBddKF3eS1euy7pvQdc3dnybWis26Xar
         EkB8E1PEp/1XX7CJTKt682L3xr/HecSUW9IMA1BkxuuBPV3lO+X5Rd1Gq8ZYHxV+FCXx
         T8iIZ4fVYff8mz6yLATkKNWgNsqxRRGMStjvzMJ6cFR2SDEEcyWdpUe/xSAPIh/RzqHu
         86FpMiaGly8MPRKi0t4aShp9YODwiD40U5NWfBgFwr2VIe/l+C/n01J0GNBJtj+5V6fk
         Ilwg==
X-Forwarded-Encrypted: i=1; AJvYcCXO8Aw6Sl2JwLFUAHg5x080mqBVL0NxxXSsS4SHBp3nhnjQ0I8uyu9545jI/Qk7A7bDzamTnJ8zSeWgGWet3g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/vjF5ay+jOQ7d7mwjtYEftM3Wfj5Il/tffFJwFOsbdcIO+W9S
	XJLK6LO9NynW8grznGyC0vLJsW7ngNkGfXdC8NGc4ibIh4qXRSyu2MahZOQRsj4WVwE7K99mFr1
	+Mc26IneF6Nl/xvqmbuKQGzobLUJ3Ow3sco3R0fcKh5PL4Y1NXDCandRrf8/dg7UR
X-Received: by 2002:adf:edd2:0:b0:375:c4c7:c7ac with SMTP id ffacd0b85a97d-378896c8082mr1231865f8f.49.1725613745472;
        Fri, 06 Sep 2024 02:09:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMD4aX16S9LZGKe4EPTwXGfS6x36Rfr8HE2zqgzih2SEOtsrLoz+17HThNjBLPwX/BHpiRNA==
X-Received: by 2002:adf:edd2:0:b0:375:c4c7:c7ac with SMTP id ffacd0b85a97d-378896c8082mr1231823f8f.49.1725613744555;
        Fri, 06 Sep 2024 02:09:04 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374cbbc8281sm12225923f8f.64.2024.09.06.02.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:09:03 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:08:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Message-ID: <20240906045904-mutt-send-email-mst@kernel.org>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240906044143-mutt-send-email-mst@kernel.org>
 <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > > leads to regression on VM with the sysctl value of:
> > >
> > > - net.core.high_order_alloc_disable=1
> > >
> > > which could see reliable crashes or scp failure (scp a file 100M in size
> > > to VM):
> > >
> > > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > everything is fine. However, if the frag is only one page and the
> > > total size of the buffer and virtnet_rq_dma is larger than one page, an
> > > overflow may occur. In this case, if an overflow is possible, I adjust
> > > the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> > > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> > > the first buffer of the frag is affected.
> > >
> > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> >
> > Guys where are we going with this? We have a crasher right now,
> > if this is not fixed ASAP I'd have to revert a ton of
> > work Xuan Zhuo just did.
> 
> I think this patch can fix it and I tested it.
> But Darren said this patch did not work.
> I need more info about the crash that Darren encountered.
> 
> Thanks.

So what are we doing? Revert the whole pile for now?
Seems to be a bit of a pity, but maybe that's the best we can do
for this release.


> >
> >
> > > ---
> > >  drivers/net/virtio_net.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index c6af18948092..e5286a6da863 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> > >  	void *buf, *head;
> > >  	dma_addr_t addr;
> > >
> > > -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> > > -		return NULL;
> > > -
> > >  	head = page_address(alloc_frag->page);
> > >
> > >  	dma = head;
> > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> > >  	len = SKB_DATA_ALIGN(len) +
> > >  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > >
> > > +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> > > +		return -ENOMEM;
> > > +
> > >  	buf = virtnet_rq_alloc(rq, len, gfp);
> > >  	if (unlikely(!buf))
> > >  		return -ENOMEM;
> > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> > >  	 */
> > >  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> > >
> > > +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> > > +		return -ENOMEM;
> > > +
> > > +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> > > +		len -= sizeof(struct virtnet_rq_dma);
> > > +
> > >  	buf = virtnet_rq_alloc(rq, len + room, gfp);
> > >  	if (unlikely(!buf))
> > >  		return -ENOMEM;
> > > --
> > > 2.32.0.3.g01195cf9f
> >

