Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61C84A39
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430223; cv=none; b=HycmmgKb/kSOEbQ7Bxw+BMsKjiOY49PBehS57wuuUrIs78g5leBVjNc+aFJejFn67IhCeoUPsBbhWeOeT1r1Km7NeP1vn/IreFGVWjSU9lbSouiMERmCrSkFqDmlXfvGlNJTLeeq+CH4CYR1uc/xU4I675LFg2vGYt4rlFCH1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430223; c=relaxed/simple;
	bh=014gXkD8ygbNVGMJO+0Zp0ga5DirG6KNtyYbEwIUiCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qk2a5+FjSdEjgg7/qVznNupBkbb7sWyXiRQtMvOHZ9+pYkqMcSNiVvdMsbWQAT1FeoakLKSgvnWLhC+7KCsKC5T6sUF0G6vd3BsASrQzxeN+ENY3ELCZ1hBH5py5uBcpIcX9J3CdktS+SPzc9ehOfPIVgMWmyIG0PDkbZR9QMHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LcUBgSuE; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LcUBgSuE"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4f9e39c55so328057a12.2
        for <virtualization@lists.linux.dev>; Tue, 03 Sep 2024 23:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725430220; x=1726035020; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V36tSWxAHLAIOwnkr8bXXchZBGFhkcs/NfyGu0nHDJw=;
        b=LcUBgSuEYmRIHgLCpNymKHVDJu+XX7Rm0NheZB/8p+XQLSAdXVL1gLWeoRPiFfXzUt
         2442SycIB4NAeHnA0yCQO2EMxayl4dpPbx57/9rRJ2IDz0+/p+6nOEdqjujn15heDZzf
         mdJL/9SUcOrYi8UAICizDEHIMjZWwMeHSdcfllezDxbriZvNY4zkTiizSp/SZEjx10rg
         itgkpPidOEmTVPE/of/NYB5t3B1+ByrzG176rZX8kjKPxBertbTCsnB5n9K+yZEBm5W1
         XcgkXhekFxqfHD3i82AOgfLkT9qCrJrqlJmQlTRayW0EcKjpAOZPpQ9ftLuSK3GxPIwz
         6Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725430220; x=1726035020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V36tSWxAHLAIOwnkr8bXXchZBGFhkcs/NfyGu0nHDJw=;
        b=SU5y/cDf1M1kup13RxUBtLmbIAkc6zmOHxQ5OLaFIl4I2M8i7svGNIIljSyiAgOrGe
         S3PnZnPnnEhsVgvF4nQxTg00lDidEoPT5TTYBJbuImnA9mAXwVzQJ885sgcLmQWkV6D3
         AhKwOxvglFt9s8jqhzZTxnzyz5+SR+IpgWCWBqP3SuuhAYDLLES+m53N0QssVrZVX4VU
         mEiaSMWxKoO0AM16RGN7wIXNlmvp5Q3Y9Xp9R8iXVhxgp9ZUprSj69y0LGPxVcnfIv+5
         81H8+hv3Z8gRNTc6umKFVvAAaOaQzpX9PBV5GiNdikl7GT3yfQ8I8yfoq0Radn/HgUhv
         jwZA==
X-Gm-Message-State: AOJu0YwPCcu79kYxGTbao2cBqb4odzNA8GnuXlG3xVkoxOZPQxId07q0
	lkAso3F3uULgJ6qiTy0HP2xfBtJNQhHdMY7qJZMLyGhCu3EU+mvN9fHDQE3nBrA=
X-Google-Smtp-Source: AGHT+IHMau4o8Ew3FW+eey6qgIUz41XJZGyUqCz0/A7x+A6o0sgpiBWZX5EMygQKk21MSGSMGAcELQ==
X-Received: by 2002:a17:903:18d:b0:206:b5b8:25ef with SMTP id d9443c01a7336-206b5b82940mr13284525ad.15.1725430220327;
        Tue, 03 Sep 2024 23:10:20 -0700 (PDT)
Received: from LRW1FYT73J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae912357sm6989385ad.14.2024.09.03.23.10.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Sep 2024 23:10:19 -0700 (PDT)
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
Subject: [PATCH v2] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Wed,  4 Sep 2024 14:10:09 +0800
Message-Id: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
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

This patch handles small and mergeable packets separately and fixes
the mismatched buffer address.

Changes from v1: Use ctx to get xdp_headroom.

Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
---
 drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c6af18948..cbc3c0ae4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -891,6 +891,23 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	return buf;
 }
 
+static void *virtnet_rq_get_buf_small(struct receive_queue *rq,
+				      u32 *len,
+				      void **ctx,
+				      unsigned int header_offset)
+{
+	void *buf;
+	unsigned int xdp_headroom;
+
+	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
+	if (buf) {
+		xdp_headroom = (unsigned long)*ctx;
+		virtnet_rq_unmap(rq, buf + VIRTNET_RX_PAD + xdp_headroom, *len);
+	}
+
+	return buf;
+}
+
 static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 {
 	struct virtnet_rq_dma *dma;
@@ -2692,13 +2709,23 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
 	int packets = 0;
 	void *buf;
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs) {
+	if (vi->mergeable_rx_bufs) {
 		void *ctx;
 		while (packets < budget &&
 		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
 			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stats);
 			packets++;
 		}
+	} else if (!vi->big_packets) {
+		void *ctx;
+		unsigned int xdp_headroom = virtnet_get_headroom(vi);
+		unsigned int header_offset = VIRTNET_RX_PAD + xdp_headroom;
+
+		while (packets < budget &&
+		       (buf = virtnet_rq_get_buf_small(rq, &len, &ctx, header_offset))) {
+			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stats);
+			packets++;
+		}
 	} else {
 		while (packets < budget &&
 		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
-- 
2.20.1

