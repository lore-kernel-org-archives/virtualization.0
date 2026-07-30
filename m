Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AE3CCFD4;
	Thu, 30 Jul 2026 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447625; cv=none; b=fmx71YcU8D1nSUt5QegyOoA/iMGPDsXm6T/cIfrACcHvMr70LsGL5CO3O/ZUvzBvHC4r9exmxtzuXVDgPG0oUSEa5YJLxLEPmdNdi7VOwxnlOju1tBq2T02R7qp6UqSYbBipzLkV6BXdLUluGFtnD6UgGIhyvor8uMRBlB9KCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447625; c=relaxed/simple;
	bh=rBqgu1F0koQsVsffOWRU3Qic9RIVJJtFADMpQIiTQHA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsdOThiTasUkqr/GD8G1fiGJm/6icIqSQxWE6LvzQI8HbpIf4w8bhO2PaQF7Rg8zmryXT+R7Y4DB6806u8VLlrKXD4c5nwFx6cZM8zto2kTW5cZgOi0ODUa7EjDs/8sArT7vv3RGeRDWVlISNsWqGosiACoA5Q4a1su5ZRGBT0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=anSG97m0; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="anSG97m0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1785447415;
	bh=MPl0XUkglLf9dOelFbzWW8yugpi1pWF5oFSEMbwK9pQ=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=anSG97m0YuEtJqc2LepMY18Ke7SwVqf9yE/fUIXslBzVWeCtHPELAIW9VAxt9Mly2
	 /hLKpioD1RHi2tw/nsjUo/CNHbqDxUc5c2sxZmlTZ0ivXtD8DlsbcdzFp11HxPOurF
	 UsHw7bYOdgvnNhNSFwJtntt3jfFDCectAzJERfPk=
Received: from simon-Latitude-5450.fritz.box (pd9eaa9cd.dip0.t-ipconnect.de [217.234.169.205])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66ULan2u027704
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 23:36:54 +0200 (CEST)
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
Subject: [PATCH net-next v13 3/5] vhost-net: wake queue of tun/tap after ptr_ring consume
Date: Thu, 30 Jul 2026 23:36:37 +0200
Message-ID: <20260730213639.726381-4-simon.schippers@tu-dortmund.de>
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

Add tun_wake_queue() to tun.c and export it for use by vhost-net. The
function validates that the file belongs to a tun/tap device and that
the tfile exists, dereferences the tun_struct under RCU, and delegates
to __tun_wake_queue().

vhost_net_buf_produce() now calls tun_wake_queue() after a successful
batched consume of the ring to allow the netdev subqueue to be woken up.
The point is to allow the queue to be stopped when it gets full, which
is required for traffic shaping, implemented by the following
"stop tail-drop when IFF_BACKPRESSURE is set".
As __tun_wake_queue() returns early unless IFF_BACKPRESSURE is set, a
tun/tap device that does not opt in only pays for the added check.

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c      | 23 +++++++++++++++++++++++
 drivers/vhost/net.c    | 21 +++++++++++++++------
 include/linux/if_tun.h |  3 +++
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d9db6d2e4c56..04275dcac456 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3808,6 +3808,29 @@ struct ptr_ring *tun_get_tx_ring(struct file *file)
 }
 EXPORT_SYMBOL_GPL(tun_get_tx_ring);
 
+/* Callers must hold ring.consumer_lock */
+void tun_wake_queue(struct file *file, int consumed)
+{
+	struct tun_file *tfile;
+	struct tun_struct *tun;
+
+	if (file->f_op != &tun_fops)
+		return;
+
+	tfile = file->private_data;
+	if (!tfile)
+		return;
+
+	rcu_read_lock();
+
+	tun = rcu_dereference(tfile->tun);
+	if (tun)
+		__tun_wake_queue(tun, tfile, consumed);
+
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(tun_wake_queue);
+
 module_init(tun_init);
 module_exit(tun_cleanup);
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 6949b704166d..3e72b9c6af0c 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -176,13 +176,21 @@ static void *vhost_net_buf_consume(struct vhost_net_buf *rxq)
 	return ret;
 }
 
-static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq)
+static int vhost_net_buf_produce(struct sock *sk,
+				 struct vhost_net_virtqueue *nvq)
 {
+	struct file *file = sk->sk_socket->file;
 	struct vhost_net_buf *rxq = &nvq->rxq;
 
 	rxq->head = 0;
-	rxq->tail = ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
-					      VHOST_NET_BATCH);
+	spin_lock(&nvq->rx_ring->consumer_lock);
+	rxq->tail = __ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
+					       VHOST_NET_BATCH);
+
+	if (rxq->tail)
+		tun_wake_queue(file, rxq->tail);
+
+	spin_unlock(&nvq->rx_ring->consumer_lock);
 	return rxq->tail;
 }
 
@@ -209,14 +217,15 @@ static int vhost_net_buf_peek_len(void *ptr)
 	return __skb_array_len_with_tag(ptr);
 }
 
-static int vhost_net_buf_peek(struct vhost_net_virtqueue *nvq)
+static int vhost_net_buf_peek(struct sock *sk,
+			      struct vhost_net_virtqueue *nvq)
 {
 	struct vhost_net_buf *rxq = &nvq->rxq;
 
 	if (!vhost_net_buf_is_empty(rxq))
 		goto out;
 
-	if (!vhost_net_buf_produce(nvq))
+	if (!vhost_net_buf_produce(sk, nvq))
 		return 0;
 
 out:
@@ -1004,7 +1013,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
 	unsigned long flags;
 
 	if (rvq->rx_ring)
-		return vhost_net_buf_peek(rvq);
+		return vhost_net_buf_peek(sk, rvq);
 
 	spin_lock_irqsave(&sk->sk_receive_queue.lock, flags);
 	head = skb_peek(&sk->sk_receive_queue);
diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
index 80166eb62f41..5f3e206c7a73 100644
--- a/include/linux/if_tun.h
+++ b/include/linux/if_tun.h
@@ -22,6 +22,7 @@ struct tun_msg_ctl {
 #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
 struct socket *tun_get_socket(struct file *);
 struct ptr_ring *tun_get_tx_ring(struct file *file);
+void tun_wake_queue(struct file *file, int consumed);
 
 static inline bool tun_is_xdp_frame(void *ptr)
 {
@@ -55,6 +56,8 @@ static inline struct ptr_ring *tun_get_tx_ring(struct file *f)
 	return ERR_PTR(-EINVAL);
 }
 
+static inline void tun_wake_queue(struct file *f, int consumed) {}
+
 static inline bool tun_is_xdp_frame(void *ptr)
 {
 	return false;
-- 
2.43.0

