Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF2439010;
	Tue, 28 Apr 2026 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380090; cv=none; b=M2E9XrpkFTiMzV8KC5T54mWGFww/qv+vNfF7FWmhq17vAwHPdR9z7WRiTpX831hwl3ChgUcEFAjVL+pDBo3WoQlWnfguJNF/eez0li5ciXQvf/ItWBpZjkBspQkC5tKknkXGy+w1J/thWAmYKG1JILn96SX1O7BPIPW9++DY9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380090; c=relaxed/simple;
	bh=igeIamDKNz2CqpiHk60+LMJNsVn1EVXKQJKILvvCnv0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuX0ZOKkjJZ796B7IU+em3OotNkZuI1NcxIpDqSw0eBVxUtXwUMHs2nn8+Wpic/LalYVoFA+sErt8vqUy1KoyvxG0iPSFiBPXiv8ch8pFGfXsh7XWma5KO36uZVOIg4N+5YHQhHD3jygovjgo9gzCc/DewgkOMkKbESEwJE4cZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.62])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 63SCewwg012433
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 14:41:00 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v9 1/4] tun/tap: add ptr_ring consume helper with netdev queue wakeup
Date: Tue, 28 Apr 2026 14:38:56 +0200
Message-ID: <20260428123859.19578-2-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
References: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
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
cons_cnt field in tun_file. When the ring is empty the queue is also
woken to handle potential races. The point is to allow the queue to
be stopped when it gets full, which is required for traffic shaping -
implemented by the following "avoid ptr_ring tail-drop when a qdisc
is present".

Without the corresponding queue stopping, this patch alone causes no
regression for a tap setup sending to a qemu VM: 1.136 Mpps
to 1.141 Mpps.

Details: AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU
threads, pktgen sender; Avg over 50 runs @ 100,000,000 packets;
SRSO and spectre v2 mitigations disabled.

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b183189f1853..e6ee2271732f 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -145,6 +145,7 @@ struct tun_file {
 	struct list_head next;
 	struct tun_struct *detached;
 	struct ptr_ring tx_ring;
+	int cons_cnt;
 	struct xdp_rxq_info xdp_rxq;
 };
 
@@ -564,6 +565,7 @@ static void tun_queue_purge(struct tun_file *tfile)
 	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
 		tun_ptr_free(ptr);
 
+	tfile->cons_cnt = 0;
 	skb_queue_purge(&tfile->sk.sk_write_queue);
 	skb_queue_purge(&tfile->sk.sk_error_queue);
 }
@@ -730,6 +732,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 		goto out;
 	}
 
+	tfile->cons_cnt = 0;
 	tfile->queue_index = tun->numqueues;
 	tfile->socket.sk->sk_shutdown &= ~RCV_SHUTDOWN;
 
@@ -2115,13 +2118,42 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	return total;
 }
 
-static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
+/* Callers must hold ring.consumer_lock */
+static void __tun_wake_queue(struct tun_struct *tun, struct tun_file *tfile)
+{
+	if (__ptr_ring_empty(&tfile->tx_ring))
+		goto wake;
+
+	if (!__netif_subqueue_stopped(tun->dev, tfile->queue_index) ||
+	    ++tfile->cons_cnt < tfile->tx_ring.size / 2)
+		return;
+
+wake:
+	netif_wake_subqueue(tun->dev, tfile->queue_index);
+	tfile->cons_cnt = 0;
+}
+
+static void *tun_ring_consume(struct tun_struct *tun, struct tun_file *tfile)
+{
+	void *ptr;
+
+	spin_lock(&tfile->tx_ring.consumer_lock);
+	ptr = __ptr_ring_consume(&tfile->tx_ring);
+	if (ptr)
+		__tun_wake_queue(tun, tfile);
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
@@ -2133,7 +2165,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ptr = ptr_ring_consume(&tfile->tx_ring);
+		ptr = tun_ring_consume(tun, tfile);
 		if (ptr)
 			break;
 		if (signal_pending(current)) {
@@ -2170,7 +2202,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (!ptr) {
 		/* Read frames from ring */
-		ptr = tun_ring_recv(tfile, noblock, &err);
+		ptr = tun_ring_recv(tun, tfile, noblock, &err);
 		if (!ptr)
 			return err;
 	}
@@ -3406,6 +3438,8 @@ static int tun_chr_open(struct inode *inode, struct file * file)
 		return -ENOMEM;
 	}
 
+	tfile->cons_cnt = 0;
+
 	mutex_init(&tfile->napi_mutex);
 	RCU_INIT_POINTER(tfile->tun, NULL);
 	tfile->flags = 0;
@@ -3614,6 +3648,7 @@ static int tun_queue_resize(struct tun_struct *tun)
 	for (i = 0; i < tun->numqueues; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
 		rings[i] = &tfile->tx_ring;
+		tfile->cons_cnt = 0;
 	}
 	list_for_each_entry(tfile, &tun->disabled, next)
 		rings[i++] = &tfile->tx_ring;
-- 
2.43.0

