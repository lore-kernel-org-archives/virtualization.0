Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7457A3321BD
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869444; cv=none; b=rSymu/1nYvCy2el369VZqw2e9Gw/bqLAcm5pHz0q+d15gAC2KkTkLOuBGF9O5rWtQ4Ub3qxet0SLOkREM3ll9bIhR9f+eTdthgRO1rlRvHieKTM5hVyCckr2zwHP5FIILYAbmFUhdfPUgGIffT0Ssf6tP2zc4SSEEMc6Rtsjgok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869444; c=relaxed/simple;
	bh=KcFlavboTGzQdx+SFgUh+a4o6emzU3fjZ0ClZo866qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ackYy/uMHzy/y/kFTjUzsJ6n/KfYmWDXJr0fJn2WqTWWDnxqL0uKBiNJRqDpBwf/IxS32MC8uGn+8aTzW7IVZ911u90WNeGt/52auzpYw/2SsdNpFjo6S2qttEiIvwaWVrtiI5CzIBsHUNnYZcbD2oXpm6NaPYiKrBZkONdLyYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWwD1Hrg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWwD1Hrg"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e7006bbf77so13884315ad.0
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 22:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791869443; x=1792474243; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sFTdq2AdFaWp+a8LZGReJeGWYdMQaatHWPNuzNn9a44=;
        b=UWwD1HrgTOQcQ0slPkh+6ZXWgSySl3IGazQf7gl6zpJFIqaLj1zXd+RrF9AggFNm5s
         /qHzDaY1KlzSAhbHbTPZ4/SWayJTrtvPNWP4CU3efLq/ot4OeOoYfcY7ylJuO5fZnAn5
         fDmFjZEicCCPejWlL/3nJN4UK1F2yLl4qe8PQAJL5cgLEZNEIr4cP6mfPwLQ1gEQwSPX
         Z6eAgWmqy1lhdVuXw7hcbYEjPvVbV0o5bCSlSAugwbMvy/XrR9MiRitScunrg7yJmiGk
         Dzk8f6NpfyYDkaBRkCGSG9f/bGCExXqvABnLcueISDTgK2aUDCX7Cp+MfKBKfHcx44OD
         uw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791869443; x=1792474243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sFTdq2AdFaWp+a8LZGReJeGWYdMQaatHWPNuzNn9a44=;
        b=bCyTmOvKr+gLiWopkljSe49FAdazkKg9UJk4kODEjjTO4ZcgY8WXFZwbrFbKVTrmw5
         uoxrawcQgqfoXkf4BPG2bBeNrA7fKpyPVkDwPD1ly28kFcQW023KNHkY7xwMPf8ilSOQ
         HSHqJYufYAtfFDCRORjD+pSrhb5ObCfBDdQjwjML8jHyGlhVarJl4OIPBP2Gjlzy95mg
         m2/OB5qckxu9IubJA7XbZA4fspE+Rmvf5vAIJY+5Ll1JUDoffpFcCcuDjL5nIXB3JqEd
         fcw0K0jQWvftDCe/2YvZM2+fxRhKOggXWn5oe+8atg48qNUuZk3C8EEH1ZoWp+5esLTG
         LS5g==
X-Forwarded-Encrypted: i=1; AKwUvBzXXxV5ykA769jUTf87s76mecGXGdSb9SV+D0qdOmRJvDu1PGgtItaZfFPOdThlyVpkWlkMDZLgOZ9orD2+/A==@lists.linux.dev
X-Gm-Message-State: AFq9FYKR1/pk3z4YXY2owyvTACw6h9MrcVgKsfOROXRnpHvxHrkF5jiA
	sHSjBOJSzQP8Yo+D3JfruZy7dPjM7rXYDodVIoahtgCIcpX7mkrEpyqS
