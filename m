Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCB921FF26
	for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707360; cv=none; b=Gwn0/7Lz+dgoMwQo2Ko4M4qckvLeXvABr9xq43w8nTqWy9yz1lcluqhtFHc01glE/zR9AyFHS9FPIvVYVX0If8Qmujue8V+uRLQtoAPXss6sN9/kZWB595i2jGwUCAgjQ432HOGFNOuK5TN5GSu7evHQLXxrro3bTZzfg6B4HuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707360; c=relaxed/simple;
	bh=VsGrtzGrNy1cIT4AoNC/ON4WFlgvVfd6eytwrKQgnPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Es+Q7xp6fIbW5ZkmBH9Qar2lu13rdZl+UsjyTick8cS/Ts8OdsZ/dh3PaO6JqR3ZvhSQOQ2aG8zprYjf7ffYVk0PTXDTn6gJm73aayOWZs6HGjM7vnAqOkFz5hOuq8cYe5gcEbekcR7DTelWOMm2ADR8nCTcY2Lp6+5AWADToug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lUzUD6CL; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lUzUD6CL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761707355; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=38XUyf4PYI6r7rorqyBRnTafMkc9cf9wYq9IqQkZUMc=;
	b=lUzUD6CLhMYrQs2oQyQMdwsTQLnCWEd+PKUIiAJr9oOifTKx9XYEQ0Lmk+vknnpcFonrf/sfbvuzT9mcQqj++0WkjnnC1ECimcDFGrTp5UYZFUrMgXTjderLcngrVzSqyzK/GPpA/aP8p/mQrT3su+HO+Vycj1ZtNYI6yiVeyBE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrEEDMM_1761707354 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Oct 2025 11:09:14 +0800
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
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v4 1/4] virtio-net: fix incorrect flags recording in big mode
Date: Wed, 29 Oct 2025 11:09:10 +0800
Message-Id: <20251029030913.20423-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: eb1fbe1c38ee
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
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8e8a179aaa49..59f116b609f6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2625,22 +2625,28 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
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

