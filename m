Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A83A0B24
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877442; cv=none; b=gPVfOp8BdEIeBiAUahcWHCGMsw/oKeJjSy3J5GToVTk3ojts0sCS2C1LYpxGhD4PmilXeI+x+TkcqjqjYCkj4rH0XXM3ipOsj3KLAQA+7LqDREDuhe4/UkEcML3ywjN0FCHqBzI3xI15BOtVwWnhphpE9814u0AKPVk87N0jNSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877442; c=relaxed/simple;
	bh=pwNblbWrm5OD5TA5me6F3/LOLUd0mFmzYtucFfkbMXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWhoicKyoR0BKCtm/vLOlfoGi5RcN9bcifqhdIM8KG94Kz8mDrInFgh+QAJL9Agrp6yF1N87+d40D/Rq07mHX2WJQ+vk0DqnRQ82kq3q2ZlVJiXb6oj/pihlqv5E/bCTnceJWHUIAcvXVLza1R+MMn39RJQ69TRdGFjD7X7bqc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLpWwZ0P; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLpWwZ0P"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab98332238so1293587a91.3
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 00:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791877439; x=1792482239; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A4Nga1IEEBSo5687TyetgrCo6afRO5bkl3ZzOjXmUS4=;
        b=jLpWwZ0P2ItyxnOv0VKj5JAeFk93+DtjinVbirOsr0Tm4WbzKJjIXLEfE1V+eodvgC
         4n0qT433uiAdrtaKs++9hmmpfAEZr7ASkoi5LV7XbiKcs/XlYGoK8/rZmaiyXdf+QAmI
         UUtrgzGiUVE1SZK0W7YCzm1S1VV5GboZYw2MVYCn1LDWNRks0qpgNWbxFAHQFyLsX50R
         TGwTYSKs28cmXAQUJXMhwonRfA2Hx3u3KRt3pb49Cvj5+F6qa/9aZn5go686fmrZa4n3
         kds41pyIc10ZqGuo9SWS1X6dwv0SydeyR+iTWQSKPuyenc9ZROCkIg03Gfc7B6zc1kBD
         B1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791877439; x=1792482239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A4Nga1IEEBSo5687TyetgrCo6afRO5bkl3ZzOjXmUS4=;
        b=usY231psfxuiBss7wSP++SKNPqxL6vHeLDV/Ep/ohKXSAeAXg9U94dTqslrS+dfNpZ
         O8cz23lvTAT48XcUin6nj4PIzqnM+MctsBQT39FP8CCgnowCi1iqgQk0FJwKoUefdqAV
         KGFsDxSAteeT+TDs4ZRC3TNvnUIUxP/Zipuk592he+SqlVxmS9cDYV5Azxhq7Bwe1W6L
         G98VeAT6xqYjSAf02cxQPQzhOtpz+qevuybbuHltQbVpTRhx0SHYNQyQQDwenNRYCCEr
         T6/6VcEKSad3W05BLIzB3w/iqHwE6A0VlHhXgRnA3oUEdgW0X3gLea6a+zIkI6EgOjsj
         HPqw==
X-Forwarded-Encrypted: i=1; AKwUvBzWoeg+xf1LDxbuY1iNBytwjjvuZ8pn/1DbIFea/OeeYM3YtqusWNjTzPqeVLenLP2lAP2FVQgP3aCRJe4z0Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLDfdzHbVj+cFBIEado+xb38HcQO9EfQkMha61Xx4dpW3j/pyGf
	o4bHZpt5j43H2HZbg6Bfy4SNON8CbcrtcXcGro/FUqB4RN6PfhoxQ/io
X-Gm-Gg: AYBFou3padBwADu5QgIoj8IV4Zgn5bBfBRMJl3zEMscB4vL7V7UD3G566NIbhil4qtF
	OakkqK0EFuKDnt2hbBx6sfp1EQRsMoC+41eI8iOzQje4+ojqyUxdbbxmIhYYvLi4UHOhTG9jvpu
	jJA4bXNfBIOFObK8rrylcsv5aJUdp7V1ZKJYiNdG8Gt6pVQCnfb9aMvsbbD72ck2mfc0cPfBFmU
	1w0d01FdgDo3vESVlPY5M/TM1T4n7dQCItg7gcvo2H8NnNBxLb3OroHent9B6230xFIJM1YzR4i
	SyEo7oLj2qiVAsFeKrzn+DFd7ji75xTdwkkclpBkI7OBS1Ebc3sDENTLVNlzrkHVW3Dv4cKhw1H
	Hi0cHQBbsd8QfrhLMh8lIg14Xq+lyFYjTQmKtS4XdmgGZyIZtM8IE2OVhDrPv6zRTpMkM7z+4dS
	UGwVpnhVJ1w5gyB17xoK59NM/N4aitEDfz8AErgtTLV4tQYI2Q9kJOG672uKR+0EZXPRAZECxxp
	F+lOWV8tsQ02cPEU72Onk40XbCiP2oWk/Lur6bx6Ntlaj+MuV0JA+a3wDFipuCHATs5FkOnQ8bd
	VVomJayQAOMIOJ8Nkw==
X-Received: by 2002:a17:90b:224e:b0:3a8:9db2:a4f with SMTP id 98e67ed59e1d1-3ab3af75ac1mr8829588a91.51.1791877439448;
        Tue, 13 Oct 2026 00:43:59 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm20552825a91.4.2026.10.13.00.43.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 00:43:59 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Subject: [PATCH v2 1/5] ALSA: virtio: Propagate PCM send failures through ACK
Date: Tue, 13 Oct 2026 16:43:46 +0900
Message-ID: <d6c405ed4ac3412b376e5c2fee70cd66703f921c.1791877396.git.mynameisjune111@gmail.com>
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
Changes in v2:
- Propagate send errors through ACK, retain indirect state only on
  success, and stop the stream before an out-of-sync retry.

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

