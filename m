Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263849;
	b=lcDBDAs06/Dyeb5ZCWknBjtJwOASNoQCAbmk3Lxb/lscstYf9XUu1BQqDwysmMx0nqy1
	 A1VTn7Wfv3ath/eQRZtTirQF7hSptoSRWBO9R9pQ9wB3GOMPknDJ5mxy8VJgmvpPWnemn
	 dWfWzMH7OCk8mh+8hEup3tWg+vJc1CghIrop1lAltHs/Z+K2QuI76nh3XPBRwqEXiuCoY
	 zAbfLIcm5Z9yAHI4UICzmvkPjplkk4Dpgy0ot452ps8I1O9h+1gfKTakKYMUVUpKIxzUT
	 6V5iDJWGeoPnmFmwrXMGkCb24xf3RVUF4Zejx9Mt6DaPj8pB913yV/IGaAUd8TKTTSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pPsijI/WFroQ3WU8JWBkdFg+dO3cPuO9jwy6Y07G2CQ=;
	b=gpiYFF9y/oAZJZfP3Nlh+rDdh3Otg71laM8KxhJzIElRnvlD+G+auCoCwywIMbzdZjVf
	 uJqISe5bLVZmMkhiM5NnUgIz0PfIgA+Qg6LhMXeAWW7goaWt8b6OHOjBEitd8P+Gpz5kL
	 MfMEScuSlvmaiVcJMW2aT040F7hBm0BvbdLuXF0q5QzwUUVbYUxJe5/mdaXKQh945nVf6
	 warovqu+Pm9QzMSmqXovKGGuMR6qqI+2OOxo2WkYBnCYF8nKtep3zuXkhVp1ldDl2TM1x
	 iugJksy+57Yzh5oK6B0wP9HEXn+IS10je9G8TU1q2B07sGDIcgso1it5MQ72quASotg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hjly2LmU;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB40606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EB40606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hjly2LmU
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e8246b13cbso15946505ad.2
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 01:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263849; x=1793868649; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPsijI/WFroQ3WU8JWBkdFg+dO3cPuO9jwy6Y07G2CQ=;
        b=hjly2LmUSIf+u00S0UsbnKE5NNs2KkQla7Q/EBN2NBbas5q3OWXL+5/Yb013Nc8K/D
         9fzv7y21dhecYPfshvCOohMX5GNO/JMunG03T12sG7juYvL9iTnq9qxt4It8KsaKNy73
         LwvJK0CMVLfwMK3EJQhsVE+IIiSyBbQm2BA0DZDrkwFoQMdlr08J8Qn4pOEgJ5mpUZYm
         z955OucuZF0J9WP+oZxXwC82KyxwIzC81lycf0+DPe4teMcM/n7w7FHa/xrSVLrJlMkw
         A7QKqLBwC5e2Ji/k3+12EujO0lxLDXqfXQvNWPimm8Mi/nLIrzJJ2/0rUcZ7GS2nKX41
         cndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263849; x=1793868649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pPsijI/WFroQ3WU8JWBkdFg+dO3cPuO9jwy6Y07G2CQ=;
        b=IcaViMaz++uvwLm3vOFwkQ/AGXS+D2R9OS5I5BvwEW9pAaa6qLOE2Ma7ZN+n6IcYKz
         SgScKkCmUSLBg9JZ13pBKFblMfz1XHnVoPSS4G4PNWdjg93z+WgkFroTrdhNGbovg3hB
         9vPfz+ziLvPDEe/NMkwfZA/mcguinO5sR6TzImp+Awdy0DX5jmxQq4JFFkMtKrn8hF1n
         +llmFiPPyfFHxGdJweeWFrG8o2ZjOfjgKT6KBxRR9MgvD7Qd+asvJoqwr5YLmN648AVu
         6HrZ+kalpoxlWFAVaNaHPPQT85YykY7JzZhQC9ik5PcWYuAy8KwOMB1usJRthrGbsagG
         17lQ==
X-Forwarded-Encrypted: i=1; AKwUvByAbz3uIGFfbEMttusgoi5p9NkDq+8Ypxn23ZYJyLf3TcAzBgMFBd5d63n06WOQJa5H4oo4aU7Y5fTSDCGYDA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKSQApHSLrFaNRa3MPCWjQitwX9rV/NdtNmPdQHyc9jVxWt1ZXF
	1KwVjRuynrZIjShj3xqNTZt9EE96cemGWNSb32VLqy9YT2kQuF+piaot
X-Gm-Gg: AYBFou1mUBtzyYAEjUzEg9mEIoBm+QtcUh6dS7kIk9V9IAdaYC3wGGYy7wbpLurD2xR
	C+WpFhW5UxQYp6/kBBcme8MoVQHeMPdzaDFNUK/KCS1yJ7RzpmkaFs3jB+nTfBImHepmyDOEimf
	QBT4Qbp7nlauOiok3ElG21WkE5ubw03P4m2CWKUq6gJVujMXzOZwcRDMqOwrpiopQ14Yost0fCg
	f5vjAYgHJvGoGWap79ebwvI/d1ZGwNlaj+C5txLUl4TvkulWlMyI+BSJtLvFSaJ3e8lr8kVFtCB
	e9y/5kfTVWwaxD/TjuKUOI7HvQE1lJK33GSB14mBp2ntJOdbd4aJKdFWEAGk+DN8oxDoYM6889Y
	6oBvsXzzv66KoAV4fy572itYzNrgCVLnbEKpR/L4L3zrNIfzeQTmX0AUWlIQnGql//TqoAaap3Z
	hh1H7bOZHjlz5OKNRfggVkGHnBAbTFawuuv+ZImNm3dHwtfuRKD8FxgjP+2Jah/r4ALNFC3hc0b
	Sa2HvbGaqeM3KbhXlVSfSV/I+6VxJO0Obl6+RpAmJXGliZL3r19oXvoFVXcHQzEymHsgl51J1uo
	Rzf02vyjo5KxfgTgYen56g5CAsE/0+2jc9CVuSWwGaVkJif+2f/n4+RR3n28o6QQj6Thln3x5Wd
	GOSsWq21lYaRg5gQGkF6npVTahoXQ4YuBzKQ2xrgHqw==
X-Received: by 2002:a17:902:d2c4:b0:2e9:6333:fbb7 with SMTP id d9443c01a7336-2eb004cf0e0mr48238865ad.51.1793263848855;
        Thu, 29 Oct 2026 01:50:48 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm29991205ad.35.2026.10.29.01.50.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 01:50:48 -0700 (PDT)
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
Subject: [PATCH v9 02/14] ALSA: virtio: Recover PCM state after a failed start
Date: Thu, 29 Oct 2026 17:50:20 +0900
Message-ID: <20261029085032.70689-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029085032.70689-1-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
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
