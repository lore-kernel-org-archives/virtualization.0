Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794027498;
	b=ZRXMYFjoELdhiXzPvj4eL2/hNruKsjJyY1KRtvmWpELQDJvKBYIHIdXOODPRF1rvM8oK
	 MAi8HTYwUeHG8pjbGo11rCGTmE2jq4JGMJ2zQyOnVTLLJSkTxWPBITd/2dVjerqCYbkf+
	 G9+96Hhj3nZrnQDQtVxl4ygVRqpKPBQewuuIsi7TtUQWrrv1MQC1FUNgk+RTAfPCBxT2U
	 0J8+0f81VWOdIfhaDhWbniv+v9MA8XIvBb9ANeh/7lTn93aQI/c0LIdoiw7V+KH2DHTCH
	 282KhNGr8dGIWj7YGczbMe8arb+h5Eprl6lSkEEc8PjpdZksNcTo6ZEfSjv9AmSY0VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027498;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Sv51d9kMWMthUFjzkrWQSycwGQXVVnXwybSfAvnFHD4=;
	b=U2eEVOioX6EFDPx14CuggxlWnNCx6+9UUYqjqCz5pvvTZEyAyzG5L9WWzhfIfgvq0AJD
	 gqJjjqvUrv8F5g4JiVTSmFLZVh4ny2w5YQH04yh0p0PTRgIowy8S6ODyjlu5VsEQs+FAs
	 FcMVhcAKco5Ieo6+cOPPGmmPRu2SiABPDvKnI+l09fUmQ1jMyAfN+V3UYngxdAKUooHfu
	 IZlfGKT2G10TDZ2YZe4T6hFzpB27mn5XfyEHq3loNkXbe7koKIRrllVei1UXRguNxHEMF
	 P9ANOGpqfhwZeWwFXmjdNwIRC7nnYzWP0KiWxfuAHaQGI5DyaRC6McfFa/3mccKpcgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QJvdD8Mq;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5370606A32D
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 04:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5370606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QJvdD8Mq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=QJvdD8MqIVYWdiA2be5avnyDoyvSA/PmvOh5dwG40SJtfvP2orN/vICWu0YpR6rI/7/XBHGIeis+T
	 jOhdKrFCXZ5t/9Zurpdom8YD5EfIfCOp43bgZ216UvUXo62hSVlSjaXViLKxl37P6ADWnz3Mh/HA1w
	 RZYC8lKxDcws0ihI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26aeeafe0a4d-f164f;
	Sat, 07 Nov 2026 12:58:10 +0800 (CST)
X-RM-TRANSID:2ee26aeeafe0a4d-f164f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36aeeafb3fe6-3a4e5;
	Sat, 07 Nov 2026 12:58:10 +0800 (CST)
X-RM-TRANSID:2ee36aeeafb3fe6-3a4e5
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
Subject: [PATCH net 2/2] virtio_net: Keep AF_XDP zero-copy pools bound across suspend
Date: Sat,  7 Nov 2026 21:57:03 +0900
Message-ID: <20261107125723.33547-3-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107125723.33547-1-yanhaishuang@cmss.chinamobile.com>
References: <20261107125723.33547-1-yanhaishuang@cmss.chinamobile.com>
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

Release the driver side of all zero-copy pools before freezing and bind
the pools the core still has for the queues again after restore. Also
return early from virtnet_xsk_pool_disable() for a queue without a pool,
in case rebinding failed.

Fixes: 09d2b3182c8e ("virtio_net: xsk: bind/unbind xsk for rx")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 drivers/net/virtio_net.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4f5d8812f75b..5995ad730a91 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6037,6 +6037,9 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 	rq = &vi->rq[qid];
 
 	pool = rq->xsk_pool;
+	/* Not bound to the driver, e.g. if rebinding it on restore failed */
+	if (!pool)
+		return 0;
 
 	err = virtnet_rq_bind_xsk_pool(vi, rq, NULL);
 	err |= virtnet_sq_bind_xsk_pool(vi, sq, NULL);
@@ -6052,6 +6055,42 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 	return err;
 }
 
+/*
+ * Freeze frees the receive and send queues while the AF_XDP sockets stay
+ * bound to the device, so release the driver side of the zero-copy pools
+ * before and bind them again after restore.
+ */
+static void __maybe_unused virtnet_xsk_pools_unbind(struct virtnet_info *vi)
+{
+	int i;
+
+	ASSERT_RTNL();
+
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		if (vi->rq[i].xsk_pool)
+			virtnet_xsk_pool_disable(vi->dev, i);
+}
+
+static void __maybe_unused virtnet_xsk_pools_rebind(struct virtnet_info *vi)
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
+		err = virtnet_xsk_pool_enable(vi->dev, pool, i);
+		if (err)
+			netdev_warn(vi->dev,
+				    "failed to rebind AF_XDP pool to queue %d: %d\n",
+				    i, err);
+	}
+}
+
 static int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	if (xdp->xsk.pool)
@@ -7246,6 +7285,10 @@ static __maybe_unused int virtnet_freeze(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
 
+	rtnl_lock();
+	virtnet_xsk_pools_unbind(vi);
+	rtnl_unlock();
+
 	virtnet_cpu_notif_remove(vi);
 	virtnet_freeze_down(vdev);
 	remove_vq_common(vi);
@@ -7270,6 +7313,10 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
 		return err;
 	}
 
+	rtnl_lock();
+	virtnet_xsk_pools_rebind(vi);
+	rtnl_unlock();
+
 	return 0;
 }
 
-- 
2.43.0



