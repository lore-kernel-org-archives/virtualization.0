Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B461134BA29
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245699; cv=none; b=IDHnN269thm2IlOEwhjr72k5/2IFsVnWgt802qwZa0tQpx2L155oNLfoTFUqbUIDWZkgqtM9xazLpTbWikfnkyyTX3/f+5G9zpJNpAlde73qvmaWpdqEl7xi4zW794UFgaXeNoRcrJFBwOLvEbc9yRP/wc/pHAY7cI3NeC2BHgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245699; c=relaxed/simple;
	bh=lJYEuAf6VDWdCErnVrRsVKPl4GfmP3hnp2qqY2A30ps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jPBfJ4PPrHnJoC08RcDaVTUtowbOHJTlTw1/gS5w3Aqjcvds/bNGeEDZRoX0VDEbxVilDi50FOfiB6YZpWavSj3wFfllEsVqtMLzHRJNGEk+mpMpEcHC4uzRfHMsvhB5KjTzEwHeVpnxs8og9bORjcfWQ7+45jonh1movFP+7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nfl74tkI; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nfl74tkI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758245692; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NsFGh+9mw+WdnZ/caHT4763xAMzma/QFNrbt/6FOTkk=;
	b=nfl74tkIrNpw6N34qGqzy6e7v/0UZ3z+hngBmtmVavBZtbbSXwwuCxTYLu+vXqWIJmt2TJyuhul/DrTSVc4leuSEUzVrTSsaWuberJHcYbGfK0XPHjQB0KB9zhww9M4kZJ2SNbIGI5LVL1QvZCVI02qT3ZaA8Sk6b9rTkRuqzVo=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WoHsaiy_1758245691 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Sep 2025 09:34:51 +0800
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
	virtualization@lists.linux.dev
Subject: [PATCH net] virtio-net: fix incorrect flags recording in big mode
Date: Fri, 19 Sep 2025 09:34:50 +0800
Message-Id: <20250919013450.111424-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 7426b57cb775
Content-Transfer-Encoding: 8bit

The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
checksummed packets handling") is to record the flags in advance, as
their value may be overwritten in the XDP case. However, the flags
recorded under big mode are incorrect, because in big mode, the passed
buf does not point to the rx buffer, but rather to the page of the
submitted buffer. This commit fixes this issue.

For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
buf address when unmapping for small packets") fixed it.

Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packets handling")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 975bdc5dab84..6e6e74390955 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2630,13 +2630,19 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	 */
 	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
 
-	if (vi->mergeable_rx_bufs)
+	if (vi->mergeable_rx_bufs) {
 		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
 					stats);
-	else if (vi->big_packets)
+	} else if (vi->big_packets) {
+		void *p;
+
+		p = page_address((struct page *)buf);
+		flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
+
 		skb = receive_big(dev, vi, rq, buf, len, stats);
-	else
+	} else {
 		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
+	}
 
 	if (unlikely(!skb))
 		return;
-- 
2.32.0.3.g01195cf9f

