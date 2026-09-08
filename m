Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655154A1E0E
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859627; cv=none; b=VRLiD27WiCcNWBJYlhY3kYokpB8Ae5PTi5AccDzJHZrsEVPoDStvGqRrmF3+MoCu80ad/8A/pjt5/jsyFkAx0HSPm2lTeLfvnKTplHnd5Q7mFzaDPaILbbEC/HMwm0bHfv4GF9yLxbmyKS27TcPo40dh2eUooxv9aMLFZVi+WaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859627; c=relaxed/simple;
	bh=3bA5gtZiPneMgqqKxUSE1OjB1OylMbEwWtvu55uEZEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hu5hoAeSHax7PvxuZ4jKKAemfXpOIKGZMHhkmgLxwNRSRuquYOgqyWtTcJE0nf74Fc7KMb2CRl28Pli543S9s/qcP/v7/onf8gGWprTu3iNtUiTzs+JKnKZNkbnqxZaO5h3zf/3jvWNJibOKD0ZgzxjvwjxLhTPbdrPv+UEbrfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kq0JIlHL; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kq0JIlHL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Wx
	id2EgyFOqLVjrirkNTMHd56v9PxmNtv6rmVyDNoh0=; b=kq0JIlHLRbBDW5BoLl
	c+ny35lZKDwsfKVPGT+L1N2W7EC/a6fFHY9tg5umz6DhenjMBVcw3wMU3ugZCWQL
	9yEOaRay5ft1v6/l9VjqGEZLPR74fwO1UDb1UaI+ltjfxsmDUIKp8+rkMVVUWUWx
	J2NMsGgr4r/7SrMefHm6Gowg0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3Bf3X1J9qaBRdRg--.18019S4;
	Tue, 08 Sep 2026 17:26:50 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org
Cc: jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: [RFC RESEND 2/3] virtio_net: introduce an RX queue watchdog for stuck detection
Date: Tue,  8 Sep 2026 17:26:45 +0800
Message-Id: <20260908092646.108865-3-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260908092646.108865-1-lange_tang@163.com>
References: <20260908092646.108865-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3Bf3X1J9qaBRdRg--.18019S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr17Jw15tF4UWF43AFW7twb_yoW7GF48pF
	43Cwn8tr48tr4xuryft397JFy5KrykXry7Gry3K345ZFn8Kr1rZFn2kFy5Ga909FZ3Jr17
	ZF4vy3ySkaykurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDtxfUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4hrtHGqf1NqxGgAA3Z

From: Longjun Tang <tanglongjun@kylinos.cn>

The backend raises an interrupt after adding buffers to the used ring,
and the hypervisor injects it. If one is lost (e.g., a transient KVM
failure), NAPI will not be scheduled and the driver stops consuming
buffers. The ring eventually fills up, the backend stops notifying, and
the queue is left permanently stuck.

Add a per-device watchdog that scans the RX queues once per second and
detects a queue that has a non-zero backlog while making no consumption
progress and receiving no new interrupt for rx_watchdog_timeo seconds
(default 5, 0 disables it). On detection it logs a warning, rate-limited
to once per timeout.

Assisted-by: Kilo:deepseek-v4-pro
Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 drivers/net/virtio_net.c | 88 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e34c52d059d3..c28de03c177b 100644
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
@@ -330,6 +334,11 @@ struct receive_queue {
 	/* The number of rx notifications */
 	u16 calls;
 
+	/* RX watchdog state for stuck detection. */
+	u16 watchdog_last_used_idx;
+	u16 watchdog_calls;
+	unsigned long watchdog_jiffies;
+
 	/* Is dynamic interrupt moderation enabled? */
 	bool dim_enabled;
 
@@ -441,6 +450,9 @@ struct virtnet_info {
 	/* Work struct for setting rx mode */
 	struct work_struct rx_mode_work;
 
+	/* RX watchdog timer for stuck detection */
+	struct timer_list rx_watchdog;
+
 	/* OK to queue work setting RX mode? */
 	bool rx_mode_work_enabled;
 
@@ -3046,6 +3058,77 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	return received;
 }
 
+/*
+ * This watchdog detects that state: a queue is considered stalled when
+ * it has a non-zero backlog, makes no consumption progress and receives
+ * no new interrupt for rx_watchdog_timeo seconds. On detection it logs
+ * a warning.
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
+
+		if (!backlog || last_used != rq->watchdog_last_used_idx ||
+		    calls != rq->watchdog_calls) {
+			/* No pending data, or the queue made progress, or a
+			 * new interrupt arrived: restart the window.
+			 */
+			rq->watchdog_last_used_idx = last_used;
+			rq->watchdog_calls = calls;
+			rq->watchdog_jiffies = jiffies;
+			continue;
+		}
+
+		if (time_after(jiffies, rq->watchdog_jiffies + timeout)) {
+			unsigned int stall_ms =
+				jiffies_to_msecs(jiffies - rq->watchdog_jiffies);
+
+			netdev_warn(vi->dev, "RX queue %u stalled for %u ms\n",
+				    i, stall_ms);
+
+			/* Rate-limit to one event per timeout. */
+			rq->watchdog_jiffies = jiffies;
+		}
+	}
+
+	mod_timer(&vi->rx_watchdog, jiffies + HZ);
+}
+
+static void virtnet_rx_watchdog_start(struct virtnet_info *vi)
+{
+	int i;
+
+	if (!rx_watchdog_timeo)
+		return;
+
+	for (i = 0; i < vi->curr_queue_pairs; i++) {
+		struct receive_queue *rq = &vi->rq[i];
+
+		rq->watchdog_last_used_idx =
+			virtqueue_get_last_used_idx(rq->vq);
+		rq->watchdog_calls = rq->calls;
+		rq->watchdog_jiffies = jiffies;
+	}
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
@@ -3209,6 +3292,8 @@ static int virtnet_open(struct net_device *dev)
 		netif_carrier_on(dev);
 	}
 
+	virtnet_rx_watchdog_start(vi);
+
 	return 0;
 
 err_enable_qp:
@@ -3802,6 +3887,8 @@ static int virtnet_close(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
+	virtnet_rx_watchdog_stop(vi);
+
 	/* Prevent the config change callback from changing carrier
 	 * after close
 	 */
@@ -6869,6 +6956,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
 	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
+	timer_setup(&vi->rx_watchdog, virtnet_rx_watchdog, 0);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
 		vi->mergeable_rx_bufs = true;
-- 
2.25.1

