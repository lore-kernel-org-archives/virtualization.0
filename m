Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137977;
	b=SCfgkBc/VFG2OtXYlhFkE9NQrficcBRr28Av09+klhGgO9Gzz9hsO9Ea9ifk10asfSYe
	 HfzSGZTEd4SjVyPIHA+frb9FBaJUHc1FgZyJCjfdEUvv82rcQ9UOurr3YDGWIeggdqWPk
	 HOvZrOS5QJuThhaAJGJTbjf6OctJ/DeKz/x6kfKs7zWk0/zHGy7jjNW14jU6jUdD0HjRr
	 V6Zsq6SjsiAURQWYjCsTcNTO7/tqRWW1gBBYgsFhBLFnvFvSFozRBADkazMmSX6WT4k2F
	 lRrlaom4kquH/o8GtNirXeouPuTqClqy5Eu0myGxChEySV85c7oYZTf8jtoz15aeQNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137977;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YI+QK96xKMFwFE4sByJjvSpEiF0SUOoelmRtxJdJZqo=;
	b=OZ3vlg3ScOrHhcrnK+t0dcz0sw9KhmrngaCY625PXk/+0234SZ1CVfXbwIPihioTFoIT
	 zvK5ZVzc1cXVTo3/ruKYavJpr5rGZu5FtAV73ogL8VArwPwqPgTvF9T0orMQdxfjx8BHq
	 C5IofIx0Q8AVQehLCSrpIkKb3yVMFhT5BfSM6E9XxAgCW6P6ypGvNFx1w8yvWNXi57thi
	 fZxzqqo+D2QorcFUdHvzTgtC3ZsrYDaBMiGtHp6F3LgPIP4sXbputIUEeix3fhpzmfnpt
	 S2dlCSsIRuKLtskH0ae2j7FpX4Cj82xEdwc9pXlykt1lKE7WTGCtqLY1bygyKfeGzYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=WHFiWLPc;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B712606A330
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 11:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B712606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=WHFiWLPc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=WHFiWLPcp/qEP9VqwRM22BotBJx+p+jvBvs2luGpaDiHO+IJzqfTqp/v8Ijkm7gvf9zjnlnHGi68X
	 yKVDcRmEFqblpH6C3LZzwJhvgcuE2EiUo7TAvdNCxhT0d/SeBeeDBOwUi99xdaw2G0bL2pHsiE4jy7
	 GnRUhOakAvV8PzDY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26af05f6e7d3-f7409;
	Sun, 08 Nov 2026 19:39:29 +0800 (CST)
X-RM-TRANSID:2ee26af05f6e7d3-f7409
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af05f47e53-666cf;
	Sun, 08 Nov 2026 19:39:29 +0800 (CST)
X-RM-TRANSID:2eea6af05f47e53-666cf
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/3] virtio_net: Keep AF_XDP zero-copy pools bound across suspend
Date: Mon,  9 Nov 2026 04:38:39 +0900
Message-ID: <20261108193845.73621-4-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108193845.73621-1-yanhaishuang@cmss.chinamobile.com>
References: <20261108193845.73621-1-yanhaishuang@cmss.chinamobile.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_freeze() frees the receive and send queues and virtnet_restore()
allocates new ones, but AF_XDP sockets stay bound to the device in the
xsk core. Whatever the driver set up for a zero-copy pool is lost on
freeze: the pool's DMA mapping, the xsk_buffs array, the TX header and
its mapping are leaked, and the queue comes back with no pool. When the
socket is closed afterwards, the core asks the driver to disable the
pool again:

  WARNING: net/core/xdp.c:140 ... Missing register, driver bug
  BUG: KASAN: null-ptr-deref in xp_dma_unmap
  Read of size 8 at addr 0000000000000090

as virtnet_xsk_pool_disable() unregisters an xdp_rxq_info that was
never registered and passes the NULL rq->xsk_pool to
xsk_pool_dma_unmap().

