Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461697;
	b=GBB2UAHq5cTzAv30JIM9BEdB/aw3sBqTJSbH+bXU3fm6yi3Md28uQR2IfmApamL0m9Ox
	 xrMwG+zXtZZ83WGQMxrvpfhu92YRL4d+wOyJCpUKTa7QRG2n6DwZuOKioKoSXIJWbow/b
	 5+tBfSdekpWFX4ZvX4iueaa986Na5t0jbQmgIdd1OKvJ4b7H2m+6DH4rjW/grJ3z076V+
	 EXA3rG1TLEFz7x2FuUNL5Eh38FeZbcaihPTZvN++5JpV629AiCLZ3jfsK2rCTNrvVf8IB
	 74zy990h3w7EQTopIwbVpH+VuZaRFM+bJx3nfm4+jfJy6WUvIVOWBSwIPhlO2aoTGTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
	b=ymeeiq0kmyD90RU7YpZrAt4CJUX79Q3cPD6l8sFgqdAyB6OR4EpQNuQk//IWK5oIqVeP
	 PznHIjjcvtiGs2F7gXJK0wCEV2F8+ydC/PxqTjLlNuIu82/1Ys83/UCKXCSIOUM/Ijw/E
	 qvyDJIVqAZ6r0yasi/aUL07qrrjFh+BKnk56FZLuSGyFx5t+bna5QlLLEcVkWjZCBslUN
	 KJT+jJvMk26GNV9y2LwiWSJ++4Zkp7wrs5ysdulUfbiosPO+aM53l+f/aKSMrHjjOllcS
	 zQdK8Rltb9MWIDml5r7xiyBzef9gSlKRiV+B0/K68VLuChmsAPBIKuzRs5+Wb1JyFEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vRIamVfu;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FD606A33F
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E8FD606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vRIamVfu
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1438d9363fbso318882c88.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794461695; x=1795066495; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=vRIamVfuMT/1fAyc20Ktb0wWyPLbKMvAfyKF/MpkQ51auSHiuP5WSpNWvv9z3aBGjZ
         3iW/Pz89ZcF+f1c9vEJyyXFRgmTkKtYeZowmilJR3mBgPdpWpOeCInzJXQCvRrzvD3/7
         Yq4B6sRLFetZV9+ImIBsZz1jBvQS2zPeGoReG6rdnW4MIiV27rN+wwXxhAJ45uTsUtl7
         nL/H1D9PU9XeeKW179udbPq59vxwjkyCdHR90ID8VBGZjojyR0SJRbWd3yK5zeER+4Gn
         HGjHwtpATHmFRIVgmlUxCe9wiXCKWwZF4XqgXNeYsK6mvXw0BFfLQ21Hk3qsBNuYkN7D
         sW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461695; x=1795066495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=BjE8jfLkyhF+bZfyfLXI3YgscghV/abNyvEgVBsFIES8pHQtkX94AQlP5Nrqrmp6IR
         QXzP5l2JZEnDw2nSEdK/yrXuJmKTboRF2hUpBGj4K3eyMxU3Eraq9ood1TjZmZFZuDNn
         PZT8l0bxbGslIyn8rQJRXpPNXZho1Ni8ERsTTwoo4dM9+io+sN+YZDDX7GprEpF2/quK
         NglhlLp7666bkSnYH5NrKdS2V6szuLU7zXvbFFKz0GhyXXwmHyNtO+fo+AlGQuCf4I8o
         8YWqyiDzz06gD5jjy7HIY/0ZGUzfEJUj+nXzucKagrKDxkg2bPg4QggiNs7vaQumGKr2
         WqTg==
X-Forwarded-Encrypted: i=1; AL+hErHpJshRBTVnQ6gcDXL2H7yRjLoSxDywylVxqt8CrkapAWoNlntAO4aPuRyDXcBSIKrNhpFzuamyhjBFQ6ZTcw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+hq4Grk7n3OAe0mh4esBZDmLeA73WmXz4D7Ih+qgvAa6WMceQe
	rjornqtW6uB0/QpEiyLxOfgq2I+SuSgUoJ4CPZ3hasFfi8H2FoyEgB9K
X-Gm-Gg: AYBFou0amjHYE1BtA0q/bzWlXiQL4NX56h6WhHNZRzK6+bhv9RUeUwGfzzYpro1qeUR
	O3epfKgQqDS1U4+oLJvK+eHpG4Lj/K9AX1K/OG5aMnIsC4VjAK2mk0S8PnejTaqcOf6YMJ4sJzc
	iGzMKXOp09DgZC2KBRVlhAj7v23zETv1l7FqwIxdO75XJx6mo1LPpdmb8cNZVUgZxeLTh6fF9Vm
	pEn16XvhHV35tdNoxo4LvDOij4xmMIvDF8zFMfwpVXRUHdus8FiSTTLx4+ommRMd8duLOfFyo1f
	0D1m/LFIJM+tmf6vIrDaPTouRwMqmQss85GLkeCJlPWYulU99NSYsPMC8kPmcIDY2F1PHIlh2Cb
	J4t0Z8VQTXg/MeO4C8x997r+fTwjglg7K4D6t2XAOZM+pu7tTZyGvExJUtkGAvO61M2Cc8U0QMl
	Up7M/lBiRdL4i2M6bdleVCgXW3qGMKTGbkRT529+V7OqBuwphCLnBHKFt0qt08lfN0X9KUoZXxt
	5Ai/W00e9YHQFOG4j02XI52HMC+VUcGQGiIH8vN92WlaA9Vmi14MvTALXOXbkRs7sL/jUekpqHp
	ihe3pi5CUDgKfiDRzu6W8vvc1owS8SAZckpb3l0SUhtB19DOK/lEnvxlcakH8XIR3M8QKc1zuDp
	2goA5Q1BFb1QmpyztkL7IfelBfBpoi0Td/r3Dm+c4TdqtlbzkiGRoGj1rhhNalihy54fy
X-Received: by 2002:a05:701b:420f:20b0:1b3:a87e:8040 with SMTP id a92af1059eb24-1b4f5eba049mr1425278c88.20.1794461695410;
        Wed, 11 Nov 2026 21:34:55 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm21953240c88.1.2026.11.11.21.34.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 21:34:54 -0800 (PST)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
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
Subject: [PATCH v29 01/17] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Thu, 12 Nov 2026 14:34:30 +0900
Message-ID: <20261112053446.73504-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112053446.73504-1-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
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
staged-capture policy sampling.

These annotations do not provide a transaction for the entire sw_params
update. The driver serializes its cached policy and accounting with its
own substream lock.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/core/oss/pcm_oss.c |    2 +-
 sound/core/pcm.c         |    3 ++-
 sound/core/pcm_native.c  |    5 +++--
 3 files changed, 6 insertions(+), 4 deletions(-)

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
