Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693315;
	b=xTa6AZligTRMsNLlk2N2x5qEZy+sXeJQss52Qu1BonstahkhB3s+YklB0D3ZjwQeDGWS
	 woe+wnmQ0lCVkKEPvem/4qOvfLL2bOx0DUaGH5I8DHxVU9cKOAZlEmKlQwFbHR5oS5EdB
	 pPN+hHXX+PjplVduW/i1Vy9vWERxg4lCZi6r14OJPnH+F/iQA510oJbdF5McjrsS8zhHa
	 Mmse2TI9T/E24f7D42hgwZZYTW1KMklzC0b51W+ICI3Td2YyQ7kT/J+kn/yJ0e4qixliK
	 C0YlTZ8ikvjuYBrPsIqvaja2dkRPIVy3uNElb7jfMw4bnCDV2UWLAWpkI8aJFcLLBHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7ISRk/hThz0s3N0yY62fPvRzMoAMDGueG8DMaorOn1g=;
	b=WRytmx79nfuMVxzUsdQRQOcxdmJ07cZoIujkcFDn0UsyhAG/kYiwVwRAvo+qMGFkW5bI
	 ijqFqxyX6VoL8bvzcG+1I6fMI2G/Zmj05N5b+WEAWNupgwqcaHouiXlj4fUkliX4ttaZu
	 EnVps3cOIssbZlLv8Jkd7G/2gLIjqZcbCSoHXpGBRdeqGpprS9XJH/owYfuM8BXlhtbLV
	 1UUCVUGpmTQp1s8Vtrh40MGJ7dv68GpYr5+2IyhuqzLWoSSOwZn5D8s8pjemkLWi5uzyn
	 E8y7/TIHLhsvJj8y6Ee8LlncYubWSVnyLRfShhE4WdaFBDBiSjsbGzXuCYWZi4d4lAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="BV9/2wir";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF285606A331
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF285606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BV9/2wir
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a17a332ecso5941947eec.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 00:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793693314; x=1794298114; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ISRk/hThz0s3N0yY62fPvRzMoAMDGueG8DMaorOn1g=;
        b=BV9/2wirb/u9lUJXfhs8xbW82Wch1YI5jQou7Vezm6bs/B0dkvFO/MTZToIvT/1UST
         GIdGZ644suphZiRe6eksDGfA/pKaMbPKDoFBssc3duIkwv/AxjGmveLT5/buuh4P3z4t
         HzNQX8S0HtjLYMFl2zpvbehALpOrbBCA2JLaIs2QVOXaclyyX/+sB1tnuvL85dBk3E+K
         gPTDMx4Zlcoks9w1Ttb0h2rCaBw2eEy9p/c+rtw+uZQDTK0p7LtkBQGQDL+xYw0LEvNf
         vtr46LkjKZObVBPFkDFeSMHzgJiTzcAdvof0MrOCUlGDNXKv15HGsRNtiQSzAznUp3r/
         pTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693314; x=1794298114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ISRk/hThz0s3N0yY62fPvRzMoAMDGueG8DMaorOn1g=;
        b=r1YTvv7xeJfwKFeTCxhYAB5i2CVmKc/SEoMEaPtLaIOWzKuKSITVKfXrXaAsx1xHgk
         rOeGvWQk6fggTvyEQNX/9pguRl0Fq47Tz+/VqfcHWaQExxdsiOTMJPnJDVd/MGl1jhg2
         VOXYRPmIqpAtQrwJvccKK9D9BZRMg/JvePO5vVsX1MQdIYdDOnyipXJYebsj0U0EAwZH
         ULTu+Ly8pt60nUEpLyBXWe9YEJCZHVCXnssIzZPdLbKgdxdqOl+8YhEOcnIcw5J+6gNY
         7qzM0vjDy5aWcFMtMd06XqwJPbrLuYGCDkoWh3pcJbaB7SSImcVLC7cHOl2+IKAbOvyW
         5iWg==
X-Forwarded-Encrypted: i=1; AKwUvByhMp08u/8TeWsuChie5dYyztVuR58aCCsdWdN11nvZ5i2ods3TSTC4ezmMCPqhSJcbQQU86Obcd+xSriR30w==@lists.linux.dev
X-Gm-Message-State: APuU4Z81wgeVM5KHiGj7+r3RZfG8Wq6U/rBVEB3JiWPDAAI1mme7O/42
	z7rk1pi/Yz01acYMomiR8G9+XyWCcVNeqvWhNPz9opeGrkW7uBWUzRSJ
