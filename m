Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482419;
	b=aTTYLtFhFHIjkm7tFx/mZgaEcSxsg39d2kNQMB94Xlsf5+YAwhVb++J3WL5z0avfBCp7
	 suSGehM9KCPVLf8Lq+jCMLmuH4QJy8hz0IMwPS8p+Ped4IWxXeWRDjsmC3RZacnMb/8B4
	 L3LknEhSNiylsid8En2+zRnCe+FgYyVsWCEhQWb5kIRSwgaLt8evljjSYP/8mCU+LsuLg
	 oGaGIP04Z5Ennpp9r92+gEJoeh0FaT7TmfIABA9gY8JSBLrUu4MG/Z5Ag3/EG545l1zz0
	 HJy1bzxqI6gK0UBRVxgN3bdLIxxfWDi5PsAqlb3ZAMq2cYUBW2VOFcMHE5PcXQX9z0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482419;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=yIhQC+fZJDJtnl/5PxVelzCXuQMPhx05yFsV78RhKTw=;
	b=hm2UCCaFOaWSBBIElTRTpr+5fC8Vnf4WdrX8UYJ0TF59BtegoDgIApxf9506MYSwJWLx
	 qHYboCqkPN6trZMjcBsTv9qiUhVe8baNz7BT/gmX2cLhO3kgeMkIJuRtDe24VJH0PtxAE
	 G5fgEBYs4sLYz9fjJYagIbV5QRWv2pEMksDVybTklbORU0gMU5dbz6ymo0+OOCrlh3yBY
	 Gk2ihR+7u/++PWKO2Y2wan1hVdDbFfdLbDE/DPTX51UhrswUFEzou/3Zma64MrbyiBBjT
	 +6gCuVOo0jqU5PsrIjEBCK9MY34Cqm1dsZ/z5D4DjMf4w4WXa6PkFJ1VJ9HOpmpkK4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=JYJMlKJq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE5360A6F6F
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 11:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CE5360A6F6F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=JYJMlKJq
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 50292205847;
	Thu, 12 Nov 2026 12:20:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yIhQC+fZJDJtnl/5PxVelzCXuQMPhx05yFsV78RhKTw=;
	b=JYJMlKJqVdTy+cEKxZTWSAz+J+/LiAv5BLuwJaPS5ai6MuOqjOUIHFAUt6GlbrtAAuYlcP
	v0EDRDHZpI8vDEwYRqmDPY0zUFo2tYa+Fj2EVdgyMCDUJHNOHk7wtFk5eRaij6PRXaO23X
	VyqCKFpG1U1P124MAV+5VM3+OHhG6BbVY3vXznyz5TNL50D9OC4beDag1sMbUpEJ/u3hCJ
	5YamiuSLDmuVH0ssflWMbMahsXZBRZE6u97/1m0JkMpTrcfcq/DlB5z9/WI7cDwdKtsUGk
	Rl0mtUYl2pKqFFAMsZcAqV1aQPQ6o6jTahWPGuuWTfhlfYLQWxinxPMnFf58eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yIhQC+fZJDJtnl/5PxVelzCXuQMPhx05yFsV78RhKTw=;
	b=PAAAP1NRAjjfnSRFLaF43iNuN5TyNT32PmEIevZvyYl6rV5xeBtFxx7K19zCNnfWJjSwCf
	Zt9x3lkiByWx5re+xmGMyawVRNyFC4T9sbeOaP+2deWrAz9GMLryDA8DHNSNLAkJKBy/4v
	3t/rfX4zHO1PmSElrM9vArwRZ4iR1GdpyweJpt270RMc3cmZ4gGzsmScib23wq1Fmf8LKP
	yvcxFeym/637E6vx54TCgcdGiwREOjIDVuICvgk3ckYoLbMI/TlDYCVuhcaVaxSSoufE6R
	3XAYDriZjZL3nr7hWJPlCVQsBrVAZhgeo+eQbzviQZkA96Yjv+qCLEp9FQtZkg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794482417; a=rsa-sha256;
	cv=none;
	b=VmF0P/v1RQzZTPDGCuWB0w/C7+K/FnTSRDXHo2Wpm+aVCQJlbAbPaj6H1pPyykOczFmVSD
	a7DHX9AN4zudVqrqUpgycWIuUIXBt7OIlZGNDWeBk80sPCskvhZKp2eLOi2MkSab7M/Il+
	Ks+8OYtis/waoKDi+4eYCk05EDi/Mn1kNwjtoql8wM+iGFoeu1N8EIz3jIsfC9zwQeVI0T
	MrsJJTHCuKc7MoLiuAsPheLu+LX81GpscV1veo81GtD+K+9fm8LNIH0GHaObGEMYVWNre5
	0tsE5sGUudTQhbYYudttLksL5RwRG4rV93RVpXwTPm0xmIlcToN8ya8CIzqhbg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 12 Nov 2026 12:19:39 +0100