Keep the pools DMA mapped across suspend, as the DMA device does not
change, and only move the driver state of a pool from the old queues to
the new ones. On freeze, release it in remove_vq_common() once the
device is reset and the posted buffers are back in the pool. On restore,
set it up again before virtnet_open() fills the queues and enables NAPI.

If that fails for a queue, the pool is left DMA mapped and
virtnet_xsk_pool_disable() only unmaps it when the socket is closed. A
pool left above curr_queue_pairs by removing XDP is not set up again,
so it is unmapped on freeze.

This was found by code review of the suspend path and reproduced in
QEMU by running a suspend cycle with an AF_XDP socket bound, not in
production.

Fixes: 09d2b3182c8e ("virtio_net: xsk: bind/unbind xsk for rx")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 drivers/net/virtio_net.c | 151 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 145 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f9d227060375..d9c920f42126 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5774,6 +5774,8 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 }
 
 static int init_vqs(struct virtnet_info *vi);
+static void virtnet_xsk_pools_release(struct virtnet_info *vi);
+static void virtnet_xsk_pools_attach(struct virtnet_info *vi);
 
 static int virtnet_restore_up(struct virtio_device *vdev)
 {
@@ -5790,13 +5792,13 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	if (netif_running(vi->dev)) {
-		rtnl_lock();
+	rtnl_lock();
+	virtnet_xsk_pools_attach(vi);
+	if (netif_running(vi->dev))
 		err = virtnet_open(vi->dev);
-		rtnl_unlock();
-		if (err)
-			goto err_destroy_pools;
-	}
+	rtnl_unlock();
+	if (err)
+		goto err_destroy_pools;
 
 	netif_tx_lock_bh(vi->dev);
 	netif_device_attach(vi->dev);
@@ -5808,6 +5810,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 err_destroy_pools:
 	virtio_reset_device(vdev);
 	free_unused_bufs(vi);
+	virtnet_xsk_pools_release(vi);
 	virtnet_destroy_page_pools(vi);
 	virtnet_del_vqs(vi);
 	return err;
@@ -6038,6 +6041,13 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 	rq = &vi->rq[qid];
 
 	pool = rq->xsk_pool;
+	if (!pool) {
+		/* Binding it again on restore failed, only the DMA map is left */
+		pool = xsk_get_pool_from_qid(dev, qid);
+		if (pool)
+			xsk_pool_dma_unmap(pool, 0);
+		return 0;
+	}
 
 	err = virtnet_rq_bind_xsk_pool(vi, rq, NULL);
 	err |= virtnet_sq_bind_xsk_pool(vi, sq, NULL);
@@ -6053,6 +6063,133 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 	return err;
 }
 
