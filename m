Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144633;
	b=Nby3fq1VXXj9vdMD0fK+6ADPPrjKotsd74Sxt29mlgbGBI6ZAt+uzjUTcJ4DDDt/WI1+
	 WkstzDPfnmaOqIJOiHV00Uvq6ZQ9UimF7WyMvarSA7pc9BPBNulciFfhxh0fxu7vn7gHd
	 ebFGv121te5YFFaaZspS3611qDJXJX6CLAYe9R/O2rzhZ0o98L+euH16oXuz3VbwHn/5n
	 ff2jiwlhl7SbXxjK2kbn1N88tW1Nhwh7bokpCHvSan9HzWbJ+YkvRjrk7vNoSk0H0WmQo
	 /F8uGYfGy1JCCIyIoT2UA1+Io3MnCTHVEaJP4OV7Dblp8ppHssxPuxC9bP2npOl58FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cwJJNaSJlKm/koK5kjoFQnQ8cfxssNfTJLq5LnG8GkA=;
	b=uLG7JB8WyNg8FDoYx6Q6uc1EEAvl4cq78w7qdOqgqKFEFc6M+B6bOIGSZUckgK1rWGtT
	 6ERPzjPF/mCTblc63ZeYIPUiutXriCPsWDrdmIAEF8533XUfYRdOYfL6Gg1cUCRnGkEEi
	 3OKON/nX7Mq2GLOpGpDO74tDFBSoiIfxhFGEqEXhgcCjhSZMPuVyFRlZk9Pwlq15lO3m8
	 FTLL53vyAlx5v4pCWYcWM/wSLXjKabTP9sSLpeg6L2SUCb9B8DSkhbcwdm6Z74/JOh0kb
	 6KIeJiSy2YJ62kbf3BQGxKSJ7TA6jqEEfkpFCAQ6bh6W82/7DK0QDrlf5josZErrGDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SVudKgSy;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2F5606A31E
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 23:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E2F5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SVudKgSy
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so251779b3a.0
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 16:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793144632; x=1793749432; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cwJJNaSJlKm/koK5kjoFQnQ8cfxssNfTJLq5LnG8GkA=;
        b=SVudKgSyjXSwBT+qplxs670ibkasazYL4UgaiPhPhJU9FFq5rjmjDVyL2rJ8ghxRPe
         l1a2oVIXK6tyISK9O3lOH8Gz/GuzPiT1d/oS6IHXaMITDesc42ub+XiAR1L+pP0xja5/
         0niAth/6eJHNjMjy/hR+3NNsNUk3FDaGZNtjkbByu9Ibg4n3VCkTByxVHLB29KuYCPhV
         liXfxqlI8arI5x+M0ez69SbnPoMBEo87KAvsl5NxGO8VrywO1mJNR9T9uW1XBZZWIfss
         wSpjLlqLH6yUV+oUw8z3DrvKnmzG/5Xje1UXgJqx2X0xu+LZocw8hJMWHSiYQUZFlroQ
         mmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793144632; x=1793749432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cwJJNaSJlKm/koK5kjoFQnQ8cfxssNfTJLq5LnG8GkA=;
        b=KASmQTM5t724gdybk7C1bYI+anXxwsnKfVu4RLAjlwQf1He7+hjFalweasf3WaMpfl
         4+MeNLiy2gt/Zmwdq3cdpcBwFGRUs5i6m9Mj2T68pfbisjH153v5MOymHnRPQGMfl0vH
         edQMULwUNqJHvE3OrN4JpWHvkpPPB1EfrCNb00QPTES5LTHJRwQbKq5V9gegScUUMru0
         VR7BvbmIVS2rR97JHSRF8EcrRTAfUnCUMyEM/Rq+6RNsw07andCYk+uKqDNZqEJ+9qLB
         Ny7tsFAVSgu9YQAVEnQa/ouFVFNeK+4f5spUXFi610DjDKkpxHBk/DTtWsLmWYlKcV+S
         WZog==
X-Forwarded-Encrypted: i=1; AKwUvBxS3pMCKxGhOmCJmR1lZOVahFuqZUgMf2TmC95pQVmNkFuml1B6JcjZ9P6bxMuf2kjJBJ5J7oW/wkz6kIsuLA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJHZVdBXfZ/k0nweaHXglXJd8hy5WvEo26C3i6J4JIupq7WYRkY
	2aNlbkj/v8MdypsF6iqIsPqobhs14lz4DxVbViQQ/sjrlyvfm36GfQad
