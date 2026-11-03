Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693312;
	b=TJAXfevYNg+aSS9+0+hX+Ct5+k19AB+8XLswLS/wrxlJXXJKJnDFuuZM6ki4+vssCJOA
	 Xl+FmFBQiZDkxatNBdvex/L3ukw3MUuHF0zrCCvO3pPXcZZvU3R6Dpv6W9BTL4NXpjuSe
	 E4T26/ehPxO0irEgo0yzP6F/mrnLsjMtmvLBn584lHh5F+smJwrVnzJZTR01DLqIx4dNj
	 LmjJl7h1YHuHeN17LN4NjsRKJAhhcN6ThqBAEOLrSnS9g3tlbp59veaDtZxOzWlY61uf+
	 3fflbFavXAecpPgUcEBtjlfLr68o4ZGq/W0IrVj2YSvjYkeVItaFN2psAL8VD2Ll03g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NjXyF+97NpD7QlpoyoVDNxXHmgR7PkO0NBUnxo8wzt8=;
	b=pfjbazDNfQ5J/TqRtkcv2Umd6ILePmaMR30mcEEkXpwBGDeaK+r86vBBa79RPRTXHs9+
	 x5Uley3kWz1c4W4g52lZcDgL0uLuFDWVEU5sPd6+tldJ8Q+Z0QCYteehobFmZNbH58KZK
	 ZrY8LQN+2tllebP9M8BLWzuag1GhGqBguwRDsDreh8mBuC1seY/bIjyVQCbbtvFpu88xF
	 0xp6w4SlwQ0/qNh1oNF8LcnzLhoLGgSf+wcQCO/z79wrWUJYPbgCOBCsp+CHLLZx6+j3z
	 S64F3t2pGHJ1HxGG6aaiv0NQXU1Xfh0lTVYHIM5H9Qxgen2iB3HketGwIlxOa6KYikg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALJJvZ8u;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2947606A33A
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2947606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ALJJvZ8u
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36661f953e4so5954864eec.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 00:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793693311; x=1794298111; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjXyF+97NpD7QlpoyoVDNxXHmgR7PkO0NBUnxo8wzt8=;
        b=ALJJvZ8ueU6QBpnml4RwmFU39lBTtgbTbfGXR0tbtQfvEs7EaxlT1BdA9cbkasYgXf
         PwcVG3uejdBt1Y7eAKJOGaKCq7BDH0E6Wc8LTk7gXOgctezs5slnCd3jRYykvuEWUecm
         ujYVzEAMYenLf2G2uaHdODx3LnU0eV9/PMKt/QdRQ8C6EJZsbqnIAkK73dANLkqbI4Tu
         Kiw77VKmCtAbx+aRz0gcqvI6aJ0c1cx/AvjE0eTLxjRAdnI8tlNoQlHmcZOfCr3gpDNU
         SPL45YbG6Jfj+5/qljk9GzTjr0f0RLC4vcaR3FrWylnWXJ47rNClh3zsAhT4RD6WUvyf
         eDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693311; x=1794298111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NjXyF+97NpD7QlpoyoVDNxXHmgR7PkO0NBUnxo8wzt8=;
        b=t2thkFCg62rjRUTEYNPUipEjHtxoUVRVGJdvqZ98VHuI2I3AbeDdhK+MbGgf78In+I
         NVvjFFDiSHBMkbFM7f6AwVM/bP1BQsEcrjdkoCH4sXGdkMqogYbhOFd2OAQcoZJkIWY5
         IhgL14uH8ZNfHUUJIUETOrtWwpgYljnVUVeC2i9Vge0jQRmvzupRkgKKHWRK04BI5BN9
         7ZthOqui63wjFn4oQo5Lp0TGOgeJutbYcn7Ly80iq7mErEaXLYVhecQO+HAZCaQKbx6B
         a0QrfexekDl6LEiFOExz9m/GQz2VAu8/Yvp0uA3KPYgcSOkOeNf/+kJJFKgzwKUJ2kiP
         tKSw==
X-Forwarded-Encrypted: i=1; AKwUvBxtT3uWFdvWOWlwuikYGZJZfTbwgsDIXfqQue8B/Nx7MUff0apR8P9FJMej1bDLAI0rJMXva544MTOoenVtYA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8WY8X5VdhF4aNAMoQIXPYdshxQaoG3e8TdO0MkvCTaidGiDbWr
	gV7JY3qUFgBATrCQeHUjCyM3i9NNFWp8JyBC6iKC2wSn4rwsV9RCUP/H
