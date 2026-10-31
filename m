Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412553;
	b=itlzYvuo3llaolP72uBbE0lq3pfvjMcu16dBtayw30QnoxB99udGLZ0ed5zI2rsVaF7s
	 lWchtaC0W6WRO5MDmvva5W2UaE6720KhprC30SrQnllzEmZLukofzYUZZqAAXS4Wmry9r
	 fpykuPKEN9q9eiKeKtOB1SD0KnO89mS0cXPzBn0krvX/DKFHTqCoyQOW/3ncdbywQjTWg
	 pcwpBxgHV4xPYETK1G6ExID9m73LtaCYFFpCmnyhIrsQGMMIxSVVTBv7D2xkc39m6VZFD
	 9yGtX0fwRK36/p6Xo2KqZEvx56Trcafih0eNzsGknLzJNPmMJw/5hcgQvoZEfXCSscw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pPsijI/WFroQ3WU8JWBkdFg+dO3cPuO9jwy6Y07G2CQ=;
	b=39eKnsWl+sTvl4spHgiVos/oNcerHj2xTUtA8Af0ALlGYJIpBfvJIY9PqJyAIdKMDw5Z
	 Ju5pO+r5uwvUChtJhlYyJiLPIKvzjjMpTdQyybKQXGeJKVW9x35ZNs1RVt1uV9CDsHaHh
	 ASIwbsu2rZ0qfxcTl9KtAlgZNMW5KTI7ri33LXTW74DOo7jMyycBOHMvURGxAWVFaiypc
	 VCYvpqYy5Od1qerJ/Jjxn/nun7EncqsLTTCNLl9VsaMPc3UpZnjSKx1DtLRtXDxg/Red6
	 3N6brGUb++tYZLu8kBVf4oAfpAY/rOJpQ/ILIbneEuAPucUUJFiJfrN30uxg3dQ7AGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0WTjk/iE";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FBA606A32E
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16FBA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0WTjk/iE
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a1947498bso772909eec.1
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 19:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793412546; x=1794017346; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPsijI/WFroQ3WU8JWBkdFg+dO3cPuO9jwy6Y07G2CQ=;
        b=0WTjk/iEl1lMKCQ596WgY9aCU/6mjK9H3QrvEqmnLLy5oj+lSj4rBEU4IuxMa9xGl7
         ddc/0KI1rqvtAtlgENc1NRmHREhE4k1Gf0tJANq15svQ62MCsHhT/HcDADUiep9+fvZp
         gJqs7bVioUTTsbcuutHBE35n/aWPLimue/oKIfn8B4sBRPw3BE9SMle+Fb/aR+ptm+OZ
         3CUJH80DIkBNEXSt8pnvEn+xS6nmLPab398vw5oOrj2AiVgy11EH5ySlc2tAmdr1WGQg
         AAtmDil/D8dZIRuwyeWTvX5ITbYExAdOt+3p9rr1938HPoI7QkYZMeNJE/LiVaY8sOdv
         Bu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793412546; x=1794017346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pPsijI/WFroQ3WU8JWBkdFg+dO3cPuO9jwy6Y07G2CQ=;
        b=Ucwk3QVoNidVx36idQePQALzESS7fzRGKzt4oUy3Q7qjyUsBR0g/OtSfhzKbQe2VFn
         cuj1kLY18Cb+RKd0R0kQYuv/l1qWYwG48N/yDBk9vyGezSuqQvgkDZljWUgIhM/169RG
         QdXXMh35XggsetNfNtUWqjJrIMgnbhuEPWi3Yp8uvzCQsDtodqn0hwmdhFAISrA7XNrW
         Gwix1AgJDMBeVRCYAEH4lIuy/6ak/DYx2k8OAhjZR04sosbsBNk7gPCuO6QjPt32tiK5
         XmbDwa3byjFhxRdvBHYzLr0FHS36w3nG09292EQBbHtlss7Y3hCtwOeLlu/upk5cOoyY
         b7mA==
X-Forwarded-Encrypted: i=1; AKwUvByk9t4TIyjVFoGvaSjEoddFFK931KBUl+TgAdpVnF5eF4nIAZUoN/Vlq3o+Xu0PdevPM+vnhh4HQdFcaWJXQQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLrDPOXDqkSvINYUHe3IF6EIMqjlzfF65V7TfrZDCQ1SWmXl4Hq
	zog/Y2bbWX1ETZoqXHJRtvikm2j3AghK8upXwmfekfjxf9YHCmdF8Epk
X-Gm-Gg: AYBFou0ryG7AfdaZnx2IaP3m9/qGe8+4i5mNiPae5NYys1dtM5OJg41UszeB+aWK3tn
	qq7shg6e+h1gHekLN0hj4GnV/6SACfVwkCF5pSAjnMQxgVtyF8kthkO4sm0zowQhGjMlZ6SOKlp
	lriuAQqKNt4J/OJgilZuQ+dyC5khmJTRjs6fta0pkCaJ46Ew97LCSLWAmiUYd+l2LzmLrpPtwj7
	9BwfTDE3kcKtNrEBvwKTpBPniVtP2dqIVgKlQZN0V86USos4x1q/ijXVjbv7sPIqwIsLQ5MOWW1
	42ATiQ234KSeKzCNYY/Hz2oAkrRBfqA0xF7t4TRQ6tdEZaF+ErrK/EuFeejGxh/T2+JqgPTO5yL
	LhPtGHOdVpjwC77YAxQOwmUbJ6Tr5b8IxTJJKYIdB7ip04Ux1OODDvGqtHVs7HbTyc40ELMG0cV
	Ujvvygzanr4wUkwYT/nGgQ0wYNzE14sHiEepD48qXMaAdo18h4l6NtQUbH2QSJ3oD2NVpwWgGfE
	noJYtxYRQ+ZBm9P/p8qIcVXRwz1OlPuGvuTXKw4OaasbmvntnGi14fIZH3TefQTfQEqUZjEXUJD
	Vb6iVQTDzLs6VG5rQK5jCd9A5zmX7gxgDGEPE12J7oV5eGap7tguTLkDUpYntXOnnL+/ZXFcCoz
	1PoM+UVUtSIRUU/9Mt+JQ0uWItyKVCxLgPLjOdftVa+SyAg==
X-Received: by 2002:a05:693c:83cf:10b0:36a:1427:3933 with SMTP id 5a478bee46e88-36a4236e7bemr6531801eec.16.1793412546048;
        Fri, 30 Oct 2026 19:09:06 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm13214096eec.26.2026.10.30.19.09.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 19:09:05 -0700 (PDT)
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
Subject: [PATCH v11 02/14] ALSA: virtio: Recover PCM state after a failed start
Date: Sat, 31 Oct 2026 11:08:43 +0900
Message-ID: <20261031020855.2402-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261031020855.2402-1-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
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
