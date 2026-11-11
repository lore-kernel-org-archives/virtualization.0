Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355599;
	b=fOKM+C3Y6wLU7aTpbiODfjLtdtaYWASkam1+4wrL7jWgGPPh2jbRgdaM9t37pFH0pH3Z
	 M9yQaGRKhDqitsafOuE4RYHJ9k0eS3b2AwI2kqZVkM9LjsZjQJsDKxdV5/YOe1kSaX7WH
	 XqKzBq2nrW6fqOuyTKAhH9p/5VqiCRaqtBIR2dk+Rvm/WvitBOZkwWywKHXbkqOeMbQCI
	 RWpLKuJY8kC17GP9qyKnsdgIiSzsG5O8Mynf/Wycg5ECTC9DSUa+y0DO3jtzdjTTFeOsC
	 0Jzel5rjl6kHstPipNafOgBlVK+RdkRksSiBZu52ti9jM1iX894qjLZhcZF1uOSN4iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jsF0g6/jL+UrPtAcAK77KH+OE8/e35qS1mJtx6cJFDs=;
	b=fe58UnQo0gNJKZpakUwBvv3vZ28bQvck3a/hVmo8Tm+X0Sa86ppNaGQIFdtnVLL/5mC4
	 Ov82TH9ydXrlG4pfnpmY5Aok4OQCIrZxOEIqTL0fHvjpUoK7TJy1Mohs0CRPpvRoiwyXr
	 62NRdHuPrpkA38+EriLlfnDHK2oR4OgQeXMJ2fqoKGs0oY8yGkKBHhcbJx0vaUCF6h8Sm
	 jLAGYa2volBnqlKbBMU5Ufc85GLBN/VjuD7T8GO9a9lOcuwkqgJHDW+QtLokg/yO/4x3k
	 IuKIw2F6z4HvA9h6dLuhfzdo3z24fxMwbfvMJSzIhXcBRonbDULcSelH2PU7l/Kfwdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QGOuPdmg;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FF60A263B
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 892FF60A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QGOuPdmg
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso1351127a91.3
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 16:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355597; x=1794960397; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsF0g6/jL+UrPtAcAK77KH+OE8/e35qS1mJtx6cJFDs=;
        b=QGOuPdmgV3LJfFif8rfe+Uoygov6fNK8fiGADyKuI+cuzLx2Lx3sI/1jVbZrwXuSc1
         hQ81ETpMsH7JZ1H3M9xdYmaDhmXVxRWRE26pGBWt+dXs+aXD8RDD5LBFXdL0OXnGxIPs
         0TmgWmgZ7qpxPuw7TsuZbUWhNikaSqdvlNusIkTisJu1v/32Wd1fk8ejOj+bR942mz0+
         Jy4y0bbAFXzEhjAVFa30AxmgZU1N8GE+ZD9uE8K+9seLHANT9MIs7V/B9h5UHp+kTcU2
         QVnuAu1mDJ3uilh0lndwmWRvxoglwAeIIpL+bvwrXpdPOcmxNAnq2Ni10UDvPVkTpHhD
         ASeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355597; x=1794960397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsF0g6/jL+UrPtAcAK77KH+OE8/e35qS1mJtx6cJFDs=;
        b=cQDGUeieja18nyq8/NwVVfLTm4HiAYbhGTCBULJ4X4KswTwj6IWvygUgOlPwM4Lbqc
         DM+ni6DdBN5afNqTyXBfQKaJInrE4uKXrUjHBPfMyEMqDxzRz9qn4K72F5xUVm3lIw1/
         ea3duOR8aGxhqM2lqqqtZGwvlkr3BeYRXtCgQBlxLt04UM0fskyKSuGKm17xmZMwphkM
         aTkXDU4ezjIkNekHPTiG93eyRyXraVVZvIYxPxFcaKbirTLhT7mpzm+Qch5YViwCUtMN
         KZouvITtnDaIOn9SIcpZZvowhFkKO5uuenBYVFXHWE+VpEdNJl4KtAT9p7goEeFhQgsI
         YO2Q==
X-Forwarded-Encrypted: i=1; AL+hErHTyMq3Kf+u2lm2Jw+NouYcmfmDqFRydsiVS+uHugH9Lm+YvR+SflZmfMa6kWlt5FGfyEY0W9xpPLkQbWU6HQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9gCBVH+nEgFv2meRp/OfDPxLsjJUV5YDYrq6UZQ55fwEYecr/S
	tGhklVfwfbpPOOfWkChdrYP71LikwEwGCHM7i/nr8zIYwMpfHHfiBWwX
X-Gm-Gg: AYBFou27XzLK9gMiWuPHRmQ2m6fil1B6rNs+NA/mveWl/vU8adwyWiA97wthwdCCtDm
	u9mc292GyrPJy7OR8EpEVhloVMC3toLMcIhZYPbzRDJosbOXY6RZAUEBJ2kF4lBOymCW+vA+ViG
	u+Zz2W3ax/udAKZi118rjMYiUdAu6Gjukei/Vtv24jP7gEiDzolpoemEK12INg+oheE99kwTKAG
	CkenjfF69pAF351seVtUApAzKs2x8mhkvzTwJVOkU1MdJUDrW4nBOzI+nq0uaUcx2mDNG42NYp0
	FIFxE8zemjVVF8d6mp5sUwgwPczQktcpbtI9eL43rzaqVd6v1NZBaF1rdLnng2zQLROoZkUMkF2
	6zrke8TwDcKekEeeQEFWOlQVLaZBKqvNPidD03ehdjZGC0iksD9AoO5gJ4Z5IrEkdOVmWRoWcmk
	Bl0Dwa8Vu+ih6rUucFztn+v2R8129/glRYDHzyp9fxzKG8VahCFNkmR6B5QD+8jpfB7L0fQiDAO
	pc8GGQLT6SKZvof84qgFxzQTxhiUBdPqf2KIBcVN2RudBEAETRBUfp6SIaA3irbGYMw63FICZtI
	iO+3v19MYuHAi8CEZyMjtF79spXxE6cvPZ3DRt4yleFYveeFlCSRfhF5c/B2LZer6gyJoMKa5WW
	qtJwkncSrCm84M20DLxXQoxqB/zpSpNs+nc233jFBMHLsduLQ
X-Received: by 2002:a17:90a:e18c:b0:3a8:211b:6c6f with SMTP id 98e67ed59e1d1-3b182f8c3b2mr599862a91.67.1794355595996;
        Tue, 10 Nov 2026 16:06:35 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm474361a91.4.2026.11.10.16.06.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 16:06:35 -0800 (PST)
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
Subject: [PATCH v24 12/16] ALSA: virtio: use request-owned capture and serialize recovery
Date: Wed, 11 Nov 2026 09:05:39 +0900
Message-ID: <20261111000543.28550-13-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111000543.28550-1-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
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

Receive capture into request-owned buffers and commit completed requests
in submission order. Append actual frame-aligned payloads contiguously
to the ALSA ring, preserve a valid STOP tail, and retire empty requests
without inventing data. Bound occupancy and report overflow through
XRUN.

Replace the direct/staged split with a common request-owned capture
path. Remove capture_staging, capture_allow_short and
capture_allow_empty. Packed status decoding and RELEASE/reprepare pause
are still explicit, default-off compatibility options. This changes the
default RX memory and copy cost.

Serialize control transitions and preparation by generation, keep
payload and DMA ownership separate from the ALSA runtime, and stop
admission after uncertain control completion. Preserve linked prepare
and paused-error recovery semantics. Implement separate capture and
playback RESET paths. A paused capture RESET keeps the modulo position
of the last committed sample instead of rebasing the logical cursor
independently of RX storage. This preserves the ordinary capture
reset/reopen sample oracle.

Capture DRAINING uses the progress helper for every pending
notification, including a tail crossing a period boundary and a latched
error. The normal period helper skips capture DRAINING, so selecting it
by period count alone leaves the cached pointer or XRUN state stale.
Running capture and playback retain their period-timer behavior.
Allocation and completion retain request buffers until device ownership
ends. The new default copies RX data while queue and stream locks are
held; resource and worst-case latency qualification remains outstanding.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_card.c    |   58 +
 sound/virtio/virtio_ctl_msg.c |   58 +
 sound/virtio/virtio_ctl_msg.h |    9 
 sound/virtio/virtio_pcm.c     |  103 ++
 sound/virtio/virtio_pcm.h     |  148 +++
 sound/virtio/virtio_pcm_msg.c |  577 ++++++++++--
 sound/virtio/virtio_pcm_ops.c | 1895 ++++++++++++++++++++++++++++++++++++-----
 7 files changed, 2486 insertions(+), 362 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -369,6 +369,23 @@
 	struct virtio_device *vdev = snd->vdev;
 	unsigned int i;
 
+	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
+		struct virtio_pcm_substream *vss = &snd->substreams[i];
+		struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+
+		guard(spinlock_irqsave)(&queue->lock);
+		guard(spinlock)(&vss->lock);
+		vss->reset_epoch++;
+		vss->resetting = true;
+		vss->prepared = false;
+		vss->preparing = false;
+		vss->device_running = false;
+		vss->release_required = false;
+		vss->control_uncertain = false;
+		vss->capture_reset_observing = false;
+		vss->xfer_enabled = false;
+		vss->suspended = true;
+	}
 	virtio_reset_device(vdev);
 
 	/* Deleting a virtqueue does not unmap its outstanding descriptors. */
@@ -388,7 +405,6 @@
 		queue->vqueue = NULL;
 		spin_unlock_irqrestore(&queue->lock, flags);
 	}
-
 	if (snd->vqs_initialized) {
 		vdev->config->del_vqs(vdev);
 		snd->vqs_initialized = false;
@@ -396,6 +412,30 @@
 }
 
 /**
+ * virtsnd_cancel_period_work() - Drain PCM work after control cleanup.
+ * @snd: VirtIO sound device.
+ *
+ * Must follow control message cleanup, which wakes work blocked on a PCM
+ * control request.
+ *
+ * Context: Any context that permits to sleep.
+ */
+static void virtsnd_cancel_period_work(struct virtio_snd *snd)
+{
+	unsigned int i;
+
+	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
+		struct virtio_pcm_substream *vss = &snd->substreams[i];
+
+		cancel_work_sync(&vss->elapsed_period);
+		guard(spinlock_irqsave)(&vss->lock);
+		vss->stopped = false;
+		vss->xfer_xrun = false;
+		vss->pause_restart_state = VIRTSND_PCM_PAUSE_RESTART_NONE;
+	}
+}
+
+/**
  * virtsnd_remove() - Remove VirtIO and ALSA devices.
  * @vdev: VirtIO parent device.
  *
@@ -414,12 +454,13 @@
 	virtsnd_ctl_msg_cancel_all(snd);
 
 	virtsnd_reset_vqs(snd);
+	/* Wake PCM workers blocked on control replies before draining them. */
 	virtsnd_ctl_msg_cleanup(snd);
+	virtsnd_cancel_period_work(snd);
 
 	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
 
-		cancel_work_sync(&vss->elapsed_period);
 		virtsnd_pcm_msg_free(vss);
 	}
 
