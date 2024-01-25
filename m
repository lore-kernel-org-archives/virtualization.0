Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B017D1CAA3
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177972; cv=none; b=So1ZI1/c2bPAQsvLqlX1y/oZbQeSwolNK8MihWazk5PQ9TJvN2YD9NAWO+R1oTPah+2D+ON69PiefZuP9jGz5KmRLv6NvkZQRm3zjXB2/LQN10Hi2N4roaWG8vECHV1tvV2oKDSsnfbTyUmiBPaXymMs/fAtl6r1GPg625XUyu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177972; c=relaxed/simple;
	bh=hE5xFIUQ4PHRjUDMHfJgA1f0UCIs24/GjLNsgi3xbLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iXSWU8UQSzwbxvqcjoQyAJflCKWXwbuR0Ys0uHkvUatTle3c9/Nm+qKVM2HpPHpuCudgs7zB31+7ImAFZYMpfPt90mcH5oKmovZjmrcMuU1a35mq/Rr5c6t7YGATGCyyu0O2p+Sa8dcn6ccRB7Y2C22JXfBTtv4yt8AeRrqTc4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FalbJ3L/; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FalbJ3L/"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 284DF40993
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 10:19:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 284DF40993
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FalbJ3L/
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hsDDFr5ARULB
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 10:19:27 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 272434036E
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 10:19:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 272434036E
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d71e1d7c78so39653585ad.3
        for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 02:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706177965; x=1706782765; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XfoTf/pNUqDMOG+odoDF+tGW4cWN9ShhMkF37xIQK6o=;
        b=FalbJ3L/+uLZZKl5h4eTQrtG2PZ5jdC2vs801xw9A+O3iahFH1IjzMj+TGt3KvlTKf
         Y8jUeGmg8raAevNSJ6ok1rZzdS45j4HxJDuqKJYb+SaWGhZ7ZzwGD3p7xNncy4/5btjT
         3zGaVi126Z7k29gky3FCGpVYsDnKVg1oMalYI+uUNILPQzI5eRC3WpbshA6L3I6I84O7
         IBwMgyPwJvUrkJOUHb79MN+teKan/iPVGO7bcfXQmMhvdtmd1MGNrVJZH8Ck7bXjXZPj
         3K1dZzaGty8oq5zJiuuzY/4CVCNBKXQQyWtf96MJsqwMf2EUHLHL7TiWOw5PN18z/CA2
         pk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706177965; x=1706782765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfoTf/pNUqDMOG+odoDF+tGW4cWN9ShhMkF37xIQK6o=;
        b=j2BDoy8AqYw1CrfCo+tPu72tsEqw1N/9SZaYPUUNdOW2wap91cVEAQZUR4Ah9NaHrO
         3KdDyV65xomLlJ0JokZ5+T1myWtYGOAEI7dvjdD8Mlz1AUgCZKwqVsceKoqSLaatabzy
         1DIqWV3Xf1CeXPfOMOZCBYd42GZe+9QUjACPSLoGGWsi0PWU2tZQIr2om3KT8YbqL6Qf
         l3tdl/N0rl+Ks9Yihm48PDkPLByTRPGFFMvpNS8w5Eo9tp/HI3HVXdwykI6PZDYT6n+X
         6dNYMXL5i9M8egryhzoaTzIkugO8reFOoa+2gnfSzJ42aplK7PSnIqtoSY5tmqpJIsUY
         n/Sg==
X-Gm-Message-State: AOJu0YzoHEZ8oQE3DeWqmHq4GmHKPA3ktaQbE3WOK59tiZGf/pB6EhOg
	xMu34T/8Dzkfk/SCdRZAMwXlrgoHVodQbS2opN9wkBjCD5+LoWzw
X-Google-Smtp-Source: AGHT+IHk0njQQrZP5z7OFk5FXN3BHZ0SZ2HvfxrSC+RKWKm/c3czuPnQFrVhrTZkEEqUW3PaHIvTzw==
X-Received: by 2002:a17:902:e80c:b0:1d5:bc48:c0fa with SMTP id u12-20020a170902e80c00b001d5bc48c0famr763320plg.0.1706177965344;
        Thu, 25 Jan 2024 02:19:25 -0800 (PST)
Received: from localhost.localdomain ([45.58.187.66])
        by smtp.googlemail.com with ESMTPSA id 12-20020a170902c24c00b001d770328a05sm3904913plg.36.2024.01.25.02.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 02:19:24 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH v3] virtio_net: Support RX hash XDP hint
Date: Thu, 25 Jan 2024 18:19:12 +0800
Message-Id: <20240125101912.60346-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RSS hash report is a feature that's part of the virtio specification.
Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
(still a work in progress as per [1]) support this feature. While the
capability to obtain the RSS hash has been enabled in the normal path,
it's currently missing in the XDP path. Therefore, we are introducing
XDP hints through kfuncs to allow XDP programs to access the RSS hash.

1.
https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.com/#r

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7ce4a1011ea..0c845f2223da 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -349,6 +349,12 @@ struct virtio_net_common_hdr {
 	};
 };
 
+struct virtnet_xdp_buff {
+	struct xdp_buff xdp;
+	u32 hash_value;
+	u16 hash_report;
+};
+
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 
 static bool is_xdp_frame(void *ptr)
