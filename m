Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664257;
	b=Vm2FLr0248hbezrHrCY134Tw9NDzX0AIT1sYwrx/EUpGFr4jOfNMvJE0rR4po17DVATr
	 Z1fllEd1JIuTthaT/vEhAKM4/jxNpvyL7yw16u+0Jsc+dqPFxtAU9xXcAsZLhRwT9VKlu
	 seXx8krBm9tHY6mg8MB880Xf8o7LoqUJUqIW+3gBwuHcg9yPjHRAu6DdUlRtseEobePle
	 sqdEKgDyAKWXNakpJIznKC7MtnNbCq5WXj/oUjQe6JzI5PKYr/JEA1jzGnZ+24mv7OWjJ
	 GsrcczhtNTOYwvGXsitAgLDgmrIpQU2o8Qn00VDNrBY7mICOxERqcoKdgvpUYZ3PU6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pPsijI/WFroQ3WU8JWBkdFg+dO3cPuO9jwy6Y07G2CQ=;
	b=Jd/7m519Z3uESMGwkI1Ev0tMc5W+F6IFS3w3ldDmfQx8ZRHKq8NEy0KsObF3fJ3Nk0Hm
	 nDQI1kLrLIl07PFdEvLm8tyL+vHKUThRZwVJrYwACp40/jzLzGniPZz0OLnbCUAduQarl
	 +QH7gq1e6qQWJ42Y0jIX3Gwl327B5EuNwGY+buhwNqiw7UEfswtKKoZHDrTe0l6Pal36P
	 Q3fEqt5SEdKwf59KIteooBLs4z0uoKR8j12TXyjCUDqAMHD/inbCKREJS7NlSy/F7GMe+
	 kj7AMl5RuIgi9zspFlCBxptCcxty6idP8/A6wwFnbSc1HJ2TSauYYw9vYfCovcSTiEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gn4doqSN;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5AB606D809
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E5AB606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gn4doqSN
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso22036635ad.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 16:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793664256; x=1794269056; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPsijI/WFroQ3WU8JWBkdFg+dO3cPuO9jwy6Y07G2CQ=;
        b=gn4doqSNGznFRSlHZnzG8wAqgDxBzIC1vbS+Esf0G8FegQCTznyt4jcb43SrQzDujx
         2venFKlsOMffdJn1jQHwcxHTeGAwI0hPLCKloF5xkyu2wGz4fN5OfgU0cDRIwuQt7pKj
         tI8VhB6fm79AyS3N8Uor8i2Ben9EJSTIE+doHaaIJOfggKTogkDLqBqUvflkG3V2XI5j
         TBiq1n0/X9aVWnQqYlDQgnInXKSUhreeGLY2EH7G/oX4oJB/1qcn/qyOFfFNyxm22/Xg
         AyO3gD2s87XLs63A8PGj9EOkP2Xl6Nsy72+EdsyefsrMDc420uirrx7HqCzJKdq3OPdM
         /pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664256; x=1794269056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pPsijI/WFroQ3WU8JWBkdFg+dO3cPuO9jwy6Y07G2CQ=;
        b=M1udTa2vzX8EhAyGhxOidFkTto8xyDowR6wr8BKjl8nSXK8xSczEeswKSS1ai5UjlX
         DWFgdtNpc3Ac7EdNItcwNkVoN6KK3YlncGSkby0LqZgjOQaNx0kJW1/N1sGxnQcXEKC+
         /DSND/bMe8hVID1sPP+XRix6S4P4Kvx9irBkwmLOtpVTpfD8SkeQ5J1R0XRMonuDyLp7
         33fli/p2YWhB/Jabnbh1+uMrb5LH+xCK2hVlbABk5uyYxkviAR+Hc1XQLxvKLoObxweR
         eF1l/Gb/BIl9HLHQhhdIazvChxeBA/VvAMaS5PenuR/n0cMLn7rlXJ3r/EVDjaI9aZUZ
         Ljrg==
X-Forwarded-Encrypted: i=1; AKwUvBzh7WG+0m263P9JbPAhlL9c9fmw0rsEr6LhebKe9MqemVdZB6ThDJs8df2pVwTtd0CI7lYSAajmk4CAW+uYFw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/E7yT4Hw62y8Pgve+kg/+1cq4wYPVH0dfG0zqDFgPojxQ3DnVg
	TzzL8ZRj63sS4yTNgrRrepNmtGhvdS7RTz1isLi9PFa+t6prjHiVRC7A
X-Gm-Gg: AYBFou2mNtvYPG0TNazNYAb0JybGPQu28c7Ig8daiiHu8ykJEFQ0lfCRcuhu3byE8ql
	KsZ1mQVRTd3XqOF49Y+8JEPOZ5m66/4/5NyE73BqIzK29oQ+P7GzOGxOXtzBXypJz0kHPgWcujm
	Ytts9jCGfFIBzb+Iz2WuF/Kv3WN0rFKI97lsZwJQsY0ccX0W4dbKeOeLCn7hBfBcGkaUPqZE/ex
	GmqyhW6T9MVAVaTLCDaADfpwLOmL7T/DkcxtOXVEj5oExmiWgpfXdAhRBqKxKDA/x+ku9xJHp5b
	So5/3h8BqUKYVhKJcOxZyeM2X+abqU2yqp2oHm2VkmaEeyavPiSg8lpsiw77/ReqxC/vbLhqwYR
	CPMILqnqWE46EeYFPRKnhpzT1JNRBbwFz96aEvLDAR4P+H3oBX+DfLAPluTUxfihFcF60yRdgJ8
	U4ad919aXP3DJy+l1EVzDAHBGjDYgDMdbKVkoirFg4Rmyozl7U1g4XC/1A10n2WQozBqp7mBc9D
	w3VpMFgnQ2Mb+hkUjaaxlU7aHck8nIi94b9oW+ePpLZpsR9cMTe78UroNQ5oaZub0v6ryPppjcS
	1bygIfH0GGiSErpBB0l6MRZ3iVW8Hzz7yuEHU+dAbdfeYF1NVzAkUycik9/jK37ck5d0qK4qT4S
	4xDPy0IHMojA/kKWF0nLHqn+611z6D620knXOi4jS91e1vnA=
X-Received: by 2002:a17:90b:53c7:b0:3ac:7e3a:1033 with SMTP id 98e67ed59e1d1-3ae897c5e5dmr9665911a91.59.1793664255901;
        Mon, 02 Nov 2026 16:04:15 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm1339225a91.13.2026.11.02.16.04.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 16:04:15 -0800 (PST)
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
Subject: [PATCH v12 02/12] ALSA: virtio: Recover PCM state after a failed start
Date: Tue,  3 Nov 2026 09:03:53 +0900
Message-ID: <20261103000403.67106-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103000403.67106-1-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
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
