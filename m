Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3423A3816
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877446; cv=none; b=TfTzcZ5ZKk/byVegifKC9EZwAADy5ELiG1zBLgPKyh5IO8XF9LY0NRTuRU18490DUcHQnYHBm4e5h/k+LC7+4p90frsFW/4mDh8E382kPZy/gjy/qpTtSNxc6T7exRjVd+uQ4z9wrlE0OcvAet5P4CT/Dda2OjlJIW3sezo7DG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877446; c=relaxed/simple;
	bh=Mvwm0oGZx5Wkcn15/Jtqt0fBIpKcqb+DnxaMP4V8Xb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAQ2w5zvCdx2b75b1GTJvC64L1MESKKxq4nkAJksLDXu60OUx9OVh1z5lGGb4p4YEcFBwBetmdhy4457+8ayy5gl6BogtkoIoNGNg/inPh7dhKe9NhPOklXWFSi87emcowd5nM1xJLpf2bk1VUnVA5FtpUkUELrqCLEKUkNBl7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ix2WWWdq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix2WWWdq"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so2804411a91.1
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 00:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791877444; x=1792482244; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xMI7teFV6AvKehNWXFxNARmcpOXzUAAEZvmyqbw/+Go=;
        b=Ix2WWWdqxwFz9vNhys7flQjX2cZfJ6/DnkUupnSQkniQKMPu8cYtiO1/bitAlc/z7m
         Zr2+53TtsXbzXTACkGpbZpHrEj1Oqhps8iaq25WAfPPDO0bNN0/78JZV0BIr8zUQUx/5
         jZAhtHFm3CFI3UKAFHuf2GPRRxTNUkhd/4ABeqvoU1AsfNIzpLWxA7DoGscHkATcCS4a
         kx/U6EaeA8SPhTCyXurnu1uqCs1rKSSRCzqUxI2pTqoeRtgPeJzKoM60nWwOjU9myrfR
         xYIRFpe64DO6vRE6CTer4Cc4G5ziNt12Vfvr+3EOqPfe5N2uVgm3p6yH/bqTjhQNX44S
         NgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791877444; x=1792482244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xMI7teFV6AvKehNWXFxNARmcpOXzUAAEZvmyqbw/+Go=;
        b=CFNmRCdEimsTdjX7c7clko2iCXv1bt3nHkjlDAFzj785AejYBJbFDHuQ1obfSvU85u
         X6uw9JFQ3oKqbWgDbeG0Lg20tsPL6q0UAm6MrDiLlximAkHZg96jcqg9+h0iUrfTkmVW
         9yZE9dqpCZwuRJM5IcGVP2g3mm56Tst80wT43IfTjsFGAcvzRFJdJ119XoAF+88tZeMk
         OyJSrGm5Gw9Jeb0uvk6cfnF0DVaHiTHY9TdAUcVX2rwtW+JXgdGnSOSnI62u/B8wSMKL
         h4ArhGkK3Bo+reNz9ajDLvsGqEoBxtr5QokhHCWedCAzMLbA4OAdWHrCf6xr4UOXIZA8
         NuGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgNBONHGIEQCiBZWoesKHUK4Qln6n8mJZUbvSrVsRNclwnQtsAiKXcVCnlE6Z7xr6i/yfEBEuhL74n/zmUrw==@lists.linux.dev
X-Gm-Message-State: AFq9FYI+CQQGrsNsvFpSY2p/sWRsujdRH5GynqB/T1Q35BTOS99dBqb+
	j8nPB58j2qJpql/dvQA9oEAJRCSZ+nhVGicMcsjVG8YlEzerDsIDxFl02U7b5INt
X-Gm-Gg: AYBFou3eNMQdVqrto6plNEL3p16XOZySzOyJI89IQS+pX6ttOTTzGR3gC1blhuH+81/
	Gofa0LB4crF+YcPQ4/zVNeBXTkOBmva3RBgfha9ERT89wzsVgp1SrjJAlRlINplw6GejJyMbQed
	gcPZNccj8zSt3ybLZ3gMJqzXt/Jzxun15HhhQhNBY+rc7AT6YrHRb2uZph4WeHgpcTpoeJJYnY6
	xSCPz1mjcm6QitFkcUZdGD+Ybcl+Mr8fIuGsAYJj2ECsRxas2AEmcZc0wr/BJjPdHoy7C+WAaAW
	zJSBkZ52g5yEvW063G+PTRuj8EDkTxRg95i04+rRRTtUYcHtP4srg24YGKLe5sF/JJUXmeu2W/2
	8qMObVH8Tf/haxWQDZ0BB7SocI5ilvQOKLdsA7B+TmzCfo5p4o/WrIlThWsuAxiTqjEvHDO+d3x
	CjNDd9d8V5Tna+WSfBb8f9+ks3AogFCYWYtrBK+NT8evS43e00HwCEEWSanhDG+RcGDFqpv4trI
	nX8gBWonus/nw8J1tg93jxypRulJ5Y5DYvqCNWQvQ9+x4VN0uoONA03ewAc6kpSF5ihhrf4GebH
	Tix4hlOMV4gQzvBf
