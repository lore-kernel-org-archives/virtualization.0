Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55D134D8
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 619714018E
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 619714018E
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4oWmj-6CnBED
	for <virtualization@lists.linux-foundation.org>;
	Fri, 29 Dec 2023 07:31:43 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0971C400D3
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0971C400D3
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VzQvuX._1703835098;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzQvuX._1703835098)
          by smtp.aliyun-inc.com;
          Fri, 29 Dec 2023 15:31:39 +0800
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
Subject: [PATCH net-next v3 26/27] virtio_net: update tx timeout record
Date: Fri, 29 Dec 2023 15:31:07 +0800
Message-Id: <20231229073108.57778-27-xuanzhuo@linux.alibaba.com>
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

If send queue sent some packets, we update the tx timeout
record to prevent the tx timeout.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio/xsk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index ee09e898a291..9214e1548e44 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -377,6 +377,16 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 	if (!virtnet_is_xdp_raw_buffer_queue(vi, sq - vi->sq))
 		virtnet_check_sq_full_and_disable(vi, vi->dev, sq);
 
+	if (packets) {
+		struct netdev_queue *txq;
+		struct virtnet_info *vi;
+
+		vi = sq->vq->vdev->priv;
+
+		txq = netdev_get_tx_queue(vi->dev, sq - vi->sq);
+		txq_trans_cond_update(txq);
+	}
+
 	u64_stats_update_begin(&sq->stats.syncp);
 	u64_stats_add(&sq->stats.packets, packets);
 	u64_stats_add(&sq->stats.bytes,   bytes);
-- 
2.32.0.3.g01195cf9f

