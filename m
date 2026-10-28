Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180537;
	b=oTj6c/I/kMDW/R10v3wMfMXe6spbGsl+pkWo3TzRYaAqgixLZM+MRrLPgMmYIJCmm3QR
	 yMhsScFueCLFYz69VFlE6W1WXkxE8pDDnR2/dzBElfm5Q2l+wEgCUNeKnzymDs5LE03IL
	 rskB5Z2tu2/xzDdV16lLyosqivyMDSE1Wuoi8vo5Fni4hdwd8oECWwi6w4tOC6XDd4eoO
	 WY9CZg8gw4pwO7YngH14r/P2wt/Ihh04Vj0VAvkRS64wBS5o8szGMQrfNC/rLbXfvKZ7Y
	 enJXwhC//ksC+WQ2VPEh9Xevsmce8rebiCAEXhBs6hNSu92A+i9kR7eiEE8ZVN+d2rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
	b=Wbs19bKzpgdkbPVIfyizXsEPR2OVe81KnLJ8kbNXVYFLpcKYeTRzgEF9+9QqJyspcCh9
	 dQc4hpX1g1SpAkCUUiomdo+sRMxBgiVhEH7YM9xEvYKhDoNVimVYc6s6UcqIzMB43eqaN
	 Pd+IPofU/UL2QrzwjajJYdq5oWpwxvmYRDYF5XeCwhbU0xxLlXAhnnegVMDJ810vU+9kE
	 lNe/3Hi2d4Jk+UPSdm6qhcmDxOtN8L8xCsfgpgjhDPCM6g2+rGJm4LchwBIuFe61ErmTY
	 E2A3QE7eNCG1vcF+Zh6NhxqfjSrlcnIjpb8Mllh269YAX/Wcu+LtuSFqvw1+O2kX2dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ONVPv8rb;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885760A3802
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4885760A3802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ONVPv8rb
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so478834a12.1
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180537; x=1793785337; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=ONVPv8rb9/EBtHR4mk3TakB3+pmKNCSi/ax7NuSk4Y7DjzDDN082XOOUUiUyHs3Av0
         FFhxJwkLzv86Spud+FN9rk2orVoUa1kwn4kKXreIfQWWH6u3tmkoA6Nvm6rnfQ+xJRFV
         pdTI+B7lQBuG2vyU776+U7TwL27qKn3+R5NFYDoNNg2fCKYVdhKrh73r12WMt/gd97bd
         B/c/LBd/i+U+3dmHgsOj0/Fk1084ptbFXdUAW+0dHkZMfXf8CQ5XeQ7tIgQDmUT5j5mO
         oiV+TmpdGiT3FYxD/cDsjNJHMiRuGji3/L34JSNe2yDhiPZ3+UYIBBzFGKVBgMBT5heY
         zOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180537; x=1793785337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=XWTCnSw7TQqMSLbJqF72FpWAaacBsH6UBB3rJ081ddwZ3kgmFZ/o7ULC5UsGzxaBQu
         h4/7Io7r7FBhNbh0QxjzzTzhXRM7R6FUhA0m8eGEGLTH+NGrYA7Oqa82CapNeUsNwDx2
         SWVqTEDnEkiEgICQlOUd1vspUz6Pu2I7CmvrhEk8bP/tAHtrcncwhqDnyLiLQ8QZKY3A
         GrGW9KKxwdjgVyFX0mDvEG+YFQVHiGeKOdhwQwmWu94E1pFJ1XDWbL3H06uHezq7US6Q
         q/X9GTF+TEAxwP4qO/je0p/i6r/eMPlD/ngqn0hlzJwIgoDxtI8YZoEt4ivWu3k+dZoZ
         VxOA==
X-Forwarded-Encrypted: i=1; AKwUvBxi6dz+KGB5smiacpI01q9B/rw2TUGo7D0DkH0YoegAIvyIeWJeI22QeqfPieZoaKne3SAOIF0EaMoLCfx/cA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLJb5bWAzvufWjjhfEoFco6mZfwjA2wQXb8Q2ZXxIgxlOilajfT
	jsEnijcNdB+PoEKezp+n91DW/eeJfhLP7COoiLVKMQxErdHa3JtSfr1G
