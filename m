Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55D520402F
	for <virtualization@lists.linux.dev>; Tue, 29 Oct 2024 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191584; cv=none; b=qJfJP24H/NV4DUoSR7C8pYZMjZewxz33Wa/6b7EVx2V9xc0iehMLVbwiqFm4XdgGC/yQ2ajpVkG3P9w6sWkqYK2EMvUpVjf00Qh9U3WKv0AQip2r4gwDIJ9lj/He5kuqTx0TH9N9GK/5JB4B6q5cBQceyIzxcmH9cVU1tCsN9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191584; c=relaxed/simple;
	bh=P2c7LxZXQrJRecWyHq0eLcetewJNr61UfLHD5iBGOFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vvb4YNkwgz76m/2POuubD1raXYwusFOeRwMncigJ79T80JFMC2X5FU8c+nI51IREfoiUN8yX3sGj7Sd0wBNP+3mg6LQDfION291ClCdcoEzEkOcqMS6wUW8JDgYT7RcJlyr1ettMw0PzoEPnxGH4LGuuJ+Z/cbwtRs6Ceggg32U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L7phQ52a; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L7phQ52a"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730191578; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VCqPISeZfYcaXdcvh6yVHHXg+YVB/qLvdu3aEXx9Qao=;
	b=L7phQ52aciHgbAlfIToiJf5x1vaZafIoxNaLsbs27J7wMS1ViNLXVt5VP3TWf8cJwZ4yyh/+RQipDzC2UhbnlkgwossfRfCEsm+702wcH8+NnyeTSY4whs6j6Sy85BnAtTkQOZHzE/4+sVw8jwjAL95GvtBru7lWhoSUST/vpMA=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WI9drjB_1730191576 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Oct 2024 16:46:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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
	virtualization@lists.linux.dev,
	"Si-Wei Liu" <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH net-next v1 1/4] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Tue, 29 Oct 2024 16:46:12 +0800
Message-Id: <20241029084615.91049-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: df8220a5376e
Content-Transfer-Encoding: 8bit

When the frag just got a page, then may lead to regression on VM.
Specially if the sysctl net.core.high_order_alloc_disable value is 1,
then the frag always get a page when do refill.

Which could see reliable crashes or scp failure (scp a file 100M in size
to VM).

The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
of a new frag. When the frag size is larger than PAGE_SIZE,
everything is fine. However, if the frag is only one page and the
total size of the buffer and virtnet_rq_dma is larger than one page, an
overflow may occur.

The commit f9dac92ba908 ("virtio_ring: enable premapped mode whatever
use_dma_api") introduced this problem. And we reverted some commits to
fix this in last linux version. Now we try to enable it and fix this
bug directly.

Here, when the frag size is not enough, we reduce the buffer len to fix
this problem.

Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
Tested-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 792e9eadbfc3..d50c1940eb23 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -926,9 +926,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 	void *buf, *head;
 	dma_addr_t addr;
 
-	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
-		return NULL;
-
 	head = page_address(alloc_frag->page);
 
 	if (rq->do_dma) {
@@ -2423,6 +2420,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	len = SKB_DATA_ALIGN(len) +
 	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
+	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
+		return -ENOMEM;
+
 	buf = virtnet_rq_alloc(rq, len, gfp);
 	if (unlikely(!buf))
 		return -ENOMEM;
@@ -2525,6 +2525,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	 */
 	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
 
+	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
+		return -ENOMEM;
+
+	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
+		len -= sizeof(struct virtnet_rq_dma);
+
 	buf = virtnet_rq_alloc(rq, len + room, gfp);
 	if (unlikely(!buf))
 		return -ENOMEM;
-- 
2.32.0.3.g01195cf9f