Subject: [PATCH net-next v5 7/9] vhost-net: support VIRTIO_NET_F_RX_TSTAMP
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
Message-Id: <20261112-v6-7-topic-virtio-net-ptp-v5-7-7ab67b572f4f@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2975;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=03D9BYdzqBz2MOaS0vkDq/S7nPzCwJmByvh+gpRH1yA=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bXBW+Mqnmaz3Os5Fbd7ryk9vevE/NWnBfyujX1mUwG0
 4X4OQu3dZSyMIhxMciKKbKoLKzgE/X44Bk5TYQLZg4rE8gQBi5OAZhI3HGG/zkS3yIPlDw8UJhd
 vmbyT79Z+esdfx56et77+uFnNxq0fh1gZNgXpywefsc39+nXI5UXjwpKizEee60TP3tpoZu+ipY
 UMz8A
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Advertise VIRTIO_NET_F_RX_TSTAMP to userspace and size the vnet header
for it, so a guest can negotiate the feature with a vhost-net backed
tap device.

The header is 40 bytes if the feature is negotiated. Whoever writes
the header (tun, or vhost itself with VHOST_NET_F_VIRTIO_NET_HDR) has
to fill in the timestamp; vhost only reserves the room. If vhost
writes the header, it zeroes everything behind the fields it fills in
(num_buffers only with VIRTIO_F_VERSION_1 or VIRTIO_NET_F_MRG_RXBUF),
so the timestamp is 0, which the guest ignores.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/vhost/net.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 435d8ed3851f3..1b171af105a22 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -77,7 +77,8 @@ static const int vhost_net_bits[] = {
 	VIRTIO_F_RING_RESET,
 	VIRTIO_F_IN_ORDER,
 	VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
-	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
+	VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
+	VIRTIO_NET_F_RX_TSTAMP
 };
 
 enum {
@@ -1166,6 +1167,7 @@ static void handle_rx(struct vhost_net *net)
 	s16 headcount;
 	size_t vhost_hlen, sock_hlen;
 	size_t vhost_len, sock_len;
+	size_t hdr_filled;
 	bool busyloop_intr = false;
 	bool set_num_buffers;
 	struct socket *sock;
@@ -1193,6 +1195,9 @@ static void handle_rx(struct vhost_net *net)
 	mergeable = vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
 	set_num_buffers = mergeable ||
 			  vhost_has_feature(vq, VIRTIO_F_VERSION_1);
+	/* Header bytes written below, if vhost supplies the header */
+	hdr_filled = sizeof(hdr) +
+		     (set_num_buffers ? sizeof(num_buffers) : 0);
 
 	do {
 		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
@@ -1278,6 +1283,16 @@ static void handle_rx(struct vhost_net *net)
 			vhost_discard_vq_desc(vq, headcount, ndesc);
 			goto out;
 		}
+		/* Zero the rest of a header supplied by vhost, e.g. tstamp */
+		if (unlikely(vhost_hlen > hdr_filled)) {
+			size_t rest = vhost_hlen - hdr_filled;
+
+			if (iov_iter_zero(rest, &fixup) != rest) {
+				vq_err(vq, "Failed vnet_hdr zeroing");
+				vhost_discard_vq_desc(vq, headcount, ndesc);
+				goto out;
+			}
+		}
 		nvq->done_idx += headcount;
 		count += in_order ? 1 : headcount;
 		if (nvq->done_idx > VHOST_NET_BATCH) {
@@ -1684,6 +1699,10 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 				     VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO))
 		hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel);
 
+	/* The header layout is cumulative, tstamp sits behind all other fields. */
+	if (virtio_features_test_bit(features, VIRTIO_NET_F_RX_TSTAMP))
+		hdr_len = offsetofend(struct virtio_net_common_hdr, tstamp);
+
 	if (virtio_features_test_bit(features, VHOST_NET_F_VIRTIO_NET_HDR)) {
 		/* vhost provides vnet_hdr */
 		vhost_hlen = hdr_len;

-- 
2.56.0

