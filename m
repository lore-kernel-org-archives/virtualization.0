Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F213446AA
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061547; cv=none; b=bUr2f3fnO/hq73sAQUIL95ZpDv8UF0Afda+SqfE/Gr7L/XideJNlqwkfRUS3bzwbrj4Nbg1FnGPZ94+fxipuzYK+d5coQ1NAXZA9/u8a+4tl84Xr1F9QAoWLUay0qB2cz46SMhMuYwHdhvq3U6kmFqj5VEaqApRvMmeD/D4JqzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061547; c=relaxed/simple;
	bh=NFWo4ioEJIhQFUj4F2K8PNPc2iMgiaom38xGap6Tnro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YePk8Lnhe0q55yFtUy2tvyL1SQB0+6bssdPeuDHApJ3OU/hiF/sjIy0+2sSYbStWeRxJjxBs5ZvElTo2AujZkS/ZGYRact7Us+wE9mgQRNz/oQOm33vEOCYJ0JfRll2OMAA4+UGNZMqC1zQGb62m00aMA7fsLhaLnAM5OhmY2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egAv0OOV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egAv0OOV"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2909448641eso88175ad.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761061545; x=1761666345; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbUGtNpnVaPGTyOD2V45HVuJEH267XSQtThwcECfQ7k=;
        b=egAv0OOVwLmF2zoj/vfXlkR2YDYVVbeZGY1uGJqlgA9sjBzoqQePe1yWw8X7yKGpIH
         UnPPSvZzEf/DFb9tQjRpwz52fZJPT8hyrqosybwZGGHiFQ4Bcn753jdZpffReoWVXtCw
         YMo4QYTz1YnehZxqT8ybXth1v/Usdvvf03q4g79H09H9dA1IEOy0Qf9EXLZWu9jTzpAD
         ZLp7H5ZQPWWBmCmrFJUSJNXeM6wEIP9tGh5MDqOmJ59oXxeDIY9txecO9gfWhWPo3669
         5sBrL5J9cdQ313dugYdsMT5yAGiy2POzOZYKXtNWIDnxxbFe2c+Yfwx0BQqKZddafd2p
         0Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061545; x=1761666345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbUGtNpnVaPGTyOD2V45HVuJEH267XSQtThwcECfQ7k=;
        b=IDra6MdU6rtHO4OnOuLreNrzb6Z1zdq2rYJxv6P3ZkqAQUVfmXmewUoRQtltsji5DM
         bCc4+xwPzaOlBwB3/+0yVf+GAJ9CCQdrwACqLg/mIVwIohtLOfthV7niJQauxWTTJMur
         ONGmEpDwQ82b4ECqbm6GlOWG2XoUFZcQ36jn9d0Gxp5lziPxqOWdNGyYAl3eDsUpMwwp
         6wi9oFZDA9IKeV0lGCVyyh8KqtAe5MXeT42rZ0nlcO7MdkDKnB4aCkhp1CjEBYzQWF/n
         iqhG2p+puVL/aXNHBFXTuUNVnLpVKh1GKg/QXTK3EFYVNPKZTl4H4sKoDtjjyJ+4Qd5Z
         uBUg==
X-Forwarded-Encrypted: i=1; AJvYcCVUXq3WZ9Q1/kw8SIN7eT7QRpbRUuGEJKzQSd1HHS9rf63+PwfKuN3Ag0sxzHSVsOsuo+msi13AjrGUCkyNcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXuvSg3cdkVS4HPNk5QMKlcWLvrzMkLpHANv3pL2ZsUzhnHkuR
	3/K8zzh7noNnbo9fjzu4IokuO9uY83E1UMnhPY4fgZrqeFlDgtyGWy5J
X-Gm-Gg: ASbGncv8zuYFAaBuIwa8aex55f4EQXwcGzh4jP2w4DXRTQnZuZvROLJt1s5+rTRQpPK
	jYWm1HMiv4/Fgq0Q13fSAMrj8OjrHwsx5T9stPxe0xVlq82NbcvDOwAqLPE0wPMmyUPB+WqPHJQ
	5HWwvrzlavp7xK8JgZuDMLMGCbWqXIjOE3+O6m5Ri7EuYmCwxgJjHGwmY1UMZbUxkwUxsrMM1aT
	bvC0F9xh5QKjixTbJ8yaaduc/L1pZL2lXjEntxllz70qWSYTed1WBoYZv8uw5OlxFMoR5nFayyU
	prI9wlW74uMF1dqyaiJHBQgfpBZdM9mzNrjVtStsd/asXcC/fZMhoW6B4IIBKpZja14+uPVlU4R
	kih3fRof9Gy9Yd9I0ptpHBGc1friBFFe6pgDI3xs+ant1pqsDprRN+HATwG/V3+uC5mnmYAL9/Q
	MVttwptQGQJ0Q1CnoQvNI8JmaW
X-Google-Smtp-Source: AGHT+IF3AjXGyHtxPeuaeB1B33R8h4DcIFMmv/CIu77BJd2s9WOMRipvHjQ1kYHQ7V9Zi5jD2ZfB7w==
X-Received: by 2002:a17:902:fc4b:b0:269:7840:de24 with SMTP id d9443c01a7336-292ff8e10damr1991205ad.21.1761061544808;
        Tue, 21 Oct 2025 08:45:44 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:87f4:6771:a0ef:9e8e])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-292471d5938sm112628365ad.58.2025.10.21.08.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:45:44 -0700 (PDT)
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
Subject: [PATCH net v3] virtio-net: fix received length check in big packets
Date: Tue, 21 Oct 2025 22:45:34 +0700
Message-ID: <20251021154534.53045-1-minhquangbui99@gmail.com>
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
Changes in v3:
- Convert BUG_ON to WARN_ON_ONCE
Changes in v2:
- Remove incorrect give_pages call
---
 drivers/net/virtio_net.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a757cbcab87f..e7b33e40ea99 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -852,7 +852,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 {
 	struct sk_buff *skb;
 	struct virtio_net_common_hdr *hdr;
-	unsigned int copy, hdr_len, hdr_padded_len;
+	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
 	struct page *page_to_free = NULL;
 	int tailroom, shinfo_size;
 	char *p, *hdr_p, *buf;
@@ -916,12 +916,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	 * tries to receive more than is possible. This is usually
 	 * the case of a broken device.
 	 */
-	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
+	if (WARN_ON_ONCE(offset >= PAGE_SIZE))
+		goto err;
+
+	max_remaining_len = (unsigned int)PAGE_SIZE - offset;
+	max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
+	if (unlikely(len > max_remaining_len)) {
 		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
-		dev_kfree_skb(skb);
-		return NULL;
+		goto err;
 	}
-	BUG_ON(offset >= PAGE_SIZE);
+
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
@@ -941,6 +945,10 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		put_page(page_to_free);
 
 	return skb;
+
+err:
+	dev_kfree_skb(skb);
+	return NULL;
 }
 
 static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
-- 
2.43.0

