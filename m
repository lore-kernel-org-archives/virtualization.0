Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217410;
	b=2X+ua9+p/u+cXR4dC1AIwD0QM1HsGfDan4NUj1tGWN8nqZENYZlflG80U2t3je+5Zc5t
	 Xm7SMl9sOivsbjxLOGLdchqQ36kxK3ZZFjHajVKhnFNUn4icVvbA8Hux4A2In52QwY16C
	 BNaa7T5uuUadrWth99r0pbnLXSu94fVgboRwpeO6+etOFYQRk2kDs0kZbRBFqZpmRhFiH
	 9oXmakCwtFnsHfl7Bim6CUT/y0/Ds6lianfg37w5FMJHBtuew0PG+F5InBLUhg7mhGmvZ
	 dbIo25OoDqvzt7o2zUi4G246Iv/UK7okPLqTIzcLvFNvgX38gfhgKv8Tm0BiSrylpEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217410;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ptywGNiTNVGUFGqPa/Yt2XRlNd43/CqRk5k+EWi/QvA=;
	b=3QLiRkB1nquLJJS+xV0YXBhd73Z+IgwDw6DFiDjon/b8g9rRkJUdmnKHCeXnedT/l2fw
	 uZIh2Je38d21qFWzPp2sia8IWaS6nRzWco2Spb2TbYga7oIUuX4hr+CB47rA/K7trXS5I
	 FYsgkH8qU8mKd6WDyLUCMspFOikf1ZlYbjc1L2aMV0aGLR2SWmWYHIq3JJN/PGpnegxPv
	 5tdAZzFqXEc+T2/5dyRzg45+MVYvcgQgQMnfNEss6YXlFfbWstFOGSetQg5iGgdcSpbxc
	 uk2hgKj4BydIA8m53RbN1Hji7PM8Tj0wyqyjD9s75PyzZi6yGPWowbpEk2NsED8Oa3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YvyQ3QrE;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472C9606A326
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 09:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 472C9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YvyQ3QrE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pt
	ywGNiTNVGUFGqPa/Yt2XRlNd43/CqRk5k+EWi/QvA=; b=YvyQ3QrEJw43EnS0jU
	DnzH28ti8cFUkYD6WlAauNaL/MvD5Ux4hvDEKd7Fthue2HavPOHQ7RpX52KYxppv
	2ojoQINtHMV6ZoWZl4ZKAfSQid/a6I1sMortaWdw0LCZRF0AXIkY9P4Hw0UdOo5e
	UXu4MUWVrUhV84emMD39G7dEE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHJCGvlfFq58sxGQ--.4049S4;
	Mon, 09 Nov 2026 17:43:13 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org,
	eperezma@redhat.com,
	jasowangio@gmail.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: [PATCH 2/3] virtio_net: introduce an RX queue watchdog for stuck detection
Date: Mon,  9 Nov 2026 17:43:09 +0800
Message-Id: <20261109094310.103979-3-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109094310.103979-1-lange_tang@163.com>
References: <20261109094310.103979-1-lange_tang@163.com>
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
X-CM-TRANSID:_____wBHJCGvlfFq58sxGQ--.4049S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jr4DJFWUZr4fKrW7KF4DJwb_yoWxGF4xpF
	W3Aw15trW8tr4xuayxJ397XF13KrykXry7GrWfK398uFs8Kr1rZFn2kry5Ga9Y9FZ3Jr17
	Xr4kt3yfK3yv9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3-B_UUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4hKo1mrxlbJX9QAA3Q

From: Longjun Tang <tanglongjun@kylinos.cn>

The backend raises an interrupt after adding buffers to the used ring,
and the hypervisor injects it. If one is lost (e.g., a transient KVM
failure), NAPI will not be scheduled and the driver stops consuming
buffers. The ring eventually fills up, the backend stops notifying, and
the queue is left permanently stuck.

Add a per-device watchdog that scans the RX queues once per second and
detects a queue that has a non-zero backlog while making no consumption
progress and receiving no new interrupt for rx_watchdog_timeo seconds
(default 5, 0 disables it). On detection, reschedule NAPI.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 drivers/net/virtio_net.c | 104 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6fbe..ec7c248080c5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -36,6 +36,10 @@ module_param(csum, bool, 0444);
 module_param(gso, bool, 0444);
 module_param(napi_tx, bool, 0644);
 
+/* RX queue stall timeout in seconds; 0 disables the watchdog. */
+static unsigned int rx_watchdog_timeo = 5;
+module_param(rx_watchdog_timeo, uint, 0644);
+
 #define VIRTIO_OFFLOAD_MAP_MIN	46
 #define VIRTIO_OFFLOAD_MAP_MAX	47
 #define VIRTIO_FEATURES_MAP_MIN	65
@@ -318,6 +322,13 @@ struct send_queue {
 	dma_addr_t xsk_hdr_dma_addr;
 };
 
