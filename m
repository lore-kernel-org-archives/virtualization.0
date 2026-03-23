Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D233C060F
	for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285847; cv=none; b=JgzlKHenHaLKBkKs0LvCYEeD72WgLtGAxjidKFkmPoEFaAxrPKD19zKobMUMqiFPvH06CUbq9aoYcKedexl/zTaUM0j0eqyLrZK7gtywuiNnGbFE0LUa67X8Y0/3ySbki51LRUKELDYzM3CmGYCroBwL3EoaI37f/3MeattG/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285847; c=relaxed/simple;
	bh=AXu4moyYLT6oyjJm/jW8zlTRLJclBIHpMOpF1YV/RDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=huyg3R1fy7yRbrgPgC1amHv2RnyvxOV5LQiUM+rQAlqjMaIdaXO+cPTrftVhshC6SADKBPGPwlmJ9cCRXzgba+9RDIkk5SLhFqq7oxEk/dYd7kAMmHzBfYLIJGIdD1B+RGBUMeiRXNYdhOQepnhXSmM9MmA+EKc/A/Y1TMfkzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VL21juQz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VL21juQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774285844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VgSRRWjYpcT9SP6nnEifjHM4Oz7EppnrFyKqEruLcwQ=;
	b=VL21juQzJchFvWLpZ2xlBVL7+smde+yYCSLOCg3/WBKfGPazSlFJ19tqIpxLsQ4PsyKnbm
	HDNr6zx5vPXYMqKPYkCKP/c5BK2TETjySy+shPSSYpVt8wqIIElB6ei0OX5dvcID+Y2OR7
	rsuCN6QbO67cCYGx6vxhBszKNAmB2p4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-mI9VS9PIM9WpQBICHZiv1w-1; Mon, 23 Mar 2026 13:10:43 -0400
X-MC-Unique: mI9VS9PIM9WpQBICHZiv1w-1
X-Mimecast-MFC-AGG-ID: mI9VS9PIM9WpQBICHZiv1w_1774285842
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b3a675316so478165f8f.0
        for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 10:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285842; x=1774890642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgSRRWjYpcT9SP6nnEifjHM4Oz7EppnrFyKqEruLcwQ=;
        b=Be1rnogafNGwizdHL4gz2TSns0lA+24fvpcKYj3PAvVDap4rQ4220DlVYmZiG0ItFP
         jbctH0iKeGfCcMPfmigZUHmt/zpsuX3LfzQdnguz7ndLz5EXNbE2J5j3vX0XUpSyWLw+
         jz7kR4H7yBuaL8glpCn8xKjjWem++ss6I4XYytHRj7tZ6868ItDH3fsRCVu4sYUTI8et
         6jWWzaP7ZZUpsvWvGEamqv0+0LtVbKAChwgwJbwF0kpjqG0R9J4cCf8BeEWKedufMDVW
         V2YFoNqEIwi48NDFjw9JawP1U6twRvyeiYsnxzFaQIUU/6TvF0TxRQYc+os2bz6fQZVP
         MWEg==
X-Forwarded-Encrypted: i=1; AJvYcCVSmtdOKywJXkbQtyuze7PJ/SwpylYeX7OMJ2aIfEhA+xpaCe4PEKvHiejmDrnxWO6xZmwgD2DIgAe15MNW+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVsJ20X32aI8M4Eq1HR6Y/6ncqsUEDuChZHFUJ0wNfqr/1wsyP
	KkzEN7fKdszGLaO7Z8bKvpPeTrJD06+I6YU7tJFn5upH/XCpUPEfdvwl9NnIrarHKl8LicCns4M
	cgfOMavfjGvndXxZLZiVwmNoEwLaDXYnC4eEPsOp7H2n4w48twQK20UaX4MbSH5kevIni
X-Gm-Gg: ATEYQzzGOj0nrw+jm73AzU/n8Mh6S3PKh6ba/fY4xfPmfVut1cqiwstUzLonmgIPn5u
	+llQ2Mc9vIeV9NE6V/NtMsdQAboXANbWYzACeV7STtTXinOuhy0IPKwiZnz2dWSztNwoZvzJHT5
	qV+mzhH0OwZNMyeftkJ82mkj5lyTIIFCFBIcUSDmzd591DDtWtw2hvzSulFPNpaD7KV+g1IshrO
	QCsZR2xjijw46U3mJX6JSmxPiB1U1eeNgl5k2pJoBAIPAO8naYIPwItv5qVBU2Cvsftht6tJrbi
	6A2+baDuPWj5Am6dFOOhGrnUuiZM0hNcAisp0E5iEE7NCaoGMGEoEekAuCoPwu4aJKYdkg2wFoL
	xkM6CoaaHLvTKPE5a
