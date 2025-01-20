Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0FA1E0DCF
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363712; cv=none; b=qO5dVCmuXI5uvH2VL4iCnOCgjpuRuNzT848btCtDO9V2D33kUFJIB/OrnegcG9Dy6O2Z4yT+qG6Wsqwch2X13bYAMe6MD2kLnskggEZbyVBjYP7RGD71bATczEuX6r754XHKfLFNT60AWoH1Cw1oZJWO3E7DY6vb6qpFBsRGj2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363712; c=relaxed/simple;
	bh=4RYDeWZfgoS8TmhgeuK6a+3aCbA0s+NHcJ7l9i6jOAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=DhkD043zqTqdn6BeFscfjrPW2y75LTbbNXfSEHfHcEXhjyW6RYNsiRh9rB9FFiwqQ5FsBKTEi7LL3Pfmr7FFbaPmswG22wLZ8CucVKbQ9aX5e/o0wGU68NHNm623sseLnyRq0fT/C1yBkgYSPjI/JipDwODfq66WUpyYpd7pJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=CUaP0jLD; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="CUaP0jLD"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 19D8C409A6
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:01:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0FeH74FjQF75 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 09:01:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DE157405BC
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE157405BC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=CUaP0jLD
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DE157405BC
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:01:49 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso7327617a91.0
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 01:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737363709; x=1737968509; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYG55sKWzGPW6NKcxch300rRfr6veN46k3Y03F9gCrE=;
        b=CUaP0jLDtAdN8SsMRs4KbYbVnPvWLkylXbqmdWKJ7gOvsep6P4iA89GZxj7lixMiSp
         NCCDhwG5VA9E4qZjnAuMw8TbyvzHwqxM2Q0MuGXayEPdPJxgLOgwtY4tN3n+yWzHXBFU
         RZoEkSULEGqhTsf3XGoDALRjVcODsMiRHSKNrzcUulNnPrAb8We2kyUL7RmOrKbiaQFl
         u9XXq6dRdv04j6Adjm/8ryTKWQkYEIbsS4JBSkdoRaJX/mHbkdIbbrmfjGJgQH7vgUUx
         kuVxuwmBRm6G0Knfd99smnAkbZir5bExQCPYnorHA3DonxbNEp2Pl9Uk8ft6NX4qd4sz
         IJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363709; x=1737968509;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYG55sKWzGPW6NKcxch300rRfr6veN46k3Y03F9gCrE=;
        b=h3zMyzEiJLN0BfVNrr6/cL8jWla0aSVxHdOyVOCyKHGFaOH/Uw39AZkcQCETpDVc5N
         Dkuu1fk4dJZB/BHh3eXK1JYrH51hAP/xKnzsXWQVVNgzroEZev+tAajoG2pRW+GtGDOG
         +/08QWF8M8LZfSbvIpuotqVgvCECAnyC+5XQlHF6zu5e71GrwKZI2cP2zjk3p4MkncI7
         bn2V1x+Iav/1ZxjMNcpHchyXo2oK2KChrrY6vJTDHffqpvWA8gR6hF3mwMdm1X+PUXyR
         YQdj42+cb3q5inUKDE+JWR0QcvciUijgbPmoUC1GoTG63a0rgSUtP/czAYTyXSImvxy5
         jNHA==
X-Forwarded-Encrypted: i=1; AJvYcCUvVY5/ZV+lnenrQMEVKNDBF8pe1kZqebaQDbVbHdhFcI5VL60oRDlCuiBgDbwDTR5MCTFD3+GzOshjsnQJCg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz1avbq79e2t9IUsAQiIVbzqG6c6A/EBvpS0Btc86mPiH/a6xT8
	XwlWAPEmPRfOQs7zQAb6pDY7v6JpLZek16/oIZEbkpzKp8Zqe0Ayw3Z/i2+c+9g=
X-Gm-Gg: ASbGncuWrZ1ZLOkHhdMH84SZaNNZn3Rt9ivoMSrnS71Eeul5OSDtkn2MVTwAJMoOWCj
	16ur5WD0ZfCs/q1jKwppQ+vEpCf+GPp/D3AxUw+IQZ8ji33okGipRMoidQnb1bvSaKGXRt5L1QU
	rOAcLKgPWepmBpz+RqR3n/cYIZJKQxT+RFVzWbnjNgsts3/l21xY8G6IPfzPD6XCggC9ToaTl8f
	hhtGquwaKBmiYNqZLtUpy8+PDLKtrF+QqFlQ7M1Pv/ESAPsGr+YTOV5t0cGeoyHsHROd3br
