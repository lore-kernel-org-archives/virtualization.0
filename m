Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5B71E2833
	for <virtualization@lists.linux.dev>; Wed, 30 Oct 2024 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276712; cv=none; b=qPmEFYhCBJGYfODhubWb9NpVggivIc/jUY/0AO3P0zdaHHD9/cKHarP4Ipja4ctFNwtz3b0lXDgQrBZCOtjGfIF6KrJnptnZRGpvWdDhrYVEw8l1fb+18vqF6nZAkyQUMc6124jjHgGXwdcnLQsRxtvezrhE15p5fNA2BrGBcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276712; c=relaxed/simple;
	bh=0IcgHsWsxASZw5aZMF1xpM2jQIPYiNHBBMfKfngOHA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gFlOiRSGm+XCTasBEjRm2QeQNYsuUHf6rLo4th+rpl/a20WWNvkb5S33uBGdJ8dz1YeTgeWnSkq732fF1o2ue3kJc9BvWbhMHZ54luodkQYuLcI0yOGVEkv6ee4p5vYQCO4QJiXUchgye8OP4jN0AtA3/0Vx/zVQEDmCyXeZQyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k0VYngx8; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k0VYngx8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730276707; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TKYRO8AtSaV0pgGbnbh+Sj/yOt2XApUc2b3UWrxyb+8=;
	b=k0VYngx8jfTvQ6/Fg5dlxd8hKaWfJ9nIg6n+G18LgCP6RrvEdawv3PyvHFSHqyRkxH0z8VOzqo+YyWyXv7WrxuCwEuPD6Fs3EwkhZ2n/B/8wx8QMup55Cwr/nxMtVe1we0DpU+E4RwNpguqV9QYlFY7XTSQQEaBPbXSomVakmtE=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIDQj0f_1730276706 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 16:25:07 +0800
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
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 13/13] virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
Date: Wed, 30 Oct 2024 16:24:53 +0800
Message-Id: <20241030082453.97310-14-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 87bfcb32ef14
Content-Transfer-Encoding: 8bit

Now, we support AF_XDP(xsk). Add NETDEV_XDP_ACT_XSK_ZEROCOPY to
xdp_features.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 091e3ed0cafa..43e5234af699 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6614,7 +6614,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->hw_features |= NETIF_F_GRO_HW;
 
 	dev->vlan_features = dev->features;
-	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+		NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	/* MTU range: 68 - 65535 */
 	dev->min_mtu = MIN_MTU;
-- 
2.32.0.3.g01195cf9f