X-Gm-Gg: AYBFou0gN7GWDPpfP2mMXMS6Fzmx4ArBWUrbUXbyB2SJOrvuAMM+4k/gkTBWUEXCVHy
	zhvq58kOg57fZY1V6u/HvEUnhJGw7S6ijgwje7wPdnvvllD6OE/kSg2ixg0Sfxk47DoM2Aq4Rgu
	bYZgDYWTjX9bjt0xVEwCMUkhKWAHsqVevc5cI7gq+A207N3M+pHSxn+MctOfoyJV4W0arDvcB3w
	kry8IOMmJHolBHxnKYmuXy4/99mN9i+05W6xLefxrlPJlsef63zH0kbqqQVsL7AF4kQ4llkjfOc
	S4TjTcsRjquSqXZoiJAPsm0OdF12cJo7941yotVH7hSMoEw5LRUKoVvxZeO4/KdBrRewheEDR+R
	SDr7xWvEtK7YZhST9spxRHmrJGDCKuuGT2lUHxkHMf+wQ8o1eunluPjSG/p1O1gWsNBraFvvQCD
	X8xYjedMx+MmUwyY+u/KOmUTuq9+2ZKvupdGedbx0t/PmmwW5yNWuZPRzlNmvKa0phMofJ0ovxm
	dgk9d/h848+vIxQuKRg9koG8ubBwQkHZN9t8NanYbd4VxOSBCKVU/fBfTlgpl+pnkusIYpuf+sN
	+JxktmtCBcGFv9iX
X-Received: by 2002:a17:902:d50a:b0:2e6:943:39df with SMTP id d9443c01a7336-2e842bc7e0bmr94618825ad.25.1791869442718;
        Mon, 12 Oct 2026 22:30:42 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cb6sm50820915ad.60.2026.10.12.22.30.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 22:30:42 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Takashi Iwai <tiwai@suse.com>
Cc: Joonho Lee <mynameisjune111@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] ALSA: virtio: Retain control requests through device reset
Date: Tue, 13 Oct 2026 14:30:24 +0900
Message-ID: <9d5a0ff360e66bc4ddd28aa790d617edc875e20b.1791867377.git.mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791867377.git.mynameisjune111@gmail.com>
References: <cover.1791867377.git.mynameisjune111@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtsnd_ctl_msg_cancel_all() currently completes and releases
pending messages before the device is reset. A sender can then free
a message while the virtqueue still holds its token, allowing a late
completion to access freed memory. Sending also notifies the device
after releasing the queue lock, so teardown can reset and delete the
queue between enqueue and notify.

Gate new requests and mark pending messages canceled under the queue
lock. Notify the device while still holding that lock, and retain
each queue reference until normal completion or post-reset cleanup.
Normal completion wakes a canceled sender after the device returns
ownership; cleanup wakes remaining senders only after reset and
virtqueue deletion.

Keep the control queue available through snd_card_free() so close-
time STOP and RELEASE commands can still be submitted.

Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
Dependency: apply with patch 5 for control payload lifetime protection.
This patch retains the message and its headers; caller-owned payloads
are addressed by patch 5.

Validation: ARM64 W=1 build and source-extracted ASan/UBSan teardown,
late-completion and cancellation tests. The final QEMU/KASAN reset test
covers the complete series, not this commit in isolation.

 sound/virtio/virtio_card.c    |  6 +++-
 sound/virtio/virtio_card.h    |  2 ++
 sound/virtio/virtio_ctl_msg.c | 61 +++++++++++++++++++++++++++++++----
 sound/virtio/virtio_ctl_msg.h |  4 +++
 4 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 6f35276416fe..ed884327bb0e 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -349,13 +349,15 @@ static void virtsnd_remove(struct virtio_device *vdev)
 	unsigned int i;
 
 	virtsnd_disable_event_vq(snd);
-	virtsnd_ctl_msg_cancel_all(snd);
 
 	if (snd->card)
 		snd_card_free(snd->card);
 
+	virtsnd_ctl_msg_cancel_all(snd);
+
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
+	virtsnd_ctl_msg_cleanup(snd);
 
 	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
@@ -385,6 +387,7 @@ static int virtsnd_freeze(struct virtio_device *vdev)
 
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
+	virtsnd_ctl_msg_cleanup(snd);
 
 	for (i = 0; i < snd->nsubstreams; ++i)
 		cancel_work_sync(&snd->substreams[i].elapsed_period);
@@ -412,6 +415,7 @@ static int virtsnd_restore(struct virtio_device *vdev)
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
index 6433c870f271..3ad1e1e1b205 100644
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
@@ -227,9 +237,32 @@ void virtsnd_ctl_msg_complete(struct virtio_snd_msg *msg)
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
+ * This must be called after virtio_reset_device() and del_vqs(), when no queue
+ * callback can still access a message.
+ *
+ * Context: Any context.
+ */
+void virtsnd_ctl_msg_cleanup(struct virtio_snd *snd)
 {
 	struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
 
@@ -243,6 +276,20 @@ void virtsnd_ctl_msg_cancel_all(struct virtio_snd *snd)
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
-- 
2.54.0 (Apple Git-157)

