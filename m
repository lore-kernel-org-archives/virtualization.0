Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8501CD6E56
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 09:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D0F1824CB;
	Wed, 11 Oct 2023 09:27:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D0F1824CB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vItA1kgeeZnA; Wed, 11 Oct 2023 09:27:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C78D782499;
	Wed, 11 Oct 2023 09:27:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C78D782499
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4303C0088;
	Wed, 11 Oct 2023 09:27:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10936C0088
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F40682499
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F40682499
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UAH-cnJ5k_Pb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:51 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5AE1E823EB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5AE1E823EB
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R671e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VtwJVgi_1697016465; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VtwJVgi_1697016465) by smtp.aliyun-inc.com;
 Wed, 11 Oct 2023 17:27:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost 15/22] virtio_net: xsk: tx: support wakeup
Date: Wed, 11 Oct 2023 17:27:21 +0800
Message-Id: <20231011092728.105904-16-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 7e791d85ef9e
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

xsk wakeup is used to trigger the logic for xsk xmit by xsk framework or
user.

Virtio-Net does not support to actively generate an interruption, so it
tries to trigger tx NAPI on the tx interrupt cpu.

Consider the effect of cache. When interrupt triggers, it is
generally fixed on a CPU. It is better to start TX Napi on the same
CPU.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       |  3 ++
 drivers/net/virtio/virtio_net.h |  8 +++++
 drivers/net/virtio/xsk.c        | 57 +++++++++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h        |  1 +
 4 files changed, 69 insertions(+)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 87bed583b6c4..a0a735c7aa32 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -2072,6 +2072,8 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 		return 0;
 	}
 
+	sq->xsk.last_cpu = smp_processor_id();
+
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
@@ -3776,6 +3778,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
 	.ndo_bpf		= virtnet_xdp,
 	.ndo_xdp_xmit		= virtnet_xdp_xmit,
+	.ndo_xsk_wakeup         = virtnet_xsk_wakeup,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 58eb7a46c489..3e114360cc8a 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -101,6 +101,14 @@ struct virtnet_sq {
 		struct xsk_buff_pool __rcu *pool;
 
 		dma_addr_t hdr_dma_address;
+
+		u32 last_cpu;
+		struct __call_single_data csd;
+
+		/* The lock to prevent the repeat of calling
+		 * smp_call_function_single_async().
+		 */
+		spinlock_t ipi_lock;
 	} xsk;
 };
 
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index a96e23ad577e..cce746301758 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -115,6 +115,60 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 	return sent == budget;
 }
 
+static void virtnet_remote_napi_schedule(void *info)
+{
+	struct virtnet_sq *sq = info;
+
+	virtnet_vq_napi_schedule(&sq->napi, sq->vq);
+}
+
+static void virtnet_remote_raise_napi(struct virtnet_sq *sq)
+{
+	u32 last_cpu, cur_cpu;
+
+	last_cpu = sq->xsk.last_cpu;
+	cur_cpu = get_cpu();
+
+	/* On remote cpu, softirq will run automatically when ipi irq exit. On
+	 * local cpu, smp_call_xxx will not trigger ipi interrupt, then softirq
+	 * cannot be triggered automatically. So Call local_bh_enable after to
+	 * trigger softIRQ processing.
+	 */
+	if (last_cpu == cur_cpu) {
+		local_bh_disable();
+		virtnet_vq_napi_schedule(&sq->napi, sq->vq);
+		local_bh_enable();
+	} else {
+		if (spin_trylock(&sq->xsk.ipi_lock)) {
+			smp_call_function_single_async(last_cpu, &sq->xsk.csd);
+			spin_unlock(&sq->xsk.ipi_lock);
+		}
+	}
+
+	put_cpu();
+}
+
+int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtnet_sq *sq;
+
+	if (!netif_running(dev))
+		return -ENETDOWN;
+
+	if (qid >= vi->curr_queue_pairs)
+		return -EINVAL;
+
+	sq = &vi->sq[qid];
+
+	if (napi_if_scheduled_mark_missed(&sq->napi))
+		return 0;
+
+	virtnet_remote_raise_napi(sq);
+
+	return 0;
+}
+
 static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *rq,
 				    struct xsk_buff_pool *pool)
 {
@@ -244,6 +298,9 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 
 	sq->xsk.hdr_dma_address = hdr_dma;
 
+	INIT_CSD(&sq->xsk.csd, virtnet_remote_napi_schedule, sq);
+	spin_lock_init(&sq->xsk.ipi_lock);
+
 	return 0;
 
 err_sq:
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index 73ca8cd5308b..1bd19dcda649 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -17,4 +17,5 @@ static inline void *virtnet_xsk_to_ptr(u32 len)
 int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
 bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 		      int budget);
+int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
 #endif
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
