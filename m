Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845926;
	b=IjvkICupKqQ/ZBq7brC4A7AnHSnofMdrwnzJ4wgNgB8I+lpucc0MeO+s5vLfI4u401tB
	 UCcHsNewGpjpoOxD/w4Bb0ruwjDT5yxjWPfU4cF1SBjbNnG128R4w7BVAPGGmNBziSSme
	 CQB+FDkVHyIPnKGq456A0mZccBztmMaO8EqNXqVKb2RjpABJmE0yUwaMKhFNFuDpwOqjt
	 0VWcRmnpXmnQyqG+Zr2R3fvw7fcNfDBglcgEVPM+q+Lbw5zlUh+Qt0iK4TnApTDS8ppyB
	 Qa+JpaFR2zoFOb9+2iFrnXHQO87eqFdgbKZpkSatRPpfpj0Ru5P3uIA0TaTNY7l4/YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=L2ncasJwCW/aoSrC8F4UjbFCWtDNg2LhwMiWB4wH+wk=;
	b=YsJraUoy1pBvTLXpMBcGWx43trSxM3ZM3thD/kimNHdl/nYWUMwIQBiHEQnWw//+DMnj
	 VTFC4SqzFYIh5qk0RsX6P6pNbrvoUWVcRtYxEEFAjq2x9rcJ0eSUNcSrIjuhrSsqFGmPK
	 xmnLh2R4QM4pnWIWzo2V3NQ9IkvDxrlw5vUc3pnbnG9Y5Wr+WXsmbwbjQwuf4rbhKSfOv
	 wUGSS5h7eDPbI6OksMMaQYQnFka/ZptJIjO9MFLn5TxLDRsGAXNBw5zP0J9+xB7+05gs/
	 uMDPf3Hps4G3CG+H8UgGEjNZJXmeUpi+Lp2dWfNm9+OYeCp+SVfZbioXKuOJYIFo0rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YjNR6Ly/";
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B56A606D838
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B56A606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YjNR6Ly/
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso987969a91.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 18:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793845926; x=1794450726; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2ncasJwCW/aoSrC8F4UjbFCWtDNg2LhwMiWB4wH+wk=;
        b=YjNR6Ly/eoRVZsnAeasvErjr2xzGgYXLAzeFHNIRnYViwb2lBT7trW/DSkzJGqorm0
         wXFF6K2cb7+ePTmd0D6Qa6mFzFEeZ8qwMYOuXR0heISzhNl7YBZPCc2XENWo9AJbHw2M
         6xEHUWXLhdKk5su74klfzb5R7G0yyZw4QfagnyAv1PllhOMqw0G7OCoI6+8wYAuCXQ3q
         B6a2FCdK15xPzLaj0Jq+qOP4vhCXDgSCu0xWJvOyx1x09jyrEiv6q00SC43JGAeUx40Y
         5SPAAD6VjY7PtAqpH6OVpAnavnmKBAREj6SwWbAFHAjRcQfw4f91AOvQWYRHAx+YfJLO
         ZxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793845926; x=1794450726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L2ncasJwCW/aoSrC8F4UjbFCWtDNg2LhwMiWB4wH+wk=;
        b=TJvrRHmhtol9OiDFdu5vwA7CN0SG2YxsiIg4Tk6lMZmgQ/7t+HNmcusx/8V8Tk02t3
         Ppc9nKrsEITaIt4wttaKhXQzwnRUlriHCnTE05vDURr8eS19M2FJ5O8eqS4IgR+nemk0
         AHqvTavNz5gXlwRY8XN1NsnmlV/+1hqbzcdweeHXo986Rnsk0C5saNFYJwb2BMYz/F4y
         oAReAukgdaR63iUJoJXHJ6CFZT4388pV6zwaLCtmcKbOU2NoqWKfcpHjWPbbyIU4BTrp
         EgzvaeUJ+qHRBVR+nBolx0AEJCm95ZNYW1MIMizJRL5DwAZjOovIkn0rOAwMWL76DKg4
         f1Lw==
X-Forwarded-Encrypted: i=1; AKwUvByTKdAlzVYwJl6Eo0iB3ewZLOig24TyFSy8qtUUVf8eiO37LMbPK0TqzkBe6f3hjtqZU66Q2UugTXY25aMLew==@lists.linux.dev
X-Gm-Message-State: APuU4Z+OLzGVZSFuEgSig6teKHJtsry95QKIRHinoRCpnxQ9zFY0H9o5
	Vfon1vR+Bkwu/cprWGrrVrS0Ql7TmhLseSGrb6ZH2BXJtjfCX96hW9na
X-Gm-Gg: AYBFou0v5335AuqVsN33FnTPnRZwBaxQW9KsE1sxJGqMfCBQYrze8LaV+5dWAeJWnKi
	CsZwH/ZEo9u+hpByTmIGyAMwlo2awc7/NK8me8ZOelsrTz/wXySnS/i3D7p023YVm6ry1qbABpQ
	/t6wI4IWmcKoWEjuws5pnMeQoUpufdXOiq0WKmFg1Ch+0URxbIF/GVDly89vgy5w7WdWwWMkNjo
	cuvlE5ju1DAxnYbqIUh9PFsgVR4XlfsWXGzUsOWR8jbPkZB2VoW2xD+JXjgBhZVIVJv9MTLAKoM
	uEznlGJqvHAKshimhKCRCHx4QXVwgJMjpON3KUVuD4qOl7N7n9UBciqGYYXlwuHhACO/1A+iigd
	P3ln4R11evVXQuJPLxLfEbkeZPh/6o/TJfJpjAioKUZKEXwH7nt4VQalSem4MeQapd5xk8DgLNh
	yivKtNxOsgvZ/W1PetCDMwaw9HIVDU9lFkIDrl/G6wGJtCCMWRhC6Z20OF/PDbAZMzyOfs5bO6l
	bBk0zv5GK25eOl7YFrC2mv09P4XHv5t2DGg4rUesBlhCQFjFEdkj0llE/PKTH6u6pYE8OZbSpGs
	/ePGZDfInW0C8B+fPFtiIdjE7jP4mpGjYHadOfDvSc0PSBv8/7RMNyEGwS1QpnFL/g+fYi181zZ
	zetOxN0vVuNhTWQ+3RhmnYO88ewq64mrm5qtq4sMo1lb5zxsUvj7xuL+z8/lX0JU/7CTe6w==
X-Received: by 2002:a17:90b:224d:b0:3ab:afca:1d79 with SMTP id 98e67ed59e1d1-3ae897eb33emr15008437a91.21.1793845925764;
        Wed, 04 Nov 2026 18:32:05 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323cd3csm1292775a91.3.2026.11.04.18.32.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 18:32:04 -0800 (PST)
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
Subject: [PATCH v16 05/12] ALSA: virtio: Recover PCM state after a failed start
Date: Thu,  5 Nov 2026 11:31:33 +0900
Message-ID: <20261105023140.18373-6-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105023140.18373-1-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
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
