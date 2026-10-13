Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61942DF3EA
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 05:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869444; cv=none; b=AYzZyzI8W3HyhsQVFHDHv95qJ5UxKbACLOn6izH0vB19JvzmwQLcBbTWWIPCPtcKn/pTiIe8ByckxkkBgSc3c+GR6y7EddPt69ODHtKT+XPdwQQRLQFceMmUE8k3SAstDm1La46hB2pHVroVQvEVIn+mA/uN6QAZocCRJ54/HsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869444; c=relaxed/simple;
	bh=q3nEYlWrGMesNp2ijmu5al21Kx2H94q3NPm6x8zhFDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMnCu8nyxGJrq5LJRqADUZ4uUs+9UDAk31wuUCqp/S7ra1F0ftbVQPnfXhZ+/Zhox9PUAIPkgpVP2Ct0vwSMttab+QEGUo3/x80swdnYz+rL8mVl1f8HkeM4odGKQayIowRmjmCcFTDcx8i3JUJIVf43DOQ4w9IpNhTaYkDC6Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4P01E+8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4P01E+8"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8b20a899fso8164795ad.1
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 22:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791869440; x=1792474240; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZ+PQK4JXB0NEmhfXifpRZfnQrbnZ5qKFhfS05wV4xM=;
        b=U4P01E+8phZRQW6W4c/ISo0tw9yvp6dRky/n1G/q4K+VvjRxFXCDgY2Gvnmvgbku2w
         v/7fuW6bVMM4BVUSMFz+/b6ISMXeSQfqBwFQX/awAxVBksqJkBm1dxzUX+CtgArUDPzA
         uyfdLwH7l2QWjMa4rcLbneDLF7TH8R7VWQPA4b6MDJjGsp1nsfz2DcHJ3oOtrRqS+oZN
         bPKNh0ksheoptbrk9ea1nXhSknCtK0Gy7Eoj/FhaWHX+PsXmlLhWzcWbNjbjDY/gM31A
         55dTdCXSGh0NWLsnzX03E22TzmFCBnQoSUjnsO8aRIdofiWrZlVHTHEzkPdCiEoCcyTH
         q1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791869440; x=1792474240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZ+PQK4JXB0NEmhfXifpRZfnQrbnZ5qKFhfS05wV4xM=;
        b=MIf5p8fio5qUkeniiSqwKhbOvvRA+Zt4m0wsJE7yPwN7MbXoab0BTrlmrGtWZiTZKh
         OJy5dpsKpt9WLq3zyyxE/paQlAMmy/5J2WuhxhzNPm9sqDgSrZLy7mDtcGt9iGqjhosp
         rMPoIPSNDfhGxLhuTI49zZzMhBtarwZ6NTcgA/ggOMBa2MEJYhmxeZ3vg/uBj8FeG7Lf
         i77JJbO3meHUoBTAM3ZWY1em3fvxtmWLCDf3/kGRSsxchpRR9oPfB+Tt2ZPbvJAdvaUb
         tB77dmSWlT7gHwRAdJW7XRv2dzhmuje3XbVcFmPIDUZPprF7+uiExbD4mlElLE2HI6NQ
         6PHQ==
X-Forwarded-Encrypted: i=1; AKwUvBy636qRQtc/+G59Osj+DUTuLVXcQDmsujdeBuuLVHfMCOKmackp6ULVXh4ZQWDn/o0Z5/oS35LmKQBd0/4wpw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKm7e7L1ZMObRVh6deGQy1K8qLVsvrOQK2vj1ssBqCxE38FDv5w
	r0st4JDUGvjzoyo/FMoMeYvE6dVea6MS7zm7WcHEheBRUkuBVOl7fRUb
X-Gm-Gg: AYBFou1ppLtmYpSNp83R2YvEQvOCGzfCw7h82QrXCNokExfJNGEUMT1ESy8BGx5XRzQ
	DgJRqlo+8RjtFSlao34K+/mjDB07o5kTucS4WveXmIUOYQIWftsGbWHxx+kfibeata17fxQN2qR
	aGVskw6MSqZlhL3M3wD1jzSQWUMM6y2poHTcWinPvDeoXOlw8y/FMKJJIBzwOAY9mLLjeTdBYkW
	/hz0vN62uRDIfvNb3z+Z1xXQxEwLmCxDnzyKyOVvddvqBXitzndyesGgPmVqYXXpIto70HmN37+
	mg5W5KGaC+iQnq8AveN2dGbyv/jDnXF/w2zR/WlrbZCclCVPu7XecANBQx0m23nyo0YVMv90Hmi
	XVaMwKmpFiZB0k+6MxuTmxwUb/0PT7AN3NP7fPqg6GcWeTm/NjZRYIpd6EXz9p1D+ANdWvLgs0m
	xP3Z2P/qvrEWyX1ZMo5hE7WaCdjph//ZT6O8JCTGTEOTZ2DqPBxQ1MDzyWDXCx+v1vFGZzMlO3q
	fWApwXYvaB4zXFBVMlTkV5o6VyWC4zN4ZE5gGTXCVubG/+jswN0vnvO1EVXJWXmZDcEpqU0THCT
	3AEr9m9vTHST6YONwfDqezQQJg4=
X-Received: by 2002:a17:902:f54f:b0:2dd:c100:b2c3 with SMTP id d9443c01a7336-2e842ce0ad9mr91612705ad.46.1791869440083;
        Mon, 12 Oct 2026 22:30:40 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cb6sm50820915ad.60.2026.10.12.22.30.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 22:30:39 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Takashi Iwai <tiwai@suse.com>
Cc: Joonho Lee <mynameisjune111@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] ALSA: virtio: Recover PCM state after a failed start
Date: Tue, 13 Oct 2026 14:30:23 +0900
Message-ID: <5f0fd9cf601921d24f07df051f990283e571607c.1791867377.git.mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791867377.git.mynameisjune111@gmail.com>
References: <cover.1791867377.git.mynameisjune111@gmail.com>
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
Dependency: patch 1 notifies capture messages successfully queued before
a later enqueue fails, so this error path can drain them via sync_stop.

Validation: source-extracted ASan/UBSan START allocation/send failures,
retry gating and sync_stop recovery; included in the W=1 builds through
patches 3 and 5. This commit was not separately kernel-built.

 sound/virtio/virtio_pcm_ops.c | 63 +++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 1091100a4c98..f2362f0dd80a 100644
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