+/*
+ * Freeze frees the receive and send queues, but the AF_XDP sockets stay
+ * bound and the xsk core keeps their pools. Release only the driver state
+ * of the zero-copy pools here, once the device is reset and the buffers
+ * posted to it are back in the pools. The pools stay DMA mapped, since the
+ * DMA device is still the same after restore and the buffers on their free
+ * lists keep their DMA addresses.
+ *
+ * A pool left above curr_queue_pairs by removing XDP is not bound again
+ * on restore, so unmap it as well.
+ */
+static void virtnet_xsk_pools_release(struct virtnet_info *vi)
+{
+	int i;
+
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		struct receive_queue *rq = &vi->rq[i];
+		struct send_queue *sq = &vi->sq[i];
+
+		if (rq->xsk_pool) {
+			if (i >= vi->curr_queue_pairs)
+				xsk_pool_dma_unmap(rq->xsk_pool, 0);
+			xdp_rxq_info_unreg(&rq->xsk_rxq_info);
+			kvfree(rq->xsk_buffs);
+			rq->xsk_buffs = NULL;
+			rq->xsk_pool = NULL;
+		}
+
+		if (sq->xsk_pool) {
+			virtqueue_unmap_single_attrs(sq->vq, sq->xsk_hdr_dma_addr,
+						     vi->hdr_len, DMA_TO_DEVICE, 0);
+			kfree(sq->xsk_hdr);
+			sq->xsk_hdr = NULL;
+			sq->xsk_pool = NULL;
+		}
+	}
+}
+
+/* Set up the driver state of a still DMA mapped pool on a new queue pair. */
+static int virtnet_xsk_pool_attach(struct virtnet_info *vi, u16 qid,
+				   struct xsk_buff_pool *pool)
+{
+	struct receive_queue *rq = &vi->rq[qid];
+	struct send_queue *sq = &vi->sq[qid];
+	struct device *dma_dev;
+	dma_addr_t hdr_dma;
+	int err;
+
+	dma_dev = virtqueue_dma_dev(rq->vq);
+	if (!rq->page_pool || !dma_dev || dma_dev != virtqueue_dma_dev(sq->vq))
+		return -EINVAL;
+
+	rq->xsk_buffs = kvzalloc_objs(*rq->xsk_buffs,
+				      virtqueue_get_vring_size(rq->vq));
+	if (!rq->xsk_buffs)
+		return -ENOMEM;
+
+	sq->xsk_hdr = kzalloc_obj(*sq->xsk_hdr);
+	if (!sq->xsk_hdr) {
+		err = -ENOMEM;
+		goto err_free_buffs;
+	}
+
+	hdr_dma = virtqueue_map_single_attrs(sq->vq, sq->xsk_hdr, vi->hdr_len,
+					     DMA_TO_DEVICE, 0);
+	if (virtqueue_map_mapping_error(sq->vq, hdr_dma)) {
+		err = -ENOMEM;
+		goto err_free_hdr;
+	}
+
+	err = xdp_rxq_info_reg(&rq->xsk_rxq_info, vi->dev, qid,
+			       rq->napi.napi_id);
+	if (err < 0)
+		goto err_unmap_hdr;
+
+	err = xdp_rxq_info_reg_mem_model(&rq->xsk_rxq_info,
+					 MEM_TYPE_XSK_BUFF_POOL, NULL);
+	if (err < 0)
+		goto err_unreg;
+
+	xsk_pool_set_rxq_info(pool, &rq->xsk_rxq_info);
+
+	sq->xsk_hdr_dma_addr = hdr_dma;
+	sq->xsk_pool = pool;
+	rq->xsk_pool = pool;
+
+	return 0;
+
+err_unreg:
+	xdp_rxq_info_unreg(&rq->xsk_rxq_info);
+err_unmap_hdr:
+	virtqueue_unmap_single_attrs(sq->vq, hdr_dma, vi->hdr_len,
+				     DMA_TO_DEVICE, 0);
+err_free_hdr:
+	kfree(sq->xsk_hdr);
+	sq->xsk_hdr = NULL;
+err_free_buffs:
+	kvfree(rq->xsk_buffs);
+	rq->xsk_buffs = NULL;
+	return err;
+}
+
+/*
+ * On restore, set the zero-copy pools up again on the new queues before
+ * they are filled and their NAPI is enabled.
+ */
+static void virtnet_xsk_pools_attach(struct virtnet_info *vi)
+{
+	struct xsk_buff_pool *pool;
+	int i, err;
+
+	ASSERT_RTNL();
+
+	for (i = 0; i < vi->curr_queue_pairs; i++) {
+		pool = xsk_get_pool_from_qid(vi->dev, i);
+		if (!pool || !pool->umem->zc)
+			continue;
+
+		/* The pool stays DMA mapped until it is disabled */
+		err = virtnet_xsk_pool_attach(vi, i, pool);
+		if (err)
+			netdev_warn(vi->dev,
+				    "failed to bind AF_XDP pool to queue %d: %d\n",
+				    i, err);
+	}
+}
+
 static int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	if (xdp->xsk.pool)
@@ -7208,6 +7345,8 @@ static void remove_vq_common(struct virtnet_info *vi)
 	/* Free unused buffers in both send and recv, if any. */
 	free_unused_bufs(vi);
 
+	virtnet_xsk_pools_release(vi);
+
 	/*
 	 * Rule of thumb is netdev_tx_reset_queue() should follow any
 	 * skb freeing not followed by netdev_tx_completed_queue()
-- 
2.43.0



