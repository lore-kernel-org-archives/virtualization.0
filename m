Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92CF14D420
	for <virtualization@lists.linux.dev>; Fri, 14 Jun 2024 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347189; cv=none; b=NcCk/3t8MNh+cF347HgVtark35KFAzunNwEy4VP6dekh6CI+5Mcz5NmwSkFC2v/Aj5FVYGu1rf2iOOVfHU+i4HXe7WzWCR/IKEePHw2D/3l8Vl0hIk4TSGuILSpQkQxLypkiDtwvwyMZ5TKj7m46fL5yqmUrlaeE50kvkqWqycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347189; c=relaxed/simple;
	bh=JNOnnmOFu1NUWWjC8WtNGzYk18S62nPmUhl6YzbpQds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kOPijKG5H+HDin1JdBVE1oLQQIm8xo7WPhNJe+P1WKezXutdAxaPX0ftFc5cSPrvdruD2uoZQL4XGK4chT6IvfFeYpRCkD3Hq0ZGoPYeRpTi63WLmzt7CmC+pI6dSFAbKo4Oat0wXvz8b55Dse5VhqzkaT0aOvVT0jDew+3v6g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U5MshxJo; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U5MshxJo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718347185; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AsxCsmPwJLPCPz8R6ARZ0TKBqaj/tWLFeD6Lswatkas=;
	b=U5MshxJotsTtaBkTcpVgNnGfM22mTO3cjRvrbxvS0Dv/NpUplIUBZzfSzSWtsJd9u0gV3HLfpnjmj7ygkRKZOHO8/YHMyu5CGUFdm0wi8q1mkpfgQSISooTTgr5FoYIgJFZ8ZQUCm50bh3ah1Qiv1uChQ6u6sUKyiT/L80Ik1cI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8QKgVb_1718347184;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8QKgVb_1718347184)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 14:39:44 +0800
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
Subject: [PATCH net-next v5 12/15] virtio_net: xsk: tx: support wakeup
Date: Fri, 14 Jun 2024 14:39:30 +0800
Message-Id: <20240614063933.108811-13-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: e008fb4a0943
Content-Transfer-Encoding: 8bit

xsk wakeup is used to trigger the logic for xsk xmit by xsk framework or
user.

Virtio-net does not support to actively generate an interruption, so it
tries to trigger tx NAPI on the local cpu.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7e811f392768..9bfccef18e27 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1368,6 +1368,29 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	return sent == budget;
 }
 
+static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct send_queue *sq;
+
+	if (!netif_running(dev))
+		return -ENETDOWN;
+
+	if (qid >= vi->curr_queue_pairs)
+		return -EINVAL;
+
+	sq = &vi->sq[qid];
+
+	if (napi_if_scheduled_mark_missed(&sq->napi))
+		return 0;
+
+	local_bh_disable();
+	virtqueue_napi_schedule(&sq->napi, sq->vq);
+	local_bh_enable();
+
+	return 0;
+}
+
 static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 				   struct send_queue *sq,
 				   struct xdp_frame *xdpf)
@@ -5706,6 +5729,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
 	.ndo_bpf		= virtnet_xdp,
 	.ndo_xdp_xmit		= virtnet_xdp_xmit,
+	.ndo_xsk_wakeup         = virtnet_xsk_wakeup,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
-- 
2.32.0.3.g01195cf9f

