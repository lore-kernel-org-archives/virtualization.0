Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44C4A7CAC
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001981; cv=none; b=bgNIEQKL0yyC/bSpEc0ARtMhNeGkUeISe0emvPbDW4OIgF+BKXSFdy5A878pICg5tWp9aQ7vHYfSWVrr5IngnCXz5p2Gm03HQEBGEXSHV7EpFkAkFvtgQQetrpGgdmgE9WVAH2BU+6TRpo4Rk0v3EMWJsJH4OX0H93uBK3aT9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001981; c=relaxed/simple;
	bh=Xu5NNYUv3QkvPDO37s/spZC3Lcn7LkjLNqeHi6OeTnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSyTV4xVGKW5jafljSmnx85WHVvsXXqemwMzyf1BsrnEifPwPuNtY+HjAjZFYay11nhFxpHbZjPIGtrY5h4AxYVCfFcZP68qAF69HhF0b8yaP3IkTZbSJNEt0F+8M0Mhl/MTnkLdRVy6p6JdSpZhb/xTf+DKTt9kGWTBil6bgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:4b01:1e0e:d42d:4ec8:33b2])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0410C201F08;
	Mon, 21 Sep 2026 16:46:15 +0200 (CEST)
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 21 Sep 2026 16:46:11 +0200
Subject: [PATCH RFC v3 2/2] tun: support rx-tstamp
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-v6-7-topic-virtio-net-ptp-v3-2-3350851c4f88@pengutronix.de>
References: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
In-Reply-To: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Jason Wang <jasowangio@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6467;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=Xu5NNYUv3QkvPDO37s/spZC3Lcn7LkjLNqeHi6OeTnU=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9ZGZ9N11vH8VR2y2dMebXspePtH586t6gz8s84caFG/p
 dtWr5rZUcrCIMbFICumyKKysIJP1OODZ+Q0ES6YOaxMIEMYuDgFYCKlIQz/bNbIzHrvu+tQ9vJH
 /P9/b+50DhGsd+tZbPU1kvO6i2DCSkaGiTPM6rZpXiw51xP38rBF2Q8VxZN7T59YXhG1RDpf3+I
 wJwA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Demonstrate support for new virtio-net features

VIRTIO_NET_HDR_F_TSTAMP

This is not intended to be merged.

A full feature test also requires a patched qemu binary that knows
these features and negotiates correct vnet_hdr_sz in
virtio_net_set_mrg_rx_bufs. See
https://github.com/strumtrar/qemu/tree/v11.0.1/virtio-rx-stamps

Not-yet-signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

---
 Changes since v2:
 - use tstamp from virtio_net_common_hdr
 - use the negotiated vnet_hdr_sz in __tun_vnet_hdr_get

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/net/tun.c               | 20 +++++++++++++++-----
 drivers/net/tun_vnet.h          | 27 ++++++++++++++++-----------
 drivers/net/virtio_net.c        | 11 -----------
 include/uapi/linux/virtio_net.h | 11 +++++++++++
 4 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5a302709a68aa..924784771b6b7 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2157,12 +2157,23 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	}
 
 	if (vnet_hdr_sz) {
-		struct virtio_net_hdr_v1_hash_tunnel hdr;
-		struct virtio_net_hdr *gso;
+		struct virtio_net_common_hdr hdr;
 
 		memset(&hdr, 0, sizeof(hdr));
+
+		/* hdr has at least the size up to and including the tstamp field. */
+		if (vnet_hdr_sz >= offsetof(struct virtio_net_common_hdr, tstamp) +
+				   sizeof_field(struct virtio_net_common_hdr, tstamp)) {
+			u64 tstamp = ktime_get_clocktai_ns();
+
+			hdr.tstamp[0] = (tstamp & 0x000000000000ffffULL) >> 0;
+			hdr.tstamp[1] = (tstamp & 0x00000000ffff0000ULL) >> 16;
+			hdr.tstamp[2] = (tstamp & 0x0000ffff00000000ULL) >> 32;
+			hdr.tstamp[3] = (tstamp & 0xffff000000000000ULL) >> 48;
+		}
+
 		ret = tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,
-						&hdr);
+						(struct virtio_net_hdr_v1_hash_tunnel *)&hdr);
 		if (ret)
 			return ret;
 
@@ -2170,9 +2181,8 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 		 * Drop the packet if the configured header size is too small
 		 * WRT the enabled offloads.
 		 */
