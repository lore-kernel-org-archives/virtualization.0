Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A46BFAB
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406511; cv=none; b=jh/Wx2CKfeRbK57Nt9HcvFENCS95HwlvArpmN3XLuKvVyESjtBAqfZ34adF9v9IXEWJMCCf0b/u6FdQUE/3YbbWzcTKE++roo3rp0NfP5KaeEoIoNmLXciil+XS/HVuZBgAkuN+9yFuvye4f9JLjd5gMux68kvPqv/1MwqdIhyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406511; c=relaxed/simple;
	bh=DDVK0Kxl97Rq7kCrzMYktQ9SwmI4N3mrd02iSIYBK6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XORbPPt4+wz+nj/b1TX7LLdNtYOqDQEg08e7HQ57NIMVEGHsXT+VdNGYgciK/4s/PKMUvElB48c1RfDOhCdC032LMLTxz/ma4Oz9F9Rte8I8IzqGUOMNio5fe/IM/UHDOj5dkTukJvNneYHfSYD2PQiZFjPa76f6w1aBQ93uN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GewG8KJV; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GewG8KJV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710406507; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uvUNm0fEIo37DYRfBx8YeihhR00l/u+vhQwqaIQC7jA=;
	b=GewG8KJV8xrTmvI8kQUMByKG+PIO4zDC1OTq7TmIz3dby+2jYm1SnNW+xh9UIJgtH6wr87COAO2Ts/JE8lWhOC8+Xv72A201GhcoTfBWmYS4IBVYXgqun7tHkjeZ8ypaH6QfTByBhVJ1ZQXEHw3SymLnEt2GFU4SDoNBgpynXDE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2S1OEM_1710406506;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2S1OEM_1710406506)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 16:55:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 5/8] virtio_net: add the total stats field
Date: Thu, 14 Mar 2024 16:54:56 +0800
Message-Id: <20240314085459.115933-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
References: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 76259b0090f3
Content-Transfer-Encoding: 8bit

Now, we just show the stats of every queue.

But for the user, the total values of every stat may are valuable.

NIC statistics:
     rx_packets: 373522
     rx_bytes: 85919736
     rx_drops: 0
     rx_xdp_packets: 0
     rx_xdp_tx: 0
     rx_xdp_redirects: 0
     rx_xdp_drops: 0
     rx_kicks: 11125
     rx_hw_notifications: 0
     rx_hw_packets: 1325870
     rx_hw_bytes: 263348963
     rx_hw_interrupts: 0
     rx_hw_drops: 1451
     rx_hw_drop_overruns: 0
     rx_hw_csum_valid: 1325870
     rx_hw_needs_csum: 1325870
     rx_hw_csum_none: 0
     rx_hw_csum_bad: 0
     rx_hw_packets_allowance_exceede: 0
     rx_hw_bytes_allowance_exceeded: 0
     tx_packets: 10050
     tx_bytes: 1230176
     tx_xdp_tx: 0
     tx_xdp_tx_drops: 0
     tx_kicks: 10050
     tx_timeouts: 0
     tx_hw_notifications: 0
     tx_hw_packets: 32281
     tx_hw_bytes: 4315590
     tx_hw_interrupts: 0
     tx_hw_drops: 0
     tx_hw_drop_malformed: 0
     tx_hw_csum_none: 0
     tx_hw_needs_csum: 32281
     tx_hw_packets_allowance_exceede: 0
     tx_hw_packets_allowance_exceede: 0
     rx_queue_0_packets: 373522
     rx_queue_0_bytes: 85919736
     rx_queue_0_drops: 0
     rx_queue_0_xdp_packets: 0
     rx_queue_0_xdp_tx: 0
     rx_queue_0_xdp_redirects: 0
     rx_queue_0_xdp_drops: 0
     rx_queue_0_kicks: 11125
     rx_queue_hw_0_notifications: 0
     rx_queue_hw_0_packets: 1325870
     rx_queue_hw_0_bytes: 263348963
     rx_queue_hw_0_interrupts: 0
     rx_queue_hw_0_drops: 1451
     rx_queue_hw_0_drop_overruns: 0
     rx_queue_hw_0_csum_valid: 1325870
     rx_queue_hw_0_needs_csum: 1325870
     rx_queue_hw_0_csum_none: 0
     rx_queue_hw_0_csum_bad: 0
     rx_queue_hw_0_packets_allowance: 0
     rx_queue_hw_0_bytes_allowance_e: 0
     tx_queue_0_packets: 10050
     tx_queue_0_bytes: 1230176
     tx_queue_0_xdp_tx: 0
     tx_queue_0_xdp_tx_drops: 0
     tx_queue_0_kicks: 10050
     tx_queue_0_timeouts: 0
     tx_queue_hw_0_notifications: 0
     tx_queue_hw_0_packets: 32281
     tx_queue_hw_0_bytes: 4315590
     tx_queue_hw_0_interrupts: 0
     tx_queue_hw_0_drops: 0
     tx_queue_hw_0_drop_malformed: 0
     tx_queue_hw_0_csum_none: 0
     tx_queue_hw_0_needs_csum: 32281
     tx_queue_hw_0_packets_allowance: 0
     tx_queue_hw_0_packets_allowance: 0

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 65 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e127915a20bd..784512406218 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3419,6 +3419,7 @@ static int virtnet_set_channels(struct net_device *dev,
 	return err;
 }
 
