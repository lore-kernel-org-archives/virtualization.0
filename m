Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A083E8C46;
	Tue,  4 Aug 2026 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808483; cv=none; b=AbQmZT6uPL5iZKtvR+K0UJMU8AumP79hTOm8m9+0vTKQlPAcPVFkMOfJCFJvzFK9iTZ7qaleRMFS27ffvPqqbDlYw7Yef9LkyRv4Q3BU8BfmENpwbCcY5p3Ne+vzRekObkV7N2XftbU+38zRY4XwXOMFQvknf6Ez1sWnZV6wOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808483; c=relaxed/simple;
	bh=NmP/VjS4RQMK2q1ga4zk1ZciKS9lcLH7YNoC+J7jVnA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6mVqsv8jZwQkUkAgX/sXPIWDcunniSwYdsUVUX5o9KGUO8djnv4rg+CGs6+31ePAHQ6ocmrPWM3q8dtl7hvzzgfcSKIemyyU+Quw0Yx3HqXS9DIEETYszYHG4UrJSww71umhbGxNhE17mBFVnuxUuBpVjQr/RJYPNsPPIMauAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from simon-Latitude-5450.. (tmo-075-57.customers.d1-online.com [80.187.75.57])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 673IarsA011387
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 3 Aug 2026 20:36:58 +0200 (CEST)
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
Subject: [PATCH net-next v14 2/5] tun/tap: add ptr_ring consume helper with netdev queue wakeup
Date: Mon,  3 Aug 2026 20:36:38 +0200
Message-ID: <20260803183641.96882-3-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803183641.96882-1-simon.schippers@tu-dortmund.de>
References: <20260803183641.96882-1-simon.schippers@tu-dortmund.de>
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

Every site that clears __QUEUE_STATE_DRV_XOFF now checks netif_running()
under a ring lock that tun_net_close() takes, so that none of them undoes
its stop. The core sets it before it calls ndo_open() and clears it
before it calls ndo_stop(), so it is false for exactly as long as the
device is down. IFF_UP would not do, it is only cleared after ndo_stop()
returns.

Some implementation details:
- tun_ring_recv() replaces ptr_ring_consume() with tun_ring_consume()
  to properly wake the queue.
- __tun_wake_queue() returns early for a device that is not running, so a
  stop from tun_net_close() is not mistaken for backpressure, and it only
  wakes if the tfile still owns its slot in tun->tfiles[]. A detached
  tfile keeps its queue_index, which __tun_detach() may already have
  handed to the tfile that took over the slot.
- lockdep_assert_held() enforces the documented consumer_lock
  precondition of __tun_wake_queue().
- __tun_detach() locks the tx_ring.consumer_lock to avoid races with
  the consumer on the queue_index, and that of tfile across the hand-over
  of the slot, which makes the ownership check above exact.
- The ptr_ring_consume() call in tun_queue_purge() is not replaced with
  tun_ring_consume(). Instead __tun_detach() wakes the netdev queue for
  the ntfile taking it over, to avoid a possible stall. The queue is only
  woken if the ring of the ntfile is empty, as otherwise the consumer
  wakes it after consuming the remaining entries. This does not matter
  for tun_detach_all(), as it is called during device teardown and no
  tfile takes over any queue.
- That wake sits after synchronize_net() and tun_queue_purge(), so it can
  not be undone by a concurrent tun_net_xmit() or __tun_wake_queue().
- Ensure detached queues are woken on re-attach by calling the new
  tun_force_wake_queue() helper from tun_attach(), and reuse it across
  the existing wake paths. Unlike __tun_wake_queue() it ignores
  IFF_BACKPRESSURE, so a queue can not stay stopped after the flag is
  cleared. It does honour netif_running(), but it always clears cons_cnt,
  so no old count is left over when the queue is stopped again.
- tun_net_close() takes and releases both ring locks of every tfile
  before netif_tx_stop_all_queues(), so that its stop is the last write
  to __QUEUE_STATE_DRV_XOFF.
- The aforementioned upcoming patch explains the pairing of the smp_mb()
  of __tun_wake_queue().

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c | 118 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 51e80000bd0e..d49b6bfd104d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -145,6 +145,8 @@ struct tun_file {
 	struct list_head next;
 	struct tun_struct *detached;
 	struct ptr_ring tx_ring;
+	/* Protected by tx_ring.consumer_lock */
+	int cons_cnt;
 	struct xdp_rxq_info xdp_rxq;
 };
 
@@ -585,11 +587,16 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 		u16 index = tfile->queue_index;
 		BUG_ON(index >= tun->numqueues);
 
+		spin_lock(&tfile->tx_ring.consumer_lock);
 		rcu_assign_pointer(tun->tfiles[index],
 				   tun->tfiles[tun->numqueues - 1]);
+		spin_unlock(&tfile->tx_ring.consumer_lock);
 		ntfile = rtnl_dereference(tun->tfiles[index]);
