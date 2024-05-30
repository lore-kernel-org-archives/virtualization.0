Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43D142E7C
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054020; cv=none; b=XWK8rVJpjqLAdVDTI0azJn/K2kYmsC0Wn7LM2F/ydq7agN6X1zP6taKk/XY9CA/3zy/KPqFLIR8OzKDEyc87S4Ok+ox4w+sBze71QrMLkvJtt6h/ROJBFyIGMdeRcu8eWADVIUJH8pRrLyi812pNeY1JGsFhI+j9Hpr15Z2Jx3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054020; c=relaxed/simple;
	bh=u6jVS5wttRoZd6vJokwIP/uA1bUbIOhknKCiKbcyBzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bBdDEeoGdWNZq4i46kSQ+ggSxF6NpWaap7Ktyq8iunMOaemrqcWQe7wQcHNrtDv7t6Qfu7Z24DR+RKMAaZZ35ZuxSCOmc3Zb+BGdJYmComSi4D+YqqQJMFTdne6Ymvg0ac9oeoH8qUnAxwZlwMBYVmlWy3+qZG3vteLwUYVzCbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fPtrPtgJ; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fPtrPtgJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717054015; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OZJv/rmnooQqQ6gH8tT4WEIgPwRt/yTX4QOZHhqarUM=;
	b=fPtrPtgJIQwz36ku7oVmkX72plTfimBvkyyz1GPdHAfkdmcTn3LWbr5ZKjpxX3HDiQinG56VG8a16iaWgduHS7pKoKLNrj/FnHq0t9TJFT7wpvNrx8a9tQDDOVdmF6KNIbK8xuDYYwcfLgeUezpZQf+GJkOAYhREmUvQhtMJ9V4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W7WBAxZ_1717054014;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7WBAxZ_1717054014)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 15:26:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v1 5/7] virtio_net: separate virtnet_tx_resize()
Date: Thu, 30 May 2024 15:26:47 +0800
Message-Id: <20240530072649.102437-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240530072649.102437-1-xuanzhuo@linux.alibaba.com>
References: <20240530072649.102437-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 12be1d34ab2c
Content-Transfer-Encoding: 8bit

This patch separates two sub-functions from virtnet_tx_resize():

* virtnet_tx_pause
* virtnet_tx_resume

Then the subsequent virtnet_tx_reset() can share these two functions.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio/virtnet.h      |  2 ++
 drivers/net/virtio/virtnet_main.c | 35 +++++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio/virtnet.h b/drivers/net/virtio/virtnet.h
index b0f2ae4bd1c4..b56ebc7fcdcc 100644
--- a/drivers/net/virtio/virtnet.h
+++ b/drivers/net/virtio/virtnet.h
@@ -239,4 +239,6 @@ struct virtnet_info {
 
 void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
+void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
+void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq);
 #endif
diff --git a/drivers/net/virtio/virtnet_main.c b/drivers/net/virtio/virtnet_main.c
index a2bf576e644c..285443da040c 100644
--- a/drivers/net/virtio/virtnet_main.c
+++ b/drivers/net/virtio/virtnet_main.c
@@ -2416,12 +2416,11 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	return err;
 }
 
-static int virtnet_tx_resize(struct virtnet_info *vi,
-			     struct virtnet_sq *sq, u32 ring_num)
+void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq)
 {
 	bool running = netif_running(vi->dev);
 	struct netdev_queue *txq;
-	int err, qindex;
+	int qindex;
 
 	qindex = sq - vi->sq;
 
@@ -2442,10 +2441,17 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 	netif_stop_subqueue(vi->dev, qindex);
 
 	__netif_tx_unlock_bh(txq);
+}
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
-	if (err)
-		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
+void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq)
+{
+	bool running = netif_running(vi->dev);
+	struct netdev_queue *txq;
+	int qindex;
+
+	qindex = sq - vi->sq;
+
+	txq = netdev_get_tx_queue(vi->dev, qindex);
 
 	__netif_tx_lock_bh(txq);
 	sq->reset = false;
@@ -2454,6 +2460,23 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 
 	if (running)
 		virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+}
+
+static int virtnet_tx_resize(struct virtnet_info *vi, struct virtnet_sq *sq,
+			     u32 ring_num)
+{
+	int qindex, err;
+
+	qindex = sq - vi->sq;
+
+	virtnet_tx_pause(vi, sq);
+
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
+	if (err)
+		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
+
+	virtnet_tx_resume(vi, sq);
+
 	return err;
 }
 
-- 
2.32.0.3.g01195cf9f

