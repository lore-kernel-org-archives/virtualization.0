Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE13344056
	for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774309085; cv=none; b=oMq0mTtb8R8KrjUBPe/O5UV1if7lGSA/qJ8HqUnVOQCsbnBHhGngrKTa7cI/4P5+8NFpesfFStkp700yAcSZGO1GVF7I9Tm3M+LGgDp8w30J5xzCCYz8H1YK+kAcc21cqHUt8EQ3u+91cxDhXWKSFTdsLg68OucoG26hsVtkyps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774309085; c=relaxed/simple;
	bh=owEdr220dkK3ppsi6JXpVg05w8GpReJWUif3G0RS6T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eWhYBIW/A+c7RDyFvHO4BKFttijtotpcstU8380yT1/0YVcHEs4BM8zrfdEc1f1z64+IVrv+wnvqLz+hkmamJ6t8jg/cP+YEInWsqnqaCrHuaCJDvy/IMFkhAQLISnyHY487y+13fLDbsHMEcnvJL646ZXR4nwo2e6zOHkjviNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZeFhDgx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZeFhDgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774309082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fo0gWB5wj1kID668MfwKwidT0apXwX5ZGElz9QaiNPw=;
	b=CZeFhDgxY7QbOusjuAzL1Bgseh5/zr77T/YKYTKljLZdQbHBlj6mfHv96Bu5g1FmdAL49o
	AYZ516yNA3B68oVed8sWnQGeyoOcuR8mzjH2kF2nrPLsen7xWeHwo9PqcS9s2NDn21Zaw2
	JmPeqgLLmxHxX6KGfej7GhWmloiE4j0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-tXMYv4kEPWaZxinlyhcbew-1; Mon, 23 Mar 2026 19:38:01 -0400
X-MC-Unique: tXMYv4kEPWaZxinlyhcbew-1
X-Mimecast-MFC-AGG-ID: tXMYv4kEPWaZxinlyhcbew_1774309081
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso35339335e9.1
        for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 16:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774309080; x=1774913880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo0gWB5wj1kID668MfwKwidT0apXwX5ZGElz9QaiNPw=;
        b=fYQC3lTvJsGzMRVpY8j8qv7TN386moIP8F/KYh4suscec/qTFzFCb5EwJ0+9C9sA4p
         XCt88zjqpt7BSbs4QiHHQ5/W4AyfCV8tH97kIJ0cQTqavIJbURSjSOxIyREAb2zCnyxC
         VP0F59PQWaJyg478qhliAzUWKrdDEnRfBxjONOlqhZJ1rAS2P/NvxFhlTETqzQNk30u1
         okqKKrVqu/vT4iATiZRMFGPoiVyv4rk3c254M4oENy2OvmcqpRcIzl9FEmF8Ageix+fC
         J42i35xobTk1l1vpWdfZ47nJltMlInkx8kobQJfEo5Kvk6C3W8ndzqWFBwtroNIcQDa7
         YKNw==
X-Forwarded-Encrypted: i=1; AJvYcCXspqdiHaJ8S4YAQIDcDBB1SHtnIK8I/gsd5yQ5GgA5BV12YGV+m6zZhPr2KBMzFfv3P0CWWoUtX0VjqVSPCw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx64EVRQT/lLdfVhpcEfiXthgNHSG4vZIL2JnMajn12Zei0AWD3
	nh4mv6iWgSuvA0f8rvKXvQl29YKWfTG1tmwwo0jKDKrnWrs5/R2YB/fgJiWb1hTwSwA0qc+097O
	UT5TM+Kz9OLargvVjLLVfx52uH4EjouEvoGEEZBEEaDzmVGs1b0lZ0GkBORSDEdUN1fgQ
X-Gm-Gg: ATEYQzw4VT1Hf3ZfuKhlQa2ohFFurME4OI6LFrxpG7IzYkvmWVWZZMZIZxDt4AfqaPx
	WVeondhssNR4XLE1wtJnwu4uOZjXSDxTNoOzmwlLEkjk0ODuTUNqhL89NxJbwqLTT9eZgkelIEB
	KPkDScQUrzRpgILEcURGnwnLfeCCCcTKTtmZ3Qq7aMDCldO/WXqCccQVd4cK10N9H6pr9J8K85r
	0WwZ6Lgczcpj5YziM4Tb+6SgBEbFuOr9+V6DTMzN+CzJpf/HSJ0y/H7i3sm6FCHPaG71Rd5Djtb
	lFnu7EOvHsrIDUMxSQGdBab9Tv1P7ICJeUyi27HkgB6VymHt2G0dlwI/Rv+IIin2g4sXIFb2y1Q
	bcUGmqflbpWsi9olC
