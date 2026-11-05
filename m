Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862573;
	b=GQQSFJxMWw5SjpUID1Wolcf2K/Oswlkxp/yCIXjOj3u2UWuJQ/rSQilrqIptpllWvr0v
	 qxhF0+kmL0xwtdZ5pOZEV8j4qE7aS5sp1V8T2lDZF4/qGT/r0nbViB7NVRE11IZ7+0/Tc
	 TZIe7P6HbX9aGJdKSJ3wWQ7bsNfx/CW6f1DHa3XbL3TMo/BdAXEHSUeMvHQU4qqqp6Jbu
	 72TdD8yZ87kj39JgJLd5/pU7hXzZ4FBYHJKfZZwmGIiFyYCg1MGD9Vd3HNYbwn0TPfLre
	 uiD/5+DEPBSebfNq4aW3hyRSj2tgIbJPQmU8Rkuh7vB4sMW0W6HgRVRa/QVtUQm5Yhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Iw67g4EDcO8Evs1cI/+ddT9bSMqLkpv3nkMDKAasjoM=;
	b=eVxh/Oxc3VLldmsoMT/cOjhHm0wcubhn5nRrJnpIKfRBZt90j22Ra0b/Y3kcYBr3+42i
	 FjXR/0S6dCrqIfhP0cAAv74wEcmBfdwp+vy7pb4MTCvCptq5dggEGNPBXb5ZC7n/wCsJS
	 3G+Er9+LkGJTVXw61FMCWyTnXtJE836unTdaI5VAnIJOKxaHT5h5Mt5kbZMm6BPiBGr9h
	 gAIvDKenbRBjJnAxkd84C2pzPixvKkvry0JxuUNRmnkmQ8tBbd8eGA/yvCyb38TnMwIen
	 TrASh8Q/CfA8XAcVhwYO/OqN9AhECWZgJQn2W16e9EujQX+5SFYVaJ4oGEphd95R4bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xgEaBvqo;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21E606A335
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A21E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xgEaBvqo
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a1947498bso4302753eec.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 23:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793862569; x=1794467369; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iw67g4EDcO8Evs1cI/+ddT9bSMqLkpv3nkMDKAasjoM=;
        b=xgEaBvqozwJw/IvYMN02iGpm5BX27dXnGh8hGHQwbUfgElwm6qJMvvDPKF9KchgV/I
         Wvj4jaYUgO5jRXEjNU7CTzzVamKO9VLzfhaaRR+sLW69fBV/dCFfyPzEBYnco1LZNgbU
         V5hM5w96kPPrhgCDx73OV7+oQM3ZguXaQhB4IjOrqAsYZ5MdzpHmc3bEoTUnqm9e/dq/
         0oxktNFcFoHSSMOB+Gp4H7ZhgsVHCQzJknP9xYiE8rpaAyS31hKAPXws2HvZqO2hETss
         FVnjWBGggKJTCMJCWqKvEcoVzIKm0xuTVD+0nG7SOG7wyoYgYU5mStl4A+Gn8Eolahke
         NreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793862569; x=1794467369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iw67g4EDcO8Evs1cI/+ddT9bSMqLkpv3nkMDKAasjoM=;
        b=yFyCB7RcFbI127SZOVKQ/mCAylMMlB+VJa4SGI7bFGLdCtF1zjhAu9SqFNceXGwNuw
         Ye4SCLPFV6eGdM50F11RhlRhjmNHROOxng9GOetVz28ScOmz3PUDsIvQv6xbB0HgQ5Jg
         Zab8BgIl01C3629xyCG3k+7r4CWd2b7BfU1huN1igJRnrjxZWXRHzyZrWengtIzRWHdU
         eZRWZ0yG3p8UCaUgM4hRB2KpmBiOyfqJD3pTld5RapgreRrlyKBVhva45LZnOxndH83x
         aJ6Dx9KK9HpR1USN07z2zBH4J8oYXKZUo2X5PqdkRkWyzZjsQ2Ob+dDluuUvJ8laS7Bq
         rPPg==
X-Forwarded-Encrypted: i=1; AKwUvByLH7GfqWJzD9UvZ9Cs2v7vOgTqq1PJ5wxNpa0JZSoz4BpWjn46e1pq22i+lF3F74xwAhnEUPPZOu7zmmCwzQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9+cAY0S0lu4Gv2hcfEc5y+lvv3XuE8EAaHmLNTQFijTl5swcWJ
	x3s3RvPli/BGfh6o6jT3QYbqIFlnm5ntFZd0elayC1ETLTqW1p3TReYl
