Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B93204C3E
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849350; cv=none; b=jH5K/lDENgC9ynnzvSfyvZIBH7MKYXsuGeGUCCR6RxfZnfr+sYKZ+QP0YY05gFB/6S00GgysbdV3QEqLq1H1ZFN0mZ5rwON96dOHEpHSr9wW0rL3jOrCknQ17C8v4egF2AGq7f5fxO3tf9EcRYcX6IoaXc6Loa3m1Eo/L/BW/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849350; c=relaxed/simple;
	bh=QysKwJMoIqaKFtrng8JoZjRW/Qn7QIvbuXMh0UY/638=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=fF29jmoyc5HqUELplu7L2g9aUq6CQA31n+m7bEFnOiILj1oo7UnQU9SFQ7IgK31MbStBwujUI8T8LKy4C6EpnrnROlscpY1Ptb4Ny3aPDQ7CoUVDSpFuLWL2bhvM2Xx3kfer03aPtL0nlbhpTfhp5JO+w3xEjgolzIJJ44qfgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=sA7Uy7gG; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="sA7Uy7gG"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4A61B41018
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:02:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jhURARzhcjrB for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Mar 2025 07:02:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C0A0B403F0
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C0A0B403F0
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=sA7Uy7gG
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C0A0B403F0
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 07:02:27 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso1170450a91.0
        for <virtualization@lists.linux-foundation.org>; Thu, 13 Mar 2025 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849347; x=1742454147; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXhv781+liPB0AwwevhkbIFrQwob4kiywxMETbO/hoM=;
        b=sA7Uy7gGVdzbiPHWv/SUECps1n554edrYQn4cvjOJVquY/YF7AlMrYGLzHNqJUl27s
         cbv7mzGckVxoIpbZQ5jjDhkcASHaUmaQM46Ex+t0urTO2vUlSVYFy6RxXuH3NyR9zW+y
         iLgblvpDqN3tyViMOWa7BgK7CkCLrKQO45Aqf7raBhyUA8kZEXN4k7nG/FM1VbaRZyKy
         773JtBcZYX7cm89nkgArpzF/0Sbd0cJ0DPuZv89BM7sHyailFauM40WS8P1EG5qCCL3Z
         62EQHpJaEIKSr+uydrJftTUe85tktHzymR7eakH8vcNVsLUdQBYN2RiruJFs/+V3qaNq
         a9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849347; x=1742454147;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXhv781+liPB0AwwevhkbIFrQwob4kiywxMETbO/hoM=;
        b=WANRnWQEN67stN59bX3bfhHWKAjgaNdIjXmiqyu3fedw7jhtHSII8evCk85sG5RPZw
         71O2yb+kIH796avsfbRz4OQTGvCzHq5DmtTDTszFREnjslV+X1b8JPppIJS5clkCugSW
         pM+D4ZXh3umzpzjbWIvPraMce6AIlBFSNSoFqYSUdU/vEFE1nfund8m4bLyjTKeGyVnv
         iz3YNa6X1Lu0cAolly/LJzweu6R+oiGantGwG+Wi/gLzNtFPUjV3lORoE8Wk8utXwvp0
         UrKP7LQ5z7LHo6wcptCFOor6dK+BmfBYMTThs61wug7G64bPgbRE3ctpxtPhtF6SSqO0
         BsZg==
X-Forwarded-Encrypted: i=1; AJvYcCVrz1JqCoBOM7StQ4tSDMFAxmGCDQiVGr4pZT4NmwcXUHjCowJV92N+CuqV9V5mAyQwG9g3Mro5UdgHVxXbHQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx6b+CafDuqOAF0Fi0JD0BKEpz73MFfYKA+wvS+NCWztcS6Kg/R
	Wcm7e9aRB4PbtuSF2anGWN+CwegpyBh0ds1uTdm9PoSzSTodO5uaIIp+wZiB64Q=
X-Gm-Gg: ASbGncsERdraM1W/1DWwiX6JunKiqOEGhwBFic6eUwkwFIGfKN7GkASiJGVaKjrkOvI
	7Dr9nV1d8+moMWX41ERWk9Ztl1wSDfZLwtw6aKtrm0pIB0rPLg1Z9SdNjDwFV8iAYKkgXroj31c
	tOU0I4OQ1IMgi7ePLfmX9FU+d4GpJ26pJXOTYz1TfNQYXJfDZ4w9nXxnPxYvcxeO+RtL4+26LpW
	nayFx8BlCwclNxKWa+DholuSxCGEzJHOjZ8ealHy5krvYCyMJKc92CGYi+aGfQ8V9P77SaQOgd0
	N/aPrSpZ/A6TLcWWb6ma3CRIk6wqHyq0l/f5BKc8YT529cWp
X-Google-Smtp-Source: AGHT+IGccZgOJLORtXOMA8FoHHhk3Vs+fThzqAecT9XzOzLOKltyG5QMhk3cYTHxosFWc0Sd5b9x1g==
X-Received: by 2002:a17:90b:3e4f:b0:2ff:7b15:813b with SMTP id 98e67ed59e1d1-2ff7ce93a00mr40091027a91.17.1741849346958;
        Thu, 13 Mar 2025 00:02:26 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c68a4095sm6633235ad.66.2025.03.13.00.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:02:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 16:01:13 +0900
