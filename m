Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981941;
	b=TFr64z0Hcrp0BcsrCGG+g++jBvf3i+H63vjty/JysM05O3D3BePFUuEdnOU2a0/FVil1
	 UrfXaieUOL1kj9mVP8KCXHUzu+tCK3v6u5VBYuk6tC0zDK76Ddhpe40SdiJMX9zg323RI
	 MZ4NW0MnmRD0/iCeQLyi7/DTzopzPsBFuu3MmS+lTQ8O1cmP2YAQKAxkZB1Ub5sbGZegI
	 SV9tRk7d0q5rIy+voMrii0qcZdbUVaZp2yxY+ewSG88s+rmSIrduiKzlKZhlyKlakT8XN
	 IbvxsQw974UNNPfkNp8oYKKywxnlO14WEQnRwDANYDYwAJOd6Xk5EtQJlkVAJAEQmWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=p2HQn0uK6b7S8WnZVO6RYFKBvJhyKWdKHL77ptFOkeg=;
	b=2ra+Go0ZlRdtPw0s/pYOfREKj9gstC2dhoQOCT7T3mQF7gp0I5v3+HKr9NrFmKBXEbbm
	 j9duTgGdUOsQhiKF1CscZTaR1TOLgD3IavXQl+/ca/u7I/45G0c6LKwuJHhlxS1CYKAmz
	 pE/1cUkHaNrY/+xu3ZGnEw3xoCxqp0xbBETGdG/HwTReUDT3YQTa4U7dpidFaKgYqIw2z
	 JloqGWFyL8I6Zy8fGgRUsJ2Cn32dqMvOHH1v5q+P9jCpzBReqTihDy8BTC3+jAKVz9h45
	 mHfM1Z99Bjd7i+40uGq9zE4qOK9dzcgQFR/lCXGp4/qnuwMIEku2H1FOc6z0nv2Q7ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wO3ZOVl/";
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2721E606EEB7
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 16:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2721E606EEB7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wO3ZOVl/
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-170135e43c7so1485886c88.0
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 08:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981940; x=1794586740; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p2HQn0uK6b7S8WnZVO6RYFKBvJhyKWdKHL77ptFOkeg=;
        b=wO3ZOVl/EO5bwqqzcJF4cNKfDu/Iqn8CIRSIsin3IKb0pDchiyRsa2NqGFGidxLcHu
         JjN22lWmGuyR/rx3xA/xZ6EhAkgEg4Fzs6LvfSFlx1eKETekd51DZaaFXumK/J4s0CLQ
         v/vEIus5xih9IKA/LoKs3wcVwew/sHSdbGYhziAqnN8UB9iHVi3e3jbNBd0gyJIj3raU
         vRAxSsu+Rz3K43il925p0QmbVoDvkNSUf/khrB57pgPT3HFqlHAvFEUeTrvbtOmMJeA2
         za3E+k808zJWcDgdUu77FG6m96YIWPBre+eVLMvrK49j5wcqr+mIH2G9GlFj1KwnuQph
         P6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981940; x=1794586740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p2HQn0uK6b7S8WnZVO6RYFKBvJhyKWdKHL77ptFOkeg=;
        b=cWGIMj7QqTqcSdl8xByzeQvffDFUrc0V/sAugm1m8nlXIqOjZKdAgfskwZW3xi0aNO
         DIVWR6evOcEJ6dPhBsY+qE6Hj3GG++x5I3RdWz4e4K6+ohFVp0HF8j7UEzr+FJ614uX+
         ANTbWrf0HJJBXRyhlEytne3vymLims66yWbIgKWteOcYvFfPzK50u+yZfX5FQ/LI3Tn+
         +ZON23JXWHAKJ9ZJ4G991kFrKABZNYq2CUfkZXy1pvFopofp+y+sfC/vwr3qzQ3eO+nV
         QsNoneC9Oug8PDTEaizYK4Hs18EpcsyJdsc/qDd1dPS8yXJ/dp9q9bobYGz2xTrh1C71
         jxPg==
X-Forwarded-Encrypted: i=1; AKwUvBzxC/nS8cYFjkGpy5FRsIqZxGf4hhWJJXsvTS/UAQHo3Fxue+Njj6s/NVtF40V0vt8kwg7fyEooYb10IWdZyg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8XNGC2JhtrF956zd7aO3jxoZXijpGVuXQaK15D9NJcIViH5FNj
	vpQWtavvu8TvG4PpMKGhLPi3SK5HjvtFenVVL5WcYVxaHJUVJ4xXCC8F
X-Gm-Gg: AYBFou2970OHogOVKx0CFJdK9oouKPHTfHYemhmJYyuRfmOCbtsKbfgWGpx4IlCEaDb
	Sl9iF2x0S/4l/zTLKW83plN0qjsHVUwHXs7Z1XkTYWeuWmOnmzf5aoTiYKu8SKDG6If17oh1Ay5
	7tdsanCYLWktRrayTapZgsppvU5SlcWpdTS6cHUr1sXZlhp92IXkmwVl+SGJeRCxQ61MEuSCx9E
	s3W1gDPxRetcES6oUzH3umz4B6T4/Mjyfp/rr9woZtydadYwec7nqOdceFtuR22ll64cg0MvFp7
	4Bfp7J5vEbrB5N0Hq6jpiy4hi+r39LXDO68kTMetXTvrPAf5B0VQuk69291TaWUQcVresNP3WKw
	EeGuUfaqOMzK0fqA8Fku1KM/cE40zHOkmC0awrVitx/R1Tq6bx0PXE9fYAiWIRaQfKcEgZFQlIP
	HTwdBNl0CCjSM6GEtmAYukUa6to3OhxbRLWMm9Z/DhHzIFWzA1Hc0M/aLtBLYq2JrMf9uGWoTiv
	3yrJxS3ariRaAbjikgrD1So/yQqFlk77Ui8dUyxbseOZxKq+cFY7oR88iB49LksiatxfTpiep3O
	wXHi7Ukrb9NEXU50kILWzVYoIzVNZHDiBcT7t0kUiNI1CvcybQNVL75ZYeFj2QcOWnIhQk6FUQO
	+Icih32AgL8cmvCZzwe5XGYIQdPFaZ64G9b1KWkhSXdUXscDJyla0kkf4/mCjO7y7gQiw
X-Received: by 2002:a05:701b:2512:b0:150:c9c5:1ca1 with SMTP id a92af1059eb24-1b25d318407mr3621714c88.18.1793981940158;
        Fri, 06 Nov 2026 08:19:00 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4840f3sm13139526c88.5.2026.11.06.08.18.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 08:18:59 -0800 (PST)
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
Subject: [PATCH v19 05/12] ALSA: virtio: Recover PCM state after a failed start
Date: Sat,  7 Nov 2026 01:18:31 +0900
Message-ID: <20261106161838.94308-6-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106161838.94308-1-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
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