@@ -437,16 +478,14 @@
 static int virtsnd_freeze(struct virtio_device *vdev)
 {
 	struct virtio_snd *snd = vdev->priv;
-	unsigned int i;
 
 	virtsnd_disable_event_vq(snd);
 	virtsnd_ctl_msg_cancel_all(snd);
 
 	virtsnd_reset_vqs(snd);
+	/* Wake PCM workers blocked on control replies before draining them. */
 	virtsnd_ctl_msg_cleanup(snd);
-
-	for (i = 0; i < snd->nsubstreams; ++i)
-		cancel_work_sync(&snd->substreams[i].elapsed_period);
+	virtsnd_cancel_period_work(snd);
 
 	kfree(snd->event_msgs);
 	snd->event_msgs = NULL;
@@ -465,6 +504,7 @@
 {
 	struct virtio_snd *snd = vdev->priv;
 	int rc;
+	unsigned int i;
 
 	rc = virtsnd_find_vqs(snd);
 	if (rc) {
@@ -475,6 +515,12 @@
 	virtio_device_ready(vdev);
 	virtsnd_ctl_msg_enable(snd);
 
+	for (i = 0; i < snd->nsubstreams; ++i) {
+		struct virtio_pcm_substream *vss = &snd->substreams[i];
+
+		guard(spinlock_irqsave)(&vss->lock);
+		vss->resetting = false;
+	}
 	virtsnd_enable_event_vq(snd);
 
 	return 0;
diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -23,6 +23,9 @@
  * @list: Pending message list entry.
  * @notify: Request completed notification.
  * @ref_count: Reference count used to manage a message lifetime.
+ * @pcm: Optional PCM generation owner, valid until control queue teardown.
+ * @pcm_epoch: Operation generation captured before request allocation.
+ * @submitted: Request was handed to the device.
  * @cancelled: Request canceled during device teardown.
  */
 struct virtio_snd_msg {
@@ -37,7 +40,49 @@
 	struct completion notify;
 	refcount_t ref_count;
 	bool cancelled;
+	bool submitted;
+	struct virtio_pcm_substream *pcm;
+	u64 pcm_epoch;
 };
+
+/* Bind an operation's original generation before publishing the request. */
+void virtsnd_ctl_msg_bind_pcm(struct virtio_snd_msg *msg,
+			     struct virtio_pcm_substream *vss, u64 epoch)
+{
+	msg->pcm = vss;
+	msg->pcm_epoch = epoch;
+}
+
+u64 virtsnd_ctl_msg_pcm_epoch(struct virtio_snd_msg *msg)
+{
+	return msg->pcm_epoch;
+}
+
+static int virtsnd_ctl_msg_enqueue(struct virtio_snd *snd,
+				   struct virtio_snd_msg *msg,
+				   struct scatterlist **sgs,
+				   unsigned int nouts, unsigned int nins)
+{
+	struct virtqueue *vq = virtsnd_control_queue(snd)->vqueue;
+
+	if (!msg->pcm)
+		return virtqueue_add_sgs(vq, sgs, nouts, nins, msg, GFP_ATOMIC);
+
+	/* Control queue -> PCM lock serializes enqueue against device reset. */
+	guard(spinlock)(&msg->pcm->lock);
+	if (msg->pcm->resetting || msg->pcm->reset_epoch != msg->pcm_epoch)
+		return -ECANCELED;
+	return virtqueue_add_sgs(vq, sgs, nouts, nins, msg, GFP_ATOMIC);
+}
+
+/* Caller retains a reference across the synchronous send. */
+bool virtsnd_ctl_msg_uncertain(struct virtio_snd_msg *msg, int rc)
+{
+	return msg->submitted &&
+	       (rc == -ETIMEDOUT || rc == -ERESTARTSYS ||
+		READ_ONCE(msg->cancelled));
+}
+
 
 /**
  * virtsnd_ctl_msg_ref() - Increment reference counter for the message.
@@ -293,9 +338,9 @@
 	if (snd->ctl_msgs_blocked)
 		rc = -ENODEV;
 	else
-		rc = virtqueue_add_sgs(queue->vqueue, psgs, nouts, nins, msg,
-				       GFP_ATOMIC);
+		rc = virtsnd_ctl_msg_enqueue(snd, msg, psgs, nouts, nins);
 	if (!rc) {
+		msg->submitted = true;
 		notify = virtqueue_kick_prepare(queue->vqueue);
 
 		list_add_tail(&msg->list, &snd->ctl_msgs);
@@ -315,11 +360,14 @@
 		virtsnd_ctl_msg_unref(msg);
 	} else if (!nowait) {
 		/*
-		 * Teardown must observe completion even with a pending signal.
-		 * Otherwise a subsequent open can retry RELEASE while the device
-		 * is still processing the previous teardown request.
+		 * PCM state changes must observe completion with a pending signal.
+		 * Otherwise recovery can issue a conflicting command while the
+		 * device is still processing the previous transition.
 		 */
 		switch (le32_to_cpu(request->code)) {
+		case VIRTIO_SND_R_PCM_SET_PARAMS:
+		case VIRTIO_SND_R_PCM_PREPARE:
+		case VIRTIO_SND_R_PCM_START:
 		case VIRTIO_SND_R_PCM_STOP:
 		case VIRTIO_SND_R_PCM_RELEASE:
 			rc = wait_for_completion_timeout(&msg->notify, js);
diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
--- a/sound/virtio/virtio_ctl_msg.h
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -11,6 +11,13 @@
 
 struct virtio_snd;
 struct virtio_snd_msg;
+struct virtio_pcm_substream;
+
+void virtsnd_ctl_msg_bind_pcm(struct virtio_snd_msg *msg,
+			     struct virtio_pcm_substream *vss, u64 epoch);
+u64 virtsnd_ctl_msg_pcm_epoch(struct virtio_snd_msg *msg);
+
+bool virtsnd_ctl_msg_uncertain(struct virtio_snd_msg *msg, int rc);
 
 void virtsnd_ctl_msg_ref(struct virtio_snd_msg *msg);
 
@@ -47,7 +54,7 @@
  * The msg_timeout_ms module parameter defines the message completion timeout.
  * If the message is not completed within this time, the function will return an
  * error.
- * PCM STOP and RELEASE wait through pending signals within this timeout.
+ * PCM state-changing requests wait through pending signals within this timeout.
  * Other requests remain interruptible. Device reset cancels and wakes either
  * kind of waiter.
  *
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -310,8 +310,97 @@
 {
 	struct virtio_pcm_substream *vss =
 		container_of(work, struct virtio_pcm_substream, elapsed_period);
-
-	snd_pcm_period_elapsed(vss->substream);
+	struct snd_pcm_substream *substream = vss->substream;
+	struct snd_pcm_runtime *runtime;
+	size_t period_bytes;
+	u64 period_floor;
+	u64 snapshot;
+	bool paused_xrun = false;
+	bool notify = false;
+	bool partial = false;
+	bool requeue = false;
+
+	/* Serialize the pointer snapshot with ALSA's pointer and ACK callbacks. */
+	guard(pcm_stream_lock_irqsave)(substream);
+	runtime = substream->runtime;
+	if (!runtime)
+		return;
+	if (!snd_pcm_running(substream) &&
+	    runtime->state != SNDRV_PCM_STATE_DRAINING) {
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			paused_xrun = runtime &&
+				      runtime->state == SNDRV_PCM_STATE_PAUSED &&
+				      vss->xfer_xrun;
+			if (paused_xrun)
+				virtsnd_pcm_defer_paused_xrun(vss);
+		}
+		return;
+	}
+
+	if (vss->direction != SNDRV_PCM_STREAM_CAPTURE) {
+		snd_pcm_period_elapsed_under_stream_lock(substream);
+		return;
+	}
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		runtime = substream->runtime;
+		if (!runtime || !vss->runtime_active ||
+		    (!vss->xfer_enabled && !vss->xfer_xrun &&
+		     runtime->state != SNDRV_PCM_STATE_DRAINING))
+			return;
+
+		period_bytes = snd_pcm_lib_period_bytes(substream);
+		if (vss->xfer_xrun) {
+			notify = true;
+		} else if (!period_bytes || period_bytes >= vss->buffer_bytes ||
+			   !virtsnd_pcm_capture_counters_valid(vss) ||
+			   vss->capture_notified_periods >
+				div64_ul(vss->capture_copied_total, period_bytes)) {
+			vss->xfer_xrun = true;
+			notify = true;
+		} else {
+			period_floor = div64_ul(vss->capture_copied_total, period_bytes);
+			if (period_floor > vss->capture_notified_periods) {
+				/* Reserve crossed boundaries before the callback. */
+				vss->capture_notified_periods = period_floor;
+				notify = true;
+			} else if (vss->capture_copied_total >
+				   vss->capture_pointer_seen_total) {
+				notify = true;
+				partial = true;
+			}
+		}
+
+		if (notify) {
+			snapshot = vss->capture_copied_total;
+			vss->capture_callback_snapshot = snapshot;
+			vss->capture_callback_snapshot_active = true;
+		}
+	}
+
+	if (!notify)
+		return;
+
+	/* Capture DRAINING needs pointer updates even at a period boundary. */
+	if (partial || runtime->state == SNDRV_PCM_STATE_DRAINING)
+		snd_pcm_progress_under_stream_lock(substream);
+	else
+		snd_pcm_period_elapsed_under_stream_lock(substream);
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->capture_callback_snapshot_active = false;
+		vss->capture_callback_snapshot = 0;
+		if (vss->runtime_active && vss->xfer_enabled &&
+		    !vss->xfer_xrun && substream->runtime) {
+			period_bytes = snd_pcm_lib_period_bytes(substream);
+			if (period_bytes &&
+			    vss->capture_copied_total > vss->capture_pointer_seen_total)
+				requeue = true;
+		}
+	}
+
+	if (requeue)
+		virtsnd_pcm_schedule_period_elapsed(vss);
 }
 
 /**
@@ -351,8 +440,10 @@
 		vss->snd = snd;
 		vss->sid = i;
 		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
+		disable_work(&vss->elapsed_period);
 		init_waitqueue_head(&vss->msg_empty);
 		spin_lock_init(&vss->lock);
+		mutex_init(&vss->lifecycle_lock);
 	}
 
 	info = kzalloc_objs(*info, snd->nsubstreams);
@@ -486,7 +577,7 @@
 			snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops[i]);
 		}
 
-		snd_pcm_set_managed_buffer_all(vpcm->pcm,
+		snd_pcm_lib_preallocate_pages_for_all(vpcm->pcm,
 					       SNDRV_DMA_TYPE_VMALLOC, NULL,
 					       0, 0);
 	}
@@ -517,8 +608,12 @@
 		break;
 	case VIRTIO_SND_EVT_PCM_XRUN:
 		scoped_guard(spinlock, &vss->lock) {
-			if (vss->xfer_enabled)
+			if (vss->xfer_enabled ||
+			    (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+			     vss->prepared && !vss->stopped)) {
 				vss->xfer_xrun = true;
+				virtsnd_pcm_schedule_period_elapsed(vss);
+			}
 		}
 		break;
 	}
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -7,13 +7,32 @@
 #define VIRTIO_SND_PCM_H
 
 #include <linux/atomic.h>
+#include <linux/mutex.h>
+#include <linux/math64.h>
 #include <linux/virtio_config.h>
+#include <linux/workqueue.h>
 #include <sound/pcm.h>
 #include <sound/pcm-indirect.h>
 
 struct virtio_pcm;
 struct virtio_pcm_msg;
 struct page;
+
+enum virtio_pcm_pause_restart_state {
+	VIRTSND_PCM_PAUSE_RESTART_NONE,
+	VIRTSND_PCM_PAUSE_RESTART_CONFIGURED,
+	VIRTSND_PCM_PAUSE_RESTART_SET_PARAMS_SUBMITTED,
+	VIRTSND_PCM_PAUSE_RESTART_PREPARE_SUBMITTED,
+	VIRTSND_PCM_PAUSE_RESTART_PREPARED,
+	VIRTSND_PCM_PAUSE_RESTART_START_SUBMITTED,
+	VIRTSND_PCM_PAUSE_RESTART_RUNNING,
+	VIRTSND_PCM_PAUSE_RESTART_STOP_SUBMITTED,
+	VIRTSND_PCM_PAUSE_RESTART_STOPPED,
+	VIRTSND_PCM_PAUSE_RESTART_RELEASE_SUBMITTED,
+	VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT,
+	VIRTSND_PCM_PAUSE_RESTART_RELEASED,
+	VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED,
+};
 
 /**
  * struct virtio_pcm_substream - VirtIO PCM substream.
@@ -26,20 +45,48 @@
  * @pcm_indirect: Kernel indirect pcm structure.
  * @hw: Kernel ALSA substream hardware descriptor.
  * @elapsed_period: Kernel work to handle the elapsed period state.
+ * @lifecycle_lock: Serializes prepare with synchronous release, outside trigger.
+ * @period_work_quiesced: Teardown owns a work disable, protected by @lifecycle_lock.
+ * @resetting: Device queues are unavailable until restore completes.
+ * @reset_epoch: Invalidates control replies from before device reset.
  * @lock: Spinlock that protects fields shared by interrupt handlers and
  *        substream operators, including @stopped.
  * @buffer_bytes: Current buffer size in bytes.
  * @hw_ptr: Substream hardware pointer value in bytes [0 ... buffer_bytes).
+ * @capture_ready: Managed-mode bytes copied but not yet acknowledged by ALSA;
+ *                 always zero in free-running mode.
+ * @capture_boundary: ALSA boundary captured for this prepared epoch.
+ * @capture_copied_total: Monotonic bytes copied into the capture ring.
+ * @capture_acked_total: Monotonic bytes acknowledged by the capture client.
+ * @capture_pointer_seen_total: Last capture position sampled by ALSA.
+ * @capture_submit_sequence: Next sequence assigned to a capture RX request.
+ * @capture_commit_sequence: Next capture request sequence allowed to append.
+ * @capture_quiet_sequence: Requests below this sequence were queued before a
+ *                          STOP or PAUSE and may complete without audio.
+ * @capture_notified_periods: Highest full-period boundary reserved for notify.
+ * @capture_callback_snapshot: Capture position fixed for the period callback.
+ * @capture_callback_snapshot_active: The callback must use its fixed position.
+ * @runtime_active: ALSA capture runtime buffer may be accessed by completions.
+ * @capture_stopping: A STOP or PAUSE is draining requests already in flight.
+ * @capture_started: Non-empty capture data was received since prepare.
+ * @capture_empty: Consecutive empty startup completions.
+ * @capture_free_running: Cached staged-capture policy, protected by @lock.
  * @xfer_enabled: Data transfer state (0 - off, 1 - on).
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
  * @stopped: True if the substream is stopped and must be released on the device
  *           side; protected by @lock.
- * @prepared: True after device PREPARE and the core pointer reset succeed;
- *            protected by @lock.
- * @preparing: ACK gate through teardown and prepare's core reset;
- *             protected by @lock.
+ * @prepared: Device PREPARE succeeded; protected by @lock.
+ * @preparing: ACK gate during sleeping teardown and prepare's core reset; protected by
+ *             the PCM stream lock and @lock.
+ * @device_running: Native START succeeded without a subsequent successful STOP.
+ * @release_required: Successful PREPARE still needs a successful RELEASE.
+ * @control_uncertain: Native control result requires device reset before reuse.
+ * @capture_reset_observing: Reclaim staged samples during RESET pointer capture.
+ * @indirect_reset_observing: Suppress ordinary ACK refill during RESET pointer
+ *                            capture; protected by the PCM stream lock.
  * @suspended: True if the substream is suspended and must be reconfigured on
  *             the device side at resume.
+ * @pause_restart_state: Device-side state for opt-in pause compatibility.
  * @msgs: Allocated I/O messages.
  * @nmsgs: Number of allocated I/O messages.
  * @msg_count: Number of pending I/O messages in the virtqueue.
@@ -60,16 +107,41 @@
 	struct snd_pcm_hardware hw;
 	struct work_struct elapsed_period;
 	spinlock_t lock;
+	struct mutex lifecycle_lock;
+	bool period_work_quiesced;
+	u64 reset_epoch;
+	bool resetting;
 	size_t buffer_bytes;
 	size_t hw_ptr;
+	size_t capture_ready;
+	snd_pcm_uframes_t capture_boundary;
+	u64 capture_copied_total;
+	u64 capture_acked_total;
+	u64 capture_pointer_seen_total;
+	u64 capture_submit_sequence;
+	u64 capture_commit_sequence;
+	u64 capture_quiet_sequence;
+	u64 capture_notified_periods;
+	u64 capture_callback_snapshot;
+	bool capture_callback_snapshot_active;
+	bool runtime_active;
+	bool capture_stopping;
+	bool capture_started;
+	bool capture_free_running;
+	unsigned int capture_empty;
 	bool xfer_enabled;
 	bool xfer_xrun;
 	bool stopped;
 	bool prepared;
 	bool preparing;
-	/* Successful PREPARE still needs RELEASE; protected by lock. */
+	/* Native control state, protected by lock. */
+	bool device_running;
 	bool release_required;
+	bool control_uncertain;
+	bool capture_reset_observing;
+	bool indirect_reset_observing;
 	bool suspended;
+	enum virtio_pcm_pause_restart_state pause_restart_state;
 	struct virtio_pcm_msg **msgs;
 	unsigned int nmsgs;
 	unsigned int msg_count;
@@ -82,6 +154,63 @@
 	wait_queue_head_t msg_empty;
 };
 
+/* Caller holds the PCM stream lock and vss->lock. */
+static inline void
+virtsnd_pcm_defer_paused_xrun(struct virtio_pcm_substream *vss)
+{
+	struct snd_pcm_runtime *runtime = vss->substream->runtime;
+
+	lockdep_assert_held(&vss->lock);
+	if (!runtime || runtime->state != SNDRV_PCM_STATE_PAUSED)
+		return;
+
+	/* Publish the XRUN after resume, when ALSA can stop the whole group. */
+	vss->xfer_enabled = false;
+	runtime->stop_operating = true;
+}
+
+/* Give capture accounting priority over PCM callbacks that can block readers. */
+static inline bool
+virtsnd_pcm_schedule_period_elapsed(struct virtio_pcm_substream *vss)
+{
+	return schedule_work(&vss->elapsed_period);
+}
+
+/*
+ * ALSA may observe a subperiod tail before its period callback. Keep actual
+ * unread occupancy separate from pointer observations and notification state;
+ * free-running streams account occupancy from monotonic totals instead.
+ */
+static inline size_t virtsnd_pcm_ring_offset(u64 total, size_t size)
+{
+	u64 remainder;
+
+	div64_u64_rem(total, size, &remainder);
+	return remainder;
+}
+
+static inline bool
+virtsnd_pcm_capture_counters_valid(const struct virtio_pcm_substream *vss)
+{
+	u64 outstanding;
+
+	if (!vss->buffer_bytes ||
+	    vss->capture_copied_total < vss->capture_acked_total ||
+	    vss->capture_pointer_seen_total > vss->capture_copied_total ||
+	    vss->hw_ptr != virtsnd_pcm_ring_offset(vss->capture_copied_total, vss->buffer_bytes) ||
+	    (vss->capture_callback_snapshot_active &&
+	     (vss->capture_callback_snapshot < vss->capture_pointer_seen_total ||
+	      vss->capture_callback_snapshot > vss->capture_copied_total)))
+		return false;
+
+	if (vss->capture_free_running)
+		return !vss->capture_ready;
+
+	outstanding = vss->capture_copied_total - vss->capture_acked_total;
+	return outstanding == (u64)vss->capture_ready &&
+	       vss->capture_ready < vss->buffer_bytes;
+}
+
 /**
  * struct virtio_pcm_stream - VirtIO PCM stream.
  * @substreams: VirtIO substreams belonging to the stream.
@@ -112,6 +241,8 @@
 
 extern const struct snd_pcm_ops virtsnd_pcm_ops[];
 
+extern bool virtsnd_capture_packed_status;
+
 int virtsnd_pcm_validate(struct virtio_device *vdev);
 
 int virtsnd_pcm_parse_cfg(struct virtio_snd *snd);
@@ -130,11 +261,16 @@
 
 struct virtio_snd_msg *
 virtsnd_pcm_ctl_msg_alloc(struct virtio_pcm_substream *vss,
-			  unsigned int command, gfp_t gfp);
+			  unsigned int command, gfp_t gfp, u64 epoch);
 
 int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
 			  unsigned int periods, unsigned int period_bytes);
 
+int virtsnd_pcm_capture_send(struct virtio_pcm_substream *vss);
+
+int virtsnd_pcm_capture_refresh_mode_locked(struct virtio_pcm_substream *vss,
+					    bool *free_running);
+
 void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
 
 void virtsnd_pcm_msg_reset(struct virtio_pcm_substream *vss);
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -3,9 +3,12 @@
  * virtio-snd: Virtio sound device
  * Copyright (C) 2021 OpenSynergy GmbH
  */
+#include <linux/compiler.h>
+#include <linux/gcd.h>
 #include <linux/limits.h>
 #include <linux/mm.h>
 #include <linux/overflow.h>
+#include <linux/vmalloc.h>
 #include <sound/pcm_params.h>
 
 #include "virtio_card.h"
@@ -16,15 +19,27 @@
  * @xfer: Request header payload.
  * @status: Response header payload.
  * @length: Data length in bytes.
+ * @data: Request-owned payload for every capture request.
  * @data_offset: Offset of the fixed PCM ring slice for ordinary I/O.
+ * @capture_sequence: Submission order for capture stream data.
+ * @capture_audio_bytes: Validated audio bytes returned by the device.
+ * @capture_latency_bytes: Latency returned with the capture completion.
+ * @capture_complete: Completion waits for preceding request sequences.
+ * @capture_valid: Response length and status passed protocol validation.
  * @sgs: Payload scatter-gather table.
  */
 struct virtio_pcm_msg {
 	struct virtio_pcm_substream *substream;
-	struct virtio_snd_pcm_xfer xfer;
-	struct virtio_snd_pcm_status status;
+	struct virtio_snd_pcm_xfer *xfer;
+	struct virtio_snd_pcm_status *status;
 	size_t length;
+	u8 *data;
 	size_t data_offset;
+	u64 capture_sequence;
+	size_t capture_audio_bytes;
+	u32 capture_latency_bytes;
+	bool capture_complete;
+	bool capture_valid;
 	struct scatterlist sgs[];
 };
 
@@ -212,6 +227,7 @@
 	struct snd_pcm_runtime *runtime;
 	size_t buffer_bytes;
 	unsigned int i;
+	bool request_owned;
 	int rc;
 
 	if (vss->msgs || vss->nmsgs || vss->dma_pages || vss->ndma_pages)
@@ -222,10 +238,13 @@
 #endif
 	if (!periods || !period_bytes)
 		return -EINVAL;
