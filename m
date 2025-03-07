Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633052135D3
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345331; cv=none; b=haZ1TH5jrW0OSTxP73eQE0Ih8DwrZn9w6baN2hcSl5yjmO5jEpEMCatOytpZH2cA+oOmZ+v4h0XwU9ar52CR0E9FZqbUZ0izYqGnG/EtEkThN5y8nKHtJE0wsORNCfZqGXtxLHP2KigvBULTgGkOZ6iiIDjR0yx2+BKK1Mv+0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345331; c=relaxed/simple;
	bh=bUqgi3dszTeuIO6Jayt7FNCSfLxGF0Q3vs9yEXuCbLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=qwtOaMginhf/11EOw4vr63P6Taoe1wwFLPEhXjShJ9v70mMmzRdxV0d1mGbzo3rLhBnENb5oDIDkiK20xOaEZym6ecPi+DxcPteJwuYD3TBIjkQA7hX30GHDdpPryxrfWTgSdQRt3nYDp7AN1YgFaIcFlNNUtHFGaG31RKxH17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=wQx3JD13; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="wQx3JD13"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1CBD413E5
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 11:02:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oxf26unYFV-I for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Mar 2025 11:02:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E0CC8413D1
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0CC8413D1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=wQx3JD13
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E0CC8413D1
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Mar 2025 11:02:08 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-223fd89d036so33441535ad.1
        for <virtualization@lists.linux-foundation.org>; Fri, 07 Mar 2025 03:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741345328; x=1741950128; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y12vdXD8IUD5lnVxvCmdhC+FVPs9nLD3u7Whh+JFE1I=;
        b=wQx3JD13ocZW/JUpXzIU9J8l3l7IqjAmtsuZAauLdGCWJqQnAFmQZ9D+Aczk10wC/t
         Ra4oP6/7AYBScdeXGQicuzJoDNXskK+u4qJz3OFva4k+1n+VqzvYypxjXfUc5tI+/StP
         RWVT2M8NzvRgqIaal1CcZ+ELiVlQ9KhZadjs0T6KQ0A4ZhVox7k5SciOG8+vYAhrX8x9
         WBr0IOhaW+lOQDVDob9h3XpKmcYoXeclB/6R/ybdcmTPl8HErxCwhXwUWy3tI9wXXkoJ
         QdEiQdjGcR9+LoNqPPHyAADZf6kZMTDb9UV/UqGmAY/Q9lJj+xMSfiMQxzQgY7+kYsAD
         tveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345328; x=1741950128;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y12vdXD8IUD5lnVxvCmdhC+FVPs9nLD3u7Whh+JFE1I=;
        b=IZe4aeqEboAngbZUAPQhY7t8NJdLaiPhSsOYheLvUdJBtk2DMyEDOF9jCXAbo20Tv+
         K6tmYDHVhYo+kEchVJhecAYGi1G1N9gMZDh9YRBec0rJe9DYA+uzzRtOGB3+Jsg0p1oC
         Djc/RiwINrILzVaB93cKiMYOXC/EDg2PFn7kprtuyIMa05a2HxKYLtLYU0K3/WS0qMDJ
         p/i3VdkZxy0F0LG5NXbnUEplodrQH1bHfWsElrh2pHgmC6zwR0RHBIH619QsktX4bsdE
         Mpt3rT05k7hhKeT6TOCt6yec4orq6YcgM+mr9SY568WbjGU4fhT8tJdOoBD2kzsWtVkh
         mtew==
X-Forwarded-Encrypted: i=1; AJvYcCUqG2neKR92Bxy6GooY5hlKksoqkvNNsIN7L9L4nIeUy6ResK7rFV6mp4GVX9IajIFvnTZYN4n97WalxywJaQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzbp0Aatmgbdrap6NVoLVVCpsQE6ssqJr62pwrfDEO1Jo9MZWqF
	IkSYWsdx49rBzIUJ7+TScOe4REacKxe0COt23FK17/JB+07wBd+xDZ7yHEwqsDU=
