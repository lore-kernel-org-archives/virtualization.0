Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7F1BC41
	for <virtualization@lists.linux.dev>; Sat, 13 Apr 2024 04:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712981491; cv=none; b=Kak8h3wzjKicDoPO51NcSlPOqyZmpauiiCaJvNUozj1Yf4C87Axtm9MO2VCoscgyXbjmP7W7SVKmUmFpca/LRd6XCpt9nGhNBGTCUoakfPVMSdVeHBFLUmyJXm6OGB4d9atuJYM3j9MZ1QqKphecayUsuq8TAKvKh1GHCyo6TfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712981491; c=relaxed/simple;
	bh=AfPGdpoeXhVGR+SHbrTki7kqPG4xqSDp/j1KG2K2pxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jfGPjEJICAs+Gzqw+6L3UwLntS7vGVVxVEt/QH6JyQeKP2y6fLDdbNVbTu0DQT1IRtI7RREYqlAv11MRzJqpelD9M2FE3jlqSs0/TKoSFZELuKuxEUdlh3k9KSj6PYHBUkA6DpHjoyAaIoVXhUM5O8J4OWvyxa7AIS/WqGwESkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LG/KTMDI; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG/KTMDI"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-23319017c4cso969752fac.2
        for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 21:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712981489; x=1713586289; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EDhCSWEgnV+NzpnZC+839Wmob9VMoO2EjVmXGFw60QM=;
        b=LG/KTMDIfE3mulL/bOZ/4nCRWmghdBCDKxGWjleai+ZRw98mHs00jMzecVUe8O8cWH
         TxiUHdK8QVvsDn33Ko7fs4mXf4l54REENWV/U8LorTIVDCIx1M/+vV/igPwQl7t9BOD6
         vztYRa2c1rCW/O3EJ+zzoJLNEG0Hsh50nkGSAdvzUJj54VWJJB5VAsFQNBB+yOoPqgR1
         696X9+XLlSdxiFC00CSSoKP0mDir/CkMgiWCY/F64AE3zMAgLRkBjmSsva+9pU74/ZM4
         b9P/3kIRcR04oMn1VrYVZF43yeRsut7JfUKIhSY56ATn6u4kJS2wGnq/Mc3ZB8Lzp9AD
         8NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712981489; x=1713586289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDhCSWEgnV+NzpnZC+839Wmob9VMoO2EjVmXGFw60QM=;
        b=v9c9ah0LtYJYyhXq1U4v0jgnekRIXhbmB2Q2r9+U/v9LwshLrjn6q+rSTHSMOyuO2n
         zAvgjsfddBUt8H782GG7T7mhccnQ92UneAHASyLgWVEfAhkJGpdbq0RMfVtdEh76Af8y
         ODtgVWtx4Zi2CLRuRB6elF5ZbRwh5yHVbiWPa7o9cZY751HQUjeQjs5rUnV3i6FsZxDk
         la/fcfzas6zsUx/c68TkLVzWxC6fAjwX8D8gvDRLc31aTEwqBT+k0W2oHP9e26y/fFT3
         9a8AuEffrmmMugy+rgFpkaeRRlh2UfVDS88PDQYHXFAnTAK1lu3ZOKC+qUDgGLUvDpim
         7XXw==
X-Forwarded-Encrypted: i=1; AJvYcCWd7dMTeX5kMnVbA87/Je/KqGU3U4zllr69Fk22Kb40CkYMkOzmuhWN3YGRgNqGukSdYDw++AQI+pk3i6LK+ujmrIeScGVkVX1npQNdhlY=
X-Gm-Message-State: AOJu0YwUCJSAVA+jwn76wOC6X9GkVv0NHgzcH15frW8SDYenK8NfJNAO
	M1vOpzTzHu5nXGxhe/WUkuvkk1QkVHXvrt1/jDx6jQjPH92xWZHR
X-Google-Smtp-Source: AGHT+IE+nEAWcd0+Z2P4/AV17wHWyQPGohLUz5foVK2JC1p4PEX3jDqCCzVk0FB1zWXVp5Fn7Jr8DQ==
X-Received: by 2002:a05:6870:5488:b0:22e:cbfa:678d with SMTP id f8-20020a056870548800b0022ecbfa678dmr4605735oan.57.1712981488680;
        Fri, 12 Apr 2024 21:11:28 -0700 (PDT)
Received: from localhost.localdomain ([123.116.201.21])
        by smtp.gmail.com with ESMTPSA id y22-20020aa78556000000b006ea81423c65sm3722131pfn.148.2024.04.12.21.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 21:11:27 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	hengqi@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v7] virtio_net: Support RX hash XDP hint
Date: Sat, 13 Apr 2024 12:10:35 +0800
Message-Id: <20240413041035.7344-1-liangchen.linux@gmail.com>
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
 drivers/net/virtio_net.c | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..2a1892b7b8d3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4621,6 +4621,60 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			       enum xdp_rss_hash_type *rss_type)
+{
+	const struct xdp_buff *xdp = (void *)_ctx;
+	struct virtio_net_hdr_v1_hash *hdr_hash;
+	struct virtnet_info *vi;
+
+	if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
+		return -ENODATA;
+
+	vi = netdev_priv(xdp->rxq->dev);
+	hdr_hash = (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hdr_len);
+
+	switch (__le16_to_cpu(hdr_hash->hash_report)) {
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
@@ -4747,6 +4801,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
 
 		dev->hw_features |= NETIF_F_RXHASH;
+		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
 	if (vi->has_rss_hash_report)
-- 
2.40.1

