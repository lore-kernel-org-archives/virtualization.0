Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E444AB93
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833632; cv=none; b=nPQOfbnfQIjIjXf7kSm8zGyX5yA5zxwco35ouCuS9pwZnYVV7graFHBRuRU6l1oGriRLUcP5i0TTQ3gJrEhJKJ0D1Wg17kUgVdASj/tplUbWkG30mJQzmwxgU4WG5wefGtKqThp6DjLEGo53HcdtJ/QwFPRLkFFjZyfokwRr7qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833632; c=relaxed/simple;
	bh=wpYkna2DI8tzTwXphGjACH0HVYLZl4Bl+TTw2fB5RSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rHOnZJdZqMCHOWmsvXd6kgFtTPmZ633KP40xx5CARqnojn0DQPy85jHJV9FIyLCYaMQXWP9pKf1oCM8ZrOWTK36SGS6BBUgrgi3tA2Qg52DruOIUSk6mhZ11HH7LUo/dcXZEiq3jlbaZR/QV8ZTc4NFZmxotYFqs+qgaM6lY7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ffb8e9588fe111f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:fe5403f8-9a70-42fe-8a06-337c287d2e3e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:39e93c22c0328d9772b6dcdd91079282,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ffb8e9588fe111f1aa26b74ffac11d73-20260804
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1030571462; Tue, 04 Aug 2026 16:53:44 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Brett Creeley <brett.creeley@amd.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] vdpa/pds: check virtqueue notify mapping
Date: Tue,  4 Aug 2026 16:53:41 +0800
Message-ID: <20260804085341.1333303-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vp_modern_map_vq_notify() can fail and return NULL.  Check the notify
mapping while adding a pds vDPA device and use the existing teardown path
instead of storing a NULL doorbell pointer in the virtqueue state.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/vdpa/pds/vdpa_dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 43426bd97..df53cfce9 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -731,6 +731,12 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 
 		notify = vp_modern_map_vq_notify(&pdsv->vdpa_aux->vd_mdev,
 						 i, &pdsv->vqs[i].notify_pa);
+		if (!notify) {
+			err = -EINVAL;
+			dev_warn(dev, "Fail to map vq notify %d\n", i);
+			goto err_unmap;
+		}
+
 		pds_vdpa_init_vqs_entry(pdsv, i, notify);
 	}
 
-- 
2.43.0

