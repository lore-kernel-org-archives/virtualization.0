Received: from out30-85.freemail.mail.aliyun.com (out30-85.freemail.mail.aliyun.com [115.124.30.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B79832E68F
	for <virtualization@lists.linux.dev>; Fri,  6 Mar 2026 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763898; cv=none; b=lunBjwNO1ILWPmsjrgMc7EihXdV38u/uVFs5MKNfS/HdTt5yU1t3yzX0rR7bXYgkkv6jrBJ16jZXBPMa1INtb816N4cYYXIewdS2D9uFjd+GGNhJ50JkODDY6ffZgSbveXTPdBAkJnB+haZ5TaCRafCydajusiU4umnLVQmcczo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763898; c=relaxed/simple;
	bh=pNRDtgleKcw+UtWajJqjN55JZKTysDSBC3+6j5JAobw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmTHHoAL7Xnf2fVtLgHqIpeRRHdvDhjsk4slWYFALv+6J8I2Do7W7E1flGJbIgPo14lZG3SzPGKsUh8JimbG9SVH45qpcEObxm3Mg2F7+vzPqs+bGKQoHpzrPqfwdHhFO5tXNO+2gp+yuqUr7yWrN7Rmu3rdi8LfIBkjTomkRgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=Kd5tK3Cg; arc=none smtp.client-ip=115.124.30.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="Kd5tK3Cg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1772763895; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=uKETZvpPzQ2piKVIuIchcLQYmMkl2Hf/rKze2mfXRfg=;
	b=Kd5tK3CgFxbDKzOune5dn6Fl/IYMJd4vTW3XhDzbdojols0HMRiAbNLqC+nqjXQyqGFcDtCiD1kjESQnqA2eSA/z1yXGpggTfZbec8HD2FfT13xx3JALMjn5uxBCxjtK69KnAfRpxwccqWFDovCSJNLWcXdxy1RYJ1lVFqicEi8=
Received: from localhost.localdomain(mailfrom:wdhh6@aliyun.com fp:SMTPD_---0X-Lau.N_1772763890 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Mar 2026 10:24:54 +0800
From: Chaohai Chen <wdhh6@aliyun.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	Chaohai Chen <wdhh6@aliyun.com>
Subject: [PATCH v2] virtio_ring: Fix data races in virtqueue_enable_cb_delayed_split()
Date: Fri,  6 Mar 2026 10:24:48 +0800
Message-ID: <20260306022448.216131-1-wdhh6@aliyun.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add READ_ONCE when fetching vq->split.vring.used->idx
without synchronization.

KCSAN detected data races when accessing the split virtqueue's
used ring, which is shared memory concurrently accessed by both the CPU
and the virtio device (hypervisor).

Example KCSAN report:

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
2.43.7

