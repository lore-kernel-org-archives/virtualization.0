Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830361C8FC6
	for <virtualization@lists.linux.dev>; Fri,  6 Sep 2024 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616349; cv=none; b=OI3TiYm2xegaXLrWLzo/jtu9R9jpxHmyCBgvhX7i2lLuIgq7LSA3EkN01v8n1Abl3CmzlNyziuCj7v6ydl8wBMMW1Z90EvcDBxTT3p8f4LB+P6bjekp1263NvqRvnNCV//oKemMV1+UytiuGIIXyRGD5Bj5sXPvW9zB/h4uvhmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616349; c=relaxed/simple;
	bh=DWPyC70aofNTN8NzN76YlcX1EqMQAr3p3SCqYoehNM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CF2Re3Qet+x4MT4jkNq+X/HFHcVR2RGJB8MvWdUIZmVnGI/VWMT5+9Y82A03KG7VYrS5dV6Qf7yckbsvvXxrk2csgIcxx+xppz3u6SzHWAFlcdtuLUEVBmMO3SKZDwheHIqX51/Q+vxodjh2sun6Med5MK5i3C8biUv7qnmWyJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xr6MepNv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr6MepNv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725616346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qOfH+ccoyBiuGopATmlM0rbjaC0DlQkgKBk3NY2p3mM=;
	b=Xr6MepNvkjivxFskFQC6INh3GCYEeQaRIBOfSuDqM73+ZH+fXWHH70k8ppUBQ/HdFxGON7
	mmOh3MJwiaPXrWmeTZ/mf9xp6UMZMDdQGFwJnWrK6Bx0/9hj2iwbQ7cXykZ9NY10iSN5dn
	IU11SojzcEOB/n5e18ks/V6KnW5C0/U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-i1rqNQkqPpW6WvEvxBH5Hg-1; Fri, 06 Sep 2024 05:52:25 -0400
X-MC-Unique: i1rqNQkqPpW6WvEvxBH5Hg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3787ea79dceso1019965f8f.2
        for <virtualization@lists.linux.dev>; Fri, 06 Sep 2024 02:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616342; x=1726221142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOfH+ccoyBiuGopATmlM0rbjaC0DlQkgKBk3NY2p3mM=;
        b=UMD6HsOASlSGfdD/VFD46WLdy+iCso7Ll79FiEnIrEcDyOVYJsYvF3ueWQNdYKOgD5
         VsovP9D6L9MWCi4KopckM6bZAKSSysQ9Z6/zEg+beNoBYqTRApn4nfbQrZh6oOHl8Vic
         eo2v7fLGsysFQW+bC25k6Fl+Gh2nM/BDiIDGQO2lNNQoPBHaAf9kQccmWwD3SBkl8rvh
         ob2Ge5CfVhsntRMA55dqLA1QQ/iCwLshuDxHDvXLjXIcNtg6kwTWqxSODaDxWCEUXOh/
         yw1B9VdLW8Ux572SHwWSA/Ju9H6EUOpjVC+1FJ3oyH0MqQN6ieQuVaxnGpb3oeGQtsmK
         csBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3h5x8164nTNEqdcr8G5jnyHnjCSrSpk43JwToZIWjXiuX0JAoqNq81G2d30lHlUhkKw9dFvQAmH6jD3sf1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3zlMihHXaCHUDY/hPnI7060grxlaxFGQMFdxNiIzoFSfQy/mg
	Qqc9X7ZcqmateiSrx6jFUu8SBUmkHVvDAVtAFdpD7Wzu+cZ+yqxqWfDT9yFaMTmK/y+7uPbG0c9
	/kFZzv7JwFDknFYgnq3PHDhpNNadCVF2IT1L5WgEjN4SWqIgziV00cScw3tAvvUo6
X-Received: by 2002:adf:fb11:0:b0:371:8845:a3af with SMTP id ffacd0b85a97d-3749b57f2f1mr16703555f8f.39.1725616341754;
        Fri, 06 Sep 2024 02:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTt73JKwPHK16Z3/RYkW5dDFMWDG3+e0lk0yoShyoCu8E1G8MPLSTYcu8GmLc/SunC8mGUWg==
X-Received: by 2002:adf:fb11:0:b0:371:8845:a3af with SMTP id ffacd0b85a97d-3749b57f2f1mr16703518f8f.39.1725616340741;
        Fri, 06 Sep 2024 02:52:20 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c958c471sm13302350f8f.25.2024.09.06.02.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:52:20 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:52:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: [RFC PATCH v2 1/7] Revert "virtio_net: xsk: rx: support recv merge
 mode"
Message-ID: <51e961cfb4f0a4db7fb4a7dc97cc966af05bf895.1725616135.git.mst@redhat.com>
References: <cover.1725616135.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1725616135.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This reverts commit 99c861b44eb1fb9dfe8776854116a6a9064c19bb.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 144 ---------------------------------------
 1 file changed, 144 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c6af18948092..15e202dd6964 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -504,10 +504,6 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct virtnet_rq_stats *stats);
 static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
 				 struct sk_buff *skb, u8 flags);
