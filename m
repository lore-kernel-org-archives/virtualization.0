Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180549;
	b=vFlhLU0Fk/VEFyUWKUGPAlmXhRGAbUVZYGtMnIH5zquAVTVB+AKI9APEMC7LWEyTqwyt
	 srh2qp/pi6UOjPCsWv20cnMdceG9lx8rgshzKhIh5UUX98tVBshOzQEDqzSv5Q2qoab/0
	 KL+cDWYGIkgYBl55VQsz+d+Gt0ta1YS7H4MpYZ5BPNuwF60w6imEhQeonGAvrbVbpUnF9
	 qvYWgNZFkJaNq37mjLcPe7Lq4XtNGUc5w0IbrTKicvsST1U7UFIdDbHFcf5S4is2Olsr/
	 L+ZsLUWIXymxbpZch3yApz96AOgDzW0ONbs6UBHh3GOP7f6F994jidHNgfxmbnioYpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4XywAoxeaZzuOeDhhvc4sxnHZ3aBk4zO8y4jW5OboPk=;
	b=bNxmujZ8i7Q7mvE1C4Cf8hdjDgrfpTv21VnEzJU1bT3vJsiMqDIbOHifHOEAcVDhhHRc
	 aVtR0lCM8f1DLxAcb8rtbRGeqQ0CLj5TN8VMYAqEh2eT9zD3kqZyW9jKJe8xNtBhSok5v
	 B+PX60LKn8Jci7fenW9MnG4pig2/81GuJPQcE6RbA/j+tbtyODRp/ahU5lPfjqo1/PK8d
	 dHUPYHT7VcxtSp3pNwlC9PhJzneIsis1vVDTIEKxSVQdvyByvikHYcMg8xm7xaiHGFWYR
	 6upb/ndWHfW2lNDSeToeRWY6o9ervW65IC9ksVwRogXfjQ37eAnmEJGAjx3m9M+lf6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZiX1RIwC;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5E606A329
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94B5E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZiX1RIwC
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd67cc518a6so568222a12.1
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180548; x=1793785348; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XywAoxeaZzuOeDhhvc4sxnHZ3aBk4zO8y4jW5OboPk=;
        b=ZiX1RIwCIpvmEsYjoAHWqweAm81hKAaERFGKklGbMG5WzyudUUbEzIqhLtIY95V7do
         +IL3M2GptWtZptmoqUhXMgsbHz/P5ODFfe0mL8T0arEZ34gCwQGepNS9aJpoL4cvaDaV
         DBFkE9K6SKVddvzb7LwD4Zzo09+v6TdwwaJZBaeEW2+6SYnWgMmQrOp1HViCD2j/MPsB
         1o7/nbxzuI0TIOFHTeZuWTNXXNjxMbfTVCsUMSADHstJeA7EKyI8NOSqebwd5HDWH8tP
         ZxckvVhaV6ugrWgK2xgSsC+44Nu35b/GKGviz6sQ7bKdZnMPrDtL/s98TRy5Y2R52qd6
         djwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180548; x=1793785348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4XywAoxeaZzuOeDhhvc4sxnHZ3aBk4zO8y4jW5OboPk=;
        b=jxRzGPRST1HSXScJei7EdYMlceKMdeag4c+Qq9OFAu/g+aDS0Zl6FBRpil3F9zk4qk
         MwxUeRdf017Uc1hT/jtaJSzMac9NDMblBMeRBBkOiXpDFRJ7Zm8FbERejmqAAtsNqslz
         hLJTbebgHk4C0CRA/CHBeWgtr/ChU8lRRwm3sqUdRFv8SdOpXkRW2D5RiXF1l03Nd90J
         D48IAw/vV3v05X9wEsEJlxCAwxq6Smy4o7wfiC7QCOEvmlBRWysDmu5/mrOqSsqGGRDG
         o9JkW6ZVDWwvrtCJkRriju7J8io4O8W0pOvnZjycQC2xdoDeZARSJjGUDLBz8QCO3bGi
         9RTA==
