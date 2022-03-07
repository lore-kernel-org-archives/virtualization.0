Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDDEC433F5
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 09:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C318C60B8F;
	Mon,  7 Mar 2022 09:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1NTFYFkDAbMx; Mon,  7 Mar 2022 09:40:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CD98260AC0;
	Mon,  7 Mar 2022 09:40:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D7C9C001D;
	Mon,  7 Mar 2022 09:40:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63216C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3EBD840991
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VpSLyePpxkRF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:40:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3034640943
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 09:40:46 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0V6UND1m_1646646042; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6UND1m_1646646042) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 07 Mar 2022 17:40:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost] virtio_net: fix build warnings
Date: Mon,  7 Mar 2022 17:40:42 +0800
Message-Id: <20220307094042.22180-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-Git-Hash: b3c21a590cee
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

These warnings appear on some platforms (arm multi_v7_defconfig). This
patch fixes these warnings.

drivers/net/virtio_net.c: In function 'virtnet_rx_vq_reset':
drivers/net/virtio_net.c:1823:63: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
 1823 |                    "reset rx reset vq fail: rx queue index: %ld err: %d\n",
      |                                                             ~~^
      |                                                               |
      |                                                               long int
      |                                                             %d
 1824 |                    rq - vi->rq, err);
      |                    ~~~~~~~~~~~
      |                       |
      |                       int
drivers/net/virtio_net.c: In function 'virtnet_tx_vq_reset':
drivers/net/virtio_net.c:1873:63: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
 1873 |                    "reset tx reset vq fail: tx queue index: %ld err: %d\n",
      |                                                             ~~^
      |                                                               |
      |                                                               long int
      |                                                             %d
 1874 |                    sq - vi->sq, err);
      |                    ~~~~~~~~~~~
      |                       |
      |                       int

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1fa2d632a994..4d629d1ea894 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1820,7 +1820,7 @@ static int virtnet_rx_vq_reset(struct virtnet_info *vi,
 
 err:
 	netdev_err(vi->dev,
-		   "reset rx reset vq fail: rx queue index: %ld err: %d\n",
+		   "reset rx reset vq fail: rx queue index: %td err: %d\n",
 		   rq - vi->rq, err);
 	virtnet_napi_enable(rq->vq, &rq->napi);
 	return err;
@@ -1870,7 +1870,7 @@ static int virtnet_tx_vq_reset(struct virtnet_info *vi,
 
 err:
 	netdev_err(vi->dev,
-		   "reset tx reset vq fail: tx queue index: %ld err: %d\n",
+		   "reset tx reset vq fail: tx queue index: %td err: %d\n",
 		   sq - vi->sq, err);
 	virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
 	return err;
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
