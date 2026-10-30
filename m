Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338000;
	b=yJs0CP8TRzGBZaBQn8qQ/Vsg2QhHzkd9Frl62W4dq+pSFU+0K7HxPH/XbScvroKhPHnQ
	 U+vKLdyA6HtknhPLQWVnFvPeM5fxRYHBUAEuVebSaAWUq0jqknTuhlpng40YHAEU67mUw
	 jR5Ie2z90PGgLUM/IJooRr+TAHz6bQeNC/dVQc8C/ANJnYq9Ffy9greQxkEDPN5+glqwS
	 8yHPDxIlaPHPfeLzYqOdcgVpE4QPo5vc+6v8QTuG4+gED6qjlHcAdFa7H0jgyub5vYs36
	 n4rJVAnEB2a5L6IgablwivrAKrTcFsrbrnGAhfl1XY3n4AECxSikMAKPBvTI/NvIXdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tOERZEIQ6bWpFjXc/IYsfYbCQo0wq413M2Hd4FsT6W0=;
	b=IWYIntKhZO6NrrpcVtiqQkHxz2b9e4Ux76N5s2RJStV6DHDV5qKb2oeWWs7CgRJF/8EW
	 Sh2tNOzhz7jsq5FXEr3lIf31T2gvk6MR0OJnvc5ZP1HeuQ8A/gwB2M4ZoRn4lQbN0lh+2
	 vhttQw1qV/C5JYQE4Zrwh9DtmiU4bAw9twtBICs+GWQ/fZ+ABv+4bJE7Yio08HN5jdpg4
	 XNzxNQDuVrGsaQT+UioAzjQ7jrXitwAlRONLNYXhUrCyXBaWs5WqfjKW2llUPXH3RA6Sq
	 rzjq28LcgDyPpGLK63QaEjPokkUoS3TiviHb9YqJA93MjuYnaaMB11YMv7yT/cKKIfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nueGePQ3;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67FB606A327
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B67FB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nueGePQ3
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdab938dc83so110121a12.3
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 22:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793337999; x=1793942799; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tOERZEIQ6bWpFjXc/IYsfYbCQo0wq413M2Hd4FsT6W0=;
        b=nueGePQ35m07Y5rKnBbZwwUUqfmhuotYVRcYaam1RQsw+v7ZBofOpsF4EC9nsAf+MT
         zpvtINeC2TxX48ZgpeO0sdje1QheUSqehoGI6Wif3eKJ7acKmRBFKbGfGSiwblSNAVFq
         +T6Ef2MNQgYG+zEornXSeCFsIk85afw3iuMlupTv4gWupy87tdA56+wDMKV3SaKHmrL4
         xsNb73xBH1pnvGVS+LfT48w3IWoMeIm87RepEehyWq3nN20dgZ3JJ9YhZHFMTy8oQBIF
         ZLkmhVareh3dRRZ+VkD/EYe2Iou0oFlo618ho05UGu2Xviw9xBGoKqgd/Z+YHc3rSLbY
         Qy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793337999; x=1793942799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tOERZEIQ6bWpFjXc/IYsfYbCQo0wq413M2Hd4FsT6W0=;
        b=IevGCK9CFfcfaYununBmmgJlZRgwkDor7lhLnj3Xb+rsZfccKKW64i9uPqkfjB+N2z
         XXqak2ikrAXV5NcV8u0CtwOP6tBgNTjxyJBOCE9SsbGKfTUTJJ9QpLsqKK4PsviYYzcm
         BOiLH+hSL4dsu5CaWmYX+evuWz/7tsbezumzu7dezqwce8FBmMi4AQBpOXdRcZAGZGfQ
         KgnBLKHFy44RLjLf7EUnQuY1wfjIQEtb3Ge+JcmCA2pSn4LgZ9oUGM8WjIM4kNYRpQyb
         a83ZE8zafx/KJhFOtcNaone/8ZLhB+b7/ACYTpS1kTqt+2MKMjpEvBC9jjXze1n0oeDM
         aFjw==
X-Forwarded-Encrypted: i=1; AKwUvBw5aahlC80ERXaRG8XpiEr0YEWRvZHc/3PGKM7O9TJiz6RJ97fx5HOn0pgv9JaPVrVaq4KbY+rHVhILtGF85Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYI4Vh2kWdWCnLztQOyXfnHhDgp8O0rk86etGiflEo09/rZdBGQx
	U9f/P+ClaFpqpfrHo7vNmKH7auN2pxlNI7NZLLbEex/NZu3UqxeE2eLM
X-Gm-Gg: AYBFou2zp/3L1DNcICA+qGNLSw3lHlUr6ZvcpFGV607rlnKTeDEoHuXeJyappS+DkA6
	LAZGE12KkiVJAz80hKp2SS/qM1shBZwlIwO4gPF0uTUW6Ljn3PzwiuQ/E+DiI7iqe5qIFcqgwwg
	oUQn8Qv4+WBA9Pba0/pLS/NvsFYWN+/HscWykAIPD8/D+8dFSjIlhOsiEU1Wdx3Ix/+atNy0dbM
	CrLzNdA1+INn0znRecA45ZeS3Hv+/Jur2Q5inhRDxxHsnc9KdaK6XMws+8QlNjg56Yau12FT6HU
	eZQhD9cAWrRK3Zol8wiPngrHs17lZg0p5DI2k5rA7DBa9Scl4cxLW8Tbsuep1Uhj6DX4KV45fBk
	kWK+QHB1S1oQscmiDrdFCEewHo1V31gwwMPezi/qYEdUGi2zF5yPH9iG9zYL5A+DPfngmRRlE85
	8f+sq5TWrGq7zuKsJ800egXiSmh0FWsyVkvGZQLj2IQv4Xy277S4gdgz4YjW8EjZwfJIJGDmUO9
	wfzAEXBO2eTkzxOsaZjbB4le60L5qYfsNhGzgU2r3+J/s9eJrV+sh2GTLdMp10IfRWGJ8FILcit
	jLrECj9Z0GbwFcV9aRzcN6BQo82aRLif1PzCakJUVCPvQApk60b94SS56yWbpVnKZpjVk9SRJkg
	bmk83GnCupcY3aH+WlPiS+K5RPBZUxZUclVxG6ks7xhqT+5k=
X-Received: by 2002:a17:90b:1a88:b0:3ae:3f20:7056 with SMTP id 98e67ed59e1d1-3ae89746c9cmr1077089a91.31.1793337999008;
        Thu, 29 Oct 2026 22:26:39 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm2421027a91.6.2026.10.29.22.26.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 22:26:38 -0700 (PDT)
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
Subject: [PATCH v10 01/14] ALSA: virtio: Propagate PCM send failures through ACK
Date: Fri, 30 Oct 2026 14:26:16 +0900
Message-ID: <20261030052629.27742-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030052629.27742-1-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
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
