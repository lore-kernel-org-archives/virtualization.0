Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ED7134A8
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EA0E60A69
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3EA0E60A69
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9SOWArHCFy8L
	for <virtualization@lists.linux-foundation.org>;
	Fri, 29 Dec 2023 07:31:42 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 369AA60A63
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 369AA60A63
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VzQyWBn_1703835097;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzQyWBn_1703835097)
          by smtp.aliyun-inc.com;
          Fri, 29 Dec 2023 15:31:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 25/27] virtio_net: xsk: rx: free the unused xsk buffer
Date: Fri, 29 Dec 2023 15:31:06 +0800
Message-Id: <20231229073108.57778-26-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 20112a26898d
Content-Transfer-Encoding: 8bit

Since this will be called in other circumstances(freeze), we must check
whether it is xsk's buffer in this function. It cannot be judged outside
this function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index b1567f0746e8..cc0194c14c98 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -3962,6 +3962,14 @@ void virtnet_rq_free_unused_bufs(struct virtqueue *vq)
 	rq = &vi->rq[i];
 
 	while ((buf = virtqueue_detach_unused_buf(vq)) != NULL) {
+		if (rq->xsk.pool) {
+			struct xdp_buff *xdp;
+
+			xdp = (struct xdp_buff *)buf;
+			xsk_buff_free(xdp);
+			continue;
+		}
+
 		if (virtqueue_get_dma_premapped(rq->vq))
 			virtnet_rq_unmap(rq, buf, 0);
 
-- 
2.32.0.3.g01195cf9f

