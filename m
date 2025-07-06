Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF33E17BA5
	for <virtualization@lists.linux.dev>; Sun,  6 Jul 2025 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751811146; cv=none; b=lrQRYLy/RDzLG/ECUjJxOOpMYsWVXBNqCB45lm1eOTqEP0YbG/vSDBPrUFG2ezsER8fiFIjG4yzgeuoMa9FUkPgLA1rD7Q6FurX1jYVXr/82Nkiqrmc+prQ2mvYzWDzjjV+oIlW+7tIdvw5ALbu3Nbxt73C257bQtQZo3althZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751811146; c=relaxed/simple;
	bh=YMQPaIuYUDFDFSVv86DN3Q/5Wjot7/hA7gBZ/qS/vLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qpsQZuHPhUjWQPM1ws66p7Qz4iw4vH/1YItfGwttSN+MsQud03acLV/mMULDEJnyyMnEwWcmqQmi3QROhAcLBHfdrLRIfM6GDXyRQwtFJyCDz2RbgHGF5gc1gY5DIan0dusO6TS+YwkqEw8uSAROxdo6ZlYb7G51GTUWslaE5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ls3NVSA5; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls3NVSA5"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b34a8f69862so1733228a12.2
        for <virtualization@lists.linux.dev>; Sun, 06 Jul 2025 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751811144; x=1752415944; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmty3UwjQYxMt9/q+nVVzFNRCrwm25KzPNS6GD2HyFE=;
        b=Ls3NVSA5p5+SsPrXcrK913KGQEQaZnd+BiPCtL48FoNU0Lpm4p6I738UgW2ZhmLUc9
         mw2sNRvl4bhd7b8rQrDREbIlaRCpG0qoqoIMrvshye+Fd2KUN0Lsci+rG8JjCp0oAqU5
         kn23Xsrl8EbMBXmsx2MgAqtyFzzXll5/LoeKqhKuybUFxDNFP+94NnvRTMhRIcK4YDxn
         TLKdfbrxvCzYFYYzxdfNQ35Ht0gJ45y7Yp+LLIXlxDqAeaLFT0XUHa32tpZs0Qbf0nJE
         2zlXYbO+kq59t4EsBEwsK6TW7r+FPCMyJo6ttSuoHdzzOrY/7Llce2DlcZcbFnSmS458
         Ddxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751811144; x=1752415944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmty3UwjQYxMt9/q+nVVzFNRCrwm25KzPNS6GD2HyFE=;
        b=CB22txRGbelwf+rBXj5iVMJp/R64ZQ6xl0rGfYh721+gz45QqL9plWIE/3DjizDf0e
         3tmaLzXJrCuDfGX/pd0MljwPS2pk9OzkPNuafoC8TdqY69/7GFQShROCU8qDjlZfHzDR
         fhoeTxXn5h7Nr1JoQ9S+egXUhbNKxZk81ixCvmEnnlI8SgxLhivwfHCo4519d+mLxyXH
         Nf2kaIzVsG/gQp+fA9AUu99LEBHTUaLRBJJCCGA3TKPgUS8+WpGUT1/pfx5UnAO4/zj8
         63ehRbbQ4SVnBoHVzVtPbZb5NnGMcWrW2VZeueOHizluwd5RxyGjdhceqHavMaMxuxCV
         c6fg==
X-Forwarded-Encrypted: i=1; AJvYcCX1O8/TsQb5yS/9/vpdylrtxZHHZv3RCGAXdydJOAUYCoMP09fzfwC/9AGxFxygF23E8MuHZ2cWB6uUf/eV2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzK3G9qSvhdc3TLmAouzmisF1oMGMCqRKLHRwUFkGQWwQ82GHce
	Au9+Qnr+Icgsz5qZj53xPSCXLN+sRNuNCcy6qwxznEQdLa5mhAw9zMqS
X-Gm-Gg: ASbGnctyBC+qh6MAW3h8HB/jaXR9dB54HsPdF/X1KrPXHk5N2vqVVBKY6OnLWsNm+qq
	lBp2wpFAudQdFUgSfHgFps2tBKHDm4YmPRDxTdfYiGBN/nJ94T0yYJPwKCMR77K8zjw4cirlbhS
	rZtBtUSRsRwp3qddlUhz8ynqnN479QwuZvYgtlvPJV2fvJ6IeSD5rfpNcycixamBncHJH4vxEaT
	WzWVV/nz5KgNkJPGeLeMMj+/fshXFhyhvjkaKstuOVyFWZWLdpuzqgPXNOrzwORjaXqYgXlJAN9
	kwFzDS204By6Ri94+U52W8fkq38Y+O2V8Y34aQFSeZIT4D0jImVUncqRXt+JAlT05QDqH6YDu/b
	BtveRSK8g/0c=
X-Google-Smtp-Source: AGHT+IHkMY/lRn+VrFKknoTqwsdTVy0zZpH8pPEV8VEaNmKPItjhky43HQDZRy1FJjpVkZPUnxbrIQ==
X-Received: by 2002:a17:90a:d64c:b0:312:def0:e2dc with SMTP id 98e67ed59e1d1-31aadcf9664mr14554793a91.7.1751811144042;
        Sun, 06 Jul 2025 07:12:24 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:4ccf:d06a:bc2:ae04])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23c8457e6d8sm66407425ad.155.2025.07.06.07.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 07:12:23 -0700 (PDT)
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
	Gavin Li <gavinl@nvidia.com>,
	Gavi Teitz <gavi@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net] virtio-net: fix received length check in big packets
Date: Sun,  6 Jul 2025 21:11:50 +0700
Message-ID: <20250706141150.25344-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
for big packets"), the allocated size for big packets is not
MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
number of allocated frags for big packets is stored in
vi->big_packets_num_skbfrags. This commit fixes the received length
check corresponding to that change. The current incorrect check can lead
to NULL page pointer dereference in the below while loop when erroneous
length is received.

Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5d674eb9a0f2..ead1cd2fb8af 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 {
 	struct sk_buff *skb;
 	struct virtio_net_common_hdr *hdr;
-	unsigned int copy, hdr_len, hdr_padded_len;
+	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
 	struct page *page_to_free = NULL;
 	int tailroom, shinfo_size;
 	char *p, *hdr_p, *buf;
@@ -887,12 +887,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	 * tries to receive more than is possible. This is usually
 	 * the case of a broken device.
 	 */
-	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
+	BUG_ON(offset >= PAGE_SIZE);
+	max_remaining_len = (unsigned int)PAGE_SIZE - offset;
+	max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
+	if (unlikely(len > max_remaining_len)) {
 		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
 		dev_kfree_skb(skb);
+		give_pages(rq, page);
 		return NULL;
 	}
-	BUG_ON(offset >= PAGE_SIZE);
+
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
-- 
2.43.0

