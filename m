Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794027496;
	b=pFxiV8arWwbjF01POBlc1nmKiHTtv0hQ56J/XdkzJAzh/zoeKchMTdH/CM7o4mcgJ2aQ
	 tnoKh4Y1K7Fcsub7L4LFf5P6rbiUmuqw4ggDrU0fxyKfCxw8zY9/HtR/vmdhS84bpf/lH
	 jrYa3JqPSlyTXW4CeTYq/OO6gt/db8lBD2mnO3dSdbAx1tAe9IxwznPCmNrKC/0TT0lbT
	 9/wxJJAh7Q+y3/3qfLcOuo5OV4GMwX4VwuM/DSFhZNJGPBzQPUIJwWG+n8+v+H7tLlzj1
	 6li91NMfh4qj5B0TIGAJoTewaSK1ILFKZYcLoT0cV28PZuUWqjjgfMJarZY++JYbIxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027496;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=k/8YzMNiVPZlBUW40yrliXFv9KTnhM76PNAu4E7vSnw=;
	b=b8OKYfG0xIF8AgfxzScCupDUd8Y/Wz+nndnwNg1/rHXWzKyJoc/THP2tqc5rf5XdZzZ/
	 0/AtPzUg+Ldnt501rjQxMgKxVvuoRYjvNi/c35wYLuHmG5pocm6ANtF3ct2Dx87s+Un8N
	 eDWoY5+ET0iSiZJa4qeYyJ2lIkLvJoXFIRGYxYBVMMaDLd5FxyvtZvaPxSft/OV7r7aOj
	 +VMDFgWoIr0c69dk3nAXsOaG0F7If58qh2wkksIIYZd8sn3Ci00oULf5RHTXiblUZjl18
	 1i6BSPpz7W4NMO9KJjlkolktw5jyQJmQn+mI643mY6+9KtCag6dIOgS702co2G5N5Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=SaDZMVKj;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A506606A32F
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 04:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A506606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=SaDZMVKj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=SaDZMVKjyMlf0KH9q3yyUhjZ520K80NGBM605AVOIOvReWJidJ6up7qUNoOfajiiVWjPrc3r+voXz
	 wSKmOHc7MqUsMjZuOD73E8VIsp54HSXT6QDlKvJCfWBFlCas2sDMvIEO9cYrI1FK0XjvpXNQUy267D
	 ONOHuHo1OVLe1tuU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26aeeafd8a49-f164b;
	Sat, 07 Nov 2026 12:58:06 +0800 (CST)
X-RM-TRANSID:2ee26aeeafd8a49-f164b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36aeeafb3fe6-3a4df;
	Sat, 07 Nov 2026 12:58:06 +0800 (CST)
X-RM-TRANSID:2ee36aeeafb3fe6-3a4df
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
Subject: [PATCH net 1/2] virtio_net: Don't DMA map the kernel image for the AF_XDP TX header
Date: Sat,  7 Nov 2026 21:57:02 +0900
Message-ID: <20261107125723.33547-2-yanhaishuang@cmss.chinamobile.com>
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

virtnet_xsk_pool_enable() DMA maps the static xsk_hdr, which lives in
the kernel image. On arm64 the kernel image is mapped in the vmalloc
area, so when the device uses the DMA API the mapping is rejected:

  virtio_net virtio0: rejecting DMA map of vmalloc memory
  WARNING: drivers/virtio/virtio_ring.c:3882 ...

and binding an AF_XDP zero-copy socket fails with -ENOMEM. Even where
the mapping succeeds, the header shares cache lines with unrelated data.

Allocate the all-zero header per send queue when the pool is enabled
and free it when it is disabled.

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 drivers/net/virtio_net.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6fbe..4f5d8812f75b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -315,6 +315,8 @@ struct send_queue {
 
 	struct xsk_buff_pool *xsk_pool;
 
+	/* All-zero header shared by the AF_XDP packets sent on this queue */
+	struct virtio_net_common_hdr *xsk_hdr;
 	dma_addr_t xsk_hdr_dma_addr;
 };
 
@@ -500,8 +502,6 @@ struct virtio_net_common_hdr {
 	};
 };
 
-static struct virtio_net_common_hdr xsk_hdr;
-
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq);
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
@@ -5971,11 +5971,21 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (!rq->xsk_buffs)
 		return -ENOMEM;
 
-	hdr_dma = virtqueue_map_single_attrs(sq->vq, &xsk_hdr, vi->hdr_len,
+	/*
+	 * Don't map a static header: the kernel image is not in the linear
+	 * map on all architectures (e.g. arm64), so it can't be DMA mapped.
+	 */
+	sq->xsk_hdr = kzalloc_obj(*sq->xsk_hdr);
+	if (!sq->xsk_hdr) {
+		err = -ENOMEM;
+		goto err_free_buffs;
+	}
+
+	hdr_dma = virtqueue_map_single_attrs(sq->vq, sq->xsk_hdr, vi->hdr_len,
 					     DMA_TO_DEVICE, 0);
 	if (virtqueue_map_mapping_error(sq->vq, hdr_dma)) {
 		err = -ENOMEM;
-		goto err_free_buffs;
+		goto err_free_hdr;
 	}
 
 	err = xsk_pool_dma_map(pool, dma_dev, 0);
@@ -6004,6 +6014,9 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 err_xsk_map:
 	virtqueue_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
 				     DMA_TO_DEVICE, 0);
+err_free_hdr:
+	kfree(sq->xsk_hdr);
+	sq->xsk_hdr = NULL;
 err_free_buffs:
 	kvfree(rq->xsk_buffs);
 	return err;
@@ -6032,6 +6045,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 
 	virtqueue_unmap_single_attrs(sq->vq, sq->xsk_hdr_dma_addr,
 				     vi->hdr_len, DMA_TO_DEVICE, 0);
+	kfree(sq->xsk_hdr);
+	sq->xsk_hdr = NULL;
 	kvfree(rq->xsk_buffs);
 
 	return err;
-- 
2.43.0



