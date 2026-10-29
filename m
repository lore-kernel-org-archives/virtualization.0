Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263844;
	b=YTKnodf+NCHlMIDushHzj29IMFWRwZ9uEgaN5pi9pTk53rlBzkvvA0iF2W/ie2/8WWS+
	 QbW3W+iayMVtiVmNwnMb7PPUfgB2Rqo6n86OGywq4Yd4cHZZju/5ZnHguuZfK7DqWP72J
	 Z8XmbU4X2F+1dbzZgEz176r1J0K6ICcPR7F50BBcw9CI85z+opty8RraUgpQWBIzftGJn
	 qp7zIzV/+TBAiVivp3DHqEofN4UgjQIm0gj62m+p+9blZYvy5ZGqf75wAMS4odVwVBdz9
	 axB0iyGh1CrjyACpC/mHtZ14QKc/lMxIBI9YgWtojraQCg0XgO23jMotRJRBSkEHV3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tOERZEIQ6bWpFjXc/IYsfYbCQo0wq413M2Hd4FsT6W0=;
	b=Ulqp95gKM1J3ym5OzoY4mKJGzCdjKRPs8+XDbGaT2Bx9ZuSWCiIh39tUwe3I1dTbkvKZ
	 zehgNvFb9iAsZoGO3F1BJPNuhJXFntcg3l41fDq4QQxQqacCbT4N+WQorTdmaqbie8FEe
	 fUmSPSxzzetgQVgZQh52w8j/R5/UsEjmL3Yu68O1+ICnRmSiPBEwToWGzHtIHnjtZgMr8
	 CB9wk3SK1fD3GFoLbiY3p5PbC5a18HjYtkBUgXjGeoYeylI3L9wtbbMIqRaOLGn+m5vgq
	 AUILMNPGPNGhVLaYYrAC6kuutDCn2jldkQqJ7Ra03ggTXaE/kIIQKeWkQbdP16pYZHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v8h5g9pc;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94187606A31E
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94187606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v8h5g9pc
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ea94541adbso8327135ad.2
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 01:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263844; x=1793868644; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tOERZEIQ6bWpFjXc/IYsfYbCQo0wq413M2Hd4FsT6W0=;
        b=v8h5g9pcnb+KxCPva1Y90PEkZcDa3/BK7fbzx/vuq8RNxV9b+uXqUhYpWeh+bOCceY
         rOvKSRMTcKcnO9mDMD4jzq+IMphQdACSsGdoAbLCZ+wASrK4VHzJMhfc899JcKV3+pCD
         sTAW5+avCp0HLP1DdJBWWkIpFu5jrzugmi5XGrvU90vtgjopR1xgMSXdisPDD2Ap/Zm4
         VkwDmlisA+GhUhZVxbsrqgHFdIpwt5OlMisuz/UEwp9uVO1lzXol8JTJmlTfj9ZsReyo
         ryBgyeS7gbx817XxIcG5ROkb28i8ugTXKYBLLGcH5rLYtgaq1BZ+KnjJES/z83pS70V+
         u4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263844; x=1793868644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tOERZEIQ6bWpFjXc/IYsfYbCQo0wq413M2Hd4FsT6W0=;
        b=rF6/gno8vssmS9ZvYa/+Aa140vnEYpCHNA8vUWTD2/Y/qXMXIJDhaH3IgudBQkCbnX
         Se5edf+01Kk765zPdIEmSsMth30gtioXtt8Twu38v6jergsbItMriIhq+8fCxjvBTKzb
         p+zxTY/3GVfEGxVz9oe0BLQ4XiahVHw65lZp++JZBf4ovwXOMs5j6ZNLWsuFrd/nMgPE
         Uk1hK65YWBWCfFotmdz0dMHfJHht+yT19wtJyH+llq1ajRQP3aC2cW2PIquk9hw+PUeJ
         n8xEJBT7R3hzfZgWYPe+v4AwlGe9yrWE2+hMfodlNOy1DQF+U3UhARGXzR/RYA3jFqo1
         WFlg==
X-Forwarded-Encrypted: i=1; AKwUvBwyCsveiek3MbJb0eOK3IPtqf6nI9XpY+e5p4gKxHiiKFeWy2Eiht9yaWG6Z/tAAFBWlNJYFEPu082+EFxfdw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJnqa9G1l/YhOH9WB0FCKGvpSZQdzxPMyGKnoW9xNFArEuUWHWX
	AGAWQYyUg6O4Nd9ubj9Ek15snowwF/sL3mHR0O8Max+f/3OsP2C/i4NU
X-Gm-Gg: AYBFou1zlyY/rTi6G6SJTln5N/iOHN85oIzm/+1u1qUyULTsNu0gYTwXJYQtaLrEmBI
	2x7NLF1qo4ZFcQsO0Z8YUuV6nepA76hcfgDn9vIV1M7rgnVBm7rzzHuzT6QcBEV0HnJLZDiNx5b
	U5Xxh9pGN682QTlk8t0kPQQrMPddrSmQjgZj5SbjvrvsYmo7Q212fijZnOaDkIZ5Tg3UMzT13he
	xbc2bNYgdLdYvnm0RtHN2Stga9Gzsddcaoyb9Xo6ISK68Mkv9Bdeoz0ClK70wrL+TkYtRc21d3z
	+mVzpixAfTr/p2hp6ZbNc73IRgAe8+jp1ewFXJiQPewAaQeq0eQrILE1wkS3zaAV1zRKTsKWwWB
	kHZgy52Fcka7AxKA7hbzrOy0x03MZCegZo8Voh4CZor3VPHh8V1RKk7awghSe7k+/Tfw6rCJxiB
	L9CZjG6FCpwEOjTW8nyANOe6aYUesPJkht1XArzsxQeFiTazIjFMvlt8pXylFdh1iYNuDpaLpta
	cVVKBCbRxl2nEEMtysUnP/PfyPvoO3SQwYziXuB4aUHM/Fz71+JPsl+UWihtvwFQsuCYI8xKA4a
	1937XOLAbjdbdPDbphO29gFZ/K58qUMQEsG+SzKo1HKSVwujHoRarsF1nNgochNcyAOEPyyDQEo
	7gOFmndIVUEFMXsbgC+A/tzMGwf68x7koBcCeAfWLXFCNyYOVBokLfJBIT6JUcJk=
X-Received: by 2002:a17:902:cf4c:b0:2e5:467a:7a6b with SMTP id d9443c01a7336-2eb004f2a79mr44003435ad.10.1793263843827;
        Thu, 29 Oct 2026 01:50:43 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm29991205ad.35.2026.10.29.01.50.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 01:50:42 -0700 (PDT)
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
Subject: [PATCH v9 01/14] ALSA: virtio: Propagate PCM send failures through ACK
Date: Thu, 29 Oct 2026 17:50:19 +0900
Message-ID: <20261029085032.70689-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029085032.70689-1-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
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
