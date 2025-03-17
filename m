Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17135238160
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209153; cv=none; b=sXbsgwVSkahStUWmEjqxFDL6cIhgwZ1nUOCS/ektfl2SO2YeoBrR7dL2TdXdAoy6Liod0w3zJfMcIbobB6nrlJTo1J8aMyByeoc/9NW988KCgiWFHx5p73NMq+P1N3F8Fh6bKZbieV4pIsb8yUEQkaZY/XIdrxYhIXfNcdzHJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209153; c=relaxed/simple;
	bh=QysKwJMoIqaKFtrng8JoZjRW/Qn7QIvbuXMh0UY/638=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=jwueMt5/WYZDQ2e+LIiTDLBJg8tkKg9bCXPP7KLSWE+/UscUigbGosiZVLtuR7RjHGAvWl2V5xCK5vNhtYxii212e1jhs5vrqwQ5BDp0iQP6AxzN0CUre4j2vg9Di/KpHP9I9IR0urPIMA4rAdnNzXynT7Wb5Xl18M8xvNs+E3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=fetOvu++; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="fetOvu++"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A400B40B9E
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:59:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FL6pjCFUSbhi for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Mar 2025 10:59:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8493640480
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8493640480
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=fetOvu++
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8493640480
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 10:59:10 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so2151288a91.1
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742209150; x=1742813950; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXhv781+liPB0AwwevhkbIFrQwob4kiywxMETbO/hoM=;
        b=fetOvu++eyImiRQzC4DUEEm6jvk1ZR4NPxKbs004KFNWK1DuPJHLBqTt1ziKuuJ6h6
         GgaR9MdX7SzwgyuVbONrdM8rRgl/feq+D7zFnNrTlMfWnwb4n/rG5JBKySLsBoe294NW
         +werN7UJQpBygzJw59mc5iHxPX8C7CCupt3S8fimTQD4HiQFwnh28tNia5aAdbNhdCzy
         wEEW4tWDEu+hzats4DIWMCtq4I2FNXP23vUiBAKDSeQ91EOVpns+iXO7OEZx3MZffC1n
         Mv23GqKu6bcogyufM28qs7aVKw6UHY2XeEEVqlCgATJOuX3ciAEBzECRJbW/E+j9bWPe
         2jJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209150; x=1742813950;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXhv781+liPB0AwwevhkbIFrQwob4kiywxMETbO/hoM=;
        b=orlGePU4MAv9KTyLlGnRZL1kb4DdvZXcLQphAlXSGzWSN3xySjTLQlIOlT+eqowRJE
         j1pdkIs1KTkod0M5znwDqGIsUTcr7HfI3P3mPqtABelc1wR14W+qphjH6MFbWkcSOHvv
         TuZMntiogpouc4KUv6CtbtLryg9mrKKV9kwJyJBGeOyBb/bO3iLcTQUSgQcmkJA2admL
         tJpcjehPq/oGo9W7vNJpHXfQP2vAgEop+jdS9jWW82FgXOJqz/BMqK/GnTCdvRvWuWNh
         drXvciqrzbclfP6sJRz+MFbgJP1MBIf5MWusdFZK1ARXhOJsmjRkkZNzQRpN/0VHhMfm
         f/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUakeeQ4oXJ3PzbcS+ooAaWI7ASUeCdjTz2ItSi9ghAfMJ83RWXC+hXH/ae3snWmoOS5HbfmYNew3PNzhEX9w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxDf+sao3kuLHiiTCZ2BzrS0ZxbmVPXjjE53b2vWPIIkC4UnIMt
	d81MSv+4xlchZL+Xm4jREe/PDSOg74vaQ83xYlVd123DaZBteFKTOB/zqZgbqX0=
X-Gm-Gg: ASbGncsaXV1hfcJLwLG0qO3odh3LxJimFAlffi4knceho8PfahWEDDfRyD2RWgn2dTw
	Q+6Up3UEYXdttWEY+nvqQ7aUCkCb62JqpTYWQUnyMrxNUzEMqa/qL4PycMgQMUKl/auUoW5ht0U
	YiyAWRDMb6v64v1XUnl3e0NZpppjTcSSzg3sh1cY+TB+K3VschDWsXlpTGFWvaT5Gmx1tnq3aMn
	dRnUOvds4xxrVHw8Ba0T1YNBTq0ufFVJT6NUjBOnx3qT8MGJ1mYVsfFVscD/RMFCyoYUswQLDLz
	6Cry3wEFXGbloKQt2h6W0nzVAaHqPSakNLKAuTbSLQvp+eci
X-Google-Smtp-Source: AGHT+IFBTzBt4W91RO9hEmwf21fzT3s8Bp70zxhXco8GCOaNp4xUeMJNMRSu3auEGTPJcF2HKgGT2A==
X-Received: by 2002:a17:90b:5347:b0:2ff:58c7:a71f with SMTP id 98e67ed59e1d1-30151dc7588mr13016176a91.32.1742209149802;
        Mon, 17 Mar 2025 03:59:09 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3015364ec6esm5760309a91.49.2025.03.17.03.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:59:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 17 Mar 2025 19:58:00 +0900
Subject: [PATCH net-next v11 10/10] vhost/net: Support
 VIRTIO_NET_F_HASH_REPORT
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rss-v11-10-4cacca92f31f@daynix.com>
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
In-Reply-To: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
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