+	request_owned = vss->direction == SNDRV_PCM_STREAM_CAPTURE;
 
 	if (check_mul_overflow((size_t)periods, (size_t)period_bytes,
 			       &buffer_bytes))
 		return -EOVERFLOW;
+	if (request_owned && periods < 2)
+		return -EINVAL;
 
 	if (!vss->substream || !vss->substream->runtime)
 		return -EINVAL;
@@ -234,14 +253,19 @@
 		return -EINVAL;
 
 #ifdef CONFIG_MMU
-	rc = virtsnd_pcm_dma_pages_get(vss, runtime->dma_area, buffer_bytes);
-	if (rc)
-		return rc;
+	if (!request_owned) {
+		rc = virtsnd_pcm_dma_pages_get(vss, runtime->dma_area,
+					       buffer_bytes);
+		if (rc)
+			return rc;
+	}
 #else
-	vss->owned_dma_area = kzalloc(buffer_bytes, GFP_KERNEL);
-	if (!vss->owned_dma_area)
-		return -ENOMEM;
-	vss->owned_dma_bytes = buffer_bytes;
+	if (!request_owned) {
+		vss->owned_dma_area = kzalloc(buffer_bytes, GFP_KERNEL);
+		if (!vss->owned_dma_area)
+			return -ENOMEM;
+		vss->owned_dma_bytes = buffer_bytes;
+	}
 #endif
 
 	vss->msgs = kzalloc_objs(*vss->msgs, periods);
@@ -253,32 +277,54 @@
 	vss->nmsgs = periods;
 
 	for (i = 0; i < periods; ++i) {
-		int sg_num;
 		struct virtio_pcm_msg *msg;
 		u8 *data;
+		int sg_num;
+
+		if (request_owned) {
+			data = vzalloc(period_bytes);
+		} else {
 #ifdef CONFIG_MMU
-		data = runtime->dma_area + (size_t)period_bytes * i;
+			data = runtime->dma_area + (size_t)period_bytes * i;
 #else
-		data = vss->owned_dma_area + (size_t)period_bytes * i;
+			data = vss->owned_dma_area + (size_t)period_bytes * i;
 #endif
+		}
+		if (!data) {
+			rc = -ENOMEM;
+			goto err_free_msgs;
+		}
+
 		sg_num = virtsnd_pcm_sg_num(data, period_bytes);
 		if (sg_num < 0) {
+			if (request_owned)
+				vfree(data);
 			rc = sg_num;
 			goto err_free_msgs;
 		}
 
 		msg = kzalloc_flex(*msg, sgs, sg_num + 2);
 		if (!msg) {
+			if (request_owned)
+				vfree(data);
 			rc = -ENOMEM;
 			goto err_free_msgs;
 		}
 
 		msg->substream = vss;
+		msg->data = request_owned ? data : NULL;
 		vss->msgs[i] = msg;
-		sg_init_one(&msg->sgs[PCM_MSG_SG_XFER], &msg->xfer,
-			    sizeof(msg->xfer));
-		sg_init_one(&msg->sgs[PCM_MSG_SG_STATUS], &msg->status,
-			    sizeof(msg->status));
+		/* DMA payloads must not share cachelines with CPU-owned fields. */
+		msg->xfer = kzalloc(sizeof(*msg->xfer), GFP_KERNEL);
+		msg->status = kzalloc(sizeof(*msg->status), GFP_KERNEL);
+		if (!msg->xfer || !msg->status) {
+			rc = -ENOMEM;
+			goto err_free_msgs;
+		}
+		sg_init_one(&msg->sgs[PCM_MSG_SG_XFER], msg->xfer,
+			    sizeof(*msg->xfer));
+		sg_init_one(&msg->sgs[PCM_MSG_SG_STATUS], msg->status,
+			    sizeof(*msg->status));
 		msg->data_offset = (size_t)period_bytes * i;
 		virtsnd_pcm_sg_from(&msg->sgs[PCM_MSG_SG_DATA], sg_num, data,
 				    period_bytes);
@@ -312,8 +358,14 @@
 {
 	unsigned int i;
 
-	for (i = 0; vss->msgs && i < vss->nmsgs; ++i)
-		kfree(vss->msgs[i]);
+	for (i = 0; vss->msgs && i < vss->nmsgs; ++i) {
+		if (vss->msgs[i]) {
+			vfree(vss->msgs[i]->data);
+			kfree(vss->msgs[i]->xfer);
+			kfree(vss->msgs[i]->status);
+			kfree(vss->msgs[i]);
+		}
+	}
 	kfree(vss->msgs);
 #ifdef CONFIG_MMU
 	virtsnd_pcm_dma_pages_put(vss);
@@ -335,15 +387,37 @@
  * substream was stopped are never sent to the device, so their length must be
  * cleared before the substream is started again.
  *
- * Context: Any context. Takes and releases the VirtIO substream spinlock.
+ * Context: Caller holds the VirtIO substream spinlock.
  */
 void virtsnd_pcm_msg_reset(struct virtio_pcm_substream *vss)
 {
 	unsigned int i;
 
-	guard(spinlock_irqsave)(&vss->lock);
+	lockdep_assert_held(&vss->lock);
 	for (i = 0; vss->msgs && i < vss->nmsgs; ++i)
 		vss->msgs[i]->length = 0;
+	for (i = 0; vss->msgs && i < vss->nmsgs; ++i) {
+		vss->msgs[i]->capture_sequence = 0;
+		vss->msgs[i]->capture_audio_bytes = 0;
+		vss->msgs[i]->capture_latency_bytes = 0;
+		vss->msgs[i]->capture_complete = false;
+		vss->msgs[i]->capture_valid = false;
+	}
+	vss->capture_ready = 0;
+	vss->capture_copied_total = 0;
+	vss->capture_acked_total = 0;
+	vss->capture_pointer_seen_total = 0;
+	vss->capture_submit_sequence = 0;
+	vss->capture_commit_sequence = 0;
+	vss->capture_quiet_sequence = 0;
+	vss->capture_notified_periods = 0;
+	vss->capture_callback_snapshot = 0;
+	vss->capture_callback_snapshot_active = false;
+	vss->capture_boundary = 0;
+	vss->capture_free_running = false;
+	vss->capture_empty = 0;
+	vss->capture_started = false;
+	vss->capture_stopping = false;
 }
 
 /**
@@ -373,6 +447,8 @@
 	bool notify = false;
 	int rc;
 
+	if (!vqueue || !vss->prepared || vss->suspended)
+		return -EBADFD;
 	if (!bytes)
 		return 0;
 	if (!period_bytes || !vss->msgs || offset >= vss->buffer_bytes ||
@@ -398,8 +474,8 @@
 
 		msg->length += n;
 		if (msg->length == period_bytes) {
-			msg->xfer.stream_id = cpu_to_le32(vss->sid);
-			memset(&msg->status, 0, sizeof(msg->status));
+			msg->xfer->stream_id = cpu_to_le32(vss->sid);
+			memset(msg->status, 0, sizeof(*msg->status));
 
 #ifndef CONFIG_MMU
 		if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -473,6 +549,365 @@
 	return 0;
 }
 
+/* Caller holds vss->lock. */
+int virtsnd_pcm_capture_refresh_mode_locked(struct virtio_pcm_substream *vss,
+					    bool *free_running)
+{
+	struct snd_pcm_runtime *runtime;
+	snd_pcm_uframes_t stop_threshold;
+	u64 outstanding;
+	bool new_free_running;
+
+	if (!vss->runtime_active || !vss->substream)
+		return -EBADFD;
+
+	runtime = vss->substream->runtime;
+	if (!runtime || !vss->buffer_bytes || !vss->capture_boundary)
+		return -EBADFD;
+
+	/* Validate the currently committed policy before observing a transition. */
+	if (!virtsnd_pcm_capture_counters_valid(vss))
+		return -EIO;
+
+	stop_threshold = READ_ONCE(runtime->stop_threshold);
+	new_free_running = stop_threshold == vss->capture_boundary;
+	if (new_free_running != vss->capture_free_running) {
+		outstanding = vss->capture_copied_total -
+			      vss->capture_acked_total;
+		if (new_free_running) {
+			vss->capture_ready = 0;
+		} else {
+			if (outstanding >= vss->buffer_bytes)
+				return -EPIPE;
+			vss->capture_ready = outstanding;
+		}
+		vss->capture_free_running = new_free_running;
+	}
+
+	*free_running = new_free_running;
+	return 0;
+}
+
+/* Caller holds the RX queue and vss locks and has sampled the policy. */
+static int virtsnd_pcm_capture_enqueue(struct virtio_pcm_substream *vss,
+				       bool free_running)
+{
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	struct virtqueue *vqueue = queue->vqueue;
+	unsigned long period_bytes;
+	size_t free_bytes;
+	size_t request_limit = vss->nmsgs;
+	unsigned int i;
+	bool added = false;
+
+	if (!vqueue || !vss->prepared || vss->suspended ||
+	    !vss->runtime_active)
+		return -EBADFD;
+
+	period_bytes = snd_pcm_lib_period_bytes(vss->substream);
+	if (!period_bytes || !vss->buffer_bytes ||
+	    period_bytes >= vss->buffer_bytes ||
+	    free_running != vss->capture_free_running ||
+	    !virtsnd_pcm_capture_counters_valid(vss) ||
+	    vss->msg_count > vss->nmsgs)
+		return -EIO;
+
+	if (!free_running) {
+		free_bytes = vss->buffer_bytes - vss->capture_ready;
+		request_limit = free_bytes / period_bytes +
+				!!(free_bytes % period_bytes);
+		request_limit = min_t(size_t, request_limit, vss->nmsgs);
+	}
+
+	for (i = 0; i < vss->nmsgs && vss->msg_count < request_limit; ++i) {
+		struct virtio_pcm_msg *msg = vss->msgs[i];
+		struct scatterlist *sgs[] = {
+			&msg->sgs[PCM_MSG_SG_XFER],
+			&msg->sgs[PCM_MSG_SG_DATA],
+			&msg->sgs[PCM_MSG_SG_STATUS]
+		};
+		int rc;
+
+		if (msg->length || msg->capture_complete)
+			continue;
+		if (vss->capture_submit_sequence == U64_MAX)
+			return -EOVERFLOW;
+
+		msg->xfer->stream_id = cpu_to_le32(vss->sid);
+		/* Do not let an absent packed trailer reuse old PCM bytes. */
+		memset(msg->data, 0, period_bytes);
+		memset(msg->status, 0, sizeof(*msg->status));
+		msg->status->status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+		rc = virtqueue_add_sgs(vqueue, sgs, 1, 2, msg, GFP_ATOMIC);
+		if (rc) {
+			if (added && !(vss->features &
+				       (1U << VIRTIO_SND_PCM_F_MSG_POLLING)) &&
+			    virtqueue_kick_prepare(vqueue))
+				virtqueue_notify(vqueue);
+			return rc;
+		}
+
+		msg->length = period_bytes;
+		msg->capture_sequence = vss->capture_submit_sequence++;
+		msg->capture_audio_bytes = 0;
+		msg->capture_latency_bytes = 0;
+		msg->capture_valid = false;
+		vss->msg_count++;
+		added = true;
+	}
+
+	if (added && !(vss->features &
+			(1U << VIRTIO_SND_PCM_F_MSG_POLLING)) &&
+	    virtqueue_kick_prepare(vqueue))
+		virtqueue_notify(vqueue);
+
+	return 0;
+}
+
+/**
+ * virtsnd_pcm_capture_send() - Refresh policy and queue staged requests.
+ * @vss: VirtIO PCM substream.
+ *
+ * Context: Expects the RX queue and substream spinlocks to be held by caller.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_pcm_capture_send(struct virtio_pcm_substream *vss)
+{
+	bool free_running;
+	int rc;
+
+	rc = virtsnd_pcm_capture_refresh_mode_locked(vss, &free_running);
+	if (rc)
+		return rc;
+
+	return virtsnd_pcm_capture_enqueue(vss, free_running);
+}
+
+static int virtsnd_pcm_capture_status(const struct virtio_pcm_msg *msg,
+				      size_t written_bytes,
+				      size_t frame_bytes,
+				      size_t *audio_bytes,
+				      u32 *latency_bytes)
+{
+	struct virtio_snd_pcm_status status;
+	size_t max_written;
+	size_t first;
+
+	if (!frame_bytes ||
+	    check_add_overflow(msg->length, sizeof(status), &max_written) ||
+	    written_bytes < sizeof(status) || written_bytes > max_written)
+		return -EIO;
+
+	*audio_bytes = written_bytes - sizeof(status);
+	if (*audio_bytes > msg->length || *audio_bytes % frame_bytes)
+		return -EIO;
+
+	if (virtsnd_capture_packed_status) {
+		first = min_t(size_t, sizeof(status),
+			      msg->length - *audio_bytes);
+		if (first)
+			memcpy(&status, msg->data + *audio_bytes, first);
+		if (first < sizeof(status))
+			memcpy((u8 *)&status + first, msg->status,
+			       sizeof(status) - first);
+	} else {
+		status = *msg->status;
+	}
+
+	if (le32_to_cpu(status.status) != VIRTIO_SND_S_OK)
+		return -EIO;
+
+	*latency_bytes = le32_to_cpu(status.latency_bytes);
+	return 0;
+}
+
+static void virtsnd_pcm_capture_xrun_locked(struct virtio_pcm_substream *vss)
+{
+	if (!vss->xfer_xrun) {
+		vss->xfer_xrun = true;
+		virtsnd_pcm_schedule_period_elapsed(vss);
+	}
+}
+
+/* Caller holds vss->lock; append only once every older request is complete. */
+static bool virtsnd_pcm_capture_commit_one_locked(
+	struct virtio_pcm_substream *vss, struct virtio_pcm_msg *msg)
+{
+	struct snd_pcm_runtime *runtime = vss->substream->runtime;
+	size_t audio_bytes = msg->capture_audio_bytes;
+	size_t next_ready = 0;
+	u64 next_copied_total;
+	bool free_running;
+	const char *invalid_reason = NULL;
+	size_t ring_ptr, first;
+	unsigned int limit;
+
+	if (!msg->capture_valid)
+		invalid_reason = "status";
+	else if (!runtime || !runtime->dma_area)
+		invalid_reason = "runtime";
+	else if (virtsnd_pcm_capture_refresh_mode_locked(vss, &free_running))
+		invalid_reason = "policy";
+	else if (!virtsnd_pcm_capture_counters_valid(vss))
+		invalid_reason = "counters";
+	else if (vss->hw_ptr != virtsnd_pcm_ring_offset(
+			vss->capture_copied_total, vss->buffer_bytes))
+		invalid_reason = "hw_ptr";
+	else if (check_add_overflow(vss->capture_copied_total,
+				    (u64)audio_bytes, &next_copied_total))
+		invalid_reason = "total_overflow";
+	else if (!audio_bytes)
+		goto empty;
+	else if (free_running && audio_bytes >= vss->buffer_bytes)
+		invalid_reason = "payload_exceeds_ring";
+	else if (!free_running &&
+		 audio_bytes >= vss->buffer_bytes - vss->capture_ready)
+		invalid_reason = "ring_capacity";
+	else if (!free_running &&
+		 check_add_overflow(vss->capture_ready, audio_bytes, &next_ready))
+		invalid_reason = "ready_overflow";
+	else if (!free_running && next_ready >= vss->buffer_bytes)
+		invalid_reason = "ring_full";
+	else if (free_running &&
+		 (next_copied_total < vss->capture_pointer_seen_total ||
+		  next_copied_total - vss->capture_pointer_seen_total >=
+			vss->buffer_bytes))
+		invalid_reason = "pointer_window";
+	else if (free_running)
+		next_ready = 0;
+
+	if (invalid_reason)
+		goto invalid;
+
+	ring_ptr = virtsnd_pcm_ring_offset(vss->capture_copied_total,
+						  vss->buffer_bytes);
+	first = min(audio_bytes, vss->buffer_bytes - ring_ptr);
+	memcpy(runtime->dma_area + ring_ptr, msg->data, first);
+	if (audio_bytes > first)
+		memcpy(runtime->dma_area, msg->data + first,
+		       audio_bytes - first);
+	vss->capture_copied_total = next_copied_total;
+	vss->hw_ptr = virtsnd_pcm_ring_offset(next_copied_total,
+						      vss->buffer_bytes);
+	vss->capture_ready = next_ready;
+	vss->capture_started = true;
+	vss->capture_empty = 0;
+	runtime->delay = bytes_to_frames(runtime,
+					 msg->capture_latency_bytes);
+	return true;
+
+empty:
+	if (msg->capture_sequence >= vss->capture_quiet_sequence) {
+		limit = min_t(unsigned int, vss->nmsgs, UINT_MAX / 2) * 2;
+		if (vss->capture_started || vss->capture_empty >= limit)
+			goto invalid;
+		vss->capture_empty++;
+	}
+	runtime->delay = bytes_to_frames(runtime, msg->capture_latency_bytes);
+	return false;
+
+invalid:
+	virtsnd_pcm_capture_xrun_locked(vss);
+	dev_warn_ratelimited(&vss->snd->vdev->dev,
+			     "SID %u: capture completion rejected (%s)\n",
+			     vss->sid, invalid_reason ?: "empty_limit");
+	return false;
+}
+
+/* Caller holds vss->lock. */
+static bool virtsnd_pcm_capture_commit_ready_locked(
+	struct virtio_pcm_substream *vss)
+{
+	bool got_audio = false;
+	unsigned int i;
+
+	while (!vss->xfer_xrun) {
+		struct virtio_pcm_msg *next = NULL;
+
+		for (i = 0; i < vss->nmsgs; i++) {
+			struct virtio_pcm_msg *msg = vss->msgs[i];
+
+			if (msg->capture_complete &&
+			    msg->capture_sequence == vss->capture_commit_sequence) {
+				next = msg;
+				break;
+			}
+		}
+		if (!next)
+			break;
+		got_audio |= virtsnd_pcm_capture_commit_one_locked(vss, next);
+		if (vss->xfer_xrun)
+			break;
+		next->capture_complete = false;
+		next->length = 0;
+		vss->capture_commit_sequence++;
+	}
+
+	if (vss->xfer_xrun) {
+		for (i = 0; i < vss->nmsgs; i++) {
+			struct virtio_pcm_msg *msg = vss->msgs[i];
+
+			if (msg->capture_complete) {
+				msg->capture_complete = false;
+				msg->length = 0;
+			}
+		}
+	}
+
+	return got_audio;
+}
+
+static void virtsnd_pcm_capture_complete(struct virtio_pcm_msg *msg,
+					 size_t written_bytes)
+{
+	struct virtio_pcm_substream *vss = msg->substream;
+	struct snd_pcm_runtime *runtime;
+	size_t audio_bytes = 0;
+	u32 latency_bytes = 0;
+	size_t frame_bytes;
+	bool got_audio = false;
+	bool accept_completion;
+
+	guard(spinlock)(&vss->lock);
+	vss->msg_count--;
+	accept_completion = vss->runtime_active && vss->prepared &&
+		(!vss->stopped || vss->capture_stopping) && !vss->xfer_xrun;
+	if (accept_completion) {
+		runtime = vss->substream->runtime;
+		if (runtime && runtime->dma_area) {
+			frame_bytes = runtime->frame_bits /
+				gcd(runtime->frame_bits, 8);
+			msg->capture_valid = !virtsnd_pcm_capture_status(
+				msg, written_bytes, frame_bytes, &audio_bytes,
+				&latency_bytes);
+			msg->capture_audio_bytes = audio_bytes;
+			msg->capture_latency_bytes = latency_bytes;
+			msg->capture_complete = true;
+			got_audio = virtsnd_pcm_capture_commit_ready_locked(vss);
+		} else {
+			msg->length = 0;
+			msg->capture_complete = false;
+		}
+	} else {
+		msg->length = 0;
+		msg->capture_complete = false;
+	}
+
+	if (vss->runtime_active && vss->xfer_enabled) {
+		if (!vss->xfer_xrun && virtsnd_pcm_capture_send(vss)) {
+			dev_warn_ratelimited(&vss->snd->vdev->dev,
+					     "SID %u: failed to refill capture queue\n",
+					     vss->sid);
+			virtsnd_pcm_capture_xrun_locked(vss);
+		}
+	}
+	if (!vss->msg_count) {
+		wake_up_all(&vss->msg_empty);
+	}
+	if (got_audio && !vss->xfer_xrun)
+		virtsnd_pcm_schedule_period_elapsed(vss);
+}
+
 /**
  * virtsnd_pcm_msg_pending_num() - Returns the number of pending I/O messages.
  * @vss: VirtIO substream.
@@ -524,9 +959,9 @@
  * allowed, then each completed message is immediately placed back at the end
  * of the queue.
  *
- * For the playback substream, @written_bytes is equal to sizeof(msg->status).
- *
- * For the capture substream, @written_bytes is equal to sizeof(msg->status)
+ * For the playback substream, @written_bytes is equal to sizeof(*msg->status).
+ *
+ * For the capture substream, @written_bytes is equal to sizeof(*msg->status)
  * plus the number of captured bytes.
  *
  * Context: Interrupt context. Takes and releases the VirtIO substream spinlock.
@@ -535,80 +970,32 @@
 				     size_t written_bytes)
 {
 	struct virtio_pcm_substream *vss = msg->substream;
-	bool capture_invalid = false;
-
-	/*
-	 * Completed requests can return captured data after STOP while the PCM
-	 * buffer remains prepared. Once preparation ends, completions only retire
-	 * queue ownership.
-	 */
+	size_t completed_bytes;
+	u32 latency_bytes;
+
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+		virtsnd_pcm_capture_complete(msg, written_bytes);
+		return;
+	}
+
+	/* Playback requests point directly at the ALSA ring. */
 	guard(spinlock)(&vss->lock);
-	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
-	    (!vss->prepared || vss->xfer_xrun ||
-	     (vss->stopped && written_bytes <= sizeof(msg->status)))) {
-		msg->length = 0;
-		vss->msg_count--;
-		if (!vss->msg_count)
-			wake_up_all(&vss->msg_empty);
-		return;
-	}
-
-	/* Validate the returned payload before advancing the capture pointer. */
-	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
-	    (written_bytes < sizeof(msg->status) ||
-	     le32_to_cpu(msg->status.status) != VIRTIO_SND_S_OK ||
-	     written_bytes - sizeof(msg->status) > msg->length)) {
-		dev_err_ratelimited(&vss->snd->vdev->dev,
-				    "SID %u: invalid capture position, status or length\n",
-			vss->sid);
-		vss->xfer_xrun = true;
-		capture_invalid = true;
-	}
-#ifndef CONFIG_MMU
-	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
-	    vss->prepared && !capture_invalid &&
-	    written_bytes > sizeof(msg->status)) {
-		struct snd_pcm_runtime *runtime =
-			vss->substream ? vss->substream->runtime : NULL;
-
-		if (!runtime || !runtime->dma_area || !vss->owned_dma_area ||
-		    msg->data_offset > runtime->dma_bytes ||
-		    written_bytes - sizeof(msg->status) > runtime->dma_bytes - msg->data_offset ||
-		    msg->data_offset > vss->owned_dma_bytes ||
-		    written_bytes - sizeof(msg->status) > vss->owned_dma_bytes - msg->data_offset) {
-			dev_err_ratelimited(&vss->snd->vdev->dev,
-					    "SID %u: invalid capture buffer for I/O message\n",
-				vss->sid);
-			vss->xfer_xrun = true;
-			capture_invalid = true;
-		} else {
-			memcpy(runtime->dma_area + msg->data_offset,
-			       vss->owned_dma_area + msg->data_offset,
-			       written_bytes - sizeof(msg->status));
-		}
-	}
-#endif
-	/* Publish pointer progress only for a complete TX or valid RX request. */
-	if (!capture_invalid) {
-		vss->hw_ptr += vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
-			written_bytes > sizeof(msg->status) ?
-			written_bytes - sizeof(msg->status) : msg->length;
-		if (vss->hw_ptr >= vss->buffer_bytes)
-			vss->hw_ptr -= vss->buffer_bytes;
-	}
+	completed_bytes = msg->length;
+	latency_bytes = le32_to_cpu(msg->status->latency_bytes);
+	vss->hw_ptr += completed_bytes;
+	if (vss->hw_ptr >= vss->buffer_bytes)
+		vss->hw_ptr -= vss->buffer_bytes;
 
 	msg->length = 0;
