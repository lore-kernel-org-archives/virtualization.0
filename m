Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDAA16A95B
	for <virtualization@lists.linux.dev>; Fri,  6 Sep 2024 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625912; cv=none; b=N6T7eALV3QhxrvWC9SpXEqp8iOh++Qp7HhWRPi9PZpZ+5A/iVAeRNGL9OO9HkwiD3YTFdiMGbgR2rQqmoOA+gphsKrpz4c8vMNT9Uunf00Q/++V2WD2uNKKEpf3cu+cEQBWZK9WyjIouxjz4bYKcisllb+eed1e/0h1SQyqYfo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625912; c=relaxed/simple;
	bh=Kj6/X2k07j/CehXA3VPPfTqgdj/I7tMUUeCkDOp1W9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kfLWrHvKU+zWyB1Mit6hFKnwzr3H+9SXCgiuTXoQrBxLIngiWQY+H9I+VFUvjor6lO4mpNCL2wFANVxa8P7+LbB2HrG0uk9LRLBeMdJZwvHLYifjICdCwiT0oY5nn2SUiXiXSOzqjQuEqdN2WX355+7sAcXJmbpmuwdipt+mlt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=N9c8k54d; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="N9c8k54d"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725625902; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kIcQ2WeFtXg+QL/4Adk4HAJSR6V3+Bpy2cVvh76r2uQ=;
	b=N9c8k54dgYIo7EKfsmDxWWQQm22jupCsLaJ08cOw5/UzML+A0BbnDZlGZ48OcDkMXdTx1eHGWxnTHO+J6f6JlDngyLuTL1t6ePqF5RWBmp0z2nDPLWOXh2C9YNDu6rf3rtewlKcDDmNXy0CX1SQpZ9M/AsfY67gv15808SnXQnI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEPamQ5_1725625901)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 20:31:41 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Darren Kenny <darren.kenny@oracle.com>,
	"Si-Wei Liu" <si-wei.liu@oracle.com>
Subject: [PATCH 3/3] virtio_net: disable premapped mode by default
Date: Fri,  6 Sep 2024 20:31:37 +0800
Message-Id: <20240906123137.108741-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
References: <20240906123137.108741-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: ccfd5e625b8b
Content-Transfer-Encoding: 8bit

Now, the premapped mode encounters some problem.

    http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com

So we disable the premapped mode by default.
We can re-enable it in the future.

Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b68e64e8c7b6..284db2912808 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -979,22 +979,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
 	return buf;
 }
 
-static void virtnet_rq_set_premapped(struct virtnet_info *vi)
-{
-	int i;
-
-	/* disable for big mode */
-	if (!vi->mergeable_rx_bufs && vi->big_packets)
-		return;
-
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
-			continue;
-
-		vi->rq[i].do_dma = true;
-	}
-}
-
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
@@ -6126,8 +6110,6 @@ static int init_vqs(struct virtnet_info *vi)
 	if (ret)
 		goto err_free;
 
-	virtnet_rq_set_premapped(vi);
-
 	cpus_read_lock();
 	virtnet_set_affinity(vi);
 	cpus_read_unlock();
-- 
2.32.0.3.g01195cf9f

