Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5C3C278A
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881887; cv=none; b=UeczFCrHN1LXW5rKZH0eg5dZ3VE+QI/agPfBxZre8RYu3lUV3SipoVwrIFR+evZ4R8TrJ3hXGYqt3j70kaQpK/kIW84OXVVSsqrMMbSbkmxFLWpyUwHmGCNjvTq21gl+KAsJsOBS2HAqcN15h5fnvHOqfu9tkV+4mIjsKjyQFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881887; c=relaxed/simple;
	bh=uCXqX1jQ0YdZGHcTeVLM5+QaLjhW0N9hDYyFeGyLb9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usbvMUfqVFUdqKeoPid+wSD7YPCpTZ1l+Gbi7pgi00elXUpbwpXfHdnRD0aWnCMkS6fK2HA0/L2GGZSeL5Cb2MHSAzbQ6P2IjCLkMpWK3Saft5QBtn5WWoXRiQFQuDVpuIaUuE54dnt1IFFzNNFKZvWaXqec38smGs/lc/C5zGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkUuKC1d; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkUuKC1d"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so1016588a12.1
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791881885; x=1792486685; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhpmC/Uc/PbS3eydMZOwQvVnE3o7hoZ+spCQpzSOEEE=;
        b=mkUuKC1dd4Uf0EdQRtJ2HPay6+4F2zG31UPXiCoOpI1AZ+NrpiEeyeSbn6qoeyBnC3
         vpvxBQqX8jkn97rPDCczp6dScsx4YT+Ixnnlk3MrYz/4MNcmxtwUaGT/ckQLoHLAq56w
         +U00UzR8DeTpS8s+WotvNlLEgZXU4/6q81vk0bc8PJvvjsLXHSFWmVQqH9Q12h8B811X
         l00IHGtaB4eVDLkiCtyumjSZLAYnkX7joz6LXH1/U2B+JK4Vtsh43WZABz0g0Kz2jzky
         YB3MTGIfsNaLyu55ctzZPL3DiHsevtprAAUWLEL2oDElVIB1BLzGOZ4CqaxtQGsoxHsl
         CfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881885; x=1792486685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhpmC/Uc/PbS3eydMZOwQvVnE3o7hoZ+spCQpzSOEEE=;
        b=bkTZLTv5PEVeQ0d26F4mrAlNvjzTYn8v2nA2hSHE8ZDYPQkV+fdm4wmzyWeoTE+LYv
         s/DdrZFrGi5vCP0fw0zLGmkzQHA9/7yC46D3tmq75w2vwUgsUBplnfbU6bICjCJQJtlJ
         CLrkykc5o1TLH1GBqtVfKbIgBnlen/zPHMjLMwKEpZhliHnswbRmRIQnIqLM6TJ7EZq1
         j1mNQm5EplcoqKjse+seEiOmS4M+ebBansvD4TR9Qhd2D4hdT9EFrRtZg676a4NLf7vj
         xNhBGvCTA0LHDoG+Cf0rcMXIhK3HEGtCagIXPFaVO8BNAiNw81VmpAHV8cz9j0yWqkOX
         8sNg==
X-Forwarded-Encrypted: i=1; AKwUvBxR4bD6BTj5YkjfcB/sYmxUFuB6Vxb5v8wbUR+GzC4kwMNjAGN4Db9hj3Sjr1WmWNmNL74QyY7zj8gM7uc8hQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKwW9ZffXEhaYGlvfwyglcZSeccV9Dd+peKlWhxAuF2anaa+yyg
	1xim9wUIwLT+Dd0yxIi1SnkA+woEkYBlj1hUnQK4gKALBneDA9tBpjsb