+
+	/* Keep latched errors until prepare establishes a fresh epoch. */
 	vss->msg_count--;
 
 	if (vss->xfer_enabled) {
-		if (!capture_invalid) {
-			struct snd_pcm_runtime *runtime = vss->substream->runtime;
-
-			runtime->delay =
-				bytes_to_frames(runtime,
-						le32_to_cpu(msg->status.latency_bytes));
-		}
-		schedule_work(&vss->elapsed_period);
+		struct snd_pcm_runtime *runtime = vss->substream->runtime;
+
+		runtime->delay = bytes_to_frames(runtime, latency_bytes);
+		virtsnd_pcm_schedule_period_elapsed(vss);
 	}
 	if (!vss->msg_count)
 		wake_up_all(&vss->msg_empty);
@@ -668,6 +1055,7 @@
  * virtsnd_pcm_ctl_msg_alloc() - Allocate and initialize the PCM device control
  *                               message for the specified substream.
  * @vss: VirtIO PCM substream.
+ * @epoch: Operation generation captured before allocation.
  * @command: Control request code (VIRTIO_SND_R_PCM_XXX).
  * @gfp: Kernel flags for memory allocation.
  *
@@ -676,7 +1064,7 @@
  */
 struct virtio_snd_msg *
 virtsnd_pcm_ctl_msg_alloc(struct virtio_pcm_substream *vss,
-			  unsigned int command, gfp_t gfp)
+			  unsigned int command, gfp_t gfp, u64 epoch)
 {
 	size_t request_size = sizeof(struct virtio_snd_pcm_hdr);
 	size_t response_size = sizeof(struct virtio_snd_hdr);
@@ -694,6 +1082,7 @@
 
 		hdr->hdr.code = cpu_to_le32(command);
 		hdr->stream_id = cpu_to_le32(vss->sid);
+		virtsnd_ctl_msg_bind_pcm(msg, vss, epoch);
 	}
 
 	return msg;
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -3,9 +3,26 @@
  * virtio-snd: Virtio sound device
  * Copyright (C) 2021 OpenSynergy GmbH
  */
+#include <linux/moduleparam.h>
+#include <linux/overflow.h>
+#include <linux/spinlock.h>
 #include <sound/pcm_params.h>
 
 #include "virtio_card.h"
+
+static const struct snd_pcm_ops virtsnd_pcm_capture_ops;
+
+bool virtsnd_capture_packed_status;
+module_param_named(capture_packed_status, virtsnd_capture_packed_status,
+		   bool, 0444);
+MODULE_PARM_DESC(capture_packed_status,
+		 "Read an explicitly opted-in packed PCM status trailer");
+
+static bool virtsnd_capture_pause_restart;
+module_param_named(capture_pause_restart, virtsnd_capture_pause_restart,
+		   bool, 0444);
+MODULE_PARM_DESC(capture_pause_restart,
+		 "Use release/reprepare pause compatibility instead of native pause");
 
 /*
  * I/O messages lifetime
@@ -97,48 +114,265 @@
 };
 
 static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);
-
-/**
- * virtsnd_pcm_close_ack() - Update PCM prepare admission state.
- * @substream: Kernel ALSA substream.
- * @preparing: True while driver prepare and the core pointer reset are active.
- *
- * Context: Process context.
- */
-static void virtsnd_pcm_close_ack(struct snd_pcm_substream *substream,
-				  bool preparing)
-{
-	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
-
-	scoped_guard(pcm_stream_lock_irqsave, substream) {
-		guard(spinlock_irqsave)(&vss->lock);
-		vss->prepared = false;
+static int virtsnd_pcm_sync_stop_locked(struct snd_pcm_substream *substream);
+static int virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream *substream);
+
+static void virtsnd_pcm_trigger_failed(struct virtio_pcm_substream *vss,
+				       u64 epoch)
+{
+	bool notify;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return;
 		vss->xfer_enabled = false;
-		vss->preparing = preparing;
-	}
-}
-
-static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss)
-{
-	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->stopped = vss->release_required || vss->msg_count;
+		vss->xfer_xrun = true;
+		notify = vss->direction != SNDRV_PCM_STREAM_CAPTURE ||
+			 vss->runtime_active;
+	}
+	vss->substream->runtime->stop_operating = true;
+	if (notify)
+		virtsnd_pcm_schedule_period_elapsed(vss);
+}
+
+static bool
+virtsnd_pcm_pause_restart_enabled(struct virtio_pcm_substream *vss)
+{
+	return virtsnd_capture_pause_restart &&
+	       vss->direction == SNDRV_PCM_STREAM_CAPTURE;
+}
+
+static bool virtsnd_pcm_pause_restart_transitioning(enum virtio_pcm_pause_restart_state state)
+{
+	switch (state) {
+	case VIRTSND_PCM_PAUSE_RESTART_SET_PARAMS_SUBMITTED:
+	case VIRTSND_PCM_PAUSE_RESTART_PREPARE_SUBMITTED:
+	case VIRTSND_PCM_PAUSE_RESTART_START_SUBMITTED:
+	case VIRTSND_PCM_PAUSE_RESTART_STOP_SUBMITTED:
+	case VIRTSND_PCM_PAUSE_RESTART_RELEASE_SUBMITTED:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int virtsnd_pcm_send_sync(struct virtio_pcm_substream *vss,
+				 struct virtio_snd_msg *msg)
+{
+	u64 epoch = virtsnd_ctl_msg_pcm_epoch(msg);
+	bool uncertain;
+	int rc;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch ||
+		    vss->control_uncertain) {
+			rc = vss->control_uncertain ? -EIO : -ECANCELED;
+			virtsnd_ctl_msg_unref(msg);
+			return rc;
+		}
+	}
+	virtsnd_ctl_msg_ref(msg);
+	rc = virtsnd_ctl_msg_send_sync(vss->snd, msg);
+	uncertain = virtsnd_ctl_msg_uncertain(msg, rc);
+	virtsnd_ctl_msg_unref(msg);
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (epoch != vss->reset_epoch || vss->resetting)
+			return -ECANCELED;
+		if (rc && uncertain)
+			vss->control_uncertain = true;
+	}
+	return rc;
+}
+
+static int
+virtsnd_pcm_pause_restart_send(struct virtio_pcm_substream *vss,
+			       struct virtio_snd_msg *msg,
+			       unsigned long allowed_states,
+			       enum virtio_pcm_pause_restart_state submitted_state,
+			       enum virtio_pcm_pause_restart_state success_state)
+{
+	enum virtio_pcm_pause_restart_state state;
+	bool uncertain;
+	u64 epoch = virtsnd_ctl_msg_pcm_epoch(msg);
+	int rc;
+
+	if (!virtsnd_pcm_pause_restart_enabled(vss))
+		return virtsnd_pcm_send_sync(vss, msg);
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		state = vss->pause_restart_state;
+		if (vss->resetting || vss->reset_epoch != epoch) {
+			rc = -ECANCELED;
+		} else if (state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED) {
+			rc = -EIO;
+		} else if (virtsnd_pcm_pause_restart_transitioning(state)) {
+			vss->pause_restart_state =
+				VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
+			rc = -EIO;
+		} else if (!(allowed_states & BIT(state))) {
+			rc = -EBADFD;
+		} else {
+			vss->pause_restart_state = submitted_state;
+			rc = 0;
+		}
+	}
+
+	if (rc) {
+		virtsnd_ctl_msg_unref(msg);
+		return rc;
+	}
+
+	virtsnd_ctl_msg_ref(msg);
+	rc = virtsnd_ctl_msg_send_sync(vss->snd, msg);
+	uncertain = virtsnd_ctl_msg_uncertain(msg, rc);
+	virtsnd_ctl_msg_unref(msg);
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->reset_epoch != epoch || vss->resetting)
+			return -ECANCELED;
+		if ((rc && uncertain) || vss->pause_restart_state != submitted_state) {
+			vss->pause_restart_state =
+				VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
+			if (!rc)
+				rc = -EIO;
+		} else if (rc) {
+			vss->pause_restart_state = state;
+		} else {
+			vss->pause_restart_state = success_state;
+		}
+	}
+
+	if (rc && uncertain)
+		dev_err(&vss->snd->vdev->dev,
+			"SID %u: PCM control state is unknown; device reprobe required\n",
+			vss->sid);
+
+	return rc;
+}
+
+static void
+virtsnd_pcm_pause_restart_fail(struct virtio_pcm_substream *vss,
+			       bool reset_required, u64 epoch)
+{
+	bool notify_xrun;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return;
+		notify_xrun = vss->runtime_active;
 		vss->xfer_enabled = false;
 		vss->stopped = true;
 		vss->xfer_xrun = true;
-	}
+		if (reset_required)
+			vss->pause_restart_state =
+				VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
+	}
+	if (notify_xrun)
+		virtsnd_pcm_schedule_period_elapsed(vss);
 	vss->substream->runtime->stop_operating = true;
