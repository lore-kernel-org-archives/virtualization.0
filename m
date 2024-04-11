Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EE013B29F
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 02:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803896; cv=none; b=LYIK/fdYmRg7q+L03xf1b6f9c/R6nYK2cnAKcYtZi13fNifoGMdso3utO9nuso7zZ00MIXSV2ziFf+rVtFlcYEI/nJRaoZjqxC92ZqhPcRrtN0hg61BoJ6/SQAVEIN926Pow6bEiZyb3VRswtYQEcR735nq0PZSrdKqVvbB2xd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803896; c=relaxed/simple;
	bh=miCPScfh21j9uz1QvaLJKnsl7ydBn0J4ay5WPoqV3+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFzM00yrZISQcUUsg3Vld2QuXqNwmOOI4Z/GYs/1u9x5fOC8+/0STRBGHnrvV96haOr4VLZ4fwk9H/ZhDXQ9m1gSFyRLiE2H5mx44BDdo3HsqyIQu8oujgukQ/4Gvqt8oVRD2AiujdHBwrfZO1L5JSb6Mp8KVug513+dZr732jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CUMu70KI; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CUMu70KI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712803892; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Mc+qwhMMQZxW7Pe4sx6I9JfFRSK5ghrWVN+yqd/F7H4=;
	b=CUMu70KIfIYjafET2eQqrA/7K3PTNNPD6UzqbnF6K2yLzSi0VI6AEIcrfRZ/mF/fF/bh1YYmZCV/aiSeq75NGrZv/jye5Sj3MPWG9XxVIB6fwyzX7zBl03T0UR1WPYwwPntls7ERYP/xGVEiTZZzu9YW86T0w8aEC5L70oHR1eo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4JPoA8_1712803891;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4JPoA8_1712803891)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 10:51:32 +0800
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
Subject: [PATCH vhost 5/6] virtio_net: enable premapped by default
Date: Thu, 11 Apr 2024 10:51:26 +0800
Message-Id: <20240411025127.51945-6-xuanzhuo@linux.alibaba.com>
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

Currently, big, merge, and small modes all support the premapped mode.
We can now enable premapped mode by default. Furthermore,
virtqueue_set_dma_premapped() must succeed when called immediately after
find_vqs(). Consequently, we can assume that premapped mode is always
enabled.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7ea7e9bcd5d7..f0faf7c0fe59 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -860,15 +860,13 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 
 static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 {
-	int i;
-
-	/* disable for big mode */
-	if (!vi->mergeable_rx_bufs && vi->big_packets)
-		return;
+	int i, err;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
-			continue;
+		err = virtqueue_set_dma_premapped(vi->rq[i].vq);
+
+		/* never happen */
+		BUG_ON(err);
 
 		vi->rq[i].do_dma = true;
 	}
-- 
2.32.0.3.g01195cf9f

