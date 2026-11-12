Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466180;
	b=OLY8DmgiytdVVPkPWs3kzoFglvPE3DIN1K0t0ETaw5ubq/vtRIeKArWL5VAlM0Tth5DA
	 9SJccLZWDZKYHAhnNWnNlplYmh0OoCGtv03/KON7+kf6+7a2qPjsUzhshUWUGqbP6zuqw
	 hc+pNu+lHfUEF2+anpqNPoCLwNTaJJQ6BOnPEhx8wGjklkAA5hyj6ztKLyTY4TIqCvjFW
	 ckSgu5/2dn1YmCawl25u5omhVvdbAjhKqnpadaYK4FeLZ5pgeMSDz92oOJxDoHXNOKzL1
	 Pnvs+QLMvhO/p9IiWTsV4psKvTzQs/GiR+K92ayh6LeiwqbPN25JFctit8lXY9XnHWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
	b=qE2F5Op8Qkt7ouk7ni9/jbi7HEc3Cih4yt6pyocwWCZ8KcOQJAI7Y0Zuqka0Inmw9Sw5
	 QOiV1yjA73sxscyGLrSD3ZPS3bmUCe4fnrfWFT2ECQpo2R2dEb+OUFOlkNCHCDujgM82o
	 opxviH3VNRbQvh2pzExqdPoUG2f7BR+GqAcOOGm095sz4NbRwGWcOd1b9eLDY00/9uQLc
	 D+53M45PgMiOYiYCdIgNIpCZspeUOVuWTERnhqZk8Zn//GopRt9OFLGz8ahDSZSv4iJRh
	 9vdUi/Y6qbEct6nM+Mtw8BjZ0a8cfZyCl6z/5MkyV+stsVsThQS2FihrBMg2QD6buOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RA6u1Mgv;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47A606A883
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE47A606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RA6u1Mgv
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b2382bf051so2256032b3a.3
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466179; x=1795070979; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=RA6u1MgvSi+ckNhy3/LE01Md7QMvMCk8nJDfnwcK7EKXgaQiat2cMKfQvIlsU2eeI6
         UPfQ0WoquMhONp072QfBDa66Kp+SKrNl2HMReGa1mihbXiXYG9CHwXOA1yPrKJYr/Y3p
         BwiguIi0TgRBva2AUJgVThLWO/LUyfArt0f385gYKoBg2LiZN7c246hRabGacY5aAZsJ
         wRrsedg08c82hs/Vs4r9vhB3dgLyRHLWLrDh/xnKr3nHflTE9ddQL42NIHalECMrgkq5
         RaNn/pj2OIMywpH1hHRDzd3TouPwX1WVxHeZJVSURgx+cHK8dwDU9kzXV9j6lZBdXpfm
         SyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466179; x=1795070979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=wprXvI0Fu+oZAbb+2YhiWMMT5tJ4Mr5dh7j91X9+QUBeAwh38OwB2c7AaTGlsk7Uls
         Rj2rltuDXy0J1ikfEtUtPU7neIbetjfjW/FXEEOw95yPvdTyIcZLE6XLVWnEUAsb8O4X
         3vmvDdLtpJWIo7oydUmenggjA/zZ+E39KQeUpTCIvGoHDrigUFE8Nb/bFSqo7tXEarPo
         j4F0tbbeBnnTlRKGzpFhUGGhXboKz9mIK4CackDk0zlRcc4jlFH3SMW4VMmATxnXGzMT
         om7DxEUvGu5RAxuN26wh5z26C4VwSPksHv/01OzEG+oGGErOLcIemwwfFYspUtzwLnet
         wdVA==
X-Forwarded-Encrypted: i=1; AL+hErG9Fz1d/feZ3rK3Jus6gAUHQTotHWZY+x9sE07UwvpqO8FmBY6T+aUYGJFfAoURgDybuv6Nfy8BM+Vdols2aQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/5XqnjODymVcI0ncV2hRmaCdtffUXRWDkyqpuXinBIR1QdbxPG
	5+f6CMAdeS0t/b6rfqvxgkoelPTwzMllk1AeM0Kcb7aQ9ScIdjkb9mpq
X-Gm-Gg: AYBFou2OaINuvSJHQWByVOTbT0pP0pkxifL4z5x48WsTuccZeXQ3uwXQ1nZWMyGELtY
	QteaOWcNKiik8RDz9cR7cCL4TbkK1jgS+Urrf6EZYfJpKtdkloHwU1z/P2kKdGuX+wUk1ZO6tp8
	Iu+qqFPzHNuP8ix81EcM8/1r2imQtZc+BnyjhgV6CMxVwdkhItD10cqAYGaOPhpjHWFCgkXJKp8
	7ft8xptFCKtlHPlRF7oNL5Y1hQ39ZpTxmt74cigjFbA9pkF1sKVAdCyQZE+qkmOIBrHzsmjZhff
	zC68cUbLm4YKZ7j1/rOaPGgl0zZ26K+/UTZZ08jNi06oSiiIUQ3Nwps8JgCcGEGIeOqfvmQGsG6
	uFgSumNw0vQ+SgH3UcvZ+gQkRq3Z1p+qB9bt+CKVKFPgr+SNpDMmg0tkEIWieAmheXQiD81gHdG
	47Qlh4RqxR5x8zKsyn+fDztqScqjdeLSzLK/cljaxNHI0itN1YtjViAoXF7ok/HKE0vJ6BfDPMr
	Q6vsZf+E6Yo+wVg2rjXyUcw2qujgwfKYhn6g2AtrDWgU0sxfSVJU5z88y88HL15hPle3W2BgNY7
	caQC25hUrMPRAGLL+lZQh1zmOP/SgBV2ZzHAFx+MnCRdmC0DTZH5ySMzFPZmtbBXY5pP4IHGmB6
	kKKvbRtW/1vGW6NWB2+4QvcriXRz3tBp2vFmsj/NiQ/bGlCg=
X-Received: by 2002:a05:6a00:3390:b0:8a0:76ea:36a2 with SMTP id d2e1a72fcca58-8bc1deef1damr4766908b3a.54.1794466179289;
        Wed, 11 Nov 2026 22:49:39 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab1228e2sm3097511b3a.41.2026.11.11.22.49.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:49:38 -0800 (PST)
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
Subject: [PATCH v31 01/17] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Thu, 12 Nov 2026 15:49:13 +0900
Message-ID: <20261112064929.11211-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112064929.11211-1-mynameisjune111@gmail.com>
References: <20261112064929.11211-1-mynameisjune111@gmail.com>
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
