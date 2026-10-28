Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180559;
	b=EerarS8z5yERlpKheIK+m6j0miwELepQcCO6NfI8JjYVh6Y/N/Yr19/FVCIv8FGWDfU2
	 jQt3FahzZUC3rCQrexNLbqnTF6BR5qZaAyYp1UdqL0WDrmC4wwUHR254/l4P8hmJqvGU7
	 kC7IsrffDdeE01WrXZTcaMIIUtnhZrcxt7mUObo4M0c0tYxj/zLGyZ43KDQxTCZ2supR9
	 mZVqwTzdNXUq1f9njHdcxe169bJLUyqO0pIU9nlZw/SVAcFJ1pIhgONFu//OdEnLlWsYx
	 gnrCSKosT3Se4wjQTvAgVV+9zwByFjmr4ogVV4UbgiqffpPuO7qhItXY6A87MrkSyBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dXMyduMzytnAp1ZnMnxqZQaqQ801PKYqhwGnJTZFYDM=;
	b=yQppCDqIAAOXLSLYoeTMaDII3VGLsg2BETsucmSDZWe4SM2VVvNaaz6tsZyjSPK/YAp2
	 /R0EnjL2gpVdKnoRsCxalLHy5eZfimPkS0Vd1x/LZUqY6/V/PXs4u9/+Xy9KGIooClWqN
	 QQjM8xP5tfcHN1mC5c2lJky6+WjmoxbbP2dgnehmc2YyDqnlICfkFiKEpe79D9J845wiH
	 0kTbXzWzLMooa+NHkuySTk4AE6fvYtvN9KGAdnqICYy1yfoea5x1yUSGBDX3Trk9qmM8m
	 yJyXTiuvjJAwliQg24Mn8GUvJ63t9tnk9wovEzvrKpCp4l50YkYqMe5/fviR0lPHPfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kd6cPaK/";
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F560A5BDE
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 502F560A5BDE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kd6cPaK/
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so637368a91.2
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180559; x=1793785359; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXMyduMzytnAp1ZnMnxqZQaqQ801PKYqhwGnJTZFYDM=;
        b=kd6cPaK/2IryZfCXm/tCzwvvs2Pmdg1j2gHUv7B7Xxu5YK5kYjRH+lhfDFXFXrdm/Z
         D5av6Y6hPp4h+uodyZyhWs6kPKyJSZG35/qM7dAt1X7JDIJfEtYov05G4j/9a0O76qtO
         Av6CFp5EXtqvUMWhd6V6WVRMT7uNLRgaA2yQ3gocweDmxeo/sxz3DlNfwvJx6eQEf6hZ
         vTMw2uuFkmm1bZXAviZeB+WLwY77xkioRI0fO7Qrk0Izipjl9R86GGPTq0qZG6FFNuse
         JQsqk/HOwX4WgJ/DtqVPlYmk+ZwxT87MNpQtZBaaw4JaHKrWqvQVDS8aqrpeALuhFdvs
         17Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180559; x=1793785359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dXMyduMzytnAp1ZnMnxqZQaqQ801PKYqhwGnJTZFYDM=;
        b=etna2ISvDDmVMjax0pAXKsQkr2+mrqhWMqSkqHfG1DoqxAYCc7XIqwy8n45Zz2HzxO
         I3feHdkZMESyihfzZYvcccQ7+68QE4rSacMuO8l170FCR6TvR+9EbemltuGciIbOkS/g
         WgA/CV+JFWFN3P0uBThhvS2yJkIFpjBiNHDQ8fywkb51FINYBx6RL67FRXYxbZCE+Lma
         G7YL6TfGizPrDGzr+O8MCgO6HiV0vjWH7cArBgPphHzdAyONlHUL/RlVQFRK4v/h46G+
         DKWAVc9UgbTa+wBTw/ilfVsv47XR34MmT1r+bJ04FLeJT4VqSLnB9OP03d8fnKNtNERR
         teRg==
