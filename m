Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923639;
	b=yQxKLpsdUFbzk7bKze58Lwnp1OzEpNB2zmT79K+3mZYrTmaVFSusNGtj7gjEnr9L1fvT
	 f2rQ68occcPS2vPiHY1bBIa45KZI8RKB4pfWpjV+CPpB6B3Ix3wwXcy0bzUVY8iDOQ4R9
	 e0+PYjyKybTaWhfwSltbKWrCSbaR+YLomP31Tmu+FxPbqMZ2uRkF1Vp/z3p65T2lQC7fz
	 +6eKEVtU4tqq9uKKH20ISRdAG3HNTJq1M6eMKQ7gw2lqzv+wtHzMAN4HRTsOWVAiEaHXJ
	 Bz5ruanR3bjgO5wX0LOKwDYegPN/vZCdd9vN9yphpjOVXq+QQSYuTeVoAuGTjEhD4cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hA9whqWWbV6K20gHw6KCXT5xEkMWnuiSkLAw9Y5Ct34=;
	b=yvFg0maqQGydsazOLIZfR16rqV7Rj/MFnE/7zwhP7CptWEYkx8PFLt3sSoHQTqMIgKD/
	 vFXDBBw7xPdwvxMRb5/BNLt0icIO/si7nmJvEIva88SAF7zJ3Ro5y9uRE9E8zrBNRdGCt
	 leS5yJ299Gh/oTF5UId2Qm65sRy0xBoKRJX1rMD/OLzy46d1ecwmaFQKIf6rvAUGidtAX
	 ViucX7MySfWPnebPmHwE+URio3+rcF789s6+EAUf03tHnip5Trptj17ZAKWjfFBzEogQ8
	 8inAUOtdJP3NmIpFwgERej4BoQbXh5j0nXBHCbMRWJ+cf3QoKfgZoHEfG1YdSVbKQlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xb6US6jX;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE659606A333
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE659606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xb6US6jX
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36a1947498bso239510eec.1
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 16:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793923630; x=1794528430; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hA9whqWWbV6K20gHw6KCXT5xEkMWnuiSkLAw9Y5Ct34=;
        b=Xb6US6jXHQS47BKrz2HV/KJktWkD9Wqa1kGQcQ/xJ8zAai79On3yfhMrgJM+OrVai1
         FYM75VSE+8UXNeBPPe1tcMu7A+RVDUq9PaNfp0dB7116SRsDTKDRjlqB+vE3of265kxL
         4WgMGESLZCPeHaqKWFrCZAFj7qwvX2hBlzpb8Y3PnLvqELo+bIKB035OyNuG49Wc/qQ2
         iHazAwUxqvAWTGZv8Q8fqzhsrG0gKKRcL2JslEAkeKxeuhNgWYMNDJSaO99SrTS4lURp
         GMzejF0vKmCJok2gl6AUHqzhrHqVEbzl9LGesKHdPfr5kuJ4vvVi5/0F4bunupHIDxtZ
         f+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793923630; x=1794528430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hA9whqWWbV6K20gHw6KCXT5xEkMWnuiSkLAw9Y5Ct34=;
        b=vZL5EzzRyH7PZEx831ER+StIjgG88DZgJxtMD8jEhvIZJNmNdD1zUlcPrHdOLAxeJX
         NfMPAV2F/8Tz6cv6idPVY0qf0mDi0QX1bgdc3LHGOLi+KSc0c0TX55yCjLv2TzTdQNNc
         C50NsmXZTiukcSu+S/aKDhj541Y/4ZNttFsBuRNzluLrq05EZiBGNqzd0ApYf+2wbxAj
         SntvInq2OORGgVD31g4T9G00Dxp9mwiXtWOUQ1lRqu0XJ8HNit4sftSLeHv4nIcHAp2B
         Y0ClnPY4ei8BxMNLa0XfOnWVMVx6398VdHBYlZzi+CU1U8KI71bm1Hc8kqywia16gPTD
         QW/g==
X-Forwarded-Encrypted: i=1; AKwUvBxWoSBs4LCE8X9bAJIECub7/gFib+R5U6Nwy1i8VhxwJ7LKrV5pSBmZUpbE6xRNKEm9koWHHCrhlUFimJ0ukQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8UKAeJ2fWfr7+EuDJgf7aEv+ayrMZlxjSGPgt+aVFqDJu3Z9Oo
	opiC/4UYTz1npnmXC3I8zLMhY56e7XxX5SpaOF+puZY4aSszNgGt9iYP
X-Gm-Gg: AYBFou1qWG8Ns0iWDnhowQUPla3mDWOIJCUJNr39dmAjFNMBHgbZDmRhA0cugginiLs
	geDR5swuYjMlB4DTb4jdVUz05fXWGuC01thZj+MT7ZJVgqwS5s55gb+RVXjE3PDvEfRjN3TAkFq
	ZdC6Hz05ee49+RBJjOX2ZkfX/K3cQ2UNNOPPmjiHE3iRpzHXzl35T8Rf9uCvwSz6AkfiPIoiiII
	VfyQGh9e59wMHe9CA+vkz7kLPDUbL0k6QT96aw9a/KWGKuAlsj0uVPWFXm/r/+d/dYqjKJhUmN9
	fpguHPhoFDnJBWJetKZTc5rnhdPzXSEdyJSQG+XtBbh0xd31SN5O6PIPcEpbRFJIyt4+YH7EX62
	8WEG+gMb0inFO8tAx9z7ECAppEpilERLlyKq2flmORVF/bBar33vQzXY2m93i3ibevhzd6sNsQy
	He7/xN+aumIxGwMSdXNzh1XyR4k16ietA8GsBKjRv+9l4MKh2wLQiuEjEcD+O0BMz2LAAE5BEU+
	iwokmnRj7jc3eITFryUSLqjkMUZf/jnhE0xHMuezTC8kJZhhoW07S+zjexB/onTz/CSSQvb5bhV
	qcCU1s0exxwP6GoL/PWJlXIuwn/s1g6VBWIQab1vzXqO71qzFO2l5fQlMprbzwR8j3LQnYZauwM
	fB5NiFJWSxzb6LuYUMxEhGOJePfrwXEJEShv2+Ks0OQYwP8M=
X-Received: by 2002:a05:7022:ea46:10b0:152:3812:496a with SMTP id a92af1059eb24-1b25d3769b2mr791820c88.43.1793923629512;
        Thu, 05 Nov 2026 16:07:09 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4e079esm371165c88.19.2026.11.05.16.07.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 16:07:08 -0800 (PST)
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
Subject: [PATCH v18 06/12] ALSA: virtio: Retain queued messages through device reset
Date: Fri,  6 Nov 2026 09:06:38 +0900
Message-ID: <20261106000644.20460-7-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106000644.20460-1-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
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
