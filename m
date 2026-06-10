Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23311282F02
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781129780; cv=none; b=b+tQx0GoOEydlwwkfasSdiuKQdrI10CB/tsYVzBzUkSF6halGk2kY1Lq2Xfdpy29vwlltaF3FryB4rPOwq9dPh8Cgd2N5pVI4mzGKcyX1wNG0cY/nLiDd0g327dBVQ81/kqWN/iGig8TxZvYq4SIACl3EAi2Y8kaAgoLNLQiJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781129780; c=relaxed/simple;
	bh=sA5wDrFp+CIULT1bCPxy5eyB03Jyi7VOtlavmBqnXaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTNnHVMH+Kxel49T4wO2l1e+dH9gOGDWhEL4QUj2UFkvR38NLRp3l0WysbN6dAM0dJ7iai2BYOdA3d4LcM+ABVXst9KTGWKlyySLLzDWm9SsJZy72kxUNEu0fSAFtCTmSKlKpKDfH16sWg4hxCi6cyG6nqNHiTF8TN+fOk3f4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=YnfRG4V6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="YnfRG4V6"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36ba3ea5c46so4413682a91.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781129778; x=1781734578; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AnoVRF6dvwmy9F0C12un1rCKf6ehebtbYfYrWq+XNsU=;
        b=YnfRG4V6kfxdAcuNJdD7tVolPhhMWH1ECaKIyTu6BF9TM4hNkkBA37X1HHHQPBpNYR
         cMlsmeNKU/pFygM8J6YVuF3pZdVmrxUwVDSR+iyn+GEXtzbpVDUaUsiWPJGjtJpxfXDu
         LWpXObm4v+GvQwERaln/FfzKTNxn28Ps5r+KmnXVlHlVeEPN38IiDgcgnabjlcSE11MQ
         eVz2u1z1FkXAZejsRbtBaKpsxI48GU6tG2PnQ/hoTTYoXccYQKiXiwXVJCkmfZJ3E/Bt
         mvGsWHzgFdnzhO2PSDcjRbqe4OZi+GW2V8X5JuFh70cdECxakl1jZHlhr9+9r1YjHH8D
         scdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781129778; x=1781734578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnoVRF6dvwmy9F0C12un1rCKf6ehebtbYfYrWq+XNsU=;
        b=i1+7xNzvJnDvkaOzXJGo2SkLR60LB3nnKTBvzvbXCFNZSwzOc4Hg7FkWqDteMOTKQD
         87qrIIspoQ38c+EEO5hOX1lKRaX/D+EbmvJ+xr6iuqUpkBn/oKeHIJBSuCjDNFlvQrQn
         +O3Uu70CPjY4QRtfsPvwLFVX1cmgWy037f/btHHL2a6i6wgbUKk/w9R8+MZmjnPY5Nvf
         KJpDJgjZu+YjGbLUXd/TYizyp4f1fDfnpH0XCCoz2lZ9uoSEueE1EReg4/WaxP1eHqix
         qcPgqnRrch/WDJ/mYiDtRoa2QrLesuNEMzCapIhOKPKBkbK/ieqHIfz2uDBfryBIXD61
         s59g==
X-Forwarded-Encrypted: i=1; AFNElJ8OnJQG6N8VLpiPD9+BofH+3bk5lQ+UVPDuchWV0VnC2jmBh8sLFmk2KHcS89YphTBhGBJ/9ZzIKFuyHviMnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzHdh+p5Clh3NwAQMDEX/AlADogS6pAEFsje6AEe1PvBdqS9w5
	185SaVwUpV+iSZA6X3/qtjEX0evIB2LOLfGQnozasG3zSd3nJ8mpLHQDCYZBZqZHrGLiPqowKNu
	OcYG/eKf+
X-Gm-Gg: Acq92OF9LRGm51pcgXo5K6lTp/KSakhcqFgLTBfwk2iDQMoSVHjmepqckxwEwnIHFbA
	rE2AfxULABGkR9W1pAkDlBge166IdqeaQV8tOvTXgq2qxfXQvtZGseyidj/BoaYGi2V9oxaAG2t
	Clx3Yw3UjjZjabpZ9fDLRWVHxI7wAd47x3fpkroYNwFe518zu77c9GC8dZloXKL+ihdvLTE2E2f
	dsgBUVTuqIgHt/QAx/jQTlUzeJFX1l4vWM7Fb/21Tm1BsXJco+4QY2qNnsYSMRI45taErz0fFxN
	9PwvT4RwZ8Kq6SS50uZlUaPS5XzEvbA9eeT/Cm98iVCAE+fUvBBQzn7ASyyL9QahoeU3E3W6rv5
	KA8KZ60Kk/XYWdsOsVWg9le84/lLOo5GT1sRm0rMDiCZaRd7AiU6+t/NE4bTzpGqR7KWWNy5gve
	cGN0R836IVaIfhe5WvKDA=
X-Received: by 2002:a17:90b:57f0:b0:36b:71e6:3e01 with SMTP id 98e67ed59e1d1-377a4d95a42mr152613a91.16.1781129778354;
        Wed, 10 Jun 2026 15:16:18 -0700 (PDT)
Received: from p1.. ([2607:fb91:1582:d2f1:7bbf:a7c4:749b:120a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3775549af53sm356019a91.11.2026.06.10.15.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:16:18 -0700 (PDT)
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
Subject: [PATCH net] virtio-net: fix len check in receive_big()
Date: Wed, 10 Jun 2026 15:16:06 -0700
Message-ID: <20260610221606.1091465-1-xmei5@asu.edu>
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

