Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210327262B
	for <virtualization@lists.linux.dev>; Sun, 15 Jun 2025 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750000479; cv=none; b=T6x7Wc15pCvnDdIgOJeGLRv2YE3DVg59kijhF1ofuLoCfj8h4P17R8KPho8+/rNJIDv7aQSeInNvw921H6eA4ilbPii/PYSJEMhha+hNZ5L8hvx4LLs33WMVoK9uVZ9np5NaXaEmZaq4tXaXX/yuVC4QBjMZKw8gfMscKzzS5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750000479; c=relaxed/simple;
	bh=ND9xpjO/EgzVkVrG+j9hpH3tRTi52jjvodovOmf6J/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hY80t8BexyggJJK5Rl/I+eRMRfW28LTLNjphcPaSNJp8Ay20PZw0NjKrMnmAAIBiRQS70gw6gFp8KAIUSMmlYhD8K0CAWtsJhfpgCe5nWKUS7MXilUVtJTozG6/z389BK6HbZMahb7luDo50uLhFzWwxfV7lgSuio7IruoUpFSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAn1LrgJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAn1LrgJ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748a42f718aso726443b3a.2
        for <virtualization@lists.linux.dev>; Sun, 15 Jun 2025 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750000477; x=1750605277; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqZXoccd5enL7c4ScDfrc/L3+vhJGMt2m7+g5f2BwpM=;
        b=VAn1LrgJzZBZa+LNxpmje/c3R8IWuFyvyUUOiWcN1n6daA+b43Wet0jIvy1wnm2tfd
         lTj28tFjqCu867sXc9Aqr5endn/Hs1ZoxatiSHYS6qH0+NlQgwHpDVc0lRjiIS+BiFgF
         sRY0kTS84H/OjO1jARLTzGDJyHBBmF/AZc+pj8Vae1umfVVr3gJxbxXS2ReQkUey7oHY
         0TvwJpiTjj0jSlCHEYIYsVZ5BC9RPe6lm/axVtM3AxReNMuZyx6TmbbvR78ZzH0v35VG
         IgSqKWDJ3B0wvQ4WEI8Y/oBvpYiqW15r8btxQH0VANz29eNa/irfNOKbgKBmozTRwit/
         eflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750000477; x=1750605277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqZXoccd5enL7c4ScDfrc/L3+vhJGMt2m7+g5f2BwpM=;
        b=tBa1iMpWlyyVhDA3lCNctxPv/jQv2SBRP4c/h5iVf6cTaVG9RK28bDSRI9rQoAhVoa
         azgK8qnMAMxL4+raz1SU6qFS3TvuYTj8eI3f0dQB73qpNXmq7uSIyfnLdnQaDI5Ia5dP
         JNJlw1v1KNLMDHwtohcB6b5jepP3w4vsmiH0XA5piD9drZSawH1QMJqPme+KqGIg/WQr
         BquJMya6Mz8b0bT2nP3ZyQV1ZyaWfQWfs4MujsQ1gkQQepa2wiaDPtCOV9d3h94oGix6
         jRllbxUage3L6q2lNki3uqXwTQ3f3d0H/wJi8Y+bmccQ/w53UhRX1bY5WQD9OdMSz7ee
         dhHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3qPEUzFcQqU4mUaT5u18atYdpxam/s8V2nSyvzQSWcKCnb7/JBtTlLGwLXJgJplBw5ief0DyOzkp0PMrnpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGLcMoYaulOygvqLbirzhOXDCrXnSxFG2Sv/z8uRbDdeNAsfpz
	6Xatj4jtB+iU9CxDDodmVopRCcil+Ii9ki/+/SOnjRvU/cggwMrjscBI
X-Gm-Gg: ASbGncv81bJNfVAZsxQ1hvTJ/0K3E5jxK0T0OiZVLbCQ9OGo6euMDQ6u8kBbmN7dqIl
	rVttRn3XF1WxjUOK/9qn6irI9f/DUHViclQeFzb1rdrhI6D/8XyShzRnRyngRYerpBoWDBw83hc
	lnLvgLLReY4bsuKyczgJqzDjNlPzE9mmePm+Rslj085uudtxyXPinZQzBVKeAqhhQUcjEe9dH2Z
	ZeJmuzd4PCFd3HZ7TqqwKKFQB6DgL/UlE/7C6Sv0KgbIJMNHEh2bJcrlRIqgB366HNAc1OBcEmA
	dSt2jvoqkJW7QrSK3A9bU/vpNgcDHTdoLkix+raAzdZjkvke4aFPAPDxN7WkLL9eLDglgA4HrXW
	ltYe/RQlrD706
