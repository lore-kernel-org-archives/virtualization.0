Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664286;
	b=PtPm1SRMsETrj+6w5CKEZv0nWNNcJPIxm8Spv4jB0H+fk4InRVNgNix0PbNA89r+ZFxA
	 URjkhNjYfPa/K64i+ocNVRgNNEsdw66pJr7bFmzbWVh5U9/N7nrn+3/K/mZtyDXRSjWvr
	 ZvKbiuNECtLWtHjF+04cbQ7UuumUd4lk5zFkTTAGcQ3E0qlGbnWE20zxle93GKpm8riN1
	 Ff60HcOwW8r1S9yxSppq96DK/oWaeD8ChIdBDglwXHPhSHwT8+hWoC938ZlbDjkN89ElR
	 2UEza/Ill06riiKiYN2FYp1gG5gdeF4jYmjU9ta5Jj2E3AeYQGawIVNVwc+IF9p7sXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rjdZCuqRmuTCk80TLsyTv82BXuN0FhxzAQhKYyXG0Vk=;
	b=U4gHq7AFgQvPgBYSBzbQ/fdpkZO0LVdrEmCtAgQtqNzv5w1EROF3POl/2PoDT79ffi5x
	 ZLOUmr3z75JX/VX2pFlufd2hdqnF/94vym7G9GC7NpaDKDTV/VmFA6wmVLHpEegPv/qQr
	 kYsejyR0R4T82hEtIPkz46wwTOBj4MgQ2QwkQAaV2rMjWNvI+delO6AxEQASRcLsCuQLy
	 V1Iej7Wz4qcl4rmh6MlFqXTao7xk9/g0gwRold0rMnaokKBY9KmzUrfNWx2dCnClYkIfb
	 aNDU+TBAdjOnVuvnm/lDiQZ6K0NBbRCBRLKb7t3F+rYarIbfoZ8DjGzOCJ5D8uYIdhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iaO9+/+J";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A42606D816
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02A42606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iaO9+/+J
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so1633947a91.3
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 16:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793664284; x=1794269084; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rjdZCuqRmuTCk80TLsyTv82BXuN0FhxzAQhKYyXG0Vk=;
        b=iaO9+/+J1vdxPg3/QDAdgS0H9DKSICqrsHXRY9q+PUv9WAYkzXeRG6in22GYeVIw1Z
         DyQs2eyDAuWE+IdCwQPedDCS11zhZ2iwF2CtMKPkXrnwoLtn77Lf7WqNFEbLz/83rh3a
         4L2h633K6Sa8LuF2qLJcoH5+RvkJ6J64ToVgKQnzwyQKVBRCw53oYkq0KhjUkDA9SjnW
         kP+15OVmuyHAco7E636rFXKAhaS+xTYuGVvs2XuxtHTqyi+XCwgsbElJl14lqCf15Vd8
         BCU5LFH3zz/Xsn4K5lQ0doJMuiq0G0muuSUYAoCdgorO0aFrkLoGubzFneynEL3GsdNL
         N3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664284; x=1794269084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rjdZCuqRmuTCk80TLsyTv82BXuN0FhxzAQhKYyXG0Vk=;
        b=hYCiK5W1wqLF7lKvlW8eVqxE523Efd4rnznD4zG9E7Iv0d3OdCwO+zZFSPnudL5ceZ
         d2sebD/9QuKhprcLGhGr9t0zg5Yvcm6YsglCYHEt30fH/ZSm6jw5v3PSfuvLL7nkrppQ
         B8N2av6hcAQKMLFd08NTIPbl/FSumVRN3ARdf+jsTjiEasWMH8WrrTQWrIM7CCN/E07X
         LUZ9I5INbI7rbVb39fJ9iJdPEhKigS620t4nOoMHltY0SRaMPM4YIpYU31V3RTYoq9V4
         La9Gy8miDrafr7/oS1nlgbDAdA0i/XZIOoWHVZf6M4LpV5XnAf/aMfx+i//cLm9mHkGf
         NSzg==
X-Forwarded-Encrypted: i=1; AKwUvBxzJn30Xp+VUUmHgEL1v+BVBP7uHtNrfBGz4cioagHjV+6viBldbjnApaT7/vNPDCeQ3n+kHKRUhXqbVzLZxQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9IrsVuTrKN/P8bndmfRk0gJPp0l737X4Atf5JwwQCR1fb1yqEm
	cfQaVFGDNhGw9z9XPj4dW4z7yZWLi1eem3dFKx5O0GVRoCNn3BIrgjYR
X-Gm-Gg: AYBFou2ppuCRuatEKlN4RoW85gGpQbezGB1HO8DVgAzCfo4D90GI8hAiwTrhA5TbUcg
	+74CFPlrc28CDCQZ7/Mzf+bFTgOuOdOeXGDzFl5FMNQ6qP3ois1MpsJMw6LtB09lYhspj5nkgyg
	luhNLFBCdk5xZ4wjZM0DIXM/BpP/HQTc+rNml2DnMa4uwFXQlBkKsrPuXVZI7ifmZq0nq2MCNM0
	QTXIf07lEEa4m6aZRCb2zzF5/3xJJlc/OgMr7AHNTHGmHcknZLKnAUhbVJwdYQRaihaMLlOJc9g
	oxAQ10bGg/hO4OFOpahEsGBARuNhScIWyYHYXl2FGzOae3rF8omDxFLz/E6cMJvwpEbzUlCKsKm
	w+qXWaO5gPHy5JJh1bS0djwQTWz93YkMfwiqHB52QMMLwiR8wbTWlm39XeMQbk2mYqz71rZsSdz
	j6V4Zse+Izb0cUHHW8CB0KBgaOGny/7biLFsrURfDLPvdRFfpC70CrnxLqW+LF8y8GzG7RU7Bdi
	xY5LDkPKXwB4VJKzhfNlDbXD6RwYCjB/NFAN+cvBmgd3v1vQS5q/ySgWHD5LZRSzMmLmZ/mp0Ib
	mwPTS/ReKJDzbtsHzhVTWn/nrflL8MFP9n3yoaLBRoJgsxBKcV3RU73O8mjNoOYMnSzxuVa92Co
	QZVZCtVmGDrVAvUZ9vNLeH1GUJXpnEVLATnSzraD79mmyzpI=
X-Received: by 2002:a17:90b:2549:b0:3ac:a7ee:678c with SMTP id 98e67ed59e1d1-3ae89536be7mr9276426a91.2.1793664283411;
        Mon, 02 Nov 2026 16:04:43 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm1339225a91.13.2026.11.02.16.04.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 16:04:42 -0800 (PST)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
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
Subject: [PATCH v12 10/12] ALSA: virtio: add staged capture and serialize PCM lifecycle accounting
Date: Tue,  3 Nov 2026 09:04:01 +0900
Message-ID: <20261103000403.67106-11-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103000403.67106-1-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
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

Staged capture needs request-owned DMA storage and separate produced,
observed and consumed positions when shared clients use a boundary stop
threshold. Synchronize policy, RX completion and acknowledgment under
the queue and substream locks, with lifecycle_lock covering control work.

The v11 ACK path tried buffer_mutex while holding the PCM stream lock.
Core RESET, parameter refinement and linked prepare can already hold that
mutex, so normal ACK returned -EBADFD. Serialize ACK and prepare accounting
through the PCM lock instead. Set a preparing gate before dropping that
lock for PREPARE; clear it in the RESET callback while the core keeps the
same lock through the public appl_ptr rebase. A later linked member can
sleep in prepare without exposing half-rebased private accounting.

Use the preceding optional RESET operation for playback and both capture
modes. Retain common pointer/time handling and rebase private appl_ptr
with the public pointer. Preserve queued TX ownership on playback RESET.
Reset staged accounting and ordinary capture sw_ready after a successful
prepare, including repeated RESET from PREPARED.