X-Received: by 2002:a05:6000:4203:b0:43b:60f7:2284 with SMTP id ffacd0b85a97d-43b6424e660mr20920981f8f.14.1774285841807;
        Mon, 23 Mar 2026 10:10:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4203:b0:43b:60f7:2284 with SMTP id ffacd0b85a97d-43b6424e660mr20920915f8f.14.1774285841294;
        Mon, 23 Mar 2026 10:10:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b646b0d3dsm29266639f8f.16.2026.03.23.10.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 10:10:40 -0700 (PDT)
Date: Mon, 23 Mar 2026 13:10:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>
Cc: vishs@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	dw@davidwei.uk, edumazet@google.com, eperezma@redhat.com,
	ilias.apalodimas@linaro.org, jasowang@redhat.com,
	kernel-team@meta.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, technoboy85@gmail.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260323131033-mutt-send-email-mst@kernel.org>
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260323150136.14452-1-oelghoul@linux.ibm.com>
 <20260323114313-mutt-send-email-mst@kernel.org>
 <8e0a5562-4511-41df-9993-a77e51025e95@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8e0a5562-4511-41df-9993-a77e51025e95@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _u6TUEWtSM4LXOqU7MOVX0H5vbftOEP8LgNua8Y2KjM_1774285842
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2026 at 12:54:03PM -0400, Omar Elghoul wrote:
> On 3/23/26 11:52 AM, Michael S. Tsirkin wrote:
> > On Mon, Mar 23, 2026 at 11:01:31AM -0400, Omar Elghoul wrote:
> > > [...]
> > Well... I am not sure how I missed it. Obvious in hindsight:
> > 
> > static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> >                          void *buf, unsigned int len, void **ctx,
> >                          unsigned int *xdp_xmit,
> >                          struct virtnet_rq_stats *stats)
> > {
> >          struct net_device *dev = vi->dev;
> >          struct sk_buff *skb;
> >          u8 flags;
> >          if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> >                  pr_debug("%s: short packet %i\n", dev->name, len);
> >                  DEV_STATS_INC(dev, rx_length_errors);
> >                  virtnet_rq_free_buf(vi, rq, buf);
> >                  return;
> >          }
> >          /* About the flags below:
> >           * 1. Save the flags early, as the XDP program might overwrite them.
> >           * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
> >           * stay valid after XDP processing.
> >           * 2. XDP doesn't work with partially checksummed packets (refer to
> >           * virtnet_xdp_set()), so packets marked as
> >           * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
> >           */
> >          if (vi->mergeable_rx_bufs) {
> >                  flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> >                  skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
> >                                          stats);
> >          } else if (vi->big_packets) {
> >                  void *p = page_address((struct page *)buf);
> >                  flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
> >                  skb = receive_big(dev, vi, rq, buf, len, stats);
> >          } else {
> >                  flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> >                  skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
> >          }
> > 
> > 
> > So we are reading the header, before dma sync, which is within
> > receive_mergeable and friends:
> Thank you for your analysis and explanation.
> > 
> > static struct sk_buff *receive_mergeable(struct net_device *dev,
> >                                           struct virtnet_info *vi,
> >                                           struct receive_queue *rq,
> >                                           void *buf,
> >                                           void *ctx,
> >                                           unsigned int len,
> >                                           unsigned int *xdp_xmit,
> >                                           struct virtnet_rq_stats *stats)
> > {
> >          struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
> >          int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> >          struct page *page = virt_to_head_page(buf);
> >          int offset = buf - page_address(page);
> >          struct sk_buff *head_skb, *curr_skb;
> >          unsigned int truesize = mergeable_ctx_to_truesize(ctx);
> >          unsigned int headroom = mergeable_ctx_to_headroom(ctx);
> >          head_skb = NULL;
> >          if (rq->use_page_pool_dma)
> >                  page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> > 
> > 
> > Just as a test, the below should fix it (compiled only), but the real
> > fix is more complex since we need to be careful to avoid expensive syncing
> > twice.
> 
> I applied your patch and tested it on my system. With this change, I could
> not reproduce the same error anymore. I would be happy to test a proper fix
> once you have one.
> 
> > 
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 97035b49bae7..57b4f5954bed 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -931,9 +931,19 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> >   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
> >   {
> > +	void *buf;
> > +
> >   	BUG_ON(!rq->page_pool);
> > -	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > +	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > +	if (buf && rq->use_page_pool_dma && *len) {
> > +		struct page *page = virt_to_head_page(buf);
> > +		int offset = buf - page_address(page);
> > +
> > +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, *len);
> > +	}
> > +
> > +	return buf;
> >   }
> >   static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> > 
> > 
> > 
> > 

just sent

