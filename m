Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9726A1CF
	for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867835; cv=none; b=DphH/M1TDvUl4ConIJR0ByHkM0a4phwlrWkUurOj977M5kpbDqQagu0Lub7ROteifH88/vihBl6UM8nx7eTKuELuhr0VPuZB9BYnS1JkXYT8UqCPPXw0ETq9xU7L29mBdxVKUsXu30JlrShcSCQ8Bc0mwiGOQHoV/S4Q2hKcp5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867835; c=relaxed/simple;
	bh=4VNy85BUiywaXD9Mqe5C4cqxPjoK22ldzoO5xhVanSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqQeMXH4vZB6MvjkrVbPutW9ZMxtW+CSYP4op1kwzV9+rQjxBf8E9WsOEB9Q+qC3qWm+L+k5wq2YZRrXWHDw0aDHAuKdkgz/5FlozylMt4q9ho1X8utLFm66hUdchBme6BZxAYwmT0Kc+libn8uMRTxGWyiQ8LuMNCEZe/vURw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgeqPmtS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgeqPmtS"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2350fc2591dso980345ad.1
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867833; x=1751472633; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uU4X+SI62dfgcKBBMkPrylaI2hont+JORdjl4bJDSKE=;
        b=CgeqPmtSzMOA4V1CUg5IOZ8Z5VURFfe47q8Xd5FEJfDxisMoW0Sbjcgo+/HEFT/qyZ
         QADKmlMNxZd26I75j4/uQQ+qVmn208dcnI2j/HQ/TYoubDCrH8bMySaabZGpW54JqGAn
         y3+hm9Bx68DkGC/V7QS1mkvYBoKppZGai2hqb6OGLCvp87DoyHwngcgoldJYUNOm4p6M
         ZfACGIruOW6yqcQmuCqA5rw6VQza1eRzxDBIgvdLGYYhm5H4Z4R1vsfqWZnPfLOjAbN5
         PdMMDYIAou53fO0zgkpppgf98TiUoRYgVv3w9WlNC3fxNUSQL/cPcxxDImeS+m7zinsX
         pr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867833; x=1751472633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uU4X+SI62dfgcKBBMkPrylaI2hont+JORdjl4bJDSKE=;
        b=gUbwYWsss6L7yWLXD4Vy2beoJnGZ2OlsTz0BRWUZ+q1rTNq+W4XeqZD5K0TC41d2+I
         m9O02VucHnjEd89kl95Z8zVP5YgnzdbZtbAkztwmKjJsBYAn4vz1xW8lk/+W5Xd4W2k0
         gCDnJ/4pavEmv2YaV3Gqvyz4Nt4T/VQui7amHSfqgA1YPoRX9XTiwNzw4T7vZXF+6sZg
         NjZrdxClDzzg/aL2Tzvr79jPiLFoiwIuuD5iOgx3zXW61guqy53eZNYdixDwJ8avTV8c
         UzWVXINliHwZv4e8X63xjsf5LV08vqHiELT9GNJJhn5gTzfP0IjwiynP+Owa3c+ofM0B
         hjag==
X-Forwarded-Encrypted: i=1; AJvYcCU7hQs4Mz9JEzZlX2FlGd23wrj8343Go3oreQSQ+PgZTyUvB2k8dwoXnRcs1210m7GkSIGQeIhUlQiJwjokeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPZSHUNjob6RmlhofUsVVC7Ou5D0HkUZ2gxseS0YkrtYpZ3XO0
	xPMaamY6IqPnuZENh0j3f4dYy+hQF6cbIwQrx9VaJ7rXQiVlm7/NC/l2
X-Gm-Gg: ASbGncthjtL1ckhkeCPdCp+wonjx7CvRf9+zz78d2FNwoduny9f1OcDFoeTgunDt7IQ
	EdlfHQmFJjjMyeqRTCnruNBUdEVS/X4Tw0qOZNklbgaL3UNclBnM7J6+VCIZ2d/d9kPj5+juh/p
	ZDwVXFsSYODNwa3aR2Xpn983hoky/FXeWBwA7TRZYqe6e6AvSGkzgBYsqC+ZJVHa0CYHuesCuiv
	W/4xPxyTWiRt8NjMcMX8jObSgCwnITF8ncV1CD9DuQ8JNt32OqVrLuHZBsmjbKm93aO34iv+ixQ
	smbrARYkDP9THwfhc2ZyA859qkekXekJLaOAH/V0hImyE9sPrZ6u99DY29KKCosCbITHX6JpiF5
	sow==
