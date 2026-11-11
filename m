Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355554;
	b=flOHDAa1MahjmjdKwAYI08NPlDCJIks5fcwfj6Ra0jydbVYxp/c89S+VKQNQN0t2pYF+
	 lw7R75zdwToL3TOA5GviEuHtl+zrta8x/lqYaxDs9lNmDvpYVpjQ7suljhLDa6kTZ0EE0
	 nSuTGnyWjkHv9swyjycWgjd8tRKnsFSSCmVuEDMi3oaXSc3Hw9HJe44ufXREjUaORAZX+
	 hJIMoiHoCCYPTNcnQElBwrLiXyxswduOZ65Bh81/I2iW9HnGrMusodiv1eybWgCB99HXc
	 +2VgYQumzX2E8I7I7e8DnZa/hD6qIO3o+UXrfAAbS3kiveopNfnD1XonkM4dxdJS03Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
	b=dzW57bHVWzDacPKVB7jeAm5NeAEzMN4fkdd+LCDIndwMl61aVEmHE42Jf6JdEt+ogvBO
	 5r1qvMk+XvhuN6CHJgIBysvT+AP8I7vnTmWN5fx5UHxwUy2rD4YfaVOH8z4k1xLrXa3Pu
	 CdojUvXyQqTxtt5NKlGtu29PCs4HWfc1YYnWWSP0YT6OJZ8GH0Lqyd7Abq/EcU7+yHjSa
	 EO6HvbIerhXbHZb57avlh1k2v2e0zZy6b2BUW1psD273XNTT875cPIbd8nhkG32aYP70d
	 yuuQd8AWmS3fjTcjSlkp2UG8IlFkUtxvlZR33fkHIucYjOWMqUPOtOQDXyEECvCf0mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=udu6oaV3;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C006606A33E
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C006606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=udu6oaV3
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b179528d56so387771a91.3
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 16:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794355553; x=1794960353; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=udu6oaV3yQHynMaCVenISV3LoLNrZjwSn8aWgc6oDn6izahrXIx7bfv/PS9H38Stla
         AlJZrUR0HW2fCdX05wPXD+tq6XrZNzTlHwtfoKTfk/8nYPo4EP2vfI9ILagEEu8sv0NO
         +ecjqImV9Nim6McDRWNfnI3aiWbRwMdEkgpGjU5h0me2cq/c41Ju5jYbzX5V9OZzPTBg
         0eqBoXGUMWmTyn0ag0+nP6anKGccNBmVWBr6MuGBxvoIw90hgkJGeexXlPj4ZoTOCMhR
         aZZZVPybQYo+0F8RVPK25dApTj4NtLUWWFGP3mWYY0wBQQrtg6i/oKSslMeUZNh/DjS7
         /IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355553; x=1794960353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=wvuE+ix3tGonqcojYCAeafNxQ0j54wuw4CNgT3FHstNe4L06ZrMSYcnudGPXc+0zo1
         U2zF9TTM8J5VnEmfNmUDIXqyU0Tm61yiZ54lhlM0qb+ED17mRI4kRG9WamjEQBXV6cq1
         2fXrj8fX9g2wfVE12XFg5IFlonbX+yyEsBIcjOWs5Pr24qfK40hbXsBk+5ByjaBbTB7X
         Iskko+GbX0x+tkOLH1uNUv1mBPE/9vQG1A1xCQXaGIoU04xRKzCnNfVqka5ce+n6BZB6
         LBj7N7YuBPoIrl+k0BZJoDvavGyd3tIT/6PIXvL0Y9ia/6UZ9Q7Jp/yqzLoWXyMLSqta
         XaIg==
X-Forwarded-Encrypted: i=1; AL+hErFDbco0Z1Z7DrCcK7ARwpMNzfkU54eXJ5T1Ix5Tp5viyg+7XhV0Jv/7Xd6El2WgB+OdtsMNMIwsvpZSaGroHg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9LL+gv6AtZrcbd5YvqjSUz4UJUwfdSchYyA3EmBBibkIiCWajX
	T+WHY3J0MGPm1+bDzXvJqUktWg7BlcKi3EOIPwukctCjMlCYwptXLpWP
X-Gm-Gg: AYBFou0DwNW+PxGwaAGJZe+zoe4lX8N12YJWq59qHz2UmkGQUj44WFZz1OJWVYGZjkF
	uI0aSZdFDMC5AdvcrgskA0kXPV8EP4wBSJ+MmxxMU2Slh0A8z8SLsYVcl9CUMNa0ftm6v21Qo0p
	QbiWsqIiMKr6h74TYPM8ao6i9SlvY/MC51o6swQTKko5b4wJtgjdKrMw7ePYZCuwVUmeQqc4m+L
	jmIt63qbjggdLjfZQ9U+77NOLqZaLF3flhrcEJ63Z8FKw6yk2lUKmNlYJROuDFcifR41On+Ixfp
	fkaXUow8T9299BzUnmyM6hD5Opdd8jMnZMnh64fwL0t3pt9I9IOexhXpqVxhf/gfbx23fsku0m/
	nrBZy70+FXL0do9UqdLZNyM10XfpWG2t56ZPiJr0PkiuGu5hzTouYK7o4gSWKCM3QfjI5R/40GQ
	1XxEH3uqH7VxtezBejlKuLnupgNDqsoi9Z/Qx5dBWTYC2/eOy1hxyt62Pnm9Z0pWgofw7lxmGaT
	UnfyL2jwckP2lJ+P5PJ+T9RXY69xy8GTZWCldrblIrij4PvzNHjPRo9nnYeHlw3C5qei9XiUGBy
	sJycG3aJahAwqyHP13utL+9aOutpf3cQ186CwpWGVYAJJemg3VCJetz5XzLGXYZoFZ4FeEHFBjC
	SkES0FgHZlZbzv+MAmT64mCckbHpTimaP5KcyZK7UKt7O6xI=
X-Received: by 2002:a17:90b:224b:b0:3ac:403d:6239 with SMTP id 98e67ed59e1d1-3b182f45135mr614942a91.43.1794355552868;
        Tue, 10 Nov 2026 16:05:52 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1838e616dsm474361a91.4.2026.11.10.16.05.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 16:05:51 -0800 (PST)
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
Subject: [PATCH v24 01/16] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Wed, 11 Nov 2026 09:05:28 +0900
Message-ID: <20261111000543.28550-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111000543.28550-1-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
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
