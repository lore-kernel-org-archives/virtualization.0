Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D2F28D844
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294572; cv=none; b=T6M9TOdh/Z6dxDU32kUfaRXUbaMdlX/AXmslWJk+kq+YgYttv7Aptfmmw6urXiqalQXei4Gba6OQzG1CM0VuGchXX6rATngl47JEBmDr+JYCSqPdo7vIc6+nvXtcLYU5OpdOxCkwZvLyvC13dcSvE5EwZ1mpMyHZagz5GAa2OA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294572; c=relaxed/simple;
	bh=yXGAI8fsp9QAmSJK3IamseOR28dXJb3MxGrhuL4c8hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDE7j1pxrFQpeBh9dNeLqK5aUGCcgEIXB0ta3pLwgEwO8r54NjuoXyNQ6EKW5AI2Ag1F85jXkK2EyeBSYBS3w+tAaJ6+YKG/YWGUdXJqMnrhgBVd5Lsiic2ZhaEJ7YC9JVr7lw3u9Qym7lruhPizPFgYd5A0DqgJvVKIO0V1pIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPpU2YYt; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPpU2YYt"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3134c67a173so1820861a91.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751294570; x=1751899370; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TatuTvD/KRI25aZVKetSkdRBKo49t17GGxSNN77vHt4=;
        b=nPpU2YYtVg5gmgCfqPvZCiZM289ERfUVg/2K2PqbTr/TxbbrCpmK0pdjxcQsruTLec
         3YBQwDF8f3oF6cCg2WCcj8RH5RUJpg3espGdnfaVjL0cLHvRN6Y3W7X7lTEJ+jPHfDoi
         lWzDj0KGfI5/rAgFce15kw01MQFHAqhfLHTIsCEGjoty/6rr4DLfTAJG+tjDImlOatZj
         GZbmd2mHJEtdENZdUjkWC5Y/Otk5CYiTfjTzMYf+sajLl0xijXP5mQZ3cIjG4v+2xDs5
         zsiV/HaimFkzGRd/WzFDz0NtAD28d3pq0g1VjgJ74jGzVJe2RZE9Jz7YMm4JGjl/hFbC
         28gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294570; x=1751899370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TatuTvD/KRI25aZVKetSkdRBKo49t17GGxSNN77vHt4=;
        b=j2O+IreiD8Ur7lCOuxurrLDurC+QAiaGCYFtE1zmfHXJpVZnYzg9G9xZQTDZ+jS7BD
         ydEg9hDNmSmJDoJsYG9bqVcpJqQpxkHZoCtzKDuNahGXszsOnB7otueObmY0g585J3ls
         0zkF8cdtBreLRbPs+CfeUfQQtEJy6OxwZ3guwjZPAKEFAjotfDXwCUDpKARMkUKsmWOa
         W+Ia1U9/c33BmdCNvfzrcGvnRXdglLbgP2bsV9u/J+XquSElm/Od5HvN3Ihc06W+RYpj
         B6nK1xMjzq/VRiGZt3Y6Rg5OWrUjtCtdsuwToGaUskHefJxP7w0yyBT2Rae+o0MsQJQq
         iWzw==
X-Forwarded-Encrypted: i=1; AJvYcCVofTe/e6XN41lB7gCvkzVasGYpzzl7JNKDotUkNekzazOANf0NsYw3oVp42COm4zXcM17zOy75GkfO5J/auQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2lwrEkGEeJlz5cK4a70z6MiR+7nYEtM2xYXyLA+llRNCRxA95
	d3AEzjzBPqdhLeRIbNYAWfVbVKFiUagU5wr/VFaae3s/WrXmHUH+6XwV
X-Gm-Gg: ASbGncutXZNZt2Kf02zqWLVVRnoa+i+5tOuMl21IYUnrjGSHvlW5dtSsUGEK49Csi3D
	zKLE8nfE6DOdJrZNb6eaL2HoHBgH0BUoyMG5TdCMprQt49ZnbZmoT7r3CkweEQGEfCzJVjkcLIC
	9WIbk2ggGgxCtPZwkqZHAgEfoJT3tKsBRLm3O41a3Z3eilMRla6UTTmYKLK+p0V/2aIiJuFMVvY
	M6qLvB0xbkZ5EyCkMFATXwC834dVtuNHQmvNUeaEidyyetKsvi3J3orLf6CRHk9KwGBvntkNzW1
	QLoM1U2vJfcPSqEYil1a4WVHS7sKlS/ioHWMT0S2raY9GbRLvo26T3YzcryhmA2ENQv3fP+ZLpF
	m
