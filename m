Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6192D34CFD0
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645756; cv=none; b=arpHphF4IPAFh5wEp4KPJyFGHTpPpKNEIphirTaPIrVUM3kX3TKDXE5XwEoJWEmRrNTDdny6q8oxgQcyyXTrKMsekmrLmqws/Sn3EXx2ylvAJE56+IueH7hBTE13oQmIIy8T4Slq6O3p1nwz+0zn8XJfnu25KQS0bRSPo0Fmo7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645756; c=relaxed/simple;
	bh=n/m2fIo1//fzphMsR8a6nCfeSIhnPB3+DDLk5P+GvuI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XyTvILRd1nKVrVnVFK5HO0NxAr+mqjgH8TXhP5HDQmjLTlZQNNKU79B1Zpth0pV5B0QtFYiNZ+6OCiT+G4zIqxq2fi6iAcSYBNnNlNAF+KQjY6OJDQfViqYqGyCP8kSJPh6TXoPVYeneEZH49aigLPqWHfVncavpOCpmiSBy8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4fZ63h5kFfztyPT;
	Mon, 16 Mar 2026 15:22:08 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4fZ63g6BQ0zrg5n;
	Mon, 16 Mar 2026 15:22:07 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 6A4224B74;
	Mon, 16 Mar 2026 15:22:05 +0800 (CST)
Received: from SZ-4DN1M34.Hygon.cn (172.28.22.30) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 16 Mar
 2026 15:22:07 +0800
From: Di Zhu <zhud@hygon.cn>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <netdev@vger.kernel.org>,
	<virtualization@lists.linux.dev>
CC: <zhud@hygon.cn>, <lijing@hygon.cn>, <yingzhiwei@hygon.cn>
Subject: [PATCH net-next v2] virtio-net: enable NETIF_F_GRO_HW only if GRO-related offloads are supported
Date: Mon, 16 Mar 2026 15:21:52 +0800
Message-ID: <20260316072152.910857-1-zhud@hygon.cn>
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

Although VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated, which indicates
the device supports dynamic control of guest offloads, it does not
necessarily mean the device supports specific hardware GRO features.

If none of the features defined in GUEST_OFFLOAD_GRO_HW_MASK (such as
TSO4, TSO6, or UFO) are present in vi->guest_offloads_capable, the
device effectively lacks the hardware capability to perform GRO.

So, making NETIF_F_GRO_HW conditional on these feature bits ensures the
stack does not enable an unsupported hardware offload configuration.

Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
Signed-off-by: Di Zhu <zhud@hygon.cn>
---
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