@@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buff *xdp)
 	}
 }
 
+static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *virtnet_xdp,
+				     struct net_device *dev,
+				     struct virtio_net_hdr_v1_hash *hdr_hash)
+{
+	if (dev->features & NETIF_F_RXHASH) {
+		virtnet_xdp->hash_value = __le32_to_cpu(hdr_hash->hash_value);
+		virtnet_xdp->hash_report = __le16_to_cpu(hdr_hash->hash_report);
+	}
+}
+
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct net_device *dev,
 			       unsigned int *xdp_xmit,
@@ -1199,9 +1215,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	unsigned int headroom = vi->hdr_len + header_offset;
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
 	struct page *page = virt_to_head_page(buf);
+	struct virtnet_xdp_buff virtnet_xdp;
 	struct page *xdp_page;
+	struct xdp_buff *xdp;
 	unsigned int buflen;
-	struct xdp_buff xdp;
 	struct sk_buff *skb;
 	unsigned int metasize = 0;
 	u32 act;
@@ -1233,17 +1250,20 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		page = xdp_page;
 	}
 
-	xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
-	xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
+	xdp = &virtnet_xdp.xdp;
+	xdp_init_buff(xdp, buflen, &rq->xdp_rxq);
+	xdp_prepare_buff(xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
 			 xdp_headroom, len, true);
 
-	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
+	virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
+
+	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
 
 	switch (act) {
 	case XDP_PASS:
 		/* Recalculate length in case bpf program changed it */
-		len = xdp.data_end - xdp.data;
-		metasize = xdp.data - xdp.data_meta;
+		len = xdp->data_end - xdp->data;
+		metasize = xdp->data - xdp->data_meta;
 		break;
 
 	case XDP_TX:
@@ -1254,7 +1274,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		goto err_xdp;
 	}
 
-	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
+	skb = virtnet_build_skb(buf, buflen, xdp->data - buf, len);
 	if (unlikely(!skb))
 		goto err;
 
@@ -1591,10 +1611,11 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
 	struct page *page = virt_to_head_page(buf);
 	int offset = buf - page_address(page);
+	struct virtnet_xdp_buff virtnet_xdp;
 	unsigned int xdp_frags_truesz = 0;
 	struct sk_buff *head_skb;
 	unsigned int frame_sz;
-	struct xdp_buff xdp;
+	struct xdp_buff *xdp;
 	void *data;
 	u32 act;
 	int err;
@@ -1604,16 +1625,19 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	if (unlikely(!data))
 		goto err_xdp;
 
-	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
+	xdp = &virtnet_xdp.xdp;
+	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, xdp, data, len, frame_sz,
 					 &num_buf, &xdp_frags_truesz, stats);
 	if (unlikely(err))
 		goto err_xdp;
 
-	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
+	virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
+
+	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
 
 	switch (act) {
 	case XDP_PASS:
-		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
+		head_skb = build_skb_from_xdp_buff(dev, vi, xdp, xdp_frags_truesz);
 		if (unlikely(!head_skb))
 			break;
 		return head_skb;
@@ -1626,7 +1650,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		break;
 	}
 
-	put_xdp_frags(&xdp);
+	put_xdp_frags(xdp);
 
 err_xdp:
 	put_page(page);
@@ -4579,6 +4603,55 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			       enum xdp_rss_hash_type *rss_type)
+{
+	const struct virtnet_xdp_buff *virtnet_xdp = (void *)_ctx;
+
+	if (!(virtnet_xdp->xdp.rxq->dev->features & NETIF_F_RXHASH))
+		return -ENODATA;
+
+	switch (virtnet_xdp->hash_report) {
+	case VIRTIO_NET_HASH_REPORT_TCPv4:
+		*rss_type = XDP_RSS_TYPE_L4_IPV4_TCP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_UDPv4:
+		*rss_type = XDP_RSS_TYPE_L4_IPV4_UDP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_TCPv6:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_UDPv6:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP;
+		break;
+	case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP_EX;
+		break;
+	case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
+		*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP_EX;
+		break;
+	case VIRTIO_NET_HASH_REPORT_IPv4:
+		*rss_type = XDP_RSS_TYPE_L3_IPV4;
+		break;
+	case VIRTIO_NET_HASH_REPORT_IPv6:
+		*rss_type = XDP_RSS_TYPE_L3_IPV6;
+		break;
+	case VIRTIO_NET_HASH_REPORT_IPv6_EX:
+		*rss_type = XDP_RSS_TYPE_L3_IPV6_EX;
+		break;
+	case VIRTIO_NET_HASH_REPORT_NONE:
+	default:
+		*rss_type = XDP_RSS_TYPE_NONE;
+	}
+
+	*hash = virtnet_xdp->hash_value;
+	return 0;
+}
+
+static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
+	.xmo_rx_hash			= virtnet_xdp_rx_hash,
+};
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int i, err = -ENOMEM;
@@ -4704,6 +4777,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
 
 		dev->hw_features |= NETIF_F_RXHASH;
+		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
 	if (vi->has_rss_hash_report)
-- 
2.40.1

