Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05DB6EB56
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248402; cv=none; b=h1BVFUHVkTck4WU56vTSeUNIvCBQJGm9H4Yyw5YJouj5CB7UyxcoqDMOt8iE69UeBqwDj5/T6u+FmD++giXQTWQIwwZU6EcKq3FLvpjUY+dy/1JgA9i4YUj6tRJxrnGfLPadDKrqxXNQV61nZ1kjsH62sB0AVwGxmZLTRFU9A9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248402; c=relaxed/simple;
	bh=5libF+8hh3TL7tmz0fygEpN1XEmmSu9D/V7nn3/kmg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u6zUQOMPVtE29XHPaXpV/NHagsKKTpfnwWMhxCpVmou5XjN6/+1eycHzI9X5Da4N8yuQAB0XyipE6N2AtA19W0PTnX12wJPGzw1XJk0gJqG2fb6F9Ozb8x+RSMtwDGtlLHPd50hgLLcrtTxf+P/UTvbMG0kIYso4qxycazyeccU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNzzyXgw; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNzzyXgw"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c70999ff96so1061349b6e.2
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 23:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713248399; x=1713853199; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qkzd5w1QQiYFlbRgjzY4vgNg7bOQ7GZARMu1hSWDq2A=;
        b=kNzzyXgwe1OtalchqICWGDkdovI8qL7cgSlSLOKY5CPg6YkMIKa6uhp3osUgbQPR/P
         OBr5CyZ/nKCpAH4Z/Fq7wlnio8yTLPcUaApaNyymqUUlCAwzrB8XKoVi20huT154mh7e
         V8CzVG6lPFwmU7gxoSadhd9M6jrlWZXuhf3sebCbS162bwxisA2X2bSAbxL+HMa55o/q
         Jf60GJ8vx9xnAG0AOmEfkznJYM1AGg+BiiU+SQlme5xZvUnwloMc1lJBK/uXOM5QaXXN
         ulgg/2xUuO0RjjiqG5KFeMEhxKUJj2RgebZHggXsIUaJwHO3cQxzRCgYnPjafmwu4Xr0
         bpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248399; x=1713853199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qkzd5w1QQiYFlbRgjzY4vgNg7bOQ7GZARMu1hSWDq2A=;
        b=HJM58kFkDaj/AUAYnOsj5uJDrPpQiS6GfFXfnQg0Xo1HojgYp5ykaM9TM/CR+EonKZ
         2w/4XY9enoCfA6Uhruhvg06UGRy9AZz8v0I2uCdhGy6Hhb0VvJ8QRhXUgwA6bJA6h7px
         p7E75UwpPKn5WkOJvVTHB8Y85c7Kk35jsC8Po1qnLr1089Eo374jOTbjzk9mRikvz85c
         ZIMncX8TvTj5a/hX6X3yninYGIQBAKSqoXX0P3e97LBef9273QgGvnwGCnvxsdvbQEwE
         WGqv4zZEJQPQSs+QSjQWnC06SXQFzomCAyQp81gXvaPz0Wp7zKV8J+kupB6QY7ud00B/
         qTuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGx1KYPBlWTrl8r/Ybu8I8jRMPNLG/tDiZkRlPTbXaxzxyvbjWwSl80HMcAEf2jYACmxD03TRJQ7kFzXSVQOJgd5PvwzAK4g3ofPpUGiQ=
X-Gm-Message-State: AOJu0YzlICgbEhgGT9BIUAPr1+qeSukVQHwDs1Ywd/YQskR+EE1MGFyK
	fWOq0geKmBoUKGVqVxH3EYG09q0+HFfZ8CL0HDceAKYkmnywZfIK
X-Google-Smtp-Source: AGHT+IGTkeE2Qjnfg0ozjPDsXrqLB0bPuKPv9epzqELVHCsVzN8HvsXh3pGhutgvU87N1jOlyeX6zQ==
X-Received: by 2002:a05:6808:20a3:b0:3c5:f495:b8df with SMTP id s35-20020a05680820a300b003c5f495b8dfmr15444511oiw.11.1713248398778;
        Mon, 15 Apr 2024 23:19:58 -0700 (PDT)
