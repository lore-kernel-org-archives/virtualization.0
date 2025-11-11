Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C2325C838
	for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852114; cv=none; b=LAPpk+mk9mNG6CNYAw8vOEvhc6MOJJDqhY5Y/AbcRzarpvNIYWcskZA5O/y0ha692VZ8wl3Ti67jpbR8lLP6/hhfGYm9DF2sNKhrun/XXwGjonrW8bpff5lSpLHfVAAfVbo7W+C0YCNsk6TplaJ6ZauLo8NgxaC1aUlhMYUrWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852114; c=relaxed/simple;
	bh=pQlaWfkvG+vSUcyYWJl1r66Np93z97auVAruVvWhpGA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hvjsLNQRLXWLgFewW7WuDmtwH2fgDZPQqzQ5ZraRo3cFUM+FE18LWHvpV4Rp31JLaFVnf2KIBzLNbEcDzo6/RABPK8ynacb/G/0LqXt6SZipECiuyOfqyANU6EL+rXcCXhGXFCUSpQ5vgTFeQYtZQxBBkL9raypyoBLROplUmK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b1gkVOwo; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b1gkVOwo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762852109; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sqKzZ2nD6zFQsaxqpanPW11WAC4gRU6LXToUrVV4N3E=;
	b=b1gkVOwoLHLx16tb7XJR7MfggO2Px+wEo5JyFa4qpvK7PYL5enZaTMqmyBWWaBjkVNHLlHQ9s76nZnOnZxzoT7dNGhuZW9ct+nz61ZjT867JTU0RDbqGptrCY+riEoymmrfQm2pbTui4jt7buQ1IbDq3pkP3ET6IzG/HgWaaU5w=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WsAw63y_1762852108 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Nov 2025 17:08:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Alyssa Ross <hi@alyssa.is>
Subject: [PATCH] virtio-net: fix incorrect flags recording in big mode
Date: Tue, 11 Nov 2025 17:08:28 +0800
Message-Id: <20251111090828.23186-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 71bd53b0b6bf
Content-Transfer-Encoding: 8bit

The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
checksummed packets handling") is to record the flags in advance, as
their value may be overwritten in the XDP case. However, the flags
recorded under big mode are incorrect, because in big mode, the passed
buf does not point to the rx buffer, but rather to the page of the
submitted buffer. This commit fixes this issue.

For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
buf address when unmapping for small packets") fixed it.

Tested-by: Alyssa Ross <hi@alyssa.is>
Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packets handling")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8855a994e12b..0369dda5ed60 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2631,22 +2631,28 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		return;
 	}
 
-	/* 1. Save the flags early, as the XDP program might overwrite them.
+	/* About the flags below:
+	 * 1. Save the flags early, as the XDP program might overwrite them.
 	 * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
 	 * stay valid after XDP processing.
 	 * 2. XDP doesn't work with partially checksummed packets (refer to
 	 * virtnet_xdp_set()), so packets marked as
 	 * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
 	 */
-	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
 
-	if (vi->mergeable_rx_bufs)
+	if (vi->mergeable_rx_bufs) {
+		flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
 		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
 					stats);
-	else if (vi->big_packets)
+	} else if (vi->big_packets) {
+		void *p = page_address((struct page *)buf);
+
+		flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
 		skb = receive_big(dev, vi, rq, buf, len, stats);
-	else
+	} else {
+		flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
 		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
+	}
 
 	if (unlikely(!skb))
 		return;
-- 
2.32.0.3.g01195cf9f

