Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9C327E049
	for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281161; cv=none; b=YPtNj9bOinsk8754pbOzFuZW4fqTOj/hC6bmKyKQPwwuKZQy5e1zLshCnE3/BXOyRZEHJ6YgZBmvOBtdwvD36TUacGk6XJ3r4by/YcvtpacBWA+KR/AnfagF6d+piGHVkOyr/O7rDMIkYWPyLVLQ1Xh2LiV9DpuQp0K858tH4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281161; c=relaxed/simple;
	bh=Wwsnsa8I13/EF4kOLN75rRcu9F+2YoHsOAAnaEjJ+F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ifBp3uWii/WR3m01ekLaM6Dmm7j5p7hihcE1mNHaTXkRMlBVRzOx/UAgMPWFVx3WfUDlb+iMnCWwjU0oAxyWbIyZJWsC3iVcdUctjOfGhhLQfonS6WRu60JwW65DQ4eBGMpZJofWDmD5kw0OyZicJX+a2NjydjXY1yFo1AHZjaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHYA9YIn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHYA9YIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774281157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SRzimLRML1I9K6FsP40IwKIHIhW+1XMgF4uRnLLyEos=;
	b=JHYA9YInZy0Gloxg6hyVkq8eUFMN++l8cdC5nOJhxjzsEayzZB6RvtMdI3iBPR7JwqA0vJ
	4m5MloB/h8iZfkyftg6IttDbs7yldAigUTgsC2505vf/nLn4gPZAlRuqNDi2OH+xiDGbJq
	oyPfl0euM1Ejj7byzlsmEvtL/WljvSA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Ae_jmrIIOG6Ej6qnTavldg-1; Mon, 23 Mar 2026 11:52:36 -0400
X-MC-Unique: Ae_jmrIIOG6Ej6qnTavldg-1
X-Mimecast-MFC-AGG-ID: Ae_jmrIIOG6Ej6qnTavldg_1774281155
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so24512175e9.3
        for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 08:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281155; x=1774885955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRzimLRML1I9K6FsP40IwKIHIhW+1XMgF4uRnLLyEos=;
        b=J9Ni3Aw40mv6tLJ2fZVE/cJP9qo85XUypIe8Xs7BYgn4WYzydVOIr2NzKvMMeCtMs/
         6GHCU+8rRyOWzNel1jNVlnWVqHlm2K/HdXG5oiH1Mch3qO/aGrD2xu01QBPAoD0Bdr+k
         iSMbCQWhYzHUD+WBvy5ASnTTYD8O0o25dvs0z88KlTWujKZgz6+QP+w9ntvGHhzYLFKR
         4ObvQVb9kfDCoLhwDAHbLTykA/3sCX/wPNf3VFZnX8izcIWMfFU4rn/B3ypaRfnCmnIe
         gffZKt84jPy2ruODzdh+wCVqDrONh5V6GBtSYZNZdMjv/kTTSSoBHpuwNPQ5jObWvIWm
         XnjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzDwR8zV1cmPOIaFCBZOBxKpCJ5WPlbMCQyG+mmV+0HYKeehtCm62f1GirM6WZhOf8TStNGzAe/C1suz23Pw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzP+7cjROy+9ekGTrWgMAZs2VkO9/YHJM99TVLy54+iJvW7kF+7
	c4isJo44P4e6kZbNmFRZx9CFa6N/hFo+UUrv267CIXlsX9Qjz+FNEnbO3Z1SvQAD+EDALzpg9bw
	DLmVwFVgAL2VFHQu7DEWQ5NnKIHXS0ZAvohgQ81ZmacIhYACUN4/iA0CUN0nfD45y4Jox
X-Gm-Gg: ATEYQzx/wsr4J6ZPDquenkzmxdwnmtiaOc3djMXT8LqmAHmGRZB+EzM5R00W7nBCws4
	yiaDkP7HMu4EuvSooG4Lpm4/x97iiqCFYsRPeN4rwai2f8/VRTOq04Z4PmuPGnygJrbte/T06UJ
	PRlpBlfWNe9K79Aa14LvtnX8hlAqpOSUTQN/Eb9vwnMOwLCMDdveKi9ggZdrIX96ArtDIKXnT1o
	tApPexRbnyNZxSd8N5yf70QY5eeSIqIeC/2BHJp4HEZ0QUmbRgA4XrYKEMe5v9lNVM9TPXvWtI5
	76aDSdDz9PqWmOuUeIUytFGHsTOmOwd2wH4fhbuZs51k97wgbl78Wcn4eR525kKHryHANIu9mra
	pIqa1xt9uGDGfyzGX
