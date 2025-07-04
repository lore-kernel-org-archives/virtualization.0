Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C985327F183
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614060; cv=none; b=GAXxL0ctHx2PHn+yLwuizc3M8gAmBQF4TXIe+TkXAs8JXP0vZYf5Naog4TlGm87Did6JZN9mxbUiykZOhg4RoMEG4OxThjK9Z2cdYyWDJ/EoToYWZyzpRukG3/n/iPB56SsHMyuzqI3N+mbGowxIp3MmlslzDwacA+MBIIDpMNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614060; c=relaxed/simple;
	bh=yVFYo6Kk/6Zc9eHOlHEVJQtvOkaea4d9X8jdBYc1rs8=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=L4ZoSy53TGDlCftFz9M2HyjuUOGjHKfmUJuv7TXcatxSf+ukjcwqKoAQ02NSNVnCWeAurW7nZgUNwl1y6UeNkIO8J0pSstUqFFQjTGTbtkrC/ZJflp6v9jgMAl/mSDTtXP6ph7kQDDhUv4whj4Lb5LNcfTfoEfSPGUKLB8DfvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4bYQ6S48nTzCh0y
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 15:21:20 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4bYQ6J6dJtz4xD51
	for <virtualization@lists.linux.dev>; Fri,  4 Jul 2025 15:21:12 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bYQ644Mftz8R044;
	Fri,  4 Jul 2025 15:21:00 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 5647KiW8090359;
	Fri, 4 Jul 2025 15:20:44 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid31;
	Fri, 4 Jul 2025 15:20:47 +0800 (CST)
Date: Fri, 4 Jul 2025 15:20:47 +0800 (CST)
X-Zmail-TransId: 2af9686780cf5ce-2beb8
X-Mailer: Zmail v1.0
Message-ID: <20250704152047205U11FdEih1MxrmcmAz0Xpp@zte.com.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>
Cc: <mst@redhat.com>, <eperezma@redhat.com>, <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSB2aXJ0aW86IEFkZCBtaXNzaW5nIGtlcm5lbGRvYyBmb3IgdmlydGlvX2RtYV9idWZfYXR0YWNo?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5647KiW8090359
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 686780EF.000/4bYQ6S48nTzCh0y

From: Peng Jiang <jiang.peng9@zte.com.cn>

Add kerneldoc for 'virtio_dma_buf_attach' function to fix W=1 warnings:

drivers/virtio/virtio_dma_buf.c:41 function parameter 'dma_buf' not described in 'virtio_dma_buf_attach'
drivers/virtio/virtio_dma_buf.c:41 function parameter 'attach' not described in 'virtio_dma_buf_attach'

Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>
---
 drivers/virtio/virtio_dma_buf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
index 3fe1d03b0645..18d261ba5197 100644
--- a/drivers/virtio/virtio_dma_buf.c
+++ b/drivers/virtio/virtio_dma_buf.c
@@ -35,7 +35,16 @@ struct dma_buf *virtio_dma_buf_export
 EXPORT_SYMBOL(virtio_dma_buf_export);

 /**
- * virtio_dma_buf_attach - mandatory attach callback for virtio dma-bufs
+ * virtio_dma_buf_attach - Mandatory attach callback for virtio dma-bufs
+ * @dma_buf: Pointer to the shared dma-buf structure
+ * @attach: Pointer to the newly created attachment metadata
+ *
+ * Description: Implements the standard dma-buf attach operation for virtio devices.
+ *              Retrieves virtio-specific operations through container_of macro,
+ *              then invokes device-specific attach callback if present.
+ *              This enables virtio devices to participate in dma-buf sharing.
+ *
+ * Return: 0 on success, error code on failure
  */
 int virtio_dma_buf_attach(struct dma_buf *dma_buf,
                          struct dma_buf_attachment *attach)
-- 
2.25.1
