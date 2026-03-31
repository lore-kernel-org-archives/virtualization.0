Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B573E0C68
	for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952808; cv=none; b=Ea45QY4n/KjKCOGJznuxlx5i6ga6V7kfEmjj8mhf4pnbccxFcb/UBkN32MxN2ZEmh6g9LQ23MaQX6nVYAIiPh0DzHHXtj6Ee1hIPhKKbzKP7HeT1r+rbO2vbbDrRKwdlmaOpb5Qy7jMrFF8QEpy4CJnNDAI0Ms80zQgdg7IedME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952808; c=relaxed/simple;
	bh=/pmwRfXJgnSw+qbipCEn+hz6Fh4O/PsQtt5gDa1AAnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hlh8n1JhxoePfq6aWzWew+L3s2qzmiVHTsENtQakUSfYTB1Vzgqc1o3c/Qub0TI9tgpGUufgG277dm18XcHqDHX/1es/xq0O+heUv509gbUr4eLkAm9AWp58o29ekgmbEFSFgAMEv7clBN+q8seEVQin8p06NGjCmSxR3ZRpTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hTYItM+8; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hTYItM+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Uv
	yNgFhD9wYt0BzkFaAHX+L9OTAlWFIY2rxDGjtNMKw=; b=hTYItM+8tsVvluX8JF
	+2T0IjT1Zqh1Jp/i0EMjQxWMhlWDw3jZpspk8Gjx+DRAMkukGH+ziuTSlrX7cBue
	TmGa92/cOdSrgE8EFZ5DLr/LGdtmZIfx3Qeg/qLh04b5RyyOR5+qFe/s6UTWCS4I
	HYc8MiLSk5NAKV7AaaWINbHKI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDHqoNToctphXY9CQ--.9353S4;
	Tue, 31 Mar 2026 18:26:29 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	edumazet@google.com
Cc: lange_tang@163.com,
	tanglongjun@kylinos.cn,
	virtualization@lists.linux.dev
Subject: [PATCH 2/2] virtio_ring: return IRQ_HANDLED for stale interrupts when cb disabled
Date: Tue, 31 Mar 2026 18:26:26 +0800
Message-Id: <20260331102626.108962-3-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260331102626.108962-1-lange_tang@163.com>
References: <20260331102626.108962-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHqoNToctphXY9CQ--.9353S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWryftF1kJr4xCrW3Gr17KFg_yoWrAFyrpF
	4DGrWYy348WF4S9FW5XF4qqw1a9393Jry7Wryxu3ZxCF1YqF1vqF18K34rXFyrGryDC347
	AF4qqrZ8C34UurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR8pnPUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4RXK+GnLoVWcJQAA3p

From: Longjun Tang <tanglongjun@kylinos.cn>

In the vring_interrupt, if the used ring is empty, IRQ_NONE is returned.
However,Sometimes, such as with busy-polling, buffers might be consumed
from the used ring before an stale interrupt notification arrives. it
leading to return IRQ_NONE.

The kernel's spurious-IRQ detector counts consecutive IRQ_NONE returns
and will permanently disable the interrupt line if 99,900 out of 100,000
interrupts go unhandled.

Add is_cb_disabled() to virtqueue_ops and, when more_used() is false but
cb are suppressed, return IRQ_HANDLED instead of IRQ_NONE so the spurious
counter does not accumulate.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 drivers/virtio/virtio_ring.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 335692d41617..52df932fc4a2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -185,6 +185,7 @@ struct virtqueue_ops {
 		     unsigned int last_used_idx);
 	void *(*detach_unused_buf)(struct vring_virtqueue *vq);
 	bool (*more_used)(const struct vring_virtqueue *vq);
+	bool (*is_cb_disabled)(const struct vring_virtqueue *vq);
 	int (*resize)(struct vring_virtqueue *vq, u32 num);
 	void (*reset)(struct vring_virtqueue *vq);
 };
@@ -1063,6 +1064,12 @@ static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
 	}
 }
 
+static bool is_cb_disabled_split(const struct vring_virtqueue *vq)
+{
+	return !!(data_race(vq->split.avail_flags_shadow) &
+		  VRING_AVAIL_F_NO_INTERRUPT);
+}
+
 static unsigned int virtqueue_enable_cb_prepare_split(struct vring_virtqueue *vq)
 {
 	u16 last_used_idx;
@@ -2227,6 +2234,12 @@ static void virtqueue_disable_cb_packed(struct vring_virtqueue *vq)
 	}
 }
 
+static bool is_cb_disabled_packed(const struct vring_virtqueue *vq)
+{
+	return data_race(vq->packed.event_flags_shadow) ==
+	       VRING_PACKED_EVENT_FLAG_DISABLE;
+}
+
 static unsigned int virtqueue_enable_cb_prepare_packed(struct vring_virtqueue *vq)
 {
 	START_USE(vq);
@@ -2644,6 +2657,7 @@ static const struct virtqueue_ops split_ops = {
 	.poll = virtqueue_poll_split,
 	.detach_unused_buf = virtqueue_detach_unused_buf_split,
 	.more_used = more_used_split,
+	.is_cb_disabled = is_cb_disabled_split,
 	.resize = virtqueue_resize_split,
 	.reset = virtqueue_reset_split,
 };
@@ -2658,6 +2672,7 @@ static const struct virtqueue_ops packed_ops = {
 	.poll = virtqueue_poll_packed,
 	.detach_unused_buf = virtqueue_detach_unused_buf_packed,
 	.more_used = more_used_packed,
+	.is_cb_disabled = is_cb_disabled_packed,
 	.resize = virtqueue_resize_packed,
 	.reset = virtqueue_reset_packed,
 };
@@ -2672,6 +2687,7 @@ static const struct virtqueue_ops split_in_order_ops = {
 	.poll = virtqueue_poll_split,
 	.detach_unused_buf = virtqueue_detach_unused_buf_split,
 	.more_used = more_used_split_in_order,
+	.is_cb_disabled = is_cb_disabled_split,
 	.resize = virtqueue_resize_split,
 	.reset = virtqueue_reset_split,
 };
@@ -2686,6 +2702,7 @@ static const struct virtqueue_ops packed_in_order_ops = {
 	.poll = virtqueue_poll_packed,
 	.detach_unused_buf = virtqueue_detach_unused_buf_packed,
 	.more_used = more_used_packed_in_order,
+	.is_cb_disabled = is_cb_disabled_packed,
 	.resize = virtqueue_resize_packed,
 	.reset = virtqueue_reset_packed,
 };
@@ -3231,6 +3248,18 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (!more_used(vq)) {
+		/*
+		 * Stale interrupt: the device posted this notification
+		 * before it observed the callback suppression;
+		 * When more_used returns empty, IRQ_HANDLED should be
+		 * returned for stale interrupts.
+		 */
+		if (VIRTQUEUE_CALL(vq, is_cb_disabled)) {
+			if (vq->event)
+				data_race(vq->event_triggered = true);
+			pr_debug("virtqueue stale interrupt (callbacks disabled) for %p\n", vq);
+			return IRQ_HANDLED;
+		}
 		pr_debug("virtqueue interrupt with no work for %p\n", vq);
 		return IRQ_NONE;
 	}
-- 
2.43.0

