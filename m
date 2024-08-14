Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9EC13B582
	for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618774; cv=none; b=Jzj3WKiaoQua/xGcMxBtdNLHRkWWsNmirqca+FJIJKZXiyXpCkYS37l+109QnNhMe0fX84BrpKcrcRTuH9BwDTZjHHxH7qLICO+FSf1sS1GXOdEz/ahIG/l8Eul0tuMP93YEaEn08WcQ0/Tq7n/NfrIwy3+2FkDThBUbuUNY+NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618774; c=relaxed/simple;
	bh=djZGqgZTV4zePC5A4Vl+DC/Cw0xDKzbloMYfCKksJLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZLp89gEWZw919vqp1hwQLxjYjScHCUCwXuvtMUnvAzJyR+HisJ/99yHB9q+l6KpddVp917WoN4UevAOBFVUs3b1nmrBFMf5FF3c+Qvs/jnGwwMmhIOjH8L4xd3FXmkEOA0SxyHrSXJGbS9z6MaLyoOupfCP0V0jeuyhZKP5ljEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYGx+66Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYGx+66Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723618770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvHU9FJR5EjTPSL/EsPZcCx8aKRfG52mA0zYfURxj2Y=;
	b=fYGx+66YuRGcoUlO/MMfd8U68ytW9hpD7i2t9ZFDStqwHPJnaKQ5ekd3x5/x5dO27sCcQr
	8CvUKjneybAh0hdRV0/R8yg5SYvoFLJI8me2VW5PmlL9QmGNOc12AW9IYSQ3ATTbBf1Dbn
	0T48XLBWR9os4DGBFMM8/rfqVHg+lPg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-_Ot9swXWObCCP0AVmPiXaQ-1; Wed, 14 Aug 2024 02:59:28 -0400
X-MC-Unique: _Ot9swXWObCCP0AVmPiXaQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7aa56d8b14so449502266b.1
        for <virtualization@lists.linux.dev>; Tue, 13 Aug 2024 23:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723618767; x=1724223567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvHU9FJR5EjTPSL/EsPZcCx8aKRfG52mA0zYfURxj2Y=;
        b=f2HNutYV64TuPGQG2iqPPbQ0CDGiPOG6MLnt9wfFD4YKX2UgqSPtko81ypSvxsl5Vq
         H5ksnmrTNMoA+WqA+med+Lzc9wNKWQUyDE64IybC0DU4PHJ7qqiyWM1e9hi0l2BqSmgk
         ghf0resxuMp8sRnhwI/BT53zEzm04bjmhN5ARO8gzEy51JBGZEPvJs+2aKD+QspBFnn0
         5W4ielunRLN8MIcn3TOw6AsdBkdDPD6x5BmSRO39y2lWd1+pnGSAxSTUP6+gLZ+oaT0r
         ePdgegOz2650HXTYxI68PUvzlO8bxGbuE5FBI9LUfw4r6QCygv2V5NJUrU8RqdsN7CT9
         izOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO5ZfZyQICVwPY6K81P07VdmFkEVkuDItc3Dha1rnuKgFYZ5S0peBozrtwNnYCC9OYhCaJwe4aLb8Ccgz7tGKelKtsk6XvnJ3tra3tdGE=
X-Gm-Message-State: AOJu0YxyEI5WXbQI4/i1eznAFeFDWoVF6IX3zzvpRIx8Ns+ioUydDfvD
	c5+QMRHm/uqqVF7V+ftsrwK/pzQjRHkIlu05QwTAx8fHfVh3AHYSYIs5IjL+hEyjNI6AldHeRGo
	/YRvrCvj5HEq3OcS9ShYy9INejx+KuFLVjYHXWu2Ekx93tBAlpl/Gdmof4NFDkW+c
X-Received: by 2002:a17:907:e285:b0:a7a:a06b:eebe with SMTP id a640c23a62f3a-a8366c1ef88mr132792766b.9.1723618767146;
        Tue, 13 Aug 2024 23:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAu6E40NEOy1d58SSc2IGoJh1Kf2oD9rknMOVITdXpoO3UrJkKz474CZvMIRoSkCHdannKPg==
X-Received: by 2002:a17:907:e285:b0:a7a:a06b:eebe with SMTP id a640c23a62f3a-a8366c1ef88mr132790066b.9.1723618766262;
        Tue, 13 Aug 2024 23:59:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:dcde:9c09:aa95:551d:d374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414e18csm137789066b.177.2024.08.13.23.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:59:25 -0700 (PDT)
Date: Wed, 14 Aug 2024 02:59:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC 1/3] Revert "virtio_net: rx remove premapped failover
 code"
