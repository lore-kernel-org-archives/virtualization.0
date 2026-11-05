Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837366;
	b=cl2t0TQm54u+CN4l81O1qI/0NBDWbXGcuiSYKCaEKrKpNTNbjbYmp9wAz2bUEz+hfWc9
	 CXgi4mqpr8oDXxhsENX3WVzim7ka1F56eBP4pRO+lFYU3Q6mImqlT5iOt4LjyNX7RqnIx
	 KSQF0N/zllYzYhFs9XAxDPq1tRMIxmcPqJZiP+LgAsusFrtJoy6olHk+8Xhtw38LKSkGe
	 WMLyJmTigQuBmDi+j55ZZi5w6zj+/sARB9xt7K5MSTzyaepPJfzy+hv8rkmWsO+2wKqTs
	 rb7KxuGh4YA/kN17xZeaVNuhCx1D4yA0WT8sKkzeAcQMBdTdJ10DXMF7uhH4fRHyqhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BWMu6D/YafB12/Y+mikOxNZXkHRbVUuoM1lrNSU8E/Y=;
	b=RVOJjiAVNTeuXnHbZsoitSYcfAkATUsrW3+DSe8PCauMIsysa2xAlWttwvXmYnV//P4H
	 ZPDNHeDAog4pvoEIj6GsiQ5xIZiaioOXuEDepivDzSiSqhLXdW/IipR34Lt/Oy1E9583i
	 S3wb7g3qcISXiuI8W4Q/nMgc2tj6QMdnaETAkXMWrhhYSTcQR5VU+D+VIFw9N4eftdRNW
	 Ji2afVVO0bHKSu7JtsaitDpHUXkeFQtCvVbbJ+Vgg+MowJ96c2ocT84vFSWDuUxpUWHcr
	 4T7n5M15GjRPi0EBMLMFARTnYNKXEIuAl0x4U931V6GHorh/xTUFkuoSxK45qjtzGkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VVR0Lpx6;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD6E606D801
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CD6E606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VVR0Lpx6
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a06c60065fso796288b3a.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 16:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793837366; x=1794442166; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BWMu6D/YafB12/Y+mikOxNZXkHRbVUuoM1lrNSU8E/Y=;
        b=VVR0Lpx6Nn5K/QLH51KigVwDq6pUPBQ4dVX46aSjyo0gKCfMO3AYhv9Vc9RrsPUvps
         ZAmnVK/hB7qOns9JhUHBBXGG/QxYzDxSYJBV270Xk45lFmy9Ghwj3YDj7xaBLlsEmS2C
         mUPAbgqBTf2vpqCAhkYiQAbssnrSnhhscjHT5+I3ECRKUTvIFoBE25tGGTlk+N1fZ94y
         KOZHPvXh8lawuGWR7NaoeNaE2nUJRXZTinA2XLr/4C95G+Koq83Kb0PdqTGUEUstlWcp
         oRotsPfjH9xFnzKja12pKKmBvA5+VYva3Qwx1fwmELPWT3rcn+Y6T4vxhpmjSjtPIHkZ
         jv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837366; x=1794442166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BWMu6D/YafB12/Y+mikOxNZXkHRbVUuoM1lrNSU8E/Y=;
        b=LRagiNdb5t8SetlHqXvVafuGQ6VPAxVhRe1WsmDU7e4ZakOa0Mcn5IYdwEp6jzBw28
         3qVTqAVhQy062vWugDEzA7J3TtvbyyA1ScYlT51OXF0hnD63vFGGn3iyWRe659K1TTgP
         IL4LEyXJ2Y3xgU778RmTP2WANfMcIBXwgRL92oCLY3PUjMY3a/GO0C+1FvJss0piJ2jH
         7nk83ha48BnaWkgkVOLm/s9VfDOLtjlfMnPgYPg4XePzlbsVLHrxTDTgMR3Y884N4X9o
         GnVTEsyHmHFGve/XaKxkcr6+fF3MZ0c0fjEVq+Rp+h3Hy3FZq9inrUJlDwem1tvYWE9x
         3PTQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7RPTcj2np6xAsbq2clQMIhi3zY5zybi9Be6pAn1Tx0OVtDD0EiAmCOC8CnwxDu8YookUpfC31o5UjWA2q3Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z8qIGX9s4xDkEk9v3DTbbfDPS2eQ6eHL61AFqOqQP6ycJU0H7rw
	ZtsRQTbJuf83oBue3gGr6J4qJmpN6agi6BALGM1Ht+97JaSE7REhKMXo4uDIJw==
X-Gm-Gg: AYBFou22DnmqaRb67bwOFTYI50w4SJHMev1TItE8auzHJwRlYWRRWj4aBD2PvCuNMLC
	YsjfFpYwM4k5xupx996lJzdIIh43v6SDlRdqKDuWN6KtRPysDU5Af4ugHJUDt53NGtp0JdvXBRF
	IkzK1tids3/e5ZpSZO8uJcTeERUVYgayECZ9njiEtZe5XVz3snw3tkvH8zAtoWwfc6x2TJHLeWV
	7FDDMI0SryXVZJV/QyNRpn34F0Uemt/JXCbcE3Q/ylgIZpCh0+WY4fj5tAD5XGXicguyqhWgLOf
	9vIgccfCqUaGXv/M40+qalvacT+kCNfLYoha00y87CMDO79F1yAKo/T99edTcGqumZcfiTbhFmf
	NixDQhMSaCps1KjzBgRJWH0sy/OmhBKUiP4dPJO1Vn3d4hN4uzPxMZWe1N81+Ma/BIm3HX4Dknp
	mQlVKF+Km0v4pjXx5UZvHTtyHkhn4z4xfx9vG7omOTrZWFKm0xW9iYRptv9MPHUUPvmfA/aQEqr
	6SAeddZaP9GNvHgsRbPjiNVVZCSMudnz+z4p5YwHdIpyiLdNiAY871Gcnr6ANmrYK1jd5IcOH3k
	umC+RlwlxmR3TLoa3sSRV24/Mh10BNFybmysf6KCDphvJ7Al3za0aiF2gR69PNXByZgIaSXkdL5
	X/ysqGwbRINN1O7Uq0qHewnanQAxvQbfH3Age/Cy2awQJ7vs=
X-Received: by 2002:a17:90b:1d46:b0:3b0:a37a:230a with SMTP id 98e67ed59e1d1-3b0a37a37e4mr2097706a91.25.1793837365788;
        Wed, 04 Nov 2026 16:09:25 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323c18fsm897208a91.4.2026.11.04.16.09.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 16:09:25 -0800 (PST)
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
Subject: [PATCH v15 01/12] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Thu,  5 Nov 2026 09:09:04 +0900
Message-ID: <20261105000915.15177-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105000915.15177-1-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
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
READ_ONCE policy sampling in patch 9.

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
