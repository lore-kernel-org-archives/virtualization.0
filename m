Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180504;
	b=LdvLrzK5YyBm318PiFXhXNxv4+5d3VaJ+Bm8s4mSQVasf5NobnL43eP54yLXb6P9UMbT
	 bOWxktNWH2hC4Qg35Z9dejXLC3KMTSTbHxS0EHR9ZgWJw83L3HTQ4tsCsaajAj/hDMhxp
	 9yOdetBk3wKltkRJqG4ViodbobpNbrWwy+6sfGRF/CuvJFZbl9vtBxmSgWNnKZwHVm6Uz
	 FJj3Q+ldwiHNhqgXq2LlztSHe/cQi0BoiB5dJ51PXwC1upueRbDLaD2lo+jXCF9/iOFQM
	 aq2v7SbKtW2mtgwbZGDs3vCqhYVtuSZX3MjEH5eQUVWBlenKl1+mWr9JBTGitDjrRFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GcN94qJJdoXXjjKHz4VCx6KeOGW9pO5t0VvopK/sL4c=;
	b=1oyJqS+a/ml2cWqjoo8FRj/FQnEf/sTL4zgxGDBatoTSV45t39t+q9ClJMkiFKIzh5pH
	 IhyhNQtYtcOflnb6xK7l5xW690nXZDIvALOPdUm7RpYgY3ja35GPJSNKZbzr7n0+g4ObO
	 ctIqRWnwxscvpPym5hq3JDrQODa8eOfUEnoboFEPINIMzXVDTuwKHdG2FVPmQephPRjKG
	 dT4u+duAHs1UCN8nB0bAsgThlxrQYC1aPRlNrou6/VgtVoDvplQXn9aQ49ptznonnx7+8
	 G8DmSqeTJwABks4FfGHcx37I3ZNXYnHB5j8JSQOUHeSx2CC7JJw16pEMWvYNm8/W11g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QlXYTyqp;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0318606A31C
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0318606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QlXYTyqp
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e987b4a710so8720165ad.1
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180503; x=1793785303; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GcN94qJJdoXXjjKHz4VCx6KeOGW9pO5t0VvopK/sL4c=;
        b=QlXYTyqpVkSUu6rq2crmCCdOPpMStMyv3EE2q6VVueXOH5wLtA1hCArhb2q+ivqq+y
         02J4rWnA3g/d9VNpjTLaeAPxeMhzxeH6mJqbKLRN5B38Rf8MvLhCEqa6PEhO7CAuIGrw
         3CfsLnXg9pb3xZvl1g2oknDNmNmU7BMxzpK1FaRgKek8eJMMqn2F1K+3JX69XjKuIv7w
         PPzvjuPE+MVwot5tsI/Db0JYCC51LuVZUqTEtJ5j0J5Os+p1tyER6t6Ske7tJSZe8KY4
         DQfNZv3mTuAJqJSp/dqwmbH1BEtYZuzgJF7rNR8JSLn1j9LSag3ZT2S4rl2jN8ZbCEWf
         FCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180503; x=1793785303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GcN94qJJdoXXjjKHz4VCx6KeOGW9pO5t0VvopK/sL4c=;
        b=2ymQlT1RlQKP2+dmzFMHQaQbBLgTP+kj6A7Eu5fAVVsP5GYFczKFyGFBc41VS7yq9J
         QSxfo7Q4VjheRlWzhK4IGvHH5oUAenIIO6Ef+1Qz21UYxUX46GgBfetKMYGzcCh22/BB
         E4a576r1VcCa1lv51F/yPQXcMu5sjq/GyK1V0xlYAdEeksUc/BnxdjiHRJrF+N1WXd7f
         /mgIKmnyDaEyR2lPKXkI8eI8KNzO10AQalFhzJnOUE85aReuZwNTxwLMGIxxhXlZxURS
         1zixcph5RNmYkEbozueuj6cbRQpyzwIB58MvH+wS7iEUV50x1oskxcQOJ3IcsUNxMJzM
         rs5w==
X-Forwarded-Encrypted: i=1; AKwUvBxNziO6hAPSm9B5RBdqbLsx1n/uOkr3DLhaZzZ3R5S5UhIN2ozyGsS+SFZIevDX1Eh6S9mTCep/jyLo0CuxXw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIRGuavkYFs2FoC/aSwW3AnOdhzYxNXQEpdELKH4cInlwva0LTm
	Ygl7tb95XNkVVcpcpswtxvBRhzgNdLZlEUxRQ4pM1EFI8ac3L7N3NNFh
X-Gm-Gg: AYBFou2VWRaFiIIiuE9Peu70WUlXV8ItHIKoGIBxwua+sUl7DxRCqEZfCLxedvrccD7
	vZkqA1r8hFsimqx0PXIP0jN6aFB12LznKOU1FgcwsXC1tBrdG95X6bszKDjaszHnTnbpDjyCp9a
	EwNM20mTXozsT9qwwx2Bp7S1w9RT0rudG6WqY7ZACwR+hqHepC/L9CZpftoAFTxMalw3Xfa02DD
	Ihbzg3v/OiCOtM5JMahpVudIieVpyvdKJAmpMyr76TfTbi81r0mzxUTqDKxWD2XbgGEsa21xsPs
	+pWgJ+V8YpPC9B1eVnqWJV4tQYpkktRLA0MUiismCOA5LZ7UvLjw7tNPfrJ+/7bbMaoy6LNspGO
	CKhMwH7xaxPYIKMBUmVCA2fbSSGr+zqabElMfRT3vCSeap1ecGLwMgzbg6SovMowRevUn1kzhbj
	Z8T18XqjX5Bb7KBC//fEk0XGTcK74i7KGAU5/CTqPrsUW+CEodUaemc35+X/JFqLqTHAkf/mQB0
	/hQFoHXyRstz2a2+WXX9NmuzAa/xQ8O/VYhD2+WKpcDEggJsT386SR78pHr2y0V88vMj1KGKtJH
	uTsxwFWgfsersuoaaofVhecbCzWxpaYALWVdyfcDCKqLTa11CNMJU92w8tiFqReHvs+vpJ4Ufnq
	2tgpRfEnGd+hIQEV1NII94E/PiG/z/ZbYkJGf/lW4YvUvJBc=
X-Received: by 2002:a17:90b:3951:b0:3a2:bb9f:f87d with SMTP id 98e67ed59e1d1-3ae5c84f507mr566488a91.21.1793180503102;
        Wed, 28 Oct 2026 02:41:43 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a93b3f5sm2242377a91.5.2026.10.28.02.41.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 02:41:42 -0700 (PDT)
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
Subject: [PATCH v7 01/16] ALSA: virtio: Propagate PCM send failures through ACK
Date: Wed, 28 Oct 2026 18:41:17 +0900
Message-ID: <20261028094132.20364-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028094132.20364-1-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
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

