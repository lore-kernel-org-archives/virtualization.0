Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F9715746F
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134181; cv=none; b=Fx7tRxzwBL3GP+W1R2BU2Dl1wPZVbFyialZT54C+zZ5i/XOYV/YScMhNbEl1wFzdlj4OYGVdXh3Na+xXeunhYGVlr/XuvDGbhCjG8N5shBjqSAFpfGJ+ms+ur5qF2hGfeO0fqJIPi1GHLq3oEAKS+M5ak0wq8xm1HpyJjtumz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134181; c=relaxed/simple;
	bh=Carb3XjtLMPHcKqqNNU+dx1HRxViKGZwKDmTu+m4y6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WJILEQlpRvLVZYpuBKGnwQIc/cta/JAT5A6/4G/h1EY1EEqYTpRwedtft3I3Eq9YVJ7I2yEQJhSTsj0BJCoWDRDzeej08qjIz1ke4Wt//b/V4iENhYyvmCXc56nsAAadRt6kUi6+fOZ9ZEIc7OQ41A66bDDZIz1ad1qstbgwT58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=hLRGM8vo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="hLRGM8vo"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0c3546924so49026505ad.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781134180; x=1781738980; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p3EZxNZCKPnvfyZdjPI6P5IIxCOG1yzfw6sAqZhgFRQ=;
        b=hLRGM8voY8z7X410NcKLrvqoZiclQFEKIY/FHUeppVNTy89Qhbc0xq2vLO33mqe/28
         R51yU9RW2k1daipwpieo/ZcHHnVN2KlLVyt7kk3yOq4EYqux72IfwXWQc67IFlw7TZk8
         N1RJhO1WNjPZJzLh7yQBYVimcHHuzVqxPVFHFmH0AitHrwWXSvE/JuK5dMHukvTRGtc1
         MC7f7GtaX2h4JMCTa9+rnhQflfX2NpJy7Txqh0oBleUvsyZiJjjjMLdoOWlg2IIv9bUy
         hSw11JwydeLFsXm8dHcR7pxNg/tafTPB9ED4MJ/O/+V4owRHhfc8Sspf0/w4mUitXlqY
         1s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781134180; x=1781738980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3EZxNZCKPnvfyZdjPI6P5IIxCOG1yzfw6sAqZhgFRQ=;
        b=tSubmE75nml2brqasIMIYq2Fm+M8YLNlvSyxshDB2+RJNi5AJJh3g7IgGvfh/UO/rX
         /mnJjA/17NXmjPoWYNbng9jRXMjpC4XBwJJOiA3lzcn9wWotg4jjBJd2zVr8XjiSp2mK
         Azr+vt2+vmpaOt9NSJSQ0IOQywFLJGgX5t5Hw19RP2wauglEKviA99MZLlznuglEcRbE
         TFrnIQjohMYcF45FGNsBwKtlLhEjiILyzjP/JXLGtMX+koe83XUeKjch7z+LeQG+GePu
         CM+RMSdGaLtcJpr0XT6CaW//lKxr0qOGhV01nOpNSmgAiqcPpwKdyLwcOeEVGI1gzL6f
         C4jQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Qz+vHdkIgt41xke8SC+wHJRGO4AroJaQ09rFPPUfSsR65aKsEbTyj2iiAZZJd7H7MIbPK99yeonHN4bCWFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwgHhTP/xWQ3PS25o/FATGEJe5l5ULQWM9GDk7oxufi2yP9l3j
	IXhBIgNALSh12Bete0BMikF7kjLAXWdSkWc10+xmTnrIsfQnwT3b2b9JEJiSzO8PMQ==
X-Gm-Gg: Acq92OFaVyf1902PjKJawRmpbsmM3/TWs8HY1LR1vkJvZGuBCHv156p30dtg+y1Jv5a
	nPFywkfFT+Pa0OdCgsWV3GvjR6CHQhbWhy7RaAwWrMTp8FplaB9POK07fKkbe68bWhd825y+YhQ
	ZzHqzoUX9sILxVuIKXOkLMcfkqlwMLYe/+6W2wVROv0pBSGbH52zQ1P4hESRef53QDRucNJh+w8
	VrqOLGuYf3iW3IMCUbZwqdj1ag0wHedlrMMkPQKTaQHCJEgY4/Gu+txsu3aQwr8M9AtEc/yL4OA
	/lXx69SDzN4+lAriZYyjchmbBrCcQV3hSYWzedOPbbn3V+7ZQSYsJx4z9g8ZPc3w70vrpnk6SjM
	BjPP7lU8V1z3tcOMUdRIOAGAuVvH0ro025VX9bjpD81mPs0rTixOItdWiKr3iWpdhyMKFvJD8Pr
	Ke+O8bngmYK+AYlNOI7cA=
X-Received: by 2002:a17:902:c94c:b0:2bf:1e59:d99 with SMTP id d9443c01a7336-2c2f04403a7mr1546005ad.8.1781134179621;
        Wed, 10 Jun 2026 16:29:39 -0700 (PDT)
Received: from p1.. ([2607:fb91:1582:d2f1:7bbf:a7c4:749b:120a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d090sm242781845ad.55.2026.06.10.16.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:29:39 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	minhquangbui99@gmail.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2 1/2] virtio-net: fix len check in receive_big()
Date: Wed, 10 Jun 2026 16:29:35 -0700
Message-ID: <20260610232936.1176094-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

receive_big() bounds the device-announced length by
(big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
add_recvbuf_big() sets sg[1] to start at offset
sizeof(struct padded_vnet_hdr) into the first page, so the chain
actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
check allows for the common hdr_len == 12 case.

A malicious virtio backend can announce a len in that gap.  page_to_skb()
then walks one frag past the page chain, storing a NULL page->private
into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
write past the static frag array and a NULL frag handed up the rx path.

Bound len by the size add_recvbuf_big() actually advertised.

Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: add 2/2 for robustness

 drivers/net/virtio_net.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..afe73eda1491 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
+	unsigned long max_len;
 	struct sk_buff *skb;
 
 	/* Make sure that len does not exceed the size allocated in
 	 * add_recvbuf_big.
 	 */
-	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
+	max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
+		  vi->big_packets_num_skbfrags * PAGE_SIZE;
+	if (unlikely(len > max_len)) {
 		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
-			 dev->name, len,
-			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
+			 dev->name, len, max_len);
 		goto err;
 	}
 
-- 
2.43.0

