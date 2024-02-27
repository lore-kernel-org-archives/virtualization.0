Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D202456477
	for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020999; cv=none; b=YgGbNseMMLD185szjqzU7kH/Pj0olWpyBKcdA3AIoRY2IrTjotXps1tcfoDinqqUK+XOQxfOIXdBjeGxjvgifnkUw4YuBHSPdsW/NpGCOTdJFJi5fysYKwSQF2OXimm93n/5LHlyt/fTu18YG3OoDhvc0Q/N+yqkqqYTVhWmlLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020999; c=relaxed/simple;
	bh=NujPk1XinbhSzvLrFov2imWLGZSpcuAFikTms7mq81I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VNqztp43RE3bcSp3NIoDIW1rBye95hLpfQ6NC1mEJMh4whFLwXFWNPKEOn0xaya34JZ84mcSfj8MeAJKqlsPK1fWogETrKk3D6JTsrOYa1ABY+5lHI7RqB8hmPmVORytb18kmZlvMtmnnHK4X8h/yNFbwnnO34kBhkkAw3Sltew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fD6aNhMz; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fD6aNhMz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709020990; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bevBx4KouHEw4KQD9nQgZP8470FlLDbzXo8XlhAEMhY=;
	b=fD6aNhMzAzkoc7/9epm336BktqiUCAqv6qHHX6DU8w23+RVMASoXsWtkJ5W0E69l+wN5+3R0lOno1o+FDCI1x0QVYBX/rypSdPWsKj0Zszn3jQkB5MDLy97E0x7DUVgcyQ1zYGNnbvSP/oPo9e5b+HsPLkRfXHIW7jg26w7hoRA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1Lw1ef_1709020988;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1Lw1ef_1709020988)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 16:03:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next v3 5/6] virtio_net: add the total stats field
Date: Tue, 27 Feb 2024 16:03:02 +0800
Message-Id: <20240227080303.63894-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: cacd048f99e7
Content-Transfer-Encoding: 8bit

Now, we just show the stats of every queue.

But for the user, the total values of every stat may are valuable.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 72 ++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 95cbfb159a03..91838d75cff2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3399,6 +3399,7 @@ static int virtnet_set_channels(struct net_device *dev,
 	return err;
 }
 
+/* qid == -1: for rx/tx queue total field */
 static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
 {
 	struct virtnet_stats_map *m;
@@ -3421,14 +3422,23 @@ static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid,
 			else
 				tp = "_hw";
 
-			if (type == VIRTNET_STATS_Q_TYPE_RX)
-				ethtool_sprintf(&p, "rx_queue%s_%u_%s", tp, qid, m->desc[j].desc);
-
-			else if (type == VIRTNET_STATS_Q_TYPE_TX)
-				ethtool_sprintf(&p, "tx_queue%s_%u_%s", tp, qid, m->desc[j].desc);
-
-			else if (type == VIRTNET_STATS_Q_TYPE_CQ)
+			if (type == VIRTNET_STATS_Q_TYPE_RX) {
+				if (qid < 0)
+					ethtool_sprintf(&p, "rx%s_%s", tp, m->desc[j].desc);
+				else
+					ethtool_sprintf(&p, "rx_queue%s_%u_%s", tp, qid,
+							m->desc[j].desc);
+
+			} else if (type == VIRTNET_STATS_Q_TYPE_TX) {
+				if (qid < 0)
+					ethtool_sprintf(&p, "tx%s_%s", tp, m->desc[j].desc);
+				else
+					ethtool_sprintf(&p, "tx_queue%s_%u_%s", tp, qid,
+							m->desc[j].desc);
+
+			} else if (type == VIRTNET_STATS_Q_TYPE_CQ) {
 				ethtool_sprintf(&p, "cq%s_%s", tp, m->desc[j].desc);
+			}
 		}
 	}
 
@@ -3485,6 +3495,38 @@ static void virtnet_stats_ctx_init(struct virtnet_info *vi,
 	}
 }
 
+static void stats_sum_queue(u64 *sum, u32 num, u64 *q_value, u32 q_num)
+{
+	u32 step = num;
+	int i, j;
+	u64 *p;
+
+	for (i = 0; i < num; ++i) {
+		p = sum + i;
+		*p = 0;
+
+		for (j = 0; j < q_num; ++j)
+			*p += *(q_value + i + j * step);
+	}
+}
+
+static void virtnet_fill_total_fields(struct virtnet_info *vi,
+				      struct virtnet_stats_ctx *ctx)
+{
+	u64 *data, *first_rx_q, *first_tx_q;
+
+	first_rx_q = ctx->data + ctx->num_rx + ctx->num_tx + ctx->num_cq;
+	first_tx_q = first_rx_q + vi->curr_queue_pairs * ctx->num_rx;
+
+	data = ctx->data;
+
+	stats_sum_queue(data, ctx->num_rx, first_rx_q, vi->curr_queue_pairs);
+
+	data = ctx->data + ctx->num_rx;
+
+	stats_sum_queue(data, ctx->num_tx, first_tx_q, vi->curr_queue_pairs);
+}
+
 static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 			       struct virtnet_stats_ctx *ctx,
 			       const u8 *base, bool from_driver, u8 type)
@@ -3496,14 +3538,17 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 	u64 offset;
 	int i, j;
 
+	/* skip the total fields of pairs */
+	offset = ctx->num_rx + ctx->num_tx;
+
 	if (qid == vi->max_queue_pairs * 2) {
-		offset = 0;
 		queue_type = VIRTNET_STATS_Q_TYPE_CQ;
 	} else if (qid % 2) {
-		offset = ctx->num_cq + ctx->num_rx * vi->curr_queue_pairs + ctx->num_tx * (qid / 2);
+		offset += ctx->num_cq + ctx->num_rx * vi->curr_queue_pairs +
+			ctx->num_tx * (qid / 2);
 		queue_type = VIRTNET_STATS_Q_TYPE_TX;
 	} else {
-		offset = ctx->num_cq + ctx->num_rx * (qid / 2);
+		offset += ctx->num_cq + ctx->num_rx * (qid / 2);
 		queue_type = VIRTNET_STATS_Q_TYPE_RX;
 	}
 
@@ -3622,6 +3667,9 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
+		virtnet_get_stats_string(vi, VIRTNET_STATS_Q_TYPE_RX, -1, &p);
+		virtnet_get_stats_string(vi, VIRTNET_STATS_Q_TYPE_TX, -1, &p);
+
 		virtnet_get_stats_string(vi, VIRTNET_STATS_Q_TYPE_CQ, 0, &p);
 
 		for (i = 0; i < vi->curr_queue_pairs; ++i)
@@ -3663,7 +3711,7 @@ static int virtnet_get_sset_count(struct net_device *dev, int sset)
 
 		pair_count = ctx.num_rx + ctx.num_tx;
 
-		return ctx.num_cq + vi->curr_queue_pairs * pair_count;
+		return pair_count + ctx.num_cq + vi->curr_queue_pairs * pair_count;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -3696,6 +3744,8 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 			virtnet_fill_stats(vi, i * 2 + 1, &ctx, stats_base, true, 0);
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 	}
+
+	virtnet_fill_total_fields(vi, &ctx);
 }
 
 static void virtnet_get_channels(struct net_device *dev,
-- 
2.32.0.3.g01195cf9f