Native pause can return RX buffers while transfers are disabled. Accept
those completions for a live prepared capture epoch, and refill only when
transfers are enabled. Keep the period notification floor across resume;
report recovery progress without inventing PCM timer ticks. Latch XRUN
on device events and failed STOP, reject ACK from invalid or stopped
states, and keep successful prepared accounting until PREPARE succeeds.
Compatibility pause retains its released-epoch handling.

Validate ordinary RX status and payload before advancing counters. Empty
STOP completions carry no frames. Preserve full-ring XRUN protection:
a delayed observation can mean real DMA overwrite. Recovering that case
by exposing the modulo pointer returned an old ring of samples in tests.

Use gcd(frame_bits, 8) for byte alignment so packed 4-bit frames retain
byte-aligned queue boundaries. Keep the queue-to-substream lock order.
The compatibility options remain disabled by default.

ARM64 QEMU tests reproduced ACK contention, failed prepare and STOP,
paused RX, status-only RX and reset recovery. The corrected source passed
56 KASAN/KCSAN transition checks and four linked prepare/ACK checks.
RW and MMAP capture, RESET, pause/resume and reopen produced 14,208,000
oracle-matched samples. Physical VZ capture remains untested for this
revision. Sample tests cover mono S16 at 48 kHz.

Link: https://sashiko.dev/#/patchset/20261031020855.2402-1-mynameisjune111%40gmail.com
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -350,6 +350,22 @@
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
+		vss->device_running = false;
+		vss->release_required = false;
+		vss->control_uncertain = false;
+		vss->capture_reset_observing = false;
+		vss->xfer_enabled = false;
+		vss->suspended = true;
+	}
 	virtio_reset_device(vdev);
 
 	/* Deleting a virtqueue does not unmap its outstanding descriptors. */
@@ -367,8 +383,16 @@
 		queue->vqueue = NULL;
 		spin_unlock_irqrestore(&queue->lock, flags);
 	}
-
 	vdev->config->del_vqs(vdev);
+	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
+		struct virtio_pcm_substream *vss = &snd->substreams[i];
+
+		cancel_work_sync(&vss->elapsed_period);
+		guard(spinlock_irqsave)(&vss->lock);
+		vss->stopped = false;
+		vss->xfer_xrun = false;
+		vss->pause_restart_state = VIRTSND_PCM_PAUSE_RESTART_NONE;
+	}
 }
 
 /**
@@ -441,6 +465,7 @@
 {
 	struct virtio_snd *snd = vdev->priv;
 	int rc;
+	unsigned int i;
 
 	rc = virtsnd_find_vqs(snd);
 	if (rc)
@@ -449,6 +474,12 @@
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
@@ -310,8 +310,119 @@
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
+	bool staged_capture;
+	bool paused_xrun = false;
+	bool notify = false;
+	bool partial = false;
+	bool requeue = false;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		staged_capture = vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+				 vss->capture_staging;
+	}
+
+	/* Serialize the pointer snapshot with ALSA's pointer and ACK callbacks. */
+	guard(pcm_stream_lock_irqsave)(substream);
+	if (!substream->runtime)
+		return;
+	if (!snd_pcm_running(substream)) {
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			runtime = substream->runtime;
+			paused_xrun = runtime &&
+				      runtime->state == SNDRV_PCM_STATE_PAUSED &&
+				      vss->xfer_xrun;
+			if (paused_xrun)
+				virtsnd_pcm_capture_arm_paused_stop(vss);
+		}
+		if (paused_xrun) {
+			/* Stop paused transfers and wake blocked readers. */
+			snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+		}
+		return;
+	}
+
+	if (!staged_capture) {
+		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+			guard(spinlock_irqsave)(&vss->lock);
+			period_bytes = snd_pcm_lib_period_bytes(substream);
+			period_floor = period_bytes ?
+				div64_ul(vss->capture_copied_total, period_bytes) : 0;
+			partial = vss->xfer_xrun ||
+				period_floor <= vss->capture_notified_periods;
+			if (!partial)
+				vss->capture_notified_periods = period_floor;
+		}
+		/* Resume recovery can wake readers without a new period IRQ. */
+		if (partial)
+			snd_pcm_progress_under_stream_lock(substream);
+		else
+			snd_pcm_period_elapsed_under_stream_lock(substream);
+		return;
+	}
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		runtime = substream->runtime;
+		if (!vss->runtime_active ||
+		    (!vss->xfer_enabled && !vss->xfer_xrun) || !runtime)
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
+	/* Pin the callback position while completions keep updating actual totals. */
+	if (partial)
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
@@ -351,8 +462,10 @@
 		vss->snd = snd;
 		vss->sid = i;
 		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
+		disable_work(&vss->elapsed_period);
 		init_waitqueue_head(&vss->msg_empty);
 		spin_lock_init(&vss->lock);
+		mutex_init(&vss->lifecycle_lock);
 	}
 
 	info = kzalloc_objs(*info, snd->nsubstreams);
@@ -486,7 +599,7 @@
 			snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops[i]);
 		}
 
-		snd_pcm_set_managed_buffer_all(vpcm->pcm,
+		snd_pcm_lib_preallocate_pages_for_all(vpcm->pcm,
 					       SNDRV_DMA_TYPE_VMALLOC, NULL,
 					       0, 0);
 	}