-	schedule_work(&vss->elapsed_period);
-}
-
-/* Keep completed RX data valid while RELEASE drains the device queue. */
-static void virtsnd_pcm_block_ack(struct snd_pcm_substream *substream)
-{
-	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
-
-	scoped_guard(pcm_stream_lock_irqsave, substream) {
-		guard(spinlock_irqsave)(&vss->lock);
-		vss->preparing = true;
-		vss->xfer_enabled = false;
-	}
+}
+
+static int virtsnd_pcm_dev_prepare(struct virtio_pcm_substream *vss, u64 epoch)
+{
+	struct virtio_snd_msg *msg;
+
+	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_PREPARE,
+					GFP_KERNEL, epoch);
+	if (!msg)
+		return -ENOMEM;
+
+	return virtsnd_pcm_pause_restart_send(vss, msg,
+		BIT(VIRTSND_PCM_PAUSE_RESTART_CONFIGURED) |
+		BIT(VIRTSND_PCM_PAUSE_RESTART_RELEASED) |
+		BIT(VIRTSND_PCM_PAUSE_RESTART_STOPPED) |
+		BIT(VIRTSND_PCM_PAUSE_RESTART_PREPARED),
+		VIRTSND_PCM_PAUSE_RESTART_PREPARE_SUBMITTED,
+		VIRTSND_PCM_PAUSE_RESTART_PREPARED);
+}
+
+static int virtsnd_pcm_pause_prepare(struct virtio_pcm_substream *vss, u64 epoch)
+{
+	struct virtio_snd_msg *msg;
+
+	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_PREPARE,
+					GFP_KERNEL, epoch);
+	if (!msg)
+		return -ENOMEM;
+
+	return virtsnd_pcm_pause_restart_send(vss, msg,
+		BIT(VIRTSND_PCM_PAUSE_RESTART_RELEASED),
+		VIRTSND_PCM_PAUSE_RESTART_PREPARE_SUBMITTED,
+		VIRTSND_PCM_PAUSE_RESTART_PREPARED);
+}
+
+static int virtsnd_pcm_release_wait(struct virtio_pcm_substream *vss, u64 epoch)
+{
+	unsigned long js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+	long waited;
+
+	waited = wait_event_timeout(vss->msg_empty,
+				   !virtsnd_pcm_msg_pending_num(vss), js);
+	guard(spinlock_irqsave)(&vss->lock);
+	if (vss->resetting || vss->reset_epoch != epoch)
+		return -ECANCELED;
+	if (!waited || vss->msg_count ||
+	    vss->pause_restart_state != VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT)
+		return -ETIMEDOUT;
+	vss->prepared = false;
+	vss->release_required = false;
+	vss->pause_restart_state = VIRTSND_PCM_PAUSE_RESTART_RELEASED;
+	return 0;
+}
+
+static int
+virtsnd_pcm_pause_release_flush(struct virtio_pcm_substream *vss,
+				unsigned long allowed_states, u64 epoch)
+{
+	struct virtio_snd_msg *msg;
+	int rc;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return -ECANCELED;
+	}
+	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_RELEASE,
+					GFP_KERNEL, epoch);
+	if (!msg)
+		return -ENOMEM;
+	rc = virtsnd_pcm_pause_restart_send(vss, msg, allowed_states,
+			VIRTSND_PCM_PAUSE_RESTART_RELEASE_SUBMITTED,
+			VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT);
+	if (rc)
+		return rc;
+	return virtsnd_pcm_release_wait(vss, epoch);
+}
+
+static void virtsnd_pcm_pause_restart_failed(struct virtio_pcm_substream *vss,
+					     u64 epoch)
+{
+	virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+}
+
+/* The PCM stream lock is held; defer a paused XRUN until resume commits. */
+static bool virtsnd_pcm_defer_resume_xrun(struct virtio_pcm_substream *vss,
+					 u64 epoch)
+{
+	struct snd_pcm_runtime *runtime = vss->substream->runtime;
+	bool defer = false;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (!vss->resetting && vss->reset_epoch == epoch && runtime &&
+		    runtime->state == SNDRV_PCM_STATE_PAUSED &&
+		    vss->xfer_xrun) {
+			vss->xfer_enabled = false;
+			runtime->stop_operating = true;
+			defer = true;
+		}
+	}
+	if (defer)
+		virtsnd_pcm_schedule_period_elapsed(vss);
+
+	return defer;
 }
 
 /**
@@ -153,23 +387,36 @@
 	struct virtio_pcm *vpcm = snd_pcm_substream_chip(substream);
 	struct virtio_pcm_stream *vs = &vpcm->streams[substream->stream];
 	struct virtio_pcm_substream *vss = vs->substreams[substream->number];
+	int rc;
 
 	substream->runtime->hw = vss->hw;
 	substream->private_data = vss;
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+			vss->runtime_active = false;
+			vss->xfer_enabled = false;
+		}
+	}
+
+	/* All capture streams use request-owned receive and accounting paths. */
+	substream->ops = vss->direction == SNDRV_PCM_STREAM_CAPTURE ?
+		&virtsnd_pcm_capture_ops : &virtsnd_pcm_ops[substream->stream];
 
 	snd_pcm_hw_constraint_integer(substream->runtime,
 				      SNDRV_PCM_HW_PARAM_PERIODS);
 
 	scoped_guard(spinlock_irqsave, &vss->lock)
 		vss->stopped |= !!vss->msg_count;
-	vss->suspended = false;
 
 	/*
 	 * If the substream has already been used, then the I/O queue may be in
 	 * an invalid state. Just in case, we do a check and try to return the
 	 * queue to its original state, if necessary.
 	 */
-	return virtsnd_pcm_sync_stop(substream);
+	rc = virtsnd_pcm_sync_stop(substream);
+	if (!rc)
+		enable_work(&vss->elapsed_period);
+	return rc;
 }
 
 /**
@@ -181,6 +428,15 @@
  */
 static int virtsnd_pcm_close(struct snd_pcm_substream *substream)
 {
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->runtime_active = false;
+		vss->xfer_enabled = false;
+	}
+	/* Block late producers as well as drain already queued notifications. */
+	disable_work_sync(&vss->elapsed_period);
+
 	return 0;
 }
 
@@ -193,6 +449,7 @@
  * @channels: Selected number of channels.
  * @format: Selected sample format (SNDRV_PCM_FORMAT_XXX).
  * @rate: Selected frame rate.
+ * @epoch: Operation generation captured before preparing the request.
  *
  * Context: Any context that permits to sleep.
  * Return: 0 on success, -errno on failure.
@@ -202,7 +459,7 @@
 				      unsigned int period_bytes,
 				      unsigned int channels,
 				      snd_pcm_format_t format,
-				      unsigned int rate)
+				      unsigned int rate, u64 epoch)
 {
 	struct virtio_snd_msg *msg;
 	struct virtio_snd_pcm_set_params *request;
@@ -228,7 +485,7 @@
 		return -EINVAL;
 
 	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_SET_PARAMS,
-					GFP_KERNEL);
+					GFP_KERNEL, epoch);
 	if (!msg)
 		return -ENOMEM;
 
@@ -247,7 +504,14 @@
 		request->features |=
 			cpu_to_le32(1U << VIRTIO_SND_PCM_F_EVT_XRUNS);
 
-	return virtsnd_ctl_msg_send_sync(vss->snd, msg);
+	return virtsnd_pcm_pause_restart_send(vss, msg,
+		BIT(VIRTSND_PCM_PAUSE_RESTART_NONE) |
+		BIT(VIRTSND_PCM_PAUSE_RESTART_CONFIGURED) |
+		BIT(VIRTSND_PCM_PAUSE_RESTART_PREPARED) |
+		BIT(VIRTSND_PCM_PAUSE_RESTART_STOPPED) |
+		BIT(VIRTSND_PCM_PAUSE_RESTART_RELEASED),
+		VIRTSND_PCM_PAUSE_RESTART_SET_PARAMS_SUBMITTED,
+		VIRTSND_PCM_PAUSE_RESTART_CONFIGURED);
 }
 
 /**
@@ -266,10 +530,10 @@
 	unsigned int msg_count;
 	size_t period_buffer_bytes;
 	bool stopped;
+	u64 epoch;
 	int rc;
 
-	virtsnd_pcm_close_ack(substream, false);
-
+	guard(mutex)(&vss->lifecycle_lock);
 	/* Fixed descriptors require whole-byte periods covering the buffer. */
 	if (check_mul_overflow((size_t)params_periods(hw_params),
 			       (size_t)params_period_bytes(hw_params),
@@ -279,6 +543,25 @@
 	     (u64)snd_pcm_format_physical_width(params_format(hw_params)) *
 	     params_channels(hw_params)) % 8)
 		return -EINVAL;
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		epoch = vss->reset_epoch;
+	/* Drain the previous buffer before ALSA can replace its mapping. */
+	rc = virtsnd_pcm_sync_stop_locked(substream);
+	if (rc)
+		return rc;
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return -ECANCELED;
+		vss->prepared = false;
+	}
+
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			vss->runtime_active = false;
+			vss->xfer_enabled = false;
+		}
+		cancel_work_sync(&vss->elapsed_period);
+	}
 
 	scoped_guard(spinlock_irqsave, &vss->lock) {
 		msg_count = vss->msg_count;
@@ -292,16 +575,20 @@
 	if (stopped) {
 		dev_err(&vdev->dev, "SID %u: stream release failed\n",
 			vss->sid);
-		scoped_guard(pcm_stream_lock_irqsave, substream)
-			substream->runtime->stop_operating = true;
+		substream->runtime->stop_operating = true;
 		return -EBADFD;
 	}
+
+	rc = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+	if (rc < 0)
+		return rc;
+	substream->runtime->buffer_changed = rc > 0;
 
 	rc = virtsnd_pcm_dev_set_params(vss, params_buffer_bytes(hw_params),
 					params_period_bytes(hw_params),
 					params_channels(hw_params),
 					params_format(hw_params),
-					params_rate(hw_params));
+					params_rate(hw_params), epoch);
 	if (rc)
 		return rc;
 
@@ -311,8 +598,18 @@
 	 */
 	virtsnd_pcm_msg_free(vss);
 
-	return virtsnd_pcm_msg_alloc(vss, params_periods(hw_params),
-				     params_period_bytes(hw_params));
+	rc = virtsnd_pcm_msg_alloc(vss, params_periods(hw_params),
+				   params_period_bytes(hw_params));
+	if (!rc) {
+		guard(spinlock_irqsave)(&vss->lock);
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return -ECANCELED;
+		vss->suspended = false;
+		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+			vss->runtime_active = true;
+	}
+
+	return rc;
 }
 
 /**
@@ -325,108 +622,529 @@
 static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
-
-	virtsnd_pcm_close_ack(substream, false);
+	int rc;
+
+	guard(mutex)(&vss->lifecycle_lock);
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->stopped |= vss->prepared;
+		vss->prepared = false;
+		vss->runtime_active = false;
+		vss->xfer_enabled = false;
+	}
+	rc = virtsnd_pcm_sync_stop_locked(substream);
+	cancel_work_sync(&vss->elapsed_period);
+
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			vss->runtime_active = false;
+			vss->xfer_enabled = false;
+		}
+		cancel_work_sync(&vss->elapsed_period);
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			vss->hw_ptr = 0;
+			vss->capture_ready = 0;
+			vss->capture_copied_total = 0;
+			vss->capture_acked_total = 0;
+			vss->capture_pointer_seen_total = 0;
+			vss->capture_notified_periods = 0;
+			vss->capture_callback_snapshot = 0;
+			vss->capture_callback_snapshot_active = false;
+			vss->capture_boundary = 0;
+			vss->capture_free_running = false;
+		}
+	}
 
 	/* If the queue is flushed, we can safely free the messages here. */
 	if (!virtsnd_pcm_msg_pending_num(vss))
 		virtsnd_pcm_msg_free(vss);
 
-	return 0;
+	snd_pcm_lib_free_pages(substream);
+	return rc;
 }
 
 /**
- * virtsnd_pcm_prepare_device() - Prepare the PCM substream on the device.
+ * virtsnd_pcm_prepare_locked() - Prepare the PCM substream.
  * @substream: Kernel ALSA substream.
  *
  * Context: Process context.
  * Return: 0 on success, -errno on failure.
  */
