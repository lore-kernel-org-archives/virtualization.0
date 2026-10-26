Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058814;
	b=ppQmPvlyxJCK+50f4bgCjjQuY5fwIgjIxK0Jwe2I9UZwAy/olnv2yHS0dmNxLnGfaVvc
	 WQX7GrxGC93y0ripFxS4UJhbrF5ChhnUuMAMZQDoBd3IeHzUKmyD6s+GLMrl9tUnjHXhO
	 zdLhYjzRfvH1nOiLdvxUnDgIu/ouIEIvDHonugUAs9EWsnS2ngHaJodsC418C1WKtIhOf
	 zqipGcZArZBWSoXWAqOs+TQlHBF8SNEUWkiv7DC/rUuHjs5vOU7g32bnOID/Tu6fa+ZUp
	 /YVILsmsJL4uxjUAo1apksbhg3Vm8x0F2ZUmczj3OliXO+4jb+JkJekF1HNThkqNUsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058814;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=bjaWup0FuAJOmpAyAzTIR20DllfFLEmJV+1+Hi1zMWs=;
	b=gIVmqNHQgjbbPz9qU1/u3XgmRoixqoA1U7z3HOVRVGwAnhdJf97amLggIfApyJ1e0wRi
	 KSr3jnQERE4W6iAlvoTWzC8eDFn5thdYkBs5oEspp3E0oimzp/Rt8uDGOv8LBbac0RN7U
	 ENkbKJ+72rzZCERQlPBUrCcmtgObUKOimXGZ4qljJm+TWFvnw42ow6hZissFUNiN9XBkK
	 YJmR++WDBsv9XXmBhb7G/p9wLq06R7eQSFmDSQbOxw9p/twMSGijWraWUT7eX8fVqHt55
	 KplrQrvBv21ta8Al9Qqm1mcmikv79VbUj7ZdvJJR7b5zPjSFXn0OQHio3E7e9T49t8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=blRUWuhS;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DC0606A323
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 23:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69DC0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=blRUWuhS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793058812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bjaWup0FuAJOmpAyAzTIR20DllfFLEmJV+1+Hi1zMWs=;
	b=blRUWuhSJOfSGwtncVkPLUFfijiOmvxX+yREGeHLFEuYTkH/stJhQAsFAthWwkDL3UQLA6
	LbPtj7JBV/x1DFV5yVIAFRIceWHcVPPvjoq96WgM3o6wW8veJ+qA+D9PDvQEJdO3RQAUSs
	azYua6i4vnyhNUQwhKDpI4eYyCnYCJ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-drOPKchEPrSXCrFDxiEXFw-1; Mon, 26 Oct 2026 19:53:29 -0400
X-MC-Unique: drOPKchEPrSXCrFDxiEXFw-1
X-Mimecast-MFC-AGG-ID: drOPKchEPrSXCrFDxiEXFw_1793058808
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a204ac318aso18863475e9.2
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 16:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058808; x=1793663608;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bjaWup0FuAJOmpAyAzTIR20DllfFLEmJV+1+Hi1zMWs=;
        b=wrWap3S08Lf+whVCBPn52pvbegnkr6E590ga/zyUdpbd5UZ+rGLdV+orR9+DeASG8p
         2NLGdjTnk+0CrtTbTJE2/uwUWCARQEKe0qpBHwFO5oPAf0UqOuYTGO0jzcV3WdWYE36n
         156krYcSD+4kzRCFL9uBWcTYjLYqx9Y50hIbVXlxvChQObI4qrGQtLnnp8yRRey+8Ggb
         ViDKXt/D/wCFwxFvAZanhETvqvfANRKSLn5BD0Tce/Ab6Jk1eeMaWy6lLcEXpCTESsjt
         /Km2FPQrWO9Higl8Baw8HdE5vqQG9cXJA9Pm0XvgKSaQu/UEMaMQ9g2nvDEokG90y/OB
         X+Fg==
X-Forwarded-Encrypted: i=1; AKwUvBwiUv9VasfMPkbbdDZ/rvK/2Lvfdw1payJcN1rsGx4rzB8ZmkgXeZdDkN+1t8udKm4hZ6eI+eUleGV8w2M/ww==@lists.linux.dev
X-Gm-Message-State: AFq9FYIdAYVju9fphXGmxLuWUxCGXLoQo8KV72tuurHrNyexdgg34I/u
	KKa6br7gAP/7hYiFYMyoXUlrmEPjMaMfqzEPgt2TO8dcSuKgw6bLi8m4CtKVsRekOrjVSyAds0l
	WPJqTYoD/BcQ2Y0NBj3hKd56GTcrSkSV21r1LuY4H5bWyo6RcF6hQFgQF/fSuBof1B8VS2QB+Wo
	/E
X-Gm-Gg: AYBFou3pw3F7Zi1m2yZC+Mfw+F1L8GqSo0QJ9URbMSUYSQc/0Y9pyvjwogiAuUtAlJW
	fIvPEyFz82NF5Uqd64IpOdXTX320d4dAAwotjrMSLHqhDO2Md0/LccfHTz4gZYCPUwLBWo/1ubr
	YRZQfAcPxLiWlSyEg5g5jhyy3J8HFMhGN4l2L4CCQPpsLQUwm6b/kUDfiZ2gw2NzIODf4eMskqN
	LJ2L3sMu6e19UOMiw5F1nXI7jDfyUtFx7Xej8+YzGikVUqNH1J6pO1I/O1V6F3RK8BlZkYNPf80
	m0XIOiSq0BPPRxbLpKXlr6vZlJawqb34tQxmFxM6Z1ieVSNmhkakfXuBwvIjCfmrCdI=
X-Received: by 2002:a05:600c:1992:b0:4a2:1a:a121 with SMTP id 5b1f17b1804b1-4a35acaf98emr138793515e9.18.1793058807597;
        Mon, 26 Oct 2026 16:53:27 -0700 (PDT)
X-Received: by 2002:a05:600c:1992:b0:4a2:1a:a121 with SMTP id 5b1f17b1804b1-4a35acaf98emr138793265e9.18.1793058807090;
        Mon, 26 Oct 2026 16:53:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f305sm17811321f8f.3.2026.10.26.16.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:53:26 -0700 (PDT)
Date: Mon, 26 Oct 2026 19:53:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v2 1/2] virtio_ring: add virtqueue_enable_cb_delayed_max
Message-ID: <32e21059adb6cb1fd08c3f4426a313c77cf450ec.1793057483.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: p5PakUeJy5wu0_rDf0VTONaPZbsXncwukxOLnLTQ5ho_1793058808
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

Notes (changelog):
    changes since v1:
        fix off-by-one: place the used event one entry before the
        last queued buffer.  The device only signals once it passes
        the event, so with the event at the last buffer it never
        fired and callers waiting for the batch to complete hung.

 drivers/virtio/virtio_ring.c | 127 +++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |   2 +
 2 files changed, 129 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fbca7ce1c6bf..4c0bb860b703 100644
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
@@ -1122,6 +1123,43 @@ static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
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
+	/* Point the used event one entry before the last queued buffer:
+	 * the device signals when it passes the event, so this makes it
+	 * notify us exactly once it has used everything. */
+	bufs = (u16)(vq->split.avail_idx_shadow - vq->last_used_idx) - 1;
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
@@ -2318,6 +2356,68 @@ static bool virtqueue_enable_cb_delayed_packed(struct vring_virtqueue *vq)
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
+		/* Point the event one entry before the last queued buffer:
+		 * the device signals when it passes the event, so this
+		 * makes it notify us exactly once it has used everything. */
+		bufs = vq->packed.vring.num - vq->vq.num_free - 1;
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
@@ -2640,6 +2740,7 @@ static const struct virtqueue_ops split_ops = {
 	.kick_prepare = virtqueue_kick_prepare_split,
 	.disable_cb = virtqueue_disable_cb_split,
 	.enable_cb_delayed = virtqueue_enable_cb_delayed_split,
+	.enable_cb_delayed_max = virtqueue_enable_cb_delayed_max_split,
 	.enable_cb_prepare = virtqueue_enable_cb_prepare_split,
 	.poll = virtqueue_poll_split,
 	.detach_unused_buf = virtqueue_detach_unused_buf_split,
@@ -2654,6 +2755,7 @@ static const struct virtqueue_ops packed_ops = {
 	.kick_prepare = virtqueue_kick_prepare_packed,
 	.disable_cb = virtqueue_disable_cb_packed,
 	.enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
+	.enable_cb_delayed_max = virtqueue_enable_cb_delayed_max_packed,
 	.enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
 	.poll = virtqueue_poll_packed,
 	.detach_unused_buf = virtqueue_detach_unused_buf_packed,
@@ -2668,6 +2770,7 @@ static const struct virtqueue_ops split_in_order_ops = {
 	.kick_prepare = virtqueue_kick_prepare_split,
 	.disable_cb = virtqueue_disable_cb_split,
 	.enable_cb_delayed = virtqueue_enable_cb_delayed_split,
+	.enable_cb_delayed_max = virtqueue_enable_cb_delayed_max_split,
 	.enable_cb_prepare = virtqueue_enable_cb_prepare_split,
 	.poll = virtqueue_poll_split,
 	.detach_unused_buf = virtqueue_detach_unused_buf_split,
@@ -2682,6 +2785,7 @@ static const struct virtqueue_ops packed_in_order_ops = {
 	.kick_prepare = virtqueue_kick_prepare_packed,
 	.disable_cb = virtqueue_disable_cb_packed,
 	.enable_cb_delayed = virtqueue_enable_cb_delayed_packed,
+	.enable_cb_delayed_max = virtqueue_enable_cb_delayed_max_packed,
 	.enable_cb_prepare = virtqueue_enable_cb_prepare_packed,
 	.poll = virtqueue_poll_packed,
 	.detach_unused_buf = virtqueue_detach_unused_buf_packed,
@@ -3197,6 +3301,29 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
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

