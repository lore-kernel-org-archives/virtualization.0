Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB942157467
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518626; cv=none; b=Ug2YFHs1UAUcbI6Ga8xreq6qZllq/pxZ/pJQMujQ6KFAEnflNqaKVuSKgP3prLBmq5qSwqkjLlYtPm6ubBzc4S6f0VF48GXwey4B5JnxgSpQw6+hWIUcxIexictGy6/FoHJNhv1nLSUgq1tIzKM0//m1nWccFZdBwKYfvFN3iWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518626; c=relaxed/simple;
	bh=pxAMgUl6RpgEzddwp0OuSLVZnmbZKSASw1sE3RPnW5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nqCY7ydCRulx661I/XBSGazoZmpeb3n1KkuvU00z0bVeLhTomE4/uWONWMdnm2hCc4pjHZ3aKlDOeAfSQY0/IPVyVjwiOKgDkXXQCZbvu1cZPDIgBa7J345KvJ8CMXjf49m5iNL5CE+U4Gh/0b3AiGIGNQyp2ohHpl/Z/rADDu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bUjp3cXX; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bUjp3cXX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722518621; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nmlezCt3y4sHPiSBV8DTZAgWvKS3ESvpRmOQCDwrnNQ=;
	b=bUjp3cXXWg/lvCir4fkpVeV3G3hTN590HU4FhC2Gku7bKQ+ad1XUNUl8GZlayE4ympVqdC1+BFXgyLnrVqd/vVD/d7hxssykkeDj8kuiTH69ucwC6m3sAKcFaYegLi/B6dLXEC83eYPzLtSecj1RiKEmGyibDsvejORQDlxSfgM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBtoWuU_1722518620;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBtoWuU_1722518620)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 21:23:40 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net v4 1/2] virtio-net: check feature before configuring the vq coalescing command
Date: Thu,  1 Aug 2024 21:23:37 +0800
Message-Id: <20240801132338.107025-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240801132338.107025-1-hengqi@linux.alibaba.com>
References: <20240801132338.107025-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtio spec says:

	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.

So we add the feature negotiation check to
virtnet_send_{r,t}x_ctrl_coal_vq_cmd as a basis for the next bugfix patch.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
v2->v3:
  - Break out the feature check and the fix into separate patches.

 drivers/net/virtio_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0383a3e136d6..b1176be8fcfd 100644
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
-- 
2.32.0.3.g01195cf9f

