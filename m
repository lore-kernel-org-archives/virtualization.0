Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8C18651
	for <virtualization@lists.linux.dev>; Wed,  8 May 2024 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150246; cv=none; b=AiSp1oLLD86VIYGE0tSZZo1U2e5gLUD/iJViSmwtvfNIVHYJj4Py4Ecz8Ozb1jzGKuxcFVkOXqwa1vFV2kK6OJWyIdfZlKeiL+3ASTT0mLeniBmrJlWCMt0zgci0Zc9dxwJJp5aa9faO84M9TDIOnMC1/lvCt1pQH1BhVyRS0mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150246; c=relaxed/simple;
	bh=n6mg4XesdT1sasQ4rhkqIrST1eSMhlO7ON9mvf+RTao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EYjBPVMzmBn/L/burtXG9uNE4gbdtpuU4hgZ69/izk9cBAQao1yyc21CrNGts+7z5gRLc+V7WD5C6MJcVZcdzO1dnqrMMDs6x7uAtAL8mt1ctJJeI1PAQzZyhcnC/LgY9kj19ggliqEvVAcH2X3jL2gCdoAqB4DIhdvTGCayrB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YeYW/jfh; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YeYW/jfh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715150241; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ZCv5CQGZmW/6p3pLhCJK6Ph9CKCR6rO9ZXIFczRA9H4=;
	b=YeYW/jfh/BoAuHeZJcSlp3h2ue8OBPUTxog5QbZZhc/AMy4Bl1+5LYx8CESb4EoEdyLmB3Shv66SKu6NhtdiRDUfG3mMXO7wPCzYg3AzJrOUpkPjf+qrgBzKsNPNwvr3eGI25EzOTjHL8SuVQ+OgQnOcGMJtiQg7r2iHcH8Bjf0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W62X2oK_1715150239;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W62X2oK_1715150239)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 14:37:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next v4 1/4] virtio_ring: enable premapped mode whatever use_dma_api
Date: Wed,  8 May 2024 14:37:15 +0800
Message-Id: <20240508063718.69806-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240508063718.69806-1-xuanzhuo@linux.alibaba.com>
References: <20240508063718.69806-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: cadd21343bbc
Content-Transfer-Encoding: 8bit

Now, we have virtio DMA APIs, the driver can be the premapped
mode whatever the virtio core uses dma api or not.

So remove the limit of checking use_dma_api from
virtqueue_set_dma_premapped().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6f7e5010a673..85d0dc26ae9f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2782,7 +2782,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  *
  * Returns zero or a negative error.
  * 0: success.
- * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
+ * -EINVAL: the vq is in use.
  */
 int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 {
@@ -2798,11 +2798,6 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 		return -EINVAL;
 	}
 
-	if (!vq->use_dma_api) {
-		END_USE(vq);
-		return -EINVAL;
-	}
-
 	vq->premapped = true;
 	vq->do_unmap = false;
 
-- 
2.32.0.3.g01195cf9f

