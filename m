Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794182132;
	b=KyqYdOjbXVEAPF4LEmFowMZwy6Psw+RvlC0U1vWR3prsZbDcvFRqTkdpIKM44PIfYi0A
	 WDorZnaKYejnxiKQK9UW/X3GzDqfMohupae8P/1+JmBbsxG4zglcdecPQzR1/QrBzV+pm
	 QrGO6FzAB7sQnXK3O4mSAoNt2qXR1pO9S3+pQDhi+RRbH0vOAirafQcE5AG1qGBkNxUdN
	 ZYbIFAmcXf68MibJDWhkD02PpCdg0yFZXimoMaE/OqSmWrnDak9AoSRMPIzogNU8+S4bi
	 AZgT1t6lzttRbqVNHz+yyfB2416PASNgAmqhKS2y7uBr3i1asFL9uyFudtCnnOYj0kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=p2HQn0uK6b7S8WnZVO6RYFKBvJhyKWdKHL77ptFOkeg=;
	b=3M71siF4/y2TplEBZteZEvcqTsohYROajQW8aEk5U+/+ohukBQNwR/jy9EvRya7xlsGf
	 Ruzw3k4vErLy5n7J5eENbo9/Ett5wM1f7Y+k7jwosvmgP+wQmW3si7yt976+kWmxnKyij
	 xyRWYrcrEwPmJv0CYX4AKZg3BtW1ij4stwFdPkf0xoS2yymAe/GKjQeaxgg2DQIX7Mz5g
	 tw+KviRbR0IXAl4TE3mNSuC7eAnvZ6+W6gbb98TLyN+HVCU4sZsOkgeCWhJhp47BOumBK
	 OZpdfVRYJ02w1PLJSbZz+JhFM18LE9V8TjojLE+A2J8Wicp447ZbZ1FfciiG6n2KTBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cJAEmCzz;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B9606A320
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 23:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 648B9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cJAEmCzz
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9ae391a05so1493625ad.1
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 15:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794182132; x=1794786932; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p2HQn0uK6b7S8WnZVO6RYFKBvJhyKWdKHL77ptFOkeg=;
        b=cJAEmCzzk5YAvUN1Bd4+N14kgBbDIC6AfAEVEs0L2hcs1HZJCkRGl5ovJCtgNtldzJ
         IlAhT3KyxC1LQ9Z5wX1EuzZXXVMauO6LoZCneCQSFX5kKrso1OdirTDeFAWbbjxlyTDU
         CTWNQYv30NrFmViYbtFbF5A7hImXa4zS75R5O4zfCZFVoPQgXdmHnDa1dhb4BdZzmcZo
         bAfFeT5twVEQpjPfKXloyzhD/1lyse+xUKzJabN946q6zZIMbSZzpUAeGBL+HwOl4jZo
         uuZE9nKdTxkrmbldfhY/+KTKM4FxNmPgCL+aHctdX6/D6fz2y32+v56doJLkzpNO1drz
         riXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794182132; x=1794786932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p2HQn0uK6b7S8WnZVO6RYFKBvJhyKWdKHL77ptFOkeg=;
        b=FP4k+IiFyiCO5dtJ7i7o8AUbNF3koRaU+wethqhm/4kcXHFXhi6mjTNAyXWz7VLUVD
         Nov+kLVVcSTqZ021mDvaHg9yO8e8W7616NoJ/wKl3Rt/iLr1r2zQKY1+EP4PnBCd4BAB
         7sUniAA8yWMG1DlJ8Ok/v3g2GZfMdKlYoiT6tN/uc1qOAZG4szmahNI9cMhE3s/NrTK/
         +A9KGfNWZjatoea6eMWcsxSAuNq0znUODF+JKjE48IXnw9WN6Jmu5AIhk03z9K/txUaM
         c3RZbHmXmmgV38T1qoniQEGdlXkPYdKS7Pm6DDlNMXjQUtAuu2nbfMbeB7UzEiL6TOcQ
         +dVg==