+		spin_lock(&ntfile->tx_ring.consumer_lock);
 		ntfile->queue_index = index;
 		ntfile->xdp_rxq.queue_index = index;
+		ntfile->cons_cnt = 0;
+		spin_unlock(&ntfile->tx_ring.consumer_lock);
 		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
 				   NULL);
 
@@ -606,6 +613,14 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 		tun_flow_delete_by_queue(tun, tun->numqueues + 1);
 		/* Drop read queue */
 		tun_queue_purge(tfile);
+		spin_lock_bh(&ntfile->tx_ring.consumer_lock);
+		spin_lock(&ntfile->tx_ring.producer_lock);
+		ntfile->cons_cnt = 0;
+		if (netif_running(tun->dev) &&
+		    __ptr_ring_empty(&ntfile->tx_ring))
+			netif_wake_subqueue(tun->dev, index);
+		spin_unlock(&ntfile->tx_ring.producer_lock);
+		spin_unlock_bh(&ntfile->tx_ring.consumer_lock);
 		tun_set_real_num_queues(tun);
 	} else if (tfile->detached && clean) {
 		tun = tun_enable_queue(tfile);
@@ -687,6 +702,25 @@ static void tun_detach_all(struct net_device *dev)
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
+	tfile->cons_cnt = 0;
+	/* Tested under the locks that tun_net_close() takes, so this can not
+	 * undo its stop. tun_net_open() wakes the queues of a device that
+	 * comes back up.
+	 */
+	if (netif_running(tun->dev))
+		netif_wake_subqueue(tun->dev, tfile->queue_index);
+	spin_unlock(&tfile->tx_ring.producer_lock);
+	spin_unlock_bh(&tfile->tx_ring.consumer_lock);
+}
+
 static int tun_attach(struct tun_struct *tun, struct file *file,
 		      bool skip_filter, bool napi, bool napi_frags,
 		      bool publish_tun)
@@ -730,8 +764,11 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 		goto out;
 	}
 
+	spin_lock(&tfile->tx_ring.consumer_lock);
 	tfile->queue_index = tun->numqueues;
+	spin_unlock(&tfile->tx_ring.consumer_lock);
 	tfile->socket.sk->sk_shutdown &= ~RCV_SHUTDOWN;
+	tun_force_wake_queue(tun, tfile);
 
 	if (tfile->detached) {
 		/* Re-attach detached tfile, updating XDP queue_index */
@@ -964,6 +1001,24 @@ static int tun_net_open(struct net_device *dev)
 /* Net device close. */
 static int tun_net_close(struct net_device *dev)
 {
+	struct tun_struct *tun = netdev_priv(dev);
+	struct tun_file *tfile;
+	int i;
+
+	/* netif_running() is already false: take both ring locks to keep the
+	 * wake sites out, so the stop below is the last write to
+	 * __QUEUE_STATE_DRV_XOFF.
+	 */
+	for (i = 0; i < tun->numqueues; i++) {
+		tfile = rtnl_dereference(tun->tfiles[i]);
+
+		spin_lock_bh(&tfile->tx_ring.consumer_lock);
+		spin_lock(&tfile->tx_ring.producer_lock);
+		tfile->cons_cnt = 0;
+		spin_unlock(&tfile->tx_ring.producer_lock);
+		spin_unlock_bh(&tfile->tx_ring.consumer_lock);
+	}
+
 	netif_tx_stop_all_queues(dev);
 	return 0;
 }
@@ -2116,13 +2171,61 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	return total;
 }
 
-static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
+/* Callers must hold ring.consumer_lock */
+static void __tun_wake_queue(struct tun_struct *tun,
+			     struct tun_file *tfile, int consumed)
+{
+	u16 queue_index = tfile->queue_index;
+	struct netdev_queue *txq;
+
+	lockdep_assert_held(&tfile->tx_ring.consumer_lock);
+
+	if (!(tun->flags & IFF_BACKPRESSURE))
+		return;
+
+	/* A stop from tun_net_close() is not backpressure, leave it alone. */
+	if (unlikely(!netif_running(tun->dev)))
+		return;
+
+	/* Only the current owner of the slot may wake its subqueue. */
+	if (unlikely(rcu_access_pointer(tun->tfiles[queue_index]) != tfile))
+		return;
+
+	txq = netdev_get_tx_queue(tun->dev, queue_index);
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
@@ -2134,7 +2237,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ptr = ptr_ring_consume(&tfile->tx_ring);
+		ptr = tun_ring_consume(tun, tfile);
 		if (ptr)
 			break;
 		if (signal_pending(current)) {
@@ -2171,7 +2274,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (!ptr) {
 		/* Read frames from ring */
-		ptr = tun_ring_recv(tfile, noblock, &err);
+		ptr = tun_ring_recv(tun, tfile, noblock, &err);
 		if (!ptr)
 			return err;
 	}
@@ -3630,6 +3733,13 @@ static int tun_queue_resize(struct tun_struct *tun)
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

