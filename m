Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482420;
	b=LKLzqlSohD39kQ/qiBXWuQCIId2xSGyGPRP+M25k3lOYMOYmHJJ4RSwy+gyFzEgwI6h+
	 ZzizCah1gkhqMDxxxdr8kJEfmg9Sjlzc3qLJhZPp7v3bJcVWpjo2PJhMeZQ009RWIwZvj
	 1h5X9yC1LEINghGtQVnNPn+JZ0nPCTnLkgVD5esj+BJQqqIBpXNm1SbiaSiESdGrNoRHX
	 woT6YmwHhaDnF3cXR/E8vLnshVQokfGBuc0ndjyC88GtBYv7+RblYXCKfazeavyxC+ixi
	 wv0mlkujvZXy0pPRsSehJTZHUYyoLaBa2RXQWrmhFrpk5BLePwIZP3/4XxsVldMqPBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482420;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YFmiRipGVOhRtn8lRjovLQKljgNDRtPwRig6/ms6OmE=;
	b=Y5XFALbfIp+X1Pen97QY2/faaVvfaazYFHimCtX2/FCG67pWkJ5u6+3b89MxrrRD7x9a
	 AnbWoxCq7DhQ7TOxyGROng5zyo6JloTOdf0YdsjMXbOUG1OEqy5AJgLPOU1XGJhMYkvXZ
	 7o0xZgOKI3c0EjTZ6AvmyV4wWHEMeRr0AQ4MnHP7g4wqnKlvHKrxrShAhi6fSHYf+foZ0
	 2wGWxmBpPW49cBVvqVkEaq+VHHvI4mp0pusktFN6LJl2LMJC8xRMRjpPHCccWu50SruEL
	 pKXmNSuycUFCf75U2oL2AzefhbQB4kbaQVQtnZlzDs0cCVBUkhA5CmZEKZwsqDHpA4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=V61OQqSx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E1360728CD
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 11:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3E1360728CD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=V61OQqSx
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CF686205848;
	Thu, 12 Nov 2026 12:20:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YFmiRipGVOhRtn8lRjovLQKljgNDRtPwRig6/ms6OmE=;
	b=V61OQqSxORIU8ZN4ZnRzPKyX0NxkVNnWyp5Gz5b5A+ACnC86Jxi7hpmvyrrytCloExroD1
	E5QfcR8McDAayd/DqVoO0y/YRmyrSjR4tYZq1YT5YjIXjhL6Zrx4aKkFkYBXYrlHxiHrxO
	P4F6G16ptP54y5Z/01cf8hzTVfmAySC1CjQg7hlAL4s6Zur2aVFbxJt+EjUCYh7PUkacvf
	J13L2DzII7fAOkM/LyG33e6RgVNyDDiutL4vcJ9GXVMcOs+VfKDbJM4D3nw25IdSrX/wnc
	5Pt/V1181gFhvo8grgIq25TEbtiGginIBxwIDUT4DWKNqhHiTqEoYYy2Du8EcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YFmiRipGVOhRtn8lRjovLQKljgNDRtPwRig6/ms6OmE=;
	b=ZJN/QQwliDlN4M6gWvYqK8Oe5ZBB2nSb0w4uT28yOirVrnWCwqFoUImAPify5Z1PhNLr8X
	dWZByVBTXsHZF2WNmOsqysGH6CQ8+H163zbGweju1JhkYa5x/HwUTaPdJrveVliyV9+cMC
	DFJPnG51aeErLc3flQwE+nYQvbH0DX3+Jt4mfH8cIy2yZajEbM7dsldpyKAi4H5O+hlf9g
	ecpwQxjwsg6SR+Wt59mdWrhwcosYnS8e2L+9e4sWWBHRkKGTkz1IrSsR7e53JlD64aHwZs
	jfdWU7gggVNnqS7xRw6eEnnYJrrUy100K0QEuKYPWhnk/YKM0AS8SPRplOWj/g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794482418; a=rsa-sha256;
	cv=none;
	b=G99L7gKI+t7nHitGUMZSLDABtz+J3u9aztGqeU9v6Hnplxin8Nkx7mJi4EVPxSRmLbE+c2
	5AfRlWc5b0HOzIre3qh14nGGevAYJGXNYSVuH58Lfl7a0Sn3Ukr12NwyFUytJJrxuYgpDR
	1BoDEHRSMzyDlq19YPEDhBYBU8s05Ja1CBC1OT5T3a/hjh07AdL7mBksCE8Gjpy9mN/qlI
	KfvysZi/+LgiX1MWXHXwIbpt1wIonfgmP1JOUH5P55aLSsoGJi/57mbsCauuXLwHH/1c/F
	ts/+cznvvXj1Xa2vJjSkBAftxV/f0SfUABBD74Gy++7dQ7uuSuEPeV3dSHLSRA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 12 Nov 2026 12:19:40 +0100
