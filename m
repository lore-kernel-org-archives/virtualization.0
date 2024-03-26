Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CBD12881C
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434350; cv=none; b=tNsGvXRkqYvmow6VhOJeGlMgcDNS8qNza4LmLgVdeIs+j4Mu+HI4l1IvaJZe9ZFHPUpQIxsxn4a+U1gqBLz7OcFCiqHwhQ6J3MmJIfqhiexFNfO14CdlA5mhAfMrsI6KPZ6ky8qmcuzLLjjF9a801YOz2LKKNXBvIuKwYf3n4AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434350; c=relaxed/simple;
	bh=JVRlUGrgX9JPGKwuRYAxSFPzGRJh0ssLcpC/ohe5i+o=;
	h=From:To:Cc:Subject:Date:Message-Id; b=s0u6EdwGuPVkLn/4cTbTDyvooshzfue3hAUp8gLU40XLrQ+GzbS/5Gf5yOKF8LYBBG6Yw0WdXfFoGIYPmc6Ra3B16EAj8yzkY+nJcJ3+DbNdQpCeCV/Ajdonmyl1oPwQKHZ/jY5llZCsdnhQuNMq4fXBLf8pfOmp6VTAiJe7RkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RvsfLJUK; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RvsfLJUK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711434339; h=From:To:Subject:Date:Message-Id;
	bh=VrIgm9u1Afb8K7YWBLMtJPyOCbI419F7AlIXEULMlY8=;
	b=RvsfLJUKNSttrwKcxXkTRee7r3oaegUZh4dikmJfGXThBAenO5qTv25Kq6tCX2H5mr4OOVbNufKrXv8SuYpPZBHIiTTfXWcbA8pZSZJ+dFbbNebJ+4KXR53wzVmaWfUjX85BDjwx3jRbAcce0DHOKsG+gPrLt2M60xyCpZ3yF4k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3K3fs7_1711434338;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3K3fs7_1711434338)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 14:25:39 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net v2] virtio-net: fix possible dim status unrecoverable
Date: Tue, 26 Mar 2024 14:25:38 +0800
Message-Id: <1711434338-64848-1-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

When the dim worker is scheduled, if it fails to acquire the lock,
dim may not be able to return to the working state later.

For example, the following single queue scenario:
  1. The dim worker of rxq0 is scheduled, and the dim status is
     changed to DIM_APPLY_NEW_PROFILE;
  2. The ethtool command is holding rtnl lock;
  3. Since the rtnl lock is already held, virtnet_rx_dim_work fails
     to acquire the lock and exits;

Then, even if net_dim is invoked again, it cannot work because the
state is not restored to DIM_START_MEASURE.

Patch has been tested on a VM with 16 NICs, 128 queues per NIC
(2kq total):
With dim enabled on all queues, there are many opportunities for
contention for RTNL lock, and this patch introduces no visible hotspots.
The dim performance is also stable.

Fixes: 6208799553a8 ("virtio-net: support rx netdim")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
v1->v2:
  - Update commit log. No functional changes.

 drivers/net/virtio_net.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d111..0ebe322 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3563,8 +3563,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	struct dim_cq_moder update_moder;
 	int i, qnum, err;
 
-	if (!rtnl_trylock())
+	if (!rtnl_trylock()) {
+		schedule_work(&dim->work);
 		return;
+	}
 
 	/* Each rxq's work is queued by "net_dim()->schedule_work()"
 	 * in response to NAPI traffic changes. Note that dim->profile_ix
-- 
1.8.3.1

