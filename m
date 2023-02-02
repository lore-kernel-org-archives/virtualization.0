Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCE7C05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 11:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1717C40C37;
	Thu,  2 Feb 2023 11:01:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1717C40C37
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1pMJruV_TQNv; Thu,  2 Feb 2023 11:01:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8D5C740C60;
	Thu,  2 Feb 2023 11:01:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D5C740C60
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 749EAC0082;
	Thu,  2 Feb 2023 11:01:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D825EC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2CF981293
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A2CF981293
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ymi-C87acjK9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7084E81F25
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7084E81F25
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:25 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VaktKQe_1675335680; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VaktKQe_1675335680) by smtp.aliyun-inc.com;
 Thu, 02 Feb 2023 19:01:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 19/33] virtio_net: introduce virtnet_tx_reset()
Date: Thu,  2 Feb 2023 19:00:44 +0800
Message-Id: <20230202110058.130695-20-xuanzhuo@linux.alibaba.com>
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

Introduce virtnet_tx_reset() to release the buffers inside virtio ring.

This is needed for xsk disable. When disable xsk, we need to relese the
buffer from xsk, so this function is needed.

This patch reuse the virtnet_tx_resize.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 21 ++++++++++++++++++---
 drivers/net/virtio/virtio_net.h |  1 +
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index fb82035a0b7f..049a3bb9d88d 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -1806,8 +1806,8 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	return err;
 }
 
-static int virtnet_tx_resize(struct virtnet_info *vi,
-			     struct send_queue *sq, u32 ring_num)
+static int __virtnet_tx_reset(struct virtnet_info *vi,
+			      struct send_queue *sq, u32 ring_num)
 {
 	bool running = netif_running(vi->dev);
 	struct netdev_queue *txq;
@@ -1833,7 +1833,11 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 
 	__netif_tx_unlock_bh(txq);
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
+	if (ring_num)
+		err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
+	else
+		err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
+
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
 
@@ -1847,6 +1851,17 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 	return err;
 }
 
+static int virtnet_tx_resize(struct virtnet_info *vi,
+			     struct send_queue *sq, u32 ring_num)
+{
+	return __virtnet_tx_reset(vi, sq, ring_num);
+}
+
+int virtnet_tx_reset(struct virtnet_info *vi, struct send_queue *sq)
+{
+	return __virtnet_tx_reset(vi, sq, 0);
+}
+
 /*
  * Send command via the control virtqueue and check status.  Commands
  * supported by the hypervisor, as indicated by feature bits, should
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index af3e7e817f9e..b46f083a630a 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -273,4 +273,5 @@ int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			struct net_device *dev,
 			unsigned int *xdp_xmit,
 			struct virtnet_rq_stats *stats);
+int virtnet_tx_reset(struct virtnet_info *vi, struct send_queue *sq);
 #endif
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