X-Gm-Gg: AYBFou0QaEFmeeK+n65+ZtShABm8iiMl09dUt97qls5H8/GoZwN920R3GgAmOVyhmZa
	rgNnDbmgmGOWh8kR6fZJv/b9CzzQUy5GAFvEfYcQNSPBpEr5ssRGSsLqCdVxJ++3SNDHblRIz7L
	Zm2zZ3Dmeqfm5W3gmFiZXqFOx+IaqPy3NiUJU8D3jilUlL+718YW/yzXYfy/uEsjpr30Z3r+Gb8
	JAQT5A1wFJl51rPMDmZoOUrvxe+fKyRcwi0zwVYwBOi6Okr5kpWF+j/LdayCS0oKOctlPAOpG10
	8rMV924szD0KMrfYW58gDfZ0QZvBT6Rqzayhj/nr25S29v97avt68j2MF/72Q62uTNwOd2n1uOA
	J/vYBmvP3ZILJdqsH1Os1XGi3OrymeY8gE43hZvLNqM5dmcBPsuIEjjqYu3TrYiQiANAc7WJXCT
	GV4ZUIoXnlfkvpPiqIiCcYaABw6bfGyjEVjW/234WHsRLfIJMDkUnFAUFDrHn4EpY5FS97aqp2O
	ozgQ4xeetbxQ0UUdQd7+x7CWpUMLH6Zh/NfBr/WhqdfH3vv2otiDTzuG8KhNdBh999hy5m7VFTr
	by6bk7Ji4GyUr/05SV+0YWeTRL0ZMDew5MeYJ9JShzqLz6WpE3ace+wkQuSsL0EiU9x5YoeUgXx
	APpnEhytaSYfiR9Gmg/tOvd4u2SqnEEnzZZG+aOMe2VTYbx+r8pbbOFKnE8cMoWaLNZSc
X-Received: by 2002:a05:7301:6482:b0:36d:37c4:3759 with SMTP id 5a478bee46e88-36d37c43872mr4434951eec.18.1793862568263;
        Wed, 04 Nov 2026 23:09:28 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm16812286eec.24.2026.11.04.23.09.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 23:09:27 -0800 (PST)
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
Subject: [PATCH v17 10/12] ALSA: virtio: serialize staged capture lifecycle and defer paused XRUNs
Date: Thu,  5 Nov 2026 16:08:43 +0900
Message-ID: <20261105070845.6449-11-mynameisjune111@gmail.com>
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

Use request-owned RX storage and separate produced, observed and
consumed positions for shared capture clients. Serialize lifecycle
operations with lifecycle_lock and ACK accounting with the PCM stream
lock.

Close ACK admission before any sleeping teardown and keep prepare's gate
through the core pointer reset. Reject unavailable epochs with -EBADFD.
Real transfer XRUNs arm stop_operating in ACK and pause/restart
triggers, so DROP and prepare retire the remaining device state.

Track RELEASE completion and rearm release_required immediately after a
successful resume PREPARE. Publish the resumed prepared state before RX
submission because a device can complete RX before the START response.
Record suspend state even when the stopped stream has no queued
messages.

Account staged ACK progress in runtime->min_align frames. Advance the
byte counters and application cursor by that same aligned amount,
keeping any fractional-byte frame tail for the next ACK, including
boundary wrap.

Complete capture's private cursor rebase on every post-reset error path
while retaining its XRUN latch. Playback RESET with device-owned TX
requests returns -EBUSY before changing either pointer. With no pending
TX, rebase all indirect offsets and clear partial message fills
together. Applications can use DROP/PREPARE before retrying a busy
RESET. This return-value change needs maintainer review.

Teardown disables period work until the next successful prepare. After
device reset and queue deletion, complete pending control messages
before waiting for period work that may itself be blocked on a control
reply. Keep full-ring overwrite detection and retire the last pending
request with a wakeup for the release waiter.

The capture compatibility options remain opt-in and disabled by default.

Carry the same stopped-plus-XRUN admission rule into the request-owned
and shared capture ACK paths. A stopped capture tail remains available
to DRAINING when no transfer XRUN is latched.

Use prepared as the lifetime gate for staged capture pointer and ACK
access. DRAINING state alone does not authorize access after prepared
has been cleared; retain the explicit PAUSED/RELEASED exception.

Latch XRUNs while a linked stream is PAUSED and publish them after the group resumes, with sync_stop ownership armed for pause.
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_card.c    |   58 +
 sound/virtio/virtio_ctl_msg.c |   58 +
 sound/virtio/virtio_ctl_msg.h |    9 
 sound/virtio/virtio_pcm.c     |  121 ++
 sound/virtio/virtio_pcm.h     |  144 +++
 sound/virtio/virtio_pcm_msg.c |  511 +++++++++-
 sound/virtio/virtio_pcm_ops.c | 2007 ++++++++++++++++++++++++++++++++++++-----
 7 files changed, 2567 insertions(+), 341 deletions(-)

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
@@ -310,8 +310,115 @@
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
+				virtsnd_pcm_defer_paused_xrun(vss);
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
@@ -351,8 +458,10 @@
 		vss->snd = snd;
 		vss->sid = i;
 		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