X-Forwarded-Encrypted: i=1; AKwUvBzPVtBHOjbaJm81R4wPp2KoNEtP1GjqxYJ9j7QL6e3GgG1TBg2T39Dsk6sJMEloTb1KnhK4trGUJmwecOap9Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYL+VjdTRrNkF3pe5MHJ0zVUMyewk+DPHmuVGIHAkptanOf5EchZ
	9rOVjogrnF5PfpthGG28WHCJobbEPBbViuWxThcwQh5IPo2vkFBiWhkYapYhgA==
X-Gm-Gg: AYBFou1QFzYBhP2MGnfkSY2ZGeqXU4M1WdsWBr5mYDEdTNKHlIkBjVpYaP1fiWJi3Gc
	gn8PeUwp2MPWLNKwmz97/9nkvZhgag54ivSl9mtTsllBC5vjRTlFA/39RT736bKlhnNzONh6UsD
	PWPZSZD1BSE6lqgMcHpU+McoCy3oe4SCyZd/7rKQ2Z0OKJKDkfbaRNFeUGHo+a8NeWw1ud9lcyu
	YTMxo28ogLbVm/j+HxuhX7n1K9lkd8Q8uEODfjHn4KVLzjso7eEWfvQeHcrI75nuv+7vnrixi6J
	HWlqwqua6SKLyE15C/8U7zUvaUeFR6zXRSTJOb2HM26RjJhwsBIsY0lZbKA7nWJKr7bGuHkWrq7
	/f7aBg14A4hC+hynupS0/DlQ44pzt7Z3zcxyVB4mbtmP27EvyjK2Y3p/gjYtj1mfQq7pfQGbhsD
	e0D5LDHDO/MI7H84XD5QzmNhIMxBIJjfhX83F1S37JKVc9qd14b2penxfD0YwNDQ42DIspMP3qV
	Y8tcziJqvB0+pNvWJthLF7PwTmsW/uGBiqgqRYVen+0r+Kmr0gSmsdcR4e3WTkRFCSNT8GjKCi4
	SmNJdU2aj+MTZWx+ESuYdj4vxImuJu8m9jFQKfUDG/MfZ4nxxqYxdkDaBaHAf5aEc1qXsXn0YG0
	C5fnc+P9lR/J1jjz6W+uWy1xEiWhw5RmQyWoLn3eO2e5XNTI=
X-Received: by 2002:a17:90b:4cc1:b0:3ab:2737:3395 with SMTP id 98e67ed59e1d1-3ae58299f5dmr1291309a91.42.1793180547692;
        Wed, 28 Oct 2026 02:42:27 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a93b3f5sm2242377a91.5.2026.10.28.02.42.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 02:42:27 -0700 (PDT)
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
Subject: [PATCH v7 13/16] ALSA: virtio: fence staged capture state and recovery
Date: Wed, 28 Oct 2026 18:41:29 +0900
Message-ID: <20261028094132.20364-14-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028094132.20364-1-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
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

A failed PREPARE can leave subsequent START or ACK paths able to queue
requests. Device reset can also leave stale queue and pause-restart state,
and a failed open can leave period work referring to a released runtime.

Track successful device preparation under the substream lock. Require that
state and a live virtqueue before queueing transfers. Clear preparation
before reconfiguration and reset, stop transfers before resetting the
device, detach outstanding buffers, clear queue pointers under their locks,
and cancel period work before completing state cleanup. Mark all streams
suspended so prepare re-establishes device parameters after restore.

Keep prepared capture buffers eligible for NOMMU bounce copies during
native pause. Suppress new notifications from an inactive failed-open
path, cancel pending period work on open failure, and guard the worker
against an absent runtime.

Use the control-submission result to preserve the previous pause state on
a definitive failure. Keep RESET_REQUIRED when a submitted request times
out or is cancelled. A RELEASE_SENT pause retry waits for RX drain and
preserves an existing XRUN so prepare performs recovery.

