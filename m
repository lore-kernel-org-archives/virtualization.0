Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF973477
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112411; cv=none; b=SqTuUJETlaDET7j6llgQNxMIc8QCChigEZ9MG+6TSXtg2l99fiu6LyipKy6p6rrEvfTLMlz6FknaZKcqcMIjAKgcRlFhu9A0RacX9pKXOjTsZUhOjGER8xWtetVmtpMy7bTEfzC8NzhRXzssEeSHw6Wk/d3rIIAFNdYuaQSBvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112411; c=relaxed/simple;
	bh=+IrC9urOHIedwF1kR0odnuyZvBww8uEPcCN7gRyQgdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3Ye5dfACq74j2PDBCwuVeRrbdx/hKV3L7wwMW1OG1dD4VPvLw0yH6CiWSNHHmU2rGhjHXXTc8mkkRyJEqaQDDyPbnKZl+SdemPGCNBucqLTqGNvl3Qzr7JUf+yZS13PllKRIYyWqz65HsvZmKIdny1U9hkk7TYhjXCPB6fmMME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=P+Dglg9y; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="P+Dglg9y"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721112402; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5yruBXjjDxDB+TgJ/YseyGc5x3VyzQlNgiFzoKYooZY=;
	b=P+Dglg9yp+qpLy+i4U4Q42auOC6YY03L30i06VVz1TaCpmzbPRikz0qW/NMTSb+dP1RM+zIaFb+KvH451zGw3/8x4gnP3CX7Wfg5kUPGomD8q0P8bSqXvW90O06cz1LSMZNOuN8/d3ejLA4qAJ/+bPNPdkAJ2Tg1f1GlhbqtK5s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0WAgSzlV_1721112400;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WAgSzlV_1721112400)
          by smtp.aliyun-inc.com;
          Tue, 16 Jul 2024 14:46:40 +0800
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
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [RFC net-next 13/13] virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
Date: Tue, 16 Jul 2024 14:46:28 +0800
Message-Id: <20240716064628.1950-14-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
References: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: d3e48bf059c8
Content-Transfer-Encoding: 8bit

Now, we supported AF_XDP(xsk). Add NETDEV_XDP_ACT_XSK_ZEROCOPY to
xdp_features.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 38af9f0b632e..79bfc5231426 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6573,7 +6573,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->hw_features |= NETIF_F_GRO_HW;
 
 	dev->vlan_features = dev->features;
-	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+		NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	/* MTU range: 68 - 65535 */
 	dev->min_mtu = MIN_MTU;
-- 
2.32.0.3.g01195cf9f

