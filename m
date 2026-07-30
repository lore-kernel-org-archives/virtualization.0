Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B775E3C0621;
	Thu, 30 Jul 2026 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447625; cv=none; b=qi5qP6kXTA3sSd+r/kT+lmwfDWcLYsf1uzepD44W5nh1KVUKKlGuUUiObA7UcSYVKefFPbsn/iBFyefmNQtntHKQ+xWuuMV5L75xt0FxC+qqXbl8KBUbOQbnrkjjRuK9uNO6C7Z3BDa4iu2GYhmAzSFi7z8O72vcu94Yg8Epktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447625; c=relaxed/simple;
	bh=Z/DU/VTkCAKsXYxsKPe5wGW05bf0KrRktec7a/fm4ak=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WELfaSEAOKYorNS7FkjLyJ3xljFSRkzu1ZCqy4/b8RONXConwpdynr8d4F8gwRIKVqqB+z7PDb4YHaMheawgMMqmJW/lGR/1J8NSg3n/YvF8zZStq1BNx9Jq2vz4JYogShOz+z7aCbjz5mo1B5XfTpRN4KUu/z29Ia/rYsWDEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=XMqoktRH; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="XMqoktRH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1785447414;
	bh=CtPUaiLouPumVmw8aHlj/5iWQfOcY/P7jXBdQh8clB8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=XMqoktRHro18APurxcESDQDXRceaZUl66LsfSOJlXnAybnqGGaTfMmnjJQNvWghU9
	 ULllqKfqTHgCkQuSKSKt0EkUMUuwxjLoxcG82ysGLwA9IpEcwVLbFb773tE05DoS4Z
	 zswpYVyZFPNfMTGeOyo8T0BMm3grWl8tlQwJZisU=
Received: from simon-Latitude-5450.fritz.box (pd9eaa9cd.dip0.t-ipconnect.de [217.234.169.205])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66ULan2s027704
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 23:36:53 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, brett@librecast.net, corbet@lwn.net,
        skhan@linuxfoundation.org, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH net-next v13 2/5] tun/tap: add ptr_ring consume helper with netdev queue wakeup
Date: Thu, 30 Jul 2026 23:36:36 +0200
Message-ID: <20260730213639.726381-3-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730213639.726381-1-simon.schippers@tu-dortmund.de>
References: <20260730213639.726381-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce tun_ring_consume() that wraps ptr_ring_consume() and calls
__tun_wake_queue(). The latter wakes the stopped netdev subqueue once
half of the ring capacity has been consumed, tracked via the new
cons_cnt field in tun_file. As a safety net, the queue is also woken on
the last consumed entry if it leaves the ring empty. The point is to
allow the queue to be stopped when it gets full, which is required for
traffic shaping, implemented by the following "stop tail-drop when
IFF_BACKPRESSURE is set".

__tun_wake_queue() returns early unless IFF_BACKPRESSURE is set, so for a
tun/tap device that does not opt in only the added check on the consume
path remains.

Some implementation details:
- tun_ring_recv() replaces ptr_ring_consume() with tun_ring_consume()
  to properly wake the queue.
- __tun_detach() locks the tx_ring.consumer_lock to avoid races with
  the consumer on the queue_index.
- The ptr_ring_consume() call in tun_queue_purge() is not replaced with
  tun_ring_consume(). Instead, within the same tx_ring.consumer_lock
  in __tun_detach(), the netdev queue is woken for the ntfile taking
  it over, to avoid a possible stall. This does not matter for
  tun_detach_all(), as it is called during device teardown and no tfile
  takes over any queue. The queue is only woken if the ring of
  the ntfile is empty, as otherwise the consumer wakes it after
  consuming the remaining entries.
- Ensure detached queues are woken on re-attach by calling the new
  tun_force_wake_queue() helper from tun_attach(), and reuse it across
  the existing wake paths. Unlike __tun_wake_queue() it ignores
  IFF_BACKPRESSURE, so a queue can not stay stopped after the flag is
  cleared.
- The aforementioned upcoming patch explains the pairing of the smp_mb()
  of __tun_wake_queue().

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c | 77 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index ea8573efb848..d9db6d2e4c56 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -146,6 +146,8 @@ struct tun_file {
 	struct list_head next;
 	struct tun_struct *detached;
 	struct ptr_ring tx_ring;
+	/* Protected by tx_ring.consumer_lock */
+	int cons_cnt;
 	struct xdp_rxq_info xdp_rxq;
 };
 
@@ -589,8 +591,16 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 		rcu_assign_pointer(tun->tfiles[index],
 				   tun->tfiles[tun->numqueues - 1]);
 		ntfile = rtnl_dereference(tun->tfiles[index]);
