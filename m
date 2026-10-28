Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156006;
	b=WIePc9zOkDMGjTIDz7W4ho2571WJBueqUJ/wX+qRFTK2dcYhc8pHPSFyKmyGWdxPflkf
	 efxbM8Wtw1pyA4sM8i2gFo/ZjYcoqH1kUbCHibAXAyBuQiVGWzGv97KfZB7wf749h/TWI
	 vWGh0wJ1zQ95ufOvXgPoaVj1X8ca4ygkfEeLtZPzoKn1rJCkCAGhzlc2jCCH51bRzUqDm
	 Z5xGT8BNyAUWFoc+xU6gRigFOJL/U3O/I60doE2ORKl3/1QZhodjV/n0M1ixbWU+FxeBg
	 Xrz+pz3HDzEDU1wKLioF5a9pQc9QrhiUwiESOGJx1QTHScHEOA7oJyI9qGcMW6s3ZBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GcN94qJJdoXXjjKHz4VCx6KeOGW9pO5t0VvopK/sL4c=;
	b=ff35n5eERYAXNtUWYOsbmrZ85OVdWmE5L4FFZBbv//9oHsGs4IET8Euvy2xCN+6w//uX
	 4zlqfW+fzWH85MPkArLmbr2yJBtEblL9zP0TC+FWyUJWXx8IjfHNQHNP0hMGVlLs8pAt+
	 e6oGzoj9MYgH3KcS6acVWKxMyp9rM/uYiUy7MQFSAW4STExGedYbx+k+z3DhoiMLlaN5m
	 zIswSpKaQUiwRkdBe3sqtLR1hat7W9vVu1A3c+zzG+ef6LIFa16mBXA0MDEgSSNkSmm4L
	 TKA/0tmnIm5vbJ5/u87d5r4F3LagavqTV3J+bblGV0jOLzzD+pMXhrQTqKFbBwzrU7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ohnBoVLM;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502A2606A32E
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 502A2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ohnBoVLM
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-369f33df08eso974888eec.0
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 19:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156005; x=1793760805; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GcN94qJJdoXXjjKHz4VCx6KeOGW9pO5t0VvopK/sL4c=;
        b=ohnBoVLM+7B/919T4udqZZFq/z/jWQKdJH7NfoPqjRMJLTA44MvBssCZd9G7XSg1pP
         cII/C9Uy14hps5R0/+LD0rLEH3Hge1YT1Z9Awyt6+gGfvzwzeIYcyp8w3SfMdrju2lot
         vaHHq2kcX4WHK4Q2pYPvFF+x3h2Sw6nmfMpUyhuDcqDrBWWkDPHmCsKwOA33bnLTEk7I
         VzwnB5mApBWm6ihjgaWsbBcG807U6s3uqInwFnHiT3gK2MIoB0uT7a+BfsyL2l+kKGbl
         PRdRoINrdN0tlia+BIidp7F7KmmfcZCHJ0CIhsgp2UQL8T8diJiuKxlYLEO8EEPVVwBm
         t5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156005; x=1793760805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GcN94qJJdoXXjjKHz4VCx6KeOGW9pO5t0VvopK/sL4c=;
        b=F/ZoTrEN1kDN8CZ8ycWDoAkYT99JfNa9FEkeQoM7uekWNdDVGDDrWqTu3gIS/6eYZa
         58OIbbnccKHOOApZ20W3HRZeLONn62i6kq1Iw66pGmEQzh1OLpCy8/d6DjRv8fDjk8CV
         0Htkab/s6NWLtNEQh1/rD6pZARFtsJnDuhktlhKL9zf18DXLKY9lELPM73zGz+tilu+f
         dgNkEqG/EXKPGqSPWXaxJtCS6pNX937ufSmNgX0395S/iT1RVS25S1KzesUE2r6WVnoo
         igxYBIUTyx0b3Zlg5j4br/TjIlWSud3gmAMpd7D2p8X7cQRXxYdm0gMh6yZ+ysrDIb//
         O/RQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWbmQ18TJU/wjIdypwN/uFsBdmkySsiIiyp76gTwNZQp4d8vKqJ6/iQDROZmhzAfiHJ9UjW8i9PMFG8U1oPw==@lists.linux.dev
X-Gm-Message-State: AFq9FYL+BQSAPTTH/OJ07PIsq4x4sfSvqFi4VM36nO6rvjKCcv2PsR7F
	HhL+50SfyAH+DKJ7//u+1IIo4X1W007nYAyNXhZK+ktirQOgXOihIaZY
X-Gm-Gg: AYBFou0KH7OCTGCScLKr/AqkFVenur/sdG8BWh7WLmfhIMVhQKXdt80K/PMSuVjnzCP
	8Vnhy6RQwqFURlHfSOxR81GDw3jB8A7I++0XU/jPSbSGPWv+fg1K8coZSmEg/+dw+WpfxNa9omO
	KTMs5nHomlV9TmDc2o3y1hcAXaK7B7y0gUqR5iHy21cvy18iDVKlhjks9oInrBKR1lhRlPXZc+n
	uAD3RF+gIKlWGtvERrPT/aW2OJArH/23rZQC+VZMY3pQDZ5G9TIK0GqUK6fGksHm2o620ZE0njp
	FbweqR/W1mgXZte1RBJOrMV4vIQXLBqzL6OdZEcBp03dlshoyICXZvNS8VgK5bKB7b59EYhkkAk
	uid/2FZSGzwG6FQZCHliKicZjWfKARMLFr+Df2XpVDVvMdSKhGUwVg6+nF+BnPhWuzxMR4Gfyge
	Q7ANn0nhpP0GD7VCnG2WSziG/V43GrhW6zd1fe2oaML6ZFGQ2jJHwCQtp3NsZdQN8S6A7zOB1PA
	Zq2V1fJJxgz4SJyAbPdq65DHkzHt8K2ZxiJS2/XNLU1BjjYeCGdl7jCvdkyewtgzSpIkRi9IXob
	z9vdmtO85Q3KleE6PNmNMX2lO8nAp5PRX5o6JkkJ7t/2kUE+9V746BfsP2I7dCrSNb4qasLqzO1
	e267ga27scMykPgenViOvPKJBpe2lZSmvD7ke1Ile7dMAdnk=
X-Received: by 2002:a05:7301:7c12:b0:35c:ba31:6fef with SMTP id 5a478bee46e88-36a2016c61dmr2701937eec.36.1793156005254;
        Tue, 27 Oct 2026 19:53:25 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239644efsm1711914eec.23.2026.10.27.19.53.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 19:53:24 -0700 (PDT)
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
Subject: [PATCH v6 01/14] ALSA: virtio: Propagate PCM send failures through ACK
Date: Wed, 28 Oct 2026 11:53:04 +0900
Message-ID: <20261028025317.92450-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028025317.92450-1-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
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

