Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412544;
	b=LmRRdcCBCaww8YBWb1aDUpE4ndadRzw0y2JC1j06SmmtHXVCJh8IlPWezQ6cIBJk2ziF
	 ZfMA258BUJVaM6CFdTt6yppAB9mEsg+VyK0IPUwWDgDMsv+D23XWQ5SOJVvM5GVT/m+/a
	 pYny+EWsNnmOUGlCaD2mbeu8ny7mFLxHF1pbow33G/wqOmDMvHfcnq2+i70se9rAyULkR
	 J+ReEwIuaR2W8u6cbQPAy4NMv6/DM3tR5M08N6i3JmmTp0Jg8MubSDKb1I1MoHiX7XC6h
	 0xLxwdSwA1qCno2/49ql3GIjf/JIZO+uE5lT3F+MGwyC8FVm41D4CrmnC0HzMq83Mcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tOERZEIQ6bWpFjXc/IYsfYbCQo0wq413M2Hd4FsT6W0=;
	b=Bo//2vBwBhi3Tw8cx2MveATwEYvZYMM30NDTEKXzH9bbbM4qpAAugEwOTK4Ys0E+gazP
	 ZK/rC6uIzCD1H2y68Ph/u8k/IxR1VCibblMd0U2QrvjSyapExM3CPxlksAoEezg3xatER
	 zEySMM5rnWf1nk6oWjarL6UQdbNmZLuOQvTsS260V1IO8Ji8JLl0EWO4c1NytFDqt7WL+
	 bjCGhGca8MwWnltkgHHOKf7vNH+bJ3oiagC1/Il3ue9yb/ViOcpJAy2Wm3EzF2+KqqF6w
	 8ZpW7kwkzH5cvPKU20OgJ+Fhjb/aJj2Y3v68VSzJejanhfrUk/GSHdAzBR3sXW/G8cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZn0VKrZ;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ECD606A324
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02ECD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZn0VKrZ
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3535a54bed9so2011990eec.1
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 19:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793412543; x=1794017343; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tOERZEIQ6bWpFjXc/IYsfYbCQo0wq413M2Hd4FsT6W0=;
        b=eZn0VKrZN6zchvx2czdh2EAzgbtLkj4b0L+Yvpsdp8UcDzSk5oXhqbfMCEwqOOc25x
         Gszu5+crARGbieIk6UzD05uLC5T/azbHR0DjqAiU9+H/G+k/4NrciKTSyyRTc6R71WjG
         eEPqZd2R4UlS+l8rjEiAT3oAAqpE+EAbNfxOt6+vGsisKpy9UC3zGWjMYUX4MEMfjiKJ
         1ZZhRLcvwm7lF4wkYkebUzhWyL0H1mHEwqKHcqnB29cc1yI2MKsB94JqIQ81IGtKJvWd
         x5mIjgSzqYYG2Pp44mjSVQaz8woWWQeZxvj9o20DPK+xuY8s7E/nVJXZDJJ+CrlOFEUw
         C3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793412543; x=1794017343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tOERZEIQ6bWpFjXc/IYsfYbCQo0wq413M2Hd4FsT6W0=;
        b=k0lZbtleCEhGoE3FUUOgdSY012FtOm4rtwwuVXFrcDA7w6XPuMKtplBOPhNNpPThPV
         nybwvWHODJXlth8bgtSm4u/UhU0Nuj1qrnHLBz+LINUJlhzmBqCMkU2qc8Dzyrym7bOf
         QOBPRcVig7hTNzkMM7vK9zoWZv9vcbT0hRfFX59zteT8dlgKZtWG8GO9r6Ee3g16ujlt
         LPzaWSC5P62aPH9z2t4XHxGH7ksISLBsZUUvaUyRH47v5bxtl/sXmDyOruJUx2qhoIag
         sfKg9ZKOJDCqrzck+DRs7yJjhYRqlttaFE/XfXbESC9MhJHXDxh2x8YSPbz6vwCNMcae
         gVzQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8vJEdnDdW8DLefsZUonDUPlGH6Cl9uviVOuz12AcPx+jfI2L/4Kyj3lA28/aCzz6e7mtAQh010uHr1t6iWQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLeODegOXWcA7wRWBZzDfIOqr44/6aKE9zUcrLA9X19/CoYrmq6
	sh7mGoo2GCxUw8dlxBE8wKwvpYyBPEjJj5OVJ3ashhyjk+2wFT4CYaFm
X-Gm-Gg: AYBFou0jDD2WzUz7fAz/+o0X9awT8d4z6RCogBVQqViZk9tcmFpoPnBr0nt84M61ArY
	CMwRpYAZlgpWJVe5sXHWHKYNcGuacXrFRxMk/C8XGDxGj3kqILX5BmB2i82GQsNpsSZWuFfgKxt
	odQtMK1EYNRy56ESKY6uBXePuBYZTwJ1cnCUIx8PGaUE+gcX3/HA5rDrAOV8oHjfKm2rcMDyARf
	66v1/3e+8jDYfBR9QejIJXVy5glso66P3bT2tYZ5ZJSwU7XLTyClsplezKIo767I1yGAok6VSHt
	aTOymzr609EAv1u+j1y4iin1NoQI9D3y+2TDbb3eXK84TOFQTBiZlV83NRXSd4hRW7HH3MefTIx
	0kQOeTGVOPiVtq/PiqaY41stq1/OB/6Q81jorRAYHzkGsVdqGw1Ie34pFVRQG/5YEgk8+m/BTV0
	NhYYTPu4WeOFrMocpQ4ZBl+aqpIsG+58WB4gjH01/u5U7UfSkeSJr78+YghmNpLaECwgUGYCGBK
	+qhPu6hNr0qNQnVMQxS/3YK12j1tmcUvJAuM+IaVNC/+ViFgvnCrTFZPz27PeY47h19B59OXnty
	S4URoRv/YoeH/acoVTltagRSWYhjPo1SzrxpxzBlYgZR9JMe0eCF18F5ftPMhvTk1s4qPbjmtim
	XAwPbt6C2wWCID4MKkeFOJnIM0TIj3iCzzCT+kyJ11xqQ9Cc=
X-Received: by 2002:a05:7300:ce08:b0:343:ff9f:26f3 with SMTP id 5a478bee46e88-36a42401de6mr5091501eec.9.1793412543022;
        Fri, 30 Oct 2026 19:09:03 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm13214096eec.26.2026.10.30.19.09.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 19:09:02 -0700 (PDT)
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
Subject: [PATCH v11 01/14] ALSA: virtio: Propagate PCM send failures through ACK
Date: Sat, 31 Oct 2026 11:08:42 +0900
Message-ID: <20261031020855.2402-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261031020855.2402-1-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
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
@@ -466,36 +466,100 @@
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
