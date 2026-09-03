Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB492236EB
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 02:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402559; cv=none; b=Q6qllc3XXtYzk0lYs2I9QtPf7DJAK/C0IlH0h42BKLGDQAYq2hQ6JLetkTG1fl6CSRp9yD7hU66GDC0ENQeo8m9cMk1mLlsCuD8/Jzh+QO/L8sLXJeBR2lyuL/em5hTVHbYDO6zXhl6c/2mTjmMbndH5Pfu6QhNtDFvbf/W050Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402559; c=relaxed/simple;
	bh=rYQ1T8deK5DAxjP13zvM2PL0Ydf5YTZvFv1KGYJ1WAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iiaOVAhXm51VecgJ4StEQMH07lJRXkNYmNFMWx2vq/wFAVY/TgP5CAAVQKVp1dLDmDVIQQPIR7knBUC3Ze9/FzZgFqaCCYCmkH2KYA3qXCUY3+DS+7ZCUMsIUOqiWe9cVJkxelA4jqzElAqlIzBnM7ogVWZHKxQKZBQuAMKPzgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OQ2okNFJ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OQ2okNFJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=L7
	K9UgrcST5kgVGu8NN1w64Fo9NJe0nEyYK61Cexfpo=; b=OQ2okNFJi3HDcYw3SH
	egJY6W7o/RjaPeiobqPTcUqe4eIotQtOsfyDtAbZg0Tzi/UjDvnLXoL0FO0FSC/j
	77GxKaMvAJlTxIerBaDMz4u6wsbS+raZajQereJ5NdxyOGFjoa225gs0Kegmr9dh
	uuvjRuEKwclTLcjqmOmtlc3Bc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3V81i25hqbf4hAQ--.48237S2;
	Thu, 03 Sep 2026 10:28:52 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: kuba@kernel.org,
	mst@redhat.com
Cc: jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: [PATCH v3] virtio_net: add rx-alloc-fail counter
Date: Thu,  3 Sep 2026 10:28:48 +0800
Message-Id: <20260903022848.33595-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V81i25hqbf4hAQ--.48237S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw45JF1fAr1ruF18XrWxXrb_yoW7AFy7pr
	43Aas0yFWDXwnrJrWrKFWUZr1Yywnaya43GFyag34I93Z8Kr1FkF10gayFkF43AFZ5A3WU
	Xw4vy39xKayj9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UXZ2hUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4gbQ-mqY22aSEAAA3H

From: Longjun Tang <tanglongjun@kylinos.cn>

Count the cases where the driver fails to allocate a buffer or an skb,
such as when try_fill_recv() fails with ENOMEM, and report them via the
rx-alloc-fail qstat.

Plumb alloc-fail into virtnet_get_base_stats() to keep this new stat
reported consistently at both queue and device scope, matching how
packets, bytes, stop and wake are handled.

This counter does not cover every allocation failure in all RX paths.
It is intentionally limited to the common skb and RX buffer allocation
paths to keep its meaning clear.

$ ./tools/net/ynl/ynltool/ynltool qstats show --json scope queue
[{"ifname":"ens3",
"ifindex":2,
"queue-type":"rx",
"queue-id":0,
"rx":{"packets":3722,"bytes":374806,"alloc-fail":0}},
{"ifname":"ens3",
"ifindex":2,
"queue-type":"tx",
"queue-id":0,
"tx":{"packets":622,"bytes":77495,"stop":0,"wake":0}}]

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
change since v2:
- update commit msg: this counter does't cover all allocation failure cases.
- v2: https://lore.kernel.org/virtualization/20260824112050.02623327@kernel.org/T/#mcde23203f0dc3d3a64756e517d3f588c52723ad4

 drivers/net/virtio_net.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e34c52d059d3..360cc3435e90 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -125,6 +125,7 @@ struct virtnet_rq_stats {
 	u64_stats_t packets;
 	u64_stats_t bytes;
 	u64_stats_t drops;
+	u64_stats_t alloc_fail;
 	u64_stats_t xdp_packets;
 	u64_stats_t xdp_tx;
 	u64_stats_t xdp_redirects;
@@ -173,8 +174,9 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc_qstat[] = {
 };
 
 static const struct virtnet_stat_desc virtnet_rq_stats_desc_qstat[] = {
-	VIRTNET_RQ_STAT_QSTAT("packets", packets),
-	VIRTNET_RQ_STAT_QSTAT("bytes",   bytes),
+	VIRTNET_RQ_STAT_QSTAT("packets",    packets),
+	VIRTNET_RQ_STAT_QSTAT("bytes",      bytes),
+	VIRTNET_RQ_STAT_QSTAT("alloc_fail", alloc_fail),
 };
 
 #define VIRTNET_STATS_DESC_CQ(name) \
@@ -1917,8 +1919,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	}
 
 	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