X-Forwarded-Encrypted: i=1; AL+hErFG4LEoq7MsvkeyFmxJkc5DPxe45sfQ19Cf43h+FxvYY2+CD6g10uVRQNSQ1eN3U5R4XzUl7SwgrMKNQnCEbQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z97WgSCx6soM4VOn3V+wFK5FRSV01ftXiEk4GmphUcc/28+Av+6
	KDFX9P/wDspebkDu8Ol0QdtwvH4feYUwCpHyoRuA4mrydmCDnAzhybxyKiaU0g==
X-Gm-Gg: AYBFou1UA8uWqGymRPbVx5CTKzVpaLpxmfwiWMfgCoPepIEfyI+YvAwTzSXA/TQgG+6
	fI7iA9rTIdKTKJLHGJMCKxzlOcx6m5L2GIKUgS5S6RmpxPCpKf97fl16tmRUxo7qImSuh+ZOuKS
	8skSA0WYn0L7hArdOwynzFM1dw1EIICEVr9dywaEYo0HHUy2QjTIw8+sNe7I1MV6jlmInb75Sko
	ymsEQAwKDblSiehh6SnBiT+ptM/y0zGOA/uyEmGvpdi9+KxV2D5hCJYRojzDUX3h1dimS/Iqcy7
	XygJL05/QVRoOqKRBsoQz1a3sk9r6kZG0NUePwhux8qwt3N0/p3gGeFKBdw5UF/a7jKU5YS2MN6
	ViK4BFRvWLcEyb8PA4IehGDY2/FAEKj0fVtQyJ/724l3dL+Z3UPoPXbwJRVdNC9s8GBiTtvUOq1
	LHNWC6KkyL3i7v40wxACuHjg2gG6MYpYwYHcqNkGrlPxu4sV+61t73/qniZ24lcylxr3pSHYSGk
	6ZWjetlwCQW8rVnruDRF5urZ3qXquRCECgbdzESwU0okqAlZLxH4RYWC5DgDKFjafc30Mlre6G1
	FIddgb+uOsCcEIoOkFem92s6XWPdpUNijjPRisYyOinGMATJk/M5r63agK1seDoeRIbeY44nRXf
	zE+P3cDY0+0gtin8A4ytBlzcgNsJSYnWdXKrHh0pQnwogWIA=
X-Received: by 2002:a17:902:fd85:b0:2e5:debe:cb50 with SMTP id d9443c01a7336-2ed67a21a47mr38941155ad.4.1794182131739;
        Sun, 08 Nov 2026 15:55:31 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81722edesm6095215ad.55.2026.11.08.15.55.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 15:55:30 -0800 (PST)
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
Subject: [PATCH v21 05/12] ALSA: virtio: Recover PCM state after a failed start
Date: Mon,  9 Nov 2026 08:54:50 +0900
Message-ID: <20261108235457.12688-6-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108235457.12688-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
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
in one locked transition; leave it stopped when release or draining
fails.

Always cancel elapsed-period work in sync_stop, even when no RELEASE is
needed.

Record the RELEASE obligation after successful PREPARE and clear it as
soon as RELEASE succeeds. If the subsequent RX wait fails, retry that
wait without submitting RELEASE again.

Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h     |    6 ++
 sound/virtio/virtio_pcm_ops.c |  107 +++++++++++++++++++++++++++++++----------
 2 files changed, 85 insertions(+), 28 deletions(-)

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
  * @prepared: True after device PREPARE and the core pointer reset succeed;
  *            protected by @lock.
  * @preparing: ACK gate through teardown and prepare's core reset;
@@ -62,6 +62,8 @@
 	bool stopped;
 	bool prepared;
 	bool preparing;
+	/* Successful PREPARE still needs RELEASE; protected by lock. */
+	bool release_required;
 	bool suspended;
 	struct virtio_pcm_msg **msgs;
 	unsigned int nmsgs;
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -116,6 +116,15 @@
 	}
 }
 