+		spin_lock(&ntfile->tx_ring.consumer_lock);
 		ntfile->queue_index = index;
 		ntfile->xdp_rxq.queue_index = index;
+		ntfile->cons_cnt = 0;
+		/* If the ring is not empty, the consumer wakes the queue
+		 * after consuming the remaining entries.
+		 */
+		if (__ptr_ring_empty(&ntfile->tx_ring))
+			netif_wake_subqueue(tun->dev, index);
+		spin_unlock(&ntfile->tx_ring.consumer_lock);
 		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
 				   NULL);
 
@@ -688,6 +698,20 @@ static void tun_detach_all(struct net_device *dev)
 		module_put(THIS_MODULE);
 }
 
+static void tun_force_wake_queue(struct tun_struct *tun,
+				 struct tun_file *tfile)
+{
+	/* Ensure that the producer can not stop the
+	 * queue concurrently by taking locks.
+	 */
+	spin_lock_bh(&tfile->tx_ring.consumer_lock);
+	spin_lock(&tfile->tx_ring.producer_lock);
+	netif_wake_subqueue(tun->dev, tfile->queue_index);
+	tfile->cons_cnt = 0;
+	spin_unlock(&tfile->tx_ring.producer_lock);
+	spin_unlock_bh(&tfile->tx_ring.consumer_lock);
+}
+
 static int tun_attach(struct tun_struct *tun, struct file *file,
 		      bool skip_filter, bool napi, bool napi_frags,
 		      bool publish_tun)
@@ -733,6 +757,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 
 	tfile->queue_index = tun->numqueues;
 	tfile->socket.sk->sk_shutdown &= ~RCV_SHUTDOWN;
+	tun_force_wake_queue(tun, tfile);
 
 	if (tfile->detached) {
 		/* Re-attach detached tfile, updating XDP queue_index */
@@ -2117,13 +2142,50 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	return total;
 }
 
-static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
+/* Callers must hold ring.consumer_lock */
+static void __tun_wake_queue(struct tun_struct *tun,
+			     struct tun_file *tfile, int consumed)
+{
+	struct netdev_queue *txq;
+
+	if (!(tun->flags & IFF_BACKPRESSURE))
+		return;
+
+	txq = netdev_get_tx_queue(tun->dev, tfile->queue_index);
+
+	/* Paired with smp_mb__after_atomic() in tun_net_xmit() */
+	smp_mb();
+	if (netif_tx_queue_stopped(txq)) {
+		tfile->cons_cnt += consumed;
+		if (tfile->cons_cnt >= tfile->tx_ring.size / 2 ||
+		    __ptr_ring_empty(&tfile->tx_ring)) {
+			netif_tx_wake_queue(txq);
+			tfile->cons_cnt = 0;
+		}
+	}
+}
+
+static void *tun_ring_consume(struct tun_struct *tun, struct tun_file *tfile)
+{
+	void *ptr;
+
+	spin_lock(&tfile->tx_ring.consumer_lock);
+	ptr = __ptr_ring_consume(&tfile->tx_ring);
+	if (ptr)
+		__tun_wake_queue(tun, tfile, 1);
+
+	spin_unlock(&tfile->tx_ring.consumer_lock);
+	return ptr;
+}
+
+static void *tun_ring_recv(struct tun_struct *tun, struct tun_file *tfile,
+			   int noblock, int *err)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	void *ptr = NULL;
 	int error = 0;
 
-	ptr = ptr_ring_consume(&tfile->tx_ring);
+	ptr = tun_ring_consume(tun, tfile);
 	if (ptr)
 		goto out;
 	if (noblock) {
@@ -2135,7 +2197,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ptr = ptr_ring_consume(&tfile->tx_ring);
+		ptr = tun_ring_consume(tun, tfile);
 		if (ptr)
 			break;
 		if (signal_pending(current)) {
@@ -2172,7 +2234,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (!ptr) {
 		/* Read frames from ring */
-		ptr = tun_ring_recv(tfile, noblock, &err);
+		ptr = tun_ring_recv(tun, tfile, noblock, &err);
 		if (!ptr)
 			return err;
 	}
@@ -3631,6 +3693,13 @@ static int tun_queue_resize(struct tun_struct *tun)
 					  dev->tx_queue_len, GFP_KERNEL,
 					  tun_ptr_free);
 
+	if (!ret) {
+		for (i = 0; i < tun->numqueues; i++) {
+			tfile = rtnl_dereference(tun->tfiles[i]);
+			tun_force_wake_queue(tun, tfile);
+		}
+	}
+
 	kfree(rings);
 	return ret;
 }
-- 
2.43.0

