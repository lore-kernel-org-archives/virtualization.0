Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817F19CD1F
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697409; cv=none; b=UgmmNTYDHdaRDQ9X4Ne7JiMV0aZ6AbwRSLtmBGmqd6p02+03PEQHMYZgowD014VxNxvsYUuF5q6zjp+LZ/CEHw7FBqPTlOX5+H6/Fnsdq0UkNZgQgIaEhJ7y/KouAmPnIa/uHjcqfmEOp9J/Tcids2nVNDeyXsIvO97nDt7V/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697409; c=relaxed/simple;
	bh=jl6UJTABbEdU+rA4QZQp0/vIyzSqNdFSOq+02rXhgL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DewXtnzO2nfP63b5e6pJKoQkJ1fAfE3OAhXXbSt/LB2Hz2aZv4c0XjPm/TA2h7wUh2ITViYNSsaalgrNBtNXHRCA2isdkh8ByIo68zd9ENCkMkhLlg2Q2aFoIoV28jhaJIb4ondiGPZ+/QKsYXUY/B6gWb1I3SNfaFqLXP+KhKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iiiF6OeQ; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iiiF6OeQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718697405; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QKx8SD5y5bxYJMN+tvUXEDSoDlk2xgxFxidchf2RPwc=;
	b=iiiF6OeQ/VavwqihtLwsqjy576Fql69cLD337grweIl0lpodUezY8w6butAWcA5zXRxyGLekzXz5RRGx3WpuHMM8IdvrVpu5JVR87SCVemaQFRIL3v9T/NRKLue8mdNgzO4F7kXsR67EV6/mhxJyFhEske9m/Ek0NzMUQFE4Rfo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8jRu8U_1718697404;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8jRu8U_1718697404)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 15:56:44 +0800
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
Subject: [PATCH net-next v6 01/10] virtio_net: separate virtnet_rx_resize()
Date: Tue, 18 Jun 2024 15:56:34 +0800
Message-Id: <20240618075643.24867-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 8baa0af3684b
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
index 61a57d134544..8ad158bbf188 100644
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

