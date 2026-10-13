Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B7B3B9D8C
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881881; cv=none; b=NO8sueTeB2ogp+KW6ECaT3pkJBB0aMFoxs5oawFdpsh4Uui9inxfS4zkVZhJ5N4ztcsmSG5IO38lULvyP5CdQllVw9wFC+zMv/YgYJg/02BvJJcdG6dZhSvEJUCLLJ/Izi2TKMGhxPXjCbx3vUay60v53QD5HI2sSWo1OusMXEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881881; c=relaxed/simple;
	bh=opQnPFPZQ6VQRgXi04A6G5jYc/ZSjw+034MhtLu7seA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDcMeVkUiJfPbe+j4wEyBL1o/zzLxLAj/j78r8J+BL6KmOXdKS2sz7Sms+22ni/KRsNMUOKyX7fWqG1p/mSzdVQ3CPz8tEKzM59wcBbHSOLdDDU1mz/Qn81MO1r0Ha/CKLv9box84vXkSseoi1TDpkTX/EaQYZrnvAAUfJhDaIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seQ96yG1; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seQ96yG1"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso839000a12.0
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 01:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791881880; x=1792486680; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GcN94qJJdoXXjjKHz4VCx6KeOGW9pO5t0VvopK/sL4c=;
        b=seQ96yG1XkkPIbtvtw4WJI7Qvu+ALd5oQhZ61BP1WnE1ZLp1u03dYIEJI6xZsfpOjN
         mNctJ2uELyIXPRVzYNFLHJatKRRCHEcbw/BZnq/2XdJKGxAdt6FTJia5PTsNf7P8Arj6
         tkhekAkfD1VRqwnaLJmb0DXNBerUk5hIn/KHuJIKMQoTRRnFvg+uIay//c/H7Wfvppo3
         VMMATz+5LQ9rX2YWgq31z0A3XBHZJLTYKR9Zh3Sqp2RjT5uuK9sWZexxvWQHOXKADej1
         VFlA1lkROqcLcJ9b+S45GaCz6YDjU1IipHGe1SwgXxPbnbuhcb12BR6AcEXpQgWNw5hc
         aDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881880; x=1792486680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GcN94qJJdoXXjjKHz4VCx6KeOGW9pO5t0VvopK/sL4c=;
        b=D4KUaLzAd0GFrVTh2oXWsTmJL3b1ffaHa7NdhOZ9xfgGFXgKIzw1GLyFyw0lxhgGUA
         dC83V7zeyg535nvHVr9CSmhl97njNNy27vCbjXLIYESqHvTqVl2c68h2a1Kkd0IPwTI+
         b3nfFEp2X251aMlxwRBc0yFH33rdRL78diOsMrUiebAhLVs5+OTAFOHt8EnWrcncmpdJ
         EaZjOoB+2Gw+7DoOLweH6pR3ZYufsgygtYg56TSpMYhUgBYSxmf02+hekkVd9qlyye0B
         vDJUKhhggYPKDDttY3Cxy8epvef6F6eVfnMpR6HAzgUN5cI7qnxcwUvAeEsuexThYriq
         x8tQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNo56Md1wGQGiowTSkq+YoXOkeE+Vb6AKU3XzPxpg722FVtOvdzmegeT/06EKkh1Ujl+67C2cGNBv18B1Wag==@lists.linux.dev
X-Gm-Message-State: AFq9FYIjpU4SZBQX6oJBRrdLTP9SyucD/GnxgFvSVJd6b+ytPU7I6OQL
	/i3KWWacUptA4nxrqvou67Di2KGt5Fw5+xrYsJgDogwbGs4rkHeKH47c
X-Gm-Gg: AYBFou2zdReQ+IFjbvBhAl+UClZrXyiBKFLrMQpovyQT4bQqogulwrlJN1J9+LNFpke
	/1MURH70OAzrN1xs/tp2BDPxPNSbjIsraocqdzJwVJQNmTw88H+J2K/NjkwT2j/DYWOXw6xCZ6p
	jPBJEmSLpY0aTquoaDpUzCttbAUhSKeApLBRX2LcRMAqn1chJlhq7NbHuPuUO53sFaeTaPnYcZX
	n4jgxrBGE6vdni0IdTNj1J7EtF+dlmfByEQGPHKvVqX3wK3eWqzU0DRbJHnR7LYCR7aozz4GO1s
	WVoP1whlhGL5aCeKmMsCi/ehkXeuPay9+yyxEB/u3c5yE+jo0P3a2NR0UAJ8osAL2abO7EV4gwe
	3ayEWdO9hJlMZ2nvkLHWeP413wkADokzlcRrx4yIoopgA6/1SUGYhliXtNfhcRO5Lgtxbnnjufs
	p5YDWUBgnXnQrWJvyO6sFwe14sxHYiO5we7yzquMeyfA88PMEUfH9qy8vtOMYoV78moCQ6OFLNN
	iDC/igPw9Mab39cLPSTwgZf7xE9UIqN7z3Ne4NXiNz6oJlUydjqtnRHwrwUj4pxgNB1hWfKQ5dK
	X12/c9IungKdKuZ7
X-Received: by 2002:a17:90b:4fcd:b0:3a1:8b70:d46b with SMTP id 98e67ed59e1d1-3ab3ad2b1damr9231104a91.42.1791881879490;
        Tue, 13 Oct 2026 01:57:59 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6063d31dcsm1838592a12.3.2026.10.13.01.57.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 01:57:59 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>
