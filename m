Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027408;
	b=jVU9cSY1WoXa7MqgQwlHDkY7bHaXKG5uEJqs9C3GYWdWzQ0SjzNF4lzdUhJzUAluOeLq
	 41kBMnpYf8rlmLVmGIdDCFFmHGiDOfoMGCVhSJkFRNeLti8byhLGOD5ZoXqrIkdJa0KxB
	 +q4UMHGSOZTbeZ6lQ/x/8ipifYPm33xspV9q30H3JcCVxup8n5+h4KdV9M7OJSFaNOKTE
	 RGAeamEyoRCxX7tbeCZWasSZztVD/e2GAWxogun8paRothcMMsvmUJcCAAAFlZEIGT9s4
	 hk3C6T/NpKpCH7TfVsS0apCFNLT+gXCnyanK8PBuGJhnSmtuLOfGdZ4PUoVt9y2AWBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027408;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=HzMeo7/jJ0swTyFLCpz+u7iHeHxr5VYkay9cet6ED5o=;
	b=nD6SiQ62bTzKXSMrFkunP5SsHkzmRRgEcltIM5eNT09JZ56LO3h+XL97N5vtBl0SfsZc
	 akl6Rkd4HmR5cYYlSsBcyjwM7OV/a5+nHdj5+u99a4t8TpPl/T4K/5z+iO84E+Ewjih2l
	 zBHUnu/g+NxS42eaysBXDd9FxU1zAFPpjIQlOCQMfSIRAk4fFGps/Ey8PFDRx2dpnzeZV
	 FZXVOFTtV6YQFFjQEjLxdKfDR1lgXCYBA7dvF+oJRpkBxN3IUnaQFGbky8hdkLGouBfgU
	 rz7bvNUQQqrF42BQsmoDsw24Pu+7/+K9qEtJAzRwvuXXG0PFp4DQkC2ynepOgqQBjGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KJNmFiuQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D4606A324
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 15:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A2D4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KJNmFiuQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793027407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=HzMeo7/jJ0swTyFLCpz+u7iHeHxr5VYkay9cet6ED5o=;
	b=KJNmFiuQC7gsgReiBYBK8YrZilXj0nlQSRawQrojHkww0p1IbP5jKIiroEUeTJxhBxSVlG
	BJ4TohdoPR2s66OE+L2m5oFp1a1TAMPqaTtjrcK+BJ1G9kGSvsbzV6YCwKlbH24K1c8S7P
	p5O3OTHfEa/IgvKZis1WJoHH2WUNH9A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-qJukp4jYNMq2wahoj1Qa1Q-1; Mon, 26 Oct 2026 11:09:58 -0400
X-MC-Unique: qJukp4jYNMq2wahoj1Qa1Q-1
X-Mimecast-MFC-AGG-ID: qJukp4jYNMq2wahoj1Qa1Q_1793027397
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0af48c18so2788033f8f.2
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 08:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027397; x=1793632197;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HzMeo7/jJ0swTyFLCpz+u7iHeHxr5VYkay9cet6ED5o=;
        b=l+TSFIUd9bNzqqB3o5J7sK81xt0fVylp+/8m0jCLFYEKmLGJcIdRP6xFHnz59LH2H+
         ZDKpgXo+6nf2kAaaEjsFEBN69gh7CojuhGRr/0GJuoSl3yC13xHbVJ8vJEQqrnwJdb2q
         Io/Dsavsuz5ZCB63mEAxDHe9jv3YtuoE+x0zG3azYcOQzpnC0eThcY3TEzvcjrxlVhuA
         vho3Pp3pvO8lNkaSTJ/7jZYCoQNYxIXDONojELMz+7XI6U/B2MpAfJI3jDDQ0hcZxVYK
         Ta44nV5pKFxJeINe6kKGHd2bwell+/5MjEqHMfMpsY9AUAhRr4GB8yQgfIM1SJQzjpYD
         JUIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLNOyBzi6iK7hTrKGaQw52k452qtqtBYAZzLUu2/fgDdGEbqMOCyrWzx2ekJakF4Lj6GmELAfyi3vjOb4RUw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK2ueNmMOsjYr5IsF0VaCmET6dOXaYqu+KofqVVxXlDq7dQxJbW
	qUdH/InLuqqRBZLOxp1bLE+WMjhCPVWIHKwmlb6bWTxu7UmQTnfb3LF9Kd8qg00J4HNRhL3HQ2U
	Z6IDH/flmg7DdoXGmUMT+187NcvCCNDCFINJ6SDfBLkcia1H8YZY2r31jLzwgX4+5MWqu
