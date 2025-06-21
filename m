Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886848479
	for <virtualization@lists.linux.dev>; Sat, 21 Jun 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517491; cv=none; b=dINN7geJPONodhraqkY/HfZqpCj9mQBefT6BksNmih6UC5NdGPXyMB2RZC7TLzenhJTt/5pxZaDWiPMYuwgq829qtSJW/Bi1BGOZc9sz7WkoLoGG1GCDH6CvmpsI52fZP1aeiEmPSZdM3CnelybDRkSY+6YI/S+RLzq4TRHtNSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517491; c=relaxed/simple;
	bh=WUV9Kwec4xAVLQG+1Bo69YOw+1iyc2NdSdFVT9fP7Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCg3ufI2H+JHvyz0CfkufxcN1+95sEZkpHFav31DCr1JfwYJlsWJ93XADTQ/hGfZ2xE0Cfe590kJRtkyB+j7exjO1C2Euhhd6TTbMROya3+SAbSD/thpZApTjHaModvd17qr98/Vyolc2PYoCjQ8eMrVtwU4bjyiGRXUmiC0yIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bViVxz/i; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bViVxz/i"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3149741b3a.2
        for <virtualization@lists.linux.dev>; Sat, 21 Jun 2025 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750517489; x=1751122289; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up6zSBk/y+q3zd8AI4YQGat3uz9aOy8LOrfGnCsBQQ0=;
        b=bViVxz/iLchY1506I5soLaUOCAxh+nVe6hPpU5NzesmAPDf60Cypd36rhBLcOe9axf
         eD00QrKlFpLcKzU9mxxxj4487fPO25thTi+8DF8Go55WhO/wV2kyUG2yxxJ8EWxUQjZY
         cJBXiTg40sxQt3eMbF0Bcr1etF5i1j9xZwSd2YXQuVsK3jd6vpSAhpd8SNBwfoq5HR3z
         zPbc3UE8vFP5dqA3CYw1C15yN+j8Ir3XcQG7u+B1AAf6gkitigx+UaDft/1HpEy4P2Cq
         5k2czlptxSzPV6ZfSeL1zFYavlanNiK2B47zQat24vxoqMmbZePUUwyYHkA/ljUb77Ar
         LZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750517489; x=1751122289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up6zSBk/y+q3zd8AI4YQGat3uz9aOy8LOrfGnCsBQQ0=;
        b=ZwFDFBSK8c2YLVdmkbW95kOynmwNShFOZkfB43wGWXjVYE/Im3TGujXi9HmcryRBn3
         GIAsluxlP1enLS5cK1svzNpoNEQiwwyKbWKQkAD2lwoj5yUtQHwyEWogMx0agiEc37yU
         RkxL3a8NFAx/E6VfqDzGjqD3VDLR8unllGIvsXUcXDdRce6GyIwaCd4aZXTCtDGINMd1
         ZT5Rv0BHW6bxYs7OjDc+3AMkqSahsPmQ8da6yN+FAt828LmBEoqHvhHJBMq75ogWlupi
         Vzamn93JLupBjWpjufl9U8Fp53mGCKGJvzPvlq82hwfmuME9e/mqTaiNE2rue3J6xVwN
         S0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXoIX7MjGp1hNV8TocQUlf6lGTqQkLrxKJ43/P+yGVnzhFdKxeLa5WrvfuPILVPyhdUxnfSr/83QFU9XWAM9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmgeXkHVFCOzNEVS6/xSuchexan85QPS/4+y651BV4+9amVAtX
	B68RmvRSYQIxzVk0KIoxz1Bu0yV2LKtvWeoR53qVEFNT5p/sp/L90pxx
X-Gm-Gg: ASbGncsZgnJdQ/veLLgxHdlqfiI/Yx/aidG3+s6vDdNmxBYlErgpnQ/bbkKk2dhmS1F
	uJCfZHXroPKbQCPEP0JEaOvnbvxJoyyDp/EUt28frsoVxMmCRZGUvDUSBKiXdFB5Ro9YI8qPpwh
	iwBpS6fog7fH5VCvzt3UppgDw0GPpaEqru6Gh9rLvj/2xNsWThby4NLOJvfuqJU666KVkxmVe1v
	rkaOX9BRqZyuYispjZXrWsnxwcnMO9FDndvDctUOQ4IjtIPaYP6EsK6JsFBcxED5TUhE1B+qDnU
	FK184TCJTIpi4ql8iSOU3IthzCdxeiw671tITF9VB2M57VaN0V4QGgxRQ00VS/mMZ5v2gosuGHg
	Gjw==
X-Google-Smtp-Source: AGHT+IETi27TeBNcP7Wim+YmhsbCm01nbJd/oUEKhx0FHnAVaswF5F4Iuv0tVHyJ0xkSdH1X0Q0tzw==
X-Received: by 2002:a05:6a00:3e0b:b0:747:bd28:1ca1 with SMTP id d2e1a72fcca58-7490d663700mr11428892b3a.3.1750517488811;
        Sat, 21 Jun 2025 07:51:28 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:fea9:d2f2:6451:ed3b])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7490a46acf4sm4493490b3a.11.2025.06.21.07.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 07:51:28 -0700 (PDT)
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
Subject: [PATCH net v2 1/2] virtio-net: xsk: rx: fix the frame's length check
Date: Sat, 21 Jun 2025 21:49:51 +0700
Message-ID: <20250621144952.32469-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621144952.32469-1-minhquangbui99@gmail.com>
References: <20250621144952.32469-1-minhquangbui99@gmail.com>
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
 drivers/net/virtio_net.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..1eb237cd5d0b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1127,15 +1127,29 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	}
 }
 
+/* Note that @len is the length of received data without virtio header */
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
@@ -1260,7 +1274,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 
 		u64_stats_add(&stats->bytes, len);
 
-		xdp = buf_to_xdp(vi, rq, buf, len);
+		xdp = buf_to_xdp(vi, rq, buf, len, false);
 		if (!xdp)
 			goto err;
 
@@ -1358,7 +1372,7 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
 
 	u64_stats_add(&stats->bytes, len);
 
-	xdp = buf_to_xdp(vi, rq, buf, len);
+	xdp = buf_to_xdp(vi, rq, buf, len, true);
 	if (!xdp)
 		return;
 
-- 
2.43.0