Message-ID: <7774ac707743ad8ce3afeacbd4bee63ac96dd927.1723617902.git.mst@redhat.com>
References: <cover.1723617902.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1723617902.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This reverts commit defd28aa5acb0fd7c15adc6bc40a8ac277d04dea.

leads to crashes with no ACCESS_PLATFORM when
sysctl net.core.high_order_alloc_disable=1

Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
Message-ID: <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 89 +++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 37 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fd3d7e926022..4f7e686b8bf9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -348,6 +348,9 @@ struct receive_queue {
 
 	/* Record the last dma info to free after new pages is allocated. */
 	struct virtnet_rq_dma *last_dma;
+
+	/* Do dma by self */
+	bool do_dma;
 };
 
 /* This structure can contain rss message with maximum settings for indirection table and keysize
@@ -848,7 +851,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	void *buf;
 
 	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf)
+	if (buf && rq->do_dma)
 		virtnet_rq_unmap(rq, buf, *len);
 
 	return buf;
@@ -861,6 +864,11 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 	u32 offset;
 	void *head;
 
+	if (!rq->do_dma) {
+		sg_init_one(rq->sg, buf, len);
+		return;
+	}
+
 	head = page_address(rq->alloc_frag.page);
 
 	offset = buf - head;
@@ -886,42 +894,44 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 
 	head = page_address(alloc_frag->page);
 
-	dma = head;
+	if (rq->do_dma) {
+		dma = head;
 
-	/* new pages */
-	if (!alloc_frag->offset) {
-		if (rq->last_dma) {
-			/* Now, the new page is allocated, the last dma
-			 * will not be used. So the dma can be unmapped
-			 * if the ref is 0.
+		/* new pages */
+		if (!alloc_frag->offset) {
+			if (rq->last_dma) {
+				/* Now, the new page is allocated, the last dma
+				 * will not be used. So the dma can be unmapped
+				 * if the ref is 0.
+				 */
+				virtnet_rq_unmap(rq, rq->last_dma, 0);
+				rq->last_dma = NULL;
+			}
+
+			dma->len = alloc_frag->size - sizeof(*dma);
+
+			addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
+							      dma->len, DMA_FROM_DEVICE, 0);
+			if (virtqueue_dma_mapping_error(rq->vq, addr))
+				return NULL;
+
+			dma->addr = addr;
+			dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
+
+			/* Add a reference to dma to prevent the entire dma from
+			 * being released during error handling. This reference
+			 * will be freed after the pages are no longer used.
 			 */
-			virtnet_rq_unmap(rq, rq->last_dma, 0);
-			rq->last_dma = NULL;
+			get_page(alloc_frag->page);
+			dma->ref = 1;
+			alloc_frag->offset = sizeof(*dma);
+
+			rq->last_dma = dma;
 		}
 
-		dma->len = alloc_frag->size - sizeof(*dma);
-
-		addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
-						      dma->len, DMA_FROM_DEVICE, 0);
-		if (virtqueue_dma_mapping_error(rq->vq, addr))
-			return NULL;
-
-		dma->addr = addr;
-		dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
-
-		/* Add a reference to dma to prevent the entire dma from
-		 * being released during error handling. This reference
-		 * will be freed after the pages are no longer used.
-		 */
-		get_page(alloc_frag->page);
-		dma->ref = 1;
-		alloc_frag->offset = sizeof(*dma);
-
-		rq->last_dma = dma;
+		++dma->ref;
 	}
 
-	++dma->ref;
-
 	buf = head + alloc_frag->offset;
 
 	get_page(alloc_frag->page);
@@ -938,9 +948,12 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 	if (!vi->mergeable_rx_bufs && vi->big_packets)
 		return;
 
-	for (i = 0; i < vi->max_queue_pairs; i++)
-		/* error should never happen */
-		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
+			continue;
+
+		vi->rq[i].do_dma = true;
+	}
 }
 
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
@@ -2036,7 +2049,8 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		virtnet_rq_unmap(rq, buf, 0);
+		if (rq->do_dma)
+			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -2150,7 +2164,8 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	ctx = mergeable_len_to_ctx(len + room, headroom);
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-		virtnet_rq_unmap(rq, buf, 0);
+		if (rq->do_dma)
+			virtnet_rq_unmap(rq, buf, 0);
 		put_page(virt_to_head_page(buf));
 	}
 
@@ -5231,7 +5246,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 	int i;
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		if (vi->rq[i].alloc_frag.page) {
-			if (vi->rq[i].last_dma)
+			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
 				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
 			put_page(vi->rq[i].alloc_frag.page);
 		}
-- 
MST