X-Forwarded-Encrypted: i=1; AKwUvBzWo1QAs5mP+BpQRUPHQM6wZkmB+NM6N4kOMEQUIlgI/uxKfU82oGFP0q/LUZ+nZQwo4HE5y1ukcDGka7IKFw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJlrQQ4/N9c1bXpT8fLPHoilpLJpomWPidbVs0WiRBrl9z0INns
	odD7bd86m3ftRS88lC+uU/TsJqBlIjRJrLK6xYZrCrw5TryDAfjLcG8R
X-Gm-Gg: AYBFou3lhzbqpj0PGvxGucCR08ycJ4fcj2/297Xo/2w9gAwnSLpko6aQ4FB9Q7XEriA
	gmyjKbXAP7+xRcXwjQM9xz+riurFUks0h4A3nhZvp3OfGRw0XGyf+9fjh4BxpotkemmlIG/M9cP
	vlyCW+JKmTMUt1s/POZjUrTNieMBHrhy6EOYPjPE3qN8SchQEUxfoa52WrD2ynvop3n7MYxA98v
	ndakG2zHlSfvQdq7xf9totyPusYOkvBg3Q/YtWAnqAW401mtD6VGsHn3zE1g0u5Fj47JqwR7ssU
	lToXrNTHCmUEYGMxF8CramxBsUYL/5x50YFVlAYj8q1TTHn68tAk3qls0wKtZLnNINjQtKNjl77
	I5lUBJssurXQ0JLRGePltcU5LjkriqT4XOP7hwueXdV732R2KJ31x7nfmFH3fYo8hYep0WAgOOA
	/7XsNxkQZLwf0DuiwtfQEMabuv2+t/4Usri6TrNqMfWX0IlH2k6jIPgcoaev990J12wJJDWJut/
	XmCEkvaPrFxE5y+sGXy6azQ+BS6JhjkMA9IO5ezKwMzubH3zlIlAPSKa9c0v73nLlDVBXfjYZQt
	AZXZPobp78U8hZsNiZumEZDiHcunvu3euqGAmixK7dVk8AWoE4eWusAbIAzHunwxc5c1MjAHGTi
	lsW0pf/xmaNVPSxkpwIlgRqrsQA2IHhBaOm+OR9y2pS03mRFpOtDfZAiHZ5vSaGvZ3r9b
X-Received: by 2002:a17:90b:524d:b0:3ac:8527:3fcd with SMTP id 98e67ed59e1d1-3ae582c2b4dmr1398629a91.39.1793180558549;
        Wed, 28 Oct 2026 02:42:38 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a93b3f5sm2242377a91.5.2026.10.28.02.42.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 02:42:38 -0700 (PDT)
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
Subject: [PATCH v7 16/16] ALSA: virtio: serialize capture lifecycle and reset state
Date: Wed, 28 Oct 2026 18:41:32 +0900
Message-ID: <20261028094132.20364-17-mynameisjune111@gmail.com>
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

The staged capture paths can lose pending period notifications across
pause, keep counters based on the old ALSA position after RESET, and race
prepare with synchronous release. A RELEASE_SENT retry can also cancel
period work while holding the PCM lock, causing a lockdep cycle and hang.

Schedule pending period work after successful start or resume, rebase the
staged counters on RESET, and serialize process-context lifecycle calls
with a per-stream mutex. Keep trigger outside that mutex and wait for RX
without cancelling period work from the RELEASE_SENT trigger retry.
Notify an active runtime of resume failure even after transfer shutdown.

Invalidate late control responses with a reset generation. Revoke device
PREPARE permission at prepare entry and RELEASE completion. Allow cached
tails in DRAINING and released PAUSED capture without refilling RX. Remove
the successful paused-ACK threshold prediction; the preceding core change
marks synchronous cleanup on the actual stop transition.

Move runtime buffer allocation into hw_params after old RX cleanup under
the lifecycle mutex. Revoke transfer and copy access in hw_free before
synchronous cleanup and mapping release. Preserve request-owned DMA and
bounce-buffer lifetime protection.

