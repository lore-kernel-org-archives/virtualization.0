Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCE5C64EC5
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 11:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 579DE61142;
	Thu,  2 Feb 2023 11:01:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 579DE61142
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jzQ0yQxHb3Ub; Thu,  2 Feb 2023 11:01:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C005A61169;
	Thu,  2 Feb 2023 11:01:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C005A61169
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95D45C0078;
	Thu,  2 Feb 2023 11:01:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B53BAC0077
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D8DE81F02
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D8DE81F02
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BvAZw8gjJmDE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 688CC81F21
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 688CC81F21
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:37 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0Vako6Pc_1675335692; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vako6Pc_1675335692) by smtp.aliyun-inc.com;
 Thu, 02 Feb 2023 19:01:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 30/33] virtio_net: xsk: tx: support wakeup
Date: Thu,  2 Feb 2023 19:00:55 +0800
Message-Id: <20230202110058.130695-31-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d7589ab6ea10
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

Virtio-Net does not support to actively generate a interruption, so it
try to trigger tx NAPI on the tx interrupt cpu.

Consider the effect of cache. When interrupt triggers, it is
generally fixed on a CPU. It is better to start TX Napi on the same
CPU.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       |  3 ++
 drivers/net/virtio/virtio_net.h |  2 ++
 drivers/net/virtio/xsk.c        | 53 +++++++++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h        |  1 +
 4 files changed, 59 insertions(+)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 02d2f7d21bdf..7259b27f5cba 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -1613,6 +1613,8 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	int opaque;
 	bool done;
 
+	sq->xsk.last_cpu = smp_processor_id();
+
 	if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
 		/* We don't need to enable cb for XDP */
 		napi_complete_done(napi, 0);
@@ -3197,6 +3199,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
 	.ndo_bpf		= virtnet_xdp,
 	.ndo_xdp_xmit		= virtnet_xdp_xmit,
+	.ndo_xsk_wakeup         = virtnet_xsk_wakeup,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index dd2f7890f8cd..fc7c7a0f3c89 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -174,6 +174,8 @@ struct send_queue {
 		struct xsk_buff_pool __rcu *pool;
 
 		dma_addr_t hdr_dma_address;
+
+		u32 last_cpu;
 	} xsk;
 };
 
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index 04db80244dbd..27b7f0bb2d34 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -153,6 +153,59 @@ bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	return busy;
 }
 
+static void xsk_remote_trigger_napi(void *info)
+{
+	struct send_queue *sq = info;
+
+	virtqueue_napi_schedule(&sq->napi, sq->vq);
+}
+
+static void virtnet_xsk_wakeup_sq(struct send_queue *sq, bool in_napi)
+{
+	u32 last_cpu, cur_cpu;
+
+	if (napi_if_scheduled_mark_missed(&sq->napi))
+		return;
+
+	last_cpu = sq->xsk.last_cpu;
+
+	cur_cpu = get_cpu();
+
+	/* On remote cpu, softirq will run automatically when ipi irq exit. On
+	 * local cpu, smp_call_xxx will not trigger ipi interrupt, then softirq
+	 * cannot be triggered automatically by ipi irq exit.
+	 */
+	if (last_cpu == cur_cpu) {
+		virtqueue_napi_schedule(&sq->napi, sq->vq);
+
+		/* Not in softirq/irq context, we must raise napi tx manually. */
+		if (!in_napi)
+			napi_tx_raise();
+	} else {
+		smp_call_function_single(last_cpu, xsk_remote_trigger_napi, sq, true);
+	}
+
+	put_cpu();
+}
+
+int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct send_queue *sq;
+
+	if (!netif_running(dev))
+		return -ENETDOWN;
+
+	if (qid >= vi->curr_queue_pairs)
+		return -EINVAL;
+
+	sq = &vi->sq[qid];
+
+	virtnet_xsk_wakeup_sq(sq, false);
+
+	return 0;
+}
+
 static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queue *rq,
 				    struct xsk_buff_pool *pool, struct net_device *dev)
 {
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index 15f1540a5803..5eece0de3310 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -22,4 +22,5 @@ static inline u32 ptr_to_xsk(void *ptr)
 int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
 bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 		      int budget);
+int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
 #endif
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
