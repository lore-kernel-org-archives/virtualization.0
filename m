Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D81482F4
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369362; cv=none; b=M42zhceTn+Q5w1kHGXW6JFQ2f3jmlU2FMT8jkuHe+nKfu61TMuG/rbQ0RRNEDDdXafoCUW9GEFSEtnIAPQWujFkwxKeY5Z7Of2iMdvWu4LjoPG9iMXQ2JTqSYBVY7DIsan2Z2uHifDz1iRs5+SLlmf7PSL+Ihp9rITgzX+9mfek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369362; c=relaxed/simple;
	bh=Y7aVU+Yvd42Ru644LJeGMg1Z6uAGCvMyrYuVbR2AZ2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LUl6S8KgL455RSGnXmwhx4WAA4yxNilZOljN9BVKfgj8WBnimX9xHj0TUg0BaFrjrDFhPj/f63FsfZLjG3LTKwyt9VQUBxGEo08RSP57JdViSCKGAmhiy0UvMpC3En9SvHkYC3v0eT2t9iAmN7zillrrxt6GLtFYp8FCr0jMcGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qXLo920N; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qXLo920N"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713369353; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=pD4eGjoRhd08IwOJQU2fyyVO7s5eSR6uO/l4PM+ufGE=;
	b=qXLo920NF9uMQFMz4Qez71iFaq73EmIwuxE7DbJDbeCsEy5BOOKRJG0wgGdZM7dndVrJEZb95rVOr5o+jF5HFL1Usn+7BMzt7rIucSq/5WAouwNq3LPgEfRZ4pzAm2+SFfTVR6rZG7wO9KzDdyYP76VxlYhL6XHQt3q3QBm9MP8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W4m.siJ_1713369351;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4m.siJ_1713369351)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 23:55:52 +0800
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
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"justinstitt@google.com" <justinstitt@google.com>
Subject: [PATCH net-next v9 4/4] virtio-net: support dim profile fine-tuning
Date: Wed, 17 Apr 2024 23:55:46 +0800
Message-Id: <20240417155546.25691-5-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240417155546.25691-1-hengqi@linux.alibaba.com>
References: <20240417155546.25691-1-hengqi@linux.alibaba.com>
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
index 858d7ab89e34..1f7201b82be6 100644
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
@@ -3884,7 +3884,8 @@ static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
 
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
-		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
+		ETHTOOL_COALESCE_RX_EQE_PROFILE,
 	.get_drvinfo = virtnet_get_drvinfo,
 	.get_link = ethtool_op_get_link,
 	.get_ringparam = virtnet_get_ringparam,
@@ -4440,6 +4441,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 static void virtnet_dim_init(struct virtnet_info *vi)
 {
+	struct netdev_profile_moder *moder = vi->dev->moderation;
 	int i;
 
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
@@ -4449,6 +4451,8 @@ static void virtnet_dim_init(struct virtnet_info *vi)
 		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
 		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 	}
+
+	moder->flags |= NETDEV_PROFILE_USEC | NETDEV_PROFILE_PKTS;
 }
 
 static int virtnet_alloc_queues(struct virtnet_info *vi)
-- 
2.32.0.3.g01195cf9f

