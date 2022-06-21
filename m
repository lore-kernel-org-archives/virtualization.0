Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E454C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 11:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBD3483F2D;
	Tue, 21 Jun 2022 11:50:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBD3483F2D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernkonzept.com header.i=@kernkonzept.com header.a=rsa-sha256 header.s=mx1 header.b=N20iD1j4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q76A7UtYc2rW; Tue, 21 Jun 2022 11:50:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6E06983F2A;
	Tue, 21 Jun 2022 11:50:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E06983F2A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45046C0032;
	Tue, 21 Jun 2022 11:50:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D01C5C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 11:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA35961069
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 11:50:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA35961069
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernkonzept.com header.i=@kernkonzept.com
 header.a=rsa-sha256 header.s=mx1 header.b=N20iD1j4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UOEsYsixsJTY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 11:50:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D31D561067
Received: from mx.kernkonzept.com (serv1.kernkonzept.com
 [IPv6:2a01:4f8:1c1c:b490::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D31D561067
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 11:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:Message-Id
 :Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=njJuoA2Sc/56TeF9U5fuCJ1Q1iYeeVXupfO3Z71rmfU=; b=N20iD1j4QJpCbcdtTtf0vx4SfS
 v9vaHEUavFbJcnwamVJjVHTPAgSNlSJXTH6poPimDs9+bULGexIuzt+l9cAjUpktSS0RCyKacIuCp
 7mkrrtulA3TPEdxbQGC4sc5Fem19JxPiWAcf5N2zGRLSh38enkeRCc5KY2ypcoD+ovxYLed2+JLKv
 qD/IM8Xp/H194fGBE9LyVjxnqVy20zgwo5GUcbzjiUCR/QtX66QNX/o2nRLpjiZGWuqRSCMCEp5sY
 Qwl4QveMpiaAd3HMniNlZ1tVnv3oVi371F+FhewiOTracn0ddYLjmA3dk5eXCF63MrB9E/zqurcjw
 LYtHnsDA==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
 by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
 id 1o3cOK-005hVa-SB; Tue, 21 Jun 2022 13:49:56 +0200
From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH net] virtio_net: fix xdp_rxq_info bug after suspend/resume
Date: Tue, 21 Jun 2022 13:48:44 +0200
Message-Id: <20220621114845.3650258-1-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

The following sequence currently causes a driver bug warning
when using virtio_net:

  # ip link set eth0 up
  # echo mem > /sys/power/state (or e.g. # rtcwake -s 10 -m mem)
  <resume>
  # ip link set eth0 down

  Missing register, driver bug
  WARNING: CPU: 0 PID: 375 at net/core/xdp.c:138 xdp_rxq_info_unreg+0x58/0x60
  Call trace:
   xdp_rxq_info_unreg+0x58/0x60
   virtnet_close+0x58/0xac
   __dev_close_many+0xac/0x140
   __dev_change_flags+0xd8/0x210
   dev_change_flags+0x24/0x64
   do_setlink+0x230/0xdd0
   ...

This happens because virtnet_freeze() frees the receive_queue
completely (including struct xdp_rxq_info) but does not call
xdp_rxq_info_unreg(). Similarly, virtnet_restore() sets up the
receive_queue again but does not call xdp_rxq_info_reg().

Actually, parts of virtnet_freeze_down() and virtnet_restore_up()
are almost identical to virtnet_close() and virtnet_open(): only
the calls to xdp_rxq_info_(un)reg() are missing. This means that
we can fix this easily and avoid such problems in the future by
just calling virtnet_close()/open() from the freeze/restore handlers.

Aside from adding the missing xdp_rxq_info calls the only difference
is that the refill work is only cancelled if netif_running(). However,
this should not make any functional difference since the refill work
should only be active if the network interface is actually up.

Fixes: 754b8a21a96d ("virtio_net: setup xdp_rxq_info")
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/net/virtio_net.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db05b5e930be..969a67970e71 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2768,7 +2768,6 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 static void virtnet_freeze_down(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
-	int i;
 
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
@@ -2776,14 +2775,8 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
-	cancel_delayed_work_sync(&vi->refill);
-
-	if (netif_running(vi->dev)) {
-		for (i = 0; i < vi->max_queue_pairs; i++) {
-			napi_disable(&vi->rq[i].napi);
-			virtnet_napi_tx_disable(&vi->sq[i].napi);
-		}
-	}
+	if (netif_running(vi->dev))
+		virtnet_close(vi->dev);
 }
 
 static int init_vqs(struct virtnet_info *vi);
@@ -2791,7 +2784,7 @@ static int init_vqs(struct virtnet_info *vi);
 static int virtnet_restore_up(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
-	int err, i;
+	int err;
 
 	err = init_vqs(vi);
 	if (err)
@@ -2800,15 +2793,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	virtio_device_ready(vdev);
 
 	if (netif_running(vi->dev)) {
-		for (i = 0; i < vi->curr_queue_pairs; i++)
-			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
-
-		for (i = 0; i < vi->max_queue_pairs; i++) {
-			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
-			virtnet_napi_tx_enable(vi, vi->sq[i].vq,
-					       &vi->sq[i].napi);
-		}
+		err = virtnet_open(vi->dev);
+		if (err)
+			return err;
 	}
 
 	netif_tx_lock_bh(vi->dev);
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
