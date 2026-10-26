Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793003373;
	b=H5yC5Y8d7g/zZ7IupRQGBNedg0rvFxUMr4D540cMtY0S9Dri8twafCXt+HsxlD1eydnZ
	 I5+Y3EyOLlpcwapy8BTBNNT6P3Dv7nYH/+m8zKPsQaEFzmxJj4ufdCUWEYZnHvpvGcQdj
	 etipDzsByEFST05WG7RThf4WBgV5suVRHembJTidFv5xpCb6SG14X0sD/2eZlDSk77dG2
	 c950vHYWpV0Og3XcbftewWXGrbalMWtFgEjyESui8n2+3j1Ty62V63V9iPxhWMi91XR/M
	 mZHQ2mIa8DuesouSsjjjJ+nIQsE52+oKYhr5RbIn77vBlDuvS4/703SXYhZxkin0sXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003373;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8CEwU6AVVLUrN8syM2T/p6MeATp6WE5o4yWux7VIDNA=;
	b=mKq/ECyL2Ovc6LaxabYbhDn8Judf2mldvPqZeYbONfEWPvUQ2qMnUAuv7ZeIbC3Fg4Ll
	 GGo05Xr7Dp9F2oO3kXvm/jET03ADOOhIc2pOEzT5/Qv80CUKm5tlbcWVNsjVbBU1jBucv
	 SlR4Gxy3frcXv/UnINHLx5HAeEKEsGUqdEaR7suQFn/2Cq2TQFmloOOzz3vBOhPiMQQbI
	 V33Go2bcuoEVCosLd7JeEmTrVNYXsQK7aSMRyiilAR1pmpr/ffgoE2pWMgBrcRLqnjezz
	 XaWA7Gi/gkoAjZFimyNamsHn3owyo1dlRV6lCY3WfBtlvrss6keaf90Q4Ok9IlHcQHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZgdWQvgn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E034606A328
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 08:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E034606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZgdWQvgn
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 214F8201E09;
	Mon, 26 Oct 2026 09:29:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793003365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CEwU6AVVLUrN8syM2T/p6MeATp6WE5o4yWux7VIDNA=;
	b=ZgdWQvgnRbGbDbNyi+7fVkSkj30ZlQbaV4WnR0J/D9kZBfvyk2v08VL+wEv5siR6l93TQ8
	rbrDvhyamJQGrYAq1Dll1RMazCTRTwdOn7E2tv1ymBJtfphiGF53rO3Z3+Daqpi1JwQFDo
	lgiWDurSOlJg401zE2zbjJmZaUiRTFfFa7jgLWYegzXcsRilY7AiXGsfL8jpnhn1AITZaQ
	G3qbE0BLfc31MxyxQXdDlj65/nbTNydPTpcGjPM1yIHGzW0NZSoTkaaoV0WfV9tpUBUu1k
	G/ActxEJrnRaEbvgPeySYEsa42/eR3XYbjDDSctPqmkC6gfZnuNnNyAhnMg1mw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793003365; a=rsa-sha256;
	cv=none;
	b=V/2Jd+FRb2gDbajd+XqLv1olN4WP17zV1T/4hLwRE5wwdE1lhQo452k3HTxsbz+D+6SYeS
	S4mG/G6enRqJ0GmqQhTlpknnT1yBpk6253yhpahjJMwVx33Zh1e1sgcL/7gGwdMqVfzlcv
	YBm+V93iImbhljnPGb+NQxwuA2xT29fL2PV5Pa13ewbgrQzMQ2eoEuw9iWM9gUit//Jclp
	XmHzoE0hmb16sHzK/FWxYni9ZGSZW8b6UYwS8nh5qG8nCYJulmtc7SF5CWmsV9nL5sWlPy
	Yb5zzRqdfIjUaHCSjoddK8dFLJdwqGZDCgmPj/fBovJ7TRXkh8Kdt7HQ8ZP8xQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793003365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CEwU6AVVLUrN8syM2T/p6MeATp6WE5o4yWux7VIDNA=;
	b=Mut1e86Y7UcJ3aTKy+R2SoF4OTyC6vPpbee5Hq5cEQT7MSgXxrpOKGZG/c6DaphckDK0iW
	Ud7RiHnv61ybMPE7EbQxlPe27+AClM3CKoM0boLUM/m957wblYSQOEritpf0k5tZCbgRBB
	rte6ndk1E9RbiLKs7aH5ldT7p6TiUZXiwG8ftwAJppPBMpyoS0xFnVl8Daxt6QIldD+iL9
	vzIGayKhwHmIXWzzsK9IwT9iLuV+eUVMhwbRzbCNiusNnrOOancxEA1Xi14ktPAvv052TZ
	T62k4qKT+MS0gQc/Uk1sEIUeSIvwWgifF75AEmq9Pop6tZ6bqsjLJMoQzaYQdg==
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 26 Oct 2026 09:29:06 +0100
Subject: [PATCH RFC v4 6/6] tun: add rx timestamp to the vnet header
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
Message-Id: <20261026-v6-7-topic-virtio-net-ptp-v4-6-008af03cd43b@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3856;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=UF0DDam13NecUshEazoA59/3GN4tkViJoDxQqx4ifAg=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9Z9/qS6RRnBX5gStr/RDi6UrGeUnhZ0q5qFUXyKs2Kjk
 fnhI886SlkYxLgYZMUUWVQWVvCJenzwjJwmwgUzh5UJZAgDF6cATOTYDob/Pmf/v3g478vlf4zF
 x2M3Kmz+IHF+qmOP6If/0UZc96u95Bn+pz3M7RDc9jQz6JTYFpfVp7/EJP/Jl5zSld18Vs41Lqq
 SAQA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Reference implementation of the device side of VIRTIO_NET_F_RX_TSTAMP: if