X-Google-Smtp-Source: AGHT+IEtOCWRRtycCWE6b2ddeIkB621raQHnk3klmvycYJo2xwdbq//kpd/UA+wGQ7RO8gQtx2zEWA==
X-Received: by 2002:a17:902:8212:b0:221:751f:cfbe with SMTP id d9443c01a7336-2390a4e1c2fmr1517585ad.19.1750867833222;
        Wed, 25 Jun 2025 09:10:33 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1cf0:45c2:bdd1:b92d])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-237d873845esm143219175ad.243.2025.06.25.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:10:32 -0700 (PDT)
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
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net 3/4] virtio-net: create a helper to check received mergeable buffer's length
Date: Wed, 25 Jun 2025 23:08:48 +0700
Message-ID: <20250625160849.61344-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625160849.61344-1-minhquangbui99@gmail.com>
References: <20250625160849.61344-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we have repeated code to check the received mergeable buffer's
length with allocated size. This commit creates a helper to do that and
converts current code to use it.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 68 +++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6f9fedad4a5e..844cb2a78be0 100644
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
@@ -1819,8 +1839,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
 	page_off += *len;
 
 	while (--*num_buf) {
-		unsigned int headroom, tailroom, room;
-		unsigned int truesize, buflen;
+		unsigned int buflen;
 		void *buf;
 		void *ctx;
 		int off;
@@ -1832,17 +1851,8 @@ static struct page *xdp_linearize_page(struct net_device *dev,
 		p = virt_to_head_page(buf);
 		off = buf - page_address(p);
 
-		truesize = mergeable_ctx_to_truesize(ctx);
-		headroom = mergeable_ctx_to_headroom(ctx);
-		tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
-		room = SKB_DATA_ALIGN(headroom + tailroom);
-
-		if (unlikely(buflen > truesize - room)) {
+		if (check_mergeable_len(dev, ctx, buflen)) {
 			put_page(p);
-			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-				 dev->name, buflen,
-				 (unsigned long)(truesize - room));
-			DEV_STATS_INC(dev, rx_length_errors);
 			goto err_buf;
 		}
 
@@ -2143,7 +2153,6 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 				      struct virtnet_rq_stats *stats)
 {
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
-	unsigned int headroom, tailroom, room;
 	struct skb_shared_info *shinfo;
 	unsigned int xdp_frags_truesz = 0;
 	unsigned int truesize;
@@ -2189,20 +2198,14 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 		page = virt_to_head_page(buf);
 		offset = buf - page_address(page);
 
-		truesize = mergeable_ctx_to_truesize(ctx);
-		headroom = mergeable_ctx_to_headroom(ctx);
-		tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
-		room = SKB_DATA_ALIGN(headroom + tailroom);
-
-		xdp_frags_truesz += truesize;
-		if (unlikely(len > truesize - room)) {
+		if (check_mergeable_len(dev, ctx, len)) {
 			put_page(page);
-			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-				 dev->name, len, (unsigned long)(truesize - room));
-			DEV_STATS_INC(dev, rx_length_errors);
 			goto err;
 		}
 
+		truesize = mergeable_ctx_to_truesize(ctx);
+		xdp_frags_truesz += truesize;
+
 		frag = &shinfo->frags[shinfo->nr_frags++];
 		skb_frag_fill_page_desc(frag, page, offset, len);
 		if (page_is_pfmemalloc(page))
@@ -2416,18 +2419,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	struct sk_buff *head_skb, *curr_skb;
 	unsigned int truesize = mergeable_ctx_to_truesize(ctx);
 	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
-	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
-	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
 
 	head_skb = NULL;
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 
-	if (unlikely(len > truesize - room)) {
-		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-			 dev->name, len, (unsigned long)(truesize - room));
-		DEV_STATS_INC(dev, rx_length_errors);
+	if (check_mergeable_len(dev, ctx, len))
 		goto err_skb;
-	}
 
 	if (unlikely(vi->xdp_enabled)) {
 		struct bpf_prog *xdp_prog;
@@ -2462,17 +2459,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		u64_stats_add(&stats->bytes, len);
 		page = virt_to_head_page(buf);
 
-		truesize = mergeable_ctx_to_truesize(ctx);
-		headroom = mergeable_ctx_to_headroom(ctx);
-		tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
-		room = SKB_DATA_ALIGN(headroom + tailroom);
-		if (unlikely(len > truesize - room)) {
-			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-				 dev->name, len, (unsigned long)(truesize - room));
-			DEV_STATS_INC(dev, rx_length_errors);
+		if (check_mergeable_len(dev, ctx, len))
 			goto err_skb;
-		}
 
+		truesize = mergeable_ctx_to_truesize(ctx);
 		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
 						    buf, len, truesize);
 		if (!curr_skb)
-- 
2.43.0

