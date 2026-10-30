Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338004;
	b=UI9KjrY5hK7opOrVDBzyXO92WzVKfrSlkJouy0/3hQxfhC1ZAT0RYI9O+wAmQcqQ/8+f
	 kIEDKsQFjjTORORqXX79nF+O8q0Z1knIiJxOy6z37BBdx/dhZAqFlH9UPCkPhoZEYUHvY
	 q0B5ELdLonB7VOiyk2VjsFIHyZAMNOiR1CyY1N9oY3cEawfsn2KPW8mtSgVoFlkdFPvu2
	 IbIJiX/dZnSd2w/OuRvIcB7/ptDtY6UHL+k4l4eMu8FjPSFI+h5TznEsl/IjnNFgVdcDG
	 WGotz9ZsRYWTSsT9+yv+CmEpxRTdCWrUYLTKv0kQl7nvcVRqbQtQtM6Pu9y8xAMdqOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pPsijI/WFroQ3WU8JWBkdFg+dO3cPuO9jwy6Y07G2CQ=;
	b=Gp92n6sUxgzvFIhSQmNhhn2sWxOI3ylRnmdqOls3VR6tcAFClEiNf7fLVU8XCIECO0Oc
	 igra5OFQQxPQ4Z9TmKNZdXNObTjrNE4/7qfyjPdZjbsoaOKg44ossoWPmIUW84+Y1Vybp
	 tpQIecEuJtTJyBzNIcfTNO9v1NqKCm1Meih7fRagWCXR7wXXgwnRF8635GA1ZtkGQ8TBC
	 4WHcrHuMOzR7FLm80doVFyADSiP3K80rTzhQyPZeRMvLjqvlG6nT3SOc6NnDzq9dYERz1
	 +/hAuN8afhNqNdsrSY++CuvDvjjENrWbF1CwMrU2et0ZoYDql4BCsoZqsPPTzb3X6ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UC/KPP/D";
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB76606A31A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CB76606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UC/KPP/D
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd5cd8d89a7so100133a12.1
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 22:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793338002; x=1793942802; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPsijI/WFroQ3WU8JWBkdFg+dO3cPuO9jwy6Y07G2CQ=;
        b=UC/KPP/DScKjMIKEFHv3aNIk7mab0Q9f6IPFowdOqROl9Zgq+uZNvc/d+tgGZLbzpd
         RcEIpQqsFCrwltKc8H/w3RY/NuOcoWIEQF7gQCNuV1/DxEk+7o61dLIq9lAHFNClr5KP
         RcPVnvlS1PbTSsvbYY12m+ri9kC3rR2UHbKnRFJRG5LIpj0ftZSj/WqxdDNtuDpMligu
         s7R0Pmcg4PrHY+EfPmZAFxuzUhSQCw62KoPTN6cMBwqqxrEVfZXbRbHvKHHqqqy2huRV
         vlvUVbuJRJd2EwtH0J3aF3AYVxx+eFnHeLQWDvyFtPjG5J1lpAsxxdIU+vPQWV/OKyYK
         X8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793338002; x=1793942802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pPsijI/WFroQ3WU8JWBkdFg+dO3cPuO9jwy6Y07G2CQ=;
        b=k61AwOUV0dfJfuh7bV5D9eK22Jzj4VufaG2nTh3ybRb2j9SkG6gdYTbDRKWMVV8kB/
         yUuYKx5tFSlSvy1CDIaNjERw7TOO5lWigC9NCTGiNCdXulONFVkvT1ihVk7fwZTDgR5y
         xQaOvXz22exKQ7K7W1SOXrt3Nitq+ZHFYrEHZUMwJbBEVZNP6yFF4CKGg350cXP6H7gr
         55QG1TTs0/CNK9Jvt3H9vLG+FUPUxCUxxOz7fLuCmCnNUSeCyfqvlzihDXiVvxmAHZUl
         sC5qAvY4zspaKsPrBLufa1nBUFU0/9hMZkI1nsBZye5ou24nwl6nxZRh++ztpSD66Xly
         j/Uw==
X-Forwarded-Encrypted: i=1; AKwUvBzCx4UslK5ZTIzEwWtgAt01IWcVIaLH2zbt/XHAgSazlebkySIegiPjNuffqnLlO3HhsLEJwqGinbdlIZXw5A==@lists.linux.dev
X-Gm-Message-State: AFq9FYKSxuWn/F/C4o3aWvVth7p7wbt3hoQYsG6DX6cQRGUsWPaIHuwe
	ZqsUl4INSwZB/9L4ytfczjRWSRN1F0xO1+j3+lsi/7Kt/pclQCIQiOTz
X-Gm-Gg: AYBFou3ZG5F3J+OVZPpfK9sz2CNCoNhcH+WiWg6cI7KSM0KMo0iVVx3A50xHUOZpJeA
	7K0m2gK6zc9fu1lbFGNJ/BDcltppKbaTxsAaBrylPJ0oF8BRJUw/1u7682kRJ/+Nm6jnjNLSwZv
	FolOdBNvOu6VRvgz5VYyA5YDFJHlU5ib/5exCXETQp/678kFhfkngXe9Y2C8lHTfLYO8765yJDE
	jdqc7QFnG3C6IvvxoshUXGJ1ZVEmz6PO0MEsGjp7MBwyyZrJb6yffgYHfLLkaBDL7ORvRFxUFFO
	mfhr6C9rMGccw+9A6Tu7sY+T/UdLZcCZ3FtgpuPr+VNzqmA77qhCRyD88CCL1TwYrFmNOVBDh8b
	41COnehGT/evqHHO2ThG2+aS4CgL08dfM0TLCBDD3PNC0SCwUUyNCmyPs7+ZU/BA1hv+CBR7sJY
	hnIff6ZeigEGiLuTO4FmAxzMMHZ560Vg4odaEgLbGtDUrs9K8k0rS4/QBTFyXqG5kgWjD+06MTX
	xyul1ascbvXirxwkC1yr/MHMovx9uQQyN8rhVvH2bIt1pJe0oVPRW7k6xllMBoQwrB57TV58Ytx
	ENMR/S2ar7Xaz3okXoWtKxxBUVj+3XR/vmI7pGIi03jiTTwz4jNpCXqmlP5SeQs/Q/16VGSebkC
	9bHmDJvBtAH6WKaJLmYGXfLCWwYLwbbdWbsgAnrktDLWqlKk=
X-Received: by 2002:a17:90b:4a11:b0:3ab:188b:c5bc with SMTP id 98e67ed59e1d1-3ae896f7fc4mr928054a91.14.1793338002321;
        Thu, 29 Oct 2026 22:26:42 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm2421027a91.6.2026.10.29.22.26.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 22:26:41 -0700 (PDT)
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
Subject: [PATCH v10 02/14] ALSA: virtio: Recover PCM state after a failed start
Date: Fri, 30 Oct 2026 14:26:17 +0900
Message-ID: <20261030052629.27742-3-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030052629.27742-1-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
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
