Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B131220E4
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 05:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tx13K5Ju"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48CA74210D
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 05:37:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48CA74210D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tx13K5Ju
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O7TsuH-DzfM3
	for <virtualization@lists.linux-foundation.org>;
	Fri, 10 Nov 2023 05:37:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0CB3D420E4
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 05:37:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0CB3D420E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699594661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqPJjk2MnnGWUWPzIuCuxDAT90q27Y0NAPuOrC1RSKw=;
	b=Tx13K5Ju3CvSIeu3161vke3Ulnw7DzEr+sBCf9TEE4a03p+xWftUJ3MB0ONeiUOPAVVQMl
	6a6AwACjy53iOPM2FeI9mMfhIuB6zNxD+8Ttk5cEalkWPlqvMtjbSfSOLrVLjYQYWPZP6A
	JsCYyj6NwbJfGXiPhT7QZ6IH9cqlcZY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-BGb01zp8PQ2Y02BC_c-11g-1; Fri, 10 Nov 2023 00:37:39 -0500
X-MC-Unique: BGb01zp8PQ2Y02BC_c-11g-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-543d2bc7d9dso1295383a12.1
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Nov 2023 21:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699594658; x=1700199458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqPJjk2MnnGWUWPzIuCuxDAT90q27Y0NAPuOrC1RSKw=;
        b=jaIs5jJGyVgZGxOlf6boeX5HZbGzELuuwT03H4+8pkqFZMzT4KVIhEATfG4Y1Ulw4j
         i/vyKuXDsTVoQYKEHyKZc4lH4HZXxsudC1dAH+K0TZVbWg1AGdajr09D7GFNWcxEbtYr
         CGfCmJ9HEv9MD/3MDgIrqagNlWbny1wluRbCxI1lXlGU5dru2BXeR264i9lLAkd+fw65
         VkoivhmZsBAPybzTVnRv11cIF5r5dDZQtqYe0djdtpku9iamgF7akrOGwVjF11UamxUI
         VkCK012in51hktbOYjximglhFChN0bqUAwJZU07U3QsmREiWZn85xq2fLv8oX76te7bG
         U8sQ==
X-Gm-Message-State: AOJu0YxmnJ1K7e1aX3lkojyKQzCPwCRZQkIq0IxLV+MmCxvSuOvJrqKM
	7LagDIXxI5NA5uq/KGRzf3Mnk4REjRLvaQdaNIkxKYS12H8L+3RwHehcYgHutiofR9MwAMN9WS7
	l97ZJl20WdKDJn1yrHOWJmJEt3ielnN1chsM6ScRejg==
X-Received: by 2002:a50:cd1c:0:b0:540:7a88:ac7c with SMTP id z28-20020a50cd1c000000b005407a88ac7cmr5784231edi.21.1699594658658;
        Thu, 09 Nov 2023 21:37:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7zLetQroH1ubeoLJcpWp4q5dNSVEDvqJm+BH0wZvyeMC1ulO2/9gwKCf7p62SZ1ryr4goAA==
X-Received: by 2002:a50:cd1c:0:b0:540:7a88:ac7c with SMTP id z28-20020a50cd1c000000b005407a88ac7cmr5784218edi.21.1699594658295;
        Thu, 09 Nov 2023 21:37:38 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id h10-20020a50cdca000000b00540ea3a25e6sm690965edj.72.2023.11.09.21.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:37:37 -0800 (PST)
Date: Fri, 10 Nov 2023 00:37:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net] virtio_net: fix missing dma unmap for resize
Message-ID: <20231110003406-mutt-send-email-mst@kernel.org>
References: <20231106081832.668-1-xuanzhuo@linux.alibaba.com>
 <20231109070359-mutt-send-email-mst@kernel.org>
 <1699581525.5133314-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1699581525.5133314-4-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 10, 2023 at 09:58:45AM +0800, Xuan Zhuo wrote:
