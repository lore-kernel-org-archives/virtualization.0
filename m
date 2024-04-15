Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733F4085D
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173809; cv=none; b=Wtqdm8aHCw0GMQa94AbbaI9hM5FwHAgquTKx2TxRQS0+gZul7SnfGELwzTg7GScroScxMMJ8qOjXIwyCFIwCiJLTIQYrczrPFwYCj9/BvV+ywkK4aKdxTddC6kPrUv2XSJdPffHaI1uhybhmjXIAUUyOuzXWugy4X8taMSNVbCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173809; c=relaxed/simple;
	bh=pifj9zvhf0NyoaQdk6oGKwNjHWeqgKuoVAkufW8Lz5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YnhvMXp6ULa31kLspWC8+7Q/u00bOBvsIweG7cBCChRePVoFVv7a1EUOJk6Pj+eTOYaoWm8HTEUStcSz9uWG+bF6M97bX60VA3ErnLiknue9qU0Lj3v5FDMB/28xe7HzZTczw1CK+eILkerDVqf2QrADDa1fU46HKDmViI8NxS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xOue0+nH; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xOue0+nH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713173804; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GrUJ4m+2Is21O/yU23bw1HcAP+yiVjU6m9CC3U+gc+s=;
	b=xOue0+nHZxuuXAicwylcRvm/Ebpmvrp3xf5ibSfL4pmy/eB7vRr4Qps83hQnjQmW4VOeIwKjSVugmjfh9tdb8UBvRzySGTWtJYZn0L6Y/Ew23crukoddU23vNcEzqc9fovPcbEawFHsLrG4hE+MmEMVsToQVC22iuMDGZ7TR3Ko=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W4ZzP6h_1713173803;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4ZzP6h_1713173803)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 17:36:44 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v7 4/4] virtio-net: support dim profile fine-tuning
Date: Mon, 15 Apr 2024 17:36:38 +0800
Message-Id: <20240415093638.123962-5-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240415093638.123962-1-hengqi@linux.alibaba.com>
References: <20240415093638.123962-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio-net has different types of back-end device implementations.
In order to effectively optimize the dim library's gains for
different device implementations, let's use the new interface
params to fine-tune the profile list.

Since the profile now exists in netdevice, adding a function similar
to net_dim_get_rx_moderation_dev() with netdevice as argument is
nice, but this would be better along with cleaning up the rest of
the drivers, which we can get to very soon after this set.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e8fbee204bf0..f31c27ad3f85 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3584,7 +3584,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 		if (!rq->dim_enabled)
 			continue;
 
-		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+		update_moder = dev->moderation->rx_eqe_profile[dim->profile_ix];
 		if (update_moder.usec != rq->intr_coal.max_usecs ||
 		    update_moder.pkts != rq->intr_coal.max_packets) {
 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
@@ -3868,7 +3868,8 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
+		ETHTOOL_COALESCE_RX_EQE_PROFILE,
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
@@ -4424,6 +4425,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 static void virtnet_dim_init(struct virtnet_info *vi)
 {
+	struct netdev_profile_moder *moder = vi->dev->moderation;
 	int i;
 
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
@@ -4433,6 +4435,8 @@ static void virtnet_dim_init(struct virtnet_info *vi)
 		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
 		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 	}
+
+	moder->flags |= NETDEV_PROFILE_USEC | NETDEV_PROFILE_PKTS;
 }
 
 static int virtnet_alloc_queues(struct virtnet_info *vi)
-- 
2.32.0.3.g01195cf9f

