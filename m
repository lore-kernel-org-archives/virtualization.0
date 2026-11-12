Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482419;
	b=QZYSIVqPxbz++jjEV1fsYEj4SCjkv7FwLhTvansfCwCqw6r5CZRnp7AntKQuBbtIciIt
	 y2yqjrVBIBbQQHBxtZqrrAbypxl//K/EsjNDyBFeFi/3zvg8kfTs9LjrwNb+Ta/eBEEGA
	 FHxBpy2xlS02X29EDtJiPIx9dkQjtAeGOvuuZ3704LfwwUrs3dP/NPsvwogf4Pq8jC0gt
	 Y3NGovjDcrqdfLiGCUkwYIiqBtwcAS+KfWNQjbrJkW1ULQkH50IjKQvEqYrjYmeW4zbZF
	 JfW42sizHQunmHmLOnIWUD6wUsKApXGZXZKIxKejk9ukjfOhMeJlS/ph0guZXcIEn2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482419;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OMGD7uNF6jjvOLE5hh23egDWm1ccouQtG/HHFpHfkjI=;
	b=J3Ste0Yz13ApBTZOjM9vW/PHILlDHWSPRMJMvDMXuX4SEK/6SX69iMy89ESmiu2O8D79
	 Gh8Pd8ftvdhhJqXkeuORkFGjsVHs7SwOlkfDI2J0ViXaz5y7I6BZ7HMdjvTQ5Y0rn3+VA
	 hJDFqhV+wt0PdhvTab7ZEPUeAKAiqrc+c2iAO2IthAKzETeWxY0pP8E+AKkB98arZxFha
	 BZSJq7KZK8quMAUqb24O9x3jawC/eASAuzwfR+UzwcCyfemlJTe+i4OupsdyTigGB6HNO
	 S4Payuenrt7TXrsGifXDR6KxOcMLVDXfgPn1sS3d5Yz8RSnicgnFXl4W8mOwP8Fm53g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=WFx6oRWd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C385E60A2635
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 11:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C385E60A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=WFx6oRWd
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C421320583B;
	Thu, 12 Nov 2026 12:20:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMGD7uNF6jjvOLE5hh23egDWm1ccouQtG/HHFpHfkjI=;
	b=WFx6oRWdLPWbFhVlhNFrDKwI0SseM1hOgWE993LfLmOtlzQ0aohr+n2BLiyHf9PBTItNUY
	lhds3ATCSziusor6jpZpu5ZUGACiAvcvZRhSPMJBLvc9az2Tlq5qm6hsCoMCHsVnuL96Hr
	8l6nFF+ZkUvla1bxOe1VD0DQG80d/AoCm7Ye4h38nhArECvd9TVsdswCoVuLeLs2QoU6z2
	A3ZlDv8WOt/94d2er0dzJ2ziR4K0VYT7nzZ5Iv5Iw4Eht/m+I+OvDaoUeiEq6vOgn8bdNV
	0MEvUb9bLChYdVcj/XNOMnzrBS8GlBf3V0ta3QnIz6XsGkQfXILrKzOhEiBsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMGD7uNF6jjvOLE5hh23egDWm1ccouQtG/HHFpHfkjI=;
	b=YLoiE0eWQRDCGF3XEMBBsVUijw+luUrr9dfARbnK40hzeJ05BZWM/kgVVz1h35wcsx+e8L
	OZOUogJzcF64BIu+8OD+UagC8I57kDEGfM9Q6yU80VlMvbvxvi1bsuOQ2K5F3OSr/yPG2l
	MfwjKkzdX+Ls0pzBxhL6FzR7SeJ4VA7ydBwltzkcTWcYp6O9268F9tUT8kkJ8msYL1eR4M
	jcQ4mFuR57vHi/8ZczFSpQtGNY5PPrDI9a8+IgvqMsx51C8owkK+Tp0Xom+xq/9NibyA9T
	KA/WOMAZx0GnOG0uQ4qBXkYKBbzBiiIXJgdniIvY7/eVt46F1dWfwEOxXT6sxQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794482417; a=rsa-sha256;
	cv=none;
	b=Y8Nat9HYPprFPpoEsAL0DtIv+OM0GfwPjXNAEwSa3j/C50d2lPiILfUtbkhbjToou6ytTa
	+/D9wLc5mgR7b0gkaBBqfvfatCbLw4gE/tk7Cccm/gFYomO1dTvY+tsbLJZaklRYRRXEl2
	ufyk11VjoRFv+UqVmgY1LPs03xKFYIMY3+F/qPAR7JKII7qPay+pGMQKLVwxLNC7LZSm/Q
	sS77KqG6loTfqUFQ3KLQxig7i6+MSZJnMRn0//QOmXMm2ydecOYKBvv50fdeaoO9wnpbry
	4DBakMLFitVyPDf8jUc9dHfg0RGnZB6hUt7+NWm/uQsIj7bh0dyKUXZaTVtLeQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 12 Nov 2026 12:19:38 +0100
Subject: [PATCH net-next v5 6/9] virtio-net: assert header sizes
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
Message-Id: <20261112-v6-7-topic-virtio-net-ptp-v5-6-7ab67b572f4f@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1334;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=UCGplr/v9TmIbb5r7ucef4LV3SxkM/HbSDQ7Yt8TxiI=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bXBW+mzJkSvtVg/QGd/LMztpX/WulRxrLnX9KBfa039
 s2pYpBf01HKwiDGxSArpsiisrCCT9Tjg2fkNBEumDmsTCBDGLg4BWAivTqMDC8ZSptOynbqseRF
 TRaWiux7K2sS3nqErad4/mbVFMP5jgz/TN6v3vxg+cGF6/kl25f0WCsXrFn8+ILG7n9tRrd8G09
 NZwQA
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

The header is cast from skb->cb and from device buffers, so its layout
must not change silently. Add static_asserts for the offset of tstamp,
the total size, the alignment, and that the header fits into skb->cb.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 include/linux/virtio_net.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 2abd8a614a23f..e7776a37a486b 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -29,6 +29,17 @@ struct virtio_net_common_hdr {
 	__le16 tstamp[4];	/* le64 TAI receive time in ns, 0 if none */
 };
 
+/*
+ * The header is cast from skb->cb and from device buffers, the layout must not
+ * change silently.
+ */
+static_assert(offsetof(struct virtio_net_common_hdr, tstamp) == 32);
+static_assert(sizeof(struct virtio_net_common_hdr) ==
+	      offsetofend(struct virtio_net_common_hdr, tstamp));
+static_assert(__alignof__(struct virtio_net_common_hdr) == 2);
+/* virtio_net_common_hdr must fit into skb->cb */
+static_assert(sizeof(struct virtio_net_common_hdr) <= sizeof_field(struct sk_buff, cb));
+
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 {
 	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {

-- 
2.56.0

