Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8282E859
	for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727141541; cv=none; b=Gb/94O/Tp6Ou9nLYHIxdDcCfY/eIGyrEILQErraPsRstNiVfi9X9tFFVyIADN4ul0syDuwKjaei2Ex/vaoEGuQUOSYiDx5mfbdD0AItwj/842IFVFddj545C69HcnO6+UVgPg/o7+qrHAUQICe3+YY5B1uAPM7fDvLQ4N7xjNyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727141541; c=relaxed/simple;
	bh=6AucyNtivTnScZz7ltd0pC9UhwGBpDJB5+mw/CykqpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b4DT2EaKKlfX+oT3iUF2omNglKBt93U5OsJ58uuTR8UeL/OzGhNPip1IMcj7N4CWw18BLrtSYRdas+88e9MhjKquMhR0bxiMX8nkyaQtnKcO+/ZJzPEWg5DX1Ss/w2MJfwLhxko4OwSvRuBdCT1mwY8xTrUUeAmPxtms5jq0GOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qKS6PL3j; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qKS6PL3j"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727141537; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2BHkuN+s9X+aLlQr4SanE0NIc8ilrJLdzZC9WMhEijk=;
	b=qKS6PL3jgNF7DUWSfJjnNP5FjzV8YaPvlFLnvFgnxXHDzziquF8HiJtKOB50+Hi2Pu9VxcHObUHvH9wi+QRl0YDjGSSX3k4bn2H+5cdsMo8h4Jtue3aRtCa1W1DxJYFzouqtThToRuhTbM7zEOL/AqL0ngZ/MwR3ScxqxUFIHls=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFdvTvj_1727141535)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 09:32:15 +0800
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
Subject: [RFC net-next v1 12/12] virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
Date: Tue, 24 Sep 2024 09:32:04 +0800
Message-Id: <20240924013204.13763-13-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com>
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 83bb687d4b73
Content-Transfer-Encoding: 8bit

Now, we support AF_XDP(xsk). Add NETDEV_XDP_ACT_XSK_ZEROCOPY to
xdp_features.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a1ef0277c550..0995b4e1a1c8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6605,7 +6605,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->hw_features |= NETIF_F_GRO_HW;
 
 	dev->vlan_features = dev->features;
-	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+		NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	/* MTU range: 68 - 65535 */
 	dev->min_mtu = MIN_MTU;
-- 
2.32.0.3.g01195cf9f

