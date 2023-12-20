Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22118E0B
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CE5781A8E
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:07:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CE5781A8E
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0dh1U-VVcWYB
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 08:07:36 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 65168813CB
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:07:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65168813CB
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vytfnwx_1703059647;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vytfnwx_1703059647)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 16:07:28 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next] virtio-net: switch napi_tx without downing nic
Date: Wed, 20 Dec 2023 16:07:27 +0800
Message-Id: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio-net has two ways to switch napi_tx: one is through the
module parameter, and the other is through coalescing parameter
settings (provided that the nic status is down).

Sometimes we face performance regression caused by napi_tx,
then we need to switch napi_tx when debugging. However, the
existing methods are a bit troublesome, such as needing to
reload the driver or turn off the network card. So try to make
this update.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 81 ++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 44 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 10614e9f7cad..12f8e1f9971c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3559,16 +3559,37 @@ static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
 	return 0;
 }
 
-static int virtnet_should_update_vq_weight(int dev_flags, int weight,
-					   int vq_weight, bool *should_update)
+static void virtnet_switch_napi_tx(struct virtnet_info *vi, u32 qstart,
+				   u32 qend, u32 tx_frames)
 {
-	if (weight ^ vq_weight) {
-		if (dev_flags & IFF_UP)
-			return -EBUSY;
-		*should_update = true;
-	}
+	struct net_device *dev = vi->dev;
+	int new_weight, cur_weight;
+	struct netdev_queue *txq;
+	struct send_queue *sq;
 
-	return 0;
+	new_weight = tx_frames ? NAPI_POLL_WEIGHT : 0;
+	for (; qstart < qend; qstart++) {
+		sq = &vi->sq[qstart];
+		cur_weight = sq->napi.weight;
+		if (!(new_weight ^ cur_weight))
+			continue;
+
+		if (!(dev->flags & IFF_UP)) {
+			sq->napi.weight = new_weight;
+			continue;
+		}
+
+		if (cur_weight)
+			virtnet_napi_tx_disable(&sq->napi);
+
+		txq = netdev_get_tx_queue(dev, qstart);
+		__netif_tx_lock_bh(txq);
+		sq->napi.weight = new_weight;
+		__netif_tx_unlock_bh(txq);
+
+		if (!cur_weight)
+			virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+	}
 }
 
 static int virtnet_set_coalesce(struct net_device *dev,
@@ -3577,25 +3598,11 @@ static int virtnet_set_coalesce(struct net_device *dev,
 				struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int ret, queue_number, napi_weight;
-	bool update_napi = false;
-
-	/* Can't change NAPI weight if the link is up */
-	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
-	for (queue_number = 0; queue_number < vi->max_queue_pairs; queue_number++) {
-		ret = virtnet_should_update_vq_weight(dev->flags, napi_weight,
-						      vi->sq[queue_number].napi.weight,
-						      &update_napi);
-		if (ret)
-			return ret;
-
-		if (update_napi) {
-			/* All queues that belong to [queue_number, vi->max_queue_pairs] will be
-			 * updated for the sake of simplicity, which might not be necessary
-			 */
-			break;
-		}
-	}
+	int ret;
+
+	/* Param tx_frames can be used to switch napi_tx */
+	virtnet_switch_napi_tx(vi, 0, vi->max_queue_pairs,
+			       ec->tx_max_coalesced_frames);
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
 		ret = virtnet_send_notf_coal_cmds(vi, ec);
@@ -3605,11 +3612,6 @@ static int virtnet_set_coalesce(struct net_device *dev,
 	if (ret)
 		return ret;
 
-	if (update_napi) {
-		for (; queue_number < vi->max_queue_pairs; queue_number++)
-			vi->sq[queue_number].napi.weight = napi_weight;
-	}
-
 	return ret;
 }
 
@@ -3641,19 +3643,13 @@ static int virtnet_set_per_queue_coalesce(struct net_device *dev,
 					  struct ethtool_coalesce *ec)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	int ret, napi_weight;
-	bool update_napi = false;
+	int ret;
 
 	if (queue >= vi->max_queue_pairs)
 		return -EINVAL;
 
-	/* Can't change NAPI weight if the link is up */
-	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
-	ret = virtnet_should_update_vq_weight(dev->flags, napi_weight,
-					      vi->sq[queue].napi.weight,
-					      &update_napi);
-	if (ret)
-		return ret;
+	/* Param tx_frames can be used to switch napi_tx */
+	virtnet_switch_napi_tx(vi, queue, queue, ec->tx_max_coalesced_frames);
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
 		ret = virtnet_send_notf_coal_vq_cmds(vi, ec, queue);
@@ -3663,9 +3659,6 @@ static int virtnet_set_per_queue_coalesce(struct net_device *dev,
 	if (ret)
 		return ret;
 
-	if (update_napi)
-		vi->sq[queue].napi.weight = napi_weight;
-
 	return 0;
 }
 
-- 
2.19.1.6.gb485710b