Targeted QEMU tests cover pending notifications, RESET, paused forward and
wrapped reads, RELEASE retry, concurrent prepare, failed resume, late
control completion across bus freeze/restore, early prepare failure and
non-staged recovery. KASAN and lockdep report no errors in corrected runs.
NOMMU runtime and physical VZ/MOTU validation have not been repeated.

One-vCPU TCG contention still produces dsnoop client-threshold XRUNs on
both v6 and this candidate while the slave remains RUNNING. Both pass the
hardware-accelerated comparison. The cover letter records the failure
counts and the unresolved TCG worker wall-time difference.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 852cc27..2fd8595 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -354,6 +354,7 @@ static void virtsnd_reset_vqs(struct virtio_snd *snd)
 
 		guard(spinlock_irqsave)(&queue->lock);
 		guard(spinlock)(&vss->lock);
+		vss->reset_epoch++;
 		vss->prepared = false;
 		vss->xfer_enabled = false;
 		vss->suspended = true;
diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index b62c181..1fe8c50 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -443,6 +443,7 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
 		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
 		init_waitqueue_head(&vss->msg_empty);
 		spin_lock_init(&vss->lock);
+		mutex_init(&vss->lifecycle_lock);
 	}
 
 	info = kzalloc_objs(*info, snd->nsubstreams);
@@ -576,7 +577,7 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
 			snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops[i]);
 		}
 
-		snd_pcm_set_managed_buffer_all(vpcm->pcm,
+		snd_pcm_lib_preallocate_pages_for_all(vpcm->pcm,
 					       SNDRV_DMA_TYPE_VMALLOC, NULL,
 					       0, 0);
 	}
diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 1da8f09..1140b4b 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -7,6 +7,7 @@
 #define VIRTIO_SND_PCM_H
 
 #include <linux/atomic.h>
+#include <linux/mutex.h>
 #include <linux/virtio_config.h>
 #include <linux/workqueue.h>
 #include <sound/pcm.h>
@@ -43,6 +44,8 @@ enum virtio_pcm_pause_restart_state {
  * @pcm_indirect: Kernel indirect pcm structure.
  * @hw: Kernel ALSA substream hardware descriptor.
  * @elapsed_period: Kernel work to handle the elapsed period state.
+ * @lifecycle_lock: Serializes prepare with synchronous release, outside trigger.
+ * @reset_epoch: Invalidates control replies from before device reset.
  * @lock: Spinlock that protects fields shared by interrupt handlers and
  *        substream operators, including @stopped.
  * @buffer_bytes: Current buffer size in bytes.
@@ -89,6 +92,8 @@ struct virtio_pcm_substream {
 	struct snd_pcm_hardware hw;
 	struct work_struct elapsed_period;
 	spinlock_t lock;
+	struct mutex lifecycle_lock;
+	u64 reset_epoch;
 	size_t buffer_bytes;
 	size_t hw_ptr;
 	size_t capture_ready;
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 0685a00..573fab6 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -128,11 +128,14 @@ static const struct virtsnd_a2v_rate g_a2v_rate_map[] = {
 };
 
 static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);
+static int virtsnd_pcm_sync_stop_locked(struct snd_pcm_substream *substream);
 static int virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream *substream);
 
 static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss)
 {
 	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->suspended)
+			return;
 		vss->xfer_enabled = false;
 		vss->stopped = true;
 	}
@@ -160,6 +163,22 @@ static bool virtsnd_pcm_pause_restart_transitioning(enum virtio_pcm_pause_restar
 	}
 }
 