X-Gm-Gg: AYBFou2SJWCvkJMXAN0Vt/gI9y1lTgBKWjegqmgs9XAD9L5nwvC0jn3ThOZtG1TQyx3
	zPrnde8q7+PV6lZe9v8hMsFo/er7HsZD9tRWFtu6MmpDzzlSIPHHUDOHoQ/7ExAgXRJc8WX6e/Y
	fmJ56fpvQcVbRcIEzYkMZAbuWYTlEgMkQ916Q+KfIcrRwvXQc4ld83hFlp+CTxDesiY3u93AcrH
	K1O8LS+kdoxVF5qfMAVso46I8GFShCiuJh6OQa/nJjVGar2na4ZIfN4NZkuIAnljzYoMdRrgCha
	XrZpLlcg8HqlpR2m7rYCNeByEopQHIowjiFPgnESfAOvxjNog5nxv9ycwPl+zfW/VAQ=
X-Received: by 2002:a5d:4910:0:b0:48d:eb6b:9d12 with SMTP id ffacd0b85a97d-48e3eb786c9mr8555282f8f.16.1793027396380;
        Mon, 26 Oct 2026 08:09:56 -0700 (PDT)
X-Received: by 2002:a5d:4910:0:b0:48d:eb6b:9d12 with SMTP id ffacd0b85a97d-48e3eb786c9mr8555218f8f.16.1793027395723;
        Mon, 26 Oct 2026 08:09:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3bdbsm13923921f8f.19.2026.10.26.08.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:09:54 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:09:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 1/2] virtio_ring: add virtqueue_enable_cb_delayed_max
Message-ID: <ad6a530f49c4a0e182112a73789e31b5e91f3bb7.1793026707.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l5Rl5lD3cyr-1kbIy3Ck6b8dI9qP6qsVCXs05DSwHEg_1793027397
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

virtqueue_enable_cb_delayed places the used event at 3/4 of the
currently queued buffers, so with VIRTIO_RING_F_EVENT_IDX the device
interrupts early and often - this is a good fit for drivers that poll
and process buffers as they trickle in, like virtio net.

Some drivers queue a batch of buffers and then sleep waiting for the
whole batch to complete.  For these, an interrupt before the last
buffer is used is pure waste.

To fix, add virtqueue_enable_cb_delayed_max: same API, but the used
event is placed at the last currently queued buffer, so the device
only notifies us once it has used everything.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 125 +++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |   2 +
 2 files changed, 127 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fbca7ce1c6bf..0428c0ae9a8a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -180,6 +180,7 @@ struct virtqueue_ops {
 	bool (*kick_prepare)(struct vring_virtqueue *vq);
 	void (*disable_cb)(struct vring_virtqueue *vq);
 	bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
+	bool (*enable_cb_delayed_max)(struct vring_virtqueue *vq);
 	unsigned int (*enable_cb_prepare)(struct vring_virtqueue *vq);
 	bool (*poll)(const struct vring_virtqueue *vq,
 		     unsigned int last_used_idx);
@@ -1122,6 +1123,42 @@ static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
 	return true;
 }
 
+static bool virtqueue_enable_cb_delayed_max_split(struct vring_virtqueue *vq)
+{
+	u16 bufs;
+
+	START_USE(vq);
+
+	/* We optimistically turn back on interrupts, then check if there was
+	 * more to do. */
+	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
+	 * either clear the flags bit or point the event index at the next
+	 * entry. Always update the event index to keep code simple. */
+	if (vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
+		vq->split.avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
+		if (!vq->event)
+			vq->split.vring.avail->flags =
+				cpu_to_virtio16(vq->vq.vdev,
+						vq->split.avail_flags_shadow);
+	}
+	/* Point the used event at the last queued buffer: the device
+	 * will only notify us once it has used everything. */
+	bufs = (u16)(vq->split.avail_idx_shadow - vq->last_used_idx);
+
+	virtio_store_mb(vq->weak_barriers,
+			&vring_used_event(&vq->split.vring),
+			cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + bufs));
+
+	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->idx)
+						- vq->last_used_idx) > bufs)) {
+		END_USE(vq);
+		return false;
+	}
+
+	END_USE(vq);
+	return true;
+}
+
 static void *virtqueue_detach_unused_buf_split(struct vring_virtqueue *vq)
 {
 	unsigned int i;
@@ -2318,6 +2355,67 @@ static bool virtqueue_enable_cb_delayed_packed(struct vring_virtqueue *vq)
 	return true;
 }
 
