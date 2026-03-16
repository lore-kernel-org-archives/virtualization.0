Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0287430FC27
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646390; cv=none; b=PgZtm5x6AcjNzJ4ZwaQLuigVr4AZnQkQshx03NCZcthnalu/sBhXQISmRgMXV7/Kl+CxEB9zJ9ybR2W+7FjLvJBgbXnNeOQecv4zyEFd9jCea+3Tw4Iq3RBI14yQrHl5Hq2ar/zxtfB4Y/ATiSin4N+n0vF/gi86N8L6LhV8e8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646390; c=relaxed/simple;
	bh=n/m2fIo1//fzphMsR8a6nCfeSIhnPB3+DDLk5P+GvuI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QlZ/khvk+Iy45b9xQETuKKxC7cS8vOvK5GqofhfeX8k77O+1l0WJJFXJEnoqi2/JLLpvI0zBOBjkqZ1iPfLVQHKynNNQ41pl+yaWvu4dioNjUaNto+rJXhZzeKIJ3Nci4aMm9gAr0AAh377TkaY1F7fHUIl2E1x57Yi2bgCY3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fZ6J12dC3z1YHN2l;
	Mon, 16 Mar 2026 15:32:49 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fZ6Hy5Zknz1YHN2l;
	Mon, 16 Mar 2026 15:32:46 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 77CB531C6206;
	Mon, 16 Mar 2026 15:31:27 +0800 (CST)
Received: from SZ-4DN1M34.Hygon.cn (172.28.22.30) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 16 Mar
 2026 15:32:44 +0800
From: Di Zhu <zhud@hygon.cn>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <netdev@vger.kernel.org>,
	<virtualization@lists.linux.dev>
CC: <zhud@hygon.cn>, <lijing@hygon.cn>, <yingzhiwei@hygon.cn>
Subject: [PATCH net v2] virtio-net: enable NETIF_F_GRO_HW only if GRO-related offloads are supported
Date: Mon, 16 Mar 2026 15:32:29 +0800
Message-ID: <20260316073229.910962-1-zhud@hygon.cn>
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


