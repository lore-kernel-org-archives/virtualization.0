Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3914A9E
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jan 2024 03:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706673350; cv=none; b=URzfg0A4MkwqX4hw3tThHcyXnKgrTcCh1K8supHGmJkGrFkh2jr2fozlWcK9X2sMOQJACJqLBsFa9dOUEbPa4kIb7HDNv5c73r73NSu0BiKqAkJEmCx9cz4BqZl6g20OgHdCZVYDHedkDZuZldyIIMcd8F/Pj/JUPJretQNbGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706673350; c=relaxed/simple;
	bh=3eYmQ3dJsBvcxiCOUDPVxQ8QBgs7NpCaIY0MsgBedKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rDYRLgz1P2OB++dmw+JVEFQkYu7O11jPThL4mhEqQn8x1Rr/iM2cFxCx8hBXoV3v5B1EB7LcE84yAArVfafcVcS69iECsWogbr8PCAvC+6jNHoHAf0zHYW4Ky9HCod0MYcz6a+AAc9Ksqt1qUVnQlQS7FBrYk827/+U+LlYBfQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCDZ4g08; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCDZ4g08"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A78DE40182
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jan 2024 03:55:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A78DE40182
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aCDZ4g08
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dX9x1MbfjjQ3
	for <virtualization@lists.linux-foundation.org>;
	Wed, 31 Jan 2024 03:55:47 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5194440151
	for <virtualization@lists.linux-foundation.org>; Wed, 31 Jan 2024 03:55:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5194440151
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6dddc5e34e2so391432b3a.0
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 19:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706673347; x=1707278147; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0RiB2J9TsGrKN0zmH0Y/9LtHAwiNldnnpE0kXLBAF4=;
        b=aCDZ4g085TKm2w1gfV8WlY1EvhLpkUQZ9irS9AelPeWdtXqKZ9Ex1Wlh6UBoJhFG+6
         4gkzat333cR83I9/jyCCwN2EBgaLUc50xqQTnD/+AL3XidkM8ES4Xx+g99lAg8D0qrux
         VcLXOt6gZkJZbMwZ6/9TQvhVZbKCyU7Ppt+6JMc+zU/A4LCh7WMxcHag6s5BRCRd2QLf
         mil51MoLM/diM9v/RRrRJO1JE/3AVCDimZBP/AqLj85ZwjG39HGsIl49085MyNuUOsFA
         vaAZDi2KEprBDOK/mKpLvjCrhMOV1bsWh1Q1AvrbS0Vjx7Y49UFyZVloh0B8gCfd7UB4
         MYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706673347; x=1707278147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0RiB2J9TsGrKN0zmH0Y/9LtHAwiNldnnpE0kXLBAF4=;
        b=eDn6k+QEt6lAPYQrVrhsIKjkoVBjP38egrNNPKVl8D1K2r6L9D/EuKuJSyQCewNFOA
         IDNZ3YcmBprvDYtwrVfR2bsKo253RFdiWEJwb6GacK7j23e1V283qRTAHvkMET0CxYzm
         MGUY8L2wlU22pZseDkpBz8N+YOZJGaPXUvLuZj1pUW8x113j/OW2Wlu8QOU3RFsETBqm
         ZOV+n9ylckWCMVUNQN4SqwAv6XHY1Siz6fbOPD2aOcoIMOH/1uH4KnPupFqdT5/JeHZm
         SOeERVCB11+GjJs6OM6DFybfAeQNNFsjUaxeFaNjWqxzCI/JUX3Hcj11Vg6luj0SModA
         8H6A==
X-Gm-Message-State: AOJu0YwAeCQD1IYq9nwhMuNT7bs8CxcflZvnJDBmQ3SbsknwpYARo7VG
	kRBsrLKbk/pm5VTda+0ujTRsvSmInpqRMkaHo6+R3L5gMYLoOsFV
X-Google-Smtp-Source: AGHT+IHAHWpfSaKyH8nbEySVvrjEY4tH5GSlSxBkHYdxI86U3rTdtKh2lP8QDwzl47bD1g8DVf3OWQ==
X-Received: by 2002:a05:6a00:995:b0:6de:2470:92e1 with SMTP id u21-20020a056a00099500b006de247092e1mr627835pfg.15.1706673346505;
        Tue, 30 Jan 2024 19:55:46 -0800 (PST)
Received: from localhost.localdomain ([111.199.1.183])
        by smtp.googlemail.com with ESMTPSA id j8-20020a056a00234800b006d6b91c6eb6sm8988344pfj.13.2024.01.30.19.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 19:55:45 -0800 (PST)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	hengqi@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH v4] virtio_net: Support RX hash XDP hint
Date: Wed, 31 Jan 2024 11:55:35 +0800
Message-Id: <20240131035535.22258-1-liangchen.linux@gmail.com>
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
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7ce4a1011ea..7ce666c86ee0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -349,6 +349,12 @@ struct virtio_net_common_hdr {
 	};
 };
 
+struct virtnet_xdp_buff {
+	struct xdp_buff xdp;
+	__le32 hash_value;
+	__le16 hash_report;
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
+		virtnet_xdp->hash_value = hdr_hash->hash_value;
+		virtnet_xdp->hash_report = hdr_hash->hash_report;
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
+	switch (__le16_to_cpu(virtnet_xdp->hash_report)) {
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
+	*hash = __le32_to_cpu(virtnet_xdp->hash_value);
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
2.42.0