+		disable_work(&vss->elapsed_period);
 		init_waitqueue_head(&vss->msg_empty);
 		spin_lock_init(&vss->lock);
+		mutex_init(&vss->lifecycle_lock);
 	}
 
 	info = kzalloc_objs(*info, snd->nsubstreams);
@@ -486,7 +595,7 @@
 			snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops[i]);
 		}
 
-		snd_pcm_set_managed_buffer_all(vpcm->pcm,
+		snd_pcm_lib_preallocate_pages_for_all(vpcm->pcm,
 					       SNDRV_DMA_TYPE_VMALLOC, NULL,
 					       0, 0);
 	}
@@ -517,8 +626,12 @@
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
@@ -26,21 +45,45 @@
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
@@ -61,17 +104,39 @@
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
@@ -84,6 +149,63 @@
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
@@ -114,6 +236,11 @@
 
 extern const struct snd_pcm_ops virtsnd_pcm_ops[];
 
+extern bool virtsnd_capture_staging;
+extern bool virtsnd_capture_packed_status;
+extern bool virtsnd_capture_allow_short;
+extern bool virtsnd_capture_allow_empty;
+
 int virtsnd_pcm_validate(struct virtio_device *vdev);
 
 int virtsnd_pcm_parse_cfg(struct virtio_snd *snd);
@@ -132,11 +259,16 @@
 
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
  * @data_offset: Offset of the fixed PCM ring slice for ordinary I/O.
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
 	struct scatterlist sgs[];
 };
@@ -226,6 +231,8 @@
 	if (check_mul_overflow((size_t)periods, (size_t)period_bytes,
 			       &buffer_bytes))
 		return -EOVERFLOW;
+	if (vss->capture_staging && periods < 2)
+		return -EINVAL;
 
 	if (!vss->substream || !vss->substream->runtime)
 		return -EINVAL;
@@ -234,14 +241,19 @@
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
@@ -253,32 +265,54 @@
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
 		msg->data_offset = (size_t)period_bytes * i;
 		virtsnd_pcm_sg_from(&msg->sgs[PCM_MSG_SG_DATA], sg_num, data,
 				    period_bytes);
@@ -312,8 +346,14 @@
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
@@ -335,15 +375,26 @@
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
 
@@ -374,6 +425,8 @@
 	bool notify = false;
 	int rc;
 
+	if (!vqueue || !vss->prepared || vss->suspended)
+		return -EBADFD;
 	if (!bytes)
 		return 0;
 	if (!period_bytes || !vss->msgs || offset >= vss->buffer_bytes ||
@@ -399,8 +452,8 @@
 
 		msg->length += n;
 		if (msg->length == period_bytes) {
-			msg->xfer.stream_id = cpu_to_le32(vss->sid);
-			memset(&msg->status, 0, sizeof(msg->status));
+			msg->xfer->stream_id = cpu_to_le32(vss->sid);
+			memset(msg->status, 0, sizeof(*msg->status));
 
 #ifndef CONFIG_MMU
 		if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -474,6 +527,293 @@
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
@@ -525,9 +865,9 @@
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
@@ -536,78 +876,103 @@
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
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->capture_staging) {
+		virtsnd_pcm_capture_complete(msg, written_bytes);
+		return;
+	}
+
+	/* Only completed TX requests and valid RX audio advance the pointer. */
 	guard(spinlock)(&vss->lock);
+	/* Empty STOP returns retire ownership without inventing captured data. */
 	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
 	    (!vss->prepared || vss->xfer_xrun ||
-	     (vss->stopped && written_bytes <= sizeof(msg->status)))) {
+	     (vss->stopped && written_bytes <= sizeof(*msg->status)))) {
 		msg->length = 0;
 		vss->msg_count--;
 		if (!vss->msg_count)
 			wake_up_all(&vss->msg_empty);
 		return;
 	}
-
-	/* Only the next complete ring slice can extend captured data. */
-	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
-	    (msg->data_offset != vss->hw_ptr ||
-	     written_bytes < sizeof(msg->status) ||
-	     le32_to_cpu(msg->status.status) != VIRTIO_SND_S_OK ||
-	     written_bytes - sizeof(msg->status) != msg->length)) {
-		dev_err_ratelimited(&vss->snd->vdev->dev,
-				    "SID %u: invalid capture position, status or length\n",
-			vss->sid);
-		vss->xfer_xrun = true;
-		capture_invalid = true;
+	completed_bytes = msg->length;
+	latency_bytes = le32_to_cpu(msg->status->latency_bytes);
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+		struct snd_pcm_runtime *runtime = vss->substream->runtime;
+		size_t frame_bytes = runtime->frame_bits / gcd(runtime->frame_bits, 8);
+
+		/* Only the next complete ring slice can extend captured data. */
+		if (msg->data_offset != vss->hw_ptr ||
+		    virtsnd_pcm_capture_status(msg, written_bytes, frame_bytes,
+					       &completed_bytes, &latency_bytes) ||
+		    !completed_bytes || completed_bytes != msg->length) {
+			vss->xfer_xrun = true;
+			msg->length = 0;
+			vss->msg_count--;
+			if (!vss->msg_count)
+				wake_up_all(&vss->msg_empty);
+			virtsnd_pcm_schedule_period_elapsed(vss);
+			return;
+		}
 	}
 #ifndef CONFIG_MMU
 	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
