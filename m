Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A87391825
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 01:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786067910; cv=none; b=PwRKfgj+tfcVwbkpZ3mbw0tPT0BO+RtVEPKr2GbARSfxxlC252EKx9XRXRySRBJWlcCVJrFpfQUDMzrMrj71K0NGNvwbdkeDBW5EYLg3+DUn5HsoQcbfL5jV4HBsgyIt7B1C57GPLa26wkWXEK3JJBnN/hFtleeJ5M3xky06BsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786067910; c=relaxed/simple;
	bh=qCt3NMdGrtTZzqPQxUKLRnwYWfMYVnqTuad7JXGfnmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcWHchsT9KAcDl0PN6MWUi0PL70yffO5m1tYaTNhXHBno5kdZIMVyHlWeX/pvttK6ENHzRvGdunGYYucbFpijkXDVUdSsZV5YBYhujeYMA9/oU2+y7RVkpyudki/Z/2Dm3UV3Ko7g45LLKkf3nK4UKscDEvxl95TmnNa+6vXXhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 778c80e8920311f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9a1d9045-fd64-4f9c-927b-45924b860d6e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:76090eea841d40bd49fa197843e709fd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 778c80e8920311f1aa26b74ffac11d73-20260807
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 379205173; Fri, 07 Aug 2026 09:58:21 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Brett Creeley <brett.creeley@amd.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowangio@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH] vdpa/virtio_pci: use dev_err for vq notify map failure
Date: Fri,  7 Aug 2026 09:58:18 +0800
Message-ID: <20260807015818.2139754-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178606788689.2139700.16021825706254629026@kylinos.cn>
References: <178606788689.2139700.16021825706254629026@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mapping failure on the device add path is a hard error and already
returns -EINVAL.  Use dev_err() to match that, same as pds_vdpa.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 51ffc245a..26841f03b 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -562,7 +562,7 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 						&vp_vdpa->vring[i].notify_pa);
 		if (!vp_vdpa->vring[i].notify) {
 			ret = -EINVAL;
-			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);
+			dev_err(&pdev->dev, "Fail to map vq notify %d\n", i);
 			goto err;
 		}
 	}
-- 
2.43.0