-static int virtsnd_pcm_prepare_device(struct snd_pcm_substream *substream)
+static int virtsnd_pcm_prepare_locked(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_device *vdev = vss->snd->vdev;
-	struct virtio_snd_msg *msg;
+	bool pause_restart = virtsnd_pcm_pause_restart_enabled(vss);
+	bool free_running;
+	int rc;
 	bool stopped;
-	int rc;
+	bool suspended;
+	u64 epoch;
+
+	scoped_guard(pcm_stream_lock_irqsave, substream) {
+		guard(spinlock_irqsave)(&vss->lock);
+		if (vss->resetting)
+			return -ECANCELED;
+		epoch = vss->reset_epoch;
+		stopped = vss->stopped || vss->release_required || vss->msg_count;
+		vss->prepared = false;
+		vss->preparing = true;
+	}
+	if (stopped) {
+		rc = virtsnd_pcm_sync_stop_locked(substream);
+		if (rc)
+			return rc;
+	}
+	scoped_guard(pcm_stream_lock_irqsave, substream) {
+		guard(spinlock_irqsave)(&vss->lock);
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return -ECANCELED;
+		suspended = vss->suspended;
+	}
+
+	if (pause_restart) {
+		enum virtio_pcm_pause_restart_state state;
+
+		scoped_guard(spinlock_irqsave, &vss->lock)
+			state = vss->pause_restart_state;
+		if (state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
+		    virtsnd_pcm_pause_restart_transitioning(state)) {
+			virtsnd_pcm_pause_restart_fail(vss, true, epoch);
+			return -EIO;
+		}
+	}
 
 	scoped_guard(spinlock_irqsave, &vss->lock)
 		stopped = vss->stopped;
 	if (stopped) {
 		dev_err(&vdev->dev, "SID %u: stream release failed\n",
 			vss->sid);
-		scoped_guard(pcm_stream_lock_irqsave, substream)
-			substream->runtime->stop_operating = true;
+		substream->runtime->stop_operating = true;
 		return -EBADFD;
 	}
 
-	if (!vss->suspended) {
+	if (!suspended) {
 		if (virtsnd_pcm_msg_pending_num(vss)) {
 			dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
 				vss->sid);
 			return -EBADFD;
 		}
 
-		vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
-		vss->hw_ptr = 0;
 	} else {
 		struct snd_pcm_runtime *runtime = substream->runtime;
 		unsigned int buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
 		unsigned int period_bytes = snd_pcm_lib_period_bytes(substream);
 
 		rc = virtsnd_pcm_dev_set_params(vss, buffer_bytes, period_bytes,
-						 runtime->channels,
-						 runtime->format, runtime->rate);
-		if (rc)
+						runtime->channels,
+						runtime->format, runtime->rate, epoch);
+		if (rc) {
+			if (pause_restart && rc != -ECANCELED)
+				virtsnd_pcm_pause_restart_fail(vss, false, epoch);
 			return rc;
-	}
-
-	vss->suspended = false;
-	vss->msg_count = 0;
-	virtsnd_pcm_msg_reset(vss);
-
-	memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
-	vss->pcm_indirect.sw_buffer_size =
-		vss->pcm_indirect.hw_buffer_size =
-		snd_pcm_lib_buffer_bytes(substream);
-
-	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_PREPARE,
-					GFP_KERNEL);
+		}
+	}
+
+	rc = virtsnd_pcm_dev_prepare(vss, epoch);
+	if (rc) {
+		if (pause_restart && rc != -ECANCELED)
+			virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (vss->reset_epoch == epoch && !vss->resetting) {
+				vss->xfer_xrun = true;
+				vss->stopped = true;
+			}
+		}
+		return rc;
+	}
+
+	scoped_guard(pcm_stream_lock_irqsave, substream) {
+		guard(spinlock_irqsave)(&vss->lock);
+		if (epoch != vss->reset_epoch || vss->resetting)
+			return -ECANCELED;
+		vss->release_required = true;
+		vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
+		vss->hw_ptr = 0;
+		vss->suspended = false;
+		vss->msg_count = 0;
+		virtsnd_pcm_msg_reset(vss);
+		memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
+		vss->pcm_indirect.sw_buffer_size = vss->buffer_bytes;
+		vss->pcm_indirect.hw_buffer_size = vss->buffer_bytes;
+		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+			vss->capture_boundary = substream->runtime->boundary;
+			rc = virtsnd_pcm_capture_refresh_mode_locked(vss,
+							     &free_running);
+			if (rc) {
+				vss->xfer_xrun = true;
+				vss->stopped = true;
+				return rc;
+			}
+		}
+		vss->prepared = true;
+		vss->stopped = false;
+		vss->xfer_xrun = false;
+	}
+
+	return rc;
+}
+
+static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+
+	int rc;
+
+	guard(mutex)(&vss->lifecycle_lock);
+	rc = virtsnd_pcm_prepare_locked(substream);
+	if (!rc && vss->period_work_quiesced) {
+		enable_work(&vss->elapsed_period);
+		vss->period_work_quiesced = false;
+	}
+	return rc;
+}
+
+/* The core calls this after every linked member's prepare action completes. */
+static void virtsnd_pcm_prepare_complete(struct snd_pcm_substream *substream,
+					 bool success)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	bool teardown_pending;
+
+	guard(spinlock_irqsave)(&vss->lock);
+	if (vss->resetting) {
+		vss->prepared = false;
+		vss->xfer_enabled = false;
+		vss->preparing = false;
+		return;
+	}
+	if (!success) {
+		teardown_pending = vss->prepared || vss->release_required ||
+			vss->msg_count || vss->device_running || vss->stopped;
+		vss->prepared = false;
+		vss->xfer_enabled = false;
+		vss->stopped = true;
+		if (teardown_pending)
+			substream->runtime->stop_operating = true;
+	}
+	vss->preparing = false;
+}
+
+static int virtsnd_pcm_pause_restart_start(struct virtio_pcm_substream *vss,
+					   bool resume)
+{
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	struct virtio_snd_msg *msg;
+	enum virtio_pcm_pause_restart_state state;
+	bool reset_required;
+	bool invalid_state;
+	bool xrun;
+	int rc = 0;
+	u64 epoch;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		if (vss->preparing)
+			return -EBADFD;
+		epoch = vss->reset_epoch;
+		state = vss->pause_restart_state;
+		xrun = vss->xfer_xrun;
+		vss->capture_stopping = false;
+		reset_required =
+			state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
+			virtsnd_pcm_pause_restart_transitioning(state);
+		invalid_state =
+			(resume &&
+			 (state != VIRTSND_PCM_PAUSE_RESTART_RELEASED ||
+			  !vss->stopped || vss->msg_count ||
+			  !vss->runtime_active)) ||
+			(!resume &&
+			 (state != VIRTSND_PCM_PAUSE_RESTART_PREPARED ||
+			  vss->stopped));
+	}
+	if (reset_required) {
+		virtsnd_pcm_pause_restart_fail(vss, true, epoch);
+		return -EIO;
+	}
+	if (xrun) {
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
+		return -EPIPE;
+	}
+	if (invalid_state) {
+		virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+		return -EBADFD;
+	}
+
+	if (resume) {
+		rc = virtsnd_pcm_pause_prepare(vss, epoch);
+		if (rc) {
+			if (rc == -ECANCELED)
+				return rc;
+			virtsnd_pcm_pause_restart_failed(vss, epoch);
+			return rc;
+		}
+
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (vss->resetting || vss->reset_epoch != epoch) {
+				rc = -ECANCELED;
+			} else {
+				vss->release_required = true;
+				if (vss->pause_restart_state !=
+				    VIRTSND_PCM_PAUSE_RESTART_PREPARED ||
+				    vss->msg_count || !vss->runtime_active) {
+					rc = -EBADFD;
+				} else {
+					/* RX may complete before START responds to this PREPARE. */
+					vss->prepared = true;
+					vss->stopped = false;
+					vss->capture_started = false;
+					vss->capture_empty = 0;
+				}
+			}
+		}
+		if (rc) {
+			if (rc == -ECANCELED)
+				return rc;
+			virtsnd_pcm_pause_restart_failed(vss, epoch);
+			return rc;
+		}
+	}
+
+	scoped_guard(spinlock_irqsave, &queue->lock) {
+		guard(spinlock)(&vss->lock);
+		if (vss->resetting || vss->reset_epoch != epoch) {
+			rc = -ECANCELED;
+		} else if (vss->xfer_xrun) {
+			rc = -EPIPE;
+		} else if (vss->pause_restart_state !=
+			    VIRTSND_PCM_PAUSE_RESTART_PREPARED ||
+		    vss->msg_count || !vss->runtime_active) {
+			rc = -EBADFD;
+		} else {
+			rc = virtsnd_pcm_capture_send(vss);
+			if (!rc)
+				vss->xfer_enabled = true;
+		}
+	}
+	if (rc) {
+		if (rc == -ECANCELED)
+			return rc;
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
+		return rc;
+	}
+
+	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START, GFP_KERNEL, epoch);
+	if (!msg) {
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
+		return -ENOMEM;
+	}
+
+	rc = virtsnd_pcm_pause_restart_send(vss, msg,
+					    BIT(VIRTSND_PCM_PAUSE_RESTART_PREPARED),
+					    VIRTSND_PCM_PAUSE_RESTART_START_SUBMITTED,
+					    VIRTSND_PCM_PAUSE_RESTART_RUNNING);
+	if (rc) {
+		if (rc == -ECANCELED)
+			return rc;
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
+		return rc;
+	}
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return -ECANCELED;
+		vss->stopped = false;
+	}
+	virtsnd_pcm_schedule_period_elapsed(vss);
+
+	return 0;
+}
+
+static int virtsnd_pcm_pause_restart_pause(struct virtio_pcm_substream *vss)
+{
+	struct virtio_snd_msg *msg;
+	enum virtio_pcm_pause_restart_state state;
+	bool xrun;
+	int rc;
+	u64 epoch;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		epoch = vss->reset_epoch;
+		state = vss->pause_restart_state;
+		xrun = vss->xfer_xrun;
+		if (state != VIRTSND_PCM_PAUSE_RESTART_RELEASED) {
+			vss->xfer_enabled = false;
+			vss->stopped = true;
+			vss->capture_stopping = true;
+			vss->capture_quiet_sequence =
+				vss->capture_submit_sequence;
+		}
+	}
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RELEASED) {
+		if (xrun) {
+			virtsnd_pcm_pause_restart_failed(vss, epoch);
+			return -EPIPE;
+		}
+		return 0;
+	}
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT) {
+		/* Trigger holds the PCM lock; this helper never cancels work. */
+		rc = virtsnd_pcm_release_wait(vss, epoch);
+		if (!rc) {
+			guard(spinlock_irqsave)(&vss->lock);
+			rc = vss->xfer_xrun ? -EPIPE : 0;
+		}
+		if (rc && rc != -ECANCELED)
+			virtsnd_pcm_pause_restart_failed(vss, epoch);
+		return rc;
+	}
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
+	    virtsnd_pcm_pause_restart_transitioning(state)) {
+		virtsnd_pcm_pause_restart_fail(vss, true, epoch);
+		return -EIO;
+	}
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RUNNING) {
+		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_STOP,
+						GFP_KERNEL, epoch);
+		if (!msg) {
+			virtsnd_pcm_pause_restart_failed(vss, epoch);
+			return -ENOMEM;
+		}
+
+		rc = virtsnd_pcm_pause_restart_send(vss, msg,
+						    BIT(VIRTSND_PCM_PAUSE_RESTART_RUNNING),
+						    VIRTSND_PCM_PAUSE_RESTART_STOP_SUBMITTED,
+					    VIRTSND_PCM_PAUSE_RESTART_STOPPED);
+		if (rc) {
+			if (rc == -ECANCELED)
+				return rc;
+			virtsnd_pcm_pause_restart_failed(vss, epoch);
+			return rc;
+		}
+		state = VIRTSND_PCM_PAUSE_RESTART_STOPPED;
+	} else if (state != VIRTSND_PCM_PAUSE_RESTART_STOPPED &&
+		   state != VIRTSND_PCM_PAUSE_RESTART_PREPARED) {
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
+		return -EBADFD;
+	}
+
+	rc = virtsnd_pcm_pause_release_flush(vss,
+					     BIT(VIRTSND_PCM_PAUSE_RESTART_STOPPED) |
+					     BIT(VIRTSND_PCM_PAUSE_RESTART_PREPARED), epoch);
+	if (rc) {
+		if (rc == -ECANCELED)
+			return rc;
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int virtsnd_pcm_pause_restart_stop(struct virtio_pcm_substream *vss,
+					  bool suspend)
+{
+	struct virtio_snd_msg *msg;
+	enum virtio_pcm_pause_restart_state state;
+	int rc;
+	u64 epoch;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		epoch = vss->reset_epoch;
+		if (suspend)
+			vss->suspended = true;
+		if (!vss->prepared && !vss->msg_count)
+			return 0;
+		vss->xfer_enabled = false;
+		vss->stopped = true;
+		vss->capture_stopping = true;
+		vss->capture_quiet_sequence = vss->capture_submit_sequence;
+		state = vss->pause_restart_state;
+	}
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
+	    virtsnd_pcm_pause_restart_transitioning(state)) {
+		virtsnd_pcm_pause_restart_fail(vss, true, epoch);
+		return -EIO;
+	}
+	if (state != VIRTSND_PCM_PAUSE_RESTART_RUNNING)
+		return 0;
+
+	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_STOP, GFP_KERNEL, epoch);
+	if (!msg) {
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
+		return -ENOMEM;
+	}
+
+	rc = virtsnd_pcm_pause_restart_send(vss, msg,
+					    BIT(VIRTSND_PCM_PAUSE_RESTART_RUNNING),
+					    VIRTSND_PCM_PAUSE_RESTART_STOP_SUBMITTED,
+					    VIRTSND_PCM_PAUSE_RESTART_STOPPED);
+	if (rc && rc != -ECANCELED)
+		virtsnd_pcm_pause_restart_failed(vss, epoch);
+
+	return rc;
+}
+
+static int virtsnd_pcm_stop_device(struct virtio_pcm_substream *vss, u64 epoch)
+{
+	struct virtio_snd_msg *msg;
+	int rc;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return -ECANCELED;
+		if (vss->control_uncertain)
+			return -EIO;
+		if (!vss->device_running)
+			return 0;
+	}
+	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_STOP,
+					GFP_KERNEL, epoch);
 	if (!msg)
 		return -ENOMEM;
-
-	rc = virtsnd_ctl_msg_send_sync(vss->snd, msg);
+	rc = virtsnd_pcm_send_sync(vss, msg);
 	if (rc)
 		return rc;
-
-	scoped_guard(spinlock_irqsave, &vss->lock) {
-		vss->xfer_xrun = false;
-		vss->release_required = true;
-	}
+	guard(spinlock_irqsave)(&vss->lock);
+	if (vss->resetting || vss->reset_epoch != epoch)
+		return -ECANCELED;
+	vss->device_running = false;
 	return 0;
 }
 
-/* Keep ACK closed through the core's locked pointer reset. */
-static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
-{
-	virtsnd_pcm_close_ack(substream, true);
-	return virtsnd_pcm_prepare_device(substream);
-}
-
-/* Complete admission only after the linked core prepare action ends. */
-static void virtsnd_pcm_prepare_complete(
-	struct snd_pcm_substream *substream, bool success)
-{
-	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
-
-	scoped_guard(spinlock_irqsave, &vss->lock) {
-		vss->prepared = success;
-		vss->preparing = false;
-	}
+static int virtsnd_pcm_start_queue(struct virtio_pcm_substream *vss, u64 epoch)
+{
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	int rc = 0;
+
+	guard(spinlock_irqsave)(&queue->lock);
+	guard(spinlock)(&vss->lock);
+	if (vss->resetting || vss->reset_epoch != epoch)
+		return -ECANCELED;
+	if (vss->preparing)
+		return -EBADFD;
+	if (vss->stopped || !vss->prepared || vss->xfer_xrun)
+		return vss->xfer_xrun ? -EPIPE : -EBADFD;
+	if (vss->control_uncertain)
+		return -EIO;
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+		rc = vss->runtime_active ? virtsnd_pcm_capture_send(vss) : -EBADFD;
+	}
+	if (!rc)
+		vss->xfer_enabled = true;
+	return rc;
 }
 
 /**
- * virtsnd_pcm_trigger() - Process command for the PCM substream.
+ * virtsnd_pcm_trigger_inner() - Process command for the PCM substream.
  * @substream: Kernel ALSA substream.
  * @command: Substream command (SNDRV_PCM_TRIGGER_XXX).
  *
@@ -434,73 +1152,304 @@
  *          May take and release the tx/rx queue spinlock.
  * Return: 0 on success, -errno on failure.
  */
-static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
+static int virtsnd_pcm_trigger_inner(struct snd_pcm_substream *substream,
+				     int command)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
-	struct virtio_snd *snd = vss->snd;
-	struct virtio_snd_queue *queue;
 	struct virtio_snd_msg *msg;
 	int rc = 0;
+	bool running;
+	u64 epoch;
+
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		epoch = vss->reset_epoch;
+
+	if (virtsnd_pcm_pause_restart_enabled(vss)) {
+		switch (command) {
+		case SNDRV_PCM_TRIGGER_START:
+			return virtsnd_pcm_pause_restart_start(vss, false);
+		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+			return virtsnd_pcm_pause_restart_start(vss, true);
+		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+			return virtsnd_pcm_pause_restart_pause(vss);
+		case SNDRV_PCM_TRIGGER_STOP:
+			return virtsnd_pcm_pause_restart_stop(vss, false);
+		case SNDRV_PCM_TRIGGER_SUSPEND:
+			return virtsnd_pcm_pause_restart_stop(vss, true);
+		default:
+			return -EINVAL;
+		}
+	}
 
 	switch (command) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		queue = virtsnd_pcm_queue(vss);
-
-		scoped_guard(spinlock_irqsave, &queue->lock) {
-			guard(spinlock)(&vss->lock);
-			if (vss->preparing || !vss->prepared)
-				return -EBADFD;
-			if (vss->stopped) {
-				substream->runtime->stop_operating = true;
-				return -EBADFD;
-			}
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			running = vss->device_running;
 			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
-				rc = virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
-			if (!rc)
-				vss->xfer_enabled = true;
-		}
+				vss->capture_stopping = false;
+		}
+		/* Preserve queued requests and unread RX data across native pause. */
+		rc = virtsnd_pcm_start_queue(vss, epoch);
 		if (rc) {
-			virtsnd_pcm_start_failed(vss);
+			virtsnd_pcm_trigger_failed(vss, epoch);
 			return rc;
 		}
 
+		if (running) {
+			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+				virtsnd_pcm_schedule_period_elapsed(vss);
+			return 0;
+		}
+
 		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
-						GFP_KERNEL);
+						GFP_KERNEL, epoch);
 		if (!msg) {
-			virtsnd_pcm_start_failed(vss);
+			virtsnd_pcm_trigger_failed(vss, epoch);
 			return -ENOMEM;
 		}
 
-		rc = virtsnd_ctl_msg_send_sync(snd, msg);
-		if (rc)
-			virtsnd_pcm_start_failed(vss);
-
+		rc = virtsnd_pcm_send_sync(vss, msg);
+		if (rc && rc != -ECANCELED)
+			virtsnd_pcm_trigger_failed(vss, epoch);
+
+		if (!rc) {
+			guard(spinlock_irqsave)(&vss->lock);
+			if (vss->resetting || vss->reset_epoch != epoch)
+				return -ECANCELED;
+			vss->device_running = true;
+		}
+		if (!rc && (vss->direction == SNDRV_PCM_STREAM_CAPTURE))
+			virtsnd_pcm_schedule_period_elapsed(vss);
 		return rc;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		vss->suspended = true;
+		scoped_guard(spinlock_irqsave, &vss->lock)
+			vss->suspended = true;
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (!vss->prepared)
+				return 0;
 			if (command != SNDRV_PCM_TRIGGER_PAUSE_PUSH)
 				vss->stopped = true;
+			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+				vss->capture_stopping = true;
+				vss->capture_quiet_sequence =
+					vss->capture_submit_sequence;
+			}
 			vss->xfer_enabled = false;
-		}
-
-		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_STOP,
-						GFP_KERNEL);
-		if (!msg)
-			return -ENOMEM;
-
-		return virtsnd_ctl_msg_send_sync(snd, msg);
+			if (!vss->device_running)
+				return 0;
+		}
+
+		rc = virtsnd_pcm_stop_device(vss, epoch);
+		if (rc && command != SNDRV_PCM_TRIGGER_PAUSE_PUSH) {
+			guard(spinlock_irqsave)(&vss->lock);
+
+			if (vss->reset_epoch == epoch && !vss->resetting) {
+				vss->xfer_xrun = true;
+				substream->runtime->stop_operating = true;
+				if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+					virtsnd_pcm_schedule_period_elapsed(vss);
+			}
+		}
+		if (rc && command == SNDRV_PCM_TRIGGER_PAUSE_PUSH) {
+			if (substream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
+				/* Failed resume rollback must leave a paused queue closed. */
+				virtsnd_pcm_trigger_failed(vss, epoch);
+			} else if (virtsnd_pcm_start_queue(vss, epoch)) {
+				virtsnd_pcm_trigger_failed(vss, epoch);
+			} else if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+				virtsnd_pcm_schedule_period_elapsed(vss);
+			}
+		}
+		return rc;
 	default:
 		return -EINVAL;
 	}
 }
 