@@ -517,8 +630,13 @@
 		break;
 	case VIRTIO_SND_EVT_PCM_XRUN:
 		scoped_guard(spinlock, &vss->lock) {
-			if (vss->xfer_enabled)
+			if (vss->xfer_enabled ||
+			    (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+			     vss->prepared && !vss->stopped)) {
 				vss->xfer_xrun = true;
+				if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+					virtsnd_pcm_schedule_period_elapsed(vss);
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
@@ -26,17 +45,44 @@
  * @pcm_indirect: Kernel indirect pcm structure.
  * @hw: Kernel ALSA substream hardware descriptor.
  * @elapsed_period: Kernel work to handle the elapsed period state.
+ * @lifecycle_lock: Serializes prepare with synchronous release, outside trigger.
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
+ * @capture_notified_periods: Highest full-period boundary reserved for notify.
+ * @capture_callback_snapshot: Capture position fixed for the period callback.
+ * @capture_callback_snapshot_active: The callback must use its fixed position.
+ * @runtime_active: ALSA runtime buffer may be accessed by the staged path.
+ * @capture_staging: Capture uses request-owned payload buffers.
  * @capture_rx_seeded: Ordinary capture ring was queued since prepare.
+ * @capture_started: Non-empty capture data was received since prepare.
+ * @capture_empty: Consecutive empty startup completions.
+ * @capture_free_running: Cached staged-capture policy, protected by @lock.
  * @xfer_enabled: Data transfer state (0 - off, 1 - on).
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
  * @stopped: True if the substream is stopped and must be released on the device
  *           side; protected by @lock.
+ * @prepared: Device PREPARE succeeded; protected by @lock.
+ * @preparing: ACK gate held through prepare's core pointer reset; protected by
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
@@ -57,15 +103,38 @@
 	struct snd_pcm_hardware hw;
 	struct work_struct elapsed_period;
 	spinlock_t lock;
+	struct mutex lifecycle_lock;
+	u64 reset_epoch;
+	bool resetting;
 	size_t buffer_bytes;
 	size_t hw_ptr;
+	size_t capture_ready;
+	snd_pcm_uframes_t capture_boundary;
+	u64 capture_copied_total;
+	u64 capture_acked_total;
+	u64 capture_pointer_seen_total;
+	u64 capture_notified_periods;
+	u64 capture_callback_snapshot;
+	bool capture_callback_snapshot_active;
+	bool runtime_active;
+	bool capture_staging;
+	bool capture_started;
 	bool capture_rx_seeded;
+	bool capture_free_running;
+	unsigned int capture_empty;
 	bool xfer_enabled;
 	bool xfer_xrun;
 	bool stopped;
-	/* Successful PREPARE still needs RELEASE; protected by lock. */
+	bool prepared;
+	bool preparing;
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
@@ -78,6 +147,64 @@
 	wait_queue_head_t msg_empty;
 };
 
+/* Caller holds the PCM stream lock and vss->lock. */
+static inline void
+virtsnd_pcm_capture_arm_paused_stop(struct virtio_pcm_substream *vss)
+{
+	struct snd_pcm_runtime *runtime = vss->substream->runtime;
+
+	lockdep_assert_held(&vss->lock);
+	if (!runtime || runtime->state != SNDRV_PCM_STATE_PAUSED)
+		return;
+
+	/* ALSA skips trigger(STOP) when moving a paused stream to XRUN. */
+	vss->xfer_enabled = false;
+	vss->stopped = true;
+	runtime->stop_operating = true;
+}
+
+/* Keep non-staged PCM notifications on schedule_work()'s normal queue. */
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
@@ -108,6 +235,11 @@
 
 extern const struct snd_pcm_ops virtsnd_pcm_ops[];
 
+extern bool virtsnd_capture_staging;
+extern bool virtsnd_capture_packed_status;
+extern bool virtsnd_capture_allow_short;
+extern bool virtsnd_capture_allow_empty;
+
 int virtsnd_pcm_validate(struct virtio_device *vdev);
 
 int virtsnd_pcm_parse_cfg(struct virtio_snd *snd);
@@ -126,11 +258,16 @@
 
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
@@ -16,14 +19,16 @@
  * @xfer: Request header payload.
  * @status: Response header payload.
  * @length: Data length in bytes.
+ * @data: Request-owned payload for staged capture.
  * @data_offset: Offset in the driver-owned PCM buffer on NOMMU systems.
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
 #ifndef CONFIG_MMU
 	size_t data_offset;
 #endif
@@ -228,6 +233,8 @@
 	if (check_mul_overflow((size_t)periods, (size_t)period_bytes,
 			       &buffer_bytes))
 		return -EOVERFLOW;
+	if (vss->capture_staging && periods < 2)
+		return -EINVAL;
 
 	if (!vss->substream || !vss->substream->runtime)
 		return -EINVAL;
@@ -236,14 +243,19 @@
 		return -EINVAL;
 
 #ifdef CONFIG_MMU
-	rc = virtsnd_pcm_dma_pages_get(vss, runtime->dma_area, buffer_bytes);
-	if (rc)
-		return rc;
+	if (!vss->capture_staging) {
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
+	if (!vss->capture_staging) {
+		vss->owned_dma_area = kzalloc(buffer_bytes, GFP_KERNEL);
+		if (!vss->owned_dma_area)
+			return -ENOMEM;
+		vss->owned_dma_bytes = buffer_bytes;
+	}
 #endif
 
 	vss->msgs = kzalloc_objs(*vss->msgs, periods);
@@ -255,32 +267,54 @@
 	vss->nmsgs = periods;
 
 	for (i = 0; i < periods; ++i) {
-		int sg_num;
 		struct virtio_pcm_msg *msg;
 		u8 *data;
+		int sg_num;
+
+		if (vss->capture_staging) {
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
+			if (vss->capture_staging)
+				vfree(data);
 			rc = sg_num;
 			goto err_free_msgs;
 		}
 
 		msg = kzalloc_flex(*msg, sgs, sg_num + 2);
 		if (!msg) {
+			if (vss->capture_staging)
+				vfree(data);
 			rc = -ENOMEM;
 			goto err_free_msgs;
 		}
 
 		msg->substream = vss;
+		msg->data = vss->capture_staging ? data : NULL;
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
 #ifndef CONFIG_MMU
 		msg->data_offset = (size_t)period_bytes * i;
 #endif
@@ -316,8 +350,14 @@
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
@@ -339,15 +379,26 @@
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
+	vss->capture_ready = 0;
+	vss->capture_copied_total = 0;
+	vss->capture_acked_total = 0;
+	vss->capture_pointer_seen_total = 0;
+	vss->capture_notified_periods = 0;
+	vss->capture_callback_snapshot = 0;
+	vss->capture_callback_snapshot_active = false;
+	vss->capture_boundary = 0;
+	vss->capture_free_running = false;
+	vss->capture_empty = 0;
+	vss->capture_started = false;
 	vss->capture_rx_seeded = false;
 }
 
@@ -378,6 +429,8 @@
 	bool notify = false;
 	int rc;
 
+	if (!vqueue || !vss->prepared || vss->suspended)
+		return -EBADFD;
 	if (!bytes)
 		return 0;
 	if (!period_bytes || !vss->msgs || offset >= vss->buffer_bytes ||
@@ -403,8 +456,8 @@
 
 		msg->length += n;
 		if (msg->length == period_bytes) {
-			msg->xfer.stream_id = cpu_to_le32(vss->sid);
-			memset(&msg->status, 0, sizeof(msg->status));
+			msg->xfer->stream_id = cpu_to_le32(vss->sid);
+			memset(msg->status, 0, sizeof(*msg->status));
 
 #ifndef CONFIG_MMU
 		if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -478,6 +531,293 @@
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
+	if (!vss->capture_staging || !vss->runtime_active || !vss->substream)
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
+	    !vss->capture_staging || !vss->runtime_active)
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
+		if (msg->length)
+			continue;
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
+	if (msg->substream->capture_staging && virtsnd_capture_packed_status) {
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
+static void virtsnd_pcm_capture_complete(struct virtio_pcm_msg *msg,
+					 size_t written_bytes)
+{
+	struct virtio_pcm_substream *vss = msg->substream;
+	size_t audio_bytes = 0;
+	size_t next_ready = 0;
+	u64 next_copied_total = 0;
+	bool free_running = false;
+	bool got_audio = false;
+
+	guard(spinlock)(&vss->lock);
+	vss->msg_count--;
+	/* Native pause stops refills but must retain requests already in flight. */
+	if (vss->runtime_active && vss->prepared && !vss->stopped &&
+	    !vss->xfer_xrun) {
+		struct snd_pcm_runtime *runtime = vss->substream->runtime;
+		size_t frame_bytes = runtime ?
+			runtime->frame_bits / gcd(runtime->frame_bits, 8) : 0;
+		u32 latency_bytes;
+		const char *invalid_reason = NULL;
+
+		/* A full ring is modulo-ambiguous, so fail closed before copying. */
+		if (!runtime || !runtime->dma_area)
+			invalid_reason = "runtime";
+		else if (virtsnd_pcm_capture_refresh_mode_locked(vss,
+								 &free_running))
+			invalid_reason = "policy";
+		else if (!virtsnd_pcm_capture_counters_valid(vss))
+			invalid_reason = "counters";
+		else if (vss->hw_ptr !=
+			 virtsnd_pcm_ring_offset(vss->capture_copied_total, vss->buffer_bytes))
+			invalid_reason = "hw_ptr";
+		else if (virtsnd_pcm_capture_status(msg, written_bytes,
+						    frame_bytes, &audio_bytes,
+						    &latency_bytes))
+			invalid_reason = "status";
+		else if (check_add_overflow(vss->capture_copied_total,
+					    (u64)audio_bytes,
+					    &next_copied_total))
+			invalid_reason = "total_overflow";
+		else if (free_running && audio_bytes >= vss->buffer_bytes)
+			invalid_reason = "payload_exceeds_ring";
+		else if (!free_running &&
+			 audio_bytes >= vss->buffer_bytes - vss->capture_ready)
+			invalid_reason = "ring_capacity";
+		else if (!free_running &&
+			 check_add_overflow(vss->capture_ready, audio_bytes,
+					    &next_ready))
+			invalid_reason = "ready_overflow";
+		else if (!free_running && next_ready >= vss->buffer_bytes)
+			invalid_reason = "ring_full";
+		else if (free_running &&
+			 (next_copied_total < vss->capture_pointer_seen_total ||
+			  next_copied_total - vss->capture_pointer_seen_total >=
+			  vss->buffer_bytes))
+			invalid_reason = "pointer_window";
+		else if (free_running)
+			next_ready = 0;
+
+		if (invalid_reason) {
+			virtsnd_pcm_capture_xrun_locked(vss);
+			dev_warn_ratelimited(&vss->snd->vdev->dev,
+					     "SID %u: staged capture completion rejected (%s)\n",
+					     vss->sid, invalid_reason);
+		} else if (!audio_bytes) {
+			unsigned int limit = min_t(unsigned int, vss->nmsgs,
+						   UINT_MAX / 2) * 2;
+
+			if (!virtsnd_capture_allow_empty || vss->capture_started ||
+			    vss->capture_empty >= limit) {
+				virtsnd_pcm_capture_xrun_locked(vss);
+			} else {
+				vss->capture_empty++;
+			}
+		} else if (audio_bytes < msg->length &&
+			   !virtsnd_capture_allow_short) {
+			virtsnd_pcm_capture_xrun_locked(vss);
+		} else {
+			size_t ring_ptr = virtsnd_pcm_ring_offset(vss->capture_copied_total,
+						  vss->buffer_bytes);
+			size_t first = min(audio_bytes,
+					   vss->buffer_bytes - ring_ptr);
+
+			memcpy(runtime->dma_area + ring_ptr, msg->data, first);
+			if (audio_bytes > first)
+				memcpy(runtime->dma_area, msg->data + first,
+				       audio_bytes - first);
+			vss->capture_copied_total = next_copied_total;
+			vss->hw_ptr = virtsnd_pcm_ring_offset(next_copied_total, vss->buffer_bytes);
+			vss->capture_ready = next_ready;
+			vss->capture_started = true;
+			vss->capture_empty = 0;
+			runtime->delay = bytes_to_frames(runtime, latency_bytes);
+			got_audio = true;
+		}
+	}
+
+	msg->length = 0;
+	if (vss->runtime_active && vss->xfer_enabled) {
+		if (!vss->xfer_xrun &&
+		    virtsnd_pcm_capture_enqueue(vss, free_running)) {
+			dev_warn_ratelimited(&vss->snd->vdev->dev,
+					     "SID %u: failed to refill capture queue\n",
+					     vss->sid);
+			virtsnd_pcm_capture_xrun_locked(vss);
+		}
+	} else if (!vss->msg_count) {
+		wake_up_all(&vss->msg_empty);
+	}
+	if (got_audio && !vss->xfer_xrun)
+		virtsnd_pcm_schedule_period_elapsed(vss);
+}
+
 /**
  * virtsnd_pcm_msg_pending_num() - Returns the number of pending I/O messages.
  * @vss: VirtIO substream.
@@ -529,9 +869,9 @@
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
@@ -540,19 +880,52 @@
 				     size_t written_bytes)
 {
 	struct virtio_pcm_substream *vss = msg->substream;
-
-	/*
-	 * hw_ptr always indicates the buffer position of the first I/O message
-	 * in the virtqueue. Therefore, on each completion of an I/O message,
-	 * the hw_ptr value is unconditionally advanced.
-	 */
+	size_t completed_bytes;
+	u32 latency_bytes;
+
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging) {
+		virtsnd_pcm_capture_complete(msg, written_bytes);
+		return;
+	}
+
+	/* Only completed TX requests and valid RX audio advance the pointer. */
 	guard(spinlock)(&vss->lock);
+	/* Empty STOP returns retire ownership without inventing captured data. */
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    (!vss->prepared ||
+	     (vss->stopped && written_bytes <= sizeof(*msg->status)))) {
+		msg->length = 0;
+		vss->msg_count--;
+		if (!vss->msg_count)
+			wake_up_all(&vss->msg_empty);
+		return;
+	}
+	completed_bytes = msg->length;
+	latency_bytes = le32_to_cpu(msg->status->latency_bytes);
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+		struct snd_pcm_runtime *runtime = vss->substream->runtime;
+		size_t frame_bytes = runtime->frame_bits / gcd(runtime->frame_bits, 8);
+
+		if (virtsnd_pcm_capture_status(msg, written_bytes, frame_bytes,
+					       &completed_bytes, &latency_bytes) ||
+		    !completed_bytes) {
+			vss->xfer_xrun = true;
+			msg->length = 0;
+			vss->msg_count--;
+			if (!vss->msg_count)
+				wake_up_all(&vss->msg_empty);
+			virtsnd_pcm_schedule_period_elapsed(vss);
+			return;
+		}
+	}
 #ifndef CONFIG_MMU
 	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
-	    vss->xfer_enabled && written_bytes > sizeof(msg->status)) {
+	    vss->prepared && !vss->stopped &&
+	    written_bytes > sizeof(*msg->status)) {
 		struct snd_pcm_runtime *runtime =
 			vss->substream ? vss->substream->runtime : NULL;
-		size_t reported_bytes = written_bytes - sizeof(msg->status);
+		size_t reported_bytes = written_bytes - sizeof(*msg->status);
 		size_t data_bytes = min_t(size_t, reported_bytes, msg->length);
 
 		if (!runtime || !runtime->dma_area || !vss->owned_dma_area ||
@@ -568,26 +941,16 @@
 			       vss->owned_dma_area + msg->data_offset, data_bytes);
 	}
 #endif
