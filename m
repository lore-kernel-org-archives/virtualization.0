Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236DE3BF684
	for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285115; cv=none; b=QmS7IADuqhHvQhYMPV5VLAiActFfivd5gZvMcMFslMCS1aQ7QN4o/J3eyGUxu7zp+tMOVtTK/8PnNLwqenyQxcljPP7dwHxQuW/5f4QzsZS+23Zrj2rQW0by69ReHgE1cbqLeN0FFIv+7lfs6pOOOq3NHQvUHBL/7Cn7fhUjJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285115; c=relaxed/simple;
	bh=zKfpEDx/bMNnliTMcyZ3QPurRtzaRjVy8bY/EVr1Gq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hy0TJSXDroQp1ifwe0cdFTb72DaFZGpa/aGZDnOF/RCHqP7jrqt65cYvjYKXC4NWsh/3ZNKbD99MuxgPvgtXV032RFrkb70pU6vxIwC9Wm1/ag5EeOogXVoLmusnpHJ08jB8AQCeo81LJqHSshy9wv8I0A1YhVhxNQucv+Kni9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CtDauq96; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtDauq96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774285113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+LDGMV4LQONK/JaWRKk1AqF2/olqUh4X35pgtSYkU4=;
	b=CtDauq96+7u0w1rl51qkgiMZ02lXO9qBdqeN+6EyVyCsOFjmJJyNsJ248wvScchBbGynKC
	zWgbPmDv8UKv5u44M4lpH975LRXMGeQ/Ko5vjr2NwcyyVkp5kpt5hDKWLHpobQfHC2iBDM
	tHv1b0jtCWIse0qKh4FQZHAvrIVVt/Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-C3hUot3yNcuPAH5CB4ySag-1; Mon, 23 Mar 2026 12:58:31 -0400
X-MC-Unique: C3hUot3yNcuPAH5CB4ySag-1
X-Mimecast-MFC-AGG-ID: C3hUot3yNcuPAH5CB4ySag_1774285110
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439cbc5fb4fso443163f8f.0
        for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 09:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285110; x=1774889910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+LDGMV4LQONK/JaWRKk1AqF2/olqUh4X35pgtSYkU4=;
        b=q7ejEygzm822cP4rjhkqzTQBeuu6kgWg/3czdypSmyWbRhHoPIyweFkE4b73h7W3//
         2kJyqpxGEh+XfBU9safMkUAs5h1XqrQGC/5pO2Bu1lHtL6uQWa9d8OtOUXjrFVswyXNH
         r3MRSFTad0TfzcEnU1n9NG1IRgtZksBIB83iVV1CZGybCr+TgnPciWjEEjwUFuFMStOe
         DfCa05ciA7sQHbwc0e7gxleDhPPSeUPgOpIeTtj28xlgSydu56T5Of8vjhV1VuXmMisr
         G5l3pw8tRnylxt49ZierE+YRqnxII5tLgpiGbcWsmVK4Oy3pyMwDG27cRLwjKjWdpNmr
         x4iw==
X-Forwarded-Encrypted: i=1; AJvYcCV3iWXFSgrL81RD3Tm/TytzKgdfqExdt/hFGIFsKawDz+GmXPA4KgKLbJ4INbJs2+lKVnoRkJHnmWnCt7FcGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQpFORFBjwrDxON47VCD8m/lYuHWzzhKrmX3N8ZvNuaAZrgdmA
	vRlCgXRzNsleuaIbI5xMXIbjIS5yB+lxo9YN77Au+Q9N17Bvr2aN10BDLQynJ1UvkrejJ70GDIl
	m/hVe8Yo5fh2eKdjhrzWOchxA0G6UIfS235pqy1drp9vPLoS2dqejHzI3d2z0BksepdIl
X-Gm-Gg: ATEYQzxRHem9vvTTADxIOfhFnsGzMPayQ0oMK4dHteHJFbSqOUCwdpJJSgDrMTm8pPM
	ITLYYDmSjAy8n/fs95OPBbMJ+UnPgn4+TGZMJfOCqLYLDSUIvE9wr+ICGBNWI0fn9wJIjXJ52zO
	3BfOzV+ulArzrKRQl5GT08KNVyW3ULHTCC3HBFrMJzUybgmTJbXvtudxWmz4vhMsLazqOZ1CgB0
	4jg6wauQUaKOA3+kMR+T0+PHw6ihFvcR1YArI2AE/Cd+7cEv9p2F2siMdRo+Iy2KBuHRPvTiq8C
	x9xcvgJ4Uyv0RCST+t4cqhT6yYfb7VHhpS1K409le75o8xwEVxzmZXjGCt23JZqHg+eQqhI5PkT
	MOGaUS3uoCDhc1tYw
X-Received: by 2002:a5d:5f94:0:b0:43b:5744:13fb with SMTP id ffacd0b85a97d-43b6423489dmr20503936f8f.4.1774285109972;
        Mon, 23 Mar 2026 09:58:29 -0700 (PDT)
X-Received: by 2002:a5d:5f94:0:b0:43b:5744:13fb with SMTP id ffacd0b85a97d-43b6423489dmr20503890f8f.4.1774285109379;
        Mon, 23 Mar 2026 09:58:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bf1c5sm33789641f8f.14.2026.03.23.09.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:58:28 -0700 (PDT)
