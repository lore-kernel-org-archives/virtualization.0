Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458126;
	b=c5743QwdOTQbBToO5fjRzVhPBYuBDkGr2ccg0JhKMDUfImoaxi0oOxErD/gr6F2MPlQM
	 RGam2T/mIDK5TMCt9gkFpcsgoc51OVpWsUBqXxccOw0xLZPR2VXrdSmd8/apNBsei2kje
	 4rRWIvv72lPCWaEk4p470G2g7Yywiec+IAr7/IUmOzwCj2HoGRgcbLGQepYfHcQRC/6kE
	 kHdM+bpSVTDYTi8eiJI91W15dr4Ael6gTmkZ51mE8iRdxEpKRvHrf4hWYfDudfKXG1J4L
	 7F2tcWgBi+CaYpZwOD3C9GhpQGxM0bt2cvzbZ3iEg//yoqGgF1UMZ8qez8GS1myILwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
	b=0WFjOUP9w+Jxgb93MqCO1TyHhz5RuXmhBKF352E/vNp0aE+aHpyHF1Wmw0c6tO0CyVak
	 SMzafG+JmTwLbRy3X10lPDI2ulmREDU6KfFHh8LrIwIMbMWT6+8NUxWk+P++U8E1yVUWf
	 bc2VmTmeG2imF4jeVCTbHQfbe5RU39mJzVrHRSeW9sWvYCMucBY+uLEMEvXTjfU46D/k4
	 KGS+I6Yrku1fH7SnNdXubHf+V7DkwWBdQyEEIm+mvbcSyzRpx/rcd99mgZ+q/5/PBkMxS
	 pmBpjcZZFomq++bpmz0ujlQzWKh27r+EdttAFerS2Y8E5PXlfDD6KRN+9ZmdD4k4bfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sDJZfFwI;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88FF606A33E
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 04:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E88FF606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sDJZfFwI
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so2254162a91.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 20:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458125; x=1795062925; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=sDJZfFwIV/AiYs/lpwMQytoCzfi7AalPob+HFQKNm7E35AvLLLDw77mn7J2VXc3kfo
         vfArXy6978Nd07qXwEmCz1Sadu0LR5AcyZrQmo7jjWeeheOu+TUZ9jPDx81jsfazDWao
         D5jKz1oZSrNvl625DoDMA7MPuKCgsbjpl/k2/9HSMntrucIhORDZiIOf6mvsy281Tnys
         Tampv3v24gM1uX3xZcHsIdXpmfoBKqCCjE9+8zcPieySQa26bO5QOV3fTYfFyR0zzTi7
         7+Hi7fJelX5fMAe6DQ8R+czqwFot4OiD9J/2qt5CJJb1YYkWIigUT2Z7V3Nyz/bw5tmD
         PxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458125; x=1795062925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=0Nb18w9gR22JLHeYulICeW6vId9JRdPDGqFb4s667ws4YGHpBnfFBBOHDK6kzmqsXZ
         pCTCiv5IT0A0TNIWiMV2T/8xi1uth8aJeRV+1ltMGBRPjRKgLGv/i6POxkxOIaqugfn2
         zHToHY03l5+5snkw8W79TbcuUkNrMZtN2snux8k3WTQuAKSHqOjUDuDQeeWkmiFnosld
         VWbIEEdpdUb7gQiqmxUtzJVHAqXOSkBjIeXOEklPKr1ZwCMEohOAchKZi6fQ3LUkNJO7
         5GBUTiikAGOvvsX/DQsJpu0xcDkz2RWqCVGBswPsVvvzKgr9J/KFeNrTd8IVACuPw1qQ
         QabQ==
X-Forwarded-Encrypted: i=1; AL+hErEq5vf1+DPBsfWPgJMLmL1AT9Nn9dvjSOdUb+V+VHBtSJbPJ0Bn94gvk3Vu1kauuDDH59HoMiSkK571+ATJUQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+jSWnX1js5qJwQpMymYiLHZ4w433jewsKrqtRGo7XHhbz+jW0T
	ZhwBasiOgu7+wIfXvoDJDRzWhDUwOLJsh1Xu/RIQsHdnKHXLj9Scdv3S
X-Gm-Gg: AYBFou3zH2SABodgcnWy9XhqBXhECx1D+pOn6SjyrpBx3jgWXFblVaYWHMDI38AboIs
	mIw455axvcNeLrKXhcLY5CVSGpmHdg1srN/MnnCDnQPybmA3mpPy8JoVkdslCHIupOibp0JaJ8f
	vlL1B001fX4Rb71JhGNqTeAFeno4RNYQV7TQVJW/YTzGvELG4bVGwpIm9EUMD3iQJBFsuce5YIT
	ZKtUloZLTmy/bYfQ/qvh4OQCRD1HVrNTrhy9R/BZM6z6r6kpS9R6dNbn2MO8pq6NSWXPC8Is0zV
	dpygFRk6JkYpEoSaGO6KQhlqn1LQkRElxN2MpvXpFfgAiW+62+lD+cIq0PDLQmYpq5fTxdN86wh
	9vqB/74fO1r+bsRbJnxfcGnRFM16QZv2ljyS1gPPwMkm9IY2SDZAszUHo8r2Ay09hlTu/hkmFf3
	ZiGznoh1qWkiFfW3jtlqICVm9Y0elSwyy1RzaIROBxmR+kmi5u1RaDO4y/UAhO+mtSnkdX61vfr
	ydsAwDKNnJQd3CVVK+MAzVJPkXxl11pk3+/ZR/oe3ZlEFL3FPs8a1JDhrGDy0KreJSBu21oHarU
	7PbmhsjPMAnT+JIuoKP7ahWBWH44wZPfu+hE2lWIK+WHfjYeHSuKvxfUHi15wUJW9ffOWTjZOAT
	V9GoT4HW0+d9XAOpCTnDaSJssZ3AeRNDV/K0uIViQAKFbhEc=
X-Received: by 2002:a17:90a:ec83:b0:3b0:a38a:6715 with SMTP id 98e67ed59e1d1-3b182f61eb7mr4107773a91.59.1794458125200;
        Wed, 11 Nov 2026 20:35:25 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b287sm2470466a91.15.2026.11.11.20.35.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:35:24 -0800 (PST)
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
Subject: [PATCH v28 01/17] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Thu, 12 Nov 2026 13:35:00 +0900
Message-ID: <20261112043516.37010-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112043516.37010-1-mynameisjune111@gmail.com>
References: <20261112043516.37010-1-mynameisjune111@gmail.com>
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