-	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
-	    written_bytes > sizeof(msg->status) &&
-	    written_bytes - sizeof(msg->status) > msg->length)
-		dev_err_ratelimited(&vss->snd->vdev->dev,
-				    "SID %u: capture length exceeds I/O message capacity\n",
-			vss->sid);
-	/*
-	 * If the capture substream returned an incorrect status, then just
-	 * increase the hw_ptr by the message size. Clamp valid capture lengths to
-	 * the actual SG payload capacity before accounting them.
-	 */
-	if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK ||
-	    written_bytes <= sizeof(msg->status)) {
-		vss->hw_ptr += msg->length;
-	} else {
-		size_t data_bytes = min_t(size_t,
-					  written_bytes - sizeof(msg->status),
-					  msg->length);
-
-		vss->hw_ptr += data_bytes;
+	vss->hw_ptr += completed_bytes;
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+		/* A full unseen ring cannot be represented by the modulo pointer. */
+		if (check_add_overflow(vss->capture_copied_total,
+				       (u64)completed_bytes,
+				       &vss->capture_copied_total) ||
+		    vss->capture_copied_total < vss->capture_pointer_seen_total ||
+		    vss->capture_copied_total - vss->capture_pointer_seen_total >=
+			vss->buffer_bytes)
+			vss->xfer_xrun = true;
 	}
 
 	if (vss->hw_ptr >= vss->buffer_bytes)
@@ -595,16 +958,17 @@
 
 	msg->length = 0;
 
-	vss->xfer_xrun = false;
+	/* Preserve a latched capture error until prepare recovers it. */
+	if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK)
+		vss->xfer_xrun = false;
 	vss->msg_count--;
 
-	if (vss->xfer_enabled) {
+	if (vss->xfer_enabled ||
+	    (vss->direction == SNDRV_PCM_STREAM_CAPTURE && vss->xfer_xrun)) {
 		struct snd_pcm_runtime *runtime = vss->substream->runtime;
 
-		runtime->delay =
-			bytes_to_frames(runtime,
-					le32_to_cpu(msg->status.latency_bytes));
-		schedule_work(&vss->elapsed_period);
+		runtime->delay = bytes_to_frames(runtime, latency_bytes);
+		virtsnd_pcm_schedule_period_elapsed(vss);
 	} else if (!vss->msg_count) {
 		wake_up_all(&vss->msg_empty);
 	}
@@ -664,6 +1028,7 @@
  * virtsnd_pcm_ctl_msg_alloc() - Allocate and initialize the PCM device control
  *                               message for the specified substream.
  * @vss: VirtIO PCM substream.
+ * @epoch: Operation generation captured before allocation.
  * @command: Control request code (VIRTIO_SND_R_PCM_XXX).
  * @gfp: Kernel flags for memory allocation.
  *
@@ -672,7 +1037,7 @@
  */
 struct virtio_snd_msg *
 virtsnd_pcm_ctl_msg_alloc(struct virtio_pcm_substream *vss,
-			  unsigned int command, gfp_t gfp)
+			  unsigned int command, gfp_t gfp, u64 epoch)
 {
 	size_t request_size = sizeof(struct virtio_snd_pcm_hdr);
 	size_t response_size = sizeof(struct virtio_snd_hdr);
@@ -690,6 +1055,7 @@
 
 		hdr->hdr.code = cpu_to_le32(command);
 		hdr->stream_id = cpu_to_le32(vss->sid);
+		virtsnd_ctl_msg_bind_pcm(msg, vss, epoch);
 	}
 
 	return msg;
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -3,9 +3,43 @@
  * virtio-snd: Virtio sound device
  * Copyright (C) 2021 OpenSynergy GmbH
  */
