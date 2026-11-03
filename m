Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664253;
	b=MGHIT3BmdlJ3itnTl494UV6FCX4BIVncxzmL8q4ZYTVMBRUrPJOvWUcsJRtdUQ/crHyl
	 NWwGt8VcX02o84s/MFTGxSIiHnM9iEsfGqJVfwFyJhePpbXTmtf3xslpl8nGdrD7YF11c
	 NFzj/zEiA+H/iBqLT4PkmvNlj2YXmLwwhgmNDSBtiRyQXxtMeM421W0vlNQ7wCFzX52Al
	 /E2UnJVGfTc6O6Q5CkAI6Hu7FujWsqOMIdzxpIa/6s1yVqm7WedUTkvu9YKda/h7WpYht
	 zSmNoWzOTvzp3P4g5Txp9GDP85lS7JNA7AvXNJHoD/5iqTuAMb8cZ+3fdckFZnKbQZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tOERZEIQ6bWpFjXc/IYsfYbCQo0wq413M2Hd4FsT6W0=;
	b=UDQ2ZvHL2oM/EjNvp/bho9cGsRO0JE33J/5NVgLJdJYwXAjnGTR/kq7cSCRkDiEgAGfv
	 UvNuuZotPysKrwWjQhIYD0SxI2mfB+7Hbk1MXXRJLlh3wBoklMrnHDGB96YH+XzYDHSLi
	 O6jtKC+vO2tSw+oD/UdxHMrd1e1slCIvcs5V9xZeQg3YR1dhlq7Ufd6d310qzMUwD+GtD
	 zpHNZEJ4gQmUGtUgDMErQStgtO6+kvlDtN0HS4aOnjEaltRus0YU2IsN/7rv1CVTM3plC
	 G/vzHuf0bCOKDwX/MAm+aZ71f5/1WvYxtawcl+DNMjZOAPfknFk+yo/UsRxH9pt8oIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jmV8UTDA;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4027A606A329
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4027A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jmV8UTDA
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ea7987517aso23857525ad.0
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 16:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793664253; x=1794269053; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tOERZEIQ6bWpFjXc/IYsfYbCQo0wq413M2Hd4FsT6W0=;
        b=jmV8UTDAmAsXSGVwMkZek3fj18qCGPjIrc7vWsAqfOlScDB7iD7cCqdIHaJjMbsSfQ
         ZIUFYwHiCL2bH4E+47FUvWhDKULyXBihDe5SWkKttD2b6ejQ4GLTQ4l+n1aehQhjp2me
         +GRweJRljt22NPSgDqpwoO7f+pIib5JaFF1SdIGHWEwIXkJX3nNx7CshBxV7AxjY+ajx
         p4bOsMyPrMAGiWwddG8bKIz6rVUnm/z/0Z7wJgCzN0GJ8eCC1d287ku+J/zW3MvVrOCA
         NZDLlC0gnNCQgnR1QoE3jb9bwm8JguK/K4dROcpx7kiRuXRb3KzukyviCI5Qv2IO/ErI
         dKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664253; x=1794269053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tOERZEIQ6bWpFjXc/IYsfYbCQo0wq413M2Hd4FsT6W0=;
        b=bzFf9x4aQtytBnXJcI15Zmo4DnN/Cro9npvrJi44LQ9luZFl94q59bICpAmI6p9t6K
         DzLw9w7u52gJX+9SHNo9ZndC+twhXxAupaOWL1Nu0etTrk2SF+3eIcQuCm0D5JaqS+3C
         Dvahzt9ATaoEFW43mAbo4PK+XaWlDu6vmJAa01Q6hQJkRNNYFYnoAiqhaiG0Cc/eXMwl
         BrrW5hHBNxGqu95g03XoCU/Q9xYpsm6UoqsuCHc5wR1s6G5TKyituEhBreixZnPORdFB
         pnobQDU3Gmz8+PU1IggWsJD3IkpLBfzR61bHXm78+NOINa9bSKnICeXEGM0EsHizHagU
         IVbA==
X-Forwarded-Encrypted: i=1; AKwUvBwvnSEWhGa2dWgj3c65qhiCN2vsopFEW7v5IIIULjQwniqKZjEtJy3UA2JlOgFGmLxozUAWyWWaVi3fl8b6sQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/p1AO1LAgvrRaPDAChm29aFROlucyCUXrFFAeGVer4JQoFtQGz
	U8ihOkiEf/BlJVqy80d+b9elKc1mPBjkeR/uoe3wEB5vbXTiSxX9twxM
X-Gm-Gg: AYBFou0Ejwzbb7O3zGJJsvrz9/cAx65krq2mgnn8lOcAFR/SKrBO+mhFPXJmgPpjHot
	U5candTEjP1473qlt7SVKOBoI5s79SgtOfdhvc+ODg51qRQEqxro/iMuv6vguNUre/DvyBdz74K
	B2vHJZxo3CMnhj8lBdhWk5EKJisPny8N3xzXdKKN0yj+HzlPvB3JzKB5OjQNg71LJY4G5nHYjmj
	JVeu2vc7JNU+xyrB4iKcpFzhQ0G2SRg6hPe7Lvnv4lJ5UtZLBhVESck4CEzQYSLGav4Y7Wizgnu
	G53td9+U5imexfWWNr935lNHKHYLe9NiVwtWmG3DxOnWPyNnZlnAx13e0S90WWDXEAuccPhYSLF
	AcQcQZnLETtmfXBI2L0Ku03STC/UaSFzyVssQ/KaohlHG6gqWJajV7t1HjG1utb5e7+4VyTTw2C
	oRfcceXFA56FyEqtwwL5hgyW1n0Ew6S9DHjuhHrun6+JZ19helbBqYvMfLhfEFTzBdANZQW33hq
	jY3QCbsz0KMqQwoTCTnPrQU9oeoUzlH1+79y9wQ0hUCk+00LM7nrNsIMlfN2KCMuVQgpsBQLF7/
	MnTW3k4lthV3g3+1LCFFYpNlvzwNWBHfU17+WolkltbDkGnhGFLyz6TAv0MFDUqAhMnO8bR8C/Y
	goIeENocBs1PKpKenS14gcwZN6NlNL3JbbR67/gym4hSQkAQ=
X-Received: by 2002:a17:90b:1b02:b0:3ac:929d:ba5c with SMTP id 98e67ed59e1d1-3ae89847b50mr8986443a91.45.1793664252625;
        Mon, 02 Nov 2026 16:04:12 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm1339225a91.13.2026.11.02.16.04.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 16:04:12 -0800 (PST)
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
Subject: [PATCH v12 01/12] ALSA: virtio: Propagate PCM send failures through ACK
Date: Tue,  3 Nov 2026 09:03:52 +0900
Message-ID: <20261103000403.67106-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103000403.67106-1-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
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
