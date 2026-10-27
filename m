Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144638;
	b=NiMlILUP3ug8TXjELALXWu6EdhuLYuBNGA0AT5FooeIiPUfOLZv0ycFnW86WeGX14X9u
	 SK5kNZFlQYuk7gev3J+lddSCUDzytUobqQ5/dVNCKXYCNUjdF1gdmkWivu6QiWzx8Dw9F
	 5snynw3PjiZVoujPGnC+W2irL6HXVwP1/XyxRhI4K6ut3v0dlXhlNjr85Ptc4q9hnholG
	 UiX3jgLWPE7SIfU9L2yT41vO4uDKDS250X6LDf91vXLDQFK1jMkfvKh1D5Dh4EBP2U8xI
	 HxvMjIviCUZMbxS1oIsGC8Y5r9HWyXQrs1rx39EKEKAPxpYmXCGdzvsZSejAHzCxlDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JhpmC/Uc/PbS3eydMZOwQvVnE3o7hoZ+spCQpzSOEEE=;
	b=UQieL4ZJZazAUAEQoJ8W2lQVObKNgGT1s06+oU+mchZQpFZgS5JbzcIHWFwLM0ab2DXd
	 Tmp8S17AnrfPUPfvBnajuVH55Vz6+MZPlpG9SznS3ytwzWfXq75pgemvl/QZH7cBlRfar
	 awLmQKDT8UYzw+7qVgTYnjhH5rjuqPYpTdQDIL5mXFgwHc13WjN5rPH7Gvi8rOf+gls/u
	 4bxbT4ORRiMWTttOrVnmXDt6hANAk+AUbxfx5FrZcqU4Bs/TQB78u6kw+IMYvaN+id2IO
	 EU5GUzUIFg9qZqhtKhKDBdpWvWy2qXkgg5aQL6fWCWWu1PxUO30X3VI9NKpuX6NSUwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v+0PbyKC;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C5606A324
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 23:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA6C5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v+0PbyKC
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a06c60065fso365102b3a.1
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 16:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793144637; x=1793749437; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhpmC/Uc/PbS3eydMZOwQvVnE3o7hoZ+spCQpzSOEEE=;
        b=v+0PbyKCdpMetVXM1hLb3rV0uVElo31WYIj26r7ugiwry1eSsnNyeB8+Wu5hJBzmv3
         d1tBPG5/U/9yoBwuvZfYm5XgIDNK6zAyu/q3YxtPOu/T0f6MAm74ZvddSqL8uX7KFKbt
         m3KSzNMKaKKRI5K0IFMeoMoRckcxPMPJLr3BJuAWwL5OeNxSLzuWhbXwn7XRANeTvcHG
         SaGxB/DrRW8yvbZDAwpfDI/gB2XjAcWfY77J+gGJ99ycu3C+kRt0WEz5qkiew+kqEfD5
         Yz4YXRdhEaw9wjNrrXJD1JIRYcBpF9MBDLeA46zvpFPKsbRKdDnQc//W8Z7weRJ4UZ3x
         SPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793144637; x=1793749437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhpmC/Uc/PbS3eydMZOwQvVnE3o7hoZ+spCQpzSOEEE=;
        b=TkdGkealm97nKxYf/lpeLgvV6nLjZsf6a5jjmJoxe3f69uPGYS4dg+gX8b0PZcZbDc
         HfvtwcupVbrmththGzji5/XvKa6vcARMKA2i06xtfpZQe1w4552aH+Ei8ybV3YM6mnCF
         Zvq5SM8HF9lKCWD8qRWblylULWR5B83Z8Pr8QkpsYkQ4Q/L3wn1H37XTgGyhHI3wFnPE
         0df9vffgqn7y2UAfyqw1tklj7u4cUpkhiP7QCfCTTs+n4mBmLlHLGkmLwVSwcMvU0JBt
         gT4MkvVy0mgFGbrSYpZrp0nMneinljDVr6lPqOIwHNd2GkNKrkUYBQHhoY3BCpv5Rjn0
         UUMw==
X-Forwarded-Encrypted: i=1; AKwUvBzNm323Fmffy0rz/q2QKBi3PdAbZklBHhVomCwyOVCKfmo1jGOmgIZFoVUIINEUzsULdB93hlgHu2oVt9n+fg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ51NGiR6Eqe8xoQDWfsE8423j4B8/cJxrihXpFtiq5i6bSGReK
	CzafS1rrbYrH9c2Pl7Bc5V+VQYfuREIFbwWq1Rl7/S15NGHFYFcK6Q3b
X-Gm-Gg: AYBFou2IRUshAJFH8Cxzv6DdHJYCaxIN230nw6ysiAYSUv85GQVXSJwYzNLlZAvxOxB
	mLb1ksPCbwBUHFnM2KaNeGJRuxH1rH408v/ktCwEKynFU7UcGvJH2Cd/O5/Hj/0drZSGr54axoR
	JU3sTCGU9rMiw3OMJu70/yYEldNyT5q6n2aZGNxgiWx4Mho/2IvscWT052nfMbMr3WfOcFWa2AH
	pAO8hW+dKIAESYcExfGlSzxela9E97WmlqcY4Y2RX4S1XFAmjzoZLrLB5cUZfSeNKkSlYijDces
	Xw17OeOKJzjMHzC9dllkE0sI+MUNqyJIpeWkO1Q8IEEzTsR2xk9OU5eeFzhvXUhwTC4aD5Tut6z
	snzLiBBK9y8CKfHCIY8FdlFp5rKL7fXJiwoqe6MdIU6q8SxLQgO0hOhpjdUGE5X+aAc57X9Ywvp
	w9X8eh3LDRqNqWPXYSTsfCQzIZEvT0NMvrTbY/UTPCOuKvGddq1WvyIGcgt5gFdYEH05Vc6RUqn
	MgJA2aiy1xYe5reSBQ6hGX2zatDkIKbUTxSGNC3fE9tepoAHf+Ny140gzyrLKYTaLLqsIuBjuek
	hpwZW/Tc9KyRYRq7Zi24GIH2M3QU0xhCv5LNAwO0mozxvKUTgSRE07tF3TBcYVkpye9HSWQNdNr
	wPMl3C/+ANmKEiWUzlQj5
X-Received: by 2002:a05:6a00:f9b:b0:8a0:8848:8c6c with SMTP id d2e1a72fcca58-8a6e6efa326mr537702b3a.12.1793144636918;
        Tue, 27 Oct 2026 16:43:56 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662b9f5sm542507b3a.21.2026.10.27.16.43.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 16:43:55 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v5 03/11] ALSA: virtio: Retain queued messages through device reset
Date: Wed, 28 Oct 2026 08:43:26 +0900
Message-ID: <20261027234334.32551-4-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027234334.32551-1-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
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

