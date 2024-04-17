Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE540850
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338415; cv=none; b=sIF6C4O78U3XcTpOxmk6w1lNQFAQvOee3yiZZ+Hvuk9zQ2EzkHfCAYvVYJYhfdLniiBLrs+nlrhGRmr77zjt7SxXDBNz0fwY0KTGE8EFPd3MlFPOqJVfdFfUMNyCI0hDqEqDfNrXc9iCQ7jdCuYpti5OIdoX9D9/4nf8czT+AVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338415; c=relaxed/simple;
	bh=wL4iIM5J0lis2TMQWRGN6ToXbEhEI/er1H554XBUZ90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=teVSf9DMNzBeAle9fHun+PUDipf6ENmrAtfzaKjcYO2PQ4200/smij8HTc4+RVn7SZrs4gq9iYFGe6YgcAV/K/LqtuCilevG/VG7oX5Bce/MhcC04+itpPV57mpWmRiFc7tFUilvCGFCCJ5jZawcaa/+h0i5FVqyfeV1W/6dVQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0XpDhQT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0XpDhQT"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so4651397b3a.1
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 00:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713338413; x=1713943213; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pt1487gYTWW2TmxI/onbKRtkT21ZsZOQ+ApdIXHw+fc=;
        b=i0XpDhQTqXU8fvSnAsud7tKRemYHZWspYHeRmNgl2FDmvOXMJO/SGOcba3qsxS4xgx
         wI4tDQj/nTBfHQrK0go8vI2Dhv6v8Uh66MYLI1lCrwaYVE8fVpK7pRAtdbBG9tA8OEAA
         grxgAl3HUygmZVuusKjJLZPN6c+xIaj2i+vMwsjDuQrPXnlDeF0ENguuG0JyernNld9C
         64+RZU24crq5qauu8T9bTgBcJpn/UvBqzG08YmWZopxYuUXer0ZEIxjWefkPclVrneFu
         +slDgad71r8DKsa+2WvJ+slDQ9fzsnIMl1JfCTf+3jq7IlPYrUSfrmy2ZcZEIAFT8jU7
         DS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713338413; x=1713943213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pt1487gYTWW2TmxI/onbKRtkT21ZsZOQ+ApdIXHw+fc=;
        b=KulBs1LspAIwBMfiKSqKnOEe+xKWPQ7C4fTi7tmqS705uc/MiT9ziEF2ukoVhHpJjc
         uEdd/LC6AV/10dU9vE3hT7MKycJ67fEcJlTks205QqUFNdcxk0yV00PJGKOl2LR7jZLh
         E0/NYIPpRsW+068f6jEDiHRHq0ZZDh2PSTV2UmTs5eqminC3PpMwVtuW0/W3/yqL5sf/
         atGy7mN7N77kA/vImy049AVqRANx33KnS5VaF60x6OfQ/u6d9RL+7wsV6H3JgsJxtG3J
         GmkQuT5ZDs/kMbwDq5qJXOcw/JNrqxbatKFOsZQtD0HvjF0vrt1k69Bt5J/Q0xfoQFyJ
         rwXA==
X-Forwarded-Encrypted: i=1; AJvYcCWPO8b72bfpoC/bkdARBS/Mez67sQi3AbjyrfxaZv278+xvdDtPmFO6ryeioFZ3mtJh+yXyh85HPuCKaS5qj10bjGPMzXGmhuDlT6cVccg=
X-Gm-Message-State: AOJu0YzW/pR5mcwiyGw8z6Gne8aoC994oY7Xt5HFm5v+4p8BcmkStMly
	iLbeJLbEP8pk7vPrfWrboohV3MK740ZUOtkqsx9bMiR2oJ7qvzuw
X-Google-Smtp-Source: AGHT+IF8czx7WcbMRIyaPpnPne+jCia1Zgf1JHtt4BZARNuBM3xT75gCXDwNrt6TdoCdhSJBzPML4w==
X-Received: by 2002:a05:6a21:2791:b0:1a8:4266:3d02 with SMTP id rn17-20020a056a21279100b001a842663d02mr17049898pzb.30.1713338413105;
        Wed, 17 Apr 2024 00:20:13 -0700 (PDT)
Received: from localhost.localdomain ([123.116.201.21])
        by smtp.gmail.com with ESMTPSA id z3-20020aa78883000000b006e5571be110sm10007768pfe.214.2024.04.17.00.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 00:20:11 -0700 (PDT)
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
Subject: [PATCH net-next v9] virtio_net: Support RX hash XDP hint
Date: Wed, 17 Apr 2024 15:18:22 +0800
Message-Id: <20240417071822.27831-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
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
  Changes from v8:
- move max table macro out of uAPI
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
 drivers/net/virtio_net.c | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..eb99bf6c555e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4621,6 +4621,48 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+#define VIRTIO_NET_HASH_REPORT_MAX_TABLE      10
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
@@ -4747,6 +4789,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
 
 		dev->hw_features |= NETIF_F_RXHASH;
+		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
 	if (vi->has_rss_hash_report)
-- 
2.40.1