+struct virtnet_rq_watchdog {
+	u16 last_used;
+	u16 calls;
+	unsigned long jiffies;
+	bool stalled;
+};
+
 /* Internal representation of a receive virtqueue */
 struct receive_queue {
 	/* Virtqueue associated with this receive_queue */
@@ -332,6 +343,9 @@ struct receive_queue {
 	/* The number of rx notifications */
 	u16 calls;
 
+	/* RX watchdog state. */
+	struct virtnet_rq_watchdog watchdog;
+
 	/* Is dynamic interrupt moderation enabled? */
 	bool dim_enabled;
 
@@ -443,6 +457,9 @@ struct virtnet_info {
 	/* Work struct for setting rx mode */
 	struct work_struct rx_mode_work;
 
+	/* RX watchdog timer for stuck detection */
+	struct timer_list rx_watchdog;
+
 	/* Does the affinity hint is set for virtqueues? */
 	bool affinity_hint_set;
 
@@ -3067,6 +3084,80 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	return received;
 }
 
+/*
+ * An RX queue is stalled if it has a backlog but makes no progress and
+ * gets no new interrupt for rx_watchdog_timeo seconds, usually because
+ * an interrupt was lost.  Mark it stalled and reschedule NAPI to drain
+ * the ring, refill the buffers.
+ */
+static void virtnet_rx_watchdog(struct timer_list *t)
+{
+	struct virtnet_info *vi = timer_container_of(vi, t, rx_watchdog);
+	unsigned long timeout = rx_watchdog_timeo * HZ;
+	int i;
+
+	if (!rx_watchdog_timeo)
+		return;
+
+	for (i = 0; i < vi->curr_queue_pairs; i++) {
+		struct receive_queue *rq = &vi->rq[i];
+		u16 last_used = virtqueue_get_last_used_idx(rq->vq);
+		u16 calls = rq->calls;
+		bool backlog = virtqueue_poll(rq->vq, last_used);
+		bool progress = last_used != rq->watchdog.last_used;
+
+		if (!backlog || progress || calls != rq->watchdog.calls) {
+			rq->watchdog.last_used = last_used;
+			rq->watchdog.calls = calls;
+			rq->watchdog.jiffies = jiffies;
+			continue;
+		}
+
+		if (time_after(jiffies, rq->watchdog.jiffies + timeout)) {
+			unsigned int stall_ms =
+				jiffies_to_msecs(jiffies - rq->watchdog.jiffies);
+
+			netdev_warn(vi->dev,
+				    "RX queue %u stalled for %u ms, rescheduling NAPI\n",
+				    i, stall_ms);
+
+			rq->watchdog.stalled = true;
+			virtqueue_napi_schedule(&rq->napi, rq->vq);
+
+			/* Rate-limit to one event per timeout. */
+			rq->watchdog.jiffies = jiffies;
+		}
+	}
+
+	mod_timer(&vi->rx_watchdog, jiffies + HZ);
+}
+
+static void virtnet_rx_watchdog_init_queue(struct receive_queue *rq)
+{
+	rq->watchdog.last_used = virtqueue_get_last_used_idx(rq->vq);
+	rq->watchdog.calls = rq->calls;
+	rq->watchdog.jiffies = jiffies;
+	rq->watchdog.stalled = false;
+}
+
+static void virtnet_rx_watchdog_start(struct virtnet_info *vi)
+{
+	int i;
+
+	if (!rx_watchdog_timeo)
+		return;
+
+	for (i = 0; i < vi->curr_queue_pairs; i++)
+		virtnet_rx_watchdog_init_queue(&vi->rq[i]);
+
+	mod_timer(&vi->rx_watchdog, jiffies + HZ);
+}
+
+static void virtnet_rx_watchdog_stop(struct virtnet_info *vi)
+{
+	timer_delete_sync(&vi->rx_watchdog);
+}
+
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 {
 	virtnet_napi_tx_disable(&vi->sq[qp_index]);
@@ -3230,6 +3321,8 @@ static int virtnet_open(struct net_device *dev)
 		netif_carrier_on(dev);
 	}
 
+	virtnet_rx_watchdog_start(vi);
+
 	return 0;
 
 err_enable_qp:
@@ -3759,6 +3852,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	struct virtio_net_rss_config_trailer old_rss_trailer;
 	struct net_device *dev = vi->dev;
 	struct scatterlist sg;
+	u16 old_queue_pairs = vi->curr_queue_pairs;
 
 	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
 		return 0;
@@ -3816,7 +3910,14 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	if (vi->has_rss)
 		vi->rss_trailer.max_tx_vq = cpu_to_le16(queue_pairs);
 succ:
+	if (dev->flags & IFF_UP) {
+		/* Init new queues */
+		for (int i = old_queue_pairs; i < queue_pairs; i++)
+			virtnet_rx_watchdog_init_queue(&vi->rq[i]);
+	}
+
 	vi->curr_queue_pairs = queue_pairs;
+
 	if (dev->flags & IFF_UP) {
 		local_bh_disable();
 		for (int i = 0; i < vi->curr_queue_pairs; ++i)
@@ -3832,6 +3933,8 @@ static int virtnet_close(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
+	virtnet_rx_watchdog_stop(vi);
+
 	/* Prevent the config change callback from changing carrier
 	 * after close
 	 */
@@ -6900,6 +7003,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
 	disable_work(&vi->rx_mode_work);
+	timer_setup(&vi->rx_watchdog, virtnet_rx_watchdog, 0);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
-- 
2.51.0

