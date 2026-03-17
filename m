Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209E0340A76
	for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747366; cv=none; b=SrOJBVmAP85Q3cI1LW9C5W260tN8mCx9T0/z0HEfLyirW8kc9y8OEsXv1B9sjhpu4TwTBEtIVEt+ZqbPqapZQoUQ04nwnbGEAouiIXn+v5csVzL0/VWdYlYvao0A8K+l/a9YMmZD9Y9Eh9Ita3zXBQ45cBe2c4TLVLkg6VLXm5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747366; c=relaxed/simple;
	bh=O93yltRG3CkyZGubYRJthm+WDgRR4JhOkoUy8EcZyps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JElPxvkDcz55oC7QbzMC+u2stbJcFE3zN3nkQOlUkKu7G4y3N+sd4uh5+wmti7NIYrjps9lqjDP+mQ1vhzNZicossauvPb95X08CV4LTPgDvlVy7oxGghDqAaYwXFZG4Q/EiTd9sXBmnL+BaEWDTxkOhIrQYe+BNh3RaY+P6aXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fZqdl6TtGz1YQpmJ;
	Tue, 17 Mar 2026 19:35:39 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fZqdj073Nz1YQpmJ;
	Tue, 17 Mar 2026 19:35:37 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 9126B30004F8;
	Tue, 17 Mar 2026 19:34:15 +0800 (CST)
Received: from SZ-4DN1M34.Hygon.cn (172.28.22.30) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 17 Mar
 2026 19:35:35 +0800
From: Di Zhu <zhud@hygon.cn>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <netdev@vger.kernel.org>,
	<virtualization@lists.linux.dev>
CC: <zhud@hygon.cn>, <lijing@hygon.cn>, <yingzhiwei@hygon.cn>
Subject: [PATCH net v3] virtio-net: enable NETIF_F_GRO_HW only if GRO-related offloads are supported
Date: Tue, 17 Mar 2026 19:34:33 +0800
Message-ID: <20260317113433.927022-1-zhud@hygon.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

Negotiating VIRTIO_NET_F_CTRL_GUEST_OFFLOADS indicates the device
allows control over offload support, but the offloads that can be
controlled may have nothing to do with GRO (e.g., if neither GUEST_TSO4
nor GUEST_TSO6 is supported).

In such a setup, reporting NETIF_F_GRO_HW as available for the device
is too optimistic and misleading to the user.

Improve the situation by masking off NETIF_F_GRO_HW unless the device
possesses actual GRO-related offload capabilities. Out of an abundance
of caution, this does not change the current behaviour for hardware with
just v6 or just v4 GRO: current interfaces do not allow distinguishing
between v6/v4 GRO, so we can't expose them to userspace precisely.

Fixes: dbcf24d15388 ("virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO")
Signed-off-by: Di Zhu <zhud@hygon.cn>
---
/* v3 */
  -Update Fixes tag to dbcf24d15388
  -Refine commit message using Maintainer's "too optimistic" 
    phrasing to clarify the risk of misleading configurations.

/* v2 */
  -make the modified logic clearer
---
 drivers/net/virtio_net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 72d6a9c6a5a2..b233c99925e9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6781,8 +6781,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
 		dev->features |= NETIF_F_GRO_HW;
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
-		dev->hw_features |= NETIF_F_GRO_HW;
 
 	dev->vlan_features = dev->features;
 	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
@@ -7058,6 +7056,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 	vi->guest_offloads_capable = vi->guest_offloads;
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) &&
+	    (vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
+		dev->hw_features |= NETIF_F_GRO_HW;
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
-- 
2.34.1


