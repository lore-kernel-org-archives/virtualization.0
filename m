Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A840F74E;
	Tue, 28 Jul 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230805; cv=none; b=j+z6CUscj14h1sOK3h8Zzm9USzmH8WFlsBaFSqSdxRqhjbrlDwE4vLc3u8TnGH/BcOZEuqbI0ZDvFE+oJwIeR52F4BbTadXdFTR3Qvg9DLNTgbf9Fzc6yg3rp1Is6knN8WThJ5YxJHcAgmOoiU5GXEXKhgN7ZFWPOAUn80G14VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230805; c=relaxed/simple;
	bh=qneMQZotvg+ykB7xElxLGuVMagk5ce9krFJ8kvSEgO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o88bRD1BIe7CU2OXtP8xTKIjDcMg/StyyMQZ29iDyT94LFfBaTVz0KtmEGWuMGVgURr88pp6dqylTvMOiI7RUB72L/rutZZQGHdfFTPjF4YQcRCRm3JY5+VIQ4CY+Fks8BRDmDkezDABwnroFxiSxdmolfYNWI11l770i2uglE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=CR8OtOoK; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="CR8OtOoK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1785230603;
	bh=w1+LneaDKmhTEBWcnDAGqBIH4Ciar5aipwxDRJbvV1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CR8OtOoK3/PuGKlU7eHT6/EOO0kQW85e0R7NAMLU9QXhzmAHU+ZmrcOISPxGGqHBu
	 ipc/ILK+L0mixJioWtO1SdvLKVHei1ipzjYKwMZc4he7+KGJTr0vcenqdPCjR7TVWW
	 0cJuCl7TRhUdJy6/1Dz+WwAg7khYLCztO8MgOFIk=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.117])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66S9NL4U004577
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 11:23:23 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>,
        Brett Sheffield <brett@librecast.net>, kvm@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        Simon Schippers <simon.schippers@tu-dortmund.de>
Subject: [PATCH net 4/4] Revert "tun/tap: add ptr_ring consume helper with netdev queue wakeup"
Date: Tue, 28 Jul 2026 11:22:40 +0200
Message-ID: <20260728092240.250257-5-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728092240.250257-1-simon.schippers@tu-dortmund.de>
References: <20260728092240.250257-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit d4c22d70d7253dd727c71484c58d504f6c630343.

There is no netdev queue left to wake after reverting
commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop
when a qdisc is present").

Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c | 61 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 57 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 39abc3078097..fed9dfdfcc3b 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -145,8 +145,6 @@ struct tun_file {
 	struct list_head next;
 	struct tun_struct *detached;
 	struct ptr_ring tx_ring;
-	/* Protected by tx_ring.consumer_lock */
-	int cons_cnt;
 	struct xdp_rxq_info xdp_rxq;
 };
 
@@ -590,13 +588,8 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 		rcu_assign_pointer(tun->tfiles[index],
 				   tun->tfiles[tun->numqueues - 1]);
 		ntfile = rtnl_dereference(tun->tfiles[index]);
-		spin_lock(&ntfile->tx_ring.consumer_lock);
 		ntfile->queue_index = index;
 		ntfile->xdp_rxq.queue_index = index;
-		ntfile->cons_cnt = 0;
-		if (__ptr_ring_empty(&ntfile->tx_ring))
-			netif_wake_subqueue(tun->dev, index);
-		spin_unlock(&ntfile->tx_ring.consumer_lock);
 		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
 				   NULL);
 
@@ -737,9 +730,6 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 		goto out;
 	}
 
-	spin_lock(&tfile->tx_ring.consumer_lock);
-	tfile->cons_cnt = 0;
-	spin_unlock(&tfile->tx_ring.consumer_lock);
 	tfile->queue_index = tun->numqueues;
 	tfile->socket.sk->sk_shutdown &= ~RCV_SHUTDOWN;
 
@@ -2126,46 +2116,13 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 	return total;
 }
 
-/* Callers must hold ring.consumer_lock */
-static void __tun_wake_queue(struct tun_struct *tun,
-			     struct tun_file *tfile, int consumed)
-{
-	struct netdev_queue *txq = netdev_get_tx_queue(tun->dev,
-						tfile->queue_index);
-
-	/* Paired with smp_mb__after_atomic() in tun_net_xmit() */
-	smp_mb();
-	if (netif_tx_queue_stopped(txq)) {
-		tfile->cons_cnt += consumed;
-		if (tfile->cons_cnt >= tfile->tx_ring.size / 2 ||
-		    __ptr_ring_empty(&tfile->tx_ring)) {
-			netif_tx_wake_queue(txq);
-			tfile->cons_cnt = 0;
-		}
-	}
-}
-
-static void *tun_ring_consume(struct tun_struct *tun, struct tun_file *tfile)
-{
-	void *ptr;
-
-	spin_lock(&tfile->tx_ring.consumer_lock);
-	ptr = __ptr_ring_consume(&tfile->tx_ring);
-	if (ptr)
-		__tun_wake_queue(tun, tfile, 1);
-
-	spin_unlock(&tfile->tx_ring.consumer_lock);
-	return ptr;
-}
-
-static void *tun_ring_recv(struct tun_struct *tun, struct tun_file *tfile,
-			   int noblock, int *err)
+static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	void *ptr = NULL;
 	int error = 0;
 
-	ptr = tun_ring_consume(tun, tfile);
+	ptr = ptr_ring_consume(&tfile->tx_ring);
 	if (ptr)
 		goto out;
 	if (noblock) {
@@ -2177,7 +2134,7 @@ static void *tun_ring_recv(struct tun_struct *tun, struct tun_file *tfile,
 
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ptr = tun_ring_consume(tun, tfile);
+		ptr = ptr_ring_consume(&tfile->tx_ring);
 		if (ptr)
 			break;
 		if (signal_pending(current)) {
@@ -2214,7 +2171,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (!ptr) {
 		/* Read frames from ring */
-		ptr = tun_ring_recv(tun, tfile, noblock, &err);
+		ptr = tun_ring_recv(tfile, noblock, &err);
 		if (!ptr)
 			return err;
 	}
@@ -3669,16 +3626,6 @@ static int tun_queue_resize(struct tun_struct *tun)
 					  dev->tx_queue_len, GFP_KERNEL,
 					  tun_ptr_free);
 
-	if (!ret) {
-		for (i = 0; i < tun->numqueues; i++) {
-			tfile = rtnl_dereference(tun->tfiles[i]);
-			spin_lock(&tfile->tx_ring.consumer_lock);
-			netif_wake_subqueue(tun->dev, tfile->queue_index);
-			tfile->cons_cnt = 0;
-			spin_unlock(&tfile->tx_ring.consumer_lock);
-		}
-	}
-
 	kfree(rings);
 	return ret;
 }
-- 
2.43.0