+#include <linux/moduleparam.h>
+#include <linux/overflow.h>
 #include <sound/pcm_params.h>
 
 #include "virtio_card.h"
+
+static const struct snd_pcm_ops virtsnd_pcm_capture_staged_ops;
+static const struct snd_pcm_ops virtsnd_pcm_capture_indirect_ops;
+
+bool virtsnd_capture_staging;
+module_param_named(capture_staging, virtsnd_capture_staging, bool, 0444);
+MODULE_PARM_DESC(capture_staging,
+		 "Use request-owned buffers for experimental PCM capture");
+
+bool virtsnd_capture_packed_status;
+module_param_named(capture_packed_status, virtsnd_capture_packed_status,
+		   bool, 0444);
+MODULE_PARM_DESC(capture_packed_status,
+		 "Read staged capture status after the actual audio payload");
+
+bool virtsnd_capture_allow_short;
+module_param_named(capture_allow_short, virtsnd_capture_allow_short,
+		   bool, 0444);
+MODULE_PARM_DESC(capture_allow_short,
+		 "Accept non-empty short staged capture responses");
+
+bool virtsnd_capture_allow_empty;
+module_param_named(capture_allow_empty, virtsnd_capture_allow_empty,
+		   bool, 0444);
+MODULE_PARM_DESC(capture_allow_empty,
+		 "Retry bounded empty startup capture responses");
+
+static bool virtsnd_capture_pause_restart;
+module_param_named(capture_pause_restart, virtsnd_capture_pause_restart,
+		   bool, 0444);
+MODULE_PARM_DESC(capture_pause_restart,
+		 "Release and reprepare staged capture streams across pause");
 
 /*
  * I/O messages lifetime
@@ -97,14 +131,242 @@
 };
 
 static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);
-
-static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss)
-{
-	scoped_guard(spinlock_irqsave, &vss->lock) {
+static int virtsnd_pcm_sync_stop_locked(struct snd_pcm_substream *substream);
+static int virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream *substream);
+
+static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss, u64 epoch)
+{
+	bool notify;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return;
+		vss->xfer_enabled = false;
+		vss->stopped = vss->release_required || vss->msg_count;
+		notify = vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+			 (!vss->capture_staging || vss->runtime_active);
+		if (notify)
+			vss->xfer_xrun = true;
+	}
+	vss->substream->runtime->stop_operating = true;
+	if (notify)
+		virtsnd_pcm_schedule_period_elapsed(vss);
+}
+
+static bool
+virtsnd_pcm_pause_restart_enabled(struct virtio_pcm_substream *vss)
+{
+	return virtsnd_capture_pause_restart && vss->capture_staging &&
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
-	}
+		vss->xfer_xrun = true;
+		if (reset_required)
+			vss->pause_restart_state =
+				VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
+	}
+	if (notify_xrun)
+		virtsnd_pcm_schedule_period_elapsed(vss);
 	vss->substream->runtime->stop_operating = true;
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
+	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
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
 }
 
 /**
@@ -119,23 +381,42 @@
 	struct virtio_pcm *vpcm = snd_pcm_substream_chip(substream);
 	struct virtio_pcm_stream *vs = &vpcm->streams[substream->stream];
 	struct virtio_pcm_substream *vss = vs->substreams[substream->number];
+	int rc;
 
 	substream->runtime->hw = vss->hw;
 	substream->private_data = vss;
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->capture_staging = virtsnd_capture_staging &&
+			vss->direction == SNDRV_PCM_STREAM_CAPTURE;
+		if (vss->capture_staging) {
+			vss->runtime_active = false;
+			vss->xfer_enabled = false;
+		}
+	}
+
+	/* Keep RESET operation selection fixed for the opened runtime. */
+	substream->ops = vss->capture_staging ?
+		&virtsnd_pcm_capture_staged_ops :
+		&virtsnd_pcm_ops[substream->stream];
+
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE && !vss->capture_staging)
+		substream->ops = &virtsnd_pcm_capture_indirect_ops;
 
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
@@ -147,6 +428,15 @@
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
 
@@ -159,6 +449,7 @@
  * @channels: Selected number of channels.
  * @format: Selected sample format (SNDRV_PCM_FORMAT_XXX).
  * @rate: Selected frame rate.
+ * @epoch: Operation generation captured before preparing the request.
  *
  * Context: Any context that permits to sleep.
  * Return: 0 on success, -errno on failure.
@@ -168,7 +459,7 @@
 				      unsigned int period_bytes,
 				      unsigned int channels,
 				      snd_pcm_format_t format,
-				      unsigned int rate)
+				      unsigned int rate, u64 epoch)
 {
 	struct virtio_snd_msg *msg;
 	struct virtio_snd_pcm_set_params *request;
@@ -194,7 +485,7 @@
 		return -EINVAL;
 
 	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_SET_PARAMS,
-					GFP_KERNEL);
+					GFP_KERNEL, epoch);
 	if (!msg)
 		return -ENOMEM;
 
@@ -213,7 +504,14 @@
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
@@ -232,8 +530,10 @@
 	unsigned int msg_count;
 	size_t period_buffer_bytes;
 	bool stopped;
+	u64 epoch;
 	int rc;
 
+	guard(mutex)(&vss->lifecycle_lock);
 	/* Fixed descriptors require whole-byte periods covering the buffer. */
 	if (check_mul_overflow((size_t)params_periods(hw_params),
 			       (size_t)params_period_bytes(hw_params),
@@ -243,6 +543,25 @@
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
+	if (vss->capture_staging) {
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			vss->runtime_active = false;
+			vss->xfer_enabled = false;
+		}
+		cancel_work_sync(&vss->elapsed_period);
+	}
 
 	scoped_guard(spinlock_irqsave, &vss->lock) {
 		msg_count = vss->msg_count;
@@ -260,11 +579,16 @@
 		return -EBADFD;
 	}
 
+	rc = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+	if (rc < 0)
+		return rc;
+	substream->runtime->buffer_changed = rc > 0;
+
 	rc = virtsnd_pcm_dev_set_params(vss, params_buffer_bytes(hw_params),
 					params_period_bytes(hw_params),
 					params_channels(hw_params),
 					params_format(hw_params),
-					params_rate(hw_params));
+					params_rate(hw_params), epoch);
 	if (rc)
 		return rc;
 
@@ -274,8 +598,14 @@
 	 */
 	virtsnd_pcm_msg_free(vss);
 
-	return virtsnd_pcm_msg_alloc(vss, params_periods(hw_params),
-				     params_period_bytes(hw_params));
+	rc = virtsnd_pcm_msg_alloc(vss, params_periods(hw_params),
+				   params_period_bytes(hw_params));
+	if (!rc && vss->capture_staging) {
+		scoped_guard(spinlock_irqsave, &vss->lock)
+			vss->runtime_active = true;
+	}
+
+	return rc;
 }
 
 /**
@@ -288,28 +618,95 @@
 static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
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
+	if (vss->capture_staging) {
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
- * virtsnd_pcm_prepare() - Prepare the PCM substream.
+ * virtsnd_pcm_prepare_locked() - Prepare the PCM substream.
  * @substream: Kernel ALSA substream.
  *
  * Context: Process context.
  * Return: 0 on success, -errno on failure.
  */
