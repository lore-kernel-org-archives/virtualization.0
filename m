Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137966;
	b=JfTnWhG4ioZC3dJJv2cPmRDUFbQgzTzzS32Jc8cvwQ35xZJtr/H8uaHd1z/ODspl3SvJ
	 KlV2A5MSBXSwKzvHnw+7uNlpO2oMPRLCD0YNuOT6C9HMRHvaKONuGCKuCnese5pQrfLm3
	 /2fPJWA+asI0ACYcpac0WDm8hkHjtPQHOxSvGtXZEkTzXtWdbamwde1ony+hE+C0HJxCv
	 +vSR8+arqstmYEGZkSrarjbVHzemy1rE8c+SaKHN1VaKgt7LL7woUD2mrhkdtDhGEFhp7
	 Xzp+aKi/CO+CH/j+pxt+KbLTxGpW9lk/3JQmpeHiU65MGYh1/uFe+wo3IhsHWN220zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137966;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LbzaqQGFmzrDNLY8pfpPf7Z7ukRfAz9YQL2MzccnQJY=;
	b=cA0zpi2YYB+CbNvx9Zb46El6Vygcb7EsRD9XQdtLMiLeHn1y6C107Q0gcz9MYo4xhEfq
	 fJdavjVMoFb9sUDrAPyDloq2NwnPC13i5Sa+l0oLlWl1u3eqEZh6JFm9NfFBxVPVwMYfc
	 YYkdeEXw8Mf10eMOGLx2oX9stQMNnbKBd3mMG/VGfygOl/KNgKyr+hnVsDEU6vaNoaFEk
	 xM+akfveMOudN8TkfuQcSprXkO7iUiHEtu0w50SMrMoUKmeGfeZzoF8pdlEJu/mUODNTi
	 fZa3Snxxhs0LSErTmljWCugFLSfD6aO8uRzPGPs73kcE+QNZIb6gSiIYvTmE6M091PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=wiBVD7RO;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C76606A321
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 11:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08C76606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=wiBVD7RO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=wiBVD7RO7vUK0oBpN0ac38KJ7wJbcRvrh/w5YKiLxmSMFOrki9TdC1kOVnsnfwz6aXQQYgPO6YxC/
	 dtt4PfPTo/VsstzvT8N5yBY8iFMBPDNQR86fWfukc7Jv5SoBKT10RQw80brLLlIqGNwuXY/6h9YW/V
	 kYT2p/5iW9da6y/s=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86af05f64334-5b2f3;
	Sun, 08 Nov 2026 19:39:24 +0800 (CST)
X-RM-TRANSID:2ee86af05f64334-5b2f3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af05f47e53-666c9;
	Sun, 08 Nov 2026 19:39:23 +0800 (CST)
X-RM-TRANSID:2eea6af05f47e53-666c9
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
Subject: [PATCH net v2 2/3] virtio_net: Disable AF_XDP pools on queues above curr_queue_pairs
Date: Mon,  9 Nov 2026 04:38:38 +0900
Message-ID: <20261108193845.73621-3-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108193845.73621-1-yanhaishuang@cmss.chinamobile.com>
References: <20261108193845.73621-1-yanhaishuang@cmss.chinamobile.com>
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

With an XDP program attached, virtnet_xdp_set() adds nr_cpu_ids queue
pairs for XDP_TX and raises curr_queue_pairs and real_num_rx_queues to
match. virtnet_xsk_pool_enable() accepts any queue below
curr_queue_pairs, so an AF_XDP zero-copy socket can be bound to one of
them.

When the program is removed, the queue count goes down again while the
pool stays bound to the driver. When the socket is closed afterwards,
virtnet_xsk_pool_disable() rejects the queue with -EINVAL, and the core
frees the pool anyway:

  WARNING: net/xdp/xsk_buff_pool.c:160 at xp_disable_drv_zc+0x1ee/0x260
  BUG: KASAN: slab-use-after-free in xp_alloc_batch+0x930/0xb40
  Read of size 8 at addr ffff8880028eb400 by task ksoftirqd/0/14
   xp_alloc_batch+0x930/0xb40
   try_fill_recv+0xb27/0x26e0

as rq->xsk_pool still points to it and the queue is refilled from it.

Removing XDP must not fail, so let virtnet_xsk_pool_disable() accept
any queue the driver has, below max_queue_pairs. The receive and send
queues above curr_queue_pairs still exist, so they are unbound as usual.

This was pointed out by the Sashiko review of v1 of this series, and
reproduced in QEMU by binding a socket to an XDP queue, removing XDP
and closing the socket.

Fixes: 09d2b3182c8e ("virtio_net: xsk: bind/unbind xsk for rx")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4f5d8812f75b..f9d227060375 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6030,7 +6030,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 	struct send_queue *sq;
 	int err;
 
-	if (qid >= vi->curr_queue_pairs)
+	/* Removing XDP can leave the pool on a queue above curr_queue_pairs */
+	if (qid >= vi->max_queue_pairs)
 		return -EINVAL;
 
 	sq = &vi->sq[qid];
-- 
2.43.0



