Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBDE49250C;
	Wed,  6 May 2026 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076665; cv=none; b=NkL3VGWCLj1N5F/AQgiwgTXn+jmERhiJXLGZ2EqiLCqQOVd0Y09P/+nmynFuTIBKjrwtCZ/u2vpcFA0ytEYDC3T3JWtH0RniTGrQhk84h5m1TToTeaXojNCHRwpTsW4de0YfBzmMkxuE8CiWoWxQWMJcUnwE3fMJDpueTQQjMMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076665; c=relaxed/simple;
	bh=52b+YNhKvnHeBpft7vVFWaEBKKldagGULo7C9xvyt1w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2UraNS9dOqvcEwSUpL3F+mEw1oH8e9WK/Pla5GyMlf5Tpo11DEG4InlIGvbkHSbSysforfOLw/PweWXWR/wKWRiZwmR0cdtYx27Eb0+fMrEEXj6TSLvwoBtFe3rLuUDpqtZVBKvgyLJSYmL5vA3SaFqM6Nngn86R7ougYaopMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=L0xqu+cv; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="L0xqu+cv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778076651;
	bh=52b+YNhKvnHeBpft7vVFWaEBKKldagGULo7C9xvyt1w=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=L0xqu+cv/1FHMUHTfOwLHEn0LKozvoTxqk3XR+2QsA13Hw38tq/sdYglYrPeNLkQC
	 VYaUg7WVBv5lGjcATR0T9eqoMn/LLMXq+Xt0yG9O9jy3ayoLb0wJoHSnlvL0Ri/qi6
	 /kW5ZFpWvzHSihsHkbji4qtoeqrnUyL5lrgnubc4=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.46])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 646EAnWY015408
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 6 May 2026 16:10:51 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v10 1/4] tun/tap: add ptr_ring consume helper with netdev queue wakeup
Date: Wed,  6 May 2026 16:10:30 +0200
Message-ID: <20260506141033.180450-2-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506141033.180450-1-simon.schippers@tu-dortmund.de>
References: <20260506141033.180450-1-simon.schippers@tu-dortmund.de>
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
cons_cnt field in tun_file. cons_cnt is updated while holding the ring
consumer lock, avoiding races. As a safety net, the queue is also woken
when the ring becomes empty. The point is to allow the queue to be
stopped when it gets full, which is required for traffic shaping -
implemented by the following "avoid ptr_ring tail-drop when a qdisc
is present". That patch also explains the pairing of the smp_mb()
of __tun_wake_queue().

Without the corresponding queue stopping, this patch alone causes no
regression for a tap setup sending to a qemu VM: 1.132 Mpps
to 1.144 Mpps.

Details: AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU
threads, pktgen sender; Avg over 50 runs @ 100,000,000 packets;
SRSO and spectre v2 mitigations disabled.

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c | 54 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b183189f1853..00ecf128fe8e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -145,6 +145,7 @@ struct tun_file {
 	struct list_head next;
 	struct tun_struct *detached;
 	struct ptr_ring tx_ring;
+	int cons_cnt;
 	struct xdp_rxq_info xdp_rxq;
 };
 
@@ -557,6 +558,13 @@ void tun_ptr_free(void *ptr)
 }
 EXPORT_SYMBOL_GPL(tun_ptr_free);
 
+static void tun_reset_cons_cnt(struct tun_file *tfile)
+{
+	spin_lock(&tfile->tx_ring.consumer_lock);
+	tfile->cons_cnt = 0;
+	spin_unlock(&tfile->tx_ring.consumer_lock);
+}
+
 static void tun_queue_purge(struct tun_file *tfile)
 {
 	void *ptr;
@@ -564,6 +572,7 @@ static void tun_queue_purge(struct tun_file *tfile)
 	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
 		tun_ptr_free(ptr);
 
+	tun_reset_cons_cnt(tfile);
 	skb_queue_purge(&tfile->sk.sk_write_queue);
 	skb_queue_purge(&tfile->sk.sk_error_queue);
 }
@@ -730,6 +739,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 		goto out;
 	}
 
+	tun_reset_cons_cnt(tfile);
 	tfile->queue_index = tun->numqueues;
 	tfile->socket.sk->sk_shutdown &= ~RCV_SHUTDOWN;
 
@@ -2115,13 +2125,46 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	return total;
 }
 
-static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
+/* Callers must hold ring.consumer_lock */
+static void __tun_wake_queue(struct tun_struct *tun,
+			     struct tun_file *tfile, int consumed)
+{
+	struct netdev_queue *txq = netdev_get_tx_queue(tun->dev,
+						tfile->queue_index);
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
@@ -2133,7 +2176,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ptr = ptr_ring_consume(&tfile->tx_ring);
+		ptr = tun_ring_consume(tun, tfile);
 		if (ptr)
 			break;
 		if (signal_pending(current)) {
@@ -2170,7 +2213,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (!ptr) {
 		/* Read frames from ring */
-		ptr = tun_ring_recv(tfile, noblock, &err);
+		ptr = tun_ring_recv(tun, tfile, noblock, &err);
 		if (!ptr)
 			return err;
 	}
@@ -3406,6 +3449,8 @@ static int tun_chr_open(struct inode *inode, struct file * file)
 		return -ENOMEM;
 	}
 
+	tun_reset_cons_cnt(tfile);
+
 	mutex_init(&tfile->napi_mutex);
 	RCU_INIT_POINTER(tfile->tun, NULL);
 	tfile->flags = 0;
@@ -3614,6 +3659,7 @@ static int tun_queue_resize(struct tun_struct *tun)
 	for (i = 0; i < tun->numqueues; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
 		rings[i] = &tfile->tx_ring;
+		tun_reset_cons_cnt(tfile);
 	}
 	list_for_each_entry(tfile, &tun->disabled, next)
 		rings[i++] = &tfile->tx_ring;
-- 
2.43.0