Subject: [PATCH net-next v10 10/10] vhost/net: Support
 VIRTIO_NET_F_HASH_REPORT
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-rss-v10-10-3185d73a9af0@daynix.com>
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
In-Reply-To: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
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
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
hash values (i.e., the hash_report member is always set to
VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
underlying socket will be reported.

VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/vhost/net.c | 68 +++++++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b9b9e9d40951..fc5b43e43a06 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -73,6 +73,7 @@ enum {
 	VHOST_NET_FEATURES = VHOST_FEATURES |
 			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
+			 (1ULL << VIRTIO_NET_F_HASH_REPORT) |
 			 (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
 			 (1ULL << VIRTIO_F_RING_RESET)
 };
@@ -1097,10 +1098,6 @@ static void handle_rx(struct vhost_net *net)
 		.msg_controllen = 0,
 		.msg_flags = MSG_DONTWAIT,
 	};
-	struct virtio_net_hdr hdr = {
-		.flags = 0,
-		.gso_type = VIRTIO_NET_HDR_GSO_NONE
-	};
 	size_t total_len = 0;
 	int err, mergeable;
 	s16 headcount;
@@ -1174,11 +1171,15 @@ static void handle_rx(struct vhost_net *net)
 		/* We don't need to be notified again. */
 		iov_iter_init(&msg.msg_iter, ITER_DEST, vq->iov, in, vhost_len);
 		fixup = msg.msg_iter;
-		if (unlikely((vhost_hlen))) {
-			/* We will supply the header ourselves
-			 * TODO: support TSO.
-			 */
-			iov_iter_advance(&msg.msg_iter, vhost_hlen);
+		/*
+		 * Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR
+		 * TODO: support TSO.
+		 */
+		if (unlikely(vhost_hlen) &&
+		    iov_iter_zero(vhost_hlen, &msg.msg_iter) != vhost_hlen) {
+			vq_err(vq, "Unable to write vnet_hdr at addr %p\n",
+			       vq->iov->iov_base);
+			goto out;
 		}
 		err = sock->ops->recvmsg(sock, &msg,
 					 sock_len, MSG_DONTWAIT | MSG_TRUNC);
@@ -1191,30 +1192,24 @@ static void handle_rx(struct vhost_net *net)
 			vhost_discard_vq_desc(vq, headcount);
 			continue;
 		}
-		/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
-		if (unlikely(vhost_hlen)) {
-			if (copy_to_iter(&hdr, sizeof(hdr),
-					 &fixup) != sizeof(hdr)) {
-				vq_err(vq, "Unable to write vnet_hdr "
-				       "at addr %p\n", vq->iov->iov_base);
-				goto out;
-			}
-		} else {
-			/* Header came from socket; we'll need to patch
-			 * ->num_buffers over if VIRTIO_NET_F_MRG_RXBUF
-			 */
-			iov_iter_advance(&fixup, sizeof(hdr));
-		}
 		/* TODO: Should check and handle checksum. */
 
+		/*
+		 * We'll need to patch ->num_buffers over if
+		 * VIRTIO_NET_F_MRG_RXBUF or VIRTIO_F_VERSION_1
+		 */
 		num_buffers = cpu_to_vhost16(vq, headcount);
-		if (likely(set_num_buffers) &&
-		    copy_to_iter(&num_buffers, sizeof num_buffers,
-				 &fixup) != sizeof num_buffers) {
-			vq_err(vq, "Failed num_buffers write");
-			vhost_discard_vq_desc(vq, headcount);
-			goto out;
+		if (likely(set_num_buffers)) {
+			iov_iter_advance(&fixup, offsetof(struct virtio_net_hdr_v1, num_buffers));
+
+			if (copy_to_iter(&num_buffers, sizeof(num_buffers),
+					 &fixup) != sizeof(num_buffers)) {
+				vq_err(vq, "Failed num_buffers write");
+				vhost_discard_vq_desc(vq, headcount);
+				goto out;
+			}
 		}
+
 		nvq->done_idx += headcount;
 		if (nvq->done_idx > VHOST_NET_BATCH)
 			vhost_net_signal_used(nvq);
@@ -1607,10 +1602,13 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 	size_t vhost_hlen, sock_hlen, hdr_len;
 	int i;
 
-	hdr_len = (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-			       (1ULL << VIRTIO_F_VERSION_1))) ?
-			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
-			sizeof(struct virtio_net_hdr);
+	if (features & (1ULL << VIRTIO_NET_F_HASH_REPORT))
+		hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
+	else if (features & ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
+			     (1ULL << VIRTIO_F_VERSION_1)))
+		hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	else
+		hdr_len = sizeof(struct virtio_net_hdr);
 	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
 		/* vhost provides vnet_hdr */
 		vhost_hlen = hdr_len;
@@ -1691,6 +1689,10 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		if (features & ~VHOST_NET_FEATURES)
 			return -EOPNOTSUPP;
+		if ((features & ((1ULL << VIRTIO_F_VERSION_1) |
+				 (1ULL << VIRTIO_NET_F_HASH_REPORT))) ==
+		    (1ULL << VIRTIO_NET_F_HASH_REPORT))
+			return -EINVAL;
 		return vhost_net_set_features(n, features);
 	case VHOST_GET_BACKEND_FEATURES:
 		features = VHOST_NET_BACKEND_FEATURES;

-- 
2.48.1