X-Received: by 2002:a05:600c:3483:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-486ff02923emr204364915e9.21.1774309080442;
        Mon, 23 Mar 2026 16:38:00 -0700 (PDT)
X-Received: by 2002:a05:600c:3483:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-486ff02923emr204364575e9.21.1774309079916;
        Mon, 23 Mar 2026 16:37:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f822b83sm8160385e9.4.2026.03.23.16.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 16:37:59 -0700 (PDT)
Date: Mon, 23 Mar 2026 19:37:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Omar Elghoul <oelghoul@linux.ibm.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, dw@davidwei.uk, edumazet@google.com,
	eperezma@redhat.com, ilias.apalodimas@linaro.org,
	jasowang@redhat.com, kernel-team@meta.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, technoboy85@gmail.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260323193722-mutt-send-email-mst@kernel.org>
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260323150136.14452-1-oelghoul@linux.ibm.com>
 <20260323114313-mutt-send-email-mst@kernel.org>
 <20260323122728-mutt-send-email-mst@kernel.org>
 <6b6bea74-4bff-4301-8dbf-a9c162456185@linux.ibm.com>
 <f91a42f7-1e90-4db0-923a-371dac8245e0@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f91a42f7-1e90-4db0-923a-371dac8245e0@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c2M4YwGI_TbsEv-SqA74FEtsO5gpo_kcqhRHY_JBOLA_1774309081
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Mar 23, 2026 at 01:50:29PM -0400, Vishwanath Seshagiri wrote:
> 
> 
> On 3/23/26 10:39 PM, Omar Elghoul wrote:
> > On 3/23/26 12:58 PM, Michael S. Tsirkin wrote:
> > 
> > > On Mon, Mar 23, 2026 at 11:52:34AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Mar 23, 2026 at 11:01:31AM -0400, Omar Elghoul wrote:
> > > > > [...]
> > > > Well... I am not sure how I missed it. Obvious in hindsight:
> > > > 
> > > > static void receive_buf(struct virtnet_info *vi, struct
> > > > receive_queue *rq,
> > > >                          void *buf, unsigned int len, void **ctx,
> > > >                          unsigned int *xdp_xmit,
> > > >                          struct virtnet_rq_stats *stats)
> > > > {
> > > >          struct net_device *dev = vi->dev;
> > > >          struct sk_buff *skb;
> > > >          u8 flags;
> > > >          if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> > > >                  pr_debug("%s: short packet %i\n", dev->name, len);
> > > >                  DEV_STATS_INC(dev, rx_length_errors);
> > > >                  virtnet_rq_free_buf(vi, rq, buf);
> > > >                  return;
> > > >          }
> > > >          /* About the flags below:
> > > >           * 1. Save the flags early, as the XDP program might
> > > > overwrite them.
> > > >           * These flags ensure packets marked as
> > > > VIRTIO_NET_HDR_F_DATA_VALID
> > > >           * stay valid after XDP processing.
> > > >           * 2. XDP doesn't work with partially checksummed
> > > > packets (refer to
> > > >           * virtnet_xdp_set()), so packets marked as
> > > >           * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP
> > > > processing.
> > > >           */
> > > >          if (vi->mergeable_rx_bufs) {
> > > >                  flags = ((struct virtio_net_common_hdr *)buf)-
> > > > >hdr.flags;
> > > >                  skb = receive_mergeable(dev, vi, rq, buf, ctx,
> > > > len, xdp_xmit,
> > > >                                          stats);
> > > >          } else if (vi->big_packets) {
> > > >                  void *p = page_address((struct page *)buf);
> > > >                  flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
> > > >                  skb = receive_big(dev, vi, rq, buf, len, stats);
> > > >          } else {
> > > >                  flags = ((struct virtio_net_common_hdr *)buf)-
> > > > >hdr.flags;
> > > >                  skb = receive_small(dev, vi, rq, buf, ctx, len,
> > > > xdp_xmit, stats);
> > > >          }
> > > > 
> > > > 
> > > > So we are reading the header, before dma sync, which is within
> > > > receive_mergeable and friends:
> > > > 
> > > > static struct sk_buff *receive_mergeable(struct net_device *dev,
> > > >                                           struct virtnet_info *vi,
> > > >                                           struct receive_queue *rq,
> > > >                                           void *buf,
> > > >                                           void *ctx,
> > > >                                           unsigned int len,
> > > >                                           unsigned int *xdp_xmit,
> > > >                                           struct
> > > > virtnet_rq_stats *stats)
> > > > {
> > > >          struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
> > > >          int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> > > >          struct page *page = virt_to_head_page(buf);
> > > >          int offset = buf - page_address(page);
> > > >          struct sk_buff *head_skb, *curr_skb;
> > > >          unsigned int truesize = mergeable_ctx_to_truesize(ctx);
> > > >          unsigned int headroom = mergeable_ctx_to_headroom(ctx);
> > > >          head_skb = NULL;
> > > >          if (rq->use_page_pool_dma)
> > > >                  page_pool_dma_sync_for_cpu(rq->page_pool, page,
> > > > offset, len);
> > > > 
> > > > 
> > > > Just as a test, the below should fix it (compiled only), but the real
> > > > fix is more complex since we need to be careful to avoid
> > > > expensive syncing
> > > > twice.
> > > > 
> > > > 
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 97035b49bae7..57b4f5954bed 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -931,9 +931,19 @@ static struct sk_buff *page_to_skb(struct
> > > > virtnet_info *vi,
> > > >   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32
> > > > *len, void **ctx)
> > > >   {
> > > > +    void *buf;
> > > > +
> > > >       BUG_ON(!rq->page_pool);
> > > > -    return virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > > +    buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > > +    if (buf && rq->use_page_pool_dma && *len) {
> > > > +        struct page *page = virt_to_head_page(buf);
> > > > +        int offset = buf - page_address(page);
> > > > +
> > > > +        page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, *len);
> > > > +    }
> > > > +
> > > > +    return buf;
> > > >   }
> > > >   static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> > > > 
> > > > 
> > > > 
> > > > 
> > > > -- 
> > > > MST
> > > or maybe like this:
> > Both of these patches resolve the issue on my end.
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 97035b49bae7..835f52651006 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1956,13 +1956,6 @@ static struct sk_buff *receive_small(struct
> > > net_device *dev,
> > >        */
> > >       buf -= VIRTNET_RX_PAD + xdp_headroom;
> > > -    if (rq->use_page_pool_dma) {
> > > -        int offset = buf - page_address(page) +
> > > -                 VIRTNET_RX_PAD + xdp_headroom;
> > > -
> > > -        page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> > > -    }
> > > -
> > >       len -= vi->hdr_len;
> > >       u64_stats_add(&stats->bytes, len);
> > > @@ -2398,9 +2391,6 @@ static struct sk_buff
> > > *receive_mergeable(struct net_device *dev,
> > >       head_skb = NULL;
> > > -    if (rq->use_page_pool_dma)
> > > -        page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> > > -
> > >       u64_stats_add(&stats->bytes, len - vi->hdr_len);
> > >       if (check_mergeable_len(dev, ctx, len))
> > > @@ -2563,6 +2553,13 @@ static void receive_buf(struct virtnet_info
> > > *vi, struct receive_queue *rq,
> > >           return;
> > >       }
> > > +    if (rq->use_page_pool_dma) {
> > > +        struct page *page = virt_to_head_page(buf);
> > > +        int offset = buf - page_address(page);
> > > +
> > > +        page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> > > +    }
> > > +
> > >       /* About the flags below:
> > >        * 1. Save the flags early, as the XDP program might overwrite
> > > them.
> > >        * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
> > > 
> 
> Hello Omar. Thank you for the bisect, apologies for breaking the
> functionality. Thank you Michael for the patch, I will be careful next
> time about DMA sync issues. Looks like the bug is fixed, is there
> anything else needed from my end?
> 


Would be great to have you test the patch on your end and report
the performace. Thanks!

-- 
MST