X-Received: by 2002:a17:90a:d44d:b0:39b:5622:d645 with SMTP id 98e67ed59e1d1-3ab3a09d2e0mr7403573a91.0.1791877443959;
        Tue, 13 Oct 2026 00:44:03 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm20552825a91.4.2026.10.13.00.43.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 00:44:03 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Subject: [PATCH v2 2/5] ALSA: virtio: Recover PCM state after a failed start
Date: Tue, 13 Oct 2026 16:43:47 +0900
Message-ID: <9b9b0698d28e1d2b6d3a94f62cfbd97a7e308854.1791877396.git.mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791877396.git.mynameisjune111@gmail.com>
References: <cover.1791877396.git.mynameisjune111@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Capture trigger queues I/O messages before sending PCM_START. If
allocation of the START control message fails, trigger returns an
error with capture I/O messages potentially pending, but without
marking the stream stopped or arming sync_stop. If sending START
fails, trigger also leaves transfers enabled. ALSA does not run the
action undo callback after this trigger failure, so the normal STOP
path cannot be relied on to drain those requests. Retrying START can
then submit the same capture messages again.

Disable transfers and mark the stream stopped after a failed start,
and arm runtime->stop_operating so ALSA invokes sync_stop. Make
sync_stop send RELEASE when the stream is stopped or has pending
I/O, and keep the stream stopped when RELEASE or queue draining
fails. Reject prepare, hw_params, and START retries until a later
sync_stop resolves the outstanding state.

Always cancel elapsed-period work in sync_stop, even when no RELEASE
is needed.

Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
Changes in v2:
- No code or commit-message changes.

 sound/virtio/virtio_pcm_ops.c | 63 +++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index a40ea394bf17..fe8e0dc3eafc 100644
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
@@ -115,7 +124,7 @@ static int virtsnd_pcm_open(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_integer(substream->runtime,
 				      SNDRV_PCM_HW_PARAM_PERIODS);
 
-	vss->stopped = !!virtsnd_pcm_msg_pending_num(vss);
+	vss->stopped |= !!virtsnd_pcm_msg_pending_num(vss);
 	vss->suspended = false;
 
 	/*
@@ -224,6 +233,12 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
 			vss->sid);
 		return -EBADFD;
 	}
+	if (vss->stopped) {
+		dev_err(&vdev->dev, "SID %u: stream release failed\n",
+			vss->sid);
+		substream->runtime->stop_operating = true;
+		return -EBADFD;
+	}
 
 	rc = virtsnd_pcm_dev_set_params(vss, params_buffer_bytes(hw_params),
 					params_period_bytes(hw_params),
@@ -274,6 +289,13 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
 	struct virtio_device *vdev = vss->snd->vdev;
 	struct virtio_snd_msg *msg;
 
+	if (vss->stopped) {
+		dev_err(&vdev->dev, "SID %u: stream release failed\n",
+			vss->sid);
+		substream->runtime->stop_operating = true;
+		return -EBADFD;
+	}
+
 	if (!vss->suspended) {
 		if (virtsnd_pcm_msg_pending_num(vss)) {
 			dev_err(&vdev->dev, "SID %u: invalid I/O queue state\n",
@@ -338,23 +360,32 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
 
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
@@ -393,21 +424,32 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
 	struct virtio_snd *snd = vss->snd;
 	struct virtio_snd_msg *msg;
 	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+	bool need_release;
 	int rc;
 
+	scoped_guard(spinlock_irqsave, &vss->lock) {
+		vss->xfer_enabled = false;
+		need_release = vss->stopped || vss->msg_count;
+	}
 	cancel_work_sync(&vss->elapsed_period);
-
-	if (!vss->stopped)
+	if (!need_release)
 		return 0;
 
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->stopped = true;
+
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
@@ -421,6 +463,7 @@ static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream)
 	if (rc <= 0) {
 		dev_warn(&snd->vdev->dev, "SID %u: failed to flush I/O queue\n",
 			 vss->sid);
+		substream->runtime->stop_operating = true;
 
 		return !rc ? -ETIMEDOUT : rc;
 	}
-- 
2.54.0 (Apple Git-157)