X-Google-Smtp-Source: AGHT+IETaVvpcg0giznYrwd0REXTX1eTC798GSd0+9LFucKtPuDvNmFiIeU9L0x1qEGvknJT9744Lg==
X-Received: by 2002:a05:6a20:cd92:b0:219:935a:6e1e with SMTP id adf61e73a8af0-21fbd559011mr8729424637.26.1750000477212;
        Sun, 15 Jun 2025 08:14:37 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:482b:a929:1381:df12])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-748900b219csm4950022b3a.129.2025.06.15.08.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 08:14:36 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net 1/2] virtio-net: xsk: rx: fix the frame's length check
Date: Sun, 15 Jun 2025 22:13:32 +0700
Message-ID: <20250615151333.10644-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250615151333.10644-1-minhquangbui99@gmail.com>
References: <20250615151333.10644-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When calling buf_to_xdp, the len argument is the frame data's length
without virtio header's length (vi->hdr_len). We check that len with

	xsk_pool_get_rx_frame_size() + vi->hdr_len

to ensure the provided len does not larger than the allocated chunk
size. The additional vi->hdr_len is because in virtnet_add_recvbuf_xsk,
we use part of XDP_PACKET_HEADROOM for virtio header and ask the vhost
to start placing data from

	hard_start + XDP_PACKET_HEADROOM - vi->hdr_len
not
	hard_start + XDP_PACKET_HEADROOM

But the first buffer has virtio_header, so the maximum frame's length in
the first buffer can only be

	xsk_pool_get_rx_frame_size()
not
	xsk_pool_get_rx_frame_size() + vi->hdr_len

like in the current check.

This commit adds an additional argument to buf_to_xdp differentiate
between the first buffer and other ones to correctly calculate the maximum
frame's length.

Fixes: a4e7ba702701 ("virtio_net: xsk: rx: support recv small mode")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..7c9cf5ed1827 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1127,15 +1127,37 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	}
 }
 
+/**
+ * buf_to_xdp() - convert the @buf context to xdp_buff
+ * @vi: virtnet_info struct
+ * @rq: the receive queue struct
+ * @buf: the xdp_buff pointer that is passed to virtqueue_add_inbuf_premapped in
+ *       virtnet_add_recvbuf_xsk
+ * @len: the length of received data without virtio header's length
+ * @first_buf: this buffer is the first one or not
+ */
 static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
-				   struct receive_queue *rq, void *buf, u32 len)
+				   struct receive_queue *rq, void *buf,
+				   u32 len, bool first_buf)
 {
 	struct xdp_buff *xdp;
 	u32 bufsize;
 
 	xdp = (struct xdp_buff *)buf;
 
-	bufsize = xsk_pool_get_rx_frame_size(rq->xsk_pool) + vi->hdr_len;
+	/* In virtnet_add_recvbuf_xsk, we use part of XDP_PACKET_HEADROOM for
+	 * virtio header and ask the vhost to fill data from
+	 *         hard_start + XDP_PACKET_HEADROOM - vi->hdr_len
+	 * The first buffer has virtio header so the remaining region for frame
+	 * data is
+	 *         xsk_pool_get_rx_frame_size()
+	 * While other buffers than the first one do not have virtio header, so
+	 * the maximum frame data's length can be
+	 *         xsk_pool_get_rx_frame_size() + vi->hdr_len
+	 */
+	bufsize = xsk_pool_get_rx_frame_size(rq->xsk_pool);
+	if (!first_buf)
+		bufsize += vi->hdr_len;
 
 	if (unlikely(len > bufsize)) {
 		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
@@ -1260,7 +1282,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 
 		u64_stats_add(&stats->bytes, len);
 
-		xdp = buf_to_xdp(vi, rq, buf, len);
+		xdp = buf_to_xdp(vi, rq, buf, len, false);
 		if (!xdp)
 			goto err;
 
@@ -1358,7 +1380,7 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
 
 	u64_stats_add(&stats->bytes, len);
 
-	xdp = buf_to_xdp(vi, rq, buf, len);
+	xdp = buf_to_xdp(vi, rq, buf, len, true);
 	if (!xdp)
 		return;
 
-- 
2.43.0

