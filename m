Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB38C2D9EFB
	for <virtualization@lists.linux.dev>; Sat, 11 Jul 2026 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782481; cv=none; b=MQfRUpT0s+sxCFXJcgmPUZyQ1JvPvMiZ8xJKyqP+RcthmyFWsm0GhiFbMBU7o2yXe9twxuGMAsSfAOvh8ppUo3HyzeWxyPRmEdVqTupkkpGmbVHL5dmo64bBWvnjJyby2wQaE09cyHsS1A1y3jdxLUpwr6H8zvfJMcNogUEVNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782481; c=relaxed/simple;
	bh=iVN6Oa7DczuGg2N9AQ8E0U8qy+G8dhvBhCAjVmI+XN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfJBxJnf1VwWI7bxddiSsg1OOgLtLG3rdfXDZ3mJMgt8vUwh/V+3gp/ZNXNTeGtmKQQn6f0uoH1RBlQiTzbJjH+XzK3L4oYa+2F2HcQ7U7xOrKoP+dgegQ6p6Rqw5rsUQPvlaiTDbxUowHTBrWoVBLVoy3RdKv9kBK2XMpVck4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiiAydf5; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiiAydf5"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8eefd0c5f59so13426226d6.3
        for <virtualization@lists.linux.dev>; Sat, 11 Jul 2026 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782479; x=1784387279; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=14qOd7NMSc5W1H4WG9ru/PizsjwiaHIwQhYh9VLIk/c=;
        b=aiiAydf5v2wbiW4bD6qsFoH/gmADBfK9a6PXiEwI5eixKCKeBZL8Ym/yx2jHQlwnKN
         Gt3VgNku/rX0vaKbc2K6ZFwqVjo4qeLuos/cvxzuSSwVAnvvl2R3kaigZKWQLqPRZ2sv
         FwjJE7rkMX/1vtPlOv5Z3Gv2wijbGLwXURrj8CTzZ/MyTzZ7UHkm9+yPDN3tINxB0N65
         FV7X7CjXfyrO0LGp+VvCF+KP2GJRmJhROwMW578DnrOfORzgdDMFVFTNNqqbpUO3xU4K
         QrU2//jTqEKt5aQdEg9qfNvKELXt4qhAV+r4mJ16N3Bc2HIgml5wvFx5iWjd9eg5kNdU
         JihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782479; x=1784387279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=14qOd7NMSc5W1H4WG9ru/PizsjwiaHIwQhYh9VLIk/c=;
        b=ZWB9e321C9cwaqVUfsRDIh3po8DkYDImsHt1OvbrTlv2Q7/XOvgZeeiBRao20Nsx8f
         Jsxw+92zsluO10kAqpKFHppAKsTg7nXofsL637r1ctHvjbnmX4PdMigrPF/hy9rWgLFh
         XgDLeU1gXSiNXmquFFtlktoGDma37Sc3rBYsCLgkxmpePfEylvOLwH2+3Q5Z3ajy7+sD
         CmbjgBX+vtuPKl8qLBHZqCmsQkVU7faZWV4BlZjlAl1LV7hRTMZdVXLwnE17STkl8ccL
         aMOwq5PEBuaJ59JKmpMIN6kwDWA3wb8UvuZaqCG1E2PpSXG78eUY0k2BRP1KGydis9i0
         G1/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqsVPRoWRoBmNBZj/+oHMMjIGprFg5S+0bgwM7WMQXPnIihUNmck0kIwyKsWrd29AMMuKxOCy8AmNsHvsI2Og==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+PQfFoWJNyJGHJ4en8eVuzpf8hTjJ+oS9sEvYCW0/Vn9ikU3C
	x91miboJlur0CVTgwZS2ABrxDVnz2EoDK+HAZzJ3BAHPpS0fnWFcTPjZ
X-Gm-Gg: AfdE7ck6+32TRAfXfzGpn3T0PUqXAXDnHraQv4s6taD5i27tsmNhJzooS1Thvhi4+uo
	CzujxhJasftHkYaMB0G6bXHZttecRSPiry7FwjRytjYWdWMFnsfksYORRfhmqPgrCkhXtDfpa3s
	dF+wL7yY7wxEoFLNd77PMYHJUbkmFADb5UaQYU/TEWWI+LlptYKJcDLDGADdXA1D+HyczWD07MK
	kKI1CRm0XPZtcfIcZwrYNs9pdqugmaYQynkl16qGnHkD6nga19F/yzh99lWfTZYYvdwxpeutWEM
	G6vF6O4njwSBm2gb+TXmXRNR1m6f85Vh1gznqki8vSWzC8axpxwSihfaU37S8KWwmv2T82iDEk9
	3aByM38wZFF48D/lzue8D3ur0CRDRXmgciwGmLgC7lSRWMnFQPTqzowyX4ggmgmWgWBC9+IY7cM
	Ip/YgTsmB2RSebWT8xxuI8GKnNv91Tw+BsZl9pJWsTaQWy9QeW35iRFH+46YqAygeWW/zzEjwip
	o+srLq4Og==