X-Received: by 2002:a05:600c:4705:b0:485:3a86:6392 with SMTP id 5b1f17b1804b1-486fee0d816mr174481375e9.20.1774281154651;
        Mon, 23 Mar 2026 08:52:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4705:b0:485:3a86:6392 with SMTP id 5b1f17b1804b1-486fee0d816mr174480905e9.20.1774281154074;
        Mon, 23 Mar 2026 08:52:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487017210dcsm238594505e9.10.2026.03.23.08.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:52:33 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:52:30 -0400
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
Message-ID: <20260323114313-mutt-send-email-mst@kernel.org>
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260323150136.14452-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260323150136.14452-1-oelghoul@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZP2xAXaTaPZvb9nm-yj28jEAMvkKCvHxhSgk9NEPj2c_1774281155
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Mar 23, 2026 at 11:01:31AM -0400, Omar Elghoul wrote:
> Hi,
> 
> I've been testing linux-next (tags later than 03/17) and hit new issues in
> virtio-net on s390x. I bisected the issue, and I found this patch to be the
> first buggy commit.
> 
> The issue seems to only be reproducible when running in Secure Execution.
> Tested in a KVM guest, the virtio-net performance appears greatly reduced,
> and the dmesg output shows many instances of the following error messages.
> 
> Partial relevant logs
> =====================
> [   49.332028] macvtap0: bad gso: type: 0, size: 0, flags 1 tunnel 0 tnl csum 0
> [   74.365668] macvtap0: bad gso: type: 2e, size: 27948, flags 0 tunnel 0 tnl csum 0
> [  403.302168] macvtap0: bad csum: flags: 2, gso_type: 23 rx_tnl_csum 0
> [  403.302271] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum 0
> [  403.302279] macvtap0: bad csum: flags: 2, gso_type: e1 rx_tnl_csum 0
> [  403.309492] macvtap0: bad csum: flags: 2, gso_type: 4c rx_tnl_csum 0
> [  403.317029] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum 0
> 
> Steps to reproduce
> ==================
> 1. Boot a Linux guest implementing this patch under QEMU/KVM (*) with SE
>    enabled and a virtio-net-ccw device attached.
> 2. Run dmesg. The error message is usually already present at boot time,
>    but if not, it can be reproduced by creating any network traffic.
> 
> (*) This patch was not tested in a non-KVM hypervisor environment.
> 
> I've further confirmed that reverting this patch onto its parent commit
> resolves the issue. Please let me know if you'd like me to test a fix or if
> you would need more information.
> 
> Thanks in advance.
> 
> Best,
> Omar

Well... I am not sure how I missed it. Obvious in hindsight:

static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
                        void *buf, unsigned int len, void **ctx,
                        unsigned int *xdp_xmit,
                        struct virtnet_rq_stats *stats)
{
        struct net_device *dev = vi->dev;
        struct sk_buff *skb;
        u8 flags;
                
        if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
                pr_debug("%s: short packet %i\n", dev->name, len);
                DEV_STATS_INC(dev, rx_length_errors);
                virtnet_rq_free_buf(vi, rq, buf);
                return;
        }
        
        /* About the flags below:
         * 1. Save the flags early, as the XDP program might overwrite them.
         * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
         * stay valid after XDP processing.
         * 2. XDP doesn't work with partially checksummed packets (refer to
         * virtnet_xdp_set()), so packets marked as
         * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
         */
                
        if (vi->mergeable_rx_bufs) {
                flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
                skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
                                        stats);
        } else if (vi->big_packets) {
                void *p = page_address((struct page *)buf);
                
                flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
                skb = receive_big(dev, vi, rq, buf, len, stats);
        } else {
                flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
                skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
        }       


So we are reading the header, before dma sync, which is within
receive_mergeable and friends:

static struct sk_buff *receive_mergeable(struct net_device *dev,
                                         struct virtnet_info *vi,
                                         struct receive_queue *rq,
                                         void *buf,
                                         void *ctx,
                                         unsigned int len,
                                         unsigned int *xdp_xmit,
                                         struct virtnet_rq_stats *stats)
{               
        struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
        int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
        struct page *page = virt_to_head_page(buf);
        int offset = buf - page_address(page);
        struct sk_buff *head_skb, *curr_skb;     
        unsigned int truesize = mergeable_ctx_to_truesize(ctx);
        unsigned int headroom = mergeable_ctx_to_headroom(ctx);
                
        head_skb = NULL;
                
        if (rq->use_page_pool_dma)
                page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
                


Just as a test, the below should fix it (compiled only), but the real
fix is more complex since we need to be careful to avoid expensive syncing
twice.


diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 97035b49bae7..57b4f5954bed 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -931,9 +931,19 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
 static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 {
+	void *buf;
+
 	BUG_ON(!rq->page_pool);
 
-	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
+	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
+	if (buf && rq->use_page_pool_dma && *len) {
+		struct page *page = virt_to_head_page(buf);
+		int offset = buf - page_address(page);
+
+		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, *len);
+	}
+
+	return buf;
 }
 
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)




-- 
MST

