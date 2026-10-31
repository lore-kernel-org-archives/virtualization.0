Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412581;
	b=Fsos3jXF0zLvybRq/MVxDvpeJerwf3CUGFvcPe3G2xP4DgVKO6h0nngFd5bpT0J5F0B7
	 BUp6QAZmkNUnvJclUBaEXci/9KJAW0IVN3uzm0fOrFzZn8oowZl3GDLAZXVlzeCrquBro
	 kVWaADmTMoyGlSpIDpihgK7i2xy+Gjh1P07iPh3hgZZMGtdgvDu19y6doSp+06nBayeoM
	 f4H+DanW4N3PW5UmwCwpwGSD2Jrpn+EMFv7cJJeGxavEiMyCO9kNgA0EAHLjSesCuBACP
	 IVNSY6szxLtkp97pEF4FZg0rKxfxlPTCaCBWNSobKrLSqaq3m7ALbZbGE2Elhe7kBfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kYTuX92aRtCeYi/y6rrhsUUqGJaj+xMsdosIKAjJqSI=;
	b=NrjfyTtwo24zsxw5qXowF8oBNoWb47mWbmEgJdWojb1f67/wZXbrIjCzb/4/Zlr5k/Cs
	 ZQVAV1xa/aEqig9p/Ra2atQrnnTgV5fFAclYJm+HkSQlWIxE3+5aiydqGQZdHIH/A9k4l
	 hF2S5Ao66uy9oeRqhMu2PGBGAEWGEkbDGCw+VDdmUDaGMYw/do6WShOX+ulFhCPChQsIK
	 MDllxaWqyvpapodmyW5dvagxA08ZBiIRuQWQmKdgo2lfP01irZ6/DKlKzbYHbbUMagRby
	 zLeOC1LRokBf6hBS3z1NDK3reDnNj1DeDozdN4sk1LrhIDGU7GTqhKaUbeVXFgCazsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F8nBCQ0z;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C80606A33D
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88C80606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F8nBCQ0z
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-353804b591eso2077154eec.0
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 19:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793412581; x=1794017381; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kYTuX92aRtCeYi/y6rrhsUUqGJaj+xMsdosIKAjJqSI=;
        b=F8nBCQ0zEuTr7Ds6DZe8rkfljtJm/rMIhH8RhMakkqacuFadMIilKXiWKonTRSEufq
         chKFlCNLSX/rWrA2c845l3LhYDGRw4yVRA23Dy9Bejj2FnHNLbj+2TLwDotmZtyp7pUk
         xEG4Ck2oBJ1rj6DNIEP9mL52FUYIzaceEIkiptSt03hNe0f63ZQIthVvK+1qClRu6CmR
         FC/HJAuqu7atptrRO1x6igo2GN46QSdNezvXCeuN/XyV58p1iTlpJBGiZBUfpZz9qpqC
         hJyJ9Z2T/S0dBSojDR1cn2P4wIQBJu5k4b+H+evSCRMmbh+UqTa/Je5cXrueUMF2W3YX
         iDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793412581; x=1794017381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kYTuX92aRtCeYi/y6rrhsUUqGJaj+xMsdosIKAjJqSI=;
        b=gbtwGfmkvjKK2klM3dOjazqStAtv7T7Ya4v2oKmH36ygZC8Gcgb0AAmKWtgpSkvVDx
         DEks5iVixqW7NqhZ91YXe+u7WSK65qqKIDVQGg2poboqdhRZ2/WCk81Ai3EUALOfH4qG
         JMvYOloR1mnFUC2ztq26xZy7U/UbUsarqmyM34YpwGWCnCQrrwKYUu8477/KItCqoWL1
         y9pX/UUOFrKcMMLPvyELmKAj6YpajpQCxDLZfEHx3c7bYb13gnzaOaK2RtVOWyAaqeE3
         fKW7jCzQefrEIJrVMy4Ro1vtqNQbkU+yMErRM4L0BOHpfmxFt6h8eaRlON/Ui7Y+26pQ
         hZ/w==