+static int virtsnd_pcm_start_admission(struct virtio_pcm_substream *vss)
+{
+	int rc = 0;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			rc = -ECANCELED;
+		else if (vss->preparing)
+			rc = -EBADFD;
+	}
+
+	return rc;
+}
+
 /**
- * virtsnd_pcm_sync_stop() - Synchronous PCM substream stop.
+ * virtsnd_pcm_trigger() - Defer a paused XRUN until linked resume completes.
+ * @substream: Kernel ALSA substream.
+ * @command: Substream command (SNDRV_PCM_TRIGGER_XXX).
+ *
+ * Context: Called with the PCM stream and linked-group locks held.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	u64 epoch;
+	int rc;
+
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		epoch = vss->reset_epoch;
+	if (command == SNDRV_PCM_TRIGGER_START ||
+	    command == SNDRV_PCM_TRIGGER_PAUSE_RELEASE) {
+		rc = virtsnd_pcm_start_admission(vss);
+		if (rc) {
+			return rc;
+		}
+	}
+
+	if (command == SNDRV_PCM_TRIGGER_PAUSE_RELEASE &&
+	    virtsnd_pcm_defer_resume_xrun(vss, epoch)) {
+		return 0;
+	}
+
+	rc = virtsnd_pcm_trigger_inner(substream, command);
+	if (!rc && command == SNDRV_PCM_TRIGGER_PAUSE_PUSH)
+		substream->runtime->stop_operating = true;
+	if (command == SNDRV_PCM_TRIGGER_PAUSE_RELEASE &&
+	    (rc == 0 || rc == -EPIPE) &&
+	    virtsnd_pcm_defer_resume_xrun(vss, epoch))
+		rc = 0;
+
+	return rc;
+}
+
+static int
+virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	unsigned long js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+	enum virtio_pcm_pause_restart_state state;
+	struct virtio_snd_msg *msg;
+	long waited;
+	int rc;
+	u64 epoch;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		epoch = vss->reset_epoch;
+		vss->xfer_enabled = false;
+		vss->stopped = true;
+		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+			vss->capture_stopping = true;
+			vss->capture_quiet_sequence =
+				vss->capture_submit_sequence;
+		}
+		state = vss->pause_restart_state;
+	}
+	cancel_work_sync(&vss->elapsed_period);
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
+	    virtsnd_pcm_pause_restart_transitioning(state)) {
+		virtsnd_pcm_pause_restart_fail(vss, true, epoch);
+		dev_err(&vss->snd->vdev->dev,
+			"SID %u: PCM state is unknown; device reprobe required\n",
+			vss->sid);
+		return -EIO;
+	}
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_NONE ||
+	    state == VIRTSND_PCM_PAUSE_RESTART_CONFIGURED) {
+		if (virtsnd_pcm_msg_pending_num(vss)) {
+			virtsnd_pcm_pause_restart_fail(vss, true, epoch);
+			return -EIO;
+		}
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (vss->resetting || vss->reset_epoch != epoch)
+				return -ECANCELED;
+			vss->stopped = false;
+		}
+		return 0;
+	}
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RUNNING) {
+		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_STOP,
+						GFP_KERNEL, epoch);
+		if (!msg) {
+			virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+			return -ENOMEM;
+		}
+
+		rc = virtsnd_pcm_pause_restart_send(vss, msg,
+						    BIT(VIRTSND_PCM_PAUSE_RESTART_RUNNING),
+						    VIRTSND_PCM_PAUSE_RESTART_STOP_SUBMITTED,
+						    VIRTSND_PCM_PAUSE_RESTART_STOPPED);
+		if (rc) {
+			if (rc == -ECANCELED)
+				return rc;
+			virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+			return rc;
+		}
+		state = VIRTSND_PCM_PAUSE_RESTART_STOPPED;
+	}
+
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT ||
+	    state == VIRTSND_PCM_PAUSE_RESTART_RELEASED) {
+		waited = wait_event_timeout(vss->msg_empty,
+					    !virtsnd_pcm_msg_pending_num(vss), js);
+		if (waited <= 0) {
+			rc = waited ? (int)waited : -ETIMEDOUT;
+			virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+			return rc;
+		}
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (vss->resetting || vss->reset_epoch != epoch)
+				return -ECANCELED;
+			if (vss->msg_count) {
+				rc = -ETIMEDOUT;
+			} else {
+				vss->pause_restart_state =
+					VIRTSND_PCM_PAUSE_RESTART_RELEASED;
+				vss->prepared = false;
+				vss->release_required = false;
+				vss->stopped = false;
+				rc = 0;
+			}
+		}
+		if (rc)
+			virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+		return rc;
+	}
+
+	if (state != VIRTSND_PCM_PAUSE_RESTART_PREPARED &&
+	    state != VIRTSND_PCM_PAUSE_RESTART_STOPPED) {
+		virtsnd_pcm_pause_restart_fail(vss, true, epoch);
+		return -EIO;
+	}
+
+	rc = virtsnd_pcm_pause_release_flush(vss,
+					     BIT(VIRTSND_PCM_PAUSE_RESTART_PREPARED) |
+					     BIT(VIRTSND_PCM_PAUSE_RESTART_STOPPED), epoch);
+	if (rc) {
+		if (rc == -ECANCELED)
+			return rc;
+		virtsnd_pcm_pause_restart_fail(vss, false, epoch);
+		return rc;
+	}
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return -ECANCELED;
+		vss->prepared = false;
+		vss->stopped = false;
+	}
+
+	return 0;
+}
+
+/**
+ * virtsnd_pcm_release_locked() - Retire the closed PCM generation.
  * @substream: Kernel ALSA substream.
  *
  * The function can be called both from the upper level or from the driver
@@ -509,43 +1458,68 @@
  * Context: Process context. Takes and releases the VirtIO substream spinlock.
  * Return: 0 on success, -errno on failure.
  */
-static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
+static int virtsnd_pcm_release_locked(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd *snd = vss->snd;
 	struct virtio_snd_msg *msg;
-	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+	unsigned long js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
 	bool need_release;
+	long waited;
 	int rc;
-
-	virtsnd_pcm_block_ack(substream);
-
-	scoped_guard(spinlock_irqsave, &vss->lock) {
+	u64 epoch;
+
+	lockdep_assert_held(&vss->lifecycle_lock);
+	/* Keep late RX completions from requeuing work after cancellation. */
+	if (!vss->period_work_quiesced) {
+		disable_work_sync(&vss->elapsed_period);
+		vss->period_work_quiesced = true;
+	}
+	if (virtsnd_pcm_pause_restart_enabled(vss))
+		return virtsnd_pcm_pause_restart_sync_stop(substream);
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		epoch = vss->reset_epoch;
 		vss->xfer_enabled = false;
 		need_release = vss->release_required;
 		if (need_release)
 			vss->stopped = true;
-	}
-	cancel_work_sync(&vss->elapsed_period);
+		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+			vss->capture_stopping = true;
+			vss->capture_quiet_sequence =
+				vss->capture_submit_sequence;
+		}
+	}
+	/* A rejected STOP leaves the device running and must precede RELEASE. */
+	rc = virtsnd_pcm_stop_device(vss, epoch);
+	if (rc) {
+		substream->runtime->stop_operating = true;
+		return rc;
+	}
 
 	if (need_release) {
 		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_RELEASE,
-						GFP_KERNEL);
+						GFP_KERNEL, epoch);
 		if (!msg) {
-			scoped_guard(pcm_stream_lock_irqsave, substream)
-				substream->runtime->stop_operating = true;
+			substream->runtime->stop_operating = true;
 			return -ENOMEM;
 		}
 
-		rc = virtsnd_ctl_msg_send_sync(snd, msg);
+		rc = virtsnd_pcm_send_sync(vss, msg);
 		if (rc) {
-			scoped_guard(pcm_stream_lock_irqsave, substream)
-				substream->runtime->stop_operating = true;
+			substream->runtime->stop_operating = true;
 			return rc;
 		}
 
-		scoped_guard(spinlock_irqsave, &vss->lock)
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (vss->resetting || vss->reset_epoch != epoch)
+				return -ECANCELED;
 			vss->release_required = false;
+			vss->device_running = false;
+			vss->prepared = false;
+		}
 	}
 
 	/*
@@ -554,22 +1528,56 @@
 	 * Thus, we consider the absence of I/O messages in the queue as an
 	 * indication that the substream has been released.
 	 */
-	rc = wait_event_interruptible_timeout(vss->msg_empty,
-					      !virtsnd_pcm_msg_pending_num(vss),
-					      js);
-	if (rc <= 0) {
+	waited = wait_event_timeout(vss->msg_empty,
+				    !virtsnd_pcm_msg_pending_num(vss),
+				    js);
+	if (waited <= 0) {
 		dev_warn(&snd->vdev->dev, "SID %u: failed to flush I/O queue\n",
 			 vss->sid);
-		scoped_guard(pcm_stream_lock_irqsave, substream)
-			substream->runtime->stop_operating = true;
-
-		return !rc ? -ETIMEDOUT : rc;
-	}
-
-	scoped_guard(spinlock_irqsave, &vss->lock)
+		substream->runtime->stop_operating = true;
+
+		return waited ? (int)waited : -ETIMEDOUT;
+	}
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return -ECANCELED;
+		vss->prepared = false;
 		vss->stopped = false;
+	}
 
 	return 0;
+}
+
+/* Close ACK admission before any sleep; prepare owns the gate through RESET. */
+static int virtsnd_pcm_sync_stop_locked(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	bool preparing;
+	int rc;
+
+	lockdep_assert_held(&vss->lifecycle_lock);
+	scoped_guard(pcm_stream_lock_irqsave, substream) {
+		guard(spinlock_irqsave)(&vss->lock);
+		preparing = vss->preparing;
+		vss->preparing = true;
+		vss->prepared = false;
+		vss->xfer_enabled = false;
+	}
+	rc = virtsnd_pcm_release_locked(substream);
+	scoped_guard(pcm_stream_lock_irqsave, substream) {
+		guard(spinlock_irqsave)(&vss->lock);
+		vss->preparing = preparing;
+	}
+	return rc;
+}
+
+static snd_pcm_uframes_t
+virtsnd_pcm_cached_pointer(struct snd_pcm_runtime *runtime)
+{
+	if (!runtime->buffer_size)
+		return 0;
+	return runtime->status->hw_ptr % runtime->buffer_size;
 }
 
 /**
@@ -584,14 +1592,49 @@
 virtsnd_pcm_pb_pointer(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
-
-	scoped_guard(spinlock_irqsave, &vss->lock)
-		if (vss->xfer_xrun)
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	size_t hw_ptr;
+	bool paused_pointer = false;
+	bool defer_work = false;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (runtime->state == SNDRV_PCM_STATE_PAUSED) {
+			if (vss->xfer_xrun) {
+				virtsnd_pcm_defer_paused_xrun(vss);
+				defer_work = true;
+			}
+			paused_pointer = !vss->prepared || vss->preparing ||
+					 vss->xfer_xrun;
+		} else if (!vss->prepared || vss->preparing || vss->xfer_xrun) {
 			return SNDRV_PCM_POS_XRUN;
+		}
+		if (!paused_pointer)
+			hw_ptr = vss->hw_ptr;
+	}
+	if (paused_pointer) {
+		if (defer_work)
+			virtsnd_pcm_schedule_period_elapsed(vss);
+		return virtsnd_pcm_cached_pointer(runtime);
+	}
 
 	return snd_pcm_indirect_playback_pointer(substream,
-		&vss->pcm_indirect,
-		vss->hw_ptr);
+		&vss->pcm_indirect, hw_ptr);
+}
+
+/* Caller holds vss->lock. */
+static void virtsnd_pcm_capture_reset_pointer_locked(
+	struct virtio_pcm_substream *vss, struct snd_pcm_substream *substream,
+	u64 total)
+{
+	size_t period;
+
+	if (!vss->capture_reset_observing)
+		return;
+
+	period = snd_pcm_lib_period_bytes(substream);
+	vss->capture_acked_total = total;
+	vss->capture_ready = 0;
+	vss->capture_notified_periods = period ? div64_ul(total, period) : 0;
 }
 
 /**
@@ -606,14 +1649,78 @@
 virtsnd_pcm_cp_pointer(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
-
-	scoped_guard(spinlock_irqsave, &vss->lock)
-		if (vss->xfer_xrun)
-			return SNDRV_PCM_POS_XRUN;
-
-	return snd_pcm_indirect_capture_pointer(substream,
-		&vss->pcm_indirect,
-		vss->hw_ptr);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	size_t hw_ptr = 0;
+	u64 total;
+	bool free_running;
+	bool xrun = false;
+	bool paused = runtime->state == SNDRV_PCM_STATE_PAUSED;
+	bool paused_pointer = false;
+	bool defer_work = false;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (paused) {
+			if (vss->xfer_xrun) {
+				virtsnd_pcm_defer_paused_xrun(vss);
+				defer_work = true;
+			}
+			paused_pointer = !vss->runtime_active || vss->preparing ||
+				vss->suspended ||
+				(!vss->prepared &&
+				 !(virtsnd_pcm_pause_restart_enabled(vss) &&
+				   vss->pause_restart_state ==
+					VIRTSND_PCM_PAUSE_RESTART_RELEASED)) ||
+				vss->xfer_xrun;
+		} else {
+			if (!vss->runtime_active || vss->preparing || vss->suspended ||
+			    (!vss->prepared &&
+			     !(virtsnd_pcm_pause_restart_enabled(vss) &&
+			       vss->pause_restart_state ==
+				VIRTSND_PCM_PAUSE_RESTART_RELEASED)))
+				return SNDRV_PCM_POS_XRUN;
+		}
+		if (!paused_pointer) {
+			xrun = vss->xfer_xrun;
+			if (!xrun &&
+			    virtsnd_pcm_capture_refresh_mode_locked(vss, &free_running))
+				xrun = true;
+			if (!xrun && !virtsnd_pcm_capture_counters_valid(vss))
+				xrun = true;
+			if (!xrun) {
+				total = vss->capture_callback_snapshot_active ?
+					vss->capture_callback_snapshot :
+					vss->capture_copied_total;
+				/* A full-ring observation gap is modulo-ambiguous. */
+				if (total < vss->capture_pointer_seen_total ||
+				    total - vss->capture_pointer_seen_total >=
+					vss->buffer_bytes) {
+					xrun = true;
+				} else {
+					vss->capture_pointer_seen_total = total;
+					hw_ptr = virtsnd_pcm_ring_offset(
+						total, vss->buffer_bytes);
+					virtsnd_pcm_capture_reset_pointer_locked(
+						vss, substream, total);
+				}
+			}
+			if (xrun) {
+				vss->xfer_xrun = true;
+				if (paused) {
+					virtsnd_pcm_defer_paused_xrun(vss);
+					paused_pointer = true;
+					defer_work = true;
+				} else {
+					return SNDRV_PCM_POS_XRUN;
+				}
+			}
+		}
+	}
+	if (paused_pointer) {
+		if (defer_work)
+			virtsnd_pcm_schedule_period_elapsed(vss);
+		return virtsnd_pcm_cached_pointer(runtime);
+	}
+	return bytes_to_frames(runtime, hw_ptr);
 }
 
 struct virtsnd_pcm_transfer {
@@ -733,116 +1840,397 @@
 	vss->substream->runtime->stop_operating = true;
 }
 
+/* Caller holds vss->lock; a paused ACK must not trigger linked XRUN. */
+static int virtsnd_pcm_ack_xrun_locked(struct virtio_pcm_substream *vss,
+				       struct snd_pcm_runtime *runtime)
+{
+	vss->xfer_xrun = true;
+	if (runtime->state == SNDRV_PCM_STATE_PAUSED) {
+		vss->xfer_enabled = false;
+		runtime->stop_operating = true;
+		virtsnd_pcm_schedule_period_elapsed(vss);
+		return -EBADFD;
+	}
+	return -EPIPE;
+}
+
+static int virtsnd_pcm_pb_ack_locked(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	struct virtsnd_pcm_transfer transfer = {};
+	bool paused;
+	int rc;
+
+	scoped_guard(spinlock_irqsave, &queue->lock) {
+		guard(spinlock)(&vss->lock);
+		paused = runtime->state == SNDRV_PCM_STATE_PAUSED;
+		if (vss->preparing)
+			return -EBADFD;
+		/* A latched XRUN must not re-arm sync_stop once teardown began. */
+		if (vss->stopped && vss->xfer_xrun)
+			return -EBADFD;
+		if (vss->xfer_xrun) {
+			rc = virtsnd_pcm_ack_xrun_locked(vss, runtime);
+		} else {
+			if (!vss->prepared || vss->stopped)
+				return -EBADFD;
+			transfer.indirect = vss->pcm_indirect;
+			rc = virtsnd_pcm_playback_ack_validate(vss, runtime,
+							       &transfer.indirect);
+			if (rc == -EBADFD)
+				return -EBADFD;
+			if (!rc)
+				rc = snd_pcm_indirect_playback_transfer(substream,
+									&transfer.indirect,
+									virtsnd_pcm_trans_copy);
+		}
+		if (!rc)
+			rc = transfer.error;
+		if (rc) {
+			if (paused)
+				rc = virtsnd_pcm_ack_xrun_locked(vss, runtime);
+			else
+				virtsnd_pcm_transfer_failed(vss);
+		} else {
+			vss->pcm_indirect = transfer.indirect;
+		}
+	}
+	if (rc) {
+		dev_err(&vss->snd->vdev->dev,
+			"SID %u: playback ACK transfer failed: %d\n",
+			vss->sid, rc);
+		/* ALSA treats -EPIPE as an XRUN in ACK and pointer paths. */
+		return paused ? -EBADFD : -EPIPE;
+	}
+
+	return 0;
+}
+
 /* The caller holds the PCM lock, also used by DROP and state transitions. */
 static int virtsnd_pcm_ack_state(struct snd_pcm_substream *substream)
 {
 	switch (substream->runtime->state) {
 	case SNDRV_PCM_STATE_XRUN:
-		/* The member is already XRUN; avoid stopping its linked group twice. */
+		/*
+		 * pcm_lib_apply_appl_ptr() interprets -EPIPE as a new XRUN
+		 * and calls __snd_pcm_xrun(), which stops the whole linked
+		 * group. The stream is already XRUN; do not repeat that action.
+		 */
 		return -EBADFD;
 	case SNDRV_PCM_STATE_PREPARED:
 	case SNDRV_PCM_STATE_RUNNING:
 	case SNDRV_PCM_STATE_PAUSED:
 	case SNDRV_PCM_STATE_DRAINING:
-		if (atomic_read(&substream->runtime->buffer_accessing) < 0)
-			return -EBADFD;
 		return 0;
 	default:
 		return -EBADFD;
 	}
 }
 
