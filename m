Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156047;
	b=Co1Z8tYZixiMZ4e2eCZNi82mx4pHGhBD/1SpRaCkOYK5vU3/Do9NEVcYIqvQKHbloka2
	 0AXdXVGgOtTprHhzhg0wW9eKjlLRr4/NK4w76uVdF5CWrf5NFVCySGXlFIgCcNUeQpzBx
	 1SKw/7dwe9gigY7KmDM7ZtOuS9QZ2TVH15GkKXntaXWp8oBci/+Khlp1z/RGt6DltmoDd
	 wZvaXlovNTd6FeCCWUvKICkBfvO4qGAeVnI6qGXjkCaoysZe/URRO5FL/6mt68u7EZCvO
	 5lphtpugP9nY12k8IXRUvSwqo7GLMKc00bp9Sw0eDk8XwCVv4WI4Nwe7Sy+Ay4FTNOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4XywAoxeaZzuOeDhhvc4sxnHZ3aBk4zO8y4jW5OboPk=;
	b=ulncebwajX261/YjQ16ddPupVal80mdlgHCV4iY1zYiaQH678Plg8lWT4ZthpSGfjNC+
	 f0RHJuzh2oKsxcRblMgKPQiAxB0vTLm0Amg2eqfk4QJVeSgUta60tCCmpcAThfkRxBzOU
	 v5H2+Eu/ThRM8lca1WtzUXTolu0JrDkk7ZWIEZk/jTScYtyoNV51iGNTMg0QaUNFd0tCP
	 dpcA1BYZDVBb2mCqN7+Zh+aPa0pvO776r8UtUlmxkolQ8nbUPv35iCjyNzJgXQcNGfxzp
	 tlw8AyIKzz1Ew3LF+kDhoMfbjujFBa3d8BuiLEuurYwxa9qs34mj4nWpKwmOCBld7xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BHaATBYh;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41E160A2633
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E41E160A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BHaATBYh
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a17a332ecso646515eec.1
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 19:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156045; x=1793760845; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XywAoxeaZzuOeDhhvc4sxnHZ3aBk4zO8y4jW5OboPk=;
        b=BHaATBYhWO9E1pCylINx9Hi+GO/7xpdPULZxsOZ2qpLmfhrKu8vVMy19v0vwVe4ADg
         9RMx+Yl41pjfUT7tzQs/m8tL/tKpKQTehEy6NCvcAiUix7zekV1vSFhzxufJUxKLjzfJ
         QBynEaSyjzwl+DR/9LF9AV8z2DXoyPCwrP30fi1UdaYaSRmvmpmxFpTSgapzS/WNb3jL
         54kNiLsbXBcAbcYttUuCllahP8wQO5772TILRyobHJi44wLobefRSzczjVXaxQwBZ2dH
         i1WyxfKa30dSiDpSVK2iKUTz0qDwIp8ryiYx674ZYEkiMh7+PReP1edZkJPNg2AlawMR
         UnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156045; x=1793760845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4XywAoxeaZzuOeDhhvc4sxnHZ3aBk4zO8y4jW5OboPk=;
        b=ctW1rv7K9X+arfaCr5Gq4NtMM3gzPlMLIqEtscmqtHa18qBQpb8PFKnWp3uAHBRcFU
         aiyexKwUETBJTjd/PkucSDecsiGu99LME/3t6YEgGsS/saTOy1BAs4JJnIROj5Ufi/zj
         AjGIK6ZKYSZfBLSJmoN6zGDg7XigqSXsjTvu3x3mMIwSuzuc1zXn44JRMcIroXFx9xhA
         JpkQ36aJKRoBSb9QVxij+MSrk288XtQj1YU3zesPKyZUc43YMHyo51UtdtY13a68b1oF
         Si8Fkcn/f3kII6ASdNlQDnjvMIuVNjRYN0Xmq4ax1rGuFqf0t5ft0UjNhs6yXBw/Xdkz
         TLhw==
X-Forwarded-Encrypted: i=1; AKwUvBy+8Nh3wzOACNmrCBnhsEXsx/aYLu/jmstq5DW9cAHjf0aW14M7//+GOFFPJRio/jSgh3cg0SE68J0ocX00fQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLdp3ZVNkNMH2t9lSOhX9TuP2Ldy9KxdO0BlJjpBzpNBu5naeis
	o6ic5pwC/hvuVBb2I+75PPu+00x5gJGuPiS1PPlzElqNuUjDn5MHlPM2
X-Gm-Gg: AYBFou2cCp1httn/rSqHuOfVWaCvnQDIN9PcI43xD0sbROP7Ep5FYQzvc4zESMzI0/t
	bPdP0Z8VtXPAyYAbzWS5I3l1DM5Gufczb66Zfy9PZUrdB3Z3IccjMpW4205HRyMZ2v6tQ0r9iS2
	XNR5POeABOvbB5C/TYGSpqXO9/GjNDimHmDip0d8FTihelpepIwyxxX1IGh3m4uegvl377VklFW
	EloKqm/TOzD7AIFUw8qjLEA3sfGn/jSPDqDr32B44RHc5UCEUoBXHzFJ7VTGpxtYNNxZcv+1omF
	zKluICsqWIwt8E9iiikW+r1KTjBGTNGUzgMc6J0Z9OiBEJzvG2I3TdE9FhA9b1AU1B6yn87RQVB
	s/278pgjodERwhm/rEVJgRjNg4z7ka2ANbH6IUkAuvkRXKhmjgkM92SlAA4x6ikpS0AXc9FGQ2d
	9oBVfjk+LUOqrViKJc8icHFsceDOGygr+i8mjHkJf/+zFNaYwskXB/xxGOIhSehWTPw9CIBLVcU
	zUcYOvEABy9/O6gA3A8s2rIQAbO0qfqohJe/NcTR2RkDCLnVniNse32tHNxCQjpXQU/UgcAo3t3
	ISZK1DfVjDdMZjOw15sQtWsMh2fjSqVkuCxOTJnmBxT1E1fYjTnHeCeZbDngBPF1taN6p4VixNB
	J7YjhGZVx80ERgYqrUI6fLo/UUTXRutHQqBql7g0iASavfL8=
X-Received: by 2002:a05:7300:c7c3:b0:369:9af5:7bc9 with SMTP id 5a478bee46e88-36a2017929amr1448976eec.23.1793156044817;
        Tue, 27 Oct 2026 19:54:04 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm1711914eec.23.2026.10.27.19.54.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:54:04 -0700 (PDT)
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
Subject: [PATCH v6 13/14] ALSA: virtio: fence staged capture state and recovery
Date: Wed, 28 Oct 2026 11:53:16 +0900
Message-ID: <20261028025317.92450-14-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028025317.92450-1-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
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