-	if (unlikely(!skb))
+	if (unlikely(!skb)) {
+		u64_stats_inc(&stats->alloc_fail);
 		goto err;
+	}
 
 	if (metasize)
 		skb_metadata_set(skb, metasize);
@@ -1985,6 +1989,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 		return skb;
 	}
 
+	u64_stats_inc(&stats->alloc_fail);
 err:
 	u64_stats_inc(&stats->drops);
 	page_pool_put_page(rq->page_pool, page, -1, true);
@@ -2016,8 +2021,10 @@ static struct sk_buff *receive_big(struct net_device *dev,
 
 	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
-	if (unlikely(!skb))
+	if (unlikely(!skb)) {
+		u64_stats_inc(&stats->alloc_fail);
 		goto err;
+	}
 
 	return skb;
 
@@ -2298,8 +2305,10 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	switch (act) {
 	case XDP_PASS:
 		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
-		if (unlikely(!head_skb))
+		if (unlikely(!head_skb)) {
+			u64_stats_inc(&stats->alloc_fail);
 			break;
+		}
 
 		skb_mark_for_recycle(head_skb);
 		return head_skb;
@@ -2414,8 +2423,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, headroom);
 	curr_skb = head_skb;
 
-	if (unlikely(!curr_skb))
+	if (unlikely(!curr_skb)) {
+		u64_stats_inc(&stats->alloc_fail);
 		goto err_skb;
+	}
 
 	skb_mark_for_recycle(head_skb);
 	while (--num_buf) {
@@ -2444,8 +2455,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		truesize = mergeable_ctx_to_truesize(ctx);
 		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
 						    buf, len, truesize);
-		if (!curr_skb)
+		if (!curr_skb) {
+			u64_stats_inc(&stats->alloc_fail);
 			goto err_skb;
+		}
 	}
 
 	ewma_pkt_len_add(&rq->mrg_avg_pkt_len, head_skb->len);
@@ -2928,12 +2941,14 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 
 	u64_stats_set(&stats.packets, packets);
 	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
-		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
+		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
 			/* We need to retry refilling in the next NAPI poll so
 			 * we must return budget to make sure the NAPI is
 			 * repolled.
 			 */
 			packets = budget;
+			u64_stats_inc(&stats.alloc_fail);
+		}
 	}
 
 	u64_stats_update_begin(&rq->stats.syncp);
@@ -2948,6 +2963,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 
 	u64_stats_add(&rq->stats.packets, u64_stats_read(&stats.packets));
 	u64_stats_add(&rq->stats.bytes, u64_stats_read(&stats.bytes));
+	u64_stats_add(&rq->stats.alloc_fail, u64_stats_read(&stats.alloc_fail));
 
 	u64_stats_update_end(&rq->stats.syncp);
 
@@ -5666,6 +5682,7 @@ static void virtnet_get_base_stats(struct net_device *dev,
 	 */
 	rx->bytes = 0;
 	rx->packets = 0;
+	rx->alloc_fail = 0;
 
 	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_RX_BASIC) {
 		rx->hw_drops = 0;
-- 
2.25.1