X-Received: by 2002:a05:622a:14ca:b0:51a:8c9b:649c with SMTP id d75a77b69052e-51cbf38da9fmr29698741cf.64.1783782478863;
        Sat, 11 Jul 2026 08:07:58 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd57baf8dsm69025296d6.20.2026.07.11.08.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:07:58 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] virtio_net: validate device stats reply records before use
Date: Sat, 11 Jul 2026 11:07:54 -0400
Message-ID: <20260711150754.2918392-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

__virtnet_get_hw_stats() walks the device statistics reply buffer with
"for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size))",
using each record's device-supplied hdr->size as the stride without
checking that a full struct virtio_net_stats_reply_hdr remains, that
hdr->size is nonzero and matches the expected size for hdr->type, or that
the record fits within res_size. A backend that returns hdr->size == 0
spins the loop forever; a short or oversized size drives out-of-bounds
reads in virtnet_fill_stats().

Impact: a malicious or compromised virtio-net backend hangs the CPU
running the guest's device-statistics query in an infinite loop
(hdr->size == 0), or drives an out-of-bounds read of the reply buffer.
This matters most for a confidential guest, where the host is outside the
trust boundary.

Validate each record before use: require a full header in the remaining
bytes, a nonzero hdr->size that is at least the header size and matches the
size expected for hdr->type, and that the record fits within res_size; stop
the walk otherwise. Add virtnet_stats_reply_size() for the per-type size.

Fixes: 941168f8b40e ("virtio_net: support device stats")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/net/virtio_net.c | 42 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2a5876c6c8c..9cbe40d218cc4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3532,6 +3532,7 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 	return err;
 }
 
+
 /*
  * Send command via the control virtqueue and check status.  Commands
  * supported by the hypervisor, as indicated by feature bits, should
@@ -3546,6 +3547,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 	bool ok;
 	int ret;
 
+
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
 
@@ -4927,6 +4929,32 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 	}
 }
 
+static int virtnet_stats_reply_size(u8 type)
+{
+	switch (type) {
+	case VIRTIO_NET_STATS_TYPE_REPLY_CVQ:
+		return sizeof(struct virtio_net_stats_cvq);
+	case VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC:
+		return sizeof(struct virtio_net_stats_rx_basic);
+	case VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM:
+		return sizeof(struct virtio_net_stats_rx_csum);
+	case VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO:
+		return sizeof(struct virtio_net_stats_rx_gso);
+	case VIRTIO_NET_STATS_TYPE_REPLY_RX_SPEED:
+		return sizeof(struct virtio_net_stats_rx_speed);
+	case VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC:
+		return sizeof(struct virtio_net_stats_tx_basic);
+	case VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM:
+		return sizeof(struct virtio_net_stats_tx_csum);
+	case VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO:
+		return sizeof(struct virtio_net_stats_tx_gso);
+	case VIRTIO_NET_STATS_TYPE_REPLY_TX_SPEED:
+		return sizeof(struct virtio_net_stats_tx_speed);
+	default:
+		return sizeof(struct virtio_net_stats_reply_hdr);
+	}
+}
+
 static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 				  struct virtnet_stats_ctx *ctx,
 				  struct virtio_net_ctrl_queue_stats *req,
@@ -4936,7 +4964,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 	struct scatterlist sgs_in, sgs_out;
 	void *p;
 	u32 qid;
-	int ok;
+	int hdr_size, ok, remaining;
 
 	sg_init_one(&sgs_out, req, req_size);
 	sg_init_one(&sgs_in, reply, res_size);
@@ -4948,8 +4976,17 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 	if (!ok)
 		return ok;
 
-	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
+	for (p = reply; p - reply < res_size; p += hdr_size) {
+		remaining = res_size - (p - reply);
+		if (remaining < sizeof(*hdr))
+			return -EINVAL;
+
 		hdr = p;
+		hdr_size = le16_to_cpu(hdr->size);
+		if (hdr_size < virtnet_stats_reply_size(hdr->type) ||
+		    hdr_size > remaining)
+			return -EINVAL;
+
 		qid = le16_to_cpu(hdr->vq_index);
 		virtnet_fill_stats(vi, qid, ctx, p, false, hdr->type);
 	}
@@ -7305,3 +7342,4 @@ module_exit(virtio_net_driver_exit);
 MODULE_DEVICE_TABLE(virtio, id_table);
 MODULE_DESCRIPTION("Virtio network driver");
 MODULE_LICENSE("GPL");
+
-- 
2.53.0

