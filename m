Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252693;
	b=1kQPWe6sxaAdvO/Acon57P7aRR5gQo8vZptpI0nrarLbAP0KX1WHAUSCc2rC0pC/5Ry3
	 UcGf7L6emkav09+Awmou3BNAlm0II/s65h5JL4MzOGTC1hP11jknNPavhEqgmTUstQ0Gm
	 6C+z5tJYS0gfcKRzOucUz4+ldUHuwxwwUQ5za18YinT4aLn3hwuXqwo0QwhRc5K7fKLEf
	 8JaCrNkEL0XyD2juehyPs3McYaYE03/QnhhybOYAYo47TW6KLcBvxtZDoRq2xEz4Eio+b
	 XJ/WA5/wQtiOczPDAQDHfI8tD86XBY5m93VlgKbgQg3Gnh/h+n0HdyuN+XO4bConUmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=H28URnKyaN7/kOHJ43ygrA1xfHZ+j0XXEmbGM+MQsbE=;
	b=5khKqNawOVsD2aEltUR/FZBw/eSTHez6t+UWeU3tfF1lDx0Pc1xwU5CpUOfxy+eTBFJD
	 66BmYAnVHK4tVSJNkg971c8PpR/g8fl8EMHoL5RZsabVwD41ptNFQxI8IT9H6XSoE59gL
	 QbFSnerArtLnrJY/clKli7A7lom448YQnaKsttC1lWuH35xRJ04PAHvnrrbUH7Q3GpdbY
	 +WFl9+3LCcfx7BP4b9jRgXAL5YJ5fbYZ+HjW4KlaVqDGAQWOOzrndqAsOuxik7PPddvWs
	 i/A7zPlVnRr5vb8XNWHfn6i42QPOh1IcDPGIA0pGlSnYooMtKzPhi29c7iLHtcIhyhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lzoj0fAH;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522DB606A329
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 522DB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lzoj0fAH
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e5378b281aso9273095ad.2
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793252692; x=1793857492; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H28URnKyaN7/kOHJ43ygrA1xfHZ+j0XXEmbGM+MQsbE=;
        b=Lzoj0fAHT0YBy8vG2aANPwv42lZpqIKQNop3iWB2sfMLTf+liQ4FmGMSwXnZn+HhrK
         5XGtjck0TUzCmSFp8u0qu6e6bSHw8yeCryIW/UQorwXQxXRNrW5gR8xSYMPyCKc9uQ4u
         Dmjg2X0XkSyS6l8/V0jJ7Ieh6YKcOvxMJngACwPTX1M074PpSI+bUL4cVb9dM2Z8WB/6
         CX2D5ZthcGk3yqS7Eg4iv8omTbbIHW7AGwr4oKrNQWGn09B8PoXSunyQpgLJD93wBK4T
         GgA1CSW8XCB8q5w1UDPNBrJAAzFMZjDZQ4NDVa+ZmfXaO/YYxzaWvSS9U/hbnq2sqOG1
         vODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252692; x=1793857492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H28URnKyaN7/kOHJ43ygrA1xfHZ+j0XXEmbGM+MQsbE=;
        b=W5eFl3+zMzy/hMseUX1WsOz1zwvaxqkxYeyUmO1JCW4Schyu4xUQoZMDOC+PcfMUy7
         670vT2qG1qGIkOUY2VTXpxrT2SOeGjWenrlbxOgl7vyp1pHo0ga0DyHvbu99KZy2lXbX
         e09NfRyY1YE2/EFA+XIvGXiwbaXpcsYY+bUlm0BAmQW1PiB1w1v0RJcH+zszwOYnWrft
         pzaNCa0VPKE5/9yV8oG3mZmByNTg8dw8Ut45CG2ygqEajocmcaf5orQ0WI4qE3bIthvd
         nGPWk+zbIADi1uJBvVGvZTrxFZTb2ayQwQmnXKt+nWQyTZA/s+3gCNFsCKUaC/8LP5j1
         DVXg==
X-Forwarded-Encrypted: i=1; AKwUvBxsoLJylRbhOrT/2kKfGvWwMwy8DUBrgepvIBkbf9OsJxDXmP6GfaIkX4SwiWyApVIJjQvjlvoxhlGlLiuh5A==@lists.linux.dev
X-Gm-Message-State: AFq9FYLJsttltoD4kdeKPuBubQgeYeI9jF4rj+M381koT38CrE7fkLMi
	GeyIyFcH9LntCCT3QhCVn8VLfkmKQEMe1iNu6+fM0ffM3I4uC5LDOxKY