X-Gm-Gg: AYBFou0nptozUSL18lirPh4AnIchJ9FyAKXEklgTqnm9Als39S7/HqP5mg+qZkWha0p
	7TvIqe63Rn3lRFQuDvNyoKwfFtowWAuzzyWK2wnADBVRIVLUq3T8+OauBFgQ6VJFNNhW1uG83Zl
	23SVa05mDpEvtEejkb8CrULg/XxQv7edz+O/UuCOuTMQCS2h8YT8Ifv+JGPs67S9XYLU4q0Hixm
	ns7UT5kbYm4FVq6ktyzdKIRP0DPOpr1W6CcZsP055G19Qv9UpnEPZUOfit1rb0IYKDbiVADVIAm
	UtzFNzJue8gt0Z0Wh/SD2zPTKQqvvNQEWyWEX89g9RrktVhl8jYzMFWgbzb9Ssif22wyTjPFHJz
	zszlDiyfBY8TFV8KshVJJt23ZOcHAHY01uursQerflrvSrsLEBwB3mvdKwVoS4wD/EPdvENmXfu
	9sTc5T6Dk+YLlrU3BIR8QB1OwBqDlURTbiJXmSjPyG5EJqxTr/8qDGfdOvOWWjd6TGZLBWilB5Q
	KOGn4p76MnHS32RLtz10Qh6ANbUsbugOopJmwryx4LfgyEe7E6uGcJLNTx/6DWK2tDEFo+yzQmw
	Qv+dPEDi1eO1asD4GsQe2Q5E7GoePksbq/zzrCsOC2mXIFVNx0jkvBi4ehfymtMLITY+54Now5i
	YZlYDDRgue5MzU2OjE4BbVf2B2x2MM5PRF+eFypIy5kcPQX0eNK/z2SwvjGZW0r0zilqU
X-Received: by 2002:a17:90b:4b01:b0:3ad:ba54:c3d6 with SMTP id 98e67ed59e1d1-3ae5c6c4316mr584601a91.1.1793180536606;
        Wed, 28 Oct 2026 02:42:16 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a93b3f5sm2242377a91.5.2026.10.28.02.42.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 02:42:16 -0700 (PDT)
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
Subject: [PATCH v7 10/16] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Wed, 28 Oct 2026 18:41:26 +0900
Message-ID: <20261028094132.20364-11-mynameisjune111@gmail.com>
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

The staged virtio-snd capture path needs to sample stop_threshold from
completion context to distinguish free-running capture from bounded
capture. Software parameters can update this field while capture runs.

Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
status read with READ_ONCE. This pairs the assignments with the driver's
READ_ONCE policy sampling in the following patch.

These annotations do not provide a transaction for the entire sw_params
update. The driver serializes its cached policy and accounting with its
own substream lock.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2958,7 +2958,7 @@
 	       runtime->oss.mmap_bytes);
 #endif
 	/* In mmap mode we never stop */
-	runtime->stop_threshold = runtime->boundary;
+	WRITE_ONCE(runtime->stop_threshold, runtime->boundary);
 
 	return 0;
 }
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -422,7 +422,8 @@
 	snd_iprintf(buffer, "period_step: %u\n", runtime->period_step);
 	snd_iprintf(buffer, "avail_min: %lu\n", runtime->control->avail_min);
 	snd_iprintf(buffer, "start_threshold: %lu\n", runtime->start_threshold);
-	snd_iprintf(buffer, "stop_threshold: %lu\n", runtime->stop_threshold);
+	snd_iprintf(buffer, "stop_threshold: %lu\n",
+		    READ_ONCE(runtime->stop_threshold));
 	snd_iprintf(buffer, "silence_threshold: %lu\n", runtime->silence_threshold);
 	snd_iprintf(buffer, "silence_size: %lu\n", runtime->silence_size);
 	snd_iprintf(buffer, "boundary: %lu\n", runtime->boundary);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -871,7 +871,7 @@
 	runtime->period_step = 1;
 	runtime->control->avail_min = runtime->period_size;
 	runtime->start_threshold = 1;
-	runtime->stop_threshold = runtime->buffer_size;
+	WRITE_ONCE(runtime->stop_threshold, runtime->buffer_size);
 	runtime->silence_threshold = 0;
 	runtime->silence_size = 0;
 	runtime->boundary = runtime->buffer_size;
@@ -1062,7 +1062,8 @@
 		runtime->period_step = params->period_step;
 		runtime->control->avail_min = params->avail_min;
 		runtime->start_threshold = params->start_threshold;
-		runtime->stop_threshold = params->stop_threshold;
+		/* Drivers may sample the stop policy from completion context. */
+		WRITE_ONCE(runtime->stop_threshold, params->stop_threshold);
 		runtime->silence_threshold = params->silence_threshold;
 		runtime->silence_size = params->silence_size;
 		params->boundary = runtime->boundary;
