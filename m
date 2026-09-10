Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 076F5488213
	for <virtualization@lists.linux.dev>; Thu, 10 Sep 2026 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043981; cv=none; b=NAiU0W2kmIbbTmaq89Amv9FmtFxJaHqmbVVTiw+QqOU/MP/sSobJdg7XfIupIyJb/C5TK9pmMBYNQQoPZq8D/yY7Vf3YjthyEkYnNp8cv9KO2ZosS0d8KAWoIasjqTUR+3q5LiA9X89fqfV1JMVrhiqKc/+xNPP8hBqxs3ICbLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043981; c=relaxed/simple;
	bh=uERe+rPSAVEC5mjAWQyTfYZx4/ngjwuFX0r3iLJVm94=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LSzPI4k6WhHB8yLFyY5uY/uSX9vu0LmInWv5PhULFrpkkjGoUqOhpJO36tYdzSHyoY5rB7jwGfmycer22zN2V8QzZHYRSuH1uo9/FM3QFaKaYfCR3QTMl29+vQAkMMW8WxML9vJMRInw6u4cOizIndFC79/TCXojR9OCgDDhB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=ZGx34cDC; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="ZGx34cDC"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virtio_ring: reset IN_ORDER state in virtqueue_init()
Date: Thu, 10 Sep 2026 20:39:03 +0800
Message-ID: <20260910123903.1717-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc11.internal.baidu.com (172.31.3.21) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1789043967;
	bh=0SgNbr7d64dMOkmaYrpy9GpJle7Mxk78HhOW0m89bLk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=ZGx34cDCOld2IeOQ0O9pe8gMJ48Y46SXIQQvCAhSLcXJn1WbwqDdhEzvH71KPF7EN
	 /av3xS+0h0fyVL3EmKPQfeg1yAq1NdugLem17tK2qFjsrtM8GFE4Lnvo5VpvRJkbVl
	 ErilfH2UUl92wgxs8P+5PRxYEExm8yCDTmLqNzZQguBBZ50Cj3TX7bwTQltlatlTDA
	 HUp4tAabelcYogU/meWkadwt/KZDsPDikuSCuaVmVZz5TWQkuTAOu14Y61he5YCyBg
	 i7s1QvX/fIoZ5powMsr4J76kf98NhnopW+I8YHs6FwORhQ4Z+qhA+Ve9JenT7+U59r
	 CaHPo6JzOFOtg==

From: Li RongQing <lirongqing@baidu.com>

The IN_ORDER feature uses additional software state to track the next
available descriptor and in-flight descriptor batches.

virtqueue_init() resets the common virtqueue state, but free_head and
batch_last.id are initialized only when the virtqueue is created. When
an IN_ORDER virtqueue is reset, these fields can retain state from the
previous queue instance.

Reset free_head and invalidate batch_last when initializing an IN_ORDER
virtqueue. Keep this in virtqueue_init() so the state is initialized
consistently for both newly created and reset virtqueues.

Fixes: f6a15d854986 ("virtio_ring: add in order support")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/virtio/virtio_ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index db678f5..d0dc464 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -559,6 +559,11 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
 	vq->in_use = false;
 	vq->last_add_time_valid = false;
 #endif
+
+	if (virtqueue_is_in_order(vq)) {
+		vq->free_head = 0;
+		vq->batch_last.id = UINT_MAX;
+	}
 }
 
 
-- 
2.9.4