-static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
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
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		epoch = vss->reset_epoch;
+		stopped = vss->stopped || vss->release_required || vss->msg_count;
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
+		vss->prepared = false;
+		vss->preparing = true;
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
@@ -320,48 +717,370 @@
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
-		int rc;
 
 		rc = virtsnd_pcm_dev_set_params(vss, buffer_bytes, period_bytes,
 						runtime->channels,
-						runtime->format, runtime->rate);
-		if (rc)
+						runtime->format, runtime->rate, epoch);
+		if (rc) {
+			if (pause_restart && rc != -ECANCELED)
+				virtsnd_pcm_pause_restart_fail(vss, false, epoch);
 			return rc;
-	}
-
-	vss->xfer_xrun = false;
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
+		if (vss->capture_staging) {
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
+	guard(mutex)(&vss->lifecycle_lock);
+	return virtsnd_pcm_prepare_locked(substream);
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
+	int rc = 0;
+	u64 epoch;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		epoch = vss->reset_epoch;
+		state = vss->pause_restart_state;
+		reset_required =
+			state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
+			virtsnd_pcm_pause_restart_transitioning(state);
+		invalid_state =
+			vss->xfer_xrun ||
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
+			} else if (vss->pause_restart_state !=
+				    VIRTSND_PCM_PAUSE_RESTART_PREPARED ||
+			    vss->msg_count || !vss->runtime_active) {
+				rc = -EBADFD;
+			} else {
+				/* Preserve ring accounting, restarting only startup grace. */
+				vss->prepared = true;
+				vss->capture_started = false;
+				vss->capture_empty = 0;
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
+		} else if (vss->pause_restart_state !=
+			    VIRTSND_PCM_PAUSE_RESTART_PREPARED ||
+		    vss->msg_count || !vss->runtime_active || vss->xfer_xrun) {
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
+	int rc;
+	u64 epoch;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting)
+			return -ECANCELED;
+		epoch = vss->reset_epoch;
+		state = vss->pause_restart_state;
+		if (state == VIRTSND_PCM_PAUSE_RESTART_RELEASED) {
+			if (vss->xfer_xrun)
+				virtsnd_pcm_schedule_period_elapsed(vss);
+			return vss->xfer_xrun ? -EPIPE : 0;
+		}
+		vss->xfer_enabled = false;
+		vss->stopped = true;
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
+		if (!vss->prepared && !vss->msg_count)
+			return 0;
+		if (suspend)
+			vss->suspended = true;
+		vss->xfer_enabled = false;
+		vss->stopped = true;
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
-	if (!rc) {
-		guard(spinlock_irqsave)(&vss->lock);
-		vss->release_required = true;
-	}
+	rc = virtsnd_pcm_send_sync(vss, msg);
+	if (rc)
+		return rc;
+	guard(spinlock_irqsave)(&vss->lock);
+	if (vss->resetting || vss->reset_epoch != epoch)
+		return -ECANCELED;
+	vss->device_running = false;
+	return 0;
+}
+
+static int virtsnd_pcm_start_queue(struct virtio_pcm_substream *vss, u64 epoch)
+{
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	int rc = 0;
+
+	guard(spinlock_irqsave)(&queue->lock);
+	guard(spinlock)(&vss->lock);
+	if (vss->resetting || vss->reset_epoch != epoch)
+		return -ECANCELED;
+	if (vss->stopped || !vss->prepared || vss->xfer_xrun)
+		return vss->xfer_xrun ? -EPIPE : -EBADFD;
+	if (vss->control_uncertain)
+		return -EIO;
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+		if (vss->capture_staging) {
+			rc = vss->runtime_active ? virtsnd_pcm_capture_send(vss) : -EBADFD;
+		} else if (!vss->capture_rx_seeded) {
+			rc = virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
+			if (!rc)
+				vss->capture_rx_seeded = true;
+		}
+	}
+	if (!rc)
+		vss->xfer_enabled = true;
 	return rc;
 }
 
@@ -377,72 +1096,236 @@
 static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
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
-			if (vss->stopped) {
-				substream->runtime->stop_operating = true;
-				return -EBADFD;
-			}
-			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
-			    !vss->capture_rx_seeded) {
-				rc = virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
-				if (!rc)
-					vss->capture_rx_seeded = true;
-			}
-			if (rc) {
-				vss->stopped = true;
-				substream->runtime->stop_operating = true;
-				return rc;
-			}
-			vss->xfer_enabled = true;
+		scoped_guard(spinlock_irqsave, &vss->lock)
+			running = vss->device_running;
+		/* Preserve queued requests and unread RX data across native pause. */
+		rc = virtsnd_pcm_start_queue(vss, epoch);
+		if (rc) {
+			virtsnd_pcm_start_failed(vss, epoch);
+			return rc;
+		}
+
+		if (running) {
+			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+				virtsnd_pcm_schedule_period_elapsed(vss);
+			return 0;
 		}
 
 		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
-						GFP_KERNEL);
+						GFP_KERNEL, epoch);
 		if (!msg) {
-			virtsnd_pcm_start_failed(vss);
+			virtsnd_pcm_start_failed(vss, epoch);
 			return -ENOMEM;
 		}
 
-		rc = virtsnd_ctl_msg_send_sync(snd, msg);
-		if (rc)
-			virtsnd_pcm_start_failed(vss);
-
+		rc = virtsnd_pcm_send_sync(vss, msg);
+		if (rc && rc != -ECANCELED)
+			virtsnd_pcm_start_failed(vss, epoch);
+
+		if (!rc) {
+			guard(spinlock_irqsave)(&vss->lock);
+			if (vss->resetting || vss->reset_epoch != epoch)
+				return -ECANCELED;
+			vss->device_running = true;
+		}
+		if (!rc && vss->direction == SNDRV_PCM_STREAM_CAPTURE)
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
+			if (virtsnd_pcm_start_queue(vss, epoch)) {
+				guard(spinlock_irqsave)(&vss->lock);
+				if (vss->reset_epoch == epoch && !vss->resetting) {
+					vss->xfer_xrun = true;
+					vss->stopped = true;
+					substream->runtime->stop_operating = true;
+					virtsnd_pcm_schedule_period_elapsed(vss);
+				}
+			} else if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+				virtsnd_pcm_schedule_period_elapsed(vss);
+			}
+		}
+		return rc;
 	default:
 		return -EINVAL;
 	}
+
+}
+
+static int
+virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
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
 }
 
 /**
- * virtsnd_pcm_sync_stop() - Synchronous PCM substream stop.
+ * virtsnd_pcm_sync_stop_locked() - Synchronous PCM substream stop.
  * @substream: Kernel ALSA substream.
  *
  * The function can be called both from the upper level or from the driver
@@ -451,7 +1334,7 @@
  * Context: Process context. Takes and releases the VirtIO substream spinlock.
  * Return: 0 on success, -errno on failure.
  */
-static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
+static int virtsnd_pcm_sync_stop_locked(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd *snd = vss->snd;
@@ -459,31 +1342,49 @@
 	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
 	bool need_release;
 	int rc;
-
-	scoped_guard(spinlock_irqsave, &vss->lock) {
+	u64 epoch;
+
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
 	}
 	cancel_work_sync(&vss->elapsed_period);
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
 			substream->runtime->stop_operating = true;
 			return -ENOMEM;
 		}
 
-		rc = virtsnd_ctl_msg_send_sync(snd, msg);
+		rc = virtsnd_pcm_send_sync(vss, msg);
 		if (rc) {
 			substream->runtime->stop_operating = true;
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
@@ -492,7 +1393,7 @@
 	 * Thus, we consider the absence of I/O messages in the queue as an
 	 * indication that the substream has been released.
 	 */
-	rc = wait_event_interruptible_timeout(vss->msg_empty,
+	rc = wait_event_timeout(vss->msg_empty,
 					      !virtsnd_pcm_msg_pending_num(vss),
 					      js);
 	if (rc <= 0) {
@@ -503,8 +1404,12 @@
 		return !rc ? -ETIMEDOUT : rc;
 	}
 
-	scoped_guard(spinlock_irqsave, &vss->lock)
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->resetting || vss->reset_epoch != epoch)
+			return -ECANCELED;
+		vss->prepared = false;
 		vss->stopped = false;
+	}
 
 	return 0;
 }