-	    vss->prepared && !capture_invalid &&
-	    written_bytes > sizeof(msg->status)) {
+	    vss->prepared &&
+	    written_bytes > sizeof(*msg->status)) {
 		struct snd_pcm_runtime *runtime =
 			vss->substream ? vss->substream->runtime : NULL;
+		size_t reported_bytes = written_bytes - sizeof(*msg->status);
+		size_t data_bytes = min_t(size_t, reported_bytes, msg->length);
 
 		if (!runtime || !runtime->dma_area || !vss->owned_dma_area ||
 		    msg->data_offset > runtime->dma_bytes ||
-		    msg->length > runtime->dma_bytes - msg->data_offset ||
+		    data_bytes > runtime->dma_bytes - msg->data_offset ||
 		    msg->data_offset > vss->owned_dma_bytes ||
-		    msg->length > vss->owned_dma_bytes - msg->data_offset) {
+		    data_bytes > vss->owned_dma_bytes - msg->data_offset) {
 			dev_err_ratelimited(&vss->snd->vdev->dev,
 					    "SID %u: invalid capture buffer for I/O message\n",
 				vss->sid);
+			/* Do not publish progress for data that could not be copied. */
+			virtsnd_pcm_capture_xrun_locked(vss);
+			msg->length = 0;
+			vss->msg_count--;
+			if (!vss->msg_count)
+				wake_up_all(&vss->msg_empty);
+			return;
+		}
+
+		memcpy(runtime->dma_area + msg->data_offset,
+		       vss->owned_dma_area + msg->data_offset, data_bytes);
+	}
+#endif
+	vss->hw_ptr += completed_bytes;
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
+		/* A full unseen ring cannot be represented by the modulo pointer. */
+		if (check_add_overflow(vss->capture_copied_total,
+				       (u64)completed_bytes,
+				       &vss->capture_copied_total) ||
+		    vss->capture_copied_total < vss->capture_pointer_seen_total ||
+		    vss->capture_copied_total - vss->capture_pointer_seen_total >=
+			vss->buffer_bytes)
 			vss->xfer_xrun = true;
-			capture_invalid = true;
-		} else {
-			memcpy(runtime->dma_area + msg->data_offset,
-			       vss->owned_dma_area + msg->data_offset, msg->length);
-		}
-	}
-#endif
-	/* Publish pointer progress only for a complete TX or valid RX request. */
-	if (!capture_invalid) {
-		vss->hw_ptr += msg->length;
-		if (vss->hw_ptr >= vss->buffer_bytes)
-			vss->hw_ptr -= vss->buffer_bytes;
-	}
+	}
+
+	if (vss->hw_ptr >= vss->buffer_bytes)
+		vss->hw_ptr -= vss->buffer_bytes;
 
 	msg->length = 0;
+
+	/* Keep latched errors until prepare establishes a fresh epoch. */
 	vss->msg_count--;
 
-	if (vss->xfer_enabled) {
-		if (!capture_invalid) {
-			struct snd_pcm_runtime *runtime = vss->substream->runtime;
-
-			runtime->delay =
-				bytes_to_frames(runtime,
-						le32_to_cpu(msg->status.latency_bytes));
-		}
-		schedule_work(&vss->elapsed_period);
+	if (vss->xfer_enabled ||
+	    (vss->direction == SNDRV_PCM_STREAM_CAPTURE && vss->xfer_xrun)) {
+		struct snd_pcm_runtime *runtime = vss->substream->runtime;
+
+		runtime->delay = bytes_to_frames(runtime, latency_bytes);
+		virtsnd_pcm_schedule_period_elapsed(vss);
 	}
 	if (!vss->msg_count)
 		wake_up_all(&vss->msg_empty);
@@ -667,6 +1032,7 @@
  * virtsnd_pcm_ctl_msg_alloc() - Allocate and initialize the PCM device control
  *                               message for the specified substream.
  * @vss: VirtIO PCM substream.
+ * @epoch: Operation generation captured before allocation.
  * @command: Control request code (VIRTIO_SND_R_PCM_XXX).
  * @gfp: Kernel flags for memory allocation.
  *
@@ -675,7 +1041,7 @@
  */
 struct virtio_snd_msg *
 virtsnd_pcm_ctl_msg_alloc(struct virtio_pcm_substream *vss,
-			  unsigned int command, gfp_t gfp)
+			  unsigned int command, gfp_t gfp, u64 epoch)
 {
 	size_t request_size = sizeof(struct virtio_snd_pcm_hdr);
 	size_t response_size = sizeof(struct virtio_snd_hdr);
@@ -693,6 +1059,7 @@
 
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
@@ -97,46 +131,265 @@
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
+static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss, u64 epoch)
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
 }
 
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
@@ -151,23 +404,42 @@
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
@@ -179,6 +451,15 @@
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
 