X-Google-Smtp-Source: AGHT+IETLZuBDgN03KgQWXJ9JG6CGzKwn4TSRbQqf09y4q790qyn1wuwU+dXImOnss1ZphjmrXsFHQ==
X-Received: by 2002:a17:90b:5445:b0:311:c970:c9c0 with SMTP id 98e67ed59e1d1-318c9243c49mr16601470a91.22.1751294569638;
        Mon, 30 Jun 2025 07:42:49 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2f51:de71:60e:eca9])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-318c13a270csm9170017a91.16.2025.06.30.07.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:42:49 -0700 (PDT)
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
Subject: [PATCH net v2 1/3] virtio-net: ensure the received length does not exceed allocated size
Date: Mon, 30 Jun 2025 21:42:10 +0700
Message-ID: <20250630144212.48471-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630144212.48471-1-minhquangbui99@gmail.com>
References: <20250630144212.48471-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In xdp_linearize_page, when reading the following buffers from the ring,
we forget to check the received length with the true allocate size. This
can lead to an out-of-bound read. This commit adds that missing check.

Cc: <stable@vger.kernel.org>
Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e53ba600605a..31661bcb3932 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -778,6 +778,26 @@ static unsigned int mergeable_ctx_to_truesize(void *mrg_ctx)
 	return (unsigned long)mrg_ctx & ((1 << MRG_CTX_HEADER_SHIFT) - 1);
 }
 
+static int check_mergeable_len(struct net_device *dev, void *mrg_ctx,
+			       unsigned int len)
+{
+	unsigned int headroom, tailroom, room, truesize;
+
+	truesize = mergeable_ctx_to_truesize(mrg_ctx);
+	headroom = mergeable_ctx_to_headroom(mrg_ctx);
+	tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
+	room = SKB_DATA_ALIGN(headroom + tailroom);
+
+	if (len > truesize - room) {
+		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
+			 dev->name, len, (unsigned long)(truesize - room));
+		DEV_STATS_INC(dev, rx_length_errors);
+		return -1;
+	}
+
+	return 0;
+}
+
 static struct sk_buff *virtnet_build_skb(void *buf, unsigned int buflen,
 					 unsigned int headroom,
 					 unsigned int len)
@@ -1797,7 +1817,8 @@ static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
  * across multiple buffers (num_buf > 1), and we make sure buffers
  * have enough headroom.
  */
-static struct page *xdp_linearize_page(struct receive_queue *rq,
+static struct page *xdp_linearize_page(struct net_device *dev,
+				       struct receive_queue *rq,
 				       int *num_buf,
 				       struct page *p,
 				       int offset,
@@ -1817,18 +1838,27 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
 	memcpy(page_address(page) + page_off, page_address(p) + offset, *len);
 	page_off += *len;
 
+	/* Only mergeable mode can go inside this while loop. In small mode,
+	 * *num_buf == 1, so it cannot go inside.
+	 */
 	while (--*num_buf) {
 		unsigned int buflen;
 		void *buf;
+		void *ctx;
 		int off;
 
-		buf = virtnet_rq_get_buf(rq, &buflen, NULL);
+		buf = virtnet_rq_get_buf(rq, &buflen, &ctx);
 		if (unlikely(!buf))
 			goto err_buf;
 
 		p = virt_to_head_page(buf);
 		off = buf - page_address(p);
 
+		if (check_mergeable_len(dev, ctx, buflen)) {
+			put_page(p);
+			goto err_buf;
+		}
+
 		/* guard against a misconfigured or uncooperative backend that
 		 * is sending packet larger than the MTU.
 		 */
@@ -1917,7 +1947,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		headroom = vi->hdr_len + header_offset;
 		buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
 			SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-		xdp_page = xdp_linearize_page(rq, &num_buf, page,
+		xdp_page = xdp_linearize_page(dev, rq, &num_buf, page,
 					      offset, header_offset,
 					      &tlen);
 		if (!xdp_page)
@@ -2252,7 +2282,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 	 */
 	if (!xdp_prog->aux->xdp_has_frags) {
 		/* linearize data for XDP */
-		xdp_page = xdp_linearize_page(rq, num_buf,
+		xdp_page = xdp_linearize_page(vi->dev, rq, num_buf,
 					      *page, offset,
 					      XDP_PACKET_HEADROOM,
 					      len);
-- 
2.43.0