+static void virtsnd_pcm_start_failed(struct virtio_pcm_substream *vss)
+{
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->xfer_enabled = false;
+		vss->stopped = true;
+	}
+	vss->substream->runtime->stop_operating = true;
+}
+
 /* Keep completed RX data valid while RELEASE drains the device queue. */
 static void virtsnd_pcm_block_ack(struct snd_pcm_substream *substream)
 {
@@ -148,7 +157,7 @@
 				      SNDRV_PCM_HW_PARAM_PERIODS);
 
 	scoped_guard(spinlock_irqsave, &vss->lock)
-		vss->stopped = !!vss->msg_count;
+		vss->stopped |= !!vss->msg_count;
 	vss->suspended = false;
 
 	/*
@@ -250,13 +259,26 @@
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_device *vdev = vss->snd->vdev;
+	unsigned int msg_count;
+	bool stopped;
 	int rc;
 
 	virtsnd_pcm_close_ack(substream, false);
 
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
+		scoped_guard(pcm_stream_lock_irqsave, substream)
+			substream->runtime->stop_operating = true;
 		return -EBADFD;
 	}
 
@@ -310,7 +332,18 @@
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_device *vdev = vss->snd->vdev;
 	struct virtio_snd_msg *msg;
+	bool stopped;
 	int rc;
+
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		stopped = vss->stopped;
+	if (stopped) {
+		dev_err(&vdev->dev, "SID %u: stream release failed\n",
+			vss->sid);
+		scoped_guard(pcm_stream_lock_irqsave, substream)
+			substream->runtime->stop_operating = true;
+		return -EBADFD;
+	}
 
 	if (!vss->suspended) {
 		if (virtsnd_pcm_msg_pending_num(vss)) {
@@ -353,6 +386,7 @@
 
 	scoped_guard(spinlock_irqsave, &vss->lock) {
 		vss->xfer_xrun = false;
+		vss->release_required = true;
 	}
 	return 0;
 }
@@ -395,33 +429,40 @@
 			guard(spinlock)(&vss->lock);
 			if (vss->preparing || !vss->prepared)
 				return -EBADFD;
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
-		scoped_guard(spinlock_irqsave, &vss->lock)
-			vss->suspended = true;
+		vss->suspended = true;
 		fallthrough;
 	case SNDRV_PCM_TRIGGER_STOP:
-		scoped_guard(spinlock_irqsave, &vss->lock)
-			vss->stopped = true;
-		fallthrough;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		scoped_guard(spinlock_irqsave, &vss->lock) {
+			if (command != SNDRV_PCM_TRIGGER_PAUSE_PUSH)
+				vss->stopped = true;
 			vss->xfer_enabled = false;
 		}
 
@@ -452,26 +493,38 @@
 	struct virtio_snd *snd = vss->snd;
 	struct virtio_snd_msg *msg;
 	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
-	bool stopped;
+	bool need_release;
 	int rc;
 
 	virtsnd_pcm_block_ack(substream);
 
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->xfer_enabled = false;
+		need_release = vss->release_required;
+		if (need_release)
+			vss->stopped = true;
+	}
 	cancel_work_sync(&vss->elapsed_period);
 
-	scoped_guard(spinlock_irqsave, &vss->lock)
-		stopped = vss->stopped;
-	if (!stopped)
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
+			scoped_guard(pcm_stream_lock_irqsave, substream)
+				substream->runtime->stop_operating = true;
+			return -ENOMEM;
+		}
+
+		rc = virtsnd_ctl_msg_send_sync(snd, msg);
+		if (rc) {
+			scoped_guard(pcm_stream_lock_irqsave, substream)
+				substream->runtime->stop_operating = true;
+			return rc;
+		}
+
+		scoped_guard(spinlock_irqsave, &vss->lock)
+			vss->release_required = false;
+	}
 
 	/*
 	 * The spec states that upon receipt of the RELEASE command "the device
@@ -485,6 +538,8 @@
 	if (rc <= 0) {
 		dev_warn(&snd->vdev->dev, "SID %u: failed to flush I/O queue\n",
 			 vss->sid);
+		scoped_guard(pcm_stream_lock_irqsave, substream)
+			substream->runtime->stop_operating = true;
 
 		return !rc ? -ETIMEDOUT : rc;
 	}