@@ -521,10 +1426,16 @@
 virtsnd_pcm_pb_pointer(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	size_t hw_ptr;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (!vss->prepared || vss->preparing)
+			return SNDRV_PCM_POS_XRUN;
+		hw_ptr = vss->hw_ptr;
+	}
 
 	return snd_pcm_indirect_playback_pointer(substream,
-		&vss->pcm_indirect,
-		vss->hw_ptr);
+		&vss->pcm_indirect, hw_ptr);
 }
 
 /**
@@ -539,10 +1450,62 @@
 virtsnd_pcm_cp_pointer(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	size_t hw_ptr = 0;
+	u64 total;
+	bool free_running;
+	bool xrun;
+
+	if (vss->capture_staging) {
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			xrun = vss->xfer_xrun;
+			if (!xrun &&
+			    virtsnd_pcm_capture_refresh_mode_locked(vss,
+								    &free_running))
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
+					vss->xfer_xrun = true;
+				} else {
+					vss->capture_pointer_seen_total = total;
+					if (vss->capture_reset_observing) {
+						size_t period = snd_pcm_lib_period_bytes(substream);
+
+						vss->capture_acked_total = total;
+						vss->capture_ready = 0;
+						vss->capture_notified_periods =
+							period ? div64_ul(total, period) : 0;
+					}
+					hw_ptr = virtsnd_pcm_ring_offset(total, vss->buffer_bytes);
+				}
+			}
+			if (xrun)
+				vss->xfer_xrun = true;
+		}
+
+		if (xrun)
+			return SNDRV_PCM_POS_XRUN;
+
+		return bytes_to_frames(substream->runtime, hw_ptr);
+	}
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->xfer_xrun || !vss->prepared || vss->preparing)
+			return SNDRV_PCM_POS_XRUN;
+		vss->capture_pointer_seen_total = vss->capture_copied_total;
+		hw_ptr = vss->hw_ptr;
+	}
 
 	return snd_pcm_indirect_capture_pointer(substream,
-		&vss->pcm_indirect,
-		vss->hw_ptr);
+		&vss->pcm_indirect, hw_ptr);
 }
 
 struct virtsnd_pcm_transfer {
@@ -557,7 +1520,9 @@
 	struct virtsnd_pcm_transfer *transfer =
 		container_of(rec, struct virtsnd_pcm_transfer, indirect);
 
-	if (transfer->error)
+	if (transfer->error ||
+	    (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
+	     substream->runtime->state == SNDRV_PCM_STATE_DRAINING))
 		return;
 
 	transfer->error = virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
@@ -571,7 +1536,7 @@
 	vss->substream->runtime->stop_operating = true;
 }
 
-static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
+static int virtsnd_pcm_pb_ack_locked(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
@@ -580,6 +1545,8 @@
 
 	scoped_guard(spinlock_irqsave, &queue->lock) {
 		guard(spinlock)(&vss->lock);
+		if (!vss->prepared || vss->preparing)
+			return -EBADFD;
 		transfer.indirect = vss->pcm_indirect;
 		if (vss->stopped) {
 			rc = -EPIPE;
@@ -606,17 +1573,136 @@
 	return 0;
 }
 
-static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
+/* The PCM lock serializes ACK with prepare's accounting reset. */
+static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+
+	if (vss->indirect_reset_observing)
+		return 0;
+	return virtsnd_pcm_pb_ack_locked(substream);
+}
+
+static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *vss,
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
+		snd_pcm_sframes_t diff;
+		size_t bytes;
+		u64 outstanding;
+		u64 next_acked_total;
+		bool free_running;
+
+		if (!vss->runtime_active || vss->preparing || !runtime || !runtime->control ||
+		    !runtime->dma_area || vss->suspended)
+			return -EBADFD;
+		if (!vss->prepared && runtime->state != SNDRV_PCM_STATE_DRAINING &&
+		    !(runtime->state == SNDRV_PCM_STATE_PAUSED &&
+		      virtsnd_pcm_pause_restart_enabled(vss) &&
+		      vss->pause_restart_state == VIRTSND_PCM_PAUSE_RESTART_RELEASED))
+			return -EBADFD;
+		if (vss->xfer_xrun)
+			return -EPIPE;
+		if (vss->stopped && runtime->state != SNDRV_PCM_STATE_DRAINING &&
+		    !(runtime->state == SNDRV_PCM_STATE_PAUSED &&
+		      virtsnd_pcm_pause_restart_enabled(vss) &&
+		      vss->pause_restart_state == VIRTSND_PCM_PAUSE_RESTART_RELEASED))
+			return -EPIPE;
+		rc = virtsnd_pcm_capture_refresh_mode_locked(vss,
+							     &free_running);
+		if (rc || !virtsnd_pcm_capture_counters_valid(vss)) {
+			vss->xfer_xrun = true;
+			virtsnd_pcm_schedule_period_elapsed(vss);
+			return -EPIPE;
+		}
+
+		appl_ptr = runtime->control->appl_ptr;
+		diff = appl_ptr - vss->pcm_indirect.appl_ptr;
+		if (diff < -(snd_pcm_sframes_t)(runtime->boundary / 2))
+			diff += runtime->boundary;
+		if (diff < 0 ||
+		    (snd_pcm_uframes_t)diff > runtime->buffer_size) {
+			vss->xfer_xrun = true;
+			virtsnd_pcm_schedule_period_elapsed(vss);
+			return -EPIPE;
+		}
+
+		/* ACK includes any subperiod tail already copied to the ring. */
+		bytes = frames_to_bytes(runtime, diff);
+		outstanding = vss->capture_copied_total -
+			      vss->capture_acked_total;
+		if ((!free_running && bytes > vss->capture_ready) ||
+		    (free_running &&
+		     (bytes > vss->buffer_bytes || bytes > outstanding)) ||
+		    check_add_overflow(vss->capture_acked_total, (u64)bytes,
+				       &next_acked_total) ||
+		    next_acked_total > vss->capture_pointer_seen_total) {
+			vss->xfer_xrun = true;
+			virtsnd_pcm_schedule_period_elapsed(vss);
+			return -EPIPE;
+		}
+
+		vss->capture_acked_total = next_acked_total;
+		if (!free_running)
+			vss->capture_ready -= bytes;
+		vss->pcm_indirect.appl_ptr = appl_ptr;
+	}
+
+	/* Preserve the queue -> substream lock order while refilling requests. */
+	scoped_guard(spinlock_irqsave, &queue->lock) {
+		guard(spinlock)(&vss->lock);
+		if (vss->runtime_active && vss->xfer_enabled &&
+		    !vss->xfer_xrun) {
+			rc = virtsnd_pcm_capture_send(vss);
+			if (rc) {
+				vss->xfer_xrun = true;
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
+	return 0;
+}
+
+static int virtsnd_pcm_cp_ack_locked(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct virtsnd_pcm_transfer transfer = {};
 	int rc;
 
+	if (vss->capture_staging) {
+		rc = virtsnd_pcm_capture_staged_ack(vss, runtime);
+		if (rc == -EPIPE) {
+			guard(spinlock_irqsave)(&vss->lock);
+			virtsnd_pcm_capture_arm_paused_stop(vss);
+		}
+		return rc;
+	}
+
 	scoped_guard(spinlock_irqsave, &queue->lock) {
 		guard(spinlock)(&vss->lock);
+		if (!vss->prepared || vss->preparing)
+			return -EBADFD;
 		transfer.indirect = vss->pcm_indirect;
-		if (vss->stopped) {
+		if (vss->xfer_xrun ||
+		    (vss->stopped && runtime->state != SNDRV_PCM_STATE_DRAINING)) {
 			rc = -EPIPE;
 		} else {
 			rc = snd_pcm_indirect_capture_transfer(substream,
@@ -638,6 +1724,217 @@
 		return -EPIPE;
 	}
 
+	return 0;
+}
+
+/* Every linked member's prepare closes the ACK gate under its PCM lock. */
+static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	/* RESET observes the pointer before returning discarded RX space. */
+	if (vss->indirect_reset_observing)
+		return 0;
+	switch (runtime->state) {
+	case SNDRV_PCM_STATE_XRUN:
+		return -EPIPE;
+	case SNDRV_PCM_STATE_PREPARED:
+	case SNDRV_PCM_STATE_RUNNING:
+	case SNDRV_PCM_STATE_PAUSED:
+	case SNDRV_PCM_STATE_DRAINING:
+		break;
+	default:
+		return -EBADFD;
+	}
+	return virtsnd_pcm_cp_ack_locked(substream);
+}
+
+static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
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
+		if (state == SNDRV_PCM_STATE_RUNNING ||
+		    state == SNDRV_PCM_STATE_PAUSED ||
+		    state == SNDRV_PCM_STATE_PREPARED ||
+		    (state == SNDRV_PCM_STATE_DRAINING &&
+		     substream->stream == SNDRV_PCM_STREAM_PLAYBACK))
+			return 0;
+		guard(spinlock_irqsave)(&vss->lock);
+		if (!vss->stopped)
+			return 0;
+	}
+	return virtsnd_pcm_sync_stop_locked(substream);
+}
+
+/*
+ * The PCM lock covers indirect accounting and core completion. Once lib_reset
+ * changes hw_ptr, complete the core rebase even if refilling fails. The latched
+ * XRUN rejects subsequent pointer/ACK operations; the worker publishes XRUN to
+ * paused streams too. RESET success therefore does not imply stream recovery.
+ */
+static int virtsnd_pcm_indirect_reset(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	struct virtsnd_pcm_transfer transfer = {};
+	snd_pcm_uframes_t paused_ptr = 0;
+	bool paused = runtime->state == SNDRV_PCM_STATE_PAUSED;
+	int rc;
+
+	/* Only PCM-locked callbacks access this observation flag. */
+	vss->indirect_reset_observing = true;
+	rc = snd_pcm_lib_reset(substream);
+	vss->indirect_reset_observing = false;
+	if (rc)
+		return rc;
+	guard(spinlock_irqsave)(&queue->lock);
+	guard(spinlock)(&vss->lock);
+	if (vss->resetting)
+		return 0;
+	vss->preparing = false;
+	if (vss->xfer_xrun) {
+		virtsnd_pcm_transfer_failed(vss);
+		virtsnd_pcm_schedule_period_elapsed(vss);
+		return 0;
+	}
+	if (!snd_pcm_running(substream) && !paused) {
+		vss->pcm_indirect.appl_ptr = runtime->status->hw_ptr;
+		vss->pcm_indirect.sw_ready = 0;
+		return 0;
+	}
+	if (!vss->prepared || vss->stopped) {
+		virtsnd_pcm_transfer_failed(vss);
+		vss->xfer_xrun = true;
+		virtsnd_pcm_schedule_period_elapsed(vss);
+		return 0;
+	}
+
+	transfer.indirect = vss->pcm_indirect;
+	if (paused) {
+		/* Observe and reclaim paused completions in one queue transaction. */
+		vss->capture_pointer_seen_total = vss->capture_copied_total;
+		vss->indirect_reset_observing = true;
+		paused_ptr = snd_pcm_indirect_capture_pointer(substream,
+							      &transfer.indirect, vss->hw_ptr);
+		vss->indirect_reset_observing = false;
+		if (paused_ptr == SNDRV_PCM_POS_XRUN) {
+			virtsnd_pcm_transfer_failed(vss);
+			vss->xfer_xrun = true;
+			virtsnd_pcm_schedule_period_elapsed(vss);
+			return 0;
+		}
+		runtime->status->hw_ptr = paused_ptr;
+	}
+	transfer.indirect.sw_ready = 0;
+	/* Consume no application delta while returning discarded RX space. */
+	transfer.indirect.appl_ptr = runtime->control->appl_ptr;
+	rc = snd_pcm_indirect_capture_transfer(substream, &transfer.indirect,
+					       virtsnd_pcm_trans_copy);
+	if (!rc)
+		rc = transfer.error;
+	if (rc) {
+		virtsnd_pcm_transfer_failed(vss);
+		vss->xfer_xrun = true;
+		virtsnd_pcm_schedule_period_elapsed(vss);
+		return 0;
+	}
+
+	/* RESET discards all samples through the observed software pointer. */
+	transfer.indirect.sw_ready = 0;
+	transfer.indirect.appl_ptr = runtime->status->hw_ptr;
+	vss->pcm_indirect = transfer.indirect;
+	{
+		size_t period = snd_pcm_lib_period_bytes(substream);
+
+		vss->capture_notified_periods = period ?
+			div64_ul(vss->capture_pointer_seen_total, period) : 0;
+	}
+	return 0;
+}
+
+/* The core holds the stream lock through the matching appl_ptr reset. */
+static int virtsnd_pcm_reset(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	size_t position;
+	size_t period;
+	int rc;
+
+	/* Reclaim RX space atomically with the pointer observation. */
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->capture_reset_observing = true;
+	rc = snd_pcm_lib_reset(substream);
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->capture_reset_observing = false;
+	if (rc || !vss->capture_staging)
+		return rc;
+
+	guard(spinlock_irqsave)(&queue->lock);
+	guard(spinlock)(&vss->lock);
+	if (vss->resetting)
+		return 0;
+	vss->preparing = false;
+	/* The common reset has already handled a pointer-reported XRUN. */
+	if (vss->xfer_xrun)
+		return 0;
+	if (snd_pcm_running(substream)) {
+		/* Keep completions arriving after the core's pointer observation. */
+		vss->capture_acked_total = vss->capture_pointer_seen_total;
+		vss->capture_ready = vss->capture_free_running ? 0 :
+			vss->capture_copied_total - vss->capture_acked_total;
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
+/* Keep queued TX ownership while rebasing the application's write cursor. */
+static int virtsnd_pcm_playback_reset(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	int rc;
+
+	vss->indirect_reset_observing = true;
+	rc = snd_pcm_lib_reset(substream);
+	vss->indirect_reset_observing = false;
+	if (rc)
+		return rc;
+	guard(spinlock_irqsave)(&vss->lock);
+	vss->preparing = false;
+	vss->pcm_indirect.appl_ptr = substream->runtime->status->hw_ptr;
+	vss->pcm_indirect.sw_ready = 0;
 	return 0;
 }
 
@@ -654,6 +1951,7 @@
 		.sync_stop = virtsnd_pcm_sync_stop,
 		.pointer = virtsnd_pcm_pb_pointer,
 		.ack = virtsnd_pcm_pb_ack,
+		.reset = virtsnd_pcm_playback_reset,
 	},
 	{
 		.open = virtsnd_pcm_open,
@@ -668,3 +1966,32 @@
 		.ack = virtsnd_pcm_cp_ack,
 	},
 };
+
+/* Selected at open; the staging policy remains fixed for that runtime. */
+static const struct snd_pcm_ops virtsnd_pcm_capture_staged_ops = {
+	.open = virtsnd_pcm_open,
+	.close = virtsnd_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.reset = virtsnd_pcm_reset,
+	.hw_params = virtsnd_pcm_hw_params,
+	.hw_free = virtsnd_pcm_hw_free,
+	.prepare = virtsnd_pcm_prepare,
+	.trigger = virtsnd_pcm_trigger,
+	.sync_stop = virtsnd_pcm_sync_stop,
+	.pointer = virtsnd_pcm_cp_pointer,
+	.ack = virtsnd_pcm_cp_ack,
+};
+
+static const struct snd_pcm_ops virtsnd_pcm_capture_indirect_ops = {
+	.open = virtsnd_pcm_open,
+	.close = virtsnd_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.reset = virtsnd_pcm_indirect_reset,
+	.hw_params = virtsnd_pcm_hw_params,
+	.hw_free = virtsnd_pcm_hw_free,
+	.prepare = virtsnd_pcm_prepare,
+	.trigger = virtsnd_pcm_trigger,
+	.sync_stop = virtsnd_pcm_sync_stop,
+	.pointer = virtsnd_pcm_cp_pointer,
+	.ack = virtsnd_pcm_cp_ack,
+};
