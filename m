Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC7512B92
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A8FF82EE1
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A8FF82EE1
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JrbmHW6MNxtS
	for <virtualization@lists.linux-foundation.org>;
	Fri, 29 Dec 2023 07:31:41 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1EC2982EC7
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1EC2982EC7
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VzQtfD5_1703835096;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzQtfD5_1703835096)
          by smtp.aliyun-inc.com;
          Fri, 29 Dec 2023 15:31:37 +0800
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
	virtualization@lists.linux-foundation.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 24/27] virtio_net: xsk: rx: support recv small mode
Date: Fri, 29 Dec 2023 15:31:05 +0800
Message-Id: <20231229073108.57778-25-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 20112a26898d
Content-Transfer-Encoding: 8bit

receive the xsk buffer for small mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/xsk.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index 005bb5f66271..ee09e898a291 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -200,6 +200,37 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
 	return NULL;
 }
 
+static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev, struct virtnet_info *vi,
+						 struct virtnet_rq *rq, struct xdp_buff *xdp,
+						 unsigned int *xdp_xmit,
+						 struct virtnet_rq_stats *stats)
+{
+	struct bpf_prog *prog;
+	u32 ret;
+
+	ret = XDP_PASS;
+	rcu_read_lock();
+	prog = rcu_dereference(rq->xdp_prog);
+	if (prog)
+		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
+	rcu_read_unlock();
+
+	switch (ret) {
+	case XDP_PASS:
+		return xdp_construct_skb(rq, xdp);
+
+	case XDP_TX:
+	case XDP_REDIRECT:
+		return NULL;
+
+	default:
+		/* drop packet */
+		xsk_buff_free(xdp);
+		u64_stats_inc(&stats->drops);
+		return NULL;
+	}
+}
+
 struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
 					void *buf, u32 len,
 					unsigned int *xdp_xmit,
@@ -227,6 +258,8 @@ struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info *vi, struct virtnet_
 
 	if (vi->mergeable_rx_bufs)
 		skb = virtnet_receive_xsk_merge(dev, vi, rq, xdp, xdp_xmit, stats);
+	else
+		skb = virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_xmit, stats);
 
 	return skb;
 }
-- 
2.32.0.3.g01195cf9f

