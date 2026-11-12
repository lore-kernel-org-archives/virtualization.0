Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482417;
	b=HM+EzPFt923Db7yAVvyV0zOUI84/bRdlVA5pIDREMsLOzXCDjuEnkqvQyFV7xbQ6P1b5
	 Cq/2H/Q7aBFUD6WmlN+5LcBr/7UPXnMO3SYpzIGi1eX02mOki9wI80/ETwn4oYoT8KeLB
	 Zrwq+P+KC6c7KInV5zSP8y6j28W4PRDiXt/8uhtq6ADzQo3OF6ccAvAmCDdRbXHx+XTm5
	 qEKPrOlwmEcIlUvbeoXOsWyiK6ARZLEQKvASRLc+y5LDe45GDwTtXr1Z1yHrcJuEOxD2b
	 XNLvzAbW7VkJJGQo6p/oJgHHAMW7WqrDQUztOFObNsu6DxcJfkv8AyoLYm1mcbJvh7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482417;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jJEqc0txbFg3AnSKt6d/iAEvzG1LMYZ3me1fSJksIWg=;
	b=po6qyly3bNRmywvsrDgCy1AtyLzM8C5cQbxdtnqPYSyzTW2IxuNOM8Yfwo11R3UEAOta
	 MFdHKTarOhRfdwiY9Sd9hUN6tZIrtL3h18MFelpH+eT9b2CzuIzWF9RoIGyL28pbH3DRZ
	 aK/MOTLyOW7AmX6cf5SPDxEvvWL4ZuqDBU4/ULq989Jz4fQGoLB2Bq5OG4tpBEhuNCMNU
	 MlyIwfABoCXInvl4/wPpcJNMN2vafBz+69X8VfwKiBqK0sSlocRGxSjgq/E5RtpxbReBZ
	 Z37112qWQ25Uzn2d/RlY9+ZeH1NbYqODhwhmug85I/ArnPucffl9SHSkCNofgxROE9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NnVeavj3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770760A2635
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 11:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A770760A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NnVeavj3
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A4A7C202C24;
	Thu, 12 Nov 2026 12:20:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJEqc0txbFg3AnSKt6d/iAEvzG1LMYZ3me1fSJksIWg=;
	b=NnVeavj38hwC38y1nq5Uldp0BzR0qUg4EkbyoskrmKZ7CHOL2adE6yqhyzehAAd7gzT+hF
	mkKTSbW+EF5hPWnL7GjiW5NXXc1b02KH6QquiE2rpnrk5kvcSigH10dVa1Nii0Nq1WFTQS
	WdwAqnmCJnDQTkO7Qxi1UUDmqjOTabE6xVko2WWTYwev4h4904mpPv83RMmxpTdD7+wLqi
	79Lk3S/ND1Jj8m6Vq8BshwKUA6k5G/utnhO8UrqJ8JPjWkr/rp4cbxlHMaplsnrWTql7ZV
	xlpCfddHktd5c9g5E6Y6FTEDWy9w6yybdvLg/qDaH2AoWpsiayxeIQ1UnLudnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJEqc0txbFg3AnSKt6d/iAEvzG1LMYZ3me1fSJksIWg=;
	b=dI3K03otnt+mWSGe0F1nPtLp0U43phkPTtmfyEnd5STAXWbTwQG5R22LIwsrfZBO9qQCKO
	Nk8TXa4jYFsUzeWbNN6fBHYkS2V8c1swp32QdiFKAne1SjGfD+bhaDTuPFP2RiCxXtyjQ2
	7pQyWdkvWk5MPNEHOFMfGXQ1BN50h1xuPV0O1omeDcLQCK3t3XqGn3Byn/ueZStbvolzJC
	aOkusMmvZQ97R8on5EcK2ixd+CT5P+OJ3lzjUVsMHwyaSES8UeRG+pBrFefRBRZviIv12J
	/PgmG4VbB/T6nsNehdJlAkPFzzMDQ1wfqYIWM6q5EGBkxTpseUzEFhAFXMEzjA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794482415; a=rsa-sha256;
	cv=none;
	b=Rz55HEKURFkCDCb8juqBsGX0H5yhtoA+/UjETvqgyvSyW4NxoLfJIJRHHf6Lw/4/IA26ry
	N3APxXz1prof9cXx9Xz/2KonkQNiHP8VNdfTNNaXmYN2/0DI+3hs8BexKkW/S49c8/yUxK
	zqAw6TolS/AtwFQJ+jyegSDTK6O1iprqt4RRIZm80UCa0ic4tl61BIKAIm9N2uVHnhP1yI
	IP6YTyy+cBIYk2vdExBdjJQNW36rI40Uh2VBV/0KiqetQMWW0ZW631FC1+HjRhk1adqwQR
	2clxDzz4wTSm4s6oA888r8bPH/068fagfjBw3rZrg2P0npz+ZqRJjgnIoZUNVw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 12 Nov 2026 12:19:34 +0100
Subject: [PATCH net-next v5 2/9] virtio-net: zero the whole tx header
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
Message-Id: <20261112-v6-7-topic-virtio-net-ptp-v5-2-7ab67b572f4f@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=iebGne0EFwpiZlMyi8WaoLIyhzb1vtv6eJH2r4FE9fM=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bXBa8ZHSRr2TaJJB13uLI/Oe1l8MIP5RxXfpgaKLjk7
 U9Pk63sKGVhEONikBVTZFFZWMEn6vHBM3KaCBfMHFYmkCEMXJwCMJE5sgz/KxU/dQps/lGWf+L4
 fu1oc0eF91Y6HrFGLWcUbtrH/5qwiJHhpf33rl+LtV5WXwp8Gp42Izn0m8Ta2UYHFh7ZN118T8c
 mFgA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

xmit_skb() builds the virtio-net header either in skb->cb or in the
headroom in front of the packet. virtio_net_hdr_tnl_from_skb() only
clears struct virtio_net_hdr (10 bytes) and, for tunnel GSO, the hash
fields; num_buffers is cleared only with mergeable rx buffers. With a
larger negotiated header the remaining bytes go to the device as they
were in skb->cb or the headroom:

  - num_buffers with VIRTIO_F_VERSION_1 but without
    VIRTIO_NET_F_MRG_RXBUF (header size 12),
  - hash_value, hash_report and padding with
    VIRTIO_NET_F_HASH_REPORT (header size 20),
  - additionally outer_th_offset and inner_nh_offset for packets
    without tunnel GSO if a UDP tunnel GSO feature was negotiated
    (header size 24).

Clear the whole header before filling it in. This also covers
num_buffers, so drop the separate assignment.

The helpers still clear struct virtio_net_hdr and, for tunnel GSO, the
hash fields themselves; that is now redundant here, but they are
shared with tun, tap, af_packet and the UML vector driver and stay as
they are.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/net/virtio_net.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6fbe7..4c740b403ad1e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3326,14 +3326,16 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 	else
 		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
 
+	/* Fields the helper below does not fill in must not carry stale
+	 * skb->cb or headroom bytes to the device.
+	 */
+	memset(hdr, 0, hdr_len);
+
 	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
 					virtio_is_little_endian(vi->vdev), 0,
 					false, feature_hdrlen))
 		return -EPROTO;
 
-	if (vi->mergeable_rx_bufs)
-		hdr->hash_hdr.hdr.num_buffers = 0;
-
 	sg_init_table(sq->sg, skb_shinfo(skb)->nr_frags + (can_push ? 1 : 2));
 	if (can_push) {
 		__skb_push(skb, hdr_len);

-- 
2.56.0

