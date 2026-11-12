Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482420;
	b=XZqKK0jCLfTQLrU08FRJs+OQl44YoX6iSnHTqlgNIuDfatObX3OZYctz1Skfa3XH1uz1
	 7++uXo5kIw+Li/HvZrPmf88QhoRaWHii7JZc7Zq/HfcvHMZ0SmoBMZLXPRumUD0/neeAt
	 PiXB6wtPk5RxOL9qBSB15b+I57n//80SmkYnyFkgFJvev6XycZD/nGRVDjLA/7RwoHNzO
	 qTObslDs8y+TMGoyYSfP6nzJZYAPg4oznxW8tQ0kXJd06EvrduFhjp1dIiV/UO8m87jLb
	 g9lrmfB9E2CBdslrUK8SZ3XgGWnlu72kotjQbRSUxWJkA4s/b3nEQ9E5/CyliUY+A5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482420;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=m36al0+4iVX7mIEwm1TNnxEJqBCQUyFbjtZhiSN+ckg=;
	b=EDGIs64o5DbWx0eX6hDGSFiUN5j5m471UvxaPVljS1DkFK/xsL7HYHdFPSC2NxD6sGOm
	 fHgn1bSlwKg1LUzOEnvGhtzmfN/lPqhpiCNmyVYk5sw34qZKzquYDc9wWCOLVJNG7PAwl
	 2MT+WjVcdROwcb3T6ND//ZclRLm+84CEeAnSmkJ04mR3PIO8VPgZ0OGpMuSb/770N0Oe9
	 s0Cyb5M6XXWgKGOJ89tCS/XnAxQjgpLBmyKfLBoMnrOW+vnYnqYe88XsX7D+DBVX1jjBg
	 49rMdgY7T+VKQatRv2CsocndoeS2pyChEaaJSas6zP3asxd+BCemslVcKpsw9JsWYsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=fZVvZasw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F35960728FA
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 11:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F35960728FA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=fZVvZasw
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5C84B2058D6;
	Thu, 12 Nov 2026 12:20:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m36al0+4iVX7mIEwm1TNnxEJqBCQUyFbjtZhiSN+ckg=;
	b=fZVvZaswqX/e6CLJC7uWofURD9U8dQJwEYQKTIx7HB2qKEzJx2MIatfZes3KV8Ah0bbUTp
	2QZQdXeJZBsOWtwhUFfIoPgvDRy9u1lWqnx+fK0tqLN1PzOl9iEC77cfX29DtJanFdioKt
	yF84Eev/q4welquakTQg3KjYH2Pmc99uCvKOOqgwiWOtX4dxPJRkuohmSHZ1XJtYWdsFfp
	Z6SwSDztsaObf5b0HSM9sOWrZtcaCYpEgLACE6hl/yUScMTadfFdL3qX7evCkwR84ujEd8
	Nn0wcvHrqWaLb5TgyGsSatgkzi406Af9izYxpPF0EOzCVISBGju7MjSVW6qsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m36al0+4iVX7mIEwm1TNnxEJqBCQUyFbjtZhiSN+ckg=;
	b=JR4N1y1VOXzk+xY3eqNoJN5wykqRiZVIkCcJqo6yg/QYvcaSP8PDQ78RelNk5g729iIyI5
	h/JJpIE5qtCNBwBT0IANEVb+L89Ha0AV/xXBZbe8Y3/H/dw6IxRs9/9EOMSsPEHd0TgToh
	FWd0CobhUwEfAWAgDG4HXB482Q5XB4vS7uPMQmnnLhdzrI9ylWF5bGknYOKH6pLq8azjqe
	gZTqJmzCTjR4JBik/5lu77n7xyDv9hvP4OmQkZIDS7ngOU6MHKICYgHd0vGUJKGZhynW0D
	y7HzDbrm1PxSCobB9hf1CDc3HbdNW0M/gGi5AXDG3KIsP0i61bzX/nrALmyZfg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794482418; a=rsa-sha256;
	cv=none;
	b=GhNmj5zDzqmRnaGVHwxwQOnpXoqs1m1KDkMSwz+gOvICdZ04Val+rbjCYVx9lq+orOv7rj
	fnbhlFxcsTRcWbP7y40qi2YBBspNIOLniCjKL6eW0o+J2Mo4DegbIYgvRqM2QlYeoZAn2q
	pdXBZhPeCRrZRNkmKPL038Z2WScrFPhxNJNtI+CbJOYTNBWbmPS260a56zu2fJKs9fJ8Qy
	68i0R2GH2vh/9sfG/VwUXERT4xU3p+qf24WI+VEHWgjomwv7BhnXKnPYAntMuEhAUkJOxs
	BodPMzw6WzQhApnBklSdz/G3/Beez1X5UDem27+YyDnBfz3//aJmXobyklXq6g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 12 Nov 2026 12:19:41 +0100
Subject: [PATCH net-next v5 9/9] tun: add rx timestamp to the vnet header
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
Message-Id: <20261112-v6-7-topic-virtio-net-ptp-v5-9-7ab67b572f4f@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3819;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=sHvGg59eOg5DQGGBFOkvl7QZBIqLz3Bc5qdr7aC+s+s=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bXBW8PNkjN/GYjuZ79qeOeFw0GZbWWVaEvM/svGaqsr
 z/Ld727o5SFQYyLQVZMkUVlYQWfqMcHz8hpIlwwc1iZQIYwcHEKwEQ2WzP8jzXfqFD9w4BVaHLW
 9U/6f5Kslczcjm9yfTFhxo+8fya3mhj+e9Tpan4UN2FVUKhasWXF1YeKOnppIRK7SqfJsa+Y1nu
 XHQA=
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
---
 drivers/net/tun.c      | 14 +++++++++-----
 drivers/net/tun_vnet.h | 18 ++++++++++++------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 8920c797acfd7..1a8c3377753d7 100644
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
@@ -2168,12 +2169,16 @@ static ssize_t tun_put_user(struct tun_struct *tun,
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
 
@@ -2181,9 +2186,8 @@ static ssize_t tun_put_user(struct tun_struct *tun,
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
2.56.0