Received: from dell.. ([111.196.36.81])
        by smtp.googlemail.com with ESMTPSA id c9-20020a056a000ac900b006e647716b6esm8487134pfl.149.2024.04.15.23.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 23:19:57 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	hengqi@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v8] virtio_net: Support RX hash XDP hint
Date: Tue, 16 Apr 2024 14:19:43 +0800
Message-Id: <20240416061943.407082-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.40.1
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
  Changes from v7:
- use table lookup for rss hash type 
  Changes from v6:
- fix a coding style issue
  Changes from v5:
- Preservation of the hash value has been dropped, following the conclusion
  from discussions in V3 reviews. The virtio_net driver doesn't
  accessing/using the virtio_net_hdr after the XDP program execution, so
  nothing tragic should happen. As to the xdp program, if it smashes the
  entry in virtio header, it is likely buggy anyways. Additionally, looking
  up the Intel IGC driver,  it also does not bother with this particular
  aspect.
---
 drivers/net/virtio_net.c        | 42 +++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..1d750009f615 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4621,6 +4621,47 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+static enum xdp_rss_hash_type
+virtnet_xdp_rss_type[VIRTIO_NET_HASH_REPORT_MAX_TABLE] = {
+	[VIRTIO_NET_HASH_REPORT_NONE] = XDP_RSS_TYPE_NONE,
+	[VIRTIO_NET_HASH_REPORT_IPv4] = XDP_RSS_TYPE_L3_IPV4,
+	[VIRTIO_NET_HASH_REPORT_TCPv4] = XDP_RSS_TYPE_L4_IPV4_TCP,
+	[VIRTIO_NET_HASH_REPORT_UDPv4] = XDP_RSS_TYPE_L4_IPV4_UDP,
+	[VIRTIO_NET_HASH_REPORT_IPv6] = XDP_RSS_TYPE_L3_IPV6,
+	[VIRTIO_NET_HASH_REPORT_TCPv6] = XDP_RSS_TYPE_L4_IPV6_TCP,
+	[VIRTIO_NET_HASH_REPORT_UDPv6] = XDP_RSS_TYPE_L4_IPV6_UDP,
+	[VIRTIO_NET_HASH_REPORT_IPv6_EX] = XDP_RSS_TYPE_L3_IPV6_EX,
+	[VIRTIO_NET_HASH_REPORT_TCPv6_EX] = XDP_RSS_TYPE_L4_IPV6_TCP_EX,
+	[VIRTIO_NET_HASH_REPORT_UDPv6_EX] = XDP_RSS_TYPE_L4_IPV6_UDP_EX
+};
+
+static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			       enum xdp_rss_hash_type *rss_type)
+{
+	const struct xdp_buff *xdp = (void *)_ctx;
+	struct virtio_net_hdr_v1_hash *hdr_hash;
+	struct virtnet_info *vi;
+	u16 hash_report;
+
+	if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
+		return -ENODATA;
+
+	vi = netdev_priv(xdp->rxq->dev);
+	hdr_hash = (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hdr_len);
+	hash_report = __le16_to_cpu(hdr_hash->hash_report);
+
+	if (hash_report >= VIRTIO_NET_HASH_REPORT_MAX_TABLE)
+		hash_report = VIRTIO_NET_HASH_REPORT_NONE;
+
+	*rss_type = virtnet_xdp_rss_type[hash_report];
+	*hash = __le32_to_cpu(hdr_hash->hash_value);
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
@@ -4747,6 +4788,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
 
 		dev->hw_features |= NETIF_F_RXHASH;
+		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
 	if (vi->has_rss_hash_report)
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index cc65ef0f3c3e..3ee695450096 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -176,6 +176,7 @@ struct virtio_net_hdr_v1_hash {
 #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
 #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
 #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
+#define VIRTIO_NET_HASH_REPORT_MAX_TABLE      10
 	__le16 hash_report;
 	__le16 padding;
 };
-- 
2.40.1