X-Gm-Gg: AYBFou0X7+QIX70CF2ZIMt5C8sXykkP/al3MQHX4QIG7pel8J+90GW3UnvzUstKSW4u
	QZkJJosvDcX4SzAtoAtFOOa7I5LHgV/e/iSJjj9R8NhJ8z+Ud2Xn/mNDS3nvg9tNH8wiOqiSJ3B
	O4ey6qnT4PQNyNF7ceydAiTs2zvmONiiHsN+ok3UBlWKt2m6OFyO2a2VzF/zKQyAJpyJv8ZzLzg
	dg7if6mnp6b1ELSWSf5gqkRoohK6PwPv2CuglVoEbQJeMp/H7tEdiilxdgV+UVxT1fFjkgb6O79
	47Qc2u8fxOE5iIPxlQNEDQ9u5m/IyTjx2n2k269BFsbHEg/qG1Xas+VYYnsdP0kS3a5HY0ghDaI
	Yws7ctcBehPVBpsV7n5WR4bijIYQnK0bN47ll0vGNFCzwrGP7FQqHChjzpN9PA5kaTtj7pAY6kM
	BJ0kFmkeP3m2pLEBkc8ub6fCU4ofP7DrtR9Mv9Lcq5Yhgk9ERZOUc31bzduuB7OeEDPr2XCxCRI
	E9FmcUaMCSa5OE5o81BYxguVm/v3Uywrn83yN4cUmEhpr8s4YrJzjV/i77SvH/7Rwk0fSGRJQ7I
	6mW5oO1pa0tkel5C
X-Received: by 2002:a05:6a20:1446:b0:3e0:651a:d160 with SMTP id adf61e73a8af0-3e16bf5f372mr9939515637.73.1791881885044;
        Tue, 13 Oct 2026 01:58:05 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6063d31dcsm1838592a12.3.2026.10.13.01.58.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 01:58:04 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>
Subject: [PATCH v3 3/5] ALSA: virtio: Retain queued messages through device reset
Date: Tue, 13 Oct 2026 17:57:50 +0900
Message-ID: <c813ae359e4672b93d940f884903f99a29371434.1791881787.git.mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791881787.git.mynameisjune111@gmail.com>
References: <cover.1791881787.git.mynameisjune111@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
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

Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
Changes in v3:
- No code or commit-message changes from v2.

 sound/virtio/virtio_card.c    | 44 ++++++++++++++++++++++---
 sound/virtio/virtio_card.h    |  2 ++
 sound/virtio/virtio_ctl_msg.c | 62 +++++++++++++++++++++++++++++++----
 sound/virtio/virtio_ctl_msg.h |  4 +++
 sound/virtio/virtio_pcm.h     |  2 ++
 sound/virtio/virtio_pcm_msg.c | 29 ++++++++++++++++
 6 files changed, 131 insertions(+), 12 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 6f35276416fe..df7091b74a52 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -337,6 +337,38 @@ static int virtsnd_probe(struct virtio_device *vdev)
 	return rc;
 }
 
+/**
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
+		spin_unlock_irqrestore(&queue->lock, flags);
+	}
+
+	vdev->config->del_vqs(vdev);
+	for (i = 0; i < VIRTIO_SND_VQ_MAX; ++i)
+		snd->queues[i].vqueue = NULL;
+}
+
 /**
  * virtsnd_remove() - Remove VirtIO and ALSA devices.
  * @vdev: VirtIO parent device.
@@ -349,13 +381,14 @@ static void virtsnd_remove(struct virtio_device *vdev)
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
@@ -383,8 +416,8 @@ static int virtsnd_freeze(struct virtio_device *vdev)
 	virtsnd_disable_event_vq(snd);
 	virtsnd_ctl_msg_cancel_all(snd);
 
-	virtio_reset_device(vdev);
-	vdev->config->del_vqs(vdev);
+	virtsnd_reset_vqs(snd);
+	virtsnd_ctl_msg_cleanup(snd);
 
 	for (i = 0; i < snd->nsubstreams; ++i)
 		cancel_work_sync(&snd->substreams[i].elapsed_period);
@@ -412,6 +445,7 @@ static int virtsnd_restore(struct virtio_device *vdev)
 		return rc;
 
 	virtio_device_ready(vdev);
+	virtsnd_ctl_msg_enable(snd);
 
 	virtsnd_enable_event_vq(snd);
 
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index 3ceee4e416fc..bd065bd00d25 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -47,6 +47,7 @@ struct virtio_kctl {
  * @queues: Virtqueue wrappers.
  * @card: ALSA sound card.
  * @ctl_msgs: Pending control request list.
+ * @ctl_msgs_blocked: Control requests are blocked during teardown or suspend.
  * @event_msgs: Device events.
  * @pcm_list: VirtIO PCM device list.
  * @jacks: VirtIO jacks.
@@ -64,6 +65,7 @@ struct virtio_snd {
 	struct virtio_snd_queue queues[VIRTIO_SND_VQ_MAX];
 	struct snd_card *card;
 	struct list_head ctl_msgs;
+	bool ctl_msgs_blocked;
 	struct virtio_snd_event *event_msgs;
 	struct list_head pcm_list;
 	struct virtio_jack *jacks;
diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
index 6433c870f271..7114bea4033a 100644
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
@@ -22,6 +23,7 @@ struct virtio_snd_msg {
 	struct list_head list;
 	struct completion notify;
 	refcount_t ref_count;
+	bool cancelled;
 };
 
 /**
@@ -100,7 +102,7 @@ struct virtio_snd_msg *virtsnd_ctl_msg_alloc(size_t request_size,
 
 	INIT_LIST_HEAD(&msg->list);
 	init_completion(&msg->notify);
-	/* This reference is dropped in virtsnd_ctl_msg_complete(). */
+	/* The caller owns this reference; send adds a queue reference. */
 	refcount_set(&msg->ref_count, 1);
 
 	return msg;