@@ -191,6 +472,7 @@
  * @channels: Selected number of channels.
  * @format: Selected sample format (SNDRV_PCM_FORMAT_XXX).
  * @rate: Selected frame rate.
+ * @epoch: Operation generation captured before preparing the request.
  *
  * Context: Any context that permits to sleep.
  * Return: 0 on success, -errno on failure.
@@ -200,7 +482,7 @@
 				      unsigned int period_bytes,
 				      unsigned int channels,
 				      snd_pcm_format_t format,
-				      unsigned int rate)
+				      unsigned int rate, u64 epoch)
 {
 	struct virtio_snd_msg *msg;
 	struct virtio_snd_pcm_set_params *request;
@@ -226,7 +508,7 @@
 		return -EINVAL;
 
 	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_SET_PARAMS,
-					GFP_KERNEL);
+					GFP_KERNEL, epoch);
 	if (!msg)
 		return -ENOMEM;
 
@@ -245,7 +527,14 @@
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
@@ -264,10 +553,10 @@
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
@@ -277,6 +566,25 @@
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
@@ -290,16 +598,20 @@
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
 
@@ -309,8 +621,18 @@
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
+		if (vss->capture_staging)
+			vss->runtime_active = true;
+	}
+
+	return rc;
 }
 
 /**
@@ -323,101 +645,503 @@
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
+	int rc;
+
+	guard(mutex)(&vss->lifecycle_lock);
+	rc = virtsnd_pcm_prepare_locked(substream);
+	if (rc) {
+		guard(pcm_stream_lock_irqsave)(substream);
+		guard(spinlock_irqsave)(&vss->lock);
+		vss->preparing = false;
+	} else if (vss->period_work_quiesced) {
+		enable_work(&vss->elapsed_period);
+		vss->period_work_quiesced = false;
+	}
+	return rc;
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
+		epoch = vss->reset_epoch;
+		state = vss->pause_restart_state;
+		xrun = vss->xfer_xrun;
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
-	int rc;
-
-	virtsnd_pcm_close_ack(substream, true);
-	rc = virtsnd_pcm_prepare_device(substream);
-	if (rc)
-		virtsnd_pcm_close_ack(substream, false);
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
 
 /**
- * virtsnd_pcm_trigger() - Process command for the PCM substream.
+ * virtsnd_pcm_trigger_inner() - Process command for the PCM substream.
  * @substream: Kernel ALSA substream.
  * @command: Substream command (SNDRV_PCM_TRIGGER_XXX).
  *
@@ -425,77 +1149,272 @@
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
 }
 
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
+
+	if (command == SNDRV_PCM_TRIGGER_PAUSE_RELEASE &&
+	    virtsnd_pcm_defer_resume_xrun(vss, epoch))
+		return 0;
+
+	rc = virtsnd_pcm_trigger_inner(substream, command);
+	if (!rc && command == SNDRV_PCM_TRIGGER_PAUSE_PUSH)
+		substream->runtime->stop_operating = true;
+	if (command == SNDRV_PCM_TRIGGER_PAUSE_RELEASE &&
+	    (rc == 0 || rc == -EPIPE) &&
+	    virtsnd_pcm_defer_resume_xrun(vss, epoch))
+		return 0;
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
@@ -504,43 +1423,63 @@
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
 	}
-	cancel_work_sync(&vss->elapsed_period);
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
@@ -549,22 +1488,56 @@
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
@@ -579,14 +1552,49 @@
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
@@ -601,14 +1609,106 @@
 virtsnd_pcm_cp_pointer(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
-
-	scoped_guard(spinlock_irqsave, &vss->lock)
-		if (vss->xfer_xrun)
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	size_t hw_ptr = 0;
+	u64 total;
+	bool free_running;
+	bool xrun = false;
+	bool paused_pointer = false;
+	bool defer_work = false;
+
+	if (vss->capture_staging) {
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (runtime->state == SNDRV_PCM_STATE_PAUSED) {
+				if (vss->xfer_xrun) {
+					virtsnd_pcm_defer_paused_xrun(vss);
+					defer_work = true;
+				}
+				paused_pointer = !vss->runtime_active || vss->preparing ||
+					vss->suspended ||
+					(!vss->prepared &&
+					 !(virtsnd_pcm_pause_restart_enabled(vss) &&
+					   vss->pause_restart_state ==
+						VIRTSND_PCM_PAUSE_RESTART_RELEASED)) ||
+					vss->xfer_xrun;
+			} else if (!vss->runtime_active || vss->preparing || vss->suspended ||
+			    (!vss->prepared &&
+			     !(runtime->state == SNDRV_PCM_STATE_PAUSED &&
+			       virtsnd_pcm_pause_restart_enabled(vss) &&
+			       vss->pause_restart_state == VIRTSND_PCM_PAUSE_RESTART_RELEASED)))
+				return SNDRV_PCM_POS_XRUN;
+			if (!paused_pointer) {
+				xrun = vss->xfer_xrun;
+				if (!xrun &&
+				    virtsnd_pcm_capture_refresh_mode_locked(vss,
+									    &free_running))
+					xrun = true;
+				if (!xrun && !virtsnd_pcm_capture_counters_valid(vss))
+					xrun = true;
+				if (!xrun) {
+					total = vss->capture_callback_snapshot_active ?
+						vss->capture_callback_snapshot :
+						vss->capture_copied_total;
+					/* A full-ring observation gap is modulo-ambiguous. */
+					if (total < vss->capture_pointer_seen_total ||
+					    total - vss->capture_pointer_seen_total >=
+						vss->buffer_bytes) {
+						xrun = true;
+						vss->xfer_xrun = true;
+					} else {
+						vss->capture_pointer_seen_total = total;
+						hw_ptr = virtsnd_pcm_ring_offset(
+							total, vss->buffer_bytes);
+						virtsnd_pcm_capture_reset_pointer_locked(
+							vss, substream, total);
+					}
+				}
+				if (xrun) {
+					vss->xfer_xrun = true;
+					if (runtime->state == SNDRV_PCM_STATE_PAUSED) {
+						virtsnd_pcm_defer_paused_xrun(vss);
+						paused_pointer = true;
+						defer_work = true;
+					}
+				}
+			}
+		}
+
+		if (paused_pointer) {
+			if (defer_work)
+				virtsnd_pcm_schedule_period_elapsed(vss);
+			return virtsnd_pcm_cached_pointer(runtime);
+		}
+		if (xrun)
 			return SNDRV_PCM_POS_XRUN;
 
