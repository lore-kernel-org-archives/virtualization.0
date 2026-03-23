Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DFE248F62
	for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 04:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774239492; cv=none; b=NtFxZ4yMs/sGu/2U/JEzMv7BRb/RPZwlhK4WDfgSjpOcCtaaO2G9pBn5hBM7QWrbSx6926fssLPD5Fn16pwy70niQZj/xPxgsEq0Ck4/f/TYv3uI6W+UCZR0ytA1lD61caANBe9tSMttG+oGq9P/Kem1jdWObJM7SCw6jl12DVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774239492; c=relaxed/simple;
	bh=FdzHX14MszIeI/OFsmiEfmyz9F3tUdHog/RLyXl3PDU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tlh2z+OkUvtQEKQhtuMcDhtV/Ofi8yEfNPl528jLc2ouCMTJSBc2PlNfZnB/h30PSRykNcFo9vxhYBnDYkbvGpq/X/2mBEgR3cp4ZEb7Gnl0SS5F9gRyBczk8KloxB8G8RFFOI2ebbqLUP0vh5Q2RdedlkmcP92B+cxI55dnJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4ffKdk0v8qz1YQpmD;
	Mon, 23 Mar 2026 12:17:46 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4ffKdg3B8wz1YQpmG;
	Mon, 23 Mar 2026 12:17:43 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id F15CD3008F68;
	Mon, 23 Mar 2026 12:16:14 +0800 (CST)
Received: from SZ-4DN1M34.Hygon.cn (172.28.22.30) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 23 Mar
 2026 12:17:41 +0800
From: Di Zhu <zhud@hygon.cn>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <netdev@vger.kernel.org>,
	<virtualization@lists.linux.dev>
CC: <zhud@hygon.cn>, <lijing@hygon.cn>, <yingzhiwei@hygon.cn>
Subject: [PATCH net-next v4] virtio-net: enable NETIF_F_GRO_HW only if GRO-related offloads are supported
Date: Mon, 23 Mar 2026 12:17:30 +0800
Message-ID: <20260323041730.986351-1-zhud@hygon.cn>
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

Signed-off-by: Di Zhu <zhud@hygon.cn>
---
/* v4 */
  -Move the hw_features update logic before register_netdevice()
  -Target the net-next tree

/* v3 */
  -Update Fixes tag to dbcf24d15388
  -Refine commit message using Maintainer's "too optimistic"
    phrasing to clarify the risk of misleading configurations.

/* v2 */
  -make the modified logic clearer
---
 drivers/net/virtio_net.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 022f60728721..29bd313e7592 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6795,8 +6795,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
 		dev->features |= NETIF_F_GRO_HW;
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
-		dev->hw_features |= NETIF_F_GRO_HW;
 
 	dev->vlan_features = dev->features;
 	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
@@ -6989,6 +6987,19 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	enable_rx_mode_work(vi);
 
+	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++) {
+		unsigned int fbit;
+
+		fbit = virtio_offload_to_feature(guest_offloads[i]);
+		if (virtio_has_feature(vi->vdev, fbit))
+			set_bit(guest_offloads[i], &vi->guest_offloads);
+	}
+	vi->guest_offloads_capable = vi->guest_offloads;
+
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) &&
+	    (vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
+		dev->hw_features |= NETIF_F_GRO_HW;
+
 	/* serialize netdev register + virtio_device_ready() with ndo_open() */
 	rtnl_lock();
 
@@ -7071,15 +7082,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 		netif_carrier_on(dev);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++) {
-		unsigned int fbit;
-
-		fbit = virtio_offload_to_feature(guest_offloads[i]);
-		if (virtio_has_feature(vi->vdev, fbit))
-			set_bit(guest_offloads[i], &vi->guest_offloads);
-	}
-	vi->guest_offloads_capable = vi->guest_offloads;
-
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
-- 
2.34.1