+static int virtsnd_pcm_send_sync(struct virtio_pcm_substream *vss,
+				 struct virtio_snd_msg *msg)
+{
+	u64 epoch;
+	int rc;
+
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		epoch = vss->reset_epoch;
+	rc = virtsnd_ctl_msg_send_sync(vss->snd, msg);
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (epoch != vss->reset_epoch)
+			return -ECANCELED;
+	}
+	return rc;
+}
+
 static int
 virtsnd_pcm_pause_restart_send(struct virtio_pcm_substream *vss,
 			       struct virtio_snd_msg *msg,
@@ -169,12 +188,14 @@ virtsnd_pcm_pause_restart_send(struct virtio_pcm_substream *vss,
 {
 	enum virtio_pcm_pause_restart_state state;
 	bool uncertain;
+	u64 epoch;
 	int rc;
 
 	if (!virtsnd_pcm_pause_restart_enabled(vss))
-		return virtsnd_ctl_msg_send_sync(vss->snd, msg);
+		return virtsnd_pcm_send_sync(vss, msg);
 
 	scoped_guard(spinlock_irqsave, &vss->lock) {
+		epoch = vss->reset_epoch;
 		state = vss->pause_restart_state;
 		if (state == VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED) {
 			rc = -EIO;
@@ -200,6 +221,8 @@ virtsnd_pcm_pause_restart_send(struct virtio_pcm_substream *vss,
 	uncertain = virtsnd_ctl_msg_uncertain(msg, rc);
 	virtsnd_ctl_msg_unref(msg);
 	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->reset_epoch != epoch)
+			return -ECANCELED;
 		if ((rc && uncertain) || vss->pause_restart_state != submitted_state) {
 			vss->pause_restart_state =
 				VIRTSND_PCM_PAUSE_RESTART_RESET_REQUIRED;
@@ -227,8 +250,9 @@ virtsnd_pcm_pause_restart_fail(struct virtio_pcm_substream *vss,
 	bool notify_xrun;
 
 	scoped_guard(spinlock_irqsave, &vss->lock) {
-		notify_xrun = vss->runtime_active && vss->xfer_enabled &&
-			      !vss->xfer_xrun;
+		if (vss->suspended)
+			return;
+		notify_xrun = vss->runtime_active;
 		vss->xfer_enabled = false;
 		vss->stopped = true;
 		vss->xfer_xrun = true;
@@ -310,6 +334,7 @@ virtsnd_pcm_pause_release_flush(struct virtio_pcm_substream *vss,
 			    VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT) {
 			rc = -ETIMEDOUT;
 		} else {
+			vss->prepared = false;
 			vss->pause_restart_state =
 				VIRTSND_PCM_PAUSE_RESTART_RELEASED;
 		}
@@ -353,7 +378,6 @@ static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
 
 	scoped_guard(spinlock_irqsave, &vss->lock)
 		vss->stopped |= !!vss->msg_count;
-	vss->suspended = false;
 
 	/*
 	 * If the substream has already been used, then the I/O queue may be in
@@ -478,6 +502,11 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
 	bool stopped;
 	int rc;
 
+	guard(mutex)(&vss->lifecycle_lock);
+	/* Drain the previous buffer before ALSA can replace its mapping. */
+	rc = virtsnd_pcm_sync_stop_locked(substream);
+	if (rc)
+		return rc;
 	scoped_guard(spinlock_irqsave, &vss->lock)
 		vss->prepared = false;
 
@@ -505,6 +534,11 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
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
@@ -539,9 +573,16 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
 static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	int rc;
 
-	scoped_guard(spinlock_irqsave, &vss->lock)
+	guard(mutex)(&vss->lifecycle_lock);
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->stopped |= vss->prepared;
 		vss->prepared = false;
+		vss->runtime_active = false;
+		vss->xfer_enabled = false;
+	}
+	rc = virtsnd_pcm_sync_stop_locked(substream);
 
 	if (vss->capture_staging) {
 		scoped_guard(spinlock_irqsave, &vss->lock) {
@@ -567,17 +608,18 @@ static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
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
@@ -585,6 +627,14 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 	bool free_running;
 	int rc;
 	bool stopped;
+	bool suspended;
+	u64 epoch;
+
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->prepared = false;
+		epoch = vss->reset_epoch;
+		suspended = vss->suspended;
+	}
 
 	if (pause_restart) {
 		enum virtio_pcm_pause_restart_state state;
@@ -607,7 +657,7 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 		return -EBADFD;
 	}
 
-	if (!vss->suspended) {
+	if (!suspended) {
 		if (virtsnd_pcm_msg_pending_num(vss)) {
 			dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
 				vss->sid);
@@ -630,6 +680,8 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 	}
 
 	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (epoch != vss->reset_epoch)
+			return -ECANCELED;
 		vss->prepared = false;
 		vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
 		vss->hw_ptr = 0;
@@ -651,10 +703,15 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 	}
 
 	rc = virtsnd_pcm_dev_prepare(vss);
-	scoped_guard(spinlock_irqsave, &vss->lock)
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (epoch != vss->reset_epoch)
+			return -ECANCELED;
 		vss->prepared = !rc;
+	}
 	if (pause_restart) {
 		if (rc) {
+			if (rc == -ECANCELED)
+				return rc;
 			virtsnd_pcm_pause_restart_fail(vss, false);
 		} else {
 			scoped_guard(spinlock_irqsave, &vss->lock) {
@@ -667,6 +724,14 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 	return rc;
 }
 
+static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+
+	guard(mutex)(&vss->lifecycle_lock);
+	return virtsnd_pcm_prepare_locked(substream);
+}
+
 static int virtsnd_pcm_pause_restart_start(struct virtio_pcm_substream *vss,
 					   bool resume)
 {
@@ -704,6 +769,8 @@ static int virtsnd_pcm_pause_restart_start(struct virtio_pcm_substream *vss,
 	if (resume) {
 		rc = virtsnd_pcm_pause_prepare(vss);
 		if (rc) {
+			if (rc == -ECANCELED)
+				return rc;
 			virtsnd_pcm_pause_restart_failed(vss);
 			return rc;
 		}
@@ -715,11 +782,14 @@ static int virtsnd_pcm_pause_restart_start(struct virtio_pcm_substream *vss,
 				rc = -EBADFD;
 			} else {
 				/* Preserve ring accounting, restarting only startup grace. */
+				vss->prepared = true;
 				vss->capture_started = false;
 				vss->capture_empty = 0;
 			}
 		}
 		if (rc) {
+			if (rc == -ECANCELED)
+				return rc;
 			virtsnd_pcm_pause_restart_failed(vss);
 			return rc;
 		}
@@ -738,6 +808,8 @@ static int virtsnd_pcm_pause_restart_start(struct virtio_pcm_substream *vss,
 		}
 	}
 	if (rc) {
+		if (rc == -ECANCELED)
+			return rc;
 		virtsnd_pcm_pause_restart_failed(vss);
 		return rc;
 	}
@@ -753,12 +825,18 @@ static int virtsnd_pcm_pause_restart_start(struct virtio_pcm_substream *vss,
 					    VIRTSND_PCM_PAUSE_RESTART_START_SUBMITTED,
 					    VIRTSND_PCM_PAUSE_RESTART_RUNNING);
 	if (rc) {
+		if (rc == -ECANCELED)
+			return rc;
 		virtsnd_pcm_pause_restart_failed(vss);
 		return rc;
 	}
 
-	scoped_guard(spinlock_irqsave, &vss->lock)
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->suspended)
+			return -ECANCELED;
 		vss->stopped = false;
+	}
+	virtsnd_pcm_schedule_period_elapsed(vss);
 
 	return 0;
 }
@@ -771,20 +849,31 @@ static int virtsnd_pcm_pause_restart_pause(struct virtio_pcm_substream *vss)
 
 	scoped_guard(spinlock_irqsave, &vss->lock) {
 		state = vss->pause_restart_state;
-		if (state == VIRTSND_PCM_PAUSE_RESTART_RELEASED)
+		if (state == VIRTSND_PCM_PAUSE_RESTART_RELEASED) {
+			if (vss->xfer_xrun)
+				virtsnd_pcm_schedule_period_elapsed(vss);
 			return vss->xfer_xrun ? -EPIPE : 0;
+		}
 		vss->xfer_enabled = false;
 		vss->stopped = true;
 	}
 
 	if (state == VIRTSND_PCM_PAUSE_RESTART_RELEASE_SENT) {
-		rc = virtsnd_pcm_pause_restart_sync_stop(vss->substream);
-		if (!rc) {
-			guard(spinlock_irqsave)(&vss->lock);
-			vss->stopped = true;
-			if (vss->xfer_xrun)
-				rc = -EPIPE;
+		unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+
+		/* Trigger holds the PCM lock: never cancel the period worker here. */
+		if (!wait_event_timeout(vss->msg_empty,
+				       !virtsnd_pcm_msg_pending_num(vss), js))
+			return -ETIMEDOUT;
+		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (vss->suspended)
+				return -ECANCELED;
+			vss->prepared = false;
+			vss->pause_restart_state = VIRTSND_PCM_PAUSE_RESTART_RELEASED;
+			rc = vss->xfer_xrun ? -EPIPE : 0;
 		}
+		if (rc)
+			virtsnd_pcm_pause_restart_failed(vss);
 		return rc;
 	}
 
@@ -807,6 +896,8 @@ static int virtsnd_pcm_pause_restart_pause(struct virtio_pcm_substream *vss)
 						    VIRTSND_PCM_PAUSE_RESTART_STOP_SUBMITTED,
 					    VIRTSND_PCM_PAUSE_RESTART_STOPPED);
 		if (rc) {
+			if (rc == -ECANCELED)
+				return rc;
 			virtsnd_pcm_pause_restart_failed(vss);
 			return rc;
 		}
@@ -821,6 +912,8 @@ static int virtsnd_pcm_pause_restart_pause(struct virtio_pcm_substream *vss)
 					     BIT(VIRTSND_PCM_PAUSE_RESTART_STOPPED) |
 					     BIT(VIRTSND_PCM_PAUSE_RESTART_PREPARED));
 	if (rc) {
+		if (rc == -ECANCELED)
+			return rc;
 		virtsnd_pcm_pause_restart_failed(vss);
 		return rc;
 	}
@@ -836,6 +929,8 @@ static int virtsnd_pcm_pause_restart_stop(struct virtio_pcm_substream *vss,
 	int rc;
 
 	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (!vss->prepared && !vss->msg_count)
+			return 0;
 		if (suspend)
 			vss->suspended = true;
 		vss->xfer_enabled = false;
@@ -861,7 +956,7 @@ static int virtsnd_pcm_pause_restart_stop(struct virtio_pcm_substream *vss,
 					    BIT(VIRTSND_PCM_PAUSE_RESTART_RUNNING),
 					    VIRTSND_PCM_PAUSE_RESTART_STOP_SUBMITTED,
 					    VIRTSND_PCM_PAUSE_RESTART_STOPPED);
-	if (rc)
+	if (rc && rc != -ECANCELED)
 		virtsnd_pcm_pause_restart_failed(vss);
 
 	return rc;
@@ -879,7 +974,6 @@ static int virtsnd_pcm_pause_restart_stop(struct virtio_pcm_substream *vss,
 static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
-	struct virtio_snd *snd = vss->snd;
 	struct virtio_snd_queue *queue;
 	struct virtio_snd_msg *msg;
 	int rc = 0;
@@ -945,10 +1039,12 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 			return -ENOMEM;
 		}
 
-		rc = virtsnd_ctl_msg_send_sync(snd, msg);
-		if (rc)
+		rc = virtsnd_pcm_send_sync(vss, msg);
+		if (rc && rc != -ECANCELED)
 			virtsnd_pcm_start_failed(vss);
 
+		if (!rc && vss->capture_staging)
+			virtsnd_pcm_schedule_period_elapsed(vss);
 		return rc;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		scoped_guard(spinlock_irqsave, &vss->lock)
@@ -957,6 +1053,8 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (!vss->prepared)
+				return 0;
 			if (command != SNDRV_PCM_TRIGGER_PAUSE_PUSH)
 				vss->stopped = true;
 			vss->xfer_enabled = false;
@@ -967,7 +1065,7 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 		if (!msg)
 			return -ENOMEM;
 
-		return virtsnd_ctl_msg_send_sync(snd, msg);
+		return virtsnd_pcm_send_sync(vss, msg);
 	default:
 		return -EINVAL;
 	}
@@ -1023,6 +1121,8 @@ virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream *substream)
 						    VIRTSND_PCM_PAUSE_RESTART_STOP_SUBMITTED,
 						    VIRTSND_PCM_PAUSE_RESTART_STOPPED);
 		if (rc) {
+			if (rc == -ECANCELED)
+				return rc;
 			virtsnd_pcm_pause_restart_fail(vss, false);
 			return rc;
 		}
@@ -1039,11 +1139,14 @@ virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream *substream)
 			return rc;
 		}
 		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (vss->suspended)
