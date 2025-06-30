Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5528DB58
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296424; cv=none; b=nZQHhafTAsvKmQcAlc9a9UKQSHQoO6ryJ7iNJeK2vUTG/F5B8a041zcOktoYnkWFWIl/pl+wobn278zPNbtKYkurnayt298FawcMryELz42BsXkVMvTpUifFuNFzOgHkr30jGB6OhQVvh5BAmccQJzeuGfebWCkycTyHJBXdtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296424; c=relaxed/simple;
	bh=QgfXPfEJ1ko6gJfEVqi+dqAvLBbkYxXvmPhxmO6U4cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHfCS/v4BTV+jgWHX+Z8ntxtXNyKiiZfjMB5tUYNPSLD5PXxM5BizXtcpQCpVLkWd1zsilpnl8MDa5QygpZ45Z8gPo7Y0g8cS+VBGAhkVu2TBVOSjUmhqcv7BXbQX2XmkLHIvG+vXDmeJAJiTYRc/kgx6q4bieCoKDCEHadrHfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMRIIwWf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMRIIwWf"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74af4af04fdso3287699b3a.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751296422; x=1751901222; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgTzel6BYyrjmaJOOevkqrQDDDC9SFFWPVaFYPAwVp0=;
        b=QMRIIwWf+O+7lWDaZycbV/+hEdF/f5Y/UOiKeDwjScWjTnrbdhZRNQiZclI+Bl7KC1
         NHcILhsMWdWaDeDgq7VIpLjyReCr1VCKTWtC2i5S7iTe18LiyoAwd1/FfEYfxfrG1t7O
         JFVmm/RtEFjOnzJO/3rdbfPwQVXhG2blmudOE/oGSJ+h+kyR76DhiCRenJ5i17TO+/ZF
         MqPVZWEilY4+wJNWP+NA4fUfiNGa2Jz+U+3eq8o3QwsnikFQbAWa72++QWD+O7wJAG4/
         j4Mizlsci0WtOVq0Zj5id0uwduJLAngnLGCFIN08oTm9Qnt2pDB1K8LCOrrZGrn6kI74
         y4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751296422; x=1751901222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgTzel6BYyrjmaJOOevkqrQDDDC9SFFWPVaFYPAwVp0=;
        b=XsolhRw6S8a6E9XIp/665CbroZkC5Mm6ZyEvrmI2l6c5rJ8g1FcMnVN07ujKT72BbY
         Cv0IW+hs3CAj48rdfWBsvSrw9xpb3o/JE/y0P5hxQFKOQaOYdeGgqGlmY+FfQ+Lr0Ait
         k5wOylRdz7x3I5w9d258H1Vnc6Nt/e64joL8X/GCRWeYk1PKYXQisYf3zpF1qCV1eFqA
         M1CsQmw8c+eR/SV7/Lx1zrFaTMG5WTYwrFOtjy3f7jkIYLDpQuxPKD7p5TCRYQQpitlu
         7i5hyjcJc1XyOBElx+phIW1KKcRSwJ9F5EaZs5PRwZ8rBjUFvHkjAKW985HPsuWZYccJ
         mhsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPPm0AacS27EPtFP8ehPEU7TOVJy8XVC4gJ4PONRXxfJGjkN3RaXIiGLuC6iXQo45uCfbSkZTne0CBQsCjOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXSfWaTdcwKBUIZpyyFbcdjxflPnRGJ7OAQP/BpCaBhTVP+8qG
	KzNpZzeIoDy0I/qPTLE+yt3+/9wafcPx2yj7a2KyPg4waSGOXQjGViZS
X-Gm-Gg: ASbGncsR6gjerg6Jc+XrKs7Moa2VqdHTRAS01EgjwbztmaChKuh8TCq65vk+JgPAIG+
	lK7tNQcjDC1xMT2l8CG12FJeKXlZ1/biiBaRczVe7F1suBOH6qHO/ZHFTjWpWDL87aw+LmbNkko
	Vb+sTr1PE9Z6yU80DUGdrqrdnfYNK/2bAN0WbNl/4psyNT9/o4eq2hwZiAWH6mOVN5QQjIkMWJm
	g9kFvWxlYKRODxDqxb+In7PNk0Ltd8pimcxLLEOhmzzOwujbeJ1nE+byD0OK2VpQ6W+aJ1DwMlQ
	8qAymqO+3XFxpJMILCiwUAuWDF1TfKWrzWE3+xm3B/IIdfWAsa/4gQn/Daq9OFtdoMS9PX82Ppj
	s
X-Google-Smtp-Source: AGHT+IEsch+5tINjufS1E+TUAD5+k5BuyuOB3ndZxmFnJHJrghU2JPMJl3gnOuaCh+K3vDh16HFMEA==
X-Received: by 2002:a05:6a21:6e03:b0:21e:2b2c:8f4f with SMTP id adf61e73a8af0-2208d067850mr31572821637.7.1751296422446;
        Mon, 30 Jun 2025 08:13:42 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2f51:de71:60e:eca9])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b34e31bea17sm8323340a12.46.2025.06.30.08.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 08:13:42 -0700 (PDT)
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
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/2] virtio-net: xsk: rx: fix the frame's length check
Date: Mon, 30 Jun 2025 22:13:14 +0700
Message-ID: <20250630151315.86722-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630151315.86722-1-minhquangbui99@gmail.com>
References: <20250630151315.86722-1-minhquangbui99@gmail.com>
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

Cc: stable@vger.kernel.org
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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

