Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C282DB7BB
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317308; cv=none; b=aVRPLWnY28M2yiYsPsSMv6s5p6rSU0JFLIJnWXFGhVoDd5z1OLvMkyJqhcXFyoNk8IgveZP2W6xPeEOgnnIZkoWyBisnDH/3qRBwOnO7/X1r49oVKnVL7fAyfReD9hndEL6Yn7foAHRHH5Dwq1rKRtVy2Zn4eUvYghPlIdbE+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317308; c=relaxed/simple;
	bh=FtouXrjN44WuUWV0XSxv44zAKX3DKlpVqHdSJECpLBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gab5JS7W9HuMd2/5oz7YQ/LGGITR8qY6seZQYQAnMJ+l3iFzSSPDixgLFxNvB9ZG2dvWjxN2Htl2qyHmOBRSmbe5VCMVmCbyX/jUPGL3jiiT8qtR8wLrgPco1cZixt+vxhHYKOKinKIx63zh/54lwfX6zBAS6iQk/ucfB069j5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d5d2c30e8b2f11f1aa26b74ffac11d73-20260729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d3d679cc-9761-4ca0-be78-73ebad86c6a3,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:d3d679cc-9761-4ca0-be78-73ebad86c6a3,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:337e9f3fa106a96a6ffcb96d335b0fbf,BulkI
	D:260729172822ZO2XGNUG,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d5d2c30e8b2f11f1aa26b74ffac11d73-20260729
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1071181322; Wed, 29 Jul 2026 17:28:19 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	virtualization@lists.linux.dev
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	David Stevens <stevensd@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: fix kernel-doc for virtio_dma_buf_ops
Date: Wed, 29 Jul 2026 17:27:53 +0800
Message-ID: <20260729092753.1164526-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio_dma_buf_ops kernel-doc describes the required get_uuid
callback as get_uid. This leaves get_uuid undocumented and causes
kernel-doc to report an excess get_uid description.

Use the actual member name in the documentation.

Fixes: a0308938ec81 ("virtio: add dma-buf support for exported objects")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 include/linux/virtio_dma_buf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_dma_buf.h b/include/linux/virtio_dma_buf.h
index a2fdf217ac62..545ac5f17a54 100644
--- a/include/linux/virtio_dma_buf.h
+++ b/include/linux/virtio_dma_buf.h
@@ -17,7 +17,7 @@
  * @ops: the base dma_buf_ops. ops.attach MUST be virtio_dma_buf_attach.
  * @device_attach: [optional] callback invoked by virtio_dma_buf_attach during
  *		   all attach operations.
- * @get_uid: [required] callback to get the uuid of the exported object.
+ * @get_uuid: [required] callback to get the uuid of the exported object.
  */
 struct virtio_dma_buf_ops {
 	struct dma_buf_ops ops;
-- 
2.43.0