X-Forwarded-Encrypted: i=1; AKwUvBx3R3pueaAElm61jgGIrnd408KPXqi+cXk6HHhJIIEz+Qy37Gal0am6EqIvkRJzHLlbdcodcUoPhTF0IJzJsQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJcQZu5WY7U12PyWOq+eQkYbrV6km79fgOZZXnMiuOwpGnQDcHI
	5YC3U0MEvn8kCwXH+qUwORltNwIf8bBoSgolwJKkLd9Y5XroXN+OMqy4
X-Gm-Gg: AYBFou3LhpzKj3yLCpULofrBTLjuLFb1hWQ8/bOD/IGdOaR9MHB6W/nElukFpRCb7Vl
	zhxeQgrI5vqKxq39/1RaunqrlefYDGC5N3Ort/n7wc9hA12+rLshGhs0b8T+M/viqyxI54vju3O
	0xpleoLKYUo2ZQM/H3SnkMjoyzIh/sT/mj0jxbtmvxgvB5/qdEWNMuWHOAqe3PQUvVRPUCbFlxk
	8ocEEiI7DOAt9TSGO+9mSNUUANvohVJ85jl3a4O04HV6t5iwKSb1oWgMTS9brSIozJjh9nsKk6U
	wUnkhPeGiuHPbhUmGakWvC1I5dJPYQq88cy6VgLPthU9tpxnBBrL+G5PcL1uFs/IYCEWFyPdJ/Z
	a0sQU7ehNZn1ENx3TJnMz7Tz0Bk5kNMKL4rDie23hCZFAcd/GmgHKn5y16MBFuzc2RXvju7Na+C
	RG9Iwkzstd5swe56/iK73N9LZXicD9+/Txhh4ha9LdApGSQE4QVKxurgatIA2BtnjPrdcl9laar
	sNzDDJLxZ0S6gPMlyM7v5cgGZK2hTOzLHWWVJodA2tRPDR8DV3jkpkIIh3LQBQNQfp/rnpt6cWU
	qIxJBZVY6FGOLkYCuNBBA7yVErP4vufJF41ZU1365ozUkJPLEIcOmWutkAfoUA8QL3SOYEB40ys
	R1x/1Rh4M+U1TBLrJasnYQqB+AGCfoV+ot1baKJ4n+9wmTW7GExFj1DkpZn91or5fO54=
X-Received: by 2002:a05:7300:a188:b0:35f:4780:518e with SMTP id 5a478bee46e88-36a4238996bmr9338075eec.16.1793412580547;
        Fri, 30 Oct 2026 19:09:40 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm13214096eec.26.2026.10.30.19.09.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 19:09:40 -0700 (PDT)
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
Subject: [PATCH v11 13/14] ALSA: virtio: synchronize staged capture accounting during RESET
Date: Sat, 31 Oct 2026 11:08:54 +0900
Message-ID: <20261031020855.2402-14-mynameisjune111@gmail.com>
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

Use the locked PCM reset operation for staged capture. Reclaim RX space
at the same locked pointer observation used by the common reset and keep
completions arriving after that observation. Rebase the notified-period
counter there to avoid replaying old period notifications.

After common pointer mutation, finish the matching core rebase even if
refill fails. Latch XRUN and schedule notification. RESET can return zero
before the asynchronous error is visible; userspace still needs ordinary
XRUN recovery. A nonblocking read can initially return -EAGAIN and later
-EPIPE. This avoids leaving core and driver positions partly rebased.

A forced 90 ms RX interval reproduced -EPIPE with the earlier accounting.
The corrected sequence matched the next 48,000 deterministic frames and
passed reopen. Linked RESET and prepare partial-failure fixtures also
passed with atomic and nonatomic stream locking.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -9,6 +9,7 @@
 
 #include "virtio_card.h"
 