Subject: [PATCH v3 1/5] ALSA: virtio: Propagate PCM send failures through ACK
Date: Tue, 13 Oct 2026 17:57:48 +0900
Message-ID: <0a3846bb4f8742287f9c2024aec22faf0c35defa.1791881787.git.mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791881787.git.mynameisjune111@gmail.com>
References: <cover.1791881787.git.mynameisjune111@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtsnd_pcm_msg_send() can fail while queueing a transfer. Restore the
failed message's length and notify the device about earlier messages
queued by the same call, so they do not remain stranded.

Propagate that failure through the indirect PCM transfer callback instead
of discarding it. Commit the updated indirect state only after successful
submission and stop further transfers when a send fails. Return an XRUN
error to ALSA so the stream can recover.

Keep the polling feature path unchanged.

Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
Changes in v3:
- No code or commit-message changes from v2.

 sound/virtio/virtio_pcm_msg.c | 12 +++++
 sound/virtio/virtio_pcm_ops.c | 82 +++++++++++++++++++++++++++++++----
 2 files changed, 85 insertions(+), 9 deletions(-)

diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index 72103f606716..5371f4985fd0 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -260,6 +260,18 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
 				dev_err(&vdev->dev,
 					"SID %u: failed to send I/O message\n",
 					vss->sid);
+				msg->length -= n;
+
+				/*
+				 * Do not leave earlier messages queued without notifying
+				 * the device when a later message could not be added.
+				 */
+				if (msg_count != vss->msg_count &&
+				    !(vss->features &
+				      (1U << VIRTIO_SND_PCM_F_MSG_POLLING)) &&
+				    virtqueue_kick_prepare(vqueue))
+					virtqueue_notify(vqueue);
+
 				return rc;
 			}
 
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 1091100a4c98..a40ea394bf17 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -466,36 +466,100 @@ virtsnd_pcm_cp_pointer(struct snd_pcm_substream *substream)
 		vss->hw_ptr);
 }
 
+struct virtsnd_pcm_transfer {
+	struct snd_pcm_indirect indirect;
+	int error;
+};
+
 static void virtsnd_pcm_trans_copy(struct snd_pcm_substream *substream,
 				   struct snd_pcm_indirect *rec, size_t bytes)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct virtsnd_pcm_transfer *transfer =
+		container_of(rec, struct virtsnd_pcm_transfer, indirect);
+
+	if (transfer->error)
+		return;
 
-	virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
+	transfer->error = virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
+}
+
+/* Caller holds vss->lock. */
+static void virtsnd_pcm_transfer_failed(struct virtio_pcm_substream *vss)
+{
+	vss->xfer_enabled = false;
+	vss->stopped = true;
+	vss->substream->runtime->stop_operating = true;
 }
 
 static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	struct virtsnd_pcm_transfer transfer = {};
+	int rc;
 
-	guard(spinlock_irqsave)(&queue->lock);
-	guard(spinlock)(&vss->lock);
+	scoped_guard(spinlock_irqsave, &queue->lock) {
+		guard(spinlock)(&vss->lock);
+		transfer.indirect = vss->pcm_indirect;
+		if (vss->stopped) {
+			rc = -EPIPE;
+		} else {
+			rc = snd_pcm_indirect_playback_transfer(substream,
+								&transfer.indirect,
+								virtsnd_pcm_trans_copy);
+		}
+		if (!rc)
+			rc = transfer.error;
+		if (rc)
+			virtsnd_pcm_transfer_failed(vss);
+		else
+			vss->pcm_indirect = transfer.indirect;
+	}
+	if (rc) {
+		dev_err(&vss->snd->vdev->dev,
+			"SID %u: playback ACK transfer failed: %d\n",
+			vss->sid, rc);
+		/* ALSA treats -EPIPE as an XRUN in ACK and pointer paths. */
+		return -EPIPE;
+	}
 
-	return snd_pcm_indirect_playback_transfer(substream, &vss->pcm_indirect,
-						  virtsnd_pcm_trans_copy);
+	return 0;
 }
 
 static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	struct virtsnd_pcm_transfer transfer = {};
+	int rc;
 
-	guard(spinlock_irqsave)(&queue->lock);
-	guard(spinlock)(&vss->lock);
+	scoped_guard(spinlock_irqsave, &queue->lock) {
+		guard(spinlock)(&vss->lock);
+		transfer.indirect = vss->pcm_indirect;
+		if (vss->stopped) {
+			rc = -EPIPE;
+		} else {
+			rc = snd_pcm_indirect_capture_transfer(substream,
+							       &transfer.indirect,
+							       virtsnd_pcm_trans_copy);
+		}
+		if (!rc)
+			rc = transfer.error;
+		if (rc)
+			virtsnd_pcm_transfer_failed(vss);
+		else
+			vss->pcm_indirect = transfer.indirect;
+	}
+	if (rc) {
+		dev_err(&vss->snd->vdev->dev,
+			"SID %u: capture ACK transfer failed: %d\n",
+			vss->sid, rc);
+		/* ALSA treats -EPIPE as an XRUN in ACK and pointer paths. */
+		return -EPIPE;
+	}
 
-	return snd_pcm_indirect_capture_transfer(substream, &vss->pcm_indirect,
-						 virtsnd_pcm_trans_copy);
+	return 0;
 }
 
 /* PCM substream operators map. */
-- 
2.54.0 (Apple Git-157)

