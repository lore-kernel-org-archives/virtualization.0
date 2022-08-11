Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DEAC25B0C
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 08:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 395D440C56;
	Thu, 11 Aug 2022 08:03:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 395D440C56
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YxkeWXl36Q7q; Thu, 11 Aug 2022 08:03:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C924640C66;
	Thu, 11 Aug 2022 08:03:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C924640C66
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12CFEC007C;
	Thu, 11 Aug 2022 08:03:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C09A4C007B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 962D0828DF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:03:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 962D0828DF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id efnC-KtnRDpi
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:03:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B55A828DA
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B55A828DA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:03:07 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R721e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0VLyDHfr_1660204980; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VLyDHfr_1660204980) by smtp.aliyun-inc.com;
 Thu, 11 Aug 2022 16:03:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] virtio_net: fix for stuck when change tx ring size with
 dev down
Date: Thu, 11 Aug 2022 16:02:58 +0800
Message-Id: <20220811080258.79398-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220811080258.79398-1-xuanzhuo@linux.alibaba.com>
References: <20220811080258.79398-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 4d0f44f05adf
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Kangjie Xu <kangjie.xu@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

When dev is set to DOWN state, napi has been disabled, if we modify the
ring size at this time, we should not call napi_disable() again, which
will cause stuck.

And all operations are under the protection of rtnl_lock, so there is no
need to consider concurrency issues.

Reported-by: Kangjie Xu <kangjie.xu@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 17687eb3f0bd..d9c434b00e9b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1915,12 +1915,14 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 static int virtnet_tx_resize(struct virtnet_info *vi,
 			     struct send_queue *sq, u32 ring_num)
 {
+	bool running = netif_running(vi->dev);
 	struct netdev_queue *txq;
 	int err, qindex;
 
 	qindex = sq - vi->sq;
 
-	virtnet_napi_tx_disable(&sq->napi);
+	if (running)
+		virtnet_napi_tx_disable(&sq->napi);
 
 	txq = netdev_get_tx_queue(vi->dev, qindex);
 
@@ -1946,7 +1948,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 	netif_tx_wake_queue(txq);
 	__netif_tx_unlock_bh(txq);
 
-	virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+	if (running)
+		virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
 	return err;
 }
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