X-Gm-Gg: AYBFou1ScrrpFGIn0h0CYkM2Y+JmomvxNwdRSVsagfcejv0BOWE6ZHa0rd/VKihBAQS
	Q9VmhBRdAuvD2aIR8HJKyXY9J2IubJZU5vyg+Q2XgCKT3iXoO/RY/YgCvumkON2vfKovfueAHj5
	AwgEHqK7qGwNWjtd7c/ySo5JmikzJMWFGawzo610rAV775JfjOf3nWDSuL4iMW2Naahu5ySZ2T2
	6ok45JcT9mv26MP//mXyAnfmSvOW9JtylIcBaF+rGqtZ3NlXK3IKfPGdXYauGh4+7lY+bpFQ5Ch
	zvgB/KmKYdX6ZLkwNTUJypEFMBhS9AC9hDQ1HeL0EYghddcI0xzRaWiOoPOUiImgUQas5KqdF4P
	pOFWqZEfc0RAdWtYRPfEL20M9Ke/6TypmfaDxRDGK6zziR5rD5LYAThhKIX+X4i54rtOXkf2EK/
	ugnu4ryRfl+sI6IxPNtjbsRWpmgEpn5IFMR9uObY1DIwueLmfIhO+MCESjo2aUd22J5j/E6HdkH
	McOZF2/SLXAaoC/GyLwC89XX6O6olQt5pK/yLJB9+UCJSV7kybb19fyOz4NZuPr1oT3SYDbJNta
	K8KOrTqP1i1RdlqPf2yjpurlAEQ56OUTLoBjKHSUJ6MFh/HyTYdth7m3paMPbWnP198Inm6Ld/7
	EmfMU7N0mwj8wAKvxI5T2V7uGdo/bHgpMd6BeAkertNAymU4=
X-Received: by 2002:a17:90b:28c7:b0:3ab:17b6:9a93 with SMTP id 98e67ed59e1d1-3ae58140220mr3556932a91.52.1793252691492;
        Wed, 28 Oct 2026 22:44:51 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e83127csm2433520a91.10.2026.10.28.22.44.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 22:44:51 -0700 (PDT)
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
Subject: [PATCH v8 13/14] ALSA: virtio: synchronize staged capture reset with PCM positions
Date: Thu, 29 Oct 2026 14:43:53 +0900
Message-ID: <20261029054354.2931-14-mynameisjune111@gmail.com>
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

Staged capture maintains private copied and acknowledged byte totals.
Its ioctl RESET handler cannot keep the PCM lock held until core has
rebased appl_ptr. It also rebases the copied total, which loses the
relationship to completions arriving after the pointer observation.

Select the optional PCM reset operation when opening staged capture. At
this step, ordinary capture and playback keep the legacy RESET
completion policy, including when a later linked member fails. Call the
common snd_pcm_lib_reset() before acquiring the queue and substream
locks. For a running stream, retain copied_total and advance acked_total
only to pointer_seen_total. Completions after that observation remain
readable. For other states, align the private counters with the common
reset position. The operation table stays fixed for the opened runtime.

Complete the core rebase even if refilling RX fails, then report XRUN
through the period worker. A successful RESET return therefore does not
promise a usable running stream. A device-generation cancellation can
return -ECANCELED after common pointer processing; recovery still needs
the normal prepare path.

This patch depends on the core reset operation in patch 1 and the
pending staged capture and lifecycle work described in the cover letter.

Earlier narrow-candidate ARM64 QEMU tests forced RX progress between the
pointer observation and accounting, covering two capture policies and
10, 20 and 40 ms gaps. Two 1-vCPU runs crossed the ring boundary and
matched all 3,360,000 samples over the following 70 seconds, then
reopened successfully. Intentional-loss controls were detected. KASAN
and lockdep were quiet. The current narrow candidate has not been tested
with VZ and MOTU.

The ordinary capture RESET failure remains reproducible at this step.
Patch 3 handles its indirect accounting in a separate operation.
Playback continues to use the existing ioctl RESET completion path.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -8,6 +8,8 @@
 #include <sound/pcm_params.h>
 
 #include "virtio_card.h"
+
+static const struct snd_pcm_ops virtsnd_pcm_capture_staged_ops;
 
 bool virtsnd_capture_staging;
 module_param_named(capture_staging, virtsnd_capture_staging, bool, 0444);
@@ -387,6 +389,11 @@
 		}
 	}
 
+	/* Keep the legacy RESET completion policy outside staged capture. */
+	substream->ops = vss->capture_staging ?
+		&virtsnd_pcm_capture_staged_ops :
+		&virtsnd_pcm_ops[substream->stream];
+
 	snd_pcm_hw_constraint_integer(substream->runtime,
 				      SNDRV_PCM_HW_PARAM_PERIODS);
 
@@ -1591,6 +1598,58 @@
 	return virtsnd_pcm_sync_stop_locked(substream);
 }
 
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
+	/* Keep ALSA's pointer validation, time accounting and XRUN processing. */
+	rc = snd_pcm_lib_reset(substream);
+	if (rc || !vss->capture_staging)
+		return rc;
+
+	guard(spinlock_irqsave)(&queue->lock);
+	guard(spinlock)(&vss->lock);
+	if (vss->resetting)
+		return -ECANCELED;
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
+}
+
+/* PCM substream operators map. */
 const struct snd_pcm_ops virtsnd_pcm_ops[] = {
 	{
 		.open = virtsnd_pcm_open,
@@ -1617,3 +1676,18 @@
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
