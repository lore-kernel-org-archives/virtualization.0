Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A436CDC9
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421785; cv=none; b=mXNPmrvSrgNbG7G7VPRTnDEBP3jCtDHnr9seRdyYm4RTR8UCaSBdzLZXRP8HRyKUGCnrbJFxlF3Hn9Bz3FigjqRpAv0YKsu619/lmGCjUqWUa7TF5+YIj8LnPeNAIziSwxqi2juaF/xSRUDNcPl3vVzxS+C8aXntCPnErdi+ixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421785; c=relaxed/simple;
	bh=nFGOTN66EYBHIJFSdfRwFSbLVouTuRCdSp1XGYuXmsM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=ffgl/m6YJBVhFh0YOch+T9eUGMogHOECRx5GJGf/VvxN7tKoO+NQ2E4t309PWTXTDzkl0jLI/gNpkKPoeMpsl/ahbc9C1sROFQuuwoMaRr95iEuELiJCRSABDjnEexVksmOAUoZXeiSOVBvmQjgG+KszTsyHfod30pjhp1o8p0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ul8faMuE; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ul8faMuE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710421781; h=From:To:Subject:Date:Message-Id;
	bh=9cg0YmvU1dEAlXAmjaFA5LI9pkxdwF3xbmIa6kg2jwc=;
	b=Ul8faMuEPwK3yItz8NbhTfs5kfzOwieRNBn19RVSzZ3j+gZ17zhNQi2dyPpwE3g+Rt0gu4GTM1y4fyHBN06pJAVZa7mcfBeVbRUCP+7v+l38FhrZLtVM2LxBaP7E0MMbPoKDcPrwpZgDlAfcYBRyz4q37aZTeCVvLi/sefcp7Ew=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W2Sx1l3_1710421776;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W2Sx1l3_1710421776)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 21:09:37 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "David S. Miller" <davem@davemloft.net>,
	Tal Gilboa <talgi@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [RFC PATCH 2/2] virtio-net: support net sysfs to fine-tune dim profile
Date: Thu, 14 Mar 2024 21:09:33 +0800
Message-Id: <1710421773-61277-3-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com>
References: <1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Virtio-net has different types of back-end device
implementations. In order to effectively optimize
the dim library's gains for different device
implementations, let's use the interface provided
by net-sysfs to fine-tune the profile list.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e709d44..7fae737 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -57,6 +57,16 @@
 
 #define VIRTNET_DRIVER_VERSION "1.0.0"
 
+/* This is copied from NET_DIM_RX_EQE_PROFILES in DIM library */
+#define VIRTNET_DIM_RX_PKTS 256
+static struct dim_cq_moder rx_itr_conf[] = {
+	{.usec = 1,   .pkts = VIRTNET_DIM_RX_PKTS,},
+	{.usec = 8,   .pkts = VIRTNET_DIM_RX_PKTS,},
+	{.usec = 64,  .pkts = VIRTNET_DIM_RX_PKTS,},
+	{.usec = 128, .pkts = VIRTNET_DIM_RX_PKTS,},
+	{.usec = 256, .pkts = VIRTNET_DIM_RX_PKTS,}
+};
+
 static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO4,
 	VIRTIO_NET_F_GUEST_TSO6,
@@ -3584,7 +3594,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 		if (!rq->dim_enabled)
 			continue;
 
-		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+		if (dim->profile_ix >= ARRAY_SIZE(rx_itr_conf))
+			dim->profile_ix = ARRAY_SIZE(rx_itr_conf) - 1;
+
+		update_moder = rx_itr_conf[dim->profile_ix];
 		if (update_moder.usec != rq->intr_coal.max_usecs ||
 		    update_moder.pkts != rq->intr_coal.max_packets) {
 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
@@ -4170,6 +4183,53 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
 		   jiffies_to_usecs(jiffies - READ_ONCE(txq->trans_start)));
 }
 
+static int virtnet_dim_moder_valid(struct net_device *dev, struct dim_profs_list *list)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		return -EOPNOTSUPP;
+
+	if (!list || list->direction != DIM_RX_DIRECTION ||
+	    list->num != NET_DIM_PARAMS_NUM_PROFILES ||
+	    list->mode != DIM_CQ_PERIOD_MODE_START_FROM_EQE) {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int virtnet_dim_moder_get(struct net_device *dev, struct dim_profs_list *list)
+{
+	int ret;
+
+	ret = virtnet_dim_moder_valid(dev, list);
+	if (ret)
+		return ret;
+
+	memcpy(list->profs, rx_itr_conf, sizeof(*list->profs) * list->num);
+
+	return 0;
+}
+
+static int virtnet_dim_moder_set(struct net_device *dev, struct dim_profs_list *list)
+{
+	int i, ret;
+
+	ret = virtnet_dim_moder_valid(dev, list);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < list->num; i++) {
+		rx_itr_conf[i].usec = list->profs[i].usec;
+		rx_itr_conf[i].pkts = list->profs[i].pkts;
+		if (list->profs[i].comps)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct net_device_ops virtnet_netdev = {
 	.ndo_open            = virtnet_open,
 	.ndo_stop   	     = virtnet_close,
@@ -4186,6 +4246,8 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
 	.ndo_tx_timeout		= virtnet_tx_timeout,
+	.ndo_dim_moder_get      = virtnet_dim_moder_get,
+	.ndo_dim_moder_set      = virtnet_dim_moder_set,
 };
 
 static void virtnet_config_changed_work(struct work_struct *work)
-- 
1.8.3.1

