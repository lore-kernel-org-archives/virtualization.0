Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90FE1DFE0B
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Feb 2025 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729586; cv=none; b=RVIC0uBdZWOyK5bTVm9/qNb2+tZl6Ahw1h9p0+TSpKICiPh4YacH3KugebIWvrau0EKa5Bbhc4c0Y7iccIVstHBnKUF+xP2ryi7vKUUvEZRZALGAQz0PmSzqikiXczVTREqkxN4bKSVCFfXeoLRzvhq2ICYEp/y3/dQZ6Dta6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729586; c=relaxed/simple;
	bh=efUQp3xn6WYS8yAIVpG+8nNESAbDYNoZwtefI4rJo8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=L/nQ6hU8jOT+Nk1xr4jRp5mWNbnL2VPi89FiTqdH7/ZBHaC6FU+XCjjfsMUMmZOKJt4iToTno/1EaGybx1p+Y4LEdLaUkozZz6Wiaxqngdt/ZEInsK4qBVS29BHemfNm8QcoUWOJNZjRZtGGVxquHCU5xDSk1qziNbGmGOe4shA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=SBtgN4dp; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="SBtgN4dp"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56F994176C
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Feb 2025 07:59:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WUgOZzdMBhN for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Feb 2025 07:59:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4B2F84138F
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B2F84138F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=SBtgN4dp
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B2F84138F
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Feb 2025 07:59:43 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-220f4dd756eso39716715ad.3
        for <virtualization@lists.linux-foundation.org>; Thu, 27 Feb 2025 23:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740729582; x=1741334382; darn=lists.linux-foundation.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnuaMjhFxZ/6ziAA9dAFSZFZKEXkUeKJopwW9aMJd8c=;
        b=SBtgN4dppNkjS56Z8Qy+ZCNzJYhwTTDARa7+jzAYIo6DOrBvpx1gGxGjhRfq6mTWsH
         zJS+n0c+Cpck06ecbXE1qQl7O3JZCfAPqiuCBC/WhiOp9YnEp5eP4TQWCaA0Fv6lq2Jx
         gw2m5caGfm5DcRBrI1/bAmVwK4vVdKuK0sQb+D6OI9XqFKVRvqj+LhROXFHO6vxbEBEA
         dtQgMYdGGK8ysiBPdbTK8fIqkqBm5LTVB08vQCJ4OL42ul+bUHF85ewez5uLUnNkDpL6
         acveUSZWuHR2oq4G4rM/BAW9iP/Nbbp9hABWcsb0CRkD/8XhbCbl0xAmSOgDLwvub/Fi
         PPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729582; x=1741334382;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnuaMjhFxZ/6ziAA9dAFSZFZKEXkUeKJopwW9aMJd8c=;
        b=ZwXcAX914lp5fA8nF9kTZdc2mfPD5kd74VWfKhxNRCQf8zs4SkwXG6DkOaXeHr0tNa
         Z3RyF1nSWZG7k9klIcTOqwqjCg04M3hVfl50cFP0E2qnzw+5XsO2d8ZHY1b6yaLUooxf
         9mkxU+9cmY8LG5uwl8t0vx0vn2eOqcnlIFe6P2QofQ8GnE/tuozYgjQ28SQuHUxEOh4x
         aBArAHI6iI+wGyJznahzD1y3nabMY5IE2KT85PYiWyTS7uZIZyU0ceCoyMt09JjOi61v
         uJ6MjDJzO/vyBNIqHnNdoI0k5udMLW3kvYndVLvDprk7J7ke2Gjlq7sgSLTirk5D/Gra
         wqWA==
X-Forwarded-Encrypted: i=1; AJvYcCX1jQhGslot0sWSd33sNZB6vqFJJhD0Szt5QyXBPIdOyVzFKORTAhRk0bOFKPa+inigWRG0QWYJ5u+6E7rthg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz+b8JZnszlRfxZXmqlTW9EyTalWCvpnYGPk3CpQYcuZfBLleSz
	rt24yO3HSf+yzTo2xIyMkD/lPBu4LKRko5yfFFYtd9t8WH5ULZ86e8/eM/VTV3cP20/EX3qaj8b
	11vk=
X-Gm-Gg: ASbGncsZpgw6YyOLGqylNF2jLEl4uPMGH8HVvjiRhbgkTGGkaC7X1Qw+o0t7ut+m/xq
	FZvJvIl56ZAq5/MccludGvHlpaQvpOmdLL5bYaawfxSn4dLUKTvd9vCMBKrjaR+u9XjF/SzjXSS
	k4MSeaPb6EyEEJKHvwgfuh8aOp90KjDmLL18k+1LrbWBQRE+sSzy9v4ICnwohe/CsYs2cHipFEf
	qmUTTjYh9GFC/2BVeAv9cY1BDCus4UHB6lBC0LtW1/B7YZOVzBqxDRy4LeFLhJQVc0Wwq6d9ybg
	RW+321t8BXZow5ZFnHbBvd8KvXDgfA==
X-Google-Smtp-Source: AGHT+IEHq9KgafAA2Kp/V3wkg5JFswjExpfT3tDMSfV41fmOxWgxIOQNfI70dD7nhe9dRE8LZJt4RQ==
X-Received: by 2002:a17:902:ce91:b0:223:64bb:f657 with SMTP id d9443c01a7336-2236922352bmr33953935ad.46.1740729582283;
        Thu, 27 Feb 2025 23:59:42 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2235050f18bsm27632835ad.213.2025.02.27.23.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 23:59:41 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 28 Feb 2025 16:58:52 +0900
Subject: [PATCH net-next v7 6/6] vhost/net: Support
 VIRTIO_NET_F_HASH_REPORT
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-rss-v7-6-844205cbbdd6@daynix.com>
References: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
In-Reply-To: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
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
 Lei Yang <leiyang@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on the
host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
hash values (i.e., the hash_report member is always set to
VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
underlying socket will be reported.

VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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

