Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144627;
	b=ycomnGQZLpqoaqNESxRCybtQujO1G2xy7CoghwXTCx21WcERI82CvS7bhAa2h6MiN88X
	 PAorRNKviA7qf83tBSLbsmCcGwKjf0/DKNdpjIHI2lqEmVFv/GbOSDxZqEam7wfFnSsZp
	 Iy6d4qhUgZbAAF4WFTbRdIsquy67cutrtr38a8zAgsK7jp5NLE0JEZDtAr5wyDaep5a+u
	 GCTKEmmEGV1ni+rfiI7+Q2uTyOYMSkhXxMKGzwkSEpnKKanNpXE6tY21Wh+BazfvFbbi7
	 PqgDYPS9MmTqaEcJijwNdTccIGFhPn8/fG/etgvf3YKPFq/UbSa11H9n7OiJd+7kLPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GcN94qJJdoXXjjKHz4VCx6KeOGW9pO5t0VvopK/sL4c=;
	b=4fwFjd4wwkPfFgKWdOun6WwNls5aGT99+Lr+CwHk4jDUcGIqg/GRz8MzMj1t1sb7yVeS
	 FXHGSnYZX2e7Z5twnjFo+P+0gNc+xxMBVd0pn60fqMmmBPeByEcUz6u5rbsE20Bf4ckeC
	 Km9KvdCnSGzKpvRc3BSYK6463tzXXXRlypCFC63AZkdpbwWCwVijj3N6Zm6CeAraGSbBF
	 3J+KNQh7sJ7X/9xBPyIaJW6ClHMpCylZXGf43sZRtmsSbWzPkrRGTOJvI/BF0MzO9IwMA
	 /rEnA1sqNbFE5DWbFko3BK+xayXhKRaJ5EQTJ5T5J6FHClohH+71AhurHzWKQlywm+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbsrloU1;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D86606A31A
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 23:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72D86606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbsrloU1
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a06b27bf9bso223113b3a.2
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 16:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793144627; x=1793749427; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GcN94qJJdoXXjjKHz4VCx6KeOGW9pO5t0VvopK/sL4c=;
        b=YbsrloU1UbqMJleBNViT3/yB+2GxreSw3R7oUuLGgzivnKbN9AdS82UQsjOrG8JyLO
         gTNMU+8+0T7NZSVf4xmdKiaVZ8aEz2MOClDyKdbs0Cx1nMBmPhhb9srAYWUvgEcqz2C3
         qox7GppXm9vHNyr68CR9Eo+4p0HaWEV8pj65+4ImXeeKQKQplSJhg8eMNQ+VJn7vCwOL
         +co8uXJIqFwJELntN9YUEv9lSTDUt0q85a8swAlxF+hRuPmw7/0FNU8paZ76hTGnEMUa
         k43zE6Juy/nPCHEG5GipYnXas5UdGnEd85LVGZMOb4MTVguHKmjSr57gM7pPTjE/aaTm
         tjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793144627; x=1793749427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GcN94qJJdoXXjjKHz4VCx6KeOGW9pO5t0VvopK/sL4c=;
        b=UpzaBh/He4Wt/oJvCiClcsg/PT/VTaB+B077f/iS4NRKRZ/JsC0kyxRO5OQqjIhpDM
         JHbBreC5snvcgJ2KMmS2GI1Ti2wSYHECp+9x8K5CcBbuPInsw26LjSIc7uP6zNmcPzis
         lfZWwYP0Chw+sUd8MErLGmOkTzuSmDzAewbhZNSJ3HkxEG9rgbruDk3+MeWORtKwE4G6
         TYuzp5lCGT/Hn8xIgOLfpd7fNOxwk15BbbWuL8jqiBwe9Jj+HeCYCfDhSG9lJClAZ844
         /eAy7cqDH9JnKbpDJUzoBKZPiIqq1rAgi/gepV/khah0vhpxP5eOD2terv6tv7POZ3R+
         /yXA==
X-Forwarded-Encrypted: i=1; AKwUvBz6NsvtEO4EVCU7wUXR5tu6wz8rYeo8y6QGvSLTVLc6nxU40GH89J6t9vpc4BHVJNxOt1GSIVV4mM47shVktQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJewbqie6WR5H7TWuN/2hVYeccasloMaa4DRK3R9vdOjxQaNbzp
	hnSJIYzZb8yrSW9ZApf5jb4IA4mmPGZaPmGgkZplnXvlyLajLtflwpvY
X-Gm-Gg: AYBFou0KwMss29CT/UW1HAZcl7tQHDNNdn6hhp3gkaeznRWcb3B9AZ1ElHTCFmLl5V6
	HRSxCEdxCvKeQ0stuEV+JLquUM1i/Mjwr9WXJWFVhEo4sIOGfDoLMjfoZmli4noTVinknziFCHI
	Kagu906RBcMgbDWC1BwpGElA2zwzqoqEzR25FWC3hsJWoUKfkkaor8v6OcyxuoIauCpTZ8u7JSt
	ISK4Ic97PbxaQ/YtXF6wvJHeEAXhCUJTKtPgo7c7zL8VXRGuKRjPXByDMNZvLUcg7dDViiVs074
	bnXaEF3R45imYeWwfjsKpCluAG5NIvFdd6rGSvsl7Oxu9EqzPSD/PYFUjqSNbXHbsVpeGXFqv37
	oUmMZm6sm2Q60bhNoMWaoKmEnpPAdBIDhme+xN6RVowbXUvJ1tshgrlecKN+AiTas0p9amdvNd+
	PSHMVDR6GrOAPD3eFA9cLCKB1tERi3+wdhqWHmVvGbadydCW8AdZlGGFhh4ewaTnqWLyZaFVA+2
	aR4AW9u1UArWO9Un+FDBuGggdlHVeW18tEQ3+WSyMdIKoyoRZvqKMx+EWvbIGxAhIRTb4b5GGdw
	dLpdfzpe7tl5QPzInLzTKZbrK7rVh4yE2432pk1G2Tl1TlDrNLyEKSmMuX+/XvHLpjgrUs/Lgxg
	=
X-Received: by 2002:a05:6a00:92aa:b0:893:4941:4706 with SMTP id d2e1a72fcca58-8a6e7bc7575mr511399b3a.42.1793144626754;
        Tue, 27 Oct 2026 16:43:46 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662b9f5sm542507b3a.21.2026.10.27.16.43.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 16:43:45 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v5 01/11] ALSA: virtio: Propagate PCM send failures through ACK
Date: Wed, 28 Oct 2026 08:43:24 +0900
Message-ID: <20261027234334.32551-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027234334.32551-1-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
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