X-Google-Smtp-Source: AGHT+IH7uaHJ3ZKJFT5wyFQIBOmBXF2rLZqZWTmgA1OioMPJBHsnSIzsBmwU8qLRFmmzM8vdbtQ0pg==
X-Received: by 2002:a17:90b:274a:b0:2ee:5edc:489 with SMTP id 98e67ed59e1d1-2f782d4ed92mr15866201a91.26.1737363709235;
        Mon, 20 Jan 2025 01:01:49 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f77611d5d1sm7830173a91.4.2025.01.20.01.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 01:01:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 20 Jan 2025 18:00:18 +0900
Subject: [PATCH net-next v4 9/9] tap: Use tun's vnet-related code
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-tun-v4-9-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
In-Reply-To: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

tun and tap implements the same vnet-related features so reuse the code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/Kconfig |   1 +
 drivers/net/tap.c   | 152 ++++++----------------------------------------------
 2 files changed, 16 insertions(+), 137 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 924bf61f12a49566b26a78f42cea5ca1c48537c5..f8aa35bf8a93ac1c7f76b85919ac110cb06f21fb 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -421,6 +421,7 @@ config TUN
 
 config TAP
 	tristate
+	select TUN_VNET
 	help
 	  This option is selected by any driver implementing tap user space
 	  interface for a virtual interface to re-use core tap functionality.
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 7ee2e9ee2a89fd539b087496b92d2f6198266f44..4f3cc3b2e3c6fb387ee2aaeef54c3faf39d90f10 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -26,74 +26,9 @@
 #include <linux/virtio_net.h>
 #include <linux/skb_array.h>
 
-#define TAP_IFFEATURES (IFF_VNET_HDR | IFF_MULTI_QUEUE)
-
-#define TAP_VNET_LE 0x80000000
-#define TAP_VNET_BE 0x40000000
-
-#ifdef CONFIG_TUN_VNET_CROSS_LE
-static inline bool tap_legacy_is_little_endian(struct tap_queue *q)
-{
-	return q->flags & TAP_VNET_BE ? false :
-		virtio_legacy_is_little_endian();
-}
-
-static long tap_get_vnet_be(struct tap_queue *q, int __user *sp)
-{
-	int s = !!(q->flags & TAP_VNET_BE);
-
-	if (put_user(s, sp))
-		return -EFAULT;
-
-	return 0;
-}
-
-static long tap_set_vnet_be(struct tap_queue *q, int __user *sp)
-{
-	int s;
-
-	if (get_user(s, sp))
-		return -EFAULT;
-
-	if (s)
-		q->flags |= TAP_VNET_BE;
-	else
-		q->flags &= ~TAP_VNET_BE;
-
-	return 0;
-}
-#else
-static inline bool tap_legacy_is_little_endian(struct tap_queue *q)
-{
-	return virtio_legacy_is_little_endian();
-}
-
-static long tap_get_vnet_be(struct tap_queue *q, int __user *argp)
-{
-	return -EINVAL;
-}
-
-static long tap_set_vnet_be(struct tap_queue *q, int __user *argp)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_TUN_VNET_CROSS_LE */
-
-static inline bool tap_is_little_endian(struct tap_queue *q)
-{
-	return q->flags & TAP_VNET_LE ||
-		tap_legacy_is_little_endian(q);
-}
-
-static inline u16 tap16_to_cpu(struct tap_queue *q, __virtio16 val)
-{
-	return __virtio16_to_cpu(tap_is_little_endian(q), val);
-}
+#include "tun_vnet.h"
 
