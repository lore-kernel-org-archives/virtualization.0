Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0A3D9680
	for <virtualization@lists.linux.dev>; Wed,  5 Aug 2026 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916514; cv=none; b=GF712wJ+gC99e5dhWilLvaymkYFRUS0NFsNhl8I4TsdRROPtRfXns88Ju3RSYEIGDieQDVVjkl1wGxKBM9KH60EfAidoU07xJZEH+ovbZ+ZOvzS8EcykCfOEUvZjgyti7YpSl8l7zJwFwYHi1ubEkYh/xxR6rnc9nWqDaF5bK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916514; c=relaxed/simple;
	bh=N0rM1vE26NFB7w6LHfI6xd2Q86kao0THg9xuqI785ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KNB+3jYkzwI8BLEpQZsWKoqgjRL/E2b2HSbvHKh4hB1ChqYq1riwx7LMDxAzq0fUF345KikVqUCodVtX6HqKV/fNvYQvvvEfokkWs280+xi4iy7khdjTmqzBrPd3faVKHg7eMoMJFDqylInnWiwPj9bPLMW3Syi0Pat3516fcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f8645b8a90a211f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2a8e3bb5-6d1f-48dc-a7fb-20b64c66aba2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:de698e470874da575e420b507aa79b23,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f8645b8a90a211f1aa26b74ffac11d73-20260805
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 845753141; Wed, 05 Aug 2026 15:55:05 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH v2] virtio_pci: do not mutate caller irq_affinity.pre_vectors
Date: Wed,  5 Aug 2026 15:55:02 +0800
Message-ID: <20260805075502.1674970-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vp_request_msix_vectors() bumps desc->pre_vectors in place to reserve
the virtio config vector. vp_find_vqs() may call it more than once while
retrying MSI-X with different per-vq policies (EACH -> SHARED_SLOW ->
SHARED), so the caller's irq_affinity can accumulate and later attempts
get the wrong affinity layout.

This was not observed in production; it is inferred from that retry path.
Copy the descriptor to a local "affinity", adjust pre_vectors there,
assign desc = &affinity, and pass desc to pci_alloc_irq_vectors_affinity().

Fixes: ba74b6f7fcc0 ("virtio_pci: fix cpu affinity support")
Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
Changes in v2:
- use local "affinity" and assign desc = &affinity (mst)
- drop comment arguing with previous code
- drop Cc: stable; state issue was not observed (theoretical)

 drivers/virtio/virtio_pci_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 164f480b1..9415d160d 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -128,6 +128,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	const char *name = dev_name(&vp_dev->vdev.dev);
+	struct irq_affinity affinity;
 	unsigned int flags = PCI_IRQ_MSIX;
 	unsigned int i, v;
 	int err = -ENOMEM;
@@ -150,8 +151,10 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 		desc = NULL;
 
 	if (desc) {
+		affinity = *desc;
+		affinity.pre_vectors++; /* virtio config vector */
+		desc = &affinity;
 		flags |= PCI_IRQ_AFFINITY;
-		desc->pre_vectors++; /* virtio config vector */
 	}
 
 	err = pci_alloc_irq_vectors_affinity(vp_dev->pci_dev, nvectors,
-- 
2.43.0

