Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532941A00FA
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515267; cv=none; b=PazmpjY81e7PFXlpPQbN/qINlTbfw/4N99NK1nGRLSL0MGAZh2U8QYZtH4LpeyB+ISgXfi4Ep8eDyQfLr32I6n/EMJQjWxYAeHNfmAMelurV5yrrs/VzefbQCIvN01XI2QMJiDCgaLzMbDvOWsnEs+MRnzKPdWM/XobNHO2pClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515267; c=relaxed/simple;
	bh=ZCbf4dagKeXob6Jv7lK9X2wnUSfRPgMXFasbsE/FxhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhhMpx9YtIKS/nux3kvRRb2mAnJjZeWiQErdqKmr6Ovrk4TRfu+22c3TslGvPakyVMBEDqkMEnXL/6vTIEA4h+Y8lQouL6w/vO9VCUCK8365YdIDUDGpC0ROIE1jk2tAciPXL9FByYVaLXwNICEwHHnpESYpypApFLxtfXUEcfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cK16eBMQ; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cK16eBMQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722515263; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=39RrBFAmDzvWDA7/34qtG1o/5bUpFe1kib+dVzow0vA=;
	b=cK16eBMQ5w8dCfO1szQj8khcsXJ9ubrfWcGAB7I/t5mtLUVIRdKlbZfc/Ou0F2lKg/nAXoA42dj7l1rw2DkW62XFGK28naWYxysO3oWgq02ZWBQRV9wNmfhI8EGAP4cQhr5AUKgbJI2LtzpdQPoQxfShMcreHZOEExTAiHcExg0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBtHmkj_1722515261;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBtHmkj_1722515261)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 20:27:42 +0800
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
Subject: [PATCH net v3 2/2] virtio-net: unbreak vq resizing when coalescing is not negotiated
Date: Thu,  1 Aug 2024 20:27:39 +0800
Message-Id: <20240801122739.49008-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240801122739.49008-1-hengqi@linux.alibaba.com>
References: <20240801122739.49008-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Don't break the resize action if the vq coalescing feature
named VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated.

Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Eugenio Pé rez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
v2->v3:
  - Break out the feature check and the fix into separate patches.

v1->v2:
  - Rephrase the subject.
  - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd().

 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b1176be8fcfd..2b566d893ea3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3749,7 +3749,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
 			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
 							       vi->intr_coal_tx.max_usecs,
 							       vi->intr_coal_tx.max_packets);
-			if (err)
+			if (err && err != -EOPNOTSUPP)
 				return err;
 		}
 
@@ -3764,7 +3764,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
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