+/* The PCM lock serializes ACK with prepare's accounting reset. */
 static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
-	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
-	struct virtsnd_pcm_transfer transfer = {};
 	int rc;
 
+	if (vss->indirect_reset_observing)
+		return 0;
 	rc = virtsnd_pcm_ack_state(substream);
 	if (rc)
 		return rc;
-
+	return virtsnd_pcm_pb_ack_locked(substream);
+}
+
+static int virtsnd_pcm_capture_ack(struct virtio_pcm_substream *vss,
+					  struct snd_pcm_runtime *runtime)
+{
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	int rc = 0;
+
+	/*
+	 * The RX callback holds the queue lock while draining completions.
+	 * Account ALSA's read under the substream lock alone so completions later
+	 * in that drain observe the newly released ring space.
+	 */
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		snd_pcm_uframes_t appl_ptr;
+		snd_pcm_uframes_t appl_diff;
+		snd_pcm_sframes_t diff;
+		size_t bytes;
+		u64 outstanding;
+		u64 next_acked_total;
+		bool free_running;
+
+		if (!vss->runtime_active || vss->preparing || !runtime || !runtime->control ||
+		    !runtime->dma_area || vss->suspended)
+			return -EBADFD;
+		/* Preserve DRAINING tails only when no transfer XRUN is latched. */
+		if (vss->stopped && vss->xfer_xrun)
+			return -EBADFD;
+		if (vss->xfer_xrun)
+			return virtsnd_pcm_ack_xrun_locked(vss, runtime);
+		if (!vss->prepared &&
+		    !(runtime->state == SNDRV_PCM_STATE_PAUSED &&
+		      virtsnd_pcm_pause_restart_enabled(vss) &&
+		      vss->pause_restart_state == VIRTSND_PCM_PAUSE_RESTART_RELEASED))
+			return -EBADFD;
+		if (vss->stopped && runtime->state != SNDRV_PCM_STATE_DRAINING &&
+		    !(runtime->state == SNDRV_PCM_STATE_PAUSED &&
+		      virtsnd_pcm_pause_restart_enabled(vss) &&
+		      vss->pause_restart_state == VIRTSND_PCM_PAUSE_RESTART_RELEASED))
+			return -EBADFD;
+		appl_ptr = runtime->control->appl_ptr;
+		diff = appl_ptr - vss->pcm_indirect.appl_ptr;
+		if (diff < -(snd_pcm_sframes_t)(runtime->boundary / 2))
+			diff += runtime->boundary;
+		if (diff < 0)
+			return virtsnd_pcm_ack_xrun_locked(vss, runtime);
+		appl_diff = diff;
+
+		if (!runtime->min_align) {
+			return -EBADFD;
+		}
+		if (appl_diff > runtime->buffer_size)
+			return virtsnd_pcm_ack_xrun_locked(vss, runtime);
+		if (appl_diff % runtime->min_align) {
+			return -EBADFD;
+		}
+		rc = virtsnd_pcm_capture_refresh_mode_locked(vss,
+							     &free_running);
+		if (rc || !virtsnd_pcm_capture_counters_valid(vss))
+			return virtsnd_pcm_ack_xrun_locked(vss, runtime);
+
+		/* ACK includes any subperiod tail already copied to the ring. */
+		bytes = frames_to_bytes(runtime, appl_diff);
+		outstanding = vss->capture_copied_total -
+			      vss->capture_acked_total;
+		if ((!free_running && bytes > vss->capture_ready) ||
+		    (free_running &&
+		     (bytes > vss->buffer_bytes || bytes > outstanding)) ||
+		    check_add_overflow(vss->capture_acked_total, (u64)bytes,
+				       &next_acked_total) ||
+		    next_acked_total > vss->capture_pointer_seen_total) {
+			return virtsnd_pcm_ack_xrun_locked(vss, runtime);
+		}
+
+		vss->capture_acked_total = next_acked_total;
+		if (!free_running)
+			vss->capture_ready -= bytes;
+		vss->pcm_indirect.appl_ptr += appl_diff;
+		if (vss->pcm_indirect.appl_ptr >= runtime->boundary)
+			vss->pcm_indirect.appl_ptr -= runtime->boundary;
+	}
+
+	/* Preserve the queue -> substream lock order while refilling requests. */
 	scoped_guard(spinlock_irqsave, &queue->lock) {
 		guard(spinlock)(&vss->lock);
-		if (vss->preparing || !vss->prepared)
-			return -EBADFD;
-		if (vss->stopped)
-			return -EBADFD;
-		if (vss->xfer_xrun) {
-			rc = -EPIPE;
-		} else {
-			transfer.indirect = vss->pcm_indirect;
-			rc = virtsnd_pcm_playback_ack_validate(vss,
-							       substream->runtime,
-							       &transfer.indirect);
-			if (rc == -EBADFD ||
-			    (rc && substream->runtime->state ==
-			     SNDRV_PCM_STATE_PAUSED))
-				return -EBADFD;
-			if (!rc)
-				rc = snd_pcm_indirect_playback_transfer(substream,
-							       &transfer.indirect,
-							       virtsnd_pcm_trans_copy);
-			if (!rc)
-				rc = transfer.error;
-		}
-		if (rc)
-			virtsnd_pcm_transfer_failed(vss);
-		else
-			vss->pcm_indirect = transfer.indirect;
-	}
-	if (rc) {
-		dev_err(&vss->snd->vdev->dev,
-			"SID %u: playback ACK transfer failed: %d\n",
-			vss->sid, rc);
-		return -EPIPE;
-	}
-
+		if (vss->runtime_active && vss->xfer_enabled &&
+		    !vss->xfer_xrun) {
+			rc = virtsnd_pcm_capture_send(vss);
+			if (rc) {
+				vss->xfer_xrun = true;
+				if (runtime->state == SNDRV_PCM_STATE_PAUSED)
+					virtsnd_pcm_ack_xrun_locked(vss, runtime);
+				virtsnd_pcm_schedule_period_elapsed(vss);
+			}
+		}
+	}
+
+	if (rc)
+		dev_warn_ratelimited(&vss->snd->vdev->dev,
+				     "SID %u: failed to refill capture queue after ACK: %d\n",
+				     vss->sid, rc);
+
+	/* The ACK is committed; a refill failure is reported by the next XRUN. */
 	return 0;
 }
 
-static void virtsnd_pcm_legacy_capture_copy(struct snd_pcm_substream *substream,
-				   struct snd_pcm_indirect *rec, size_t bytes)
+static int virtsnd_pcm_cp_ack_locked(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
-
-	virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
-}
-
+	int rc = virtsnd_pcm_capture_ack(vss, substream->runtime);
+
+	if (rc == -EPIPE) {
+		guard(spinlock_irqsave)(&vss->lock);
+		virtsnd_pcm_transfer_failed(vss);
+	}
+	return rc;
+}
+
+/* Every linked member's prepare closes the ACK gate under its PCM lock. */
 static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	int rc;
+
+	/* RESET observes the pointer before returning discarded RX space. */
+	if (vss->indirect_reset_observing)
+		return 0;
+	rc = virtsnd_pcm_ack_state(substream);
+	if (rc)
+		return rc;
+	return virtsnd_pcm_cp_ack_locked(substream);
+}
+
+static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	bool teardown_pending;
+
+	guard(mutex)(&vss->lifecycle_lock);
+	scoped_guard(pcm_stream_lock_irqsave, substream) {
+		snd_pcm_state_t state = substream->runtime->state;
+
+		/*
+		 * Trigger holds the PCM lock through its control requests. Wait
+		 * for it, then leave a replacement active generation alone.
+		 * lifecycle_lock keeps prepare from replacing an inactive one
+		 * until sync_stop_locked has finished its teardown.
+		 */
+		guard(spinlock_irqsave)(&vss->lock);
+		teardown_pending = vss->prepared || vss->release_required ||
+			vss->msg_count || vss->device_running || vss->stopped;
+		if (state == SNDRV_PCM_STATE_RUNNING ||
+		    state == SNDRV_PCM_STATE_PAUSED ||
+		    state == SNDRV_PCM_STATE_PREPARED ||
+		    (state == SNDRV_PCM_STATE_DRAINING &&
+		     substream->stream == SNDRV_PCM_STREAM_PLAYBACK)) {
+			/* Core may consume this marker before a later inactive teardown. */
+			if (teardown_pending)
+				substream->runtime->stop_operating = true;
+			return 0;
+		}
+		if (vss->resetting) {
+			substream->runtime->stop_operating = true;
+			return -ECANCELED;
+		}
+	}
+	return virtsnd_pcm_sync_stop_locked(substream);
+}
+
+static void virtsnd_pcm_capture_reset_error(struct virtio_pcm_substream *vss,
+					    struct snd_pcm_runtime *runtime)
+{
+	size_t position = frames_to_bytes(runtime, runtime->status->hw_ptr);
+	size_t period = snd_pcm_lib_period_bytes(vss->substream);
+
+	vss->pcm_indirect.appl_ptr = runtime->status->hw_ptr;
+	vss->pcm_indirect.sw_ready = 0;
+	vss->hw_ptr = position;
+	vss->capture_copied_total = position;
+	vss->capture_acked_total = position;
+	vss->capture_pointer_seen_total = position;
+	vss->capture_ready = 0;
+	vss->capture_notified_periods = period ? position / period : 0;
+	vss->capture_callback_snapshot_active = false;
+	if (vss->xfer_xrun) {
+		virtsnd_pcm_transfer_failed(vss);
+		virtsnd_pcm_schedule_period_elapsed(vss);
+	}
+}
+
+/* The core holds the stream lock through the matching appl_ptr reset. */
+static int virtsnd_pcm_reset(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	size_t position;
+	size_t period;
 	int rc;
 
-	rc = virtsnd_pcm_ack_state(substream);
+	/* Reclaim RX space atomically with the pointer observation. */
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->capture_reset_observing = true;
+	rc = snd_pcm_lib_reset(substream);
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->capture_reset_observing = false;
+	if (rc)
+		return rc;
+
+	guard(spinlock_irqsave)(&queue->lock);
+	guard(spinlock)(&vss->lock);
+	if (vss->resetting || vss->xfer_xrun) {
+		virtsnd_pcm_capture_reset_error(vss, runtime);
+		return 0;
+	}
+	if (snd_pcm_running(substream)) {
+		/* Keep completions arriving after the core's pointer observation. */
+		vss->capture_acked_total = vss->capture_pointer_seen_total;
+		vss->capture_ready = vss->capture_free_running ? 0 :
+			vss->capture_copied_total - vss->capture_acked_total;
+	} else if (runtime->state == SNDRV_PCM_STATE_PAUSED) {
+		/* Rebase paused RESET at the last sample actually committed. */
+		position = virtsnd_pcm_ring_offset(vss->capture_copied_total,
+						 vss->buffer_bytes);
+		runtime->status->hw_ptr = bytes_to_frames(runtime, position);
+		vss->hw_ptr = position;
+		vss->capture_acked_total = vss->capture_copied_total;
+		vss->capture_pointer_seen_total = vss->capture_copied_total;
+		vss->capture_ready = 0;
+		period = snd_pcm_lib_period_bytes(substream);
+		vss->capture_notified_periods = period ?
+			div64_ul(vss->capture_copied_total, period) : 0;
+	} else {
+		position = frames_to_bytes(runtime, runtime->status->hw_ptr);
+		vss->hw_ptr = position;
+		period = snd_pcm_lib_period_bytes(substream);
+		vss->capture_copied_total = position;
+		vss->capture_acked_total = position;
+		vss->capture_pointer_seen_total = position;
+		vss->capture_ready = 0;
+		vss->capture_notified_periods = period ? position / period : 0;
+	}
+	vss->capture_callback_snapshot = 0;
+	vss->capture_callback_snapshot_active = false;
+	vss->pcm_indirect.appl_ptr = runtime->status->hw_ptr;
+	if (snd_pcm_running(substream) && vss->xfer_enabled && vss->prepared) {
+		rc = virtsnd_pcm_capture_send(vss);
+		if (rc) {
+			vss->xfer_xrun = true;
+			virtsnd_pcm_schedule_period_elapsed(vss);
+		}
+	}
+	/* Complete the matching core pointer rebase before reporting XRUN. */
+	return 0;
+}
+
+/* RESET can discard partial fills only after the transport returns ownership. */
+static int virtsnd_pcm_playback_reset(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	size_t position;
+	int rc;
+
+	/* The PCM lock excludes new ACK submissions through the entire reset. */
+	scoped_guard(spinlock_irqsave, &queue->lock) {
+		guard(spinlock)(&vss->lock);
+		if (vss->msg_count)
+			return -EBUSY;
+	}
+	vss->indirect_reset_observing = true;
+	rc = snd_pcm_lib_reset(substream);
+	vss->indirect_reset_observing = false;
 	if (rc)
 		return rc;
 	guard(spinlock_irqsave)(&queue->lock);
 	guard(spinlock)(&vss->lock);
-	if (vss->preparing || !vss->prepared)
-		return -EBADFD;
-	if (vss->xfer_xrun)
-		return -EPIPE;
-	if (vss->stopped &&
-	    substream->runtime->state != SNDRV_PCM_STATE_DRAINING)
-		return -EBADFD;
-
-	return snd_pcm_indirect_capture_transfer(substream, &vss->pcm_indirect,
-						 virtsnd_pcm_legacy_capture_copy);
-}
-
-/**
- * virtsnd_pcm_reset() - Reset PCM pointers.
- * @substream: Kernel ALSA substream.
- *
- * Context: PCM stream lock held.
- * Return: 0 on success, -errno on failure.
- */
-static int virtsnd_pcm_reset(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_reset(substream);
+	position = frames_to_bytes(runtime, runtime->status->hw_ptr) %
+		   vss->buffer_bytes;
+	vss->hw_ptr = position;
+	vss->pcm_indirect.hw_io = position;
+	vss->pcm_indirect.hw_data = position;
+	vss->pcm_indirect.sw_io = position;
+	vss->pcm_indirect.sw_data = position;
+	vss->pcm_indirect.hw_ready = 0;
+	vss->pcm_indirect.sw_ready = 0;
+	vss->pcm_indirect.appl_ptr = runtime->status->hw_ptr;
+	virtsnd_pcm_msg_reset(vss);
+	return 0;
 }
 
 /* PCM substream operators map. */
@@ -855,11 +2243,11 @@
 		.hw_free = virtsnd_pcm_hw_free,
 		.prepare = virtsnd_pcm_prepare,
 		.prepare_complete = virtsnd_pcm_prepare_complete,
-		.reset = virtsnd_pcm_reset,
 		.trigger = virtsnd_pcm_trigger,
 		.sync_stop = virtsnd_pcm_sync_stop,
 		.pointer = virtsnd_pcm_pb_pointer,
 		.ack = virtsnd_pcm_pb_ack,
+		.reset = virtsnd_pcm_playback_reset,
 	},
 	{
 		.open = virtsnd_pcm_open,
@@ -869,10 +2257,25 @@
 		.hw_free = virtsnd_pcm_hw_free,
 		.prepare = virtsnd_pcm_prepare,
 		.prepare_complete = virtsnd_pcm_prepare_complete,
-		.reset = virtsnd_pcm_reset,
 		.trigger = virtsnd_pcm_trigger,
 		.sync_stop = virtsnd_pcm_sync_stop,
 		.pointer = virtsnd_pcm_cp_pointer,
 		.ack = virtsnd_pcm_cp_ack,
 	},
 };
+
+/* All capture access uses validated request-owned payloads. */
+static const struct snd_pcm_ops virtsnd_pcm_capture_ops = {
+	.open = virtsnd_pcm_open,
+	.close = virtsnd_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.reset = virtsnd_pcm_reset,
+	.hw_params = virtsnd_pcm_hw_params,
+	.hw_free = virtsnd_pcm_hw_free,
+	.prepare = virtsnd_pcm_prepare,
+	.prepare_complete = virtsnd_pcm_prepare_complete,
+	.trigger = virtsnd_pcm_trigger,
+	.sync_stop = virtsnd_pcm_sync_stop,
+	.pointer = virtsnd_pcm_cp_pointer,
+	.ack = virtsnd_pcm_cp_ack,
+};
