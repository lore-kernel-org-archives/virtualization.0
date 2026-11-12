Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482418;
	b=QauIShRtxLrT2DRwYiZxojrJ2Pclmmuj6e+JcOuWwccQX9UQlOZB3UAOy4OZzG/cyyL7
	 V2TFyHuzxk3HmCZA/XHTzl7pfP5ljOdDW69KzBcWg1s7Zf3RZwsDJng7sRD+YDnFltpFu
	 5+umkI2stGGs9OH0/DMUWcpxkijCJRbCU/QH1tUdPac8x50jM4kLEH7K2va0ScgwOYRk7
	 YsOQb0Ai5AAjdfPukwGL3whCeJ7gjpPzSpsoI7mjIkbnLYmg+s3htZDNDDi48574GmTMO
	 uy+R7LPz6Uvz56JdxIQYa/yGdb/hcl2RQyn8qMimDN1PETlYFlQ0j2C4lqxPg6DXgIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482418;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4HakfNUpavLFvhu3nO9oY0qI71HCwNPZRBM/MdlEYYQ=;
	b=ss5KFxZL2I+XqUhAkxNmTe0hDJAhdVM7enMDYUZa6vuvMkfSq75ICDL8s498NmPQe7i7
	 jrbOSHhkrQ0nWb3YpW8g28hgZPOCZVnhBXQx/i2ErWybvGuFdJ+dYABhFgbVPdJrmk6ga
	 9Ro3WLvkyOokb1m6BpUCkDn0NezSP2nGCQeGXn5HM4DtOG//qX69QpPxqKMHY848YM3MJ
	 uDh+cSPLSdcASKluIM9mlKrr9xq8hrVCbvlLecFAS2ByZNcEcFQrhFiMYBC8dYETHUhLO
	 9lVS3sVmL/L04sjPxQ4UxGzLXynutKdEPiU6TTPyM9w8d/nbgS71cICxG4MmFJBTWuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bh8wSklX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76E760A2635
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 11:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B76E760A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=bh8wSklX
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B5A3A202C94;
	Thu, 12 Nov 2026 12:20:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HakfNUpavLFvhu3nO9oY0qI71HCwNPZRBM/MdlEYYQ=;
	b=bh8wSklX5e+zTILl8u+ZohhCu6n7DPf+8o3kjVrDwVshc+L12LvLa2dpNuRr+vTc4a7RM/
	HsnAPDTjn4rQeJebd/+dWTo/GFUMlLB/HqP0yHuHL6x/A6dHMqW1UBSwN06Zs9f1M/o4vr
	c+yaVZ0z9qQyzh56NtLS0G7fX/izP8vHHvQmGRYy+8VnPbgFWwor34GILXdvCfPgs6qapI
	dSpsZUsRjFH8RqQykr+EOSAGxI/jUgDgubBB3i5C+AuEaHoGurKgaRP/Hb2th09lh1IvOt
	r6uFnTp9EnV2LYxLhkrNb8097wW+JpN0uPg5TEVf8aPE5dxuNDRBtbvR3G0/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HakfNUpavLFvhu3nO9oY0qI71HCwNPZRBM/MdlEYYQ=;
	b=I85TVBhjAV+aqjxkeV/KNUchO6w7TCziQSGkddsaOviu9UWrdcGvrL4SJcAGBMrDx93kvx
	rNDQ05UxJCT5aik6C/NOW1npsaLLFzl1SADCr3dV1iX0hemXbFOuUFfdEqDZ+oS2gYHZ06
	CNq2q7sKtIDF5rFqD66JKhV3gjjswPmwzwuXZswqN4UDpl58o3Q0lqxptIvOiSlFs8Foyt
	/zUvVo4lQojyDSzLEpv7kZgHA0xTRqr8cHoomCfT4N7wezBxAV26wEMcyUFK4of+q8x6Gl
	/mLA3jXZeZP3er0bgUkNoob0iP/Uh1VFVqBxVpOxEWMawbGc22O/DBe2L3710w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794482416; a=rsa-sha256;
	cv=none;
	b=ITmFWfsVMIJxS96+buBJxgxoCOoyyWi5nDGMNLljnFCiPdA+6L1oWvGB/9xaaTf2xl8b8C
	HOPHHfS3c4h5uVYwHVEvP2qrh76ky3BemqZv63ADj3WAq/5pJf+Be4u8+G5zteltnqTNGi
	D8l3Rvve6FkNHWEtVX+Q3TZUkOFMbHo3Z1AnoEL5F8Sg/L9Il3UIoAaXIRkpd0IcNrWXpk
	nuSqwLcFPjZexkV/GvpqCisTX7JaasndCifVVBRa/2Gjh7mKcrFHtX4xHomWrdDmv6UlX+
	DwVlk+XLtuFI5wSqLuaQCKDcrs/GI6V80IxbsAhIo5ppd2aeMRhZo7IWzJbg/Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 12 Nov 2026 12:19:36 +0100
Subject: [PATCH net-next v5 4/9] virtio-net: move virtio_net_common_hdr to
 virtio_net.h
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-v6-7-topic-virtio-net-ptp-v5-4-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Liang Chen <liangchen.linux@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kvm@vger.kernel.org, 
 kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=qMefS7zluiz+QPZvSp9MZa6S58FNyzU/Kg6hGBw/qXw=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bXBW9mO59TqD0oW1irtf26ylPXM1M/GNt8aVtTnLV1d
 Yrlmwk7O0pZGMS4GGTFFFlUFlbwiXp88IycJsIFM4eVCWQIAxenAExk8wyGfzbTVPt3bU29dTjw
 xtY9VTNNb/08wqSa7Dhvy7L8ACdekTUM/1MmVfR1Hqw9/ri9Z16gcrxAWfDh5aaGwXdmHzVXtU0
 9yQsA
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

tun and vhost need to know the layout and size of the virtio-net
header as the driver uses it, e.g. to fill in fields behind
virtio_net_hdr_v1_hash_tunnel. Move struct virtio_net_common_hdr to
the kernel-internal header that they include already.

No functional change.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/net/virtio_net.c   | 9 ---------
 include/linux/virtio_net.h | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ffd7313663c18..23e7f62a6ff64 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -511,15 +511,6 @@ virtio_net_hash_value(const struct virtio_net_hdr_v1_hash *hdr_hash)
 		(__le16_to_cpu(hdr_hash->hash_value_hi) << 16);
 }
 
-struct virtio_net_common_hdr {
-	union {
-		struct virtio_net_hdr hdr;
-		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
-		struct virtio_net_hdr_v1_hash hash_v1_hdr;
-		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
-	};
-};
-
 static struct virtio_net_common_hdr xsk_hdr;
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d6466f96cdd00..a6de308b8f25e 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -10,6 +10,15 @@
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
 
+struct virtio_net_common_hdr {
+	union {
+		struct virtio_net_hdr hdr;
+		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
+		struct virtio_net_hdr_v1_hash hash_v1_hdr;
+		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
+	};
+};
+
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 {
 	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {

-- 
2.56.0

