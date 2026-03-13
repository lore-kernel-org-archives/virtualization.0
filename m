Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77DB2EE607
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 01:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366456; cv=none; b=Ix3ZlGDCQ1XG4gmyYElxby6eg/6xSQXy3XxqXSM0/KcBR/9V0Cek6TL0rFYsnjz8L5daWYscG8m8wYg8vHns5LL1xXfAbNvD72niRBDAige4Vy+9lMh3NXsA/PBW1KnU1LbNDRyMutBlsUuEHZiCIoMg6Ke/TlWWt0S7BIkQnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366456; c=relaxed/simple;
	bh=cARjo3b5CBMHUcYu6xnyXwuPlwMkezzMLIuyLwut6pg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pP+nFdKPaympR82VKKSuqjavwl8vVUq+cO7TMICuyQTbacKJB63LyTgyiEqNS7aIdO65WjtANVETq+KecfTddWNph6Fe7tDEyrFDVlHuKWgsunyjkXKUsmlemv8IhVo+2cTCD8v22uz8ZPBwKVvPwwh9nVQM/eJWBrkBJeIlJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fX6Pq3Tszz1YHN2l;
	Fri, 13 Mar 2026 09:30:55 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fX6Pp6PYDz1YHN2l;
	Fri, 13 Mar 2026 09:30:54 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id A0FA531C620A;
	Fri, 13 Mar 2026 09:29:39 +0800 (CST)
Received: from SZ-4DN1M34.Hygon.cn (172.28.22.30) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 13 Mar
 2026 09:30:54 +0800
From: Di Zhu <zhud@hygon.cn>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <virtualization@lists.linux.dev>
CC: <zhud@hygon.cn>, <lijing@hygon.cn>, <yingzhiwei@hygon.cn>
Subject: [PATCH net] virtio-net: clear NETIF_F_GRO_HW if no GRO-related offloads are capable
Date: Fri, 13 Mar 2026 09:30:40 +0800
Message-ID: <20260313013040.896924-1-zhud@hygon.cn>
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

In this case, NETIF_F_GRO_HW should be cleared from dev->hw_features
to prevent the stack from attempting to enable an unsupported
hardware offload configuration.

Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
Signed-off-by: Di Zhu <zhud@hygon.cn>
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 72d6a9c6a5a2..49a60af684d5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -7058,6 +7058,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 	vi->guest_offloads_capable = vi->guest_offloads;
 
+	if (!(vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
+		dev->hw_features &= ~NETIF_F_GRO_HW;
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
-- 
2.34.1