@@ -134,6 +136,7 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 	int rc;
 
 	virtsnd_ctl_msg_ref(msg);
+	/* This reference stays with the queue until completion or teardown. */
 
 	/* Set the default status in case the message was canceled. */
 	response->code = cpu_to_le32(VIRTIO_SND_S_IO_ERR);
@@ -147,12 +150,17 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
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
 
@@ -169,9 +177,6 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 		goto on_exit;
 	}
 
-	if (notify)
-		virtqueue_notify(queue->vqueue);
-
 	if (nowait)
 		goto on_exit;
 
@@ -187,6 +192,11 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 		goto on_exit;
 	}
 
+	if (READ_ONCE(msg->cancelled)) {
+		rc = -ENODEV;
+		goto on_exit;
+	}
+
 	switch (le32_to_cpu(response->code)) {
 	case VIRTIO_SND_S_OK:
 		rc = 0;
@@ -227,9 +237,33 @@ void virtsnd_ctl_msg_complete(struct virtio_snd_msg *msg)
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
 
@@ -243,6 +277,20 @@ void virtsnd_ctl_msg_cancel_all(struct virtio_snd *snd)
 	}
 }
 
+/**
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
 /**
  * virtsnd_ctl_query_info() - Query the item configuration from the device.
  * @snd: VirtIO sound device.
diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
index 7f4db044f28e..d917435409d0 100644
--- a/sound/virtio/virtio_ctl_msg.h
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -68,6 +68,10 @@ static inline int virtsnd_ctl_msg_send_async(struct virtio_snd *snd,
 
 void virtsnd_ctl_msg_cancel_all(struct virtio_snd *snd);
 
+void virtsnd_ctl_msg_cleanup(struct virtio_snd *snd);
+
+void virtsnd_ctl_msg_enable(struct virtio_snd *snd);
+
 void virtsnd_ctl_msg_complete(struct virtio_snd_msg *msg);
 
 int virtsnd_ctl_query_info(struct virtio_snd *snd, int command, int start_id,
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 8048b14e6c80..e31f090a0124 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -120,6 +120,8 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
 
 void virtsnd_pcm_msg_reset(struct virtio_pcm_substream *vss);
 
+void virtsnd_pcm_msg_cancel(struct virtio_pcm_msg *msg);
+
 int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
 			 unsigned long bytes);
 
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index 5371f4985fd0..762480363b86 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -307,6 +307,35 @@ unsigned int virtsnd_pcm_msg_pending_num(struct virtio_pcm_substream *vss)
 	return vss->msg_count;
 }
 
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
+}
+
 /**
  * virtsnd_pcm_msg_complete() - Complete an I/O message.
  * @msg: I/O message.
-- 
2.54.0 (Apple Git-157)