X-Gm-Gg: AYBFou0zzzWr2EdbY4vcZwPtoGrRo5htquizOczRWbfJkOvamKynukbIeiIwI0N5g9U
	D6bn9r3CKkj+vIuTiSBW9qq/lDcA/mfVleb9+nxwDEwoTM09Ow+03s5aaZJJRw+IzdI314/6lvQ
	OKY7YAYos4RIq6WZ9HU9EUcgHO2yJTScQWt5RZQ/MiHlvtwkyiKC+tjzskPgeyhZJzXWsPvFG96
	Cami4XQV+LuJ9cLYJU0NGx7R3zZfNSJTXvsRWwknyJDQyREjKl/lQuqwTbUYbjKON49mkHn/u6r
	Xdt+0LDkWImgysM9cHYVLQet9evzDHFZCxzGWsHjOsX29zfL4fw/DZC6OWYKJwN5rVngLTcs9cx
	3FqXY1kASUPON9P/4cr/bQmICdjQh39koMCWHT7cNxAREMOwOKPqkq1+/ePf+ZLzK+6NBejplvH
	RxAFP//q9l7TPSHU5VoAsZOWZVj6yXIOfqpI1m2cpfXYhX2wWmsF3d5ylN9K+OAHgmG9XuyHME/
	t+bmvnEN+GwLqkvwjtsSUig8B1eBi3ry2mA4JLZD0eAL1NfFcts/ytZB9SPpTqlenceH4yZd6jo
	/wMZg9oJzbcPFbZmzSBf8lbSza4PMDbbDj+Cv4S9nMz8MHgSPmvcmeBielrio4Fn5C4/GtRcPg=
	=
X-Received: by 2002:a05:6a21:4cc3:b0:3e2:8f64:e500 with SMTP id adf61e73a8af0-3e90241ef3cmr553702637.62.1793144631817;
        Tue, 27 Oct 2026 16:43:51 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662b9f5sm542507b3a.21.2026.10.27.16.43.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 16:43:50 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v5 02/11] ALSA: virtio: Recover PCM state after a failed start
Date: Wed, 28 Oct 2026 08:43:25 +0900
Message-ID: <20261027234334.32551-3-mynameisjune111@gmail.com>
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

Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
Changes in v3:
- Protect all stopped accesses with vss->lock. Keep the RELEASE
  decision and stopped transition in the same critical section.

 sound/virtio/virtio_pcm.h     |  4 +-
 sound/virtio/virtio_pcm_ops.c | 81 +++++++++++++++++++++++++++++------
 2 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 8837dfc12828..8048b14e6c80 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -26,13 +26,13 @@ struct virtio_pcm_msg;
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
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index a40ea394bf17..970499fe419b 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -96,6 +96,15 @@ static const struct virtsnd_a2v_rate g_a2v_rate_map[] = {
 
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
@@ -115,7 +124,8 @@ static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_integer(substream->runtime,
 				      SNDRV_PCM_HW_PARAM_PERIODS);
 
-	vss->stopped = !!virtsnd_pcm_msg_pending_num(vss);
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->stopped |= !!vss->msg_count;
 	vss->suspended = false;
 
 	/*
@@ -217,13 +227,25 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
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
 		return -EBADFD;
 	}
+	if (stopped) {
+		dev_err(&vdev->dev, "SID %u: stream release failed\n",
+			vss->sid);
+		substream->runtime->stop_operating = true;
+		return -EBADFD;
+	}
 
 	rc = virtsnd_pcm_dev_set_params(vss, params_buffer_bytes(hw_params),
 					params_period_bytes(hw_params),
@@ -273,6 +295,16 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_device *vdev = vss->snd->vdev;
 	struct virtio_snd_msg *msg;
+	bool stopped;
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
@@ -338,31 +370,40 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 
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
 
@@ -393,21 +434,31 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
 	struct virtio_snd *snd = vss->snd;
 	struct virtio_snd_msg *msg;
 	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+	bool need_release;
 	int rc;
 
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->xfer_enabled = false;
+		need_release = vss->stopped || vss->msg_count;
+		if (need_release)
+			vss->stopped = true;
+	}
 	cancel_work_sync(&vss->elapsed_period);
-
-	if (!vss->stopped)
+	if (!need_release)
 		return 0;
 
 	msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_RELEASE,
 					GFP_KERNEL);
-	if (!msg)
+	if (!msg) {
+		substream->runtime->stop_operating = true;
 		return -ENOMEM;
+	}
 
 	rc = virtsnd_ctl_msg_send_sync(snd, msg);
-	if (rc)
+	if (rc) {
+		substream->runtime->stop_operating = true;
 		return rc;
+	}
 
 	/*
 	 * The spec states that upon receipt of the RELEASE command "the device
@@ -421,11 +472,13 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
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
-- 
2.54.0 (Apple Git-157)

