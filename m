Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56C17C22D
	for <virtualization@lists.linux.dev>; Tue, 11 Jun 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106118; cv=none; b=WQnvQEKELCfu67FjOsisTIpGSa+JQsOcl0q66pwkgSalHSIg4Gh0xIjCBjLDhg6BIqfh9XHIayuKSMSlAHC46AJ/KX1mSOuKJLFjyJlAuKskXdk9qgptgUw8W6ISWDDuFxYp4ipcCEHnJDRCI99mQ34QACOk05oD5rbXoaPmLeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106118; c=relaxed/simple;
	bh=dpvycL/PK0HeYJyn6r9/RWK557m02BKf3Eccd6x4xLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VkhvQGJMskTt/BXMTm9vBm27gsqn5u3bLMzeZub441qvbqs88oXHK9eidYXgX6AwPxeR2Eer4+dWtV6Oq8VNEIauAIBghIEfpRrxvXib3m80ZDjoo0t1pEaL4Rju/7a/Zw/PXXjdJluEoeFfczvUnPWLyrnyRMmXVlZZ95NX7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=l9nNhKOk; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l9nNhKOk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718106113; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+bZgsSRKnPDty/2zTa+8CikoQZlg9RVPyzoPeztif5k=;
	b=l9nNhKOkZuwoyipJ/7Kbya9zzZegj8w60lIjJ9SSXhU7fg9PD7kdql2Djrru8Z95KeMUoTbb0/GoGg+ksz/fqKX8eJFsCEN54TfCChH2EydUCESb8jBPA8QJzQfSWs+MgQ2l5R/0uGCiW0p3NJ8TBJ2iPdOS0eas2E3zXVEIepU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8GFQmC_1718106112;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8GFQmC_1718106112)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 19:41:52 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 04/15] virtio_net: separate virtnet_rx_resize()
Date: Tue, 11 Jun 2024 19:41:36 +0800
Message-Id: <20240611114147.31320-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: c1658a8c15b0
Content-Transfer-Encoding: 8bit

This patch separates two sub-functions from virtnet_rx_resize():

* virtnet_rx_pause
* virtnet_rx_resume

Then the subsequent reset rx for xsk can share these two functions.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 838b450d9591..597d2c5fccc0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2609,28 +2609,41 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static int virtnet_rx_resize(struct virtnet_info *vi,
-			     struct receive_queue *rq, u32 ring_num)
+static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 {
 	bool running = netif_running(vi->dev);
-	int err, qindex;
-
-	qindex = rq - vi->rq;
 
 	if (running) {
 		napi_disable(&rq->napi);
 		cancel_work_sync(&rq->dim.work);
 	}
+}
 
-	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
-	if (err)
-		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
+static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
+{
+	bool running = netif_running(vi->dev);
 
 	if (!try_fill_recv(vi, rq, GFP_KERNEL))
 		schedule_delayed_work(&vi->refill, 0);
 
 	if (running)
 		virtnet_napi_enable(rq->vq, &rq->napi);
+}
+
+static int virtnet_rx_resize(struct virtnet_info *vi,
+			     struct receive_queue *rq, u32 ring_num)
+{
+	int err, qindex;
+
+	qindex = rq - vi->rq;
+
+	virtnet_rx_pause(vi, rq);
+
+	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
+	if (err)
+		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
+
+	virtnet_rx_resume(vi, rq);
 	return err;
 }
 
-- 
2.32.0.3.g01195cf9f