the configured vnet_hdr_sz covers the tstamp field, write the current
TAI time into the header when a packet is handed to userspace or vhost.
__tun_vnet_hdr_put() now takes the full struct virtio_net_common_hdr
and copies as much of it as vnet_hdr_sz holds.

This is not intended to be merged. A full test needs a QEMU that knows
the feature and sets the matching vnet_hdr_sz in
virtio_net_set_mrg_rx_bufs(); see
https://github.com/strumtrar/qemu/tree/v11.0.1/virtio-rx-stamps

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Assisted-by: Claude:claude-opus-5-5
---
 drivers/net/tun.c      | 14 +++++++++-----
 drivers/net/tun_vnet.h | 18 ++++++++++++------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 242899f7fd071..67699f9fc3d3d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -57,6 +57,7 @@
 #include <linux/math.h>
 #include <linux/nsproxy.h>
 #include <linux/virtio_net.h>
+#include <linux/unaligned.h>
 #include <linux/rcupdate.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
@@ -2160,12 +2161,16 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	}
 
 	if (vnet_hdr_sz) {
-		struct virtio_net_hdr_v1_hash_tunnel hdr;
-		struct virtio_net_hdr *gso;
+		struct virtio_net_common_hdr hdr;
 
 		memset(&hdr, 0, sizeof(hdr));
+
+		/* The configured header covers the tstamp field */
+		if (vnet_hdr_sz >= offsetofend(struct virtio_net_common_hdr, tstamp))
+			put_unaligned_le64(ktime_get_clocktai_ns(), hdr.tstamp);
+
 		ret = tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,
-						&hdr);
+						&hdr.tnl_hdr);
 		if (ret)
 			return ret;
 
@@ -2173,9 +2178,8 @@ static ssize_t tun_put_user(struct tun_struct *tun,
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
index f4c652b1fa44d..d4cc56dac98d6 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -153,19 +153,21 @@ static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
 	return __tun_vnet_hdr_get(sz, flags, 0, from, hdr);
 }
 
+/* hdr is fully initialized, copy as much of it as the configured size holds */
 static inline int __tun_vnet_hdr_put(int sz, netdev_features_t features,
 				     struct iov_iter *iter,
-				     const struct virtio_net_hdr *hdr)
+				     const struct virtio_net_common_hdr *hdr)
 {
-	unsigned int parsed_size = tun_vnet_parse_size(features);
+	unsigned int put_size = min_t(unsigned int, sizeof(*hdr), sz);
 
-	if (unlikely(iov_iter_count(iter) < sz))
+	if (unlikely(iov_iter_count(iter) < sz ||
+		     sz < tun_vnet_parse_size(features)))
 		return -EINVAL;
 
-	if (unlikely(copy_to_iter(hdr, parsed_size, iter) != parsed_size))
+	if (unlikely(copy_to_iter(hdr, put_size, iter) != put_size))
 		return -EFAULT;
 
-	if (iov_iter_zero(sz - parsed_size, iter) != sz - parsed_size)
+	if (iov_iter_zero(sz - put_size, iter) != sz - put_size)
 		return -EFAULT;
 
 	return 0;
@@ -174,7 +176,11 @@ static inline int __tun_vnet_hdr_put(int sz, netdev_features_t features,
 static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
 				   const struct virtio_net_hdr *hdr)
 {
-	return __tun_vnet_hdr_put(sz, 0, iter, hdr);
+	struct virtio_net_common_hdr common_hdr = {};
+
+	common_hdr.hdr = *hdr;
+
+	return __tun_vnet_hdr_put(sz, 0, iter, &common_hdr);
 }
 
 static inline int tun_vnet_hdr_to_skb(unsigned int flags, struct sk_buff *skb,

-- 
2.52.0