+static const struct snd_pcm_ops virtsnd_pcm_capture_staged_ops;
 
 bool virtsnd_capture_staging;
 module_param_named(capture_staging, virtsnd_capture_staging, bool, 0444);
@@ -392,6 +393,10 @@
 		}
 	}
 
+	/* Keep RESET operation selection fixed for the opened runtime. */
+	substream->ops = vss->capture_staging ?
+		&virtsnd_pcm_capture_staged_ops :
+		&virtsnd_pcm_ops[substream->stream];
 
 	snd_pcm_hw_constraint_integer(substream->runtime,
 				      SNDRV_PCM_HW_PARAM_PERIODS);
@@ -1754,6 +1759,61 @@
 			return 0;
 	}
 	return virtsnd_pcm_sync_stop_locked(substream);
+}
+
+/* The core holds the stream lock through the matching appl_ptr reset. */
+static int virtsnd_pcm_reset(struct snd_pcm_substream *substream)
+{
+	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
+	size_t position;
+	size_t period;
+	int rc;
+
+	/* Reclaim RX space atomically with the pointer observation. */
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->capture_reset_observing = true;
+	rc = snd_pcm_lib_reset(substream);
+	scoped_guard(spinlock_irqsave, &vss->lock)
+		vss->capture_reset_observing = false;
+	if (rc || !vss->capture_staging)
+		return rc;
+
+	guard(spinlock_irqsave)(&queue->lock);
+	guard(spinlock)(&vss->lock);
+	if (vss->resetting)
+		return 0;
+	/* The common reset has already handled a pointer-reported XRUN. */
+	if (vss->xfer_xrun)
+		return 0;
+	if (snd_pcm_running(substream)) {
+		/* Keep completions arriving after the core's pointer observation. */
+		vss->capture_acked_total = vss->capture_pointer_seen_total;
+		vss->capture_ready = vss->capture_free_running ? 0 :
+			vss->capture_copied_total - vss->capture_acked_total;
+	} else {
+		position = frames_to_bytes(runtime, runtime->status->hw_ptr);
+		vss->hw_ptr = position;
+		period = snd_pcm_lib_period_bytes(substream);
+		vss->capture_copied_total = position;
+		vss->capture_acked_total = position;
+		vss->capture_pointer_seen_total = position;
+		vss->capture_ready = 0;
+		vss->capture_notified_periods = period ? position / period : 0;
+	}
+	vss->capture_callback_snapshot = 0;
+	vss->capture_callback_snapshot_active = false;
+	vss->pcm_indirect.appl_ptr = runtime->status->hw_ptr;
+	if (snd_pcm_running(substream) && vss->xfer_enabled && vss->prepared) {
+		rc = virtsnd_pcm_capture_send(vss);
+		if (rc) {
+			vss->xfer_xrun = true;
+			virtsnd_pcm_schedule_period_elapsed(vss);
+		}
+	}
+	/* Complete the matching core pointer rebase before reporting XRUN. */
+	return 0;
 }
 
 /* PCM substream operators map. */
@@ -1783,3 +1843,18 @@
 		.ack = virtsnd_pcm_cp_ack,
 	},
 };
+
+/* Selected at open; the staging policy remains fixed for that runtime. */
+static const struct snd_pcm_ops virtsnd_pcm_capture_staged_ops = {
+	.open = virtsnd_pcm_open,
+	.close = virtsnd_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.reset = virtsnd_pcm_reset,
+	.hw_params = virtsnd_pcm_hw_params,
+	.hw_free = virtsnd_pcm_hw_free,
+	.prepare = virtsnd_pcm_prepare,
+	.trigger = virtsnd_pcm_trigger,
+	.sync_stop = virtsnd_pcm_sync_stop,
+	.pointer = virtsnd_pcm_cp_pointer,
+	.ack = virtsnd_pcm_cp_ack,
+};