+				return -ECANCELED;
 			if (vss->msg_count) {
 				rc = -ETIMEDOUT;
 			} else {
 				vss->pause_restart_state =
 					VIRTSND_PCM_PAUSE_RESTART_RELEASED;
+				vss->prepared = false;
 				vss->stopped = false;
 				rc = 0;
 			}
@@ -1063,18 +1166,24 @@ virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream *substream)
 					     BIT(VIRTSND_PCM_PAUSE_RESTART_PREPARED) |
 					     BIT(VIRTSND_PCM_PAUSE_RESTART_STOPPED));
 	if (rc) {
+		if (rc == -ECANCELED)
+			return rc;
 		virtsnd_pcm_pause_restart_fail(vss, false);
 		return rc;
 	}
 
-	scoped_guard(spinlock_irqsave, &vss->lock)
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->suspended)
+			return -ECANCELED;
+		vss->prepared = false;
 		vss->stopped = false;
+	}
 
 	return 0;
 }
 
 /**
- * virtsnd_pcm_sync_stop() - Synchronous PCM substream stop.
+ * virtsnd_pcm_sync_stop_locked() - Synchronous PCM substream stop.
  * @substream: Kernel ALSA substream.
  *
  * The function can be called both from the upper level or from the driver
@@ -1083,7 +1192,7 @@ virtsnd_pcm_pause_restart_sync_stop(struct snd_pcm_substream *substream)
  * Context: Process context. Takes and releases the VirtIO substream spinlock.
  * Return: 0 on success, -errno on failure.
  */
