Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122C156DA
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8B9B81F8B
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 05:56:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8B9B81F8B
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E44Ba6wEUDwJ
	for <virtualization@lists.linux-foundation.org>;
	Tue, 14 Nov 2023 05:56:02 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AEA9981ED5
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 05:56:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AEA9981ED5
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VwOFULA_1699941354;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VwOFULA_1699941354)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 13:55:55 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH net-next v3 5/5] virtio-net: return -EOPNOTSUPP for adaptive-tx
Date: Tue, 14 Nov 2023 13:55:47 +0800
Message-Id: <6a79229fbeb72edf41185a45a0f9ea5cd87a1086.1699938946.git.hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1699938946.git.hengqi@linux.alibaba.com>
References: <cover.1699938946.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not currently support tx dim, so respond to -EOPNOTSUPP.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
v1->v2:
- Use -EOPNOTSUPP instead of specific implementation.

 drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index bc32d5aae005..b082f2acbb22 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3364,9 +3364,15 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
 static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec)
 {
+	bool tx_ctrl_dim_on = !!ec->use_adaptive_tx_coalesce;
 	struct scatterlist sgs_tx;
 	int i;
 
+	if (tx_ctrl_dim_on) {
+		pr_debug("Failed to enable adaptive-tx, which is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
 	vi->ctrl->coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
 	sg_init_one(&sgs_tx, &vi->ctrl->coal_tx, sizeof(vi->ctrl->coal_tx));
@@ -3501,6 +3507,25 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
 	return 0;
 }
 
+static int virtnet_send_tx_notf_coal_vq_cmds(struct virtnet_info *vi,
+					     struct ethtool_coalesce *ec,
+					     u16 queue)
+{
+	bool tx_ctrl_dim_on = !!ec->use_adaptive_tx_coalesce;
+	int err;
+
+	if (tx_ctrl_dim_on) {
+		pr_debug("Enabling adaptive-tx for txq%d is not supported\n", queue);
+		return -EOPNOTSUPP;
+	}
+
+	err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
+					       ec->tx_coalesce_usecs,
+					       ec->tx_max_coalesced_frames);
+
+	return err;
+}
+
 static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec,
 					  u16 queue)
@@ -3511,9 +3536,7 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
 	if (err)
 		return err;
 
-	err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, queue,
-					       ec->tx_coalesce_usecs,
-					       ec->tx_max_coalesced_frames);
+	err = virtnet_send_tx_notf_coal_vq_cmds(vi, ec, queue);
 	if (err)
 		return err;
 
-- 
2.19.1.6.gb485710b

