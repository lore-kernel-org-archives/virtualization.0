Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA59443ACB
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138366; cv=none; b=X5NxUXXihrcbHCgpC6hiwibO2pokdG24ixBXyEfUwhikfdMo8vTYJafsslzrHkz40SUeRlOanvZSmehNeJnYqgGf6wK9WnvHNlmTKKSh6MSb6QDha1t8PGuB8imif/9/S14GVRcVWwX+fjt22FneJoX7Nw6+rqo/pxgFjemn0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138366; c=relaxed/simple;
	bh=+4y3tpuUKVecJJYH20PqlsMjT8xAJpgyyEhguCNXpS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i6JVX3g6gOxkgiZJJzW4iN7wdF1/YkKAPtXlsng83ColDjKu02eoOO7A6iiDdmV5jiiICNMAXkK81b4srxuVLBLagC6UG21dt7EpukjY9uxJh6YRBTFmDQmHqn0Srxx17+mKN3zv4a4lMRXVv+F9hlA35kQDFHse2jJ4F70+S/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RH0ZlCPu; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RH0ZlCPu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724138355; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=u5yUtFgvGZJkLvmTaub6owlArqgNe3SkGG9nd6+xSAo=;
	b=RH0ZlCPusxFCY4rbNIwbZuK+UwrxeIiQVbaTBoA8qDNAIJRBBHFGcOX2wchRNtTybDVfVobPOdC0DdkAxNzw8hz7gE1+pmksmGLWaGM6r2LyjU7LPY2+Sw1WzDC2jTa0XQuN3LPIWGBe9TMI1UyusM0/5g4L6VFa/4WOVOrSVhc=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WDHeSNR_1724138353)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 15:19:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	"Si-Wei Liu" <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Tue, 20 Aug 2024 15:19:13 +0800
Message-Id: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 1e2a77031d94
Content-Transfer-Encoding: 8bit

leads to regression on VM with the sysctl value of:

- net.core.high_order_alloc_disable=1

which could see reliable crashes or scp failure (scp a file 100M in size
to VM):

The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
of a new frag. When the frag size is larger than PAGE_SIZE,
everything is fine. However, if the frag is only one page and the
total size of the buffer and virtnet_rq_dma is larger than one page, an
overflow may occur. In this case, if an overflow is possible, I adjust
the buffer size. If net.core.high_order_alloc_disable=1, the maximum
buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
the first buffer of the frag is affected.

Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c6af18948092..e5286a6da863 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 	void *buf, *head;
 	dma_addr_t addr;
 
-	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
-		return NULL;
-
 	head = page_address(alloc_frag->page);
 
 	dma = head;
@@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	len = SKB_DATA_ALIGN(len) +
 	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
+	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
+		return -ENOMEM;
+
 	buf = virtnet_rq_alloc(rq, len, gfp);
 	if (unlikely(!buf))
 		return -ENOMEM;
@@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
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