-static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
+static int virtsnd_pcm_sync_stop_locked(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd *snd = vss->snd;
@@ -1097,7 +1206,7 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
 
 	scoped_guard(spinlock_irqsave, &vss->lock) {
 		vss->xfer_enabled = false;
-		need_release = vss->stopped || vss->msg_count;
+		need_release = vss->prepared || vss->stopped || vss->msg_count;
 		if (need_release)
 			vss->stopped = true;
 	}
@@ -1112,7 +1221,7 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
 		return -ENOMEM;
 	}
 
-	rc = virtsnd_ctl_msg_send_sync(snd, msg);
+	rc = virtsnd_pcm_send_sync(vss, msg);
 	if (rc) {
 		substream->runtime->stop_operating = true;
 		return rc;
@@ -1135,8 +1244,12 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
 		return !rc ? -ETIMEDOUT : rc;
 	}
 
-	scoped_guard(spinlock_irqsave, &vss->lock)
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		if (vss->suspended)
+			return -ECANCELED;
+		vss->prepared = false;
 		vss->stopped = false;
+	}
 
 	return 0;
 }
@@ -1299,8 +1412,13 @@ static int virtsnd_pcm_capture_staged_ack(struct virtio_pcm_substream *vss,
 		u64 next_acked_total;
 		bool free_running;
 
-		if (!vss->prepared || !vss->runtime_active || !runtime || !runtime->control ||
-		    !runtime->dma_area)
+		if (!vss->runtime_active || !runtime || !runtime->control ||
+		    !runtime->dma_area || vss->suspended)
+			return -EBADFD;
+		if (!vss->prepared && runtime->state != SNDRV_PCM_STATE_DRAINING &&
+		    !(runtime->state == SNDRV_PCM_STATE_PAUSED &&
+		      virtsnd_pcm_pause_restart_enabled(vss) &&
+		      vss->pause_restart_state == VIRTSND_PCM_PAUSE_RESTART_RELEASED))
 			return -EBADFD;
 		if (vss->xfer_xrun)
 			return -EPIPE;
@@ -1376,9 +1494,7 @@ static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 
 	if (vss->capture_staging) {
 		rc = virtsnd_pcm_capture_staged_ack(vss, runtime);
-		if (rc == -EPIPE ||
-		    (!rc && runtime->state == SNDRV_PCM_STATE_PAUSED &&
-		     snd_pcm_capture_avail(runtime) >= runtime->stop_threshold)) {
+		if (rc == -EPIPE) {
 			guard(spinlock_irqsave)(&vss->lock);
 			virtsnd_pcm_capture_arm_paused_stop(vss);
 		}
@@ -1387,7 +1503,7 @@ static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 
 	scoped_guard(spinlock_irqsave, &queue->lock) {
 		guard(spinlock)(&vss->lock);
-		if (!vss->prepared)
+		if (!vss->prepared && runtime->state != SNDRV_PCM_STATE_DRAINING)
 			return -EBADFD;
 		transfer.indirect = vss->pcm_indirect;
 		if (vss->stopped && runtime->state != SNDRV_PCM_STATE_DRAINING) {
@@ -1415,12 +1531,52 @@ static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+
+	guard(mutex)(&vss->lifecycle_lock);
+	return virtsnd_pcm_sync_stop_locked(substream);
+}
+
+static int virtsnd_pcm_ioctl(struct snd_pcm_substream *substream,
+			    unsigned int cmd, void *arg)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	size_t position;
+	size_t period;
+	int rc;
+
+	if (cmd != SNDRV_PCM_IOCTL1_RESET || !vss->capture_staging)
+		return snd_pcm_lib_ioctl(substream, cmd, arg);
+
+	rc = snd_pcm_lib_ioctl(substream, cmd, arg);
+	if (rc)
+		return rc;
+	guard(pcm_stream_lock_irqsave)(substream);
+	runtime->status->hw_ptr %= runtime->buffer_size;
+	position = frames_to_bytes(runtime, runtime->status->hw_ptr);
+	period = snd_pcm_lib_period_bytes(substream);
+	guard(spinlock_irqsave)(&vss->lock);
+	vss->hw_ptr = position;
+	vss->capture_copied_total = position;
+	vss->capture_acked_total = position;
+	vss->capture_pointer_seen_total = position;
+	vss->capture_ready = 0;
+	vss->capture_notified_periods = period ? position / period : 0;
+	vss->capture_callback_snapshot = 0;
+	vss->capture_callback_snapshot_active = false;
+	vss->pcm_indirect.appl_ptr = runtime->status->hw_ptr;
+	return 0;
+}
+
 /* PCM substream operators map. */
 const struct snd_pcm_ops virtsnd_pcm_ops[] = {
 	{
 		.open = virtsnd_pcm_open,
 		.close = virtsnd_pcm_close,
-		.ioctl = snd_pcm_lib_ioctl,
+		.ioctl = virtsnd_pcm_ioctl,
 		.hw_params = virtsnd_pcm_hw_params,
 		.hw_free = virtsnd_pcm_hw_free,
 		.prepare = virtsnd_pcm_prepare,
@@ -1432,7 +1588,7 @@ const struct snd_pcm_ops virtsnd_pcm_ops[] = {
 	{
 		.open = virtsnd_pcm_open,
 		.close = virtsnd_pcm_close,
-		.ioctl = snd_pcm_lib_ioctl,
+		.ioctl = virtsnd_pcm_ioctl,
 		.hw_params = virtsnd_pcm_hw_params,
 		.hw_free = virtsnd_pcm_hw_free,
 		.prepare = virtsnd_pcm_prepare,