X-Gm-Gg: AYBFou1hdMi7LTMs9mvG1aKeUrawZDi+r2HawSsdOsqzxXk8fphG7JSKdqPsxAT6Ozb
	Zzrti1sofFsYfLhhOD2uBoEKb6W/ClAtBuqWqdabTH1lnAZBOlprOIm+Lb8PWZh5q9BYSl5MCed
	gJD51kK9NdIhtHhcLpVgNIG7+ZRI1ZkXMI5nV7dyhiV+Tgc+7qKXAhN6w35Nfsa96+5tCp7zi25
	wjtFjVI7r7/wAT4koN7D72CoXPWXfBT1wIg4YJy98GP+kHgBWyrsGuwsWyAEfEBfz+ceshblh3z
	kdQAWwkuDvyDLgaeKMMWY7RmFwCUK90lmnf9i0BfzWDvToLnNuf/novgOO68fJMlvzahvkAUyxt
	WDZaj/espiRpGpnBs83/TCVQWcWfccpImPygt7N6UY/fUMdFLR8EAavfPwFRa0p9sQsD+azA3bg
	/nedgfFfjPCUdgvsG43/GJ8CTxg50qi3co2QkLY7wdyU1pDY9TefnXNYCbtYgnHwJqgulO3lJjV
	cwi4v1rBCwuOMDxCKmVhW/55aOIn0pDXIIyViU19tDewGiSWItREJeHNIjHyXqq/QY28LfoZcGG
	BaVGfoJb5YepzDWMwVnQjcHZuLPFoGSIrw8CFhPOvBo4i1/MUZi1Bp9C/bjiCOgfLzWOEDnLiAu
	ETHR+dmBDLmSYtvWi7TzcKICByqEPgeAzwi/GNkCNkTrp4sY=
X-Received: by 2002:a05:693c:2512:b0:369:fa7c:aee9 with SMTP id 5a478bee46e88-36a423f54a1mr18011806eec.19.1793693314004;
        Tue, 03 Nov 2026 00:08:34 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm41468466eec.12.2026.11.03.00.08.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:08:33 -0800 (PST)
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
Subject: [PATCH v13 02/12] ALSA: virtio: Recover PCM state after a failed start
Date: Tue,  3 Nov 2026 17:08:11 +0900
Message-ID: <20261103080821.16983-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103080821.16983-1-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
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

Capture trigger queues I/O messages before PCM_START. If the START
message cannot be allocated or sent, transfers may remain queued, and
ALSA does not invoke the action undo callback for the failed trigger.

Mark the stream stopped and disable transfers for every failed START
path. Arm runtime->stop_operating so sync_stop releases pending I/O and
prevents prepare, hw_params, or START retries until release succeeds.

The stopped flag is shared with ACK callbacks that can run without the
ALSA stream lock. Protect every stopped access with vss->lock. Read the
pending message count under the same lock in open and hw_params. In
sync_stop, decide whether RELEASE is needed and mark the stream stopped
in one locked transition; leave it stopped when release or draining fails.

Always cancel elapsed-period work in sync_stop, even when no RELEASE
is needed.

Record the RELEASE obligation after successful PREPARE and clear it as
soon as RELEASE succeeds. If the subsequent RX wait fails, retry that
wait without submitting RELEASE again.

Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
 sound/virtio/virtio_pcm.h     |    6 ++
 sound/virtio/virtio_pcm_ops.c |  106 ++++++++++++++++++++++++++++++++---------
 2 files changed, 88 insertions(+), 24 deletions(-)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -26,13 +26,13 @@
  * @hw: Kernel ALSA substream hardware descriptor.
  * @elapsed_period: Kernel work to handle the elapsed period state.
  * @lock: Spinlock that protects fields shared by interrupt handlers and
- *        substream operators.
+ *        substream operators, including @stopped.
  * @buffer_bytes: Current buffer size in bytes.
  * @hw_ptr: Substream hardware pointer value in bytes [0 ... buffer_bytes).
  * @xfer_enabled: Data transfer state (0 - off, 1 - on).
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
  * @stopped: True if the substream is stopped and must be released on the device
- *           side.
+ *           side; protected by @lock.
  * @suspended: True if the substream is suspended and must be reconfigured on
  *             the device side at resume.
  * @msgs: Allocated I/O messages.
@@ -56,6 +56,8 @@
 	bool xfer_enabled;
 	bool xfer_xrun;
 	bool stopped;
+	/* Successful PREPARE still needs RELEASE; protected by lock. */
+	bool release_required;
 	bool suspended;
 	struct virtio_pcm_msg **msgs;
 	unsigned int nmsgs;
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -96,6 +96,15 @@
 
 static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);
 
