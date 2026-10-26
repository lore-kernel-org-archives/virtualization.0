Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793003366;
	b=zZKDc+bJDQcj8PQ3MJO5D2v87Hcf1ahNgFDbimHLU8iI6Yhz6arLRG2AWZ7hMPTuwtga
	 kf5ABr8a9u9yKZbT0Q1UOVfu0SxUSEIT3VnpdPxegKY3/1nR8tpr+fS2SeIr4APifqrQH
	 1vV3H+te4KNnhUcpBcuYvgu4ynPU4EpYadkBLoYbSIh5SDXMth/EMCsG0pmRFYCFVRmwt
	 dKT207W632+xVSfiMki5exu1+yj3CiWE41PoKLjqTeBkMXPowIs27NDnGRm6CSgjSJnWi
	 KhuF8T0rVe3LBk0WC0ZNqKpw+J7jHoRsiZ3N6xxUVg6xG8RbXSZLgLlxNzQXi4TOsqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003366;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=KQlF6PoEcsNhxcyBiIGKVmyhgBC+BfLt7M/wlDsGWb0=;
	b=R7b5ldfkQdVXXdSy6bfkWKaZKJJBubVPCyRZfJuQLC4xWRWf+PHpsybt/irLLmbrQ9FK
	 zRyLb4oTbTndx7QilLqElMQagXgvi5aFMqLP+Vqzd30gpxECUsRJMPJYL2aexHOFvjmOT
	 H3ZxuSPHCE4C+u6X5IbWRo1Kpdhuty4mGsdL5nAaOPBeGMJt0dIEjX5t7T05YrS/13yCo
	 zGWpYe+N1BOsnfTSrcj76FqKrKn4KuxEy51uCS9W4qfafY5NKytOscGg72M4DZCaoyNFW
	 t0VehY7I7Y5MUIBo0a5uCWALDhLDRXFpsOeWnWD03fl1kIYaKKIuqtCkOZED7xRrGSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SbUVZ4Hs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E5606A31E
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 08:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 876E5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SbUVZ4Hs
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BBDF22019D1;
	Mon, 26 Oct 2026 09:29:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793003364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQlF6PoEcsNhxcyBiIGKVmyhgBC+BfLt7M/wlDsGWb0=;
	b=SbUVZ4HsLbi+mMsfNVfSsMzJSEORToKeymYd9A4Mp9lnTDdtVZ7oNSZgeNfJ1SJiutkn/k
	9oohnDQ9+8nuL6+EWDMoUNU3ahPf24xEHhLA8xsG632PZik7iZUpR89d0q6iC79PAWWnxv
	yITgIz3889wy92jt+ktZBdmTpxsPCMDnehg2mSEFt7sQQCl+SZ5jPh28GuYvYSfgkukLOl
	OxGo6NWtK3w2RaMSmdngqzJ1+M6Ogu/7AJJgX/vdmhASKWWVAQ9TRf1G442JzgHHelo9ol
	bEWF1rWnntqLYHi2fvpHr7TjJbP+7tRc6LucJ36dixKMTPUiFjtBLXZ45AlKDw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793003364; a=rsa-sha256;
	cv=none;
	b=Ku4MgVczwoceRwk2AuToIlanv22q7gN4iv0QokoLIbIC+oBZG2j2ytREVSX+/d+27Ff0T3
	tyTEvDZFV4ldTJsbXodX/GvJ3SOS44YIVJt117gh0fdNgYavCGrelQ4RN1g2u7aZrK0fWE
	ADGi8YisDq9gx5aDsIRcd+6E+0g8qkWFDMV1Zbjd9c6Yp3YbFuEbVTi+glxON0/bnssfY4
	ggaHh1kupF5owXSyCmiGnlyn9W73N2A/ksP6Qk0jbddf1lP2W2bnaYvaafcNMpADDLKv9D
	No0sCXE93gYcY91O6fjSCNymrrTJg6qoM4+9YzpJhW/nxTwxFT52bqEdg4AfTQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793003364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQlF6PoEcsNhxcyBiIGKVmyhgBC+BfLt7M/wlDsGWb0=;
	b=GtAptxFG/4LI3f21e8TmFz3QDm5/67jBenD1r8VK7uMKTro8fl8iwwBDHUxTvyVAa5d9Dw
	Cm4L+udyO1HnAPnfWDNxRSRd+qHCntII9AKKPiU9RgMJIaCTi2xWANcembt7NuwnRQ9qR1
	Lksuc+/Xdm8s/V2KGtQyO6RSVI5w5kng/3bEV+Mi2osPh0hEcyHHdHeBo3/B9oCyoj8c9O
	pJWXLWQYfJrprQyLbCLBiHyR3ofbpjduHiTtQGySpKMUQZUgNph3aaeuiXSDsFjSSMphxX
	Nz8qbCylLueSKYosQsnaKpzg5PxDnySlzaSSb8k5TxUaoJrcPiPJ7YjNYE/UYQ==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 26 Oct 2026 09:29:03 +0100
Subject: [PATCH RFC v4 3/6] virtio-net: assert header sizes
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
Message-Id: <20261026-v6-7-topic-virtio-net-ptp-v4-3-008af03cd43b@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=VNqggOE1Eks6kcVJq7bwJA4oYcZtrmSlslNSc9TyIn8=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9Z9/sQcmbdGF9M2T35eoL8zOKnmxppn+aUFQksOt05aa
 1Gz5fW0jlIWBjEuBlkxRRaVhRV8oh4fPCOniXDBzGFlAhnCwMUpABO5ZMfwTy3IId3osrfbO8t3
 lvolucquB2WNJl8Q+ZVyiPtQb3b/U4Y/XBW7Z6R6xWak7r/+/hrb/Y2R0QYNE2yN1vzecPP7vdo
 PvAA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

The header is cast from skb->cb and from device buffers, so its layout
must not change silently. Add static_asserts for the offset of tstamp,
the total size, the alignment, and that the header fits into skb->cb.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Assisted-by: Claude:claude-opus-5-5
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
2.52.0

