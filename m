Received: from out30-82.freemail.mail.aliyun.com (out30-82.freemail.mail.aliyun.com [115.124.30.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6803A3E277A
	for <virtualization@lists.linux.dev>; Wed, 11 Mar 2026 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248726; cv=none; b=TMEww4NE0igCLLA1Ta5VBZ84gvtZkgXdiaz2+2v0+SP/cp3ZsZgUo3cdUpLMHJXhGczNm8h2Oh30tJVtswnwVTNscUleWGx8CAO6o14kb1tVDkyqNztggKQSpWvEkAH8jiHOZ6RcImU0+rUMnkMBxXuQnZ2xxuDBc4H7P+V67Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248726; c=relaxed/simple;
	bh=UHfPGlXOkIhZWFADnlgDabVhJDp6lbGQJiFVdlDuLv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETn/UXmfghaDqGxxX6s7VY8FgJPP+xT8vgaC/myiD71tib4kObY4dxbM+q84TU9e+89Votf6iTqGziUjG6z5sfk6BBCFWVSSDwZ0YmrVbtECNQ8UpHjIWs7C0vBbAIaWrTo1JWqwBep8jHRb7j2jHH7W2A0T9II6yzJ+dygy4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=dqprPInU; arc=none smtp.client-ip=115.124.30.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="dqprPInU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1773248721; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RX2KjuqG9/5Rq4fV6jDCN9d+9wFl//SxRwTZyUcJRfo=;
	b=dqprPInUK1vAJl1IqIa1W4P3HfIemY+mh5ydlGB8qYwKA0JW+1rw3MuWX98ognzVjxEUEnP+9jHaicYjkfzo6X0yqJvBkzWmHgc1fy2FiCT+G89Yr0sylqnaVwD9vCiG5hwARfEwZ7yvTnNDkspbUCoNGFgmsS3rXzrn6huUN8A=
Received: from VM-32-11-ubuntu..(mailfrom:wdhh6@aliyun.com fp:SMTPD_---0X-kyQl7_1773248716 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Mar 2026 01:05:21 +0800
From: Chaohai Chen <wdhh6@aliyun.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chaohai Chen <wdhh6@aliyun.com>
Subject: [PATCH v3] virtio_ring: Fix KCSAN warnings in virtqueue_enable_cb_delayed_split()
Date: Thu, 12 Mar 2026 01:05:10 +0800
Message-ID: <20260311170510.288840-1-wdhh6@aliyun.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCSAN warns as follow:

[  109.277250] ==================================================================
[  109.283600] BUG: KCSAN: data-race in virtqueue_enable_cb_delayed_split+0x10f/0x170

[  109.295263] race at unknown origin, with read to 0xffff8b2a92ef2042 of 2 bytes by interrupt on cpu 1:
[  109.306934]  virtqueue_enable_cb_delayed_split+0x10f/0x170
[  109.312880]  virtqueue_enable_cb_delayed+0x3b/0x70
[  109.318852]  start_xmit+0x315/0x860 [virtio_net]
[  109.324532]  dev_hard_start_xmit+0x85/0x380
[  109.329993]  sch_direct_xmit+0xd3/0x680
[  109.335360]  __dev_xmit_skb+0x4ee/0xcc0
[  109.340568]  __dev_queue_xmit+0x560/0xe00
[  109.345701]  ip_finish_output2+0x49a/0x9b0
[  109.350743]  __ip_finish_output+0x131/0x250
[  109.355789]  ip_finish_output+0x28/0x180
[  109.360712]  ip_output+0xa0/0x1c0
[  109.365479]  __ip_queue_xmit+0x68d/0x9e0
[  109.370156]  ip_queue_xmit+0x33/0x40
[  109.374783]  __tcp_transmit_skb+0x1703/0x1970
[  109.379467]  __tcp_send_ack.part.0+0x1bb/0x320
...
[  109.499585]  do_idle+0x7a/0xe0
[  109.502979]  cpu_startup_entry+0x25/0x30
[  109.506481]  start_secondary+0x116/0x150
[  109.509930]  common_startup_64+0x13e/0x141

[  109.516626] value changed: 0x0029 -> 0x002a
================================================================================

Add READ_ONCE() to fix the warning.

Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>
---
 drivers/virtio/virtio_ring.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 335692d41617..ceb026161639 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1112,8 +1112,9 @@ static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
 			&vring_used_event(&vq->split.vring),
 			cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + bufs));
 
-	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->idx)
-					- vq->last_used_idx) > bufs)) {
+	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev,
+				READ_ONCE(vq->split.vring.used->idx))
+				- vq->last_used_idx) > bufs)) {
 		END_USE(vq);
 		return false;
 	}
-- 
2.43.0