Reset pointers, indirect state and capture counters in one locked section.
Bound staged ACK by the position observed by ALSA. A successful partial
read while paused can still cross ALSA's stop threshold; arm synchronous
cleanup for that path as well as an ACK error. Remove the unused
start_failed argument and protect suspended state updates with the lock.

The partial paused-read reproducer failed its first prepare with -EBADFD
on v5. Both pause modes recover and capture 48000 frames with these
changes. Queue-failure, failed-open and virtio bus freeze/restore tests
also completed under ARM64 QEMU with KASAN and lockdep.

This addresses the remaining Sashiko state and lifetime findings in
patches 2-4, 7-9 and 11. The controlled XRUN comparison found the same
client-deadline failures on v5 and the corrected kernel; it does not
justify relaxing the capture overflow checks.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
 sound/virtio/virtio_card.c    |  25 +++++++++-
 sound/virtio/virtio_pcm.c     |   2 +
 sound/virtio/virtio_pcm.h     |   2 +
 sound/virtio/virtio_pcm_msg.c |  14 ++++--
 sound/virtio/virtio_pcm_ops.c | 110 ++++++++++++++++++++++++++----------------
 5 files changed, 106 insertions(+), 47 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index df7091b..852cc27 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -348,6 +348,16 @@ static void virtsnd_reset_vqs(struct virtio_snd *snd)
 	struct virtio_device *vdev = snd->vdev;
 	unsigned int i;
 
+	for (i = 0; snd->substreams && i < snd->nsubstreams; ++i) {
+		struct virtio_pcm_substream *vss = &snd->substreams[i];
+		struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+
+		guard(spinlock_irqsave)(&queue->lock);
+		guard(spinlock)(&vss->lock);
+		vss->prepared = false;
+		vss->xfer_enabled = false;
+		vss->suspended = true;
+	}
 	virtio_reset_device(vdev);
 
 	/* Deleting a virtqueue does not unmap its outstanding descriptors. */
@@ -364,9 +374,20 @@ static void virtsnd_reset_vqs(struct virtio_snd *snd)
 		spin_unlock_irqrestore(&queue->lock, flags);
 	}
 
-	vdev->config->del_vqs(vdev);
-	for (i = 0; i < VIRTIO_SND_VQ_MAX; ++i)
+	for (i = 0; i < VIRTIO_SND_VQ_MAX; ++i) {
+		guard(spinlock_irqsave)(&snd->queues[i].lock);
 		snd->queues[i].vqueue = NULL;
+	}
+	vdev->config->del_vqs(vdev);
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
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index 8a578a5..b62c181 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -332,6 +332,8 @@ static void virtsnd_pcm_period_elapsed(struct work_struct *work)
 
 	/* Serialize the pointer snapshot with ALSA's pointer and ACK callbacks. */
 	guard(pcm_stream_lock_irqsave)(substream);
