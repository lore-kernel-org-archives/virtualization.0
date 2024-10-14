Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F5460DCF
	for <virtualization@lists.linux.dev>; Mon, 14 Oct 2024 03:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875567; cv=none; b=edARcQSavIUKMqzQ7PlpR/m0dWRIuVo+bqpo/Tloedlcea42b5nUQGhW1fiVlGmZMCYu0+UuOot5kR3eWnUxtTtwWWM5Jjr4cF5g7d4rXLk7Gw6BtGHagcRuhC53HvO/wHZGHKLkbVGp+fymfWss6PCngxAWTlp0GjzNyo6rHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875567; c=relaxed/simple;
	bh=texysb0oMlboTBEcTXJZB/LDlVjukIWBLuQxBwmKgYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cfF6O8Hz+PIMaVNco+QRZkHFqopMyuXWOvALs58L8lNalxhNlgLsrpoukq8NKtdxRh732nhZuLZa0B6cD8jUOJzyDyPIPDECxM3r4waY9OF2hKpTksYD4xHda2swYdaMz+iVdcyHdqQemveG7z3Y7nia1UMSTkB0/rL/OXe9gcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dIMMT119; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dIMMT119"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728875558; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kEqE/mvC9NiKzNXZg92xnGDP6/XNpv4tYHyaAHHbc74=;
	b=dIMMT119J3YitYm394mjih1IB8KAUdsWv9wowx7OrOy8h7Ir2oYLbQX+YScyoEM0RGcHQfdt+dEMjGXDxrRFrez2r0yErZSCDOuNxZVV1K+9gTaFYK1KxGOgyP/ReEwzKnsyGJWscogaptEkr4lSs1rdkawRhKkhW65Hab65lNA=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WH.LEVS_1728875557 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 11:12:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 3/5] virtio_net: big mode skip the unmap check
Date: Mon, 14 Oct 2024 11:12:32 +0800
Message-Id: <20241014031234.7659-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: bba499faae26
Content-Transfer-Encoding: 8bit

The virtio-net big mode did not enable premapped mode,
so we did not need to check the unmap. And the subsequent
commit will remove the failover code for failing enable
premapped for merge and small mode. So we need to remove
the checking do_dma code in the big mode path.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 14809b614d62..cd90e77881df 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -998,7 +998,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 		return;
 	}
 
-	if (rq->do_dma)
+	if (vi->mode != VIRTNET_MODE_BIG)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
@@ -2738,7 +2738,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
 		}
 	} else {
 		while (packets < budget &&
-		       (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
+		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
 			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, stats);
 			packets++;
 		}
-- 
2.32.0.3.g01195cf9f

