Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB6441BA98;
	Tue, 28 Jul 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230805; cv=none; b=VGJq1RlgfdGmU/DGvKFO2EF3xdLEA185qU6gB+qpu2KMYX/4d4jQaeWXRom3XR7x/bEcl2XyLvc4sWlc0aF821valBP17vsxBWtUSzpVKOekIZuvdTpeA/ndvdeRNVt5WHQJBwV2GZqD6bpjHjKWgLe5Ed5PH+vKkSlZPOroo+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230805; c=relaxed/simple;
	bh=bNOk+umLasMzuoz+Z3Ftjk4tBniYB+/qICHKZehwDks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXsgl9LVg29yf3juD/IAwVaAdyil6KOBEXY2lXiWtd5vqzAMsVwpknccgsAY9UinQDDacxuRZdEj01ZGy4ZXjT3FlDs5Sma2IquJYHz50UWycU7spDYGuqRsbaWZ+jP57RVKz4JHiddnAMvBrmjLLMjSsqbAi2CETtCgByNbKSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=tVfXl4OO; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="tVfXl4OO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1785230603;
	bh=CJDWP0RrRATJ39dktP1ubgvLcnOU5KeX0VfhsRNhudc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tVfXl4OOKUccD9zNjLH5hH0LYVczkqPVxyHaUrjOgO/vUp9ZuqGugdRVP5ULphaxO
	 7c6MKt+Sr9E8QNg1i2++SQS29hL72uc/Yf3oUms5R228O3HfUyW+pJikBDfmAYH040
	 Dj1OZehw9BEk7+mI06WAmn/MoMjWJT3q6LhE60/o=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.117])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66S9NL4S004577
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
Subject: [PATCH net 3/4] Revert "vhost-net: wake queue of tun/tap after ptr_ring consume"
Date: Tue, 28 Jul 2026 11:22:39 +0200
Message-ID: <20260728092240.250257-4-simon.schippers@tu-dortmund.de>
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

This reverts commit baf808fe4fcd35767ab732b4ab2ea80dabfd97a6.

There is no netdev queue left to wake after reverting
commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop
when a qdisc is present").

Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c      | 23 -----------------------
 drivers/vhost/net.c    | 21 ++++++---------------
 include/linux/if_tun.h |  3 ---
 3 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index ec5573f545af..39abc3078097 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3787,29 +3787,6 @@ struct ptr_ring *tun_get_tx_ring(struct file *file)
 }
 EXPORT_SYMBOL_GPL(tun_get_tx_ring);
 
-/* Callers must hold ring.consumer_lock */
-void tun_wake_queue(struct file *file, int consumed)
-{
-	struct tun_file *tfile;
-	struct tun_struct *tun;
-
-	if (file->f_op != &tun_fops)
-		return;
-
-	tfile = file->private_data;
-	if (!tfile)
-		return;
-
-	rcu_read_lock();
-
-	tun = rcu_dereference(tfile->tun);
-	if (tun)
-		__tun_wake_queue(tun, tfile, consumed);
-
-	rcu_read_unlock();
-}
-EXPORT_SYMBOL_GPL(tun_wake_queue);
-
 module_init(tun_init);
 module_exit(tun_cleanup);
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 3e72b9c6af0c..6949b704166d 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -176,21 +176,13 @@ static void *vhost_net_buf_consume(struct vhost_net_buf *rxq)
 	return ret;
 }
 
-static int vhost_net_buf_produce(struct sock *sk,
-				 struct vhost_net_virtqueue *nvq)
+static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq)
 {
-	struct file *file = sk->sk_socket->file;
 	struct vhost_net_buf *rxq = &nvq->rxq;
 
 	rxq->head = 0;
-	spin_lock(&nvq->rx_ring->consumer_lock);
-	rxq->tail = __ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
-					       VHOST_NET_BATCH);
-
-	if (rxq->tail)
-		tun_wake_queue(file, rxq->tail);
-
-	spin_unlock(&nvq->rx_ring->consumer_lock);
+	rxq->tail = ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
+					      VHOST_NET_BATCH);
 	return rxq->tail;
 }
 
@@ -217,15 +209,14 @@ static int vhost_net_buf_peek_len(void *ptr)
 	return __skb_array_len_with_tag(ptr);
 }
 
-static int vhost_net_buf_peek(struct sock *sk,
-			      struct vhost_net_virtqueue *nvq)
+static int vhost_net_buf_peek(struct vhost_net_virtqueue *nvq)
 {
 	struct vhost_net_buf *rxq = &nvq->rxq;
 
 	if (!vhost_net_buf_is_empty(rxq))
 		goto out;
 
-	if (!vhost_net_buf_produce(sk, nvq))
+	if (!vhost_net_buf_produce(nvq))
 		return 0;
 
 out:
@@ -1013,7 +1004,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
 	unsigned long flags;
 
 	if (rvq->rx_ring)
-		return vhost_net_buf_peek(sk, rvq);
+		return vhost_net_buf_peek(rvq);
 
 	spin_lock_irqsave(&sk->sk_receive_queue.lock, flags);
 	head = skb_peek(&sk->sk_receive_queue);
diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
index 5f3e206c7a73..80166eb62f41 100644
--- a/include/linux/if_tun.h
+++ b/include/linux/if_tun.h
@@ -22,7 +22,6 @@ struct tun_msg_ctl {
 #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
 struct socket *tun_get_socket(struct file *);
 struct ptr_ring *tun_get_tx_ring(struct file *file);
-void tun_wake_queue(struct file *file, int consumed);
 
 static inline bool tun_is_xdp_frame(void *ptr)
 {
@@ -56,8 +55,6 @@ static inline struct ptr_ring *tun_get_tx_ring(struct file *f)
 	return ERR_PTR(-EINVAL);
 }
 
-static inline void tun_wake_queue(struct file *f, int consumed) {}
-
 static inline bool tun_is_xdp_frame(void *ptr)
 {
 	return false;
-- 
2.43.0