+	if (!substream->runtime)
+		return;
 	if (!snd_pcm_running(substream)) {
 		scoped_guard(spinlock_irqsave, &vss->lock) {
 			runtime = substream->runtime;
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 7962308..1da8f09 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -65,6 +65,7 @@ enum virtio_pcm_pause_restart_state {
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
  * @stopped: True if the substream is stopped and must be released on the device
  *           side; protected by @lock.
+ * @prepared: Device PREPARE succeeded; protected by @lock.
  * @suspended: True if the substream is suspended and must be reconfigured on
  *             the device side at resume.
  * @pause_restart_state: Device-side state for opt-in pause compatibility.
@@ -106,6 +107,7 @@ struct virtio_pcm_substream {
 	bool xfer_enabled;
 	bool xfer_xrun;
 	bool stopped;
+	bool prepared;
 	bool suspended;
 	enum virtio_pcm_pause_restart_state pause_restart_state;
 	struct virtio_pcm_msg **msgs;
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index e7258bc..5e0a3a5 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -369,13 +369,13 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
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
 	vss->capture_ready = 0;
@@ -418,6 +418,10 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
 	bool notify = false;
 	int rc;
 
+	if (!vqueue || !vss->prepared || vss->suspended)
+		return -EBADFD;
+	if (!bytes)
+		return 0;
 	start = offset / period_bytes;
 	end = (offset + bytes - 1) / period_bytes;
 
@@ -562,7 +566,8 @@ static int virtsnd_pcm_capture_enqueue(struct virtio_pcm_substream *vss,
 	unsigned int i;
 	bool added = false;
 
-	if (!vss->capture_staging || !vss->runtime_active)
+	if (!vqueue || !vss->prepared || vss->suspended ||
+	    !vss->capture_staging || !vss->runtime_active)
 		return -EBADFD;
 
 	period_bytes = snd_pcm_lib_period_bytes(vss->substream);
@@ -871,7 +876,8 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
 	guard(spinlock)(&vss->lock);
 #ifndef CONFIG_MMU
 	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
-	    vss->xfer_enabled && written_bytes > sizeof(msg->status)) {
+	    vss->prepared && !vss->stopped &&
+	    written_bytes > sizeof(msg->status)) {
 		struct snd_pcm_runtime *runtime =
 			vss->substream ? vss->substream->runtime : NULL;
 		size_t reported_bytes = written_bytes - sizeof(msg->status);
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index c7e85b1..0685a00 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -128,15 +128,13 @@ static const struct virtsnd_a2v_rate g_a2v_rate_map[] = {
 };
 
 static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);
+static int virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream *substream);
 
-static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss,
-				     bool pause_restart)
+static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss)
 {
 	scoped_guard(spinlock_irqsave, &vss->lock) {
 		vss->xfer_enabled = false;
 		vss->stopped = true;
-		if (pause_restart)
-			vss->xfer_xrun = true;
 	}
 	vss->substream->runtime->stop_operating = true;
 }
@@ -170,6 +168,7 @@ virtsnd_pcm_pause_restart_send(struct virtio_pcm_substream *vss,
 			       enum virtio_pcm_pause_restart_state success_state)
 {
 	enum virtio_pcm_pause_restart_state state;
+	bool uncertain;
 	int rc;
 
 	if (!virtsnd_pcm_pause_restart_enabled(vss))
@@ -196,19 +195,24 @@ virtsnd_pcm_pause_restart_send(struct virtio_pcm_substream *vss,
 		return rc;
 	}
 
+	virtsnd_ctl_msg_ref(msg);
 	rc = virtsnd_ctl_msg_send_sync(vss->snd, msg);
+	uncertain = virtsnd_ctl_msg_uncertain(msg, rc);
+	virtsnd_ctl_msg_unref(msg);
 	scoped_guard(spinlock_irqsave, &vss->lock) {
-		if (rc || vss->pause_restart_state != submitted_state) {
+		if ((rc && uncertain) || vss->pause_restart_state != submitted_state) {
 			vss->pause_restart_state =
 				VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
 			if (!rc)
 				rc = -EIO;
+		} else if (rc) {
+			vss->pause_restart_state = state;
 		} else {
 			vss->pause_restart_state = success_state;
 		}
 	}
 
-	if (rc)
+	if (rc && uncertain)
 		dev_err(&vss->snd->vdev->dev,
 			"SID %u: PCM control state is unknown; device reprobe required\n",
 			vss->sid);
@@ -223,7 +227,8 @@ virtsnd_pcm_pause_restart_fail(struct virtio_pcm_substream *vss,
 	bool notify_xrun;
 
 	scoped_guard(spinlock_irqsave, &vss->lock) {
-		notify_xrun = !vss->xfer_xrun;
+		notify_xrun = vss->runtime_active && vss->xfer_enabled &&
+			      !vss->xfer_xrun;
 		vss->xfer_enabled = false;
 		vss->stopped = true;
 		vss->xfer_xrun = true;
@@ -330,6 +335,7 @@ static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
 	struct virtio_pcm *vpcm = snd_pcm_substream_chip(substream);
 	struct virtio_pcm_stream *vs = &vpcm->streams[substream->stream];
 	struct virtio_pcm_substream *vss = vs->substreams[substream->number];
+	int rc;
 
 	substream->runtime->hw = vss->hw;
 	substream->private_data = vss;
@@ -354,7 +360,10 @@ static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
 	 * an invalid state. Just in case, we do a check and try to return the
 	 * queue to its original state, if necessary.
 	 */
-	return virtsnd_pcm_sync_stop(substream);
+	rc = virtsnd_pcm_sync_stop(substream);
+	if (rc)
+		cancel_work_sync(&vss->elapsed_period);
+	return rc;
 }
 
 /**
@@ -469,6 +478,9 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
 	bool stopped;
 	int rc;
 
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->prepared = false;
+
 	if (vss->capture_staging) {
 		scoped_guard(spinlock_irqsave, &vss->lock) {
 			vss->runtime_active = false;
@@ -528,6 +540,9 @@ static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->prepared = false;
+
 	if (vss->capture_staging) {
 		scoped_guard(spinlock_irqsave, &vss->lock) {
 			vss->runtime_active = false;
@@ -599,8 +614,6 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 			return -EBADFD;
 		}
 
-		vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
-		vss->hw_ptr = 0;
 	} else {
 		struct snd_pcm_runtime *runtime = substream->runtime;
 		unsigned int buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
@@ -616,31 +629,30 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 		}
 	}
 
-	/* ALSA prepare resets its pointers even after a suspended stream. */
-	if (vss->capture_staging)
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->prepared = false;
+		vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
 		vss->hw_ptr = 0;
-
-	if (!pause_restart)
-		vss->xfer_xrun = false;
-	vss->suspended = false;
-	vss->msg_count = 0;
-	virtsnd_pcm_msg_reset(vss);
-	if (vss->capture_staging) {
-		scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (!pause_restart)
+			vss->xfer_xrun = false;
+		vss->suspended = false;
+		vss->msg_count = 0;
+		virtsnd_pcm_msg_reset(vss);
+		memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
+		vss->pcm_indirect.sw_buffer_size = vss->buffer_bytes;
+		vss->pcm_indirect.hw_buffer_size = vss->buffer_bytes;
+		if (vss->capture_staging) {
 			vss->capture_boundary = substream->runtime->boundary;
 			rc = virtsnd_pcm_capture_refresh_mode_locked(vss,
-								     &free_running);
+							     &free_running);
+			if (rc)
+				return rc;
 		}
-		if (rc)
-			return rc;
 	}
 
-	memset(&vss->pcm_indirect, 0, sizeof(vss->pcm_indirect));
-	vss->pcm_indirect.sw_buffer_size =
-		vss->pcm_indirect.hw_buffer_size =
-		snd_pcm_lib_buffer_bytes(substream);
-
 	rc = virtsnd_pcm_dev_prepare(vss);
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->prepared = !rc;
 	if (pause_restart) {
 		if (rc) {
 			virtsnd_pcm_pause_restart_fail(vss, false);
@@ -759,13 +771,23 @@ static int virtsnd_pcm_pause_restart_pause(struct virtio_pcm_substream *vss)
 
 	scoped_guard(spinlock_irqsave, &vss->lock) {
 		state = vss->pause_restart_state;
-		if (state == VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT ||
-		    state == VIRTSND_PCM_PAUSE_RESTART_RELEASED)
-			return 0;
+		if (state == VIRTSND_PCM_PAUSE_RESTART_RELEASED)
+			return vss->xfer_xrun ? -EPIPE : 0;
 		vss->xfer_enabled = false;
 		vss->stopped = true;
 	}
 
+	if (state == VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT) {
+		rc = virtsnd_pcm_pause_restart_sync_stop(vss->substream);
+		if (!rc) {
+			guard(spinlock_irqsave)(&vss->lock);
+			vss->stopped = true;
+			if (vss->xfer_xrun)
+				rc = -EPIPE;
+		}
+		return rc;
+	}
+
 	if (state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED ||
 	    virtsnd_pcm_pause_restart_transitioning(state)) {
 		virtsnd_pcm_pause_restart_fail(vss, true);
@@ -813,10 +835,9 @@ static int virtsnd_pcm_pause_restart_stop(struct virtio_pcm_substream *vss,
 	enum virtio_pcm_pause_restart_state state;
 	int rc;
 
-	if (suspend)
-		vss->suspended = true;
-
 	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (suspend)
+			vss->suspended = true;
 		vss->xfer_enabled = false;
 		vss->stopped = true;
 		state = vss->pause_restart_state;
@@ -887,7 +908,7 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 
 		scoped_guard(spinlock_irqsave, &queue->lock) {
 			guard(spinlock)(&vss->lock);
-			if (vss->stopped) {
+			if (vss->stopped || !vss->prepared) {
 				substream->runtime->stop_operating = true;
 				return -EBADFD;
 			}
@@ -920,17 +941,18 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
 						GFP_KERNEL);
 		if (!msg) {
-			virtsnd_pcm_start_failed(vss, false);
+			virtsnd_pcm_start_failed(vss);
 			return -ENOMEM;
 		}
 
 		rc = virtsnd_ctl_msg_send_sync(snd, msg);
 		if (rc)
-			virtsnd_pcm_start_failed(vss, false);
+			virtsnd_pcm_start_failed(vss);
 
 		return rc;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		vss->suspended = true;
+		scoped_guard(spinlock_irqsave, &vss->lock)
+			vss->suspended = true;
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
@@ -1230,6 +1252,8 @@ static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
 
 	scoped_guard(spinlock_irqsave, &queue->lock) {
 		guard(spinlock)(&vss->lock);
+		if (!vss->prepared)
+			return -EBADFD;
 		transfer.indirect = vss->pcm_indirect;
 		if (vss->stopped) {
 			rc = -EPIPE;
@@ -1275,7 +1299,7 @@ static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *vss,
 		u64 next_acked_total;
 		bool free_running;
 
-		if (!vss->runtime_active || !runtime || !runtime->control ||
+		if (!vss->prepared || !vss->runtime_active || !runtime || !runtime->control ||
 		    !runtime->dma_area)
 			return -EBADFD;
 		if (vss->xfer_xrun)
@@ -1308,7 +1332,7 @@ static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *vss,
 		     (bytes > vss->buffer_bytes || bytes > outstanding)) ||
 		    check_add_overflow(vss->capture_acked_total, (u64)bytes,
 				       &next_acked_total) ||
-		    next_acked_total > vss->capture_copied_total) {
+		    next_acked_total > vss->capture_pointer_seen_total) {
 			vss->xfer_xrun = true;
 			virtsnd_pcm_schedule_period_elapsed(vss);
 			return -EPIPE;
@@ -1352,7 +1376,9 @@ static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 
 	if (vss->capture_staging) {
 		rc = virtsnd_pcm_capture_staged_ack(vss, runtime);
-		if (rc == -EPIPE) {
+		if (rc == -EPIPE ||
+		    (!rc && runtime->state == SNDRV_PCM_STATE_PAUSED &&
+		     snd_pcm_capture_avail(runtime) >= runtime->stop_threshold)) {
 			guard(spinlock_irqsave)(&vss->lock);
 			virtsnd_pcm_capture_arm_paused_stop(vss);
 		}
@@ -1361,6 +1387,8 @@ static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 
 	scoped_guard(spinlock_irqsave, &queue->lock) {
 		guard(spinlock)(&vss->lock);
+		if (!vss->prepared)
+			return -EBADFD;
 		transfer.indirect = vss->pcm_indirect;
 		if (vss->stopped && runtime->state != SNDRV_PCM_STATE_DRAINING) {
 			rc = -EPIPE;
