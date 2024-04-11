Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77301411FE
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825586; cv=none; b=SkvOfg35yZxqysXBwQ4JebD8a5P/asktTCVplzlnW4sN51ogUEBoEK1CayG8K+2tFQvl6l/DkIjF2YSnWW+ysAzpvQWGd6X5kvsIiJ1EgqZQkzO2zPetUN4dgD3HJLiipL8pSvGrxSRVZ2nM9mE14DIlu9Lis6W1Yk4J9m2WsEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825586; c=relaxed/simple;
	bh=io9LKvvXimYbev4Iml4NKxNJy86/qa8clb83Jlhvc2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4EwgYbIpjKbfaP+2gMUGj3f4ax5/gdDPe/5jXFR7d0b5R85hm5xAv6HPXB4NtCmP3NsQHb+ngEiZBL2sTw3j99axNMOD8kzvk7p72Ednyu80jwGS9mxdkHzH0PHA8HuRGmn7nYGue5Qpwb6WWacDGt+P6D/ItS5mqHTUic4aGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmL2y0ko; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmL2y0ko"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dca1efad59so5470699a12.2
        for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 01:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712825584; x=1713430384; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ya5I5hvjUcaAqlpM5swpRYtJfi5w+dWzk4Fz+t660Ec=;
        b=lmL2y0kowKXbKJUwIzmgIXL4flKfRKGE750tMmABXju/bigtFVwJn2aEeSJYIG8/dt
         K48ZuUjzYRxheJ9984kmGTwcCgiCSAEBhNsaqseK2hwYuHzKJtl5yWPObxn11KhOoCNM
         1Akg1jkSjqScV6e3cb+0dn523LHiMD1xf0U7z/actvs1cEPvTHN3UtO0w+LBNuHj5pox
         jEBPTxVrifY+z82ZE5y2ae6kYVWCOgJ/10HCd2HQMmpQZp9gupFW1H74zSsuurgkXxB6
         1ld5vO21+jO7LQBs7bC0KVOM6NzJpe1YsBl59DobkV6H9mvqrXbmiwtL33R9a8iMht0e
         pIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712825584; x=1713430384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ya5I5hvjUcaAqlpM5swpRYtJfi5w+dWzk4Fz+t660Ec=;
        b=ZGIN+4kPsEgDNzocLEkrAYGdWpfFQg7jg1fnQFPoS27GkvTt5mmzV3ZeAneQDQhtkS
         55kK5cfyNjyk3ATEFIYTRrErfyhWVGtoxveRlw0HQEo/P7iZrhAfz1u5pa+XO2ZBwHec
         O4k1DHg+6sUtrH/lDFyT9PwhuIsKFeSVJLeI380Nr0aPj+C+hq0tWrySLQQjALpdud7W
         CAX3MDRVNsbnxOQbYJ3Ku/XeZYCKu0ICPCuwkFTEAnwvYXpUvSTGT5d3p5AlEyuSu6uW
         Wf5bUrjNy7r6/Z/ag78sVfZAr22C21widC0PiLq6WMKEN4ZXlZ5BsHI3q0AOzwnGQsEm
         m0Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXsu4OU8nXvJt/5xYqY2rX+NspZb1E9FnXNQtjavaAbW0IdPHqHXt+d/20FbdekYsfIIz4TB8qUZ6uCArIXowSKlPEdIGxJpfQOEsKmYR8=
X-Gm-Message-State: AOJu0YwMezEfj1Fq6ZkI+K1ajUualWnofO26ZJuL4B8oD6P4i/npnMMx
	fsNZ5kePSHON7XIp4+nWHJvKXte+xJ/zKZohKlwKPwBFsWRgmyFj
X-Google-Smtp-Source: AGHT+IG0RZWIYvC1TAdiHu4GiCufqpdvQrAKxYmpsyvNmU5fmkX4L1O0eJJwfz5elYuwUFstobv+qw==
X-Received: by 2002:a17:90a:f40b:b0:2a5:d5b1:b99b with SMTP id ch11-20020a17090af40b00b002a5d5b1b99bmr3708871pjb.38.1712825584034;
        Thu, 11 Apr 2024 01:53:04 -0700 (PDT)
Received: from dell.. ([111.196.36.81])
        by smtp.googlemail.com with ESMTPSA id y12-20020a17090a154c00b002a52c2d82f0sm4534844pja.1.2024.04.11.01.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 01:53:02 -0700 (PDT)
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
Subject: [PATCH net-next v6] virtio_net: Support RX hash XDP hint
Date: Thu, 11 Apr 2024 16:52:16 +0800
Message-Id: <20240411085216.361662-1-liangchen.linux@gmail.com>
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
index c22d1118a133..abd07d479508 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4621,6 +4621,60 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
 	}
 }
 
+static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
+			   enum xdp_rss_hash_type *rss_type)
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
+		case VIRTIO_NET_HASH_REPORT_TCPv4:
+			*rss_type = XDP_RSS_TYPE_L4_IPV4_TCP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_UDPv4:
+			*rss_type = XDP_RSS_TYPE_L4_IPV4_UDP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_TCPv6:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_UDPv6:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP;
+			break;
+		case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP_EX;
+			break;
+		case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
+			*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP_EX;
+			break;
+		case VIRTIO_NET_HASH_REPORT_IPv4:
+			*rss_type = XDP_RSS_TYPE_L3_IPV4;
+			break;
+		case VIRTIO_NET_HASH_REPORT_IPv6:
+			*rss_type = XDP_RSS_TYPE_L3_IPV6;
+			break;
+		case VIRTIO_NET_HASH_REPORT_IPv6_EX:
+			*rss_type = XDP_RSS_TYPE_L3_IPV6_EX;
+			break;
+		case VIRTIO_NET_HASH_REPORT_NONE:
+		default:
+			*rss_type = XDP_RSS_TYPE_NONE;
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