-static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
-					       struct sk_buff *curr_skb,
-					       struct page *page, void *buf,
-					       int len, int truesize);
 
 static bool is_xdp_frame(void *ptr)
 {
@@ -988,11 +984,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (rq->xsk_pool) {
-		xsk_buff_free((struct xdp_buff *)buf);
-		return;
-	}
-
 	if (!vi->big_packets || vi->mergeable_rx_bufs)
 		virtnet_rq_unmap(rq, buf, 0);
 
@@ -1161,139 +1152,6 @@ static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev, struct
 	}
 }
 
-static void xsk_drop_follow_bufs(struct net_device *dev,
-				 struct receive_queue *rq,
-				 u32 num_buf,
-				 struct virtnet_rq_stats *stats)
-{
-	struct xdp_buff *xdp;
-	u32 len;
-
-	while (num_buf-- > 1) {
-		xdp = virtqueue_get_buf(rq->vq, &len);
-		if (unlikely(!xdp)) {
-			pr_debug("%s: rx error: %d buffers missing\n",
-				 dev->name, num_buf);
-			DEV_STATS_INC(dev, rx_length_errors);
-			break;
-		}
-		u64_stats_add(&stats->bytes, len);
-		xsk_buff_free(xdp);
-	}
-}
-
-static int xsk_append_merge_buffer(struct virtnet_info *vi,
-				   struct receive_queue *rq,
-				   struct sk_buff *head_skb,
-				   u32 num_buf,
-				   struct virtio_net_hdr_mrg_rxbuf *hdr,
-				   struct virtnet_rq_stats *stats)
-{
-	struct sk_buff *curr_skb;
-	struct xdp_buff *xdp;
-	u32 len, truesize;
-	struct page *page;
-	void *buf;
-
-	curr_skb = head_skb;
-
-	while (--num_buf) {
-		buf = virtqueue_get_buf(rq->vq, &len);
-		if (unlikely(!buf)) {
-			pr_debug("%s: rx error: %d buffers out of %d missing\n",
-				 vi->dev->name, num_buf,
-				 virtio16_to_cpu(vi->vdev,
-						 hdr->num_buffers));
-			DEV_STATS_INC(vi->dev, rx_length_errors);
-			return -EINVAL;
-		}
-
-		u64_stats_add(&stats->bytes, len);
-
-		xdp = buf_to_xdp(vi, rq, buf, len);
-		if (!xdp)
-			goto err;
-
-		buf = napi_alloc_frag(len);
-		if (!buf) {
-			xsk_buff_free(xdp);
-			goto err;
-		}
-
-		memcpy(buf, xdp->data - vi->hdr_len, len);
-
-		xsk_buff_free(xdp);
-
-		page = virt_to_page(buf);
-
-		truesize = len;
-
-		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
-						    buf, len, truesize);
-		if (!curr_skb) {
-			put_page(page);
-			goto err;
-		}
-	}
-
-	return 0;
-
-err:
-	xsk_drop_follow_bufs(vi->dev, rq, num_buf, stats);
-	return -EINVAL;
-}
-
-static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct virtnet_info *vi,
-						 struct receive_queue *rq, struct xdp_buff *xdp,
-						 unsigned int *xdp_xmit,
-						 struct virtnet_rq_stats *stats)
-{
-	struct virtio_net_hdr_mrg_rxbuf *hdr;
-	struct bpf_prog *prog;
-	struct sk_buff *skb;
-	u32 ret, num_buf;
-
-	hdr = xdp->data - vi->hdr_len;
-	num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
-
-	ret = XDP_PASS;
-	rcu_read_lock();
-	prog = rcu_dereference(rq->xdp_prog);
-	/* TODO: support multi buffer. */
-	if (prog && num_buf == 1)
-		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
-	rcu_read_unlock();
-
-	switch (ret) {
-	case XDP_PASS:
-		skb = xsk_construct_skb(rq, xdp);
-		if (!skb)
-			goto drop_bufs;
-
-		if (xsk_append_merge_buffer(vi, rq, skb, num_buf, hdr, stats)) {
-			dev_kfree_skb(skb);
-			goto drop;
-		}
-
-		return skb;
-
-	case XDP_TX:
-	case XDP_REDIRECT:
-		return NULL;
-
-	default:
-		/* drop packet */
-		xsk_buff_free(xdp);
-	}
-
-drop_bufs:
-	xsk_drop_follow_bufs(dev, rq, num_buf, stats);
-
-drop:
-	u64_stats_inc(&stats->drops);
-	return NULL;
-}
-
 static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queue *rq,
 				    void *buf, u32 len,
 				    unsigned int *xdp_xmit,
@@ -1323,8 +1181,6 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
 
 	if (!vi->mergeable_rx_bufs)
 		skb = virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_xmit, stats);
-	else
-		skb = virtnet_receive_xsk_merge(dev, vi, rq, xdp, xdp_xmit, stats);
 
 	if (skb)
 		virtnet_receive_done(vi, rq, skb, flags);
-- 
MST

