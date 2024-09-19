Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601D125DE
	for <virtualization@lists.linux.dev>; Thu, 19 Sep 2024 03:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726717946; cv=none; b=SBwcDBMumvDWK84gF3sVyhgRvFcYeXQN9fJOFM3FoLNtWRoFXpQXTKMOFYHpa7i88WRSEyoqOusMUOgkl4lKwqUKu3AxWQVZ1bDuEjCoyE/PXTE2ZNPMCuylm4dIuI7GSVp2l5TK6qK9PWW1SoG4GICgPkNetP5PFBqyYEBzRe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726717946; c=relaxed/simple;
	bh=pBJ/W7zBpUfR9NB2GMjokItUqXP95jfukF66km3Za5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=It5hbH+IqmDlZnoq4xjTc3zwetwK372kXwgXKf+7ymKK7Q+i9OIbMP0MueLMwHW97XEKLuVZ5xDV295IslzMvU5s8wZFWk9n+h22CnXRtMqOBpjpcx+0AQ4N+f2gjh82t6TrvMLje++HkxoTaX7jcTY/cPTbuG4uVMJLfC1fN1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WbHz6MkC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WbHz6MkC"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718e285544fso270894b3a.1
        for <virtualization@lists.linux.dev>; Wed, 18 Sep 2024 20:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726717944; x=1727322744; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsPYIMNNv1DkZ6gPtEDdkFMUvpsPPh5XX8rDZ9tVrqw=;
        b=WbHz6MkCUDEiwL2Qjsd/lrSR/FptNWB0Vle4VIdqcSY8BhtlskyIrALWYKpZdfIlpV
         0JLO9zd7toI3DxRDKPvFC0DReo0Qktw8YAHSg/alEljET858PFMEtnd5G3Tk9UXtlcNv
         qN/JAAeY6Uf9/uSD98tryC3+YrKYMjXLxYNyn7CHDdEgYxJgKE755u3Eo0OaLBn+CuWu
         wgK9pwp2FYUW+m3V1miRgOGfINA+/x5hR3m+ZdgEckHirxw9XEVTLihAM7KQZZftdqrp
         b4bIkgHxwY1D80/mvL8cJtq1Sxyc1+qRHMLvL9MiwkKPhK+ykpOQ4FIkK31BFmIkjxrG
         ufhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726717944; x=1727322744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsPYIMNNv1DkZ6gPtEDdkFMUvpsPPh5XX8rDZ9tVrqw=;
        b=bwV3U2zSDV8fe8t8u7zd3jSXKuJUu+0J9DB+BFljU4/KjXfBdUJtkV4q/rNewo0WD5
         GMfLpTCUdKmh4h3gkh65reKe0m2gU352rkE0pyN97Ymh+t9wuw6BydTre+QfyctyZ5tG
         rxxWSffEohnfkJN6NCVb1V8LWxLgHO4+FJDVgkS7RJOdAy/MFmIZpLUYorpWEOuDEQaN
         NWWlUx40lO/ufSeMQvSe2HDKsaFLUsBhLWufbfaWg8VxLDufgbb3TgxwZ9Ia4Ot0cdeb
         Md7kACJkQoqGPGhRU/d8zxYFe0rryjaSP5C/4ameVdBjPkF4XkYsiSKfC0joRgtUOXTz
         2Xiw==
X-Gm-Message-State: AOJu0Yw605mt24oSHlNL9ksm/um2WsbSlDmFheCjdvjbhSMptnlHY6I8
	+IUry021wxd1VKrl4gBFNfNwYPZ/BBEhbwuZkBmwHNjLuIIJZJS2mE9JIoy4Cqg=
X-Google-Smtp-Source: AGHT+IEqBFPHlxkk+SH91tCLfNpFsIjMwSxd3QepCi+7QxXZSuHfi8gouMDIv2rsWh1zhf5xVvIJrQ==
X-Received: by 2002:a05:6a00:4fc4:b0:714:1a74:9953 with SMTP id d2e1a72fcca58-71936a6267cmr30996907b3a.16.1726717943745;
        Wed, 18 Sep 2024 20:52:23 -0700 (PDT)
Received: from LRW1FYT73J.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b9ab85sm7661091b3a.173.2024.09.18.20.52.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Sep 2024 20:52:23 -0700 (PDT)
From: Wenbo Li <liwenbo.martin@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenbo Li <liwenbo.martin@bytedance.com>,
	Jiahui Cen <cenjiahui@bytedance.com>,
	Ying Fang <fangying.tommy@bytedance.com>
Subject: [RESEND PATCH v3] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Thu, 19 Sep 2024 11:52:14 +0800
Message-Id: <20240919035214.41805-1-liwenbo.martin@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the virtio-net driver will perform a pre-dma-mapping for
small or mergeable RX buffer. But for small packets, a mismatched address
without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.

That will result in unsynchronized buffers when SWIOTLB is enabled, for
example, when running as a TDX guest.

This patch unifies the address passed to the virtio core into the address
of the virtnet header and fixes the mismatched buffer address.

Changes from v2: unify the buf that passed to the virtio core in small
and merge mode.
Changes from v1: Use ctx to get xdp_headroom.

Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
---
 drivers/net/virtio_net.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6f4781ec2b36..9446666c84aa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1804,9 +1804,15 @@ static struct sk_buff *receive_small(struct net_device *dev,
 				     struct virtnet_rq_stats *stats)
 {
 	unsigned int xdp_headroom = (unsigned long)ctx;
-	struct page *page = virt_to_head_page(buf);
+	struct page *page;
 	struct sk_buff *skb;
 
+	// We passed the address of virtnet header to virtio-core,
+	// so truncate the padding.
+	buf -= VIRTNET_RX_PAD + xdp_headroom;
+
+	page = virt_to_head_page(buf);
+
 	len -= vi->hdr_len;
 	u64_stats_add(&stats->bytes, len);
 
@@ -2422,8 +2428,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	if (unlikely(!buf))
 		return -ENOMEM;
 
-	virtnet_rq_init_one_sg(rq, buf + VIRTNET_RX_PAD + xdp_headroom,
-			       vi->hdr_len + GOOD_PACKET_LEN);
+	buf += VIRTNET_RX_PAD + xdp_headroom;
+
+	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-- 
2.20.1