+/* qid == -1: for rx/tx queue total field */
 static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
 {
 	struct virtnet_stats_map *m;
@@ -3446,7 +3447,10 @@ static void virtnet_get_stats_string(struct virtnet_info *vi, int type, int qid,
 				continue;
 			}
 
-			ethtool_sprintf(&p, "%s_queue%s_%u_%s", tp, hw, qid, desc);
+			if (qid < 0)
+				ethtool_sprintf(&p, "%s%s_%s", tp, hw, desc);
+			else
+				ethtool_sprintf(&p, "%s_queue%s_%u_%s", tp, hw, qid, desc);
 		}
 	}
 
@@ -3484,6 +3488,49 @@ static void virtnet_stats_ctx_init(struct virtnet_info *vi,
 	}
 }
 
+/* stats_sum_queue - Calculate the sum of the same fields in sq or rq.
+ * @sum: the position to store the sum values
+ * @num: field num
+ * @q_value: the first queue fields
+ * @q_num: number of the queues
+ */
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
+	u32 num_cq, num_rx, num_tx;
+
+	num_cq = ctx->desc_num[VIRTNET_Q_TYPE_CQ];
+	num_rx = ctx->desc_num[VIRTNET_Q_TYPE_RX];
+	num_tx = ctx->desc_num[VIRTNET_Q_TYPE_TX];
+
+	first_rx_q = ctx->data + num_rx + num_tx + num_cq;
+	first_tx_q = first_rx_q + vi->curr_queue_pairs * num_rx;
+
+	data = ctx->data;
+
+	stats_sum_queue(data, num_rx, first_rx_q, vi->curr_queue_pairs);
+
+	data = ctx->data + num_rx;
+
+	stats_sum_queue(data, num_tx, first_tx_q, vi->curr_queue_pairs);
+}
+
 /* virtnet_fill_stats - copy the stats to ethtool -S
  * The stats source is the device or the driver.
  *
@@ -3512,12 +3559,14 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
 	num_tx = ctx->desc_num[VIRTNET_Q_TYPE_TX];
 
 	queue_type = vq_type(vi, qid);
-	offset = 0;
+
+	/* skip the total fields of pairs */
+	offset = num_rx + num_tx;
 
 	if (queue_type == VIRTNET_Q_TYPE_TX)
-		offset = num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
+		offset += num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
 	else if (queue_type == VIRTNET_Q_TYPE_RX)
-		offset = num_cq + num_rx * (qid / 2);
+		offset += num_cq + num_rx * (qid / 2);
 
 	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
 		m = &virtio_net_stats_map[i];
@@ -3653,6 +3702,9 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
+		virtnet_get_stats_string(vi, VIRTNET_Q_TYPE_RX, -1, &p);
+		virtnet_get_stats_string(vi, VIRTNET_Q_TYPE_TX, -1, &p);
+
 		virtnet_get_stats_string(vi, VIRTNET_Q_TYPE_CQ, 0, &p);
 
 		for (i = 0; i < vi->curr_queue_pairs; ++i)
@@ -3694,7 +3746,8 @@ static int virtnet_get_sset_count(struct net_device *dev, int sset)
 
 		pair_count = ctx.desc_num[VIRTNET_Q_TYPE_RX] + ctx.desc_num[VIRTNET_Q_TYPE_TX];
 
-		return ctx.desc_num[VIRTNET_Q_TYPE_CQ] + vi->curr_queue_pairs * pair_count;
+		return pair_count + ctx.desc_num[VIRTNET_Q_TYPE_CQ] +
+			vi->curr_queue_pairs * pair_count;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -3728,6 +3781,8 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 			virtnet_fill_stats(vi, i * 2 + 1, &ctx, stats_base, true, 0);
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 	}
+
+	virtnet_fill_total_fields(vi, &ctx);
 }
 
 static void virtnet_get_channels(struct net_device *dev,
-- 
2.32.0.3.g01195cf9f

