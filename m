Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923628;
	b=v3n7kwMkjd4Sm6Tq6ogdMTONTUkuHt9DPRdCxIC67WlbT8HKm9zVOxZfQ1MYdB/UhVdY
	 ro6wTYzfhY+eSYxdHTqWBDJQp6F5DV5N9g6DNSao4bpHrEBxEux7d+36kPtOFoyA3fk0t
	 aCUtOXc8awnHYAdIMzaNoeNryLiMreiSM5wQxoy5NRTP7T9lTXWcYWK8OvJXquW1Whj/3
	 gpnnD0hSOvEMw3BtRUXQ4Pg/yg+uKoR2+sRj6mGY1gANSVnlcqCOLDEkdyQcoM+mf1C+a
	 VkwotF/prdmA4aAjRD2PFXkOZFYy0pgZ2CFr0kC+8Q4TgMzQvPL+vrUTU3c6Nl5lxYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=p2HQn0uK6b7S8WnZVO6RYFKBvJhyKWdKHL77ptFOkeg=;
	b=Os8gvIOI0Whbm9DQqngS0fGwl/DlMOzxAIKAoMDfnv2GJWAeCqtGZLFHKPIBfxh0twTv
	 vtLLlYv0GTPsaRGLz74duH7J+gL8Qs0EDjIGptDMP4WY983qhBUn6Hy7YQ1IpSZ9hHmPY
	 izc27qGmtpPbcOc7c73DVQBaOs0BlCbmBD9Xrn6BS0xPOaQbzJ4Sd8/iRnRgRVTCh0/Qn
	 bFv2v7n2gHfO42tT2hW+j7o0ftsU6uAoo/wcqRNDwIMi35i97DrWXq9CwEsUiPyxDieVA
	 N0hWKk7xtKxoUIuCC2krouG74Qj0weeE0iKiEzM6/J1RgF55OX6z5HICyzLrQLUBWCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="LvLe/MXX";
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B4606A336
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 913B4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LvLe/MXX
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-14394530ec6so178578c88.1
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 16:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793923627; x=1794528427; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p2HQn0uK6b7S8WnZVO6RYFKBvJhyKWdKHL77ptFOkeg=;
        b=LvLe/MXXry1jgk7Eey/L2TQNWof0QGHQXHpLQcOFZulqY9+I1im93ty/5HtVlYMEt0
         bPyxF3cvbo4TwvJ9Oxolrmehmn0xk/86zE9RLB2289WfURhdTrXpdFMjOB94oS8lTx7T
         yXgljn82jBzE3nxowQ+QW6CCtAs/2y1Z6kHwAK4NqMiDq6xk6xQj1ZvoksPlaPJzrtZZ
         hcq6JLMXavxQnbpbGq2C2b4pM4mgBfkT9Xp/v5Gr/Sy3MhZe2LKVTESy76gathSEHDOa
         RPw3Rb4qeXiAJaYC2kMgh/qNrXrLAXCQGD7JCGH/UXIVEfcI75sIihjf1PSCTt0ZebGP
         eejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793923627; x=1794528427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p2HQn0uK6b7S8WnZVO6RYFKBvJhyKWdKHL77ptFOkeg=;
        b=CBeaE8GHzdmuh8Q5cfUyJ4Rh8lunzfsUzn6uBh4yKcibAmlH5K7jBet9zNyrZh7Gwd
         vW4o3Wc7MFWfDZTUNxPLGjlniMHF9uM+bGMhKAwvogcGgnoZgO6TjbjcEpZnr8UDjm5U
         xKL65VxQy1jtjnEJcejXLaK/VQEQC3VCyFUGyJVTAqvsA2OF47hpm8gKg+KuzRAB6asa
         EVWOYHpORPmJwdX3WSlcplJ6C3UvQLWI7lLY/T0KPCLY2nyxL8+0mySdcgtQVge1LwYx
         T9ii06+9O0qIifmY3EwLooqFamY0c+FSMO3WPKpVdFBSFISxsWlcfIelEwcSt6Fe/c6d
         gxeg==
X-Forwarded-Encrypted: i=1; AKwUvBwOBIIm8E8ZJp4SfGDI+HXHmxdNXOkGyfEZKa002acGv3RMtFYoze8Cy458FHYcqDm0JvZneUVqiTjmPM9CIw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Abt/3i58sGDYznJyegGhBnx4f0TmGsCnHRz/9reN6dn6I4A7K
	oqUt61K0w7AIzhxXGiLktNN6d+5+Ogv0B1SMfhujs5yb0RQqmpy/C2k6
X-Gm-Gg: AYBFou2GB/CNeVi4rGfSjxQWQadU5x9FfFNe+n3kQmR00rqhpOAsJmrIRU0aO3N0pkH
	g98ldT94H9QeP9Vazg+jjSYXGsXZqnTVAXOvwka9luR3nY439QsJctj5vfjI45hG7QFQgZ21UX3
	v+SzCkbhtE71Bq+eBYjgDfZ55Mlevgs2I8SbQP3pOJrq+zQH3xIsps566m0kZZhf21RH7OmABc1
	450Czxc+Dzl58Ly73AnADBLas+sR7uvIi03RciQ9NQbYffv0bzkAIwv+//b06QA7Sm3kjKW8XHF
	ZMhs8f8EOaUp7eoSOXWaBLsWlFy8Xh6HcL3W0pnFQqMOgLBre79NMrKNDgRXqYNPWsabywOfyAC
	1vBDE4ZN00iZbMy+idQJy3SBde37fVCzv/cXRqZDOwIUNrT3yCvwHheNu81T1rv6hUNd3NzuEfo
	78Rio1iesZZ+urq4AWzUQDzrx92QfsxPnBH2PCcPhDFgh4mGZoI4kfA4KSxpevx9CYlf+4+NnS6
	fjpop0SsfHCrc9NKNZs5UTs+gHYtEPU69tEgdvXm9RvI62k+4Kh/EUDubksqQvUUMfTge84M68U
	aFR/sz2SmH3RT0fkGM1Fs7pMP2pN2UGHGZByjJXqm/47TvkOcDeUiSLSIX1aOLAYhnUQ2gDCReo
	af2iruEeQI9w35lOc0YMs9AK19PWmSvpREg8TODKEeLOrxpA=
X-Received: by 2002:a05:701b:4251:10b0:16a:1fa:58cb with SMTP id a92af1059eb24-1b25d287191mr832185c88.1.1793923626429;
        Thu, 05 Nov 2026 16:07:06 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4e079esm371165c88.19.2026.11.05.16.07.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 16:07:05 -0800 (PST)
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
Subject: [PATCH v18 05/12] ALSA: virtio: Recover PCM state after a failed start
Date: Fri,  6 Nov 2026 09:06:37 +0900
Message-ID: <20261106000644.20460-6-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106000644.20460-1-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
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