+static bool virtqueue_enable_cb_delayed_max_packed(struct vring_virtqueue *vq)
+{
+	u16 used_idx, wrap_counter, last_used_idx;
+	u16 bufs;
+
+	START_USE(vq);
+
+	/*
+	 * We optimistically turn back on interrupts, then check if there was
+	 * more to do.
+	 */
+
+	if (vq->event) {
+		/* Point the event at the last queued buffer: the device
+		 * will only notify us once it has used everything. */
+		bufs = vq->packed.vring.num - vq->vq.num_free;
+		last_used_idx = READ_ONCE(vq->last_used_idx);
+		wrap_counter = packed_used_wrap_counter(last_used_idx);
+
+		used_idx = packed_last_used(last_used_idx) + bufs;
+		if (used_idx >= vq->packed.vring.num) {
+			used_idx -= vq->packed.vring.num;
+			wrap_counter ^= 1;
+		}
+
+		vq->packed.vring.driver->off_wrap = cpu_to_le16(used_idx |
+			(wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
+
+		/*
+		 * We need to update event offset and event wrap
+		 * counter first before updating event flags.
+		 */
+		virtio_wmb(vq->weak_barriers);
+	}
+
+	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DISABLE) {
+		vq->packed.event_flags_shadow = vq->event ?
+				VRING_PACKED_EVENT_FLAG_DESC :
+				VRING_PACKED_EVENT_FLAG_ENABLE;
+		vq->packed.vring.driver->flags =
+				cpu_to_le16(vq->packed.event_flags_shadow);
+	}
+
+	/*
+	 * We need to update event suppression structure first
+	 * before re-checking for more used buffers.
+	 */
+	virtio_mb(vq->weak_barriers);
+
+	last_used_idx = READ_ONCE(vq->last_used_idx);
+	wrap_counter = packed_used_wrap_counter(last_used_idx);
+	used_idx = packed_last_used(last_used_idx);
+	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
+		END_USE(vq);
+		return false;
+	}
+
+	END_USE(vq);
+	return true;
+}
+
 static void *virtqueue_detach_unused_buf_packed(struct vring_virtqueue *vq)
 {
 	unsigned int i;
@@ -2640,6 +2738,7 @@ static const struct virtqueue_ops split_ops = {
 	.kick_prepare = virtqueue_kick_prepare_split,
 	.disable_cb = virtqueue_disable_cb_split,
 	.enable_cb_delayed = virtqueue_enable_cb_delayed_split,
+	.enable_cb_delayed_max = virtqueue_enable_cb_delayed_max_split,
 	.enable_cb_prepare = virtqueue_enable_cb_prepare_split,
 	.poll = virtqueue_poll_split,
 	.detach_unused_buf = virtqueue_detach_unused_buf_split,
@@ -2654,6 +2753,7 @@ static const struct virtqueue_ops packed_ops = {
 	.kick_prepare = virtqueue_kick_prepare_packed,
 	.disable_cb = virtqueue_disable_cb_packed,
 	.enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
+	.enable_cb_delayed_max = virtqueue_enable_cb_delayed_max_packed,
 	.enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
 	.poll = virtqueue_poll_packed,
 	.detach_unused_buf = virtqueue_detach_unused_buf_packed,
@@ -2668,6 +2768,7 @@ static const struct virtqueue_ops split_in_order_ops = {
 	.kick_prepare = virtqueue_kick_prepare_split,
 	.disable_cb = virtqueue_disable_cb_split,
 	.enable_cb_delayed = virtqueue_enable_cb_delayed_split,
+	.enable_cb_delayed_max = virtqueue_enable_cb_delayed_max_split,
 	.enable_cb_prepare = virtqueue_enable_cb_prepare_split,
 	.poll = virtqueue_poll_split,
 	.detach_unused_buf = virtqueue_detach_unused_buf_split,
@@ -2682,6 +2783,7 @@ static const struct virtqueue_ops packed_in_order_ops = {
 	.kick_prepare = virtqueue_kick_prepare_packed,
 	.disable_cb = virtqueue_disable_cb_packed,
 	.enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
+	.enable_cb_delayed_max = virtqueue_enable_cb_delayed_max_packed,
 	.enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
 	.poll = virtqueue_poll_packed,
 	.detach_unused_buf = virtqueue_detach_unused_buf_packed,
@@ -3197,6 +3299,29 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
 
+/**
+ * virtqueue_enable_cb_delayed_max - callback for all queued buffers
+ * @_vq: the struct virtqueue we're talking about.
+ *
+ * Like virtqueue_enable_cb_delayed, but with VIRTIO_RING_F_EVENT_IDX
+ * the used event is placed at the last currently queued buffer, so the
+ * device only notifies us once it has used everything we queued.
+ *
+ * Returns "true" if the callback is armed and we can sleep waiting
+ * for the notification, or "false" if some buffers were already used
+ * and we should poll instead.
+ */
+bool virtqueue_enable_cb_delayed_max(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (vq->event_triggered)
+		data_race(vq->event_triggered = false);
+
+	return VIRTQUEUE_CALL(vq, enable_cb_delayed_max);
+}
+EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed_max);
+
 /**
  * virtqueue_detach_unused_buf - detach first unused buffer
  * @_vq: the struct virtqueue we're talking about.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 3bbc4cb6a672..214fa36b8eed 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -114,6 +114,8 @@ bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
 bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
 
+bool virtqueue_enable_cb_delayed_max(struct virtqueue *vq);
+
 void *virtqueue_detach_unused_buf(struct virtqueue *vq);
 
 unsigned int virtqueue_get_vring_size(const struct virtqueue *vq);
-- 
MST

