Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04EB12A174
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270605; cv=none; b=IYf5t17+LfbQk5SdQ6itOi7yXQDSoccvUOvOBzXJT73VLIuszwGjT2qSQO5ADWf2fPfrwrrVLWoPd5ClIsORNQk9DOIUvNOB0ix8jS36zAIpDjDsBWETPfyHMNQWpivHc9iRqkDwQSiyQ1Qr1SF+1qhAnM0Im2ieskraqJzjrjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270605; c=relaxed/simple;
	bh=kZK53Rp7KIpAwByil0yRyktDOIYGEO2VhYRieEn3Zao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WqHC7bomn0+17IjD5ytWwkgWM2DXL5GRgUh++CC6S55Ve4ucw9SJuPzydb5UE6fQE21owJVHFnqepa3k0H8j0dyUIHNQxXS7qtDvQ6L0x9bFmL7raIAnrkSkKNzRdxStTtekZIV2ehae3mTBC/GM78alx52zeB9D9WL8c1TTsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v6GLNlpJ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v6GLNlpJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713270595; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tPqiRwVSaLEAe+HcvyM29Do3zQovGanj54XR1XFNne0=;
	b=v6GLNlpJh/9ijYpP4ds6rj+E8KakziWJMse4yGoY2EIGBpUfkmFHNJLKlP0CJe/1Db+fd0mH7/1vGCaQ6b6Jqzu02NZNp1FR1Gno+SPAAsxwrjLa29zBhgD4KSHc0Mdh41Sd4PFtSR5cmCxP28Rwc7WkfAtkYm5VYHOzSrqnTq0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4hxV83_1713270594;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4hxV83_1713270594)
          by smtp.aliyun-inc.com;
          Tue, 16 Apr 2024 20:29:55 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v8 3/4] virtio-net: refactor dim initialization/destruction
Date: Tue, 16 Apr 2024 20:29:49 +0800
Message-Id: <20240416122950.39046-4-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240416122950.39046-1-hengqi@linux.alibaba.com>
References: <20240416122950.39046-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the initialization and destruction actions
of dim for use in the next patch.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 115c3c5414f2..858d7ab89e34 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2274,6 +2274,13 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	return err;
 }
 
+static void virtnet_dim_clean(struct virtnet_info *vi,
+			      int start_qnum, int end_qnum)
+{
+	for (; start_qnum <= end_qnum; start_qnum++)
+		cancel_work_sync(&vi->rq[start_qnum].dim.work);
+}
+
 static int virtnet_open(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -2297,11 +2304,9 @@ static int virtnet_open(struct net_device *dev)
 err_enable_qp:
 	disable_delayed_refill(vi);
 	cancel_delayed_work_sync(&vi->refill);
-
-	for (i--; i >= 0; i--) {
+	virtnet_dim_clean(vi, 0, i - 1);
+	for (i--; i >= 0; i--)
 		virtnet_disable_queue_pair(vi, i);
-		cancel_work_sync(&vi->rq[i].dim.work);
-	}
 
 	return err;
 }
@@ -2466,7 +2471,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 
 	if (running) {
 		napi_disable(&rq->napi);
-		cancel_work_sync(&rq->dim.work);
+		virtnet_dim_clean(vi, qindex, qindex);
 	}
 
 	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
@@ -2716,10 +2721,9 @@ static int virtnet_close(struct net_device *dev)
 	/* Make sure refill_work doesn't re-enable napi! */
 	cancel_delayed_work_sync(&vi->refill);
 
-	for (i = 0; i < vi->max_queue_pairs; i++) {
+	virtnet_dim_clean(vi, 0, vi->max_queue_pairs - 1);
+	for (i = 0; i < vi->max_queue_pairs; i++)
 		virtnet_disable_queue_pair(vi, i);
-		cancel_work_sync(&vi->rq[i].dim.work);
-	}
 
 	return 0;
 }
@@ -4434,6 +4438,19 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	return ret;
 }
 
+static void virtnet_dim_init(struct virtnet_info *vi)
+{
+	int i;
+
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		return;
+
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
+		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+	}
+}
+
 static int virtnet_alloc_queues(struct virtnet_info *vi)
 {
 	int i;
@@ -4461,9 +4478,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 					 virtnet_poll_tx,
 					 napi_tx ? napi_weight : 0);
 
-		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
-		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
-
 		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
 		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
 		sg_init_table(vi->sq[i].sg, ARRAY_SIZE(vi->sq[i].sg));
@@ -4873,6 +4887,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	virtnet_dim_init(vi);
+
 	_virtnet_set_queues(vi, vi->curr_queue_pairs);
 
 	/* a random MAC address has been assigned, notify the device.
-- 
2.32.0.3.g01195cf9f