> On Thu, 9 Nov 2023 07:06:16 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Nov 06, 2023 at 04:18:32PM +0800, Xuan Zhuo wrote:
> > > For rq, we have three cases getting buffers from virtio core:
> > >
> > > 1. virtqueue_get_buf{,_ctx}
> > > 2. virtqueue_detach_unused_buf
> > > 3. callback for virtqueue_resize
> > >
> > > But in commit 295525e29a5b("virtio_net: merge dma operations when
> > > filling mergeable buffers"), I missed the dma unmap for the #3 case.
> > >
> > > That will leak some memory, because I did not release the pages referred
> > > by the unused buffers.
> > >
> > > If we do such script, we will make the system OOM.
> > >
> > >     while true
> > >     do
> > >             ethtool -G ens4 rx 128
> > >             ethtool -G ens4 rx 256
> > >             free -m
> > >     done
> > >
> > > Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 43 ++++++++++++++++++++--------------------
> > >  1 file changed, 22 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index d16f592c2061..6423a3a007ce 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -408,6 +408,17 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
> > >  	return p;
> > >  }
> > >
> > > +static void virtnet_rq_free_buf(struct virtnet_info *vi,
> > > +				struct receive_queue *rq, void *buf)
> > > +{
> > > +	if (vi->mergeable_rx_bufs)
> > > +		put_page(virt_to_head_page(buf));
> > > +	else if (vi->big_packets)
> > > +		give_pages(rq, buf);
> > > +	else
> > > +		put_page(virt_to_head_page(buf));
> > > +}
> > > +
> >
> > >  static void enable_delayed_refill(struct virtnet_info *vi)
> > >  {
> > >  	spin_lock_bh(&vi->refill_lock);
> > > @@ -634,17 +645,6 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
> > >  	return buf;
> > >  }
> > >
> > > -static void *virtnet_rq_detach_unused_buf(struct receive_queue *rq)
> > > -{
> > > -	void *buf;
> > > -
> > > -	buf = virtqueue_detach_unused_buf(rq->vq);
> > > -	if (buf && rq->do_dma)
> > > -		virtnet_rq_unmap(rq, buf, 0);
> > > -
> > > -	return buf;
> > > -}
> > > -
> > >  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
> > >  {
> > >  	struct virtnet_rq_dma *dma;
> > > @@ -1764,7 +1764,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > >  	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> > >  		pr_debug("%s: short packet %i\n", dev->name, len);
> > >  		DEV_STATS_INC(dev, rx_length_errors);
> > > -		virtnet_rq_free_unused_buf(rq->vq, buf);
> > > +		virtnet_rq_free_buf(vi, rq, buf);
> > >  		return;
> > >  	}
> > >
> > > @@ -4034,14 +4034,15 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> > >  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> > >  {
> > >  	struct virtnet_info *vi = vq->vdev->priv;
> > > +	struct receive_queue *rq;
> > >  	int i = vq2rxq(vq);
> > >
> > > -	if (vi->mergeable_rx_bufs)
> > > -		put_page(virt_to_head_page(buf));
> > > -	else if (vi->big_packets)
> > > -		give_pages(&vi->rq[i], buf);
> > > -	else
> > > -		put_page(virt_to_head_page(buf));
> > > +	rq = &vi->rq[i];
> > > +
> > > +	if (rq->do_dma)
> > > +		virtnet_rq_unmap(rq, buf, 0);
> > > +
> > > +	virtnet_rq_free_buf(vi, rq, buf);
> > >  }
> > >
> >
> > So we have virtnet_rq_free_buf which sounds like it should free any
> > buf, and we have virtnet_rq_free_unused_buf which is only for unused.
> > Or so it would seem from names but this is not true.
> > Better function names?
> 
> Sorry. not get it.
> 
> virtnet_rq_free_buf() that free the buf passed in. That is called by
> virtnet_rq_free_unused_buf or receive_buf to free the buffer. I think
> the name is right.
> 
> virtnet_rq_free_unused_buf is called by free_unused_bufs() and the
> virtqueue_resize() to free the unused bufs. I think this name is right also.
> 
> So I do not get your mean.
> Are there any details I've overlooked?
> 
> Thanks.

Bad function names - they are too similar. Function name should
say what it does not where it's called from.
What is the difference? That virtnet_rq_free_unused_buf unmaps
and frees and virtnet_rq_free_buf just frees memory?


> >
> > >  static void free_unused_bufs(struct virtnet_info *vi)
> > > @@ -4057,10 +4058,10 @@ static void free_unused_bufs(struct virtnet_info *vi)
> > >  	}
> > >
> > >  	for (i = 0; i < vi->max_queue_pairs; i++) {
> > > -		struct receive_queue *rq = &vi->rq[i];
> > > +		struct virtqueue *vq = vi->rq[i].vq;
> > >
> > > -		while ((buf = virtnet_rq_detach_unused_buf(rq)) != NULL)
> > > -			virtnet_rq_free_unused_buf(rq->vq, buf);
> > > +		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> > > +			virtnet_rq_free_unused_buf(vq, buf);
> > >  		cond_resched();
> > >  	}
> > >  }
> > > --
> > > 2.32.0.3.g01195cf9f
> >

