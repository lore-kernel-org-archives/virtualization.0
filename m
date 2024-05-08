Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188791EB45
	for <virtualization@lists.linux.dev>; Wed,  8 May 2024 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150254; cv=none; b=Ry72U4sGGVAS2UCBwR+YTuFYMsavglhpb11ASvmUxOlk3xHvtbmLoYUmF5kGBAjb/qtjUVqrgvomMXzkJBh6+MgAC7xOH6bBm35HzvIbSWaUI/ni4wSVPIReQkjSVDM/2gbsUxjF95CExm3WtJYEbH3yvFI5vx68T5SvU8n5YfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150254; c=relaxed/simple;
	bh=hcwYkt96xwHkA7ahkN8VHJK+7gLlmBNZ4M8oYBXSh2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GUReqBwHXXrHOQy8/JejtlkqDrdeoz2lP9KmAI75v+6KP9Qxyo8wSGz2tXZsi9lWbJUHTJuIdUrqoVD9lvO6sLd4WnU6eoBCh1Qfu+6KbbaRGyOVUBz908QV7yUHIBS+hEEnGK1ei/YHz6C2fg7x6VnvzeYgrOlvwzHkAibgDt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x9VQ9QBj; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x9VQ9QBj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715150245; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6bPNehLJ+wlPYqvVl2prLGx5zEg+cgzpA4yB2IiN51c=;
	b=x9VQ9QBj45+Yc4oJIdBoVe5OQjiyq8CjuJ+YUyoti1+Celd64lte+jo6XSwWeFFhmIzkRR6EN8ACOVMVhBqQhvwfeIg/CQXU5nTVvPtWnn62+RxU8uOAvkNoFv9sV6iggpbMfQifQGnvATAZ+1fo/6P+AdtJ2U96CgiLcbzPQJ0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W62X2px_1715150243;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W62X2px_1715150243)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 14:37:24 +0800
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
Subject: [PATCH net-next v4 4/4] virtio_net: remove the misleading comment
Date: Wed,  8 May 2024 14:37:18 +0800
Message-Id: <20240508063718.69806-5-xuanzhuo@linux.alibaba.com>
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

We call the build_skb() actually without copying data.
The comment is misleading. So remove it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 070a6ed0d812..7c2b2b02338b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -739,7 +739,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
 	shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	/* copy small packet so we can reuse these pages */
 	if (!NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >= shinfo_size) {
 		skb = virtnet_build_skb(buf, truesize, p - buf, len);
 		if (unlikely(!skb))
-- 
2.32.0.3.g01195cf9f

