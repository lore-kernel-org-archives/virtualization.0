Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2086E1AD9F3
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427644; cv=none; b=cEJ6NLsXfMmHmL6LkgWeHp59HQwTSCnuKzUtQ06F/uf6JthjrclgmtNa7yp5Eo4xqQPVcPjMgdg30lz7hn38R0AW+41KPJ68BU8xTKwguaLt4ChZ6+sq03m5VxrXBq2ejM72igq9s/LsY2CF/6PRHG8KhbsWTVvZvh8jg1ongmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427644; c=relaxed/simple;
	bh=IG0sLTr1ygsrZ9QQNYZ3NvorpUUrl5P7khwkpOdDsEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IRsjCLzx55Up0w08lf/Vu5Y+pdSZCmCbeTwejWaZn3oDMqWVtJnEUBEnvtoj4V/yiDt+6imL9z7b+FhM2TH/WuUDqTmiNE2TbcgpokWum4rb8tZRgS4Oe4GX64Qcjzec4mvvhL+XuIcyKWtJwNDYE23EVjLM795qcE68y5jvGgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KBi9/TIl; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KBi9/TIl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722427639; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=3/4aoQPbG1Pa9Rn1w9hMYyTZ8VepBocG16uKLmvBsoA=;
	b=KBi9/TIlPvJxRqwHvC2DvCQJ5vxRCT8XIS518rk21BRHhQgedz4IWkyc7iU8B7tnpkKQcNH5DaXeoj+tRs+SME0F0dO3QaSgyvBgsOVLTnHNv8RxgKJ/1quJx8KnYh78sGQEX8gnb9OCSHu05e+wUhPSVwZSQbjUPLszDw1xowo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBjL5TJ_1722427637;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBjL5TJ_1722427637)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 20:07:18 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?EugenioP=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net v2] virtio-net: unbreak vq resizing when coalescing is not negotiated
Date: Wed, 31 Jul 2024 20:07:17 +0800
Message-Id: <20240731120717.49955-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From the virtio spec:

	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.

The driver must not send vq notification coalescing commands if
VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
applies to vq resize.

Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Eugenio Pé rez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
v1->v2:
 - Rephrase the subject.
 - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd().

 drivers/net/virtio_net.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0383a3e136d6..2b566d893ea3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3658,6 +3658,9 @@ static int virtnet_send_rx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
 {
 	int err;
 
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		return -EOPNOTSUPP;
+
 	err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
 					    max_usecs, max_packets);
 	if (err)
@@ -3675,6 +3678,9 @@ static int virtnet_send_tx_ctrl_coal_vq_cmd(struct virtnet_info *vi,
 {
 	int err;
 
+	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
+		return -EOPNOTSUPP;
+
 	err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
 					    max_usecs, max_packets);
 	if (err)
@@ -3743,7 +3749,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
 			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
 							       vi->intr_coal_tx.max_usecs,
 							       vi->intr_coal_tx.max_packets);
-			if (err)
+			if (err && err != -EOPNOTSUPP)
 				return err;
 		}
 
@@ -3758,7 +3764,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
 							       vi->intr_coal_rx.max_usecs,
 							       vi->intr_coal_rx.max_packets);
 			mutex_unlock(&vi->rq[i].dim_lock);
-			if (err)
+			if (err && err != -EOPNOTSUPP)
 				return err;
 		}
 	}
-- 
2.32.0.3.g01195cf9f

