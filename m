Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180507;
	b=DJCwoPE2ABl/De/8Eby2J30KFq9wTXvjvgU3BhG7mCWjkdYxvpLrvVocycOuYr4xsm1Y
	 IwytpxdglTzWX7iHqRTRVQBR9NKzojePtssh3F+jBHalxjMlxlBVJaipPLeUw7fSE72LR
	 Z9YQmfrW8gDEn6trn3//4Oq+TaaflZc0OBT0ltfuU+e3Z/CKcgWV4kHKrlC0Pok8/0HIF
	 wC4JIyIVFPCGhX/S3VjKIfA5wATf8NoFI+AmCs/3hLoV+V2yLSqhLiiEXrY0vofIOqcDp
	 U480aENX90AUK/355YRqT1OE5MyG2rfmbt9OpaCSwQQGIRKMTD3ONOtLPzeeW4rId5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cwJJNaSJlKm/koK5kjoFQnQ8cfxssNfTJLq5LnG8GkA=;
	b=SYCaS1JyGoAJBRMlb3wI3/XBfjSFn2iBYUhfRJCxE6cMyc94BRTcSXI/jCmU0SdUDkg8
	 00ew6Oc/Ybq1P9I9fLBTGQa60xl5RqqkszX7KUX+9PSh9WR3UfnBJxSAa3ePBDVZI8zqz
	 0IqSAYVDUDOUmxR2Y1GxweMe/1h8iC10Kvj/MYNSGAThCRkWVG4PFSLYBTFkTTYHCj26i
	 GfHe1TAbjr1Oern8TqkhhXfz71rm/1cXV+tacqExEp3Lv0bijb7thOp3tTskV2QmwKO8i
	 PzKDUYfWh/8cezVnvn8k+bQRrxp0f5YjrlyaSPQL8CdVpJPvGbSPy5AOkfFGULZz3Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TYOeXLrk;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636AC606A327
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 636AC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TYOeXLrk
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab98332238so456733a91.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180507; x=1793785307; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cwJJNaSJlKm/koK5kjoFQnQ8cfxssNfTJLq5LnG8GkA=;
        b=TYOeXLrklm+lifpZVHwrTOuWLXI2EcT4jUankasGTgxl2nj/C1DmULAKN3Ovd6aB9O
         513KPQWE07Yg3kOPeGh4e6xAARA6MCAcv67jn1+YMu7JNM/wZ+OBXSFq19WH9jGujlrd
         ifdelUhdpf7oSJCc4V8s+FmCaAmHhy6/UgO7xfAw/VOi4wnqvixKC83EntgIr4E55XC3
         S9Do6ljCRzwNmUMthdv+PzH3Rr4/u9XsiUR8WQAWF81srCcQXQVmTvRn3wDpDx1nCM9k
         qS/F7EJX1y7Oa4E4FCnN+SMnr3rbxVAmWwp4grfNub/EMh6dPVQxyKNo2a4p+gKzqigg
         4sQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180507; x=1793785307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cwJJNaSJlKm/koK5kjoFQnQ8cfxssNfTJLq5LnG8GkA=;
        b=uEPEgWNWoMSwpYYRovGc+bSnJSrnaewd+1rvhusuDywYuACBcpFx95wj+WxoHtkj6+
         NvUCQgV1tRac6BHvla8f3WFYsS5F5B/JTg0aPrLH/RXlHNmRUBqcbcqZgwwhs5LDBFeC
         fh7ys8vCZmgJMlZ1Nv7UZIwLI0HDcRwgo9cem8oEDExKJjyA7u6jEkrze3yTBAydye2Z
         y0BEQ7QPeUTRvaM5PRO9NxgnhQCFlbiuPhlpLfdoyr2yn5zUGtAXSHPNl8MCdluzfq9w
         aqUpxVot4EukNYi/iDP55u2pXeJQ8KSRi75h+Z2AytUwGWpsC0hZs2hAdbOHGSqR+ps7
         2O8A==
X-Forwarded-Encrypted: i=1; AKwUvBwRr55Kn0uCfNwen+2mQkl0kgrJhIkN511ovh5eMpSatvA6t98sSDXwNqX1Q2aGP5pr2G9a8Q0Ye0/HNsbbcg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIIFIqax/MKXRGXGqmUmaICOAEbQ3XvtgJyMDHPKlf9vHPeT4wD
	ZbdAReYQKIHglUZLbVPFquAx6lcHE/Lt9NnA2w10rZzQgNqu0kRyb+aQ
X-Gm-Gg: AYBFou15ZkXpHbSgvJRPdGeLb3wVevsH7RA7b1vc8k/mbrxSWUh+0H77auyC0dppYL8
	VMT7iYFtHP7V7y9PWQOEhSP85a+nzxh2nGsvFyXcxzapOzrvhifW/yS2PgM633KtI4dghCCbZl4
	WdYUM7M0+09LU+vUNENaS6LcSIOKqUIZXbOgm3C9nwQD13B9sFMvdE1A35PmniMatbov7uR14Qy
	nA56GS8d01gCNct/sqguPzVHGXHLfZCAaCmG2hUm/3dd/YykUjsfmfWclGR6AveKh9On1GKHXvo
	arVmAgWXxI05mvfRFfrsJz2ewmfoR5PJBmdJPx3Nkk1DuNG5QnQ1tZlLdqCBDMFiVLsHnk/FIHA
	yL2DT8mtPFcvaZuT5Gh1GoGyeKpP8vzN5lMqxkCk15P1w7wAp4BdGrwnmkCcUWVKqh+HJN+BOJJ
	zshLlcecKYwEYPHLU0VF7jw8gq4KxvjcGtPrEshiUXb1QhN/fDc4R3vb2YeSXtR8hrFrjnJNmLA
	NHoUfxc2WIo796y3w/Iz9uWGDdtHLg/TWRJXuvbx4kMKKU93sp/tvEvlzspvdXPXUCsdWhlNXR+
	zArdVhOvN1eFdXbAdhVNnEaBydEit3zQt6zLvV+cwFHBQVnEfWZ6+Bb9u9OJ6KszILQRRia7frz
	iKBxqSLWEQAd60B0Lht+dIFOLeC++oICG+8PTCZT6quY2NGg=
X-Received: by 2002:a17:90b:264d:b0:3aa:f4af:1e0f with SMTP id 98e67ed59e1d1-3ae57e07351mr1289738a91.8.1793180506752;
        Wed, 28 Oct 2026 02:41:46 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a93b3f5sm2242377a91.5.2026.10.28.02.41.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 02:41:46 -0700 (PDT)
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
Subject: [PATCH v7 02/16] ALSA: virtio: Recover PCM state after a failed start
Date: Wed, 28 Oct 2026 18:41:18 +0900
Message-ID: <20261028094132.20364-3-mynameisjune111@gmail.com>
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

