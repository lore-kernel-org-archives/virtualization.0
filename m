Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793003366;
	b=NHIoGf4MgxoVvwwxlVZNHqC7bFfmwT8CGISKrL25KBv1uQZtHOGJ7e7CLz+jXt4o2y24
	 EXedXkEYsochRCAXL/kVhJXJW6Ziyx7/Abz6/5d+/a1nKuzyASQe7k1uV/F+kJMh9RDwY
	 oDpYZPKmpgYPAtqEaCqOXAD+J/EuMUUY+wMnL9nrWTfLa9PvDKgFj1JcwJrNRFSIvGbQg
	 tE+N0BCPUTuU0CuBKgwCqxrXMfqUR6lqbWkxRNmBTyPp7ys7eZswE+QP+SPiLsiyJAhID
	 31za/K9ttoS8ErwbmSw3NsQsXH0vw0jVmA75/Oob+n5pYdH0cFGze55UkM+8Aacjopw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003366;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=SxPxwtKVo1NNAkpo6AEjFX1CwNaGv1grF35o4s4xQy0=;
	b=ywCSBO5+hQ3VwjoKktXfFa7j1QyOuXqeiY4/gHb6Giujb+24S0CSML/9c9y30yOfVgMT
	 C+tYDxjSyuU8d4u3lGBzx/N8Q5g80Sms762UefYhx0/QwpQAQKvpodEgcupeeIuYnz+nr
	 gtA1xOhlPAa1RxAuSyyJRB3UTz+dBupgSt342PVGRGISw41dbRrelFOcqNkNEhzTEINz8
	 ByFG6By4Ig/+fkTq2X/PbzfK2uLkfEBpx7TK0Pep0iNZI7OHB9j/Li9x/U1RSpA+TMAQv
	 Dsg0Hek+6HW9jNwqvmxYq0QwOU+Rnl6yhaRdluEN0oKSqiK6LXpx2UJnIm52caXTJLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=P7RHyocg;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4BB606A320
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 08:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C4BB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=P7RHyocg
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3617F201B9F;
	Mon, 26 Oct 2026 09:29:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793003364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxPxwtKVo1NNAkpo6AEjFX1CwNaGv1grF35o4s4xQy0=;
	b=P7RHyocgMwwrJ6qLz4KmuDGZbu59I1VCldPxCcZby/eEjWTheo6ae6N6+L/oQFepbjvi+f
	NbTREo1Vni/ndNTfeZxmoCnbbBe3hfkB+0dDURr96ZdfJxwHZ3Pj1KBnadqVVWven136jU
	pmpTIxAoxRfDoKQ5Q4NGWjEYMzzU9xeIpg44n2H2BqZ7flgy2+mTwQkPOMHFypRCrdaDRQ
	ynvb3IwlNDmbw853E+zoQT+oXvuehYk2mH1qwiNwXU4/1/z6BoM8o3La/V8oTuoMLsWxsi
	xO9LrVCH2abqVsHgxn0FKHmIQar3218pAvSK0K9r/T8ozOwuAc12ik43+MURBg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793003364; a=rsa-sha256;
	cv=none;
	b=GgHPqldAOKR8DqgiELRl9CBNQSzCx3z+fVcHe70Lby2+mUkvFyX9tSmXLfufV27N4TZYkJ
	mPZ1ryhHV4UnxFxvyeZK51mqVkOpbifSN9lsBMq80mg/MtpZCf/8GnLVsj1iStdG5IX7d6
	nomxZYLIxAl8wPr8+bOR7y1V4Q3plyWXP7clP04xlrqZVhdUDJfsxyS5syq17xgkz3jsKA
	aiiElmNFIrHkOaBqRoR8xQwiSe4J/sZqNfs24lvPSAZkU+5UMYUtIsSIPq2g0EN5lkI9Y8
	X7JVaFV/F1AvxZIvH+rZFKLPY1fzztmxuiHts7I+bW+RGmFAeCPT9Rp1CZAXVQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793003364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SxPxwtKVo1NNAkpo6AEjFX1CwNaGv1grF35o4s4xQy0=;
	b=f1kWmWdCBZMr4FIfRElIwV2ZwAFyX8EL3y+h+NcAKKWk9EPS15KH5XMMglz4HtVa+DN59h
	InzdFTzXiIEs8ppxdjVEt3bg0yzVNuyV90jclu0BxiJ3XTGIQeKlrk+nGUbUZRIiqdif/w
	yyG1ajPHLYRtt6ufiAdv4KCAgllH2nalDYHaf6UwEslD1OZt4LOeMrdWLHLqnMWJzVBL7q
	vwB7zn3O3WDVBYP4dGm0/qpS4J6np11Igf8zzAri073VYH1gQYMUD3qpCGEb+xunyUKrs9
	ympMA3XblKiaSuYNwh5D39wwsLXRg0Vj7GYHlRgMICvTbafqYkXsb6VMuooz4Q==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 26 Oct 2026 09:29:04 +0100
Subject: [PATCH RFC v4 4/6] vhost-net: support VIRTIO_NET_F_RX_TSTAMP
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
Message-Id: <20261026-v6-7-topic-virtio-net-ptp-v4-4-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
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
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kvm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2289;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=lebGyyUSFv+ztwjuRIxmRf3hzBJF94KNRyxQcoHneDw=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9Z9/sTLx0z1pFSuc1vYeL/zyFo8S22PopDmMi6RE7myT
 abvHeM7SlkYxLgYZMUUWVQWVvCJenzwjJwmwgUzh5UJZAgDF6cATES1luF/1amCxccVph2x4Knx
 fGh0bpbLigzWty3f+VxNzhy5baKYwshwuXqhT9s1sw1PZCU/TzVy7ZVf72mVb/emOYrj9aQNCkv
 YAA==
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Advertise VIRTIO_NET_F_RX_TSTAMP to userspace and size the vnet header
for it, so a guest can negotiate the feature with a vhost-net backed
tap device.

The header is 40 bytes if the feature is negotiated. Whoever writes
the header (tun, or vhost itself with VHOST_NET_F_VIRTIO_NET_HDR) has
to fill in the timestamp; vhost only reserves the room. If vhost
writes the header, it zeroes everything behind num_buffers, so the
timestamp is 0, which the guest ignores.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Assisted-by: Claude:claude-opus-5-5
---
 drivers/vhost/net.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 2cc730729e08a..2a38ad0ea1af2 100644
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
@@ -1282,6 +1283,16 @@ static void handle_rx(struct vhost_net *net)
 			vhost_discard_vq_desc(vq, headcount, ndesc);
 			goto out;
 		}
+		/* Zero the rest of a header supplied by vhost, e.g. tstamp */
+		if (unlikely(vhost_hlen > sizeof(hdr) + sizeof(num_buffers))) {
+			size_t rest = vhost_hlen - sizeof(hdr) - sizeof(num_buffers);
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
@@ -1688,6 +1699,10 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
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
2.52.0

