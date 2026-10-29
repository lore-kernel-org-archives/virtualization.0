Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252646;
	b=WQwhEqmqsSCE0CapRvPd9vxvgqQiBv9US7Zr7nlew9mrn2d8t3SGHLJFhP3pdOAepmoe
	 6a7DtL8gpbzoHvFHwhSLvrn5NtpB6prwSeRgeuZ4lDSRmsva/BKxkhGCdMiSMbnMYT1GW
	 FNS5PUAYCQ6VTkyynmEJor4bI1xCG4jGOaaB98VsD8/eJIdTBUxWgrzcO1n0JXhddc/SI
	 ixbXu0zRcmX55r0iujqzdAJtQfp7xvQt7eQ6rdd8CW3oFjDSExzMNb61buoz4LNQaL1o5
	 0xRY8C4Qu6tmE2SKdj2ElCMluSVWfIBwjejlXwJkFYfy5qVFBpgWeafHfF93VVA/7pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Kgp/0IKbbzTkFGoA+p+0MZbAmeWaaCFVonzMq0pKQfk=;
	b=b26vMd4Nbl76f/mEcPkble14OfootlAq0wXp+SJiCUfzoQyUFjefGaoiF09KlhsOL5zI
	 wi0fba2IQXCMAq+M1DkOE6S6ext11B2kHt24GWLAMA1qzQSh+WONnuLyDUdD1YsAehKPR
	 2Cf7j1Ng3zxQIBQw5Oe1Dn55gSkXCtBcBf5b5jGHR6I1ggStUGy2I85OVDh/mXGRuQsyX
	 0HSQyHMpD6KSGOX8iDfqsyzV26sudfv06aDsaRMa41BYpJt8eB77vydgnkR5JBQlnrtdv
	 wZl1+BFuqdO6hKqAdAXBhL7fJ57SNL/XYD7BSYW2+quj60wXJP8qDw949X5RAPz+/xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wL5TqhsZ;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94928606A327
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94928606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wL5TqhsZ
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd5d2dafeccso951837a12.2
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793252645; x=1793857445; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kgp/0IKbbzTkFGoA+p+0MZbAmeWaaCFVonzMq0pKQfk=;
        b=wL5TqhsZrLRIONCt/FBG7SFW1kptNq/ySDutuqLSNJZeORj+syKaJEuVWO2Jj+tUgZ
         UGA8q8YUk5hoFIn/d5yf4LA4e48vNdi2lWyri1cacJskMXY3YJWfxI5H5jlFpcjxGrHO
         qBdJF8bePRn41O2qRm9+U0UfbWdYhawRjNMvBj2vh/UdI0BXGxHAH2B7yp5QZPy4BYiZ
         uhO11g4LIRB9Q4gp7uq3prwa0uv2yLQ30nLb+ZtgWN1eAnIQ+Si+wC88T01Bjn/Kiosc
         rv8xaGjHjq9gPsyCmb/4j4K3o4yO56KmNe68YLvaAsUSXtdNevdchm3S81mcLWPQLykv
         WX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252645; x=1793857445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kgp/0IKbbzTkFGoA+p+0MZbAmeWaaCFVonzMq0pKQfk=;
        b=v29uLRa0vfl7bvinCqKWWWoOuZWO2hs78YZIbVNH8tzdRxGKN9mxj05oZcZXBwbOGV
         2DfiDo/sGR84cNsx6mhH8x8qun8JMdoj9mMULZPwQkg3Xo/NH0zrp60ej51hr6KeB7L+
         eKgmCFjh551oXdMhumWtKHuQCLuY8afQPYe2iW+qdip/JaMLPtpluwc+9dDlx6fCSCpD
         4NsmcfcjWfGjstGNMeAe0KNjQQOQjhloG15ltzDeCopcuIAAeBssDadfa0g9l9NTLsha
         IUG2nlOZ7rSRNLe1hNiv4jNOMTDC8GE9yAw4gMHjX9XgnUvAwp0XBQC6vxG7T1AeR0Qg
         4BtQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPTn4CidJCOyOD2yJqCWQFjlMfn4FQSqyh5oKEZRN6aEVgBRBVUROSAb859rYaTKrqv9AMqzf5mFH0/x5Gcg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKJ3L5GjGW/JI78BbI5T7NVDwEv3oA4rFELmde+EdWRA7qsGYR7
	vFDJAobos161bBaVt0HcYJL59IZv1s5AgtAi/qlH/jU/cQNIhHHuAS9j
X-Gm-Gg: AYBFou1I4OzZRWiqHtVHR7ixfz/qNvgQyYcTeyjeOsewmYv/emmk0GDePcXdoLiHNlk
	D7XDAlEumFaml+1KPcYtVlw6pliDqUzQpYfNH1f+fhw8fhED0gieDkWa09D313zX8X2AHM8y+hT
	zpaE58H8ip5S9+qtPWS3WUd/l+cp9xa61Q5yPbmQxj3i/080DdFcLiN4iPsxtdSSXTdlntNg5vv
	C94OvQnleVKFKig+DQMTEeLailok0Q6K7Bxz4sKf8z58bGP0bS6TG26FEnABpBHMQaY71fLwqE9
	LPW46jiEog06mViy0wybc4mC7gkjaSMhj/mlwXtlOTFCXdO+U8MtQDaTo3c3y4QLiehAEGIPTXb
	qL139VO+SsKGwh7HBZkBoYjow6SXZT2maYaK3Fr0HtBu1nKvuQfviUE9YDb4Yn29hYRwgZB77OI
	AJAxdNq/XgBMsAYo+fAJGHpRrWIsdnQF5kudYEgyzqWKJkhxdCI7xVSn4mm0vf09xQbJ6FpAycs
	v9llE/KLlGtSuLQQ9/tM9yiWbJUK/J3x1M0DDA1rwgJuH7Q7DRcCXbJXklPaGsrESZxSOZQL3VN
	zq/iEs/HUWX9NC8T7LoF8NqpJ6/dhlxzwllK4yOK7NBEB56IcNuqluVyaKLvplhSfnIDk2aa/Gd
	vrIBbgKkZtZAaMwiCvhBoX/MZTUJW5er67bOupzOxvMMa5xA=
X-Received: by 2002:a17:90b:5242:b0:3ac:7556:8eda with SMTP id 98e67ed59e1d1-3ae58100ac6mr2908685a91.26.1793252644765;
        Wed, 28 Oct 2026 22:44:04 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e83127csm2433520a91.10.2026.10.28.22.44.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 22:44:04 -0700 (PDT)
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
Subject: [PATCH v8 01/14] ALSA: virtio: Propagate PCM send failures through ACK
Date: Thu, 29 Oct 2026 14:43:41 +0900
Message-ID: <20261029054354.2931-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029054354.2931-1-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
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
