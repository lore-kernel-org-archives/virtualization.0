Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5CEC04A92
	for <virtualization@archiver.kernel.org>; Tue,  7 Nov 2023 03:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64141607CA;
	Tue,  7 Nov 2023 03:12:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 64141607CA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1TjGdb64F4yf; Tue,  7 Nov 2023 03:12:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 783A161321;
	Tue,  7 Nov 2023 03:12:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 783A161321
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B143EC0DE2;
	Tue,  7 Nov 2023 03:12:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53F7BC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2307161314
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2307161314
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oMlUSTAnjf-r
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:51 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F7A361318
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F7A361318
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VvsNiih_1699326765; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VvsNiih_1699326765) by smtp.aliyun-inc.com;
 Tue, 07 Nov 2023 11:12:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 15/21] virtio_net: xsk: tx:
 virtnet_sq_free_unused_buf() check xsk buffer
Date: Tue,  7 Nov 2023 11:12:21 +0800
Message-Id: <20231107031227.100015-16-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 59a160d210e8
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

virtnet_sq_free_unused_buf() check xsk buffer.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 6a5e74c482f3..6210a6e37396 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -3919,16 +3919,18 @@ void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 
 	sq = &vi->sq[i];
 
-	if (!virtnet_is_xdp_frame(buf)) {
+	if (virtnet_is_skb_ptr(buf)) {
 		if (sq->do_dma)
 			buf = virtnet_sq_unmap(sq, buf);
 
 		dev_kfree_skb(buf);
-	} else {
+	} else if (virtnet_is_xdp_frame(buf)) {
 		if (sq->do_dma)
 			buf = virtnet_sq_unmap(sq, buf);
 
 		xdp_return_frame(virtnet_ptr_to_xdp(buf));
+	} else {
+		xsk_tx_completed(sq->xsk.pool, 1);
 	}
 }
 
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
