Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29DAC49EA6
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:22:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCAC613DF
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCAC613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B488606A7;
	Thu, 10 Jun 2021 08:22:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9EjxVzSr3GEp; Thu, 10 Jun 2021 08:22:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3851160905;
	Thu, 10 Jun 2021 08:22:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFD05C001C;
	Thu, 10 Jun 2021 08:22:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27607C001C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 760B6606A7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MZYMSdC8bK6Z
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 472656058B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:18 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R561e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=21; SR=0; TI=SMTPD_---0Ubx5.Id_1623313335; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Ubx5.Id_1623313335) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Jun 2021 16:22:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v5 14/15] virtio-net: xsk direct xmit inside xsk
 wakeup
Date: Thu, 10 Jun 2021 16:22:08 +0800
Message-Id: <20210610082209.91487-15-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

Calling virtqueue_napi_schedule() in wakeup results in napi running on
the current cpu. If the application is not busy, then there is no
problem. But if the application itself is busy, it will cause a lot of
scheduling.

If the application is continuously sending data packets, due to the
continuous scheduling between the application and napi, the data packet
transmission will not be smooth, and there will be an obvious delay in
the transmission (you can use tcpdump to see it). When pressing a
channel to 100% (vhost reaches 100%), the cpu where the application is
located reaches 100%.

This patch sends a small amount of data directly in wakeup. The purpose
of this is to trigger the tx interrupt. The tx interrupt will be
awakened on the cpu of its affinity, and then trigger the operation of
the napi mechanism, napi can continue to consume the xsk tx queue. Two
cpus are running, cpu0 is running applications, cpu1 executes
napi consumption data. The same is to press a channel to 100%, but the
utilization rate of cpu0 is 12.7% and the utilization rate of cpu1 is
2.9%.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/xsk.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index 36cda2dcf8e7..3973c82d1ad2 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -547,6 +547,7 @@ int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct xsk_buff_pool *pool;
+	struct netdev_queue *txq;
 	struct send_queue *sq;
 
 	if (!netif_running(dev))
@@ -559,11 +560,28 @@ int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 
 	rcu_read_lock();
 	pool = rcu_dereference(sq->xsk.pool);
-	if (pool) {
-		local_bh_disable();
-		virtqueue_napi_schedule(&sq->napi, sq->vq);
-		local_bh_enable();
-	}
+	if (!pool)
+		goto end;
+
+	if (napi_if_scheduled_mark_missed(&sq->napi))
+		goto end;
+
+	txq = netdev_get_tx_queue(dev, qid);
+
+	__netif_tx_lock_bh(txq);
+
+	/* Send part of the packet directly to reduce the delay in sending the
+	 * packet, and this can actively trigger the tx interrupts.
+	 *
+	 * If no packet is sent out, the ring of the device is full. In this
+	 * case, we will still get a tx interrupt response. Then we will deal
+	 * with the subsequent packet sending work.
+	 */
+	virtnet_xsk_run(sq, pool, sq->napi.weight, false);
+
+	__netif_tx_unlock_bh(txq);
+
+end:
 	rcu_read_unlock();
 	return 0;
 }
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