-		gso = (struct virtio_net_hdr *)&hdr;
 		ret = __tun_vnet_hdr_put(vnet_hdr_sz, tun->dev->features,
-					 iter, gso);
+					 iter, &hdr);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index f4c652b1fa44d..0a7fe1ce889b5 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -109,12 +109,9 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_sz, unsigned int *flags,
 	}
 }
 
-static inline unsigned int tun_vnet_parse_size(netdev_features_t features)
+static inline unsigned int tun_vnet_parse_size(int vnet_hdr_sz)
 {
-	if (!(features & NETIF_F_GSO_UDP_TUNNEL))
-		return sizeof(struct virtio_net_hdr);
-
-	return TUN_VNET_TNL_SIZE;
+	return min_t(unsigned int, sizeof(struct virtio_net_common_hdr), vnet_hdr_sz);
 }
 
 static inline int __tun_vnet_hdr_get(int sz, unsigned int flags,
@@ -122,15 +119,20 @@ static inline int __tun_vnet_hdr_get(int sz, unsigned int flags,
 				     struct iov_iter *from,
 				     struct virtio_net_hdr *hdr)
 {
-	unsigned int parsed_size = tun_vnet_parse_size(features);
+	unsigned int parsed_size = tun_vnet_parse_size(sz);
+	u8 tmp[sizeof(struct virtio_net_common_hdr)]; // temp buffer with known size
 	u16 hdr_len;
 
 	if (iov_iter_count(from) < sz)
 		return -EINVAL;
 
-	if (!copy_from_iter_full(hdr, parsed_size, from))
+	/* copy parsed size data to the tmp buffer, otherwise compiler will complain */
+	if (!copy_from_iter_full(tmp, parsed_size, from))
 		return -EFAULT;
 
+	/* now copy the relevant data from tmp to hdr */
+	memcpy(hdr, tmp, min(parsed_size, sizeof(*hdr)));
+
 	hdr_len = tun_vnet16_to_cpu(flags, hdr->hdr_len);
 
 	if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
@@ -155,14 +157,17 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
 
 static inline int __tun_vnet_hdr_put(int sz, netdev_features_t features,
 				     struct iov_iter *iter,
-				     const struct virtio_net_hdr *hdr)
+				     const struct virtio_net_common_hdr *hdr)
 {
-	unsigned int parsed_size = tun_vnet_parse_size(features);
+	unsigned int parsed_size = tun_vnet_parse_size(sz);
+	u8 buf[sizeof(*hdr)];
 
 	if (unlikely(iov_iter_count(iter) < sz))
 		return -EINVAL;
 
-	if (unlikely(copy_to_iter(hdr, parsed_size, iter) != parsed_size))
+	memcpy(buf, hdr, parsed_size);
+
+	if (unlikely(copy_to_iter(buf, parsed_size, iter) != parsed_size))
 		return -EFAULT;
 
 	if (iov_iter_zero(sz - parsed_size, iter) != sz - parsed_size)
@@ -174,7 +179,7 @@ static inline int __tun_vnet_hdr_put(int sz, netdev_features_t features,
 static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
 				   const struct virtio_net_hdr *hdr)
 {
-	return __tun_vnet_hdr_put(sz, 0, iter, hdr);
+	return __tun_vnet_hdr_put(sz, 0, iter, (struct virtio_net_common_hdr *)hdr);
 }
 
 static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ef6238cb336b9..60ae9392f9876 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -498,17 +498,6 @@ struct padded_vnet_hdr {
 	char padding[12];
 };
 
-struct virtio_net_common_hdr {
-	union {
-		struct virtio_net_hdr hdr;
-		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
-		struct virtio_net_hdr_v1_hash hash_v1_hdr;
-		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
-	};
-
-	__le16 tstamp[4];	/* 64-bit timestamp, 2-byte aligned */
-};
-
 static struct virtio_net_common_hdr xsk_hdr;
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 39977765b72aa..8fed76755dcb1 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -238,6 +238,17 @@ struct virtio_net_hdr_mrg_rxbuf {
 	struct virtio_net_hdr hdr;
 	__virtio16 num_buffers;	/* Number of merged rx buffers */
 };
+
+struct virtio_net_common_hdr {
+	union {
+		struct virtio_net_hdr hdr;
+		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
+		struct virtio_net_hdr_v1_hash hash_v1_hdr;
+		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
+	};
+
+	__virtio16 tstamp[4];	/* 64-bit timestamp, 2-byte aligned */
+};
 #endif /* ...VIRTIO_NET_NO_LEGACY */
 
 /*

-- 
2.52.0

