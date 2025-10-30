Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5426A1B5
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835492; cv=none; b=AFok20qTCFBFSuPv9BOFluQ9UDx0Jln1glHPR7+YsbPW1VKeojs3F11bdN4GIdZZSC1o8DggmHKeeSap8zFfUZLEoLq+prREtpuaHKKZUbgOLz0H79BdHpPh4Jb1nedY6LfOV3IRZbHWsR1mzjgAV8Ef6ciuuHKKqk0igsfT7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835492; c=relaxed/simple;
	bh=gG6Rxpv+5xwuYbGpv4ZcUhGKoTxFro2YHfn3sG0/O64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWMVAkqjVcZDkBxloppgen8GCuxsh1hw7hV4qlhetc83iWlELpua6iH2YlERwfRl80YtorcaO6VrMVF1DUC2l92oG4TngKRlOfBPG2lWa75pBKKaJWh/xPMK22jiYrmjaddOoSuyj/+9QDzE6IjuA9BbbiKjjwDX1Rwa8S4kv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJnw5mhw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJnw5mhw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29509084e3bso3710765ad.1
        for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761835489; x=1762440289; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8i0KSYhBekRhZe3f+zVYiMKfUdeY1w53Ec33PFErQRM=;
        b=aJnw5mhwsjsIIaY+3pmw4UccNmi7YhlLtEP6FqW4nbzp8F8WELYRqNhDpJBZDwzTml
         EeKIsQzzi7HT1bSfYMnNFb4DNfPvHF9+vxWERlOlbX8HryRMVRHMofbyEzirKJ4PPn78
         OhglzPeRu/bKiYEF+R0Y2r6ms3GcE0ZF0BqR7+55+ukjZSYzjijLdY6Ir6+52/wQ9B0Y
         zd8e/WiDDndcUIPeLkBqt2FmhZpiNi8HvFIgKxiYeoH5GW8IGPrtlO6QeB4mR2yE8zG+
         CroKmE/+XVleuL4rQAeUVuqReqiaL8ZFICNbGO1aVdzviK0MTvlFNmIzx4PU8+9kn56X
         Xvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761835489; x=1762440289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8i0KSYhBekRhZe3f+zVYiMKfUdeY1w53Ec33PFErQRM=;
        b=TajOjzUfNY4MK9mCKeYuCP37R5rmgnmyRoIjcmlfvkCwCZgHn7XPlNfb/46Dw3DyLx
         ED4JGnuB/78Db8/ZVbr784L1jC8zsdv0ZI8d9/TDIlxPJQL8C2FrtqyGIJreaFGGrtqv
         fnFgGTeVEfVZQ+T3gvR6chiFJgDxyjwgn9iiruXXjNHo5jAK2ovJvNj/0bYxVZpzRe+g
         3ouRqK844IHcQWwXVkdrzFJz/BFbNKK1g9sJsghyChZgHH5oavTFmsN+kFH9S8/66EOc
         X4OD9nlyFlA3r4NeIyIhy9NrWAJZf5Ww0jg7oqFv19VZP3t3ENLV1lxXzlySERuqt2A/
         f2OA==
X-Forwarded-Encrypted: i=1; AJvYcCVA/8zt7QMuUVK8RyC8sx4pDrjaudgVE4hxxEsVAEMf/69Lv42w1nZg4mUo8RZl+WMFnYim3X3fK3QiUdMg1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyB5TsK/6seSIHuqOiUxOBdXb6mmRiLEPxPIH27fJqMonelo+sg
	3R5FWz0ZVm+NaZx1AZpIO4+cYuYxMA8xY/qXPWrmdgk0HIFDbPnRUSjV
X-Gm-Gg: ASbGncslvLyM1ByXg/gfTXUFrdNi67ASjCsB3/XpVgag8uJnVoTwyTPEq/sLDt7KYpM
	iZaGgf7zyO7YeflRiYDqIB4vZXAnDJLhbjZVCtKWH3XvqqMPhjbb43J+xc3qv6lhS90mAOYvzXf
	dA+Uu5ynKralTLCC4b8ImJL4Ugjl3wdNMiNYbZwQ5io+nckRERPbskPQ1KfKde+qooh6oSoEiOE
	3pMig89Hyl2dJH+sUZ3rw5+rT9u/46ORYEO3wAyO/AbfoQkoE8hFwFVgoHGWVe3ozBHLBYw4fLp
	CQ4j/ifEGlJYmQ/5raR9m1DHhCr4C6ogAVo1If4WvV40upuc6ZTfLcEWFMJSM0M/bcZRLnGa3uU
	TsXiN45resrv43LaSlRB145eeOXBzh0K7gJv30tLquiF/EvpXh67b5YKCD3LoncRXddD018uDpw
	u/F+3sKdJ50nkg8w==
X-Google-Smtp-Source: AGHT+IFKdzh5PqIDW+UtJroUaPTVHXn8ZahZ8UZQ7XX0MsdR/YUksfFQ5V7KobNywlg1F1FyaLwELg==
X-Received: by 2002:a17:903:247:b0:266:57f7:25f5 with SMTP id d9443c01a7336-294ed098015mr40411365ad.7.1761835488722;
        Thu, 30 Oct 2025 07:44:48 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:f227:4662:b8d4:840c])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498e41159sm188520295ad.91.2025.10.30.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:44:48 -0700 (PDT)
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
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v7] virtio-net: fix received length check in big packets
Date: Thu, 30 Oct 2025 21:44:38 +0700
Message-ID: <20251030144438.7582-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
for big packets"), when guest gso is off, the allocated size for big
packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
negotiated MTU. The number of allocated frags for big packets is stored
in vi->big_packets_num_skbfrags.

Because the host announced buffer length can be malicious (e.g. the host
vhost_net driver's get_rx_bufs is modified to announce incorrect
length), we need a check in virtio_net receive path. Currently, the
check is not adapted to the new change which can lead to NULL page
pointer dereference in the below while loop when receiving length that
is larger than the allocated one.

This commit fixes the received length check corresponding to the new
change.

Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v7:
- Fix typos
- Link to v6: https://lore.kernel.org/netdev/20251028143116.4532-1-minhquangbui99@gmail.com/
Changes in v6:
- Fix the length check
- Link to v5: https://lore.kernel.org/netdev/20251024150649.22906-1-minhquangbui99@gmail.com/
Changes in v5:
- Move the length check to receive_big
- Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-minhquangbui99@gmail.com/
Changes in v4:
- Remove unrelated changes, add more comments
- Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-minhquangbui99@gmail.com/
Changes in v3:
- Convert BUG_ON to WARN_ON_ONCE
- Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-minhquangbui99@gmail.com/
Changes in v2:
- Remove incorrect give_pages call
- Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-minhquangbui99@gmail.com/
---
 drivers/net/virtio_net.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a757cbcab87f..421b9aa190a0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		goto ok;
 	}
 
-	/*
-	 * Verify that we can indeed put this data into a skb.
-	 * This is here to handle cases when the device erroneously
-	 * tries to receive more than is possible. This is usually
-	 * the case of a broken device.
-	 */
-	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
-		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
-		dev_kfree_skb(skb);
-		return NULL;
-	}
 	BUG_ON(offset >= PAGE_SIZE);
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
@@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
-	struct sk_buff *skb =
-		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
+	struct sk_buff *skb;
+
+	/* Make sure that len does not exceed the size allocated in
+	 * add_recvbuf_big.
+	 */
+	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
+		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
+			 dev->name, len,
+			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
+		goto err;
+	}
 
+	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 	if (unlikely(!skb))
 		goto err;
-- 
2.43.0

