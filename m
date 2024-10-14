Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8C82D91
	for <virtualization@lists.linux.dev>; Mon, 14 Oct 2024 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875568; cv=none; b=DqRdbZqdqwPoFYNvT78+P4qyHHOMqgeWbIoK3lBu1rHeLy7S/BlDKAvajw4LBovv9zRXZQB4KHz2Pwge9nyBRcurjH+golxV/0+HBuJ3i1+PqBRibf6XedbelbCsGb5tBLjT20c67u5SoEfYXb5sPVH9mbW+5sUyaYPX3MtcBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875568; c=relaxed/simple;
	bh=CWFFvB/woliuCJsHHhnfJ92el+XRFSCnpT7eu7ZtNC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s++cvsWQMsZpNoq4drJmrveYcU4g8iYciapajwXr6ddO9ISbQJprDARASiFAEWlEwiW+pO6C/nwPtPyf7AzC63qFNHat0hxXupdOJElljE8l7mv07PU1uIQrESQJ3+T2jaoZsWff77PxezIHgkwM4zciq/5QVjfRXxFN2blbPPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UpRKPN2f; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UpRKPN2f"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728875559; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2P7txvf1UTqbJ8Av/SHvqm6/S8okRtKCBqJpJo1/+wg=;
	b=UpRKPN2f37bLd2CJbXw69XOwq30byflgOHaE9Vrl9ffy2akIq6JYFNdni1dpXJNufvhxSy0sBTG4sHF3XSwoGKzeF/TuEBtI6LJLBezz90pC/B/24gtl6QH6CuDgc25z7bXyAOb85H9X0odN0GQv+GHeO9TZRk/mHLH6+px3NtU=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WH.FFnD_1728875558 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 11:12:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 4/5] virtio_net: enable premapped mode for merge and small by default
Date: Mon, 14 Oct 2024 11:12:33 +0800
Message-Id: <20241014031234.7659-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: bba499faae26
Content-Transfer-Encoding: 8bit

Currently, the virtio core will perform a dma operation for each
buffer. Although, the same page may be operated multiple times.

In premapped mod, we can perform only one dma operation for the pages of
the alloc frag. This is beneficial for the iommu device.

kernel command line: intel_iommu=on iommu.passthrough=0

       |  strict=0  | strict=1
Before |  775496pps | 428614pps
After  | 1109316pps | 742853pps

In the 6.11, we disabled this feature because a regress [1].

Now, we fix the problem and re-enable it.

[1]: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cd90e77881df..8cf24b7b58bd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6133,6 +6133,21 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	return -ENOMEM;
 }
 
+static void virtnet_rq_set_premapped(struct virtnet_info *vi)
+{
+	int i;
+
+	/* disable for big mode */
+	if (vi->mode == VIRTNET_MODE_BIG)
+		return;
+
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		/* error should never happen */
+		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
+		vi->rq[i].do_dma = true;
+	}
+}
+
 static int init_vqs(struct virtnet_info *vi)
 {
 	int ret;
@@ -6146,6 +6161,8 @@ static int init_vqs(struct virtnet_info *vi)
 	if (ret)
 		goto err_free;
 
+	virtnet_rq_set_premapped(vi);
+
 	cpus_read_lock();
 	virtnet_set_affinity(vi);
 	cpus_read_unlock();
-- 
2.32.0.3.g01195cf9f