+		return bytes_to_frames(substream->runtime, hw_ptr);
+	}
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (runtime->state == SNDRV_PCM_STATE_PAUSED) {
+			if (vss->xfer_xrun) {
+				virtsnd_pcm_defer_paused_xrun(vss);
+				defer_work = true;
+			}
+			paused_pointer = vss->xfer_xrun || !vss->prepared ||
+					 vss->preparing;
+		} else if (vss->xfer_xrun || !vss->prepared || vss->preparing) {
+			return SNDRV_PCM_POS_XRUN;
+		}
+		if (!paused_pointer) {
+			vss->capture_pointer_seen_total = vss->capture_copied_total;
+			hw_ptr = vss->hw_ptr;
+		}
+	}
+	if (paused_pointer) {
+		if (defer_work)
+			virtsnd_pcm_schedule_period_elapsed(vss);
+		return virtsnd_pcm_cached_pointer(runtime);
+	}
+
 	return snd_pcm_indirect_capture_pointer(substream,
-		&vss->pcm_indirect,
-		vss->hw_ptr);
+		&vss->pcm_indirect, hw_ptr);
 }
 
 struct virtsnd_pcm_transfer {
@@ -623,7 +1723,9 @@
 	struct virtsnd_pcm_transfer *transfer =
 		container_of(rec, struct virtsnd_pcm_transfer, indirect);
 
-	if (transfer->error)
+	if (transfer->error ||
+	    (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
+	     substream->runtime->state == SNDRV_PCM_STATE_DRAINING))
 		return;
 
 	transfer->error = virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
@@ -637,132 +1739,515 @@
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
+			rc = snd_pcm_indirect_playback_transfer(substream,
+								&transfer.indirect,
+								virtsnd_pcm_trans_copy);
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
-		return -EPIPE;
+		/*
+		 * pcm_lib_apply_appl_ptr() interprets -EPIPE as a new XRUN
+		 * and calls __snd_pcm_xrun(), which stops the whole linked
+		 * group. The stream is already XRUN; do not repeat that action.
+		 */
+		return -EBADFD;
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
+		snd_pcm_uframes_t appl_diff;
+		snd_pcm_uframes_t ack_frames;
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
+		rc = virtsnd_pcm_capture_refresh_mode_locked(vss,
+							     &free_running);
+		if (rc || !virtsnd_pcm_capture_counters_valid(vss))
+			return virtsnd_pcm_ack_xrun_locked(vss, runtime);
+
+		appl_ptr = runtime->control->appl_ptr;
+		diff = appl_ptr - vss->pcm_indirect.appl_ptr;
+		if (diff < -(snd_pcm_sframes_t)(runtime->boundary / 2))
+			diff += runtime->boundary;
+		if (diff < 0)
+			return virtsnd_pcm_ack_xrun_locked(vss, runtime);
+		appl_diff = diff;
+		ack_frames = appl_diff - appl_diff % runtime->min_align;
+		if (ack_frames > runtime->buffer_size ||
+		    (appl_diff > runtime->buffer_size &&
+		     appl_diff - runtime->buffer_size >= runtime->min_align)) {
+			return virtsnd_pcm_ack_xrun_locked(vss, runtime);
+		}
+
+		/* ACK includes any subperiod tail already copied to the ring. */
+		bytes = frames_to_bytes(runtime, ack_frames);
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
+		/* Keep any unaligned frame tail for the next acknowledgment. */
+		vss->pcm_indirect.appl_ptr += ack_frames;
+		if (vss->pcm_indirect.appl_ptr >= runtime->boundary)
+			vss->pcm_indirect.appl_ptr -= runtime->boundary;
+	}
+
+	/* Preserve the queue -> substream lock order while refilling requests. */
 	scoped_guard(spinlock_irqsave, &queue->lock) {
 		guard(spinlock)(&vss->lock);
-		if (vss->preparing || !vss->prepared)
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
+	return 0;
+}
+
+static int virtsnd_pcm_cp_ack_locked(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct virtsnd_pcm_transfer transfer = {};
+	bool paused;
+	int rc;
+
+	if (vss->capture_staging) {
+		rc = virtsnd_pcm_capture_staged_ack(vss, runtime);
+		if (rc == -EPIPE) {
+			guard(spinlock_irqsave)(&vss->lock);
+			virtsnd_pcm_transfer_failed(vss);
+		}
+		return rc;
+	}
+
+	scoped_guard(spinlock_irqsave, &queue->lock) {
+		guard(spinlock)(&vss->lock);
+		paused = runtime->state == SNDRV_PCM_STATE_PAUSED;
+		if (vss->preparing)
 			return -EBADFD;
-		if (vss->stopped)
+		/* A latched XRUN must not re-arm sync_stop once teardown began. */
+		if (vss->stopped && vss->xfer_xrun)
 			return -EBADFD;
 		if (vss->xfer_xrun) {
-			rc = -EPIPE;
+			rc = virtsnd_pcm_ack_xrun_locked(vss, runtime);
 		} else {
-			transfer.indirect = vss->pcm_indirect;
-			rc = snd_pcm_indirect_playback_transfer(substream,
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
-	return 0;
-}
-
-static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
-{
-	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
-	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
-	struct virtsnd_pcm_transfer transfer = {};
-	int rc;
-
-	rc = virtsnd_pcm_ack_state(substream);
-	if (rc)
-		return rc;
-
-	scoped_guard(spinlock_irqsave, &queue->lock) {
-		guard(spinlock)(&vss->lock);
-		if (vss->preparing || !vss->prepared)
-			return -EBADFD;
-		/* Keep only the post-STOP capture tail available during drain. */
-		if (vss->stopped &&
-		    (vss->xfer_xrun ||
-		     substream->runtime->state != SNDRV_PCM_STATE_DRAINING))
-			return -EBADFD;
-		if (vss->xfer_xrun) {
-			rc = -EPIPE;
-		} else {
+			if (!vss->prepared ||
+			    (vss->stopped &&
+			     runtime->state != SNDRV_PCM_STATE_DRAINING))
+				return -EBADFD;
 			transfer.indirect = vss->pcm_indirect;
 			rc = snd_pcm_indirect_capture_transfer(substream,
 							       &transfer.indirect,
 							       virtsnd_pcm_trans_copy);
-			if (!rc)
-				rc = transfer.error;
-		}
-		if (rc)
-			virtsnd_pcm_transfer_failed(vss);
-		else
+		}
+		if (!rc)
+			rc = transfer.error;
+		if (rc) {
+			if (paused)
+				rc = virtsnd_pcm_ack_xrun_locked(vss, runtime);
+			else
+				virtsnd_pcm_transfer_failed(vss);
+		} else {
 			vss->pcm_indirect = transfer.indirect;
+		}
 	}
 	if (rc) {
 		dev_err(&vss->snd->vdev->dev,
 			"SID %u: capture ACK transfer failed: %d\n",
 			vss->sid, rc);
-		return -EPIPE;
+		/* ALSA treats -EPIPE as an XRUN in ACK and pointer paths. */
+		return paused ? -EBADFD : -EPIPE;
 	}
 
 	return 0;
 }
 
-/**
- * virtsnd_pcm_reset() - Reset PCM pointers and complete prepare admission.
- * @substream: Kernel ALSA substream.
- *
- * Context: PCM stream lock held.
- * Return: 0 on success, -errno on failure.
- */
-static int virtsnd_pcm_reset(struct snd_pcm_substream *substream)
+/* Every linked member's prepare closes the ACK gate under its PCM lock. */
+static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	int rc;
 
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
+	bool owned;
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
+		owned = vss->prepared || vss->release_required || vss->msg_count ||
+			vss->device_running;
+		if (state == SNDRV_PCM_STATE_RUNNING ||
+		    state == SNDRV_PCM_STATE_PAUSED ||
+		    state == SNDRV_PCM_STATE_PREPARED ||
+		    (state == SNDRV_PCM_STATE_DRAINING &&
+		     substream->stream == SNDRV_PCM_STREAM_PLAYBACK)) {
+			/* Core may consume this marker before a later inactive teardown. */
+			if (owned)
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
+	vss->preparing = false;
+	vss->pcm_indirect.appl_ptr = runtime->status->hw_ptr;
+	vss->pcm_indirect.sw_ready = 0;
+	if (vss->capture_staging) {
+		vss->hw_ptr = position;
+		vss->capture_copied_total = position;
+		vss->capture_acked_total = position;
+		vss->capture_pointer_seen_total = position;
+		vss->capture_ready = 0;
+		vss->capture_notified_periods = period ? position / period : 0;
+		vss->capture_callback_snapshot_active = false;
+	}
+	if (vss->xfer_xrun) {
+		virtsnd_pcm_transfer_failed(vss);
+		virtsnd_pcm_schedule_period_elapsed(vss);
+	}
+}
+
+/*
+ * The PCM lock covers indirect accounting and core completion. Once lib_reset
+ * changes hw_ptr, complete the core rebase even if refilling fails. The latched
+ * XRUN rejects subsequent pointer/ACK operations; paused streams publish it
+ * after resume so ALSA can stop linked members that are actually running.
+ * RESET success therefore does not imply stream recovery.
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
 	rc = snd_pcm_lib_reset(substream);
-	scoped_guard(spinlock_irqsave, &vss->lock) {
-		if (vss->preparing) {
-			vss->prepared = !rc;
-			vss->preparing = false;
-		}
-	}
-
-	return rc;
+	vss->indirect_reset_observing = false;
+	if (rc)
+		return rc;
+	guard(spinlock_irqsave)(&queue->lock);
+	guard(spinlock)(&vss->lock);
+	vss->preparing = false;
+	if (vss->resetting || vss->xfer_xrun) {
+		virtsnd_pcm_capture_reset_error(vss, runtime);
+		return 0;
+	}
+	if (!snd_pcm_running(substream) && !paused) {
+		vss->pcm_indirect.appl_ptr = runtime->status->hw_ptr;
+		vss->pcm_indirect.sw_ready = 0;
+		return 0;
+	}
+	if (!vss->prepared || vss->stopped) {
+		vss->xfer_xrun = true;
+		virtsnd_pcm_capture_reset_error(vss, runtime);
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
+			vss->xfer_xrun = true;
+			virtsnd_pcm_capture_reset_error(vss, runtime);
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
+		vss->xfer_xrun = true;
+		virtsnd_pcm_capture_reset_error(vss, runtime);
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
+	vss->preparing = false;
+	if (vss->resetting || vss->xfer_xrun) {
+		virtsnd_pcm_capture_reset_error(vss, runtime);
+		return 0;
+	}
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
+	if (rc)
+		return rc;
+	guard(spinlock_irqsave)(&queue->lock);
+	guard(spinlock)(&vss->lock);
+	position = frames_to_bytes(runtime, runtime->status->hw_ptr) %
+		   vss->buffer_bytes;
+	vss->preparing = false;
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
@@ -774,11 +2259,11 @@
 		.hw_params = virtsnd_pcm_hw_params,
 		.hw_free = virtsnd_pcm_hw_free,
 		.prepare = virtsnd_pcm_prepare,
-		.reset = virtsnd_pcm_reset,
 		.trigger = virtsnd_pcm_trigger,
 		.sync_stop = virtsnd_pcm_sync_stop,
 		.pointer = virtsnd_pcm_pb_pointer,
 		.ack = virtsnd_pcm_pb_ack,
+		.reset = virtsnd_pcm_playback_reset,
 	},
 	{
 		.open = virtsnd_pcm_open,
@@ -787,10 +2272,38 @@
 		.hw_params = virtsnd_pcm_hw_params,
 		.hw_free = virtsnd_pcm_hw_free,
 		.prepare = virtsnd_pcm_prepare,
-		.reset = virtsnd_pcm_reset,
 		.trigger = virtsnd_pcm_trigger,
 		.sync_stop = virtsnd_pcm_sync_stop,
 		.pointer = virtsnd_pcm_cp_pointer,
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
