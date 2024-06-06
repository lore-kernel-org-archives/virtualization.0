Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CC41870
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717672431; cv=none; b=RsoNns976ZRpvsz+O/fwugTVKl1TSpOz+1oXNAYf7h8gii/j5iCKkcB78FG60ezPJ7e+garwbQgNj4l/NTm74cXacT57i+9wld8qVUeEyxKgA8lisgIVWXKGRgjvN6oLv6NTRzfiGlY8eh2b5l6k/ll8lPQ5r0vOOQje+6o8JZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717672431; c=relaxed/simple;
	bh=Wi9tJ6XUiDG2zIhgrwj+eY0OzJgL+HO2VtjeZAgHr7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aUvMJXj/bRq9yuzQYhkI+FPN3RwkyWom0iqQP4D9sR+a7TWN9K/MO3zOX7iIbtKlxioAkoQyAfbNlFN/YAOva6O33gAVVz/TtSJzJsHoOMzk47Cm5cTx9xypd6auaGqz8/6R+H/wWn93d82AsCrTk8n28ishd+NvRXL9TbOs+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m0GprcW+; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m0GprcW+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717672426; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CUSScYNSoqguUJd4oHSKGJp6xNjllqDi+0y/CYQpdJI=;
	b=m0GprcW+sTpP+Trt+2sdwfQyw5YNypo11X9dyC0UbyXFt2KkXasG8QVU36CYD9KnTQj8odJQkGEJhq1vcRHl5Ai18LvQ0I2NcNX1IM0+qQvlmZuwvn/Hkw6PRs/7ei2HIIwrZKQEjarZXLjsjJyhUmwMZLuNo3xRzFsWbI8eka4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7xz1P0_1717672425;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7xz1P0_1717672425)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 19:13:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] virtio_ring: fix KMSAN error for premapped mode
Date: Thu,  6 Jun 2024 19:13:45 +0800
Message-Id: <20240606111345.93600-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 5f5ee3f8833c
Content-Transfer-Encoding: 8bit

Add kmsan for virtqueue_dma_map_single_attrs to fix:

BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
 receive_buf+0x45ca/0x6990
 virtnet_poll+0x17e0/0x3130
 net_rx_action+0x832/0x26e0
 handle_softirqs+0x330/0x10f0
 [...]

Uninit was created at:
 __alloc_pages_noprof+0x62a/0xe60
 alloc_pages_noprof+0x392/0x830
 skb_page_frag_refill+0x21a/0x5c0
 virtnet_rq_alloc+0x50/0x1500
 try_fill_recv+0x372/0x54c0
 virtnet_open+0x210/0xbe0
 __dev_open+0x56e/0x920
 __dev_change_flags+0x39c/0x2000
 dev_change_flags+0xaa/0x200
 do_setlink+0x197a/0x7420
 rtnl_setlink+0x77c/0x860
 [...]

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Tested-by: Alexander Potapenko <glider@google.com>
---
 drivers/virtio/virtio_ring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6f7e5010a673..80669e05bf0e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3126,8 +3126,10 @@ dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (!vq->use_dma_api)
+	if (!vq->use_dma_api) {
+		kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), size, dir);
 		return (dma_addr_t)virt_to_phys(ptr);
+	}
 
 	return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, attrs);
 }
-- 
2.32.0.3.g01195cf9f