+static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss)
+{
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->xfer_enabled = false;
+		vss->stopped = true;
+	}
+	vss->substream->runtime->stop_operating = true;
+}
+
 /**
  * virtsnd_pcm_open() - Open the PCM substream.
  * @substream: Kernel ALSA substream.
@@ -115,7 +124,8 @@
 	snd_pcm_hw_constraint_integer(substream->runtime,
 				      SNDRV_PCM_HW_PARAM_PERIODS);
 
-	vss->stopped = !!virtsnd_pcm_msg_pending_num(vss);
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->stopped |= !!vss->msg_count;
 	vss->suspended = false;
 
 	/*
@@ -217,11 +227,23 @@
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_device *vdev = vss->snd->vdev;
+	unsigned int msg_count;
+	bool stopped;
 	int rc;
 
-	if (virtsnd_pcm_msg_pending_num(vss)) {
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		msg_count = vss->msg_count;
+		stopped = vss->stopped;
+	}
+	if (msg_count) {
 		dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
 			vss->sid);
+		return -EBADFD;
+	}
+	if (stopped) {
+		dev_err(&vdev->dev, "SID %u: stream release failed\n",
+			vss->sid);
+		substream->runtime->stop_operating = true;
 		return -EBADFD;
 	}
 
@@ -273,6 +295,17 @@
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_device *vdev = vss->snd->vdev;
 	struct virtio_snd_msg *msg;
+	bool stopped;
+	int rc;
+
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		stopped = vss->stopped;
+	if (stopped) {
+		dev_err(&vdev->dev, "SID %u: stream release failed\n",
+			vss->sid);
+		substream->runtime->stop_operating = true;
+		return -EBADFD;
+	}
 
 	if (!vss->suspended) {
 		if (virtsnd_pcm_msg_pending_num(vss)) {
@@ -311,7 +344,12 @@
 	if (!msg)
 		return -ENOMEM;
 
-	return virtsnd_ctl_msg_send_sync(vss->snd, msg);
+	rc = virtsnd_ctl_msg_send_sync(vss->snd, msg);
+	if (!rc) {
+		guard(spinlock_irqsave)(&vss->lock);
+		vss->release_required = true;
+	}
+	return rc;
 }
 
 /**
@@ -338,31 +376,40 @@
 
 		scoped_guard(spinlock_irqsave, &queue->lock) {
 			guard(spinlock)(&vss->lock);
+			if (vss->stopped) {
+				substream->runtime->stop_operating = true;
+				return -EBADFD;
+			}
 			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
 				rc = virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
-			if (rc)
+			if (rc) {
+				vss->stopped = true;
+				substream->runtime->stop_operating = true;
 				return rc;
+			}
 			vss->xfer_enabled = true;
 		}
 
 		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
 						GFP_KERNEL);
 		if (!msg) {
-			guard(spinlock_irqsave)(&vss->lock);
-			vss->xfer_enabled = false;
-
+			virtsnd_pcm_start_failed(vss);
 			return -ENOMEM;
 		}
 
-		return virtsnd_ctl_msg_send_sync(snd, msg);
+		rc = virtsnd_ctl_msg_send_sync(snd, msg);
+		if (rc)
+			virtsnd_pcm_start_failed(vss);
+
+		return rc;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		vss->suspended = true;
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_STOP:
-		vss->stopped = true;
-		fallthrough;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (command != SNDRV_PCM_TRIGGER_PAUSE_PUSH)
+				vss->stopped = true;
 			vss->xfer_enabled = false;
 		}
 
@@ -393,21 +440,34 @@
 	struct virtio_snd *snd = vss->snd;
 	struct virtio_snd_msg *msg;
 	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+	bool need_release;
 	int rc;
 
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->xfer_enabled = false;
+		need_release = vss->release_required;
+		if (need_release)
+			vss->stopped = true;
+	}
 	cancel_work_sync(&vss->elapsed_period);
 
-	if (!vss->stopped)
-		return 0;
-
-	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_RELEASE,
-					GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	rc = virtsnd_ctl_msg_send_sync(snd, msg);
-	if (rc)
-		return rc;
+	if (need_release) {
+		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_RELEASE,
+						GFP_KERNEL);
+		if (!msg) {
+			substream->runtime->stop_operating = true;
+			return -ENOMEM;
+		}
+
+		rc = virtsnd_ctl_msg_send_sync(snd, msg);
+		if (rc) {
+			substream->runtime->stop_operating = true;
+			return rc;
+		}
+
+		scoped_guard(spinlock_irqsave, &vss->lock)
+			vss->release_required = false;
+	}
 
 	/*
 	 * The spec states that upon receipt of the RELEASE command "the device
@@ -421,11 +481,13 @@
 	if (rc <= 0) {
 		dev_warn(&snd->vdev->dev, "SID %u: failed to flush I/O queue\n",
 			 vss->sid);
+		substream->runtime->stop_operating = true;
 
 		return !rc ? -ETIMEDOUT : rc;
 	}
 
-	vss->stopped = false;
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->stopped = false;
 
 	return 0;
 }
