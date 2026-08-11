Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B2426422
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439474; cv=none; b=ROkMN2ld83nZwJhv4xFTIEzLKp+3vAwEOqcXm4s8XprtVg5EQz4ZLFQvaU3Wr08coj9ZotIzyYdv7QDpuONHrhdE6LwDHXOayFOHvOiNA/lWrFurvPtwd7ISTAV9rZEo+qJKKOjWIwVsAoiqgwoAQ3N7bhmmug0U1nCWhTHmiNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439474; c=relaxed/simple;
	bh=2Ic8nn1IjdeLMlFMkUBGlTSzq7P/pdhz3OTLOKObDQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AsA504WSePIMSKvPPUbGtQQ2rPpuRB6HF+Nz5hIRoSSnHn844+aov3Alb9MjAU7z1lRKINLoULePM91DXX+/8x1eC2T/w1Ey57hYQggdb4j1Zf0EzdRTW/KIDgTVVdIfaMknN00uFW8FqSPLXHjn4byR6DjiqE//qaqcdTSKk3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MEQvQZLS; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MEQvQZLS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sL
	m/oYLqe0SOnYjUJ8EtOecmT7yfbzQszZNvFCe2dIY=; b=MEQvQZLSHJnB6H6U7h
	czBvWdelvamtY7jtVKhjAa3ZX4SMtFsV9mlc/7eLHv4g49h/iytehhpTUDPlxpEF
	5wZ+FSXeFDTO654WPmo+6v8oMbWr5D3wlSKoiGy0LXeawE0P8a7307jN0JHPvERX
	6Kx2ZpkF4KLPlkOWDP1lahEVk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3P_4X53pq++EnKw--.16774S2;
	Tue, 11 Aug 2026 17:10:49 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org,
	jasowangio@gmail.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH] virtio_net: add rx-alloc-fail counter
Date: Tue, 11 Aug 2026 17:10:45 +0800
Message-Id: <20260811091045.115238-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3P_4X53pq++EnKw--.16774S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1DGF15CF1UWF45WF4Uurg_yoWrurW8pr
	43AasIyFWkXwn7JFWrKryUZr1Yywnayay3GFyag34I93W5Kr1FkF10gayYkF43AFZ5AF1U
	Xw4vyrZxKayj9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRaiisUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4hk5Z2p65xnBaQAA3j

From: tanglongjun <tanglongjun@kylinos.cn>

Count buffer and skb allocation failures on the rx queue and
report them via rx-alloc-fail in netdev qstats.

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
 drivers/net/virtio_net.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2a5876c6c8..f9d15c618d3b 100644
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
 
-- 
2.51.0

