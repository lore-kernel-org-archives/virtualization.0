Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793003366;
	b=3zum0TowNJONVZZ+eRJLfJOF1z36RidX4GVXIRFqogG4iFu42NDBB1lDAFLJHmiBsecV
	 nr5p50meh2gTyv20chgVzFzq5QssImkVz2z6P1mUcLpqRjrMoZkoWzxmspxmQjJTi2L5O
	 YEGz9nb4WQHZ22rKDMLhB9KkodCfZivCIIO3kNXHH7RKJjL4//HOOJGchBJgK5AZZCvsc
	 qaMhc582H9LCRXIRKAgFHtj1i25e3ctfnHkmMvhmMZZbxXZAgdrsZFSum2Me79S8dWGS/
	 pMiD9n6B8ihzUyZoOZ6b7JXk5M3IMT9j505fU4SBFCD+tjsuxl9eLIbEwx6lKlrW1uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003366;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=J9bMC2JXJdHhNlivZ17H90LnRx8yIYx/tOvnM0y2Ydo=;
	b=2I5t0kIKj12xGfTmIPNGn+JZGDamrc5Fq3SrKB8qIWsT9n3Tx7PK/10vikncpFCSG0Q+
	 xv9Vh5EhNUvaKtHuPkJTwN1PinSj7rWJ7bRkLAPfYSVAkEFeG14k7Vb1A4VdqnaF15+z4
	 FmNAY0VbHCnQlsEXJbMK4VVYL1AG7LkR/BKV1V8NtwCoAFsRKpvBQGkuobDD2azS3c9P2
	 ddcgIYWCcgz9b8ZrD3YbKjBDn8Q3jDWWw4c0kJivPPAnO2ziZR0AXNryx2g9yU9mxfR/v
	 wNiNZj0xTFZTGY8FuZaIrwP856I0rqiHb5TcHggLMPTwv7MOLeDkdpCfC/wAsS7rniA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XGtIHxWW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB8606A324
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 08:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7EB8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XGtIHxWW
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CE6A120154A;
	Mon, 26 Oct 2026 09:29:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793003363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9bMC2JXJdHhNlivZ17H90LnRx8yIYx/tOvnM0y2Ydo=;
	b=XGtIHxWWmsdm5qBUCBNyHFpqh85GVQ0fbZrmFvRWwwFnLIJgnyB6nIlNW379Y6WLbUvs2j
	jiP6Ir+3+Y64qwMqyXT7u+SxTu+J3f5FUnz7tSK2abBYoU4YB1kTb0BpBOo1lEPwE+oW1i
	IItWtTpp4ISdbqYFiTjgyWntUPMr35ia8iMs6BAzhGaZXcAogxXWNb6CVg8yN+o35tTFeC
	bSfVBJc/8gTWtoH2/K8ifTtGx6FzxOknAPTuCsGFhogcfB/NLWFMBVOU1gt77te5ABfceb
	kcLMh++1DMCt+XkVF1A8YSfY1eSO5ZLKYPwvky7F4tdvUJjlnYQ5XNG6meze6Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793003363; a=rsa-sha256;
	cv=none;
	b=Tmbah0ru6d77gv9yvsklHy2LJ54I+DTgFZ6HgT5xJD8jx0C0nhSPoXMCHJuG7/1Uj6OCC4
	lfx+Fr4U4IJWPYLia5vf6BRP+V7UYYavr3CiAUm9CB5+JSimDENYSOev008J7ENS8aVjnz
	ozrGEtLZHzJn+zWsM/QEmjMD9WC6NIpYf5yfxLgUFIMxpb/Tp5ax4q0WtZ6wwtozYSuMtu
	SZzC+fzR6srYP7xBcZamC7sMDzM3Rk+KsNUp0cYCa1SjenGh5FkuBnoHO+IHmNGtj1uq6w
	pD+qn6x0wRiSr/ERrcUhA+zkjyffOtYLjAzMmr1uW9GIU4tMhnDfmmUc3sOFHA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793003363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9bMC2JXJdHhNlivZ17H90LnRx8yIYx/tOvnM0y2Ydo=;
	b=KE1mswsBOPj5Bv7k1ghe/ZD7SnJ3HLuA0w0OAsh8qq2wNqcSnfLKD4rX9/xm5oKcW/2BU0
	+4YsShdJXP1LDWn+0xkFHxT60tGd0Jcp8JXli+lpyvCtu5ejtw7YqWSD99Q0hTWzYqCyxT
	I0ZRJ2haE5XDA/knfT/VP3R/PX1DTwqdcDj2MCdQfBUbZ6W7j3VP0hcoM7hzwcyjG/csqZ
	Pj50RiiLbkUZN5UZjjV+chYmovJ+9znOL4D+73KxMkts27tNrSBBI2kLoQNIInzGZtXSfB
	iUTqJjRnNpc1ioJl2cFSEvtBOKBZtsX2Y2yUB7g9hZLffeAciISH5qFBwluMzQ==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 26 Oct 2026 09:29:01 +0100
Subject: [PATCH RFC v4 1/6] virtio-net: move virtio_net_common_hdr to
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
Message-Id: <20261026-v6-7-topic-virtio-net-ptp-v4-1-008af03cd43b@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=YPEGObAtm5jMMsT7YJ+7C5++HnFr5unwD6moD0fXr9c=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9Z9/oSJibtyyiY9c08Lvjzr3SSehO3vxfoXWMp8+ZRq+
 Uvi2LWfHaUsDGJcDLJiiiwqCyv4RD0+eEZOE+GCmcPKBDKEgYtTACayZB4jw+5wPpMMjYULJj92
 UdfYIqlx3CrM5BSL/7PHZgXbA11PzWRk2Kshezm7LiP9EQdPrfwJ87lb2oK/8h81+hw0P/zL2xc
 l7AA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

tun and vhost need to know the layout and size of the virtio-net
header as the driver uses it, e.g. to fill in fields behind
virtio_net_hdr_v1_hash_tunnel. Move struct virtio_net_common_hdr to
the kernel-internal header that they include already.

No functional change.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Assisted-by: Claude:claude-opus-5-5
---
 drivers/net/virtio_net.c   | 9 ---------
 include/linux/virtio_net.h | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index daab43ac92ce4..17d3e32eed9d6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -492,15 +492,6 @@ struct padded_vnet_hdr {
 	char padding[12];
 };
 
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
2.52.0

