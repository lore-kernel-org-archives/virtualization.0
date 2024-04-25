Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C51494D5
	for <virtualization@lists.linux.dev>; Thu, 25 Apr 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049943; cv=none; b=J5Am9dG+K4axmV7GoppjD5K4YM+/xixk3eR5REZQHCsQjJDmBUWAX0qemnVcst95xcS2LMHnkrTDPzNjgOgy9m938jP9oRGXkaqqPRHp+t17H64t3GkfjYPVTtYndDB4U1uzWQx7I/d1gmK7lxLiNm3XbXW2a5cM7AmwvZyV0Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049943; c=relaxed/simple;
	bh=K84XKgK8KHbPWO0USuhlDpFa7QEvOPAwxpnWhm88NN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pUJ/gLMPu1GYsbhYuO4yQZec/LsQdCe4Pux1kOYesAHcLtl0HCYutFkeXbGnBguoF2tjNO04IdQZ37Ak0kI3ioJqd56Sgenx7UELU2jkaXi20jMaJd2rntnOTGa+Ar7/Gz9J3duv7eg6y/sqRBRKee9fq9T5pzK41bwfXC0CU/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xcP3Pwkz; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xcP3Pwkz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714049938; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bdjvXFYRnrSQReYwqmP/hdq3je0IOyW7L9cgHEAJbgA=;
	b=xcP3PwkzBhsKZn2HFkyyHbTZUUC+8xTwOXWcE6jpry4DKBT9JwLT7CIcVduDRYOM0/Z/qWy8JcIuJaAbleFJS3yEagWwtRDG39mwHgxRfl/JLjM2md0MZhFiu9nvgLJ6jTvsucDMk/usjJf54Zy/trZ3g/IXx6faN3Lc5kQ53Es=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5FdWV7_1714049936;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5FdWV7_1714049936)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 20:58:57 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/3] virtio_net: enable irq for the control vq
Date: Thu, 25 Apr 2024 20:58:53 +0800
Message-Id: <20240425125855.87025-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240425125855.87025-1-hengqi@linux.alibaba.com>
References: <20240425125855.87025-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Control vq polling request results consume more CPU.
Especially when dim issues more control requests to the device,
it's beneficial to the guest to enable control vq's irq.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 45 ++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a4d3c76654a4..79a1b30c173c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -287,6 +287,12 @@ struct virtnet_info {
 	bool has_cvq;
 	struct mutex cvq_lock;
 
+	/* Wait for the device to complete the request */
+	struct completion completion;
+
+	/* Work struct for acquisition of cvq processing results. */
+	struct work_struct get_cvq;
+
 	/* Host can handle any s/g split between our header and packet data */
 	bool any_header_sg;
 
@@ -520,6 +526,13 @@ static bool virtqueue_napi_complete(struct napi_struct *napi,
 	return false;
 }
 
+static void virtnet_cvq_done(struct virtqueue *cvq)
+{
+	struct virtnet_info *vi = cvq->vdev->priv;
+
+	schedule_work(&vi->get_cvq);
+}
+
 static void skb_xmit_done(struct virtqueue *vq)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
@@ -2036,6 +2049,20 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 	return !oom;
 }
 
+static void virtnet_get_cvq_work(struct work_struct *work)
+{
+	struct virtnet_info *vi =
+		container_of(work, struct virtnet_info, get_cvq);
+	unsigned int tmp;
+	void *res;
+
+	mutex_lock(&vi->cvq_lock);
+	res = virtqueue_get_buf(vi->cvq, &tmp);
+	if (res)
+		complete(&vi->completion);
+	mutex_unlock(&vi->cvq_lock);
+}
+
 static void skb_recv_done(struct virtqueue *rvq)
 {
 	struct virtnet_info *vi = rvq->vdev->priv;
@@ -2531,7 +2558,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 				 struct scatterlist *out)
 {
 	struct scatterlist *sgs[4], hdr, stat;
-	unsigned out_num = 0, tmp;
+	unsigned out_num = 0;
 	int ret;
 
 	/* Caller should know better */
@@ -2566,16 +2593,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 		return vi->ctrl->status == VIRTIO_NET_OK;
 	}
 
-	/* Spin for a response, the kick causes an ioport write, trapping
-	 * into the hypervisor, so the request should be handled immediately.
-	 */
-	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
-	       !virtqueue_is_broken(vi->cvq)) {
-		cond_resched();
-		cpu_relax();
-	}
-
 	mutex_unlock(&vi->cvq_lock);
+
+	wait_for_completion(&vi->completion);
+
 	return vi->ctrl->status == VIRTIO_NET_OK;
 }
 
@@ -4433,7 +4454,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 	/* Parameters for control virtqueue, if any */
 	if (vi->has_cvq) {
-		callbacks[total_vqs - 1] = NULL;
+		callbacks[total_vqs - 1] = virtnet_cvq_done;
 		names[total_vqs - 1] = "control";
 	}
 
@@ -4952,6 +4973,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report)
 		virtnet_init_default_rss(vi);
 
+	INIT_WORK(&vi->get_cvq, virtnet_get_cvq_work);
+	init_completion(&vi->completion);
 	enable_rx_mode_work(vi);
 
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
-- 
2.32.0.3.g01195cf9f