X-Gm-Gg: ASbGnctVn/OCssJj4DT93nKibFgB83+jlamTXKeq2UJdAw6v2Aw2cmnmwSQMeDxwfH5
	mPY1Kpg8uKsEsPWWhOm18aB4affp/R41bTksZllNFmXlnY7D3lFCNRb7XiplgMgssFg8mB+k7Ax
	qkUEQr5CInYB5hy6o6wb4ZBooNwx0EsOpmxUZ+upM7/+LGNHqeQfimIpDvhduLece6OmNNG5np6
	RGJhIm5DrDppWsJJEwUM2uMHH9ugs9ieMH+sPZY9XXRqqjpaxZTmAKXn0AB76j7dM5S8Bd/oNlw
	E+il4+LlgHwto+P0/vuMRnvqBl9zQtR7iJr761jzF65Yshsj
X-Google-Smtp-Source: AGHT+IF6zWuYi6fdLJEcdg62jGV3EWL/4omMjcZtlNvZShjxdxWSb6A2HX3eGBs7ZpbGb0lfsNdgeA==
X-Received: by 2002:a17:903:283:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-224288974admr56342095ad.12.1741345328248;
        Fri, 07 Mar 2025 03:02:08 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109ddfd2sm27280985ad.39.2025.03.07.03.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 03:02:07 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Mar 2025 20:01:22 +0900
Subject: [PATCH net-next v9 6/6] vhost/net: Support
 VIRTIO_NET_F_HASH_REPORT
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-rss-v9-6-df76624025eb@daynix.com>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
In-Reply-To: <20250307-rss-v9-0-df76624025eb@daynix.com>
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
X-Mailer: b4 0.14.2

VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
hash values (i.e., the hash_report member is always set to
VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
underlying socket will be reported.

VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42c302f3586ea6bb5e0d4289 100644
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
@@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net)
 		.msg_controllen = 0,
 		.msg_flags = MSG_DONTWAIT,
 	};
-	struct virtio_net_hdr hdr = {
-		.flags = 0,
-		.gso_type = VIRTIO_NET_HDR_GSO_NONE
+	struct virtio_net_hdr_v1_hash hdr = {
+		.hdr = {
+			.flags = 0,
+			.gso_type = VIRTIO_NET_HDR_GSO_NONE
+		}
 	};
 	size_t total_len = 0;
 	int err, mergeable;
@@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
 	bool set_num_buffers;
 	struct socket *sock;
 	struct iov_iter fixup;
-	__virtio16 num_buffers;
 	int recv_pkts = 0;
 
 	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
@@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *net)
 			vhost_discard_vq_desc(vq, headcount);
 			continue;
 		}
+		hdr.hdr.num_buffers = cpu_to_vhost16(vq, headcount);
 		/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
 		if (unlikely(vhost_hlen)) {
-			if (copy_to_iter(&hdr, sizeof(hdr),
-					 &fixup) != sizeof(hdr)) {
+			if (copy_to_iter(&hdr, vhost_hlen,
+					 &fixup) != vhost_hlen) {
 				vq_err(vq, "Unable to write vnet_hdr "
 				       "at addr %p\n", vq->iov->iov_base);
 				goto out;
 			}
-		} else {
+		} else if (likely(set_num_buffers)) {
 			/* Header came from socket; we'll need to patch
 			 * ->num_buffers over if VIRTIO_NET_F_MRG_RXBUF
 			 */
-			iov_iter_advance(&fixup, sizeof(hdr));
+			iov_iter_advance(&fixup, offsetof(struct virtio_net_hdr_v1, num_buffers));
+
+			if (copy_to_iter(&hdr.hdr.num_buffers, sizeof(hdr.hdr.num_buffers),
+					 &fixup) != sizeof(hdr.hdr.num_buffers)) {
+				vq_err(vq, "Failed num_buffers write");
+				vhost_discard_vq_desc(vq, headcount);
+				goto out;
+			}
 		}
 		/* TODO: Should check and handle checksum. */
 
-		num_buffers = cpu_to_vhost16(vq, headcount);
-		if (likely(set_num_buffers) &&
-		    copy_to_iter(&num_buffers, sizeof num_buffers,
-				 &fixup) != sizeof num_buffers) {
-			vq_err(vq, "Failed num_buffers write");
-			vhost_discard_vq_desc(vq, headcount);
-			goto out;
-		}
 		nvq->done_idx += headcount;
 		if (nvq->done_idx > VHOST_NET_BATCH)
 			vhost_net_signal_used(nvq);
@@ -1607,10 +1609,13 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
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
@@ -1691,6 +1696,10 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
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

