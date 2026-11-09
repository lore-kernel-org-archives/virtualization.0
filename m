Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201404;
	b=XXBhjHW1bvcnTS0sV0B871m6XoJh15Nzh91mjOCDVQkzguZKgEVaPfpB6BZXqsnj2feR
	 daRWyP61fJ0C7O2VO7EQw8elsHiG94KRw68pTdTPWZ+9xjWuYksv5nvn4Ka9cp4KiSQek
	 Oy+4t57i9r4VyTb0IGM6Oa9GdeuSP0HGH0hMvR5B+CeQtQOhZlNLlHsr9G8+WKF+MA0Rn
	 883kQWS/vx/5TnAMpj36LZpDxAwBw5kkkc0fwjHoiKLqblbVy8y2kobJdGIxoyXf+aVKC
	 Wd4gtSSz70H8rpRgsryqm3mSSIhIgdyzKpvFVVPJljMcjmmDKZl7Yqf+mxp+UB6rHQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lkK9x2YMJpVRIYZ2L59F9hCFi+ySsC5FbKeAqK3oOu0=;
	b=rXq7fXOinLm0UrJEeVd8X+DI3SdmmhM1qd5cagpunDiLu6rGl7w6uvcTx9+n2f6Mn3Ty
	 FncXfU+rAJbsd+qu92EJAOpLXP5YkTvhbd3RLzDRdVTcHe9AD0A2bhYT7NDBlQ41DiKdp
	 WlEIGpqPvYfhtcMw/NqKtrAJ1auoFAx6yWZ2ecrMSsZc1FNC1TSETEhLzZy3PMJ20mlwZ
	 osh4sXvaHhcGGvEgVXD2QNC/Hy/CKCNIq/ljf8y47Hk5WqgG4pmw9LFbHwgOAuJCR8pat
	 Ci3/gIhD/ko1pcR8DcqaU5ADhRACkb5x3KLDVPQaOOxBt/O3WJyyHJ1CUP12ZUIuSxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YumMzgYc;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DD0606A334
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0DD0606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YumMzgYc
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-170135e43c7so665133c88.0
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794201403; x=1794806203; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lkK9x2YMJpVRIYZ2L59F9hCFi+ySsC5FbKeAqK3oOu0=;
        b=YumMzgYc1XrocBWi9k9Ogz7DJuZLY4XTr7vd9qY00xFXD2QY7Qtc8CIqmujNL/elgW
         bNl8t8X5ov7e4jF1B4P4uInCGHL7C7jFucYZwNPGUkWQXr4gHDnjz52r/8fimskJAkdl
         NcQMbEzotp8/9bjgMooynGjKUzscUYajgepFs+8f/x4M9LvNpJMRTIaqFqp8/tGe6hC8
         M/+clKG/6E8nouj0TxsZ6Oj/dsjMab+CJ/1hUJLQmeVhdInzvBdKv+R+1DKVlp7Ghqa5
         XhWqaoTAq8x7ny++UBb6FG7Hsnxmp57JkaRmQkTXSPCvPpEA9H3AS8UjzIQqwXePK6z3
         SSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794201403; x=1794806203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lkK9x2YMJpVRIYZ2L59F9hCFi+ySsC5FbKeAqK3oOu0=;
        b=WUt1joIXYrfdCvAK70A+LtXQXtq1vo1brFxa7RZyPm4u+4lxd0XfekezWKSvo+JF/3
         y07hnGFf5bbcBQhCmROJqU9g26mbp9e68szpSdaukmTgrPuHBA9yLwknSsZtZyAyfBDy
         fhAryxwKBFxawc5qyo9KL6Y3vlYVggTsTFTGDmSGV3ihzF3cLGxTeOQna/uwsAB6mK+v
         F3NMdLtoL2QEmm+5Ak/zTs0iiuRjl5Eyh/TehPPfqekEgy/1UurpgEmgQyqswR0ptV0z
         sCY1WI/wRZu9k1iKOt7MlajW3Etl2Li0RbvR2Krg3QnpoZI7K3pvDbsrH+nltyMtXB3E
         QhRg==
X-Forwarded-Encrypted: i=1; AL+hErEG8rtTdeIAD1mOJ/6IqTaXQja4xDs8b/QVlC7cV7wpF54Uha2D7b5cJTSE0+IwmOXXAz/huiD2IAvVNZscMg==@lists.linux.dev
X-Gm-Message-State: APuU4Z82xqjIwMyFjEXhy2v/83cmTpJO876OHvdra7p3fTgoZmYhNeHA
	/AU03Z9xsIFQoBp5P/74rhv4FR3MuGJ/ME7tG6qyIk1cTssV3RFkzeuy
X-Gm-Gg: AYBFou2eFTm+LOnSceWPEE3AJmGZ0rxtbTIX3rH5tA0tSzYCrBb5vWjmuhpr1rpf+wP
	ZyH1T5WwQOfC05ZxdUcoWssS6mlx3NCIBzUCKgcs26QptZD9snF8EzNUmnyFwtjYZAZydlWuSVc
	DNXpkTAELfsM8nKTsp/vAzLdFxbx8FuRWdbsl8dAypeQ4gPS1EXt/5ZXLDZcnG1z8VUaIHBCww4
	Zv3b0CmNiYBRfI3No4w+uh6ffYPq4y1/4PJpf5sHc+LjhvIlx6kHOWdoBiCWOxCOWCS1+JQGZHG
	fNiwuxufc7zop5UBD0ORhv13zw8O5/O1ujbC9zMbDCuZVGDoFzpIko+bDLxYtSl3pASEvwEY+V8
	r+cJjR81vNBR7ZzjtQZrJssqkTa831F/qcqxR7/OC2B8ynKtNP8snm+KPdMcvb40gR2weGbmA5w
	DUc+sh8Y/mYG3RaMatNd9dyteauH1425L1g9C728aBBN2GwiN3bWtPwvkaOjbVL9BuWRWZdiLNt
	eAiAgQ89akPkzwp8gflXD3/sDddJMTXvDmN16en3OkKoLYQ9iTEJvGuzfd6v1+AjXo5dl3CghP0
	cA0Sngzxokz4wDp+1udYAiPIvUepii7t3OPWd9l4dQLe0xaUNnsg59KdA5OhV9rvfKN4wdE4M3d
	d++Xkt3hfbzw1DeNp4n1M7c+M2SygaARPJEmbcrFR57h2rXs=
X-Received: by 2002:a05:701b:2902:b0:1b2:539b:496c with SMTP id a92af1059eb24-1b39ff1388fmr4549289c88.35.1794201402935;
        Sun, 08 Nov 2026 21:16:42 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314826asm11395635c88.3.2026.11.08.21.16.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 21:16:42 -0800 (PST)
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
Subject: [PATCH v22 06/13] ALSA: virtio: Recover PCM state after a failed start
Date: Mon,  9 Nov 2026 14:16:11 +0900
Message-ID: <20261109051618.22506-7-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109051618.22506-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
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
Assisted-by: LLM
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
@@ -402,33 +436,40 @@
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
 
@@ -459,26 +500,38 @@
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
@@ -492,6 +545,8 @@
 	if (rc <= 0) {
 		dev_warn(&snd->vdev->dev, "SID %u: failed to flush I/O queue\n",
 			 vss->sid);
+		scoped_guard(pcm_stream_lock_irqsave, substream)
+			substream->runtime->stop_operating = true;
 
 		return !rc ? -ETIMEDOUT : rc;
 	}
