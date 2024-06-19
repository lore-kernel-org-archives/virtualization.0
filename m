Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C9515217B
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813957; cv=none; b=tp85OQZXuHT98aPNH46evqpThjkjmHuOjZ0+PCT1LZISs5Ufx20TVYweujXUVJ2e3l0B6neUOzxoCmLcVDzsmvMiZIb5N/9qvlpfo/4eab0u0hwCIfNfUpyBjMyahUl0E9SUKL0d2kF3Zo8q6d7zie2KY/E3GjR6a038SfcMtPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813957; c=relaxed/simple;
	bh=2dVbrgEZt4I1r0w8f74cvB5ZjjW89LI8igQo71XEqz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XZutx6wXQ3yzZqro+hO7cqpX2vE0vPLgfYiBN9WVMz9Ua+2lSh0YEHhhigDNk9trSIo0IH5j+fbHHu+NDr8NSmDSx9j95WgGd9Mde+N5Us97yqGZMlGQzK91264cCxGlNETheLpIRHiS41OWJ4hTQd7uQ3WtZH4nes09OFFAS80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Iod4p7yM; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Iod4p7yM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718813952; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=BiXA+YPL+qrJL81lBoNvxuO+9hIkSQiVA8RW5iLIO8M=;
	b=Iod4p7yMM4+KPaqLdvS5d/oZZWyQNNCNzMqeATPrQI+lV5czwINyYCC6xuCuS8tDx/DrbfphvAoZIwG9yWMBxyYxSYNrQTLRxoQr4j6occy/7+wn9oiJSmgAtd4OBn3g8oaw4nDPbs4ScFfUc4RRHKtW9+o1LbYBGssaqBX6B9Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8om-3F_1718813949;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8om-3F_1718813949)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 00:19:10 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 1/5] virtio_net: passing control_buf explicitly
Date: Thu, 20 Jun 2024 00:19:04 +0800
Message-Id: <20240619161908.82348-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240619161908.82348-1-hengqi@linux.alibaba.com>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a later patch, the driver may send requests concurrently, in
which case each command will have its own control buffer, so we
refactor virtnet_send_command_reply() to pass the control buffer
explicitly as a parameter.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61a57d134544..b45f58a902e3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2680,7 +2680,9 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
  * supported by the hypervisor, as indicated by feature bits, should
  * never fail unless improperly formatted.
  */
-static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd,
+static bool virtnet_send_command_reply(struct virtnet_info *vi,
+				       u8 class, u8 cmd,
+				       struct control_buf *ctrl,
 				       struct scatterlist *out,
 				       struct scatterlist *in)
 {
@@ -2693,18 +2695,18 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
 
 	mutex_lock(&vi->cvq_lock);
-	vi->ctrl->status = ~0;
-	vi->ctrl->hdr.class = class;
-	vi->ctrl->hdr.cmd = cmd;
+	ctrl->status = ~0;
+	ctrl->hdr.class = class;
+	ctrl->hdr.cmd = cmd;
 	/* Add header */
-	sg_init_one(&hdr, &vi->ctrl->hdr, sizeof(vi->ctrl->hdr));
+	sg_init_one(&hdr, &ctrl->hdr, sizeof(ctrl->hdr));
 	sgs[out_num++] = &hdr;
 
 	if (out)
 		sgs[out_num++] = out;
 
 	/* Add return status. */
-	sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status));
+	sg_init_one(&stat, &ctrl->status, sizeof(ctrl->status));
 	sgs[out_num + in_num++] = &stat;
 
 	if (in)
@@ -2732,7 +2734,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 	}
 
 unlock:
-	ok = vi->ctrl->status == VIRTIO_NET_OK;
+	ok = ctrl->status == VIRTIO_NET_OK;
 	mutex_unlock(&vi->cvq_lock);
 	return ok;
 }
@@ -2740,7 +2742,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 				 struct scatterlist *out)
 {
-	return virtnet_send_command_reply(vi, class, cmd, out, NULL);
+	return virtnet_send_command_reply(vi, class, cmd, vi->ctrl, out, NULL);
 }
 
 static int virtnet_set_mac_address(struct net_device *dev, void *p)
@@ -4020,7 +4022,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 
 	ok = virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_STATS,
 					VIRTIO_NET_CTRL_STATS_GET,
-					&sgs_out, &sgs_in);
+					vi->ctrl, &sgs_out, &sgs_in);
 
 	if (!ok)
 		return ok;
@@ -5880,7 +5882,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 		if (!virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_STATS,
 						VIRTIO_NET_CTRL_STATS_QUERY,
-						NULL, &sg)) {
+						vi->ctrl, NULL, &sg)) {
 			pr_debug("virtio_net: fail to get stats capability\n");
 			rtnl_unlock();
 			err = -EINVAL;
-- 
2.32.0.3.g01195cf9f

