Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54713B2A9
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803894; cv=none; b=buWMu30ZuGxcpzw+RGg7dAMzJAno+i/102IO9YDI0l67CMT49dzFfBkoPMqP86/DEOgQy9ofTikkDCGlEswk19ai4ZG6L3z18djdoIL9WKKENxXB9FP9Eues/GMBreQRRuulthvonUA5aEserxnnoC+A+dQnNYh+gxjpbOLwQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803894; c=relaxed/simple;
	bh=X2ww7mo1EYAKEUJYJPCsYfRdkjPJyGq5e6PMda/4UgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OguYvGzHJ1xN3GjulPOPcuUnk3XN4a85uyrPbSIM6LzuDm5TrjOfNwt4DhF1llUHJeYtY8wwBRpXmCxEvMvh5/k475/SUBf7TXTicUOV2kAPXrUjrjI6p8eW4KME05NmYap4ijLVl4gtIGOqGiZ8mURbUIZ2zRE8E5hvdpj28hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UEikXO6N; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UEikXO6N"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712803890; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TVKXEqi6RpM2JHJlXMJGr9y1zwACVOZXZquRsz2lu3M=;
	b=UEikXO6N9L4zkvpWWEUcGW+3YnRnUOtRRU+1M+gPs0xl+aDhcMGxuZ8LRqGUBeHcHqdIA/4Nv4cWORndflyshLQ1W01Rrdaj212dgIeAnhC7H8QN/Himqk9d13zqBmin98gjPlahh/8NgzAyuIke4OadwVHg8AbJlu19jVj/UQU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4JWvKl_1712803889;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4JWvKl_1712803889)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 10:51:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH vhost 2/6] virtio_ring: enable premapped mode whatever use_dma_api
Date: Thu, 11 Apr 2024 10:51:23 +0800
Message-Id: <20240411025127.51945-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: aa9dfb80fb4a
Content-Transfer-Encoding: 8bit

Now, we have virtio DMA APIs, the driver can be the premapped
mode whatever the virtio core uses dma api or not.

So remove the limit of checking use_dma_api from
virtqueue_set_dma_premapped().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1b9fb680cff3..72c438c5f7d7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2730,7 +2730,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  *
  * Returns zero or a negative error.
  * 0: success.
- * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
+ * -EINVAL: NOT called immediately.
  */
 int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 {
@@ -2746,11 +2746,6 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
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