Subject: [PATCH net-next v5 8/9] virtio-net: add XDP rx timestamp metadata
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
Message-Id: <20261112-v6-7-topic-virtio-net-ptp-v5-8-7ab67b572f4f@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2661;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=fT8KifTYffEMAVE4OeBysAfdxyS21tEVpFH/gXnDaCo=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bXBW+zjrj1XBX7VD/J/2fFqaKgPI0ZLasifqzNOz15y
 6rwdttJHaUsDGJcDLJiiiwqCyv4RD0+eEZOE+GCmcPKBDKEgYtTACbSuZWR4dG9bVPP8tVMWbs9
 dn5U9sKTc5trXfUUSuZ943n1UNFZkInhN6ug/rVFm/yn+qxev6HcKrc5VDko9GFu/Y6lCZ8uLOe
 w5wQA
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

For the skb, the timestamp is read from the header before the XDP
program runs, so XDP_PASS keeps it even if the program changes the
packet. XDP therefore works with rx timestamping enabled.

Add xmo_rx_timestamp so XDP programs can read the timestamp with
bpf_xdp_metadata_rx_timestamp(). It returns -ENODATA if timestamping
is not enabled or the device did not timestamp the packet. Install the
metadata ops also if only VIRTIO_NET_F_RX_TSTAMP is negotiated;
rx_hash returns -ENODATA then.

Like the hash, the timestamp is copied into struct virtnet_xdp_buff
before the program runs, so the callback still works after the program
changed the headroom with bpf_xdp_adjust_head() or
bpf_xdp_adjust_meta().

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/net/virtio_net.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 57b7c32625dfb..46be686e34b79 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -511,6 +511,7 @@ struct virtnet_xdp_buff {
 	struct xdp_buff xdp;
 	u32 hash_value;
 	u16 hash_report;
+	u64 tstamp;
 };
 
 static inline u32
@@ -1736,6 +1737,8 @@ static void virtnet_xdp_save_hdr(const struct virtnet_info *vi,
 		ctx->hash_value = 0;
 		ctx->hash_report = VIRTIO_NET_HASH_REPORT_NONE;
 	}
+
+	ctx->tstamp = virtnet_record_rx_tstamp(vi, xdp->data - vi->hdr_len);
 }
 
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
@@ -6896,8 +6899,21 @@ static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
 	return 0;
 }
 
+static int virtnet_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp)
+{
+	const struct virtnet_xdp_buff *ctx = (void *)_ctx;
+
+	/* 0: timestamping is off or the device did not timestamp the packet */
+	if (!ctx->tstamp)
+		return -ENODATA;
+
+	*timestamp = ctx->tstamp;
+	return 0;
+}
+
 static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
 	.xmo_rx_hash			= virtnet_xdp_rx_hash,
+	.xmo_rx_timestamp		= virtnet_xdp_rx_timestamp,
 };
 
 static int virtnet_probe(struct virtio_device *vdev)
@@ -7063,6 +7079,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
 	}
 
+	/* rx_hash returns -ENODATA without NETIF_F_RXHASH */
+	if (vi->rx_tstamp_supported)
+		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
+
 	if (vi->rx_tstamp_supported)
 		vi->hdr_len = offsetofend(struct virtio_net_common_hdr, tstamp);
 	else if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) ||

-- 
2.56.0

