Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB61AAE17
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835617; cv=none; b=R4MwBp87IFSz7DEA7KjC56zcgKo8W+jKfLFS6LIP8vfM2oi4l7/iSf5HJnba+YGATQ7rEJEWmWMAMUskVHOtUgK/KKHl5a9ut1PvYuB9/xb/tivKZxuGgaQRPYeK1/dzWMH358nrLkEFEuUpZKIo4mbxluCC0h98lubzcKWUQXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835617; c=relaxed/simple;
	bh=jBF80Yx+3FCuFKVPS+l7WwM4nmOJtwFzmfOzAlloupw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBsncwzBhQdExkP6zp4+i7n72c09zgG2hRcfxeTL/IRlBtM9JUwqnT5iM9ZI1x6P9mhVXOj9ukqjWlMABvfCHfol2j9UIaMsxK+wk0c9qQNjw7pAaZcAvCIkUWs4Q5OgpuV6OJ8WGz22y/0T60wlS+70evKCLZmrc5T6n3WDN9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a0b837568fe611f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ba48527c-da75-4b5e-94c6-dfff419019d4,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:8154115da632ba0047fcb1f69b71ef88,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a0b837568fe611f1aa26b74ffac11d73-20260804
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1543689485; Tue, 04 Aug 2026 17:26:52 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] virtio-vdpa: Use queue id when setting vq affinity
Date: Tue,  4 Aug 2026 17:26:49 +0800
Message-ID: <20260804092649.1344478-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When optional queues are skipped, pass the compressed vDPA queue id to
set_vq_affinity() so affinity is applied to the queue that was actually
created.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/virtio/virtio_vdpa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index de2af696d..6bcf4567a 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -352,7 +352,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			continue;
 		}
 
-		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++, vqi->callback,
+		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx, vqi->callback,
 					      vqi->name, vqi->ctx);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
@@ -360,7 +360,8 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		}
 
 		if (has_affinity)
-			ops->set_vq_affinity(vdpa, i, &masks[i]);
+			ops->set_vq_affinity(vdpa, queue_idx, &masks[i]);
+		queue_idx++;
 	}
 
 	cb.callback = virtio_vdpa_config_cb;
-- 
2.43.0

