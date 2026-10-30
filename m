Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338040;
	b=uzlGrRQp1PO6SYk/k3A8KSM1rEgJjf82PEnIFl1ty+qYVdzI0ERDSOXawQcqT4dR/4J0
	 eWGWKkgL2ISFf9nWkrC/qZQQr6oyUlx4e81p/WBiFUfnNskcGpGV6q8Dm1dlLkwlhest6
	 J0lQYAiSL3IH5pi/XTkbbatNpc+1v7E5aSCupHE33fQqtW22XE9IDG5BU4BsYaMaqYYEu
	 RorD0UBK1O95Kr3nwz2TirO0wEDirngFRuYNB5lDqNXc6NSHf6R2ml43v5Ew7d7XVXevY
	 tcbX21yjMdarasQuiEtbo0ahoA8wPs9V5h0/YZpxELQ4C3isoqe9mfDwq73rajtuzkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=L+IYz8Es9Qy/f9V0V2aGa3c/aT6j+cONl3IYueQbDwE=;
	b=YVCovqq+AE/fExBQty4JqlhU98inBsaiv7DPswRE5pUKeuC75fD5moJ19wHLnHHuYplJ
	 2my6GJe75rRqeE5Tlz7hqGsxvVAekeXwrRuYZH6d9wsytohgCyUQqhDEyyBxs0SmXKR1G
	 ULsuUUMUjvHXcA8VPVp4B/97yNmp7sa2uXkKONJ9LDRPN3Dw7y/2FFEntUvGZ2arIB1uz
	 JK/ig+eAIOBicZbY3Fx2xXzpGl2U7RSZWUQvjZbkm8vFs4y0V+uLKBGHJr//072807Gsz
	 hTy0Cnt6OS+mGuPh2ZYvOiVIgguYhUSFEVqxjIT+jm+3Ml1neBLIefswXvS4Imc0q3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=USWNm4k3;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA660A2622
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ABA660A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=USWNm4k3
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8246b13cbso3057205ad.2
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 22:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793338040; x=1793942840; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L+IYz8Es9Qy/f9V0V2aGa3c/aT6j+cONl3IYueQbDwE=;
        b=USWNm4k3OCAMxgJCGsntzDvkRQoNnRIUA53uGcz8LgfW/HJRJYpatldXzcn0DVuswX
         WhbnInn9kIbgRWQ3KMtc0z2POm/6tqp/yzZ99o7UEBk2tfPHIevkCBsKK25FcmTrFedh
         M27He37v072ozyfA27sui+sMoBl3ZsUOk2yo2OX/LlxbrKR6+gtPVUlqNzrYnrs1zFLr
         SFxkMHCOx1yCidNcs+Zrd00AYcwm5z4HJADZmU29qOxSM5Xy7hKNrBH9nq1oF8fTjpn8
         JToDh7Ksbj7ukewviNqLeOaZwYIDO6WeWuPcwtFg8L9MLRDeS8m+CfA4CTCKRdZGRaYN
         mWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793338040; x=1793942840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L+IYz8Es9Qy/f9V0V2aGa3c/aT6j+cONl3IYueQbDwE=;
        b=x8Sv03SU3N0iRdzwYYgGzZHk8EXmbwGwD1qgX6HdPSwh4jqD46yFFhKR45kbW2tBBX
         bj68eN8u6fUwgQk/vYOZZ+14iDKxn8kfDBGGfr41gyEQlzkChoNEz4TjmNVb3agkXXVe
         0RuqWuu95LuTlXmiKE5eyCLv60P3EZ7yquccBZbzY6Vo9A11KT87EzLyGykBz2IKcyVQ
         BncunXTNQw8cxAIVsgGTDo8eVhpOdR0jCFBQXigpKpu2mmpVH4yG4XFsP1bBDxz2YV4y
         oY4ytOZszsnA8scaWM6FL18sq9eN8FHf+crvdeVQY4Ij4DaYO5cMxmIJnkgaAKbjlWjg
         lNnA==
X-Forwarded-Encrypted: i=1; AKwUvBzP6EOTU+Lpc4PkAzoh25JgaKunqoKi0cwv9c4eib7/Ksyvd/JcRY9Y5JmrPLqSk/HjnG5traYMyJmMsps3kQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYK2zuJ08IyuEZBbIbaSwT+vwtyypN4YOPwXnvlhdM43t+XVVQX5
	nKZ4llHtLDnM48LDkNdhwA0gysObBDiR+l+KMkSgXlKP5U99lR3Hy+rz
X-Gm-Gg: AYBFou2DV96Q6AlC2sGLzlsgN4a+OSX0qWq81+n2tqHHnqqQtgCA4I4o6KSG8Hu7r1X
	d0ckYKDzvX1Jxi7sNPS3LPRl4U/0DvSx/yf3mdL7kkQurQfjiNJ9OeA64EKcJLYTAmmwLkAajGh
	wYyADM1enX9neRXr42+fNYGoya683DImO+O7PRkzWzE2FSLXQEKUCGoDqmhZ/7xb7agNEslDOI+
	PjdEMQSY5fp0CxNGKbd/rUP/pF/VKgqj5nHREQtSZne13E+6AgGXwoCNBnmgvKvfO2bYBFYn4F4
	hWM0VfG63vHgX6QoU982zjiBSM13Z9RD07C/Lk0CYXpYi1RWShrfNQNZ8RjQP7jypToOmrVjGLV
	p6+imJqkHx+a7JkAYKVRrDrHaewWFiW8UieXb5OdHGSrUvGim4kSZ6tm0S78lHy5ZMlGklqdxOX
	KomUSSHv/UY6HpoxOGM78nUEDB/mDypCVLhBW2zYE64I1l2dHKKr4QKPCaTWr0K0b4SvbrbFqQc
	V58shpZc4irq0NO2AoooEpNViOYKoFzhU3aLeO4DTvPYefYPrf7b5F2PIHylfcuisVmIDI/3f0m
	9pVeMgdoTzwbL74BpXzP2RHoCQ7jrcpWkszi6zN4bRAb8JgwUMYCJYdmogwIr1jF3uYu8JNrQ94
	ebaYUp8whYAokrUCCGCBdOX75Tvxrxq3ni4R9hnKBss4amMwGVKy2/aZLEQ9hrEHvUs+g
X-Received: by 2002:a17:90b:5830:b0:3a4:a850:6982 with SMTP id 98e67ed59e1d1-3ae89749ccfmr988542a91.26.1793338039474;
        Thu, 29 Oct 2026 22:27:19 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm2421027a91.6.2026.10.29.22.27.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 22:27:19 -0700 (PDT)
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
Subject: [PATCH v10 13/14] ALSA: virtio: synchronize staged capture accounting during RESET
Date: Fri, 30 Oct 2026 14:26:28 +0900
Message-ID: <20261030052629.27742-14-mynameisjune111@gmail.com>
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
@@ -1731,6 +1736,61 @@
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
@@ -1760,3 +1820,18 @@
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