-static inline __virtio16 cpu_to_tap16(struct tap_queue *q, u16 val)
-{
-	return __cpu_to_virtio16(tap_is_little_endian(q), val);
-}
+#define TAP_IFFEATURES (IFF_VNET_HDR | IFF_MULTI_QUEUE)
 
 static struct proto tap_proto = {
 	.name = "tap",
@@ -655,25 +590,11 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	if (q->flags & IFF_VNET_HDR) {
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
-		err = -EINVAL;
-		if (iov_iter_count(from) < vnet_hdr_len)
-			goto err;
-
-		err = -EFAULT;
-		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
-			goto err;
-		iov_iter_advance(from, vnet_hdr_len - sizeof(vnet_hdr));
-		if ((vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
-		     tap16_to_cpu(q, vnet_hdr.csum_start) +
-		     tap16_to_cpu(q, vnet_hdr.csum_offset) + 2 >
-			     tap16_to_cpu(q, vnet_hdr.hdr_len))
-			vnet_hdr.hdr_len = cpu_to_tap16(q,
-				 tap16_to_cpu(q, vnet_hdr.csum_start) +
-				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
-		err = -EINVAL;
-		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
+		hdr_len = tun_vnet_hdr_get(vnet_hdr_len, q->flags, from, &vnet_hdr);
+		if (hdr_len < 0) {
+			err = hdr_len;
 			goto err;
-		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
+		}
 	}
 
 	len = iov_iter_count(from);
@@ -731,8 +652,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	skb->dev = tap->dev;
 
 	if (vnet_hdr_len) {
-		err = virtio_net_hdr_to_skb(skb, &vnet_hdr,
-					    tap_is_little_endian(q));
+		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
 		if (err) {
 			rcu_read_unlock();
 			drop_reason = SKB_DROP_REASON_DEV_HDR;
@@ -795,23 +715,17 @@ static ssize_t tap_put_user(struct tap_queue *q,
 	int total;
 
 	if (q->flags & IFF_VNET_HDR) {
-		int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
 		struct virtio_net_hdr vnet_hdr;
 
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
-		if (iov_iter_count(iter) < vnet_hdr_len)
-			return -EINVAL;
 
-		if (virtio_net_hdr_from_skb(skb, &vnet_hdr,
-					    tap_is_little_endian(q), true,
-					    vlan_hlen))
-			BUG();
-
-		if (copy_to_iter(&vnet_hdr, sizeof(vnet_hdr), iter) !=
-		    sizeof(vnet_hdr))
-			return -EFAULT;
+		ret = tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vnet_hdr);
+		if (ret)
+			return ret;
 
-		iov_iter_advance(iter, vnet_hdr_len - sizeof(vnet_hdr));
+		ret = tun_vnet_hdr_put(vnet_hdr_len, iter, &vnet_hdr);
+		if (ret)
+			return ret;
 	}
 	total = vnet_hdr_len;
 	total += skb->len;
@@ -1070,42 +984,6 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		q->sk.sk_sndbuf = s;
 		return 0;
 
-	case TUNGETVNETHDRSZ:
-		s = q->vnet_hdr_sz;
-		if (put_user(s, sp))
-			return -EFAULT;
-		return 0;
-
-	case TUNSETVNETHDRSZ:
-		if (get_user(s, sp))
-			return -EFAULT;
-		if (s < (int)sizeof(struct virtio_net_hdr))
-			return -EINVAL;
-
-		q->vnet_hdr_sz = s;
-		return 0;
-
-	case TUNGETVNETLE:
-		s = !!(q->flags & TAP_VNET_LE);
-		if (put_user(s, sp))
-			return -EFAULT;
-		return 0;
-
-	case TUNSETVNETLE:
-		if (get_user(s, sp))
-			return -EFAULT;
-		if (s)
-			q->flags |= TAP_VNET_LE;
-		else
-			q->flags &= ~TAP_VNET_LE;
-		return 0;
-
-	case TUNGETVNETBE:
-		return tap_get_vnet_be(q, sp);
-
-	case TUNSETVNETBE:
-		return tap_set_vnet_be(q, sp);
-
 	case TUNSETOFFLOAD:
 		/* let the user check for future flags */
 		if (arg & ~(TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
@@ -1149,7 +1027,7 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		return ret;
 
 	default:
-		return -EINVAL;
+		return tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags, cmd, sp);
 	}
 }
 
@@ -1196,7 +1074,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	skb->protocol = eth_hdr(skb)->h_proto;
 
 	if (vnet_hdr_len) {
-		err = virtio_net_hdr_to_skb(skb, gso, tap_is_little_endian(q));
+		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
 		if (err)
 			goto err_kfree;
 	}

-- 
2.47.1