Date: Mon, 23 Mar 2026 12:58:25 -0400
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
Message-ID: <20260323122728-mutt-send-email-mst@kernel.org>
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260323150136.14452-1-oelghoul@linux.ibm.com>
 <20260323114313-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260323114313-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZLdQopCVd7GMa5RvyngRdHDaU1NIw84nVNUQ9eDCPxM_1774285110
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Mar 23, 2026 at 11:52:34AM -0400, Michael S. Tsirkin wrote:
> On Mon, Mar 23, 2026 at 11:01:31AM -0400, Omar Elghoul wrote:
> > Hi,
> > 
> > I've been testing linux-next (tags later than 03/17) and hit new issues in
> > virtio-net on s390x. I bisected the issue, and I found this patch to be the
> > first buggy commit.
> > 
> > The issue seems to only be reproducible when running in Secure Execution.
> > Tested in a KVM guest, the virtio-net performance appears greatly reduced,
> > and the dmesg output shows many instances of the following error messages.
> > 
> > Partial relevant logs
> > =====================
> > [   49.332028] macvtap0: bad gso: type: 0, size: 0, flags 1 tunnel 0 tnl csum 0
> > [   74.365668] macvtap0: bad gso: type: 2e, size: 27948, flags 0 tunnel 0 tnl csum 0
> > [  403.302168] macvtap0: bad csum: flags: 2, gso_type: 23 rx_tnl_csum 0
> > [  403.302271] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum 0
> > [  403.302279] macvtap0: bad csum: flags: 2, gso_type: e1 rx_tnl_csum 0
> > [  403.309492] macvtap0: bad csum: flags: 2, gso_type: 4c rx_tnl_csum 0
> > [  403.317029] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum 0
> > 
> > Steps to reproduce
> > ==================
> > 1. Boot a Linux guest implementing this patch under QEMU/KVM (*) with SE
> >    enabled and a virtio-net-ccw device attached.
> > 2. Run dmesg. The error message is usually already present at boot time,
> >    but if not, it can be reproduced by creating any network traffic.
> > 
> > (*) This patch was not tested in a non-KVM hypervisor environment.
> > 
> > I've further confirmed that reverting this patch onto its parent commit
> > resolves the issue. Please let me know if you'd like me to test a fix or if
> > you would need more information.
> > 
> > Thanks in advance.
> > 
> > Best,
> > Omar
> 
> Well... I am not sure how I missed it. Obvious in hindsight:
> 
> static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>                         void *buf, unsigned int len, void **ctx,
>                         unsigned int *xdp_xmit,
>                         struct virtnet_rq_stats *stats)
> {
>         struct net_device *dev = vi->dev;
>         struct sk_buff *skb;
>         u8 flags;
>                 
>         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>                 pr_debug("%s: short packet %i\n", dev->name, len);
>                 DEV_STATS_INC(dev, rx_length_errors);
>                 virtnet_rq_free_buf(vi, rq, buf);
>                 return;
>         }
>         
>         /* About the flags below:
>          * 1. Save the flags early, as the XDP program might overwrite them.
>          * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
>          * stay valid after XDP processing.
>          * 2. XDP doesn't work with partially checksummed packets (refer to
>          * virtnet_xdp_set()), so packets marked as
>          * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
>          */
>                 
>         if (vi->mergeable_rx_bufs) {
>                 flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>                 skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>                                         stats);
>         } else if (vi->big_packets) {
>                 void *p = page_address((struct page *)buf);
>                 
>                 flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
>                 skb = receive_big(dev, vi, rq, buf, len, stats);
>         } else {
>                 flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>                 skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
>         }       
> 
> 
> So we are reading the header, before dma sync, which is within
> receive_mergeable and friends:
> 
> static struct sk_buff *receive_mergeable(struct net_device *dev,
>                                          struct virtnet_info *vi,
>                                          struct receive_queue *rq,
>                                          void *buf,
>                                          void *ctx,
>                                          unsigned int len,
>                                          unsigned int *xdp_xmit,
>                                          struct virtnet_rq_stats *stats)
> {               
>         struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
>         int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>         struct page *page = virt_to_head_page(buf);
>         int offset = buf - page_address(page);
>         struct sk_buff *head_skb, *curr_skb;     
>         unsigned int truesize = mergeable_ctx_to_truesize(ctx);
>         unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>                 
>         head_skb = NULL;
>                 
>         if (rq->use_page_pool_dma)
>                 page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
>                 
> 
> 
> Just as a test, the below should fix it (compiled only), but the real
> fix is more complex since we need to be careful to avoid expensive syncing
> twice.
> 
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 97035b49bae7..57b4f5954bed 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -931,9 +931,19 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  
>  static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>  {
> +	void *buf;
> +
>  	BUG_ON(!rq->page_pool);
>  
> -	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
> +	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> +	if (buf && rq->use_page_pool_dma && *len) {
> +		struct page *page = virt_to_head_page(buf);
> +		int offset = buf - page_address(page);
> +
> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, *len);
> +	}
> +
> +	return buf;
>  }
>  
>  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> 
> 
> 
> 
> -- 
> MST

or maybe like this:

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 97035b49bae7..835f52651006 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1956,13 +1956,6 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	 */
 	buf -= VIRTNET_RX_PAD + xdp_headroom;
 
-	if (rq->use_page_pool_dma) {
-		int offset = buf - page_address(page) +
-			     VIRTNET_RX_PAD + xdp_headroom;
-
-		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
-	}
-
 	len -= vi->hdr_len;
 	u64_stats_add(&stats->bytes, len);
 
@@ -2398,9 +2391,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 
 	head_skb = NULL;
 
-	if (rq->use_page_pool_dma)
-		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
-
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 
 	if (check_mergeable_len(dev, ctx, len))
@@ -2563,6 +2553,13 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		return;
 	}
 
+	if (rq->use_page_pool_dma) {
+		struct page *page = virt_to_head_page(buf);
+		int offset = buf - page_address(page);
+
+		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
+	}
+
 	/* About the flags below:
 	 * 1. Save the flags early, as the XDP program might overwrite them.
 	 * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID

