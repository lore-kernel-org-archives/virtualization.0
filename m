Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862556;
	b=MmafGMz2c6aWLcWT0np9IJQ9CMaX57Tmq7xTO7nnuUGAAcD8s6E9myIhtxXvXVIvffak
	 x2WLgKekC8aXK6MXeAUpiNc7dqy7vI9pm0poUSviGJ4+/+ZizI7aevaq6wKA1eNCWmDfi
	 BhBV9m8bun35ViAteWMqtvcSBFufwHFRpvOq7Q8drXRJsO5mC9rE9Xm2AXe6Eg192eHMG
	 dakikKs2OoarPD1KlfS6GZu4BF6Y88Qsfam86iJ6DR1l9zlqpgadUit8jPWjtHZHD64br
	 4eX/y9/qsUk2+LclR7BqX1Bgq054FOJEvqtGMQFzcPizK+0ZnenLQCJeoqcqrQx/f3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hA9whqWWbV6K20gHw6KCXT5xEkMWnuiSkLAw9Y5Ct34=;
	b=01ac3ivLa7BF8h7dD+8XVYln0lBtnIr64RPx1x5aJfB9csXntnFVlJMKnUsuis+6QDB9
	 in6PnD1qpr4g706xV7qnPdxd4oDQct3aq7z6Npo0PpdGQ0JmozqGXtjU3fzT+5BGZ1BHB
	 1oNU2sL0Pt4I9kSQlMpd3C7OquI7WyMXGCHUiSMqBLLJI6tLXq6dQl+Ydf2hD+C6fxYWr
	 N9LobA6VcpePsmSbwTFo5tbUiZSi2KucXnh6T6RHQ0i9QZDsMmyTZZGdLjDzWAphJMPen
	 0aBRKU9ipMkJBdIEPdK1DiPhIZQ+tWxlrqIZ3v22hvdDHY7ZAVpLqOOvT4BgLIVdMJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KYfhGKxv;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51267606A334
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51267606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KYfhGKxv
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535a54bed9so2049826eec.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 23:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793862555; x=1794467355; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hA9whqWWbV6K20gHw6KCXT5xEkMWnuiSkLAw9Y5Ct34=;
        b=KYfhGKxvqRupnuWR7Gidb+WXyhs5EkOtbt0mljvuPZN3FU6h1zdLAUZtlXlfUbdojP
         ibkaUx3cxuIigJ4x/1jMoxXIT7+L3gcrzdVU076QXYMTKpjSx2/9pL62vr+zLV+Q1byY
         UW08nkYwEKXtyvzYO0Vupds0KYvGm1D8DPciEI3tQYUDqqLfzyLGtpdWW/yf0YSyMwqv
         7ECMdVQW3CveEXnbBxTEBu8eI+GmgGQyfVs9YBuiCbp0a8acgfyTf08lXBlhupUCN1tf
         YIc4qZAJdeWzfMYxKXtnGJf0vdZ7269aAUH4jaqObZtlCIk751b8plkvefT5QyHptgzQ
         AsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793862555; x=1794467355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hA9whqWWbV6K20gHw6KCXT5xEkMWnuiSkLAw9Y5Ct34=;
        b=uD0tUEdmrSfHO3EJi4Z9YQE4rHdttCD6oBmJgDGFS3vJcZcaoJtAwR3scC0oqGnuEf
         rsUstSbYV7+nM3txxu8P2ZEo5XEG+4h3jvdwBgYiR0gWvvmNv1dVe4ILH5xfm0isuMO2
         cRRKjJQzB7fcIvmTX/r5BNKTXJnrfJDL/n77jENrzcvuVcbTr3PP/xcLWPtPZwYSsn8k
         X4Em5yet2qhVWzi8vTw4iD9fO2fvSmItb7mchdUo2jLnr1I+YXnhnnTmZZ2GC2HiK4cW
         FEm3kDbETAg40Y8tzA1ofhC+UN0chsoieUJ404WSQNgTxhFFfx9PyV9LB0OBO7akcGWG
         ug9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwdTSExsq14kxSUg9gwv93Mv0rkhnpQsjNknCuc/4qADDbQCW6qT0FHJVhk1dgq8BasTN8zVg0LbHh1Zj8I9g==@lists.linux.dev
X-Gm-Message-State: APuU4Z959CqjUQsUhv5uTwXmegVqKLowowGa/LZ5PPdadcDS1eM5qJ+c
	TaBO4PuuKQtzUxg7E4gK6QLTy3aPrH8XBgBfcK/kqE0PjibNjavGKjrC
X-Gm-Gg: AYBFou1DLvwUOOI7uDU7WCUtFsxcHb+c6TBnXaDlus5hqreeV2i5hhl1OwUI+/fmgWU
	iUbvi2okNNYiwJ5FwNbeTF5VPPYeVeZUpQwJbe+V89BCDCU2N82V9PZHuk9j2ieiO4lGBgadl+I
	+VuerAsc/Q4SUvzABHxuVN50PzmChXtHnGQiZk0Ki4ax+yj5Zsx+AugNWqOK67MAthQjYjYik2U
	hQRSGG3Api7CRzw4V6pPiCjtl5cMsxjoAKMRY4QCh0XhrAFOx5ws9lVOiLI6+CcVpwfcdo0xRMS
	WmfEZHTANoyYDBrR+w5Ghw3QC8nyFlScTneLJjICR0IuVIYOtkOUgC0NzX6DRa5lgqYTtRqR67w
	XR1Yf7md2AyXTlizBQMIMuT4pPCyRnUq30rysNLpSGHKG8UlLzexbuhYCwb8rHJnhgQO2KadA1s
	lVCkelaTJDFrLOa+idURbWpX2Y1VkvvDVnRoL0Bzl1SVkjz/2zst1fcTQNw2u0UBnNGe3piEqMw
	0PF4GBZRANBu9665orJTi2csUJbi+r/XEL9UVdANi6zoQExaoFf5J8V/6wmANhfxfFowKEMOi0S
	C63CV6V+i/a+/7MYxqcAn8PWOj54WRpruT3yplnz0jMOhAqjmxDrBcODAfaLAFge9gK/cILDZxX
	2dcSJoQ22748xQhAXVSfnOtfIyp5JK6pkXgO6QACCMyGfCiMeeiK1QHb8b20Z8TfglIMi
X-Received: by 2002:a05:693c:8951:20b0:36d:f46a:87b8 with SMTP id 5a478bee46e88-36df46a8ed9mr2246143eec.37.1793862554960;
        Wed, 04 Nov 2026 23:09:14 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm16812286eec.24.2026.11.04.23.09.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 23:09:14 -0800 (PST)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v17 06/12] ALSA: virtio: Retain queued messages through device reset
Date: Thu,  5 Nov 2026 16:08:39 +0900
Message-ID: <20261105070845.6449-7-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105070845.6449-1-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep the control queue available through snd_card_free() so close-time
STOP and RELEASE commands can still be submitted. Block new control
requests and mark pending messages canceled before reset, then release
their queue references only after reset and queue deletion.

For PCM queues, detach each remaining virtqueue buffer after the device
has stopped DMA and retire its message without reporting a normal
completion. Detach all queues before deleting them so outstanding DMA
mappings are unmapped and no token remains for a late device completion.

Protect event callback admission with the event queue lock. Disabling
events waits for an active dispatch, and later callbacks see a closed
gate before ALSA objects are freed. Enable and pending-event draining
share the same lock.

Reclaim pending event buffers after a failed probe without dispatching
notifications into ALSA objects that have not been constructed. Record
the queue's prior enabled state under its lock before closing admission.

Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")

Track virtqueue initialization across partial restore so rollback deletes only queues created by the current attempt. Clear freed event-message ownership before a later remove can reclaim it.
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_card.c    |  110 ++++++++++++++++++++++++++++++++---------
 sound/virtio/virtio_card.h    |    6 ++
 sound/virtio/virtio_ctl_msg.c |   64 +++++++++++++++++++++---
 sound/virtio/virtio_ctl_msg.h |    4 +
 sound/virtio/virtio_pcm.h     |    2 +
 sound/virtio/virtio_pcm_msg.c |   42 ++++++++++++++--
 6 files changed, 193 insertions(+), 35 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -70,23 +70,13 @@
 	}
 }
 
-/**
- * virtsnd_event_notify_cb() - Dispatch all reported events from the event queue.
- * @vqueue: Underlying event virtqueue.
- *
- * This callback function is called upon a vring interrupt request from the
- * device.
- *
- * Context: Interrupt context.
- */
-static void virtsnd_event_notify_cb(struct virtqueue *vqueue)
-{
-	struct virtio_snd *snd = vqueue->vdev->priv;
-	struct virtio_snd_queue *queue = virtsnd_event_queue(snd);
+static void virtsnd_event_drain_locked(struct virtio_snd *snd,
+				       struct virtqueue *vqueue)
+{
 	struct virtio_snd_event *event;
 	u32 length;
 
-	guard(spinlock_irqsave)(&queue->lock);
+	lockdep_assert_held(&virtsnd_event_queue(snd)->lock);
 	do {
 		virtqueue_disable_cb(vqueue);
 		while ((event = virtqueue_get_buf(vqueue, &length))) {
@@ -94,6 +84,26 @@
 			virtsnd_event_send(vqueue, event, true, GFP_ATOMIC);
 		}
 	} while (!virtqueue_enable_cb(vqueue));
+}
+
+/**
+ * virtsnd_event_notify_cb() - Dispatch all reported events from the event queue.
+ * @vqueue: Underlying event virtqueue.
+ *
+ * This callback function is called upon a vring interrupt request from the
+ * device.
+ *
+ * Context: Interrupt context.
+ */
+static void virtsnd_event_notify_cb(struct virtqueue *vqueue)
+{
+	struct virtio_snd *snd = vqueue->vdev->priv;
+	struct virtio_snd_queue *queue = virtsnd_event_queue(snd);
+
+	guard(spinlock_irqsave)(&queue->lock);
+	if (queue->vqueue != vqueue || !snd->event_vq_enabled)
+		return;
+	virtsnd_event_drain_locked(snd, vqueue);
 }
 
 /**
@@ -131,6 +141,7 @@
 
 	for (i = 0; i < VIRTIO_SND_VQ_MAX; ++i)
 		snd->queues[i].vqueue = vqs[i];
+	snd->vqs_initialized = true;
 
 	/* Allocate events and populate the event queue */
 	virtqueue_disable_cb(vqs[VIRTIO_SND_VQ_EVENT]);
@@ -158,8 +169,12 @@
 {
 	struct virtio_snd_queue *queue = virtsnd_event_queue(snd);
 
+	guard(spinlock_irqsave)(&queue->lock);
+	if (!queue->vqueue)
+		return;
+	snd->event_vq_enabled = true;
 	if (!virtqueue_enable_cb(queue->vqueue))
-		virtsnd_event_notify_cb(queue->vqueue);
+		virtsnd_event_drain_locked(snd, queue->vqueue);
 }
 
 /**
@@ -172,13 +187,19 @@
 {
 	struct virtio_snd_queue *queue = virtsnd_event_queue(snd);
 	struct virtio_snd_event *event;
+	bool dispatch_events;
 	u32 length;
 
+	guard(spinlock_irqsave)(&queue->lock);
+	dispatch_events = snd->event_vq_enabled;
+	snd->event_vq_enabled = false;
 	if (queue->vqueue) {
-		guard(spinlock_irqsave)(&queue->lock);
 		virtqueue_disable_cb(queue->vqueue);
-		while ((event = virtqueue_get_buf(queue->vqueue, &length)))
-			virtsnd_event_dispatch(snd, event);
+		while ((event = virtqueue_get_buf(queue->vqueue, &length))) {
+			/* Reclaim used buffers even when failed probe cannot dispatch. */
+			if (dispatch_events)
+				virtsnd_event_dispatch(snd, event);
+		}
 	}
 }
 
@@ -338,6 +359,43 @@
 }
 
 /**
+ * virtsnd_reset_vqs() - Stop device access and unmap outstanding buffers.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context that permits to sleep.
+ */
+static void virtsnd_reset_vqs(struct virtio_snd *snd)
+{
+	struct virtio_device *vdev = snd->vdev;
+	unsigned int i;
+
+	virtio_reset_device(vdev);
+
+	/* Deleting a virtqueue does not unmap its outstanding descriptors. */
+	for (i = 0; i < VIRTIO_SND_VQ_MAX; ++i) {
+		struct virtio_snd_queue *queue = &snd->queues[i];
+		unsigned long flags;
+		void *msg;
+
+		spin_lock_irqsave(&queue->lock, flags);
+		if (queue->vqueue)
+			while ((msg = virtqueue_detach_unused_buf(queue->vqueue)))
+				if (i == VIRTIO_SND_VQ_TX || i == VIRTIO_SND_VQ_RX)
+					virtsnd_pcm_msg_cancel(msg);
+		if (i == VIRTIO_SND_VQ_EVENT)
+			snd->event_vq_enabled = false;
+		/* IRQ callbacks must never see a detached ring as live. */
+		queue->vqueue = NULL;
+		spin_unlock_irqrestore(&queue->lock, flags);
+	}
+
+	if (snd->vqs_initialized) {
+		vdev->config->del_vqs(vdev);
+		snd->vqs_initialized = false;
+	}
+}
+
+/**
  * virtsnd_remove() - Remove VirtIO and ALSA devices.
  * @vdev: VirtIO parent device.
  *
@@ -349,13 +407,14 @@
 	unsigned int i;
 
 	virtsnd_disable_event_vq(snd);
-	virtsnd_ctl_msg_cancel_all(snd);
 
 	if (snd->card)
 		snd_card_free(snd->card);
 
-	virtio_reset_device(vdev);
-	vdev->config->del_vqs(vdev);
+	virtsnd_ctl_msg_cancel_all(snd);
+
+	virtsnd_reset_vqs(snd);
+	virtsnd_ctl_msg_cleanup(snd);
 
 	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
@@ -383,8 +442,8 @@
 	virtsnd_disable_event_vq(snd);
 	virtsnd_ctl_msg_cancel_all(snd);
 
-	virtio_reset_device(vdev);
-	vdev->config->del_vqs(vdev);
+	virtsnd_reset_vqs(snd);
+	virtsnd_ctl_msg_cleanup(snd);
 
 	for (i = 0; i < snd->nsubstreams; ++i)
 		cancel_work_sync(&snd->substreams[i].elapsed_period);
@@ -408,10 +467,13 @@
 	int rc;
 
 	rc = virtsnd_find_vqs(snd);
-	if (rc)
+	if (rc) {
+		virtsnd_reset_vqs(snd);
 		return rc;
+	}
 
 	virtio_device_ready(vdev);
+	virtsnd_ctl_msg_enable(snd);
 
 	virtsnd_enable_event_vq(snd);
 
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -45,8 +45,11 @@
  * struct virtio_snd - VirtIO sound card device.
  * @vdev: Underlying virtio device.
  * @queues: Virtqueue wrappers.
+ * @vqs_initialized: Virtqueues allocated by virtio_find_vqs().
  * @card: ALSA sound card.
  * @ctl_msgs: Pending control request list.
+ * @ctl_msgs_blocked: Control requests are blocked during teardown or suspend.
+ * @event_vq_enabled: Event callbacks may dispatch, protected by the event queue lock.
  * @event_msgs: Device events.
  * @pcm_list: VirtIO PCM device list.
  * @jacks: VirtIO jacks.
@@ -62,8 +65,11 @@
 struct virtio_snd {
 	struct virtio_device *vdev;
 	struct virtio_snd_queue queues[VIRTIO_SND_VQ_MAX];
+	bool vqs_initialized;
 	struct snd_card *card;
 	struct list_head ctl_msgs;
+	bool ctl_msgs_blocked;
+	bool event_vq_enabled;
 	struct virtio_snd_event *event_msgs;
 	struct list_head pcm_list;
 	struct virtio_jack *jacks;
diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -15,6 +15,7 @@
  * @list: Pending message list entry.
  * @notify: Request completed notification.
  * @ref_count: Reference count used to manage a message lifetime.
+ * @cancelled: Request canceled during device teardown.
  */
 struct virtio_snd_msg {
 	struct scatterlist sg_request;
@@ -22,6 +23,7 @@
 	struct list_head list;
 	struct completion notify;
 	refcount_t ref_count;
+	bool cancelled;
 };
 
 /**
@@ -100,7 +102,7 @@
 
 	INIT_LIST_HEAD(&msg->list);
 	init_completion(&msg->notify);
-	/* This reference is dropped in virtsnd_ctl_msg_complete(). */
+	/* The caller owns this reference; send adds a queue reference. */
 	refcount_set(&msg->ref_count, 1);
 
 	return msg;
@@ -134,6 +136,7 @@
 	int rc;
 
 	virtsnd_ctl_msg_ref(msg);
+	/* This reference stays with the queue until completion or teardown. */
 
 	/* Set the default status in case the message was canceled. */
 	response->code = cpu_to_le32(VIRTIO_SND_S_IO_ERR);
@@ -147,12 +150,17 @@
 		psgs[nouts + nins++] = in_sgs;
 
 	scoped_guard(spinlock_irqsave, &queue->lock) {
-		rc = virtqueue_add_sgs(queue->vqueue, psgs, nouts, nins, msg,
-				       GFP_ATOMIC);
+		if (snd->ctl_msgs_blocked)
+			rc = -ENODEV;
+		else
+			rc = virtqueue_add_sgs(queue->vqueue, psgs, nouts, nins,
+					       msg, GFP_ATOMIC);
 		if (!rc) {
 			notify = virtqueue_kick_prepare(queue->vqueue);
 
 			list_add_tail(&msg->list, &snd->ctl_msgs);
+			if (notify)
+				virtqueue_notify(queue->vqueue);
 		}
 	}
 
@@ -168,9 +176,6 @@
 
 		goto on_exit;
 	}
-
-	if (notify)
-		virtqueue_notify(queue->vqueue);
 
 	if (nowait)
 		goto on_exit;
@@ -184,6 +189,11 @@
 			rc = -ETIMEDOUT;
 		}
 
+		goto on_exit;
+	}
+
+	if (READ_ONCE(msg->cancelled)) {
+		rc = -ENODEV;
 		goto on_exit;
 	}
 
@@ -227,9 +237,33 @@
  * virtsnd_ctl_msg_cancel_all() - Cancel all pending control messages.
  * @snd: VirtIO sound device.
  *
- * Context: Any context.
+ * Context: Any context. Blocks new senders and marks pending requests canceled.
+ *          Existing senders are woken when their request completes or after
+ *          the device has been reset.
  */
 void virtsnd_ctl_msg_cancel_all(struct virtio_snd *snd)
+{
+	struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
+	struct virtio_snd_msg *msg;
+
+	guard(spinlock_irqsave)(&queue->lock);
+	snd->ctl_msgs_blocked = true;
+	list_for_each_entry(msg, &snd->ctl_msgs, list) {
+		WRITE_ONCE(msg->cancelled, true);
+	}
+}
+
+/**
+ * virtsnd_ctl_msg_cleanup() - Release messages left after queue teardown.
+ * @snd: VirtIO sound device.
+ *
+ * This must be called after device reset, buffer detachment, and del_vqs(),
+ * when no queue callback or DMA access can still reach a message. The queue
+ * object and its lock must remain alive until this function returns.
+ *
+ * Context: Any context.
+ */
+void virtsnd_ctl_msg_cleanup(struct virtio_snd *snd)
 {
 	struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
 
@@ -244,6 +278,20 @@
 }
 
 /**
+ * virtsnd_ctl_msg_enable() - Allow control requests after queue restoration.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context.
+ */
+void virtsnd_ctl_msg_enable(struct virtio_snd *snd)
+{
+	struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
+
+	guard(spinlock_irqsave)(&queue->lock);
+	snd->ctl_msgs_blocked = false;
+}
+
+/**
  * virtsnd_ctl_query_info() - Query the item configuration from the device.
  * @snd: VirtIO sound device.
  * @command: Control request code (VIRTIO_SND_R_XXX_INFO).
@@ -295,6 +343,8 @@
 	u32 length;
 
 	guard(spinlock_irqsave)(&queue->lock);
+	if (queue->vqueue != vqueue)
+		return;
 	do {
 		virtqueue_disable_cb(vqueue);
 		while ((msg = virtqueue_get_buf(vqueue, &length)))
diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
--- a/sound/virtio/virtio_ctl_msg.h
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -68,6 +68,10 @@
 
 void virtsnd_ctl_msg_cancel_all(struct virtio_snd *snd);
 
+void virtsnd_ctl_msg_cleanup(struct virtio_snd *snd);
+
+void virtsnd_ctl_msg_enable(struct virtio_snd *snd);
+
 void virtsnd_ctl_msg_complete(struct virtio_snd_msg *msg);
 
 int virtsnd_ctl_query_info(struct virtio_snd *snd, int command, int start_id,
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -128,6 +128,8 @@
 
 void virtsnd_pcm_msg_reset(struct virtio_pcm_substream *vss);
 
+void virtsnd_pcm_msg_cancel(struct virtio_pcm_msg *msg);
+
 int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
 			 unsigned long bytes);
 
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -305,6 +305,35 @@
 {
 	guard(spinlock_irqsave)(&vss->lock);
 	return vss->msg_count;
+}
+
+/**
+ * virtsnd_pcm_msg_cancel() - Cancel a message detached during device reset.
+ * @msg: Message returned by virtqueue_detach_unused_buf().
+ *
+ * Reset cancellation retires the queue token without treating it as a device
+ * completion. In particular, it does not advance the PCM hardware pointer or
+ * schedule period work.
+ *
+ * Context: Process context with the PCM queue lock held.
+ */
+void virtsnd_pcm_msg_cancel(struct virtio_pcm_msg *msg)
+{
+	struct virtio_pcm_substream *vss = msg->substream;
+	bool wake;
+
+	{
+		guard(spinlock)(&vss->lock);
+		msg->length = 0;
+		vss->xfer_enabled = false;
+		if (WARN_ON_ONCE(!vss->msg_count))
+			return;
+		vss->msg_count--;
+		wake = !vss->msg_count;
+	}
+
+	if (wake)
+		wake_up_all(&vss->msg_empty);
 }
 
 /**
@@ -367,16 +396,21 @@
 
 /**
  * virtsnd_pcm_notify_cb() - Process all completed I/O messages.
- * @queue: Underlying tx/rx virtqueue.
+ * @queue: Underlying tx/rx queue wrapper.
+ * @vqueue: Queue that raised this callback.
  *
  * Context: Interrupt context. Takes and releases the tx/rx queue spinlock.
  */
-static inline void virtsnd_pcm_notify_cb(struct virtio_snd_queue *queue)
+static inline void
+virtsnd_pcm_notify_cb(struct virtio_snd_queue *queue, struct virtqueue *vqueue)
 {
 	struct virtio_pcm_msg *msg;
 	u32 written_bytes;
 
 	guard(spinlock_irqsave)(&queue->lock);
+	/* Reset can detach the queue before the transport drains its IRQs. */
+	if (queue->vqueue != vqueue)
+		return;
 	do {
 		virtqueue_disable_cb(queue->vqueue);
 		while ((msg = virtqueue_get_buf(queue->vqueue, &written_bytes)))
@@ -394,7 +428,7 @@
 {
 	struct virtio_snd *snd = vqueue->vdev->priv;
 
-	virtsnd_pcm_notify_cb(virtsnd_tx_queue(snd));
+	virtsnd_pcm_notify_cb(virtsnd_tx_queue(snd), vqueue);
 }
 
 /**
@@ -407,7 +441,7 @@
 {
 	struct virtio_snd *snd = vqueue->vdev->priv;
 
-	virtsnd_pcm_notify_cb(virtsnd_rx_queue(snd));
+	virtsnd_pcm_notify_cb(virtsnd_rx_queue(snd), vqueue);
 }
 
 /**
