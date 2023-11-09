Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039F1DA26
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gt3PZpTx"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A6B7240119
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 12:00:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6B7240119
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gt3PZpTx
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ML3tqYnT12XS
	for <virtualization@lists.linux-foundation.org>;
	Thu,  9 Nov 2023 11:59:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 66CA1400D8
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 11:59:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 66CA1400D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699531198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XBwh9BfcsGwN4p/3iVkVIw7CCYFfvzovBsgfhDaKJj0=;
	b=Gt3PZpTx1OBlTopq6HYk7yHhuCzdyA43B7GpfnKx7f9IwKebG3p2XpNKNqHcU8rNx9vCcx
	zynsZrXoTXklt/jZ2hEvHCNYUe1XQBtSQ3JOLTjsmYrPJOnhpqbBjQ3SVTNPj80ErMKyzb
	8HYdjl/mISY9BhZBO1q9bh4Fa1aNwJo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-zTSfnsKpM3GdKR3Yy95Eyw-1; Thu, 09 Nov 2023 06:59:54 -0500
X-MC-Unique: zTSfnsKpM3GdKR3Yy95Eyw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9e27cc6dbf0so61339466b.1
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Nov 2023 03:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699531193; x=1700135993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBwh9BfcsGwN4p/3iVkVIw7CCYFfvzovBsgfhDaKJj0=;
        b=NxlNUYzoscEZ9+iNEgejv1slaKnsydJawjc5+8LJaa5jjAfUPUZ2ikyiA/X0hpGl31
         efs1Ett8c6j+QOMPiI3Tp7aPtBT91KZ2+8ETStnaDKCybrpfHnJN85nX6RNQmWmDEBdA
         7tbG8zCBZcHxFw1tLDttSdwvncko5vYEHwFHUJEZoajwb77m5leFmYyF66Sb+C7fvkEl
         8oFugQyc59gmRrrD0G4rg56+p3wcDtvRm9BQFwC2wZwVc1EKAmV6IGr9+dafj+ur6MkB
         YJeUn2S9C6jLfRR/kc0/BvGHSzkqo5CK2MoDlmiRyHXcPFdND/JBont6Le8qvcWawUYz
         AbDw==
X-Gm-Message-State: AOJu0YyAfrXSUoKJ10H18+PZEMj7LmzbY3ormruZzNqgaG3gktff+Q84
	MmUhz3Jwda+e2owpSKq1+OSq73JlLmHFTjrVPxXFZMiZCM8kSeWj3U2S/amlqaRBAX8eECg/gf8
	u9A6GAZEmHg9ac89sKzfGykgmekJxwVodUOc0Wd4Q+A==
X-Received: by 2002:a17:907:744:b0:9de:32bb:faab with SMTP id xc4-20020a170907074400b009de32bbfaabmr3907933ejb.32.1699531193523;
        Thu, 09 Nov 2023 03:59:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMY+vJ5AkmDkv/+cqz1oiQHT3s2m2UmdbF1nYIjYe0sBg3Jp/+950PgPxklsw5ykh2i/4Kyw==
X-Received: by 2002:a17:907:744:b0:9de:32bb:faab with SMTP id xc4-20020a170907074400b009de32bbfaabmr3907913ejb.32.1699531193110;
        Thu, 09 Nov 2023 03:59:53 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id ss24-20020a170907039800b009de3fd8cbfasm2450555ejb.0.2023.11.09.03.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:59:52 -0800 (PST)
Date: Thu, 9 Nov 2023 06:59:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 14/21] virtio_net: xsk: tx:
 virtnet_free_old_xmit() distinguishes xsk buffer
Message-ID: <20231109065912-mutt-send-email-mst@kernel.org>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-15-xuanzhuo@linux.alibaba.com>
 <20231109061056-mutt-send-email-mst@kernel.org>
 <1699528568.0674586-6-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1699528568.0674586-6-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 09, 2023 at 07:16:08PM +0800, Xuan Zhuo wrote:
> On Thu, 9 Nov 2023 06:11:49 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Nov 07, 2023 at 11:12:20AM +0800, Xuan Zhuo wrote:
> > > virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
> > > buffer) by the last bits of the pointer.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio/virtio_net.h | 18 ++++++++++++++++--
> > >  drivers/net/virtio/xsk.h        |  5 +++++
> > >  2 files changed, 21 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> > > index a431a2c1ee47..a13d6d301fdb 100644
> > > --- a/drivers/net/virtio/virtio_net.h
> > > +++ b/drivers/net/virtio/virtio_net.h
> > > @@ -225,6 +225,11 @@ struct virtnet_info {
> > >  	struct failover *failover;
> > >  };
> > >
> > > +static inline bool virtnet_is_skb_ptr(void *ptr)
> > > +{
> > > +	return !((unsigned long)ptr & VIRTIO_XMIT_DATA_MASK);
> > > +}
> > > +
> > >  static inline bool virtnet_is_xdp_frame(void *ptr)
> > >  {
> > >  	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> > > @@ -235,6 +240,8 @@ static inline struct xdp_frame *virtnet_ptr_to_xdp(void *ptr)
> > >  	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
> > >  }
> > >
> > > +static inline u32 virtnet_ptr_to_xsk(void *ptr);
> > > +
> >
> > I don't understand why you need this here.
> 
> The below function virtnet_free_old_xmit needs this.
> 
> Thanks.

I don't understand why is virtnet_free_old_xmit inline, either.

> >
> >
> > >  static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
> > >  {
> > >  	struct virtnet_sq_dma *next, *head;
> > > @@ -261,11 +268,12 @@ static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
> > >  static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > >  					 u64 *bytes, u64 *packets)
> > >  {
> > > +	unsigned int xsknum = 0;
> > >  	unsigned int len;
> > >  	void *ptr;
> > >
> > >  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> > > -		if (!virtnet_is_xdp_frame(ptr)) {
> > > +		if (virtnet_is_skb_ptr(ptr)) {
> > >  			struct sk_buff *skb;
> > >
> > >  			if (sq->do_dma)
> > > @@ -277,7 +285,7 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > >
> > >  			*bytes += skb->len;
> > >  			napi_consume_skb(skb, in_napi);
> > > -		} else {
> > > +		} else if (virtnet_is_xdp_frame(ptr)) {
> > >  			struct xdp_frame *frame;
> > >
> > >  			if (sq->do_dma)
> > > @@ -287,9 +295,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > >
> > >  			*bytes += xdp_get_frame_len(frame);
> > >  			xdp_return_frame(frame);
> > > +		} else {
> > > +			*bytes += virtnet_ptr_to_xsk(ptr);
> > > +			++xsknum;
> > >  		}
> > >  		(*packets)++;
> > >  	}
> > > +
> > > +	if (xsknum)
> > > +		xsk_tx_completed(sq->xsk.pool, xsknum);
> > >  }
> > >
> > >  static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> > > diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> > > index 1bd19dcda649..7ebc9bda7aee 100644
> > > --- a/drivers/net/virtio/xsk.h
> > > +++ b/drivers/net/virtio/xsk.h
> > > @@ -14,6 +14,11 @@ static inline void *virtnet_xsk_to_ptr(u32 len)
> > >  	return (void *)(p | VIRTIO_XSK_FLAG);
> > >  }
> > >
> > > +static inline u32 virtnet_ptr_to_xsk(void *ptr)
> > > +{
> > > +	return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
> > > +}
> > > +
> > >  int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
> > >  bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> > >  		      int budget);
> > > --
> > > 2.32.0.3.g01195cf9f
> >
> >