X-Gm-Gg: AYBFou38FbZ6VaZerLjo+7PEeecBQ6TvUKPFFsNGWwCcKh8H0iiaLBxWCsMCsBOAqpK
	KnpzvGBpUT9ARHIAyQdPOg8uGX7fKGeuRfJVtAuvR57uNzZHRf6MqOrxs8K1FBAvvX6sE3VKNsC
	hm0lZEizSasGz6p0zFRUwyBjwlsutW1QbaE3LgnU6gZdPj8JUqVnmmq3G32o8P8kvZlnVe2xGJd
	o5IbP2kD5Pp8B+FbGIscq/3iooV7eKMpdmvcVzdGvrWV+634W88MH+RCeFsFwznfNSeNwpOrDL3
	lz3nS1GHGjIgNgRKzk/MLnCNxBgis7tuBU5Lb86wzGLg/16CFnqfm6HfsKtu40EpFoESx8Dmb2o
	xHUlNF7b9NpJi3XFNSs9Q7BQN5ANsSPOifrqoy3TnCUfscYflbKwfECYiXmKVkxwSWKAPeWrwk1
	HT3EGj4VTIueMgY0lu6UBV7QsI7vCXoo63FNqu1ayPKrkUn0Pe61z9cg8LgMrbW9X43afVdweiY
	aZ9QBmVMQn7Oi3BkSbhIcQ5MPvDAe802syBHz/8MgEDMF4jkmj1CbhKY4tos0D1/G7MkSsKeqZY
	LKMqx9salzznVTZV61edXSpc7BUHZhPagvBlc/JUK5690jOaWoSFzmL+Niy2L3+7BdcgANpvyLf
	4ZiVIdSj/CjUT5RjDPzSJhU+2EUYH//lNk0F4CMiTAbNVp4I=
X-Received: by 2002:a05:7301:6189:20b0:358:ec5c:bef1 with SMTP id 5a478bee46e88-36a42425486mr17468088eec.39.1793693310608;
        Tue, 03 Nov 2026 00:08:30 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm41468466eec.12.2026.11.03.00.08.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:08:30 -0800 (PST)
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
Subject: [PATCH v13 01/12] ALSA: virtio: Propagate PCM send failures through ACK
Date: Tue,  3 Nov 2026 17:08:10 +0900
Message-ID: <20261103080821.16983-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103080821.16983-1-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
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
Reject ACK from invalid PCM states under the stream lock before modifying
private transfer state. A concurrent DROP must keep SETUP and must not
re-arm stop_operating through the ACK error path.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
 sound/virtio/virtio_pcm_msg.c |   12 ++++
 sound/virtio/virtio_pcm_ops.c |  116 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 114 insertions(+), 14 deletions(-)

diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -260,6 +260,18 @@
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
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -466,36 +466,124 @@
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
-
-	virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
+	struct virtsnd_pcm_transfer *transfer =
+		container_of(rec, struct virtsnd_pcm_transfer, indirect);
+
+	if (transfer->error)
+		return;
+
+	transfer->error = virtsnd_pcm_msg_send(vss, rec->sw_data, bytes);
+}
+
+/* Caller holds vss->lock. */
+static void virtsnd_pcm_transfer_failed(struct virtio_pcm_substream *vss)
+{
+	vss->xfer_enabled = false;
+	vss->stopped = true;
+	vss->substream->runtime->stop_operating = true;
+}
+
+/* The caller holds the PCM lock, also used by DROP and state transitions. */
+static int virtsnd_pcm_ack_state(struct snd_pcm_substream *substream)
+{
+	switch (substream->runtime->state) {
+	case SNDRV_PCM_STATE_XRUN:
+		return -EPIPE;
+	case SNDRV_PCM_STATE_PREPARED:
+	case SNDRV_PCM_STATE_RUNNING:
+	case SNDRV_PCM_STATE_PAUSED:
+	case SNDRV_PCM_STATE_DRAINING:
+		return 0;
+	default:
+		return -EBADFD;
+	}
 }
 
 static int virtsnd_pcm_pb_ack(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
-
-	guard(spinlock_irqsave)(&queue->lock);
-	guard(spinlock)(&vss->lock);
-
-	return snd_pcm_indirect_playback_transfer(substream, &vss->pcm_indirect,
-						  virtsnd_pcm_trans_copy);
+	struct virtsnd_pcm_transfer transfer = {};
+	int rc;
+
+	rc = virtsnd_pcm_ack_state(substream);
+	if (rc)
+		return rc;
+
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
+
+	return 0;
 }
 
 static int virtsnd_pcm_cp_ack(struct snd_pcm_substream *substream)
 {
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
-
-	guard(spinlock_irqsave)(&queue->lock);
-	guard(spinlock)(&vss->lock);
-
-	return snd_pcm_indirect_capture_transfer(substream, &vss->pcm_indirect,
-						 virtsnd_pcm_trans_copy);
+	struct virtsnd_pcm_transfer transfer = {};
+	int rc;
+
+	rc = virtsnd_pcm_ack_state(substream);
+	if (rc)
+		return rc;
+
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
+
+	return 0;
 }
 
 /* PCM substream operators map. */
