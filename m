Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365826;
	b=R2XGQDSl51P9TKGp2c8HoIkHC2LwfimFUKhCCMBF9mrMDBodhFFWDBxgUZ73ilQy5kgR
	 S1kpSdG8Rvvl4ca8VuTdCZo77X7hnXz74hkQy0HNi7nXzQmLLrAbOuxQjt+qI5LcM38Zj
	 WwbVBKmkExUZS++BMecxkwgVbJ7il/odPXKWh8X3gVlwV9j5ksfqL3repGxTMlYaljxub
	 tf5iLB5YVEAmVoopEjQk+81xsz7t9CySYrzguZCPwZJo5cw90mAu5F7Yp4qQf5ZW0OEVA
	 7tcx+ePMRjZCjyS6p+RvEw7i44SqaNapqaxgvyJoUIWDNUXGTBwlZfupvIBkfrvZ9tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
	b=zffs+P+3GE1KAaRGZmY7lCYPKYrviR9mDGtRO3DkVp+xwHqqApP7ndsYze4bmkQhkZUK
	 4h1FRKV7sVbyQ/w4HIWH4C+bTUA+8rN/BqOu8KhX8dY0oeN6cjVJo9GgyVr1QK24bR4FI
	 kbUs/FAjjHasRQsOp6PHO3JWCpzk4R/aaUbKzK+f/asPkQdbfkUkg9Jm+lwZhmOyiJM1C
	 IJW4mqebUIix0wh3/xNGEsN6OpDRR79cWyCEBJGkEB8XCaR1aPWB3jBBVPRuMozca6pya
	 n/+sJ97kFy4sXWbO10rGMzuGZlMSHHKQajvh+pirr8v4YaDrCo9zGH0V2rlDYvqLjrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AAraYaDo;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A6606A33C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 02:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B4A6606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AAraYaDo
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36e795af1d4so2294800eec.1
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 18:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794365825; x=1794970625; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=AAraYaDolHvxdSoL4DU1XHr64XF3Tpg/8TpoqBVmtSf08BspsTrmF10zhL+SzmAwpN
         ak+A/WYni1P5tXBED8YefDrEueN5WZTdnGHaXu6Z4zqj1iYcTMFyOKBhlJu/E+GSLbtT
         PsTm/8SeDYPBesdyvpldzNF0q8vzCXA6skLZyZ7BXblGsZM+NIhXeD6HpuUcCkmMMGLI
         1NZ9r59ldfYSGcVnvsGKwKWKEIBEcQypOiFUiqu+Je8Oh5tpsHgyEm8VY+DzBZNdfjlY
         u69rdgq0UwCkDrmUwPjZL8gp/MzHgv0MrwL8dErd6R3HmKHcNg5RKX2YH9p2NOyz+YrA
         AFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794365825; x=1794970625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=R0Yg3BdBBGCkkzN9bvOJiLdNEPUFcGPbqtJHtI2Y56LqlbUGcsgLnCOb3TvmGbm2L0
         xsOo3G7Y9vXF0R5haSAthqZSp12NP4WVl1ImiqevXZBYyCJhgf0EEH8fELnYJgOdqCVY
         XEG7/hNo1kXeWLcsJb2iAP2Ve3nU5SOcPMP+Zkvq2Dq4KM1tZ77187IM3o2EpgAkPHnm
         wnu+f5wzhGZz8PdzNEnKHMVKFmYa5IeuUBH4cpD7k5EGqCF6uJRa6XQME9++u1tcdht4
         5H1yICfsWHXNhi+qnQ8KJCAcMMY43Gn4nTPoYzN+vXgDnrJC+g1ERoHli0Kl7MYBvUJd
         Tsxw==
X-Forwarded-Encrypted: i=1; AL+hErE7OnXgdbGriTt+DAe+0Alce+tZpiseahRwol7e93dywsZi8WRei+wMNpzxPTF4Jsbu1vaGZ5nOC8ff1l+h6A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+NAu2DR0gB0eFrK8h2fMchqMj5lEUU40HSfTbqapKpoiovc5Er
	11C2H15g3+Rok6SfvLqpPMZqePHA3W++jGUvKSZgYN+NB1YJMy4P7rkZ
X-Gm-Gg: AYBFou0r6MAqCaJOBxmhJT6+C5cNtOnV94KiY1/Qo/1kotNTob47N7o/D+0uvalCGJJ
	xWxzG/UULD4ykdXeRExBvMG4zWAzV3Ufjzn381EUyQP48MbJeAcpnywvAFbA+kxqq4a3zDbHQ7O
	GgIa6s7GO3TPAFZm5VV0IUgC+5VSNeeLpFC8Qx/nvbDHvjOueIMLKRXLy8tfeIjyYIOmEZ3QoCH
	w1ZPXKUReHxfT+hyea1Lbc61CCYFDGCzkejzPUOwf33+AZJxg8x7Psam+YssVSZwGOeQyE5KtZy
	piA2SOqbvsdRsCb0v0Z7Yf6W50pv1michgoQeYXHr/qarTiYfHyomqK2UGHXhCZ55XFmWZaTg68
	Fzeh5mCx6tkb4OcwJa6w1wOZm2wOJ6D7ajtq9UkEMzts294MvZwNkVIpD3/4gz2/OFp1KA+Q/Kc
	SX3Cx8U3d1qLl51fOZM22v8cWjCMAKVMrJATp1r4neiALsJ+xgjR2bg3XcB5kQQlaoZigECymBA
	r3jFNqDgYH6hd9lNnW8G7D4UYSWLg8pFie456MgvZ1ksF75/Kp8S3ssC0iJx6QUwfITlZIdfx4H
	PZ45KUNxMhrVG5u1iZsGq9gyD6qxzZS8tBrLL1Q+1WcY5d/Yu+7GElh3Zs8H0DYTYpXOEa0N55B
	a8PtXFBZwfK3bWwGGgju9iZMVgdzRQnlxHYzpvzisAe4zkpQ=
X-Received: by 2002:a05:7300:560d:b0:361:a195:c46e with SMTP id 5a478bee46e88-3766763b79emr1918799eec.1.1794365825118;
        Tue, 10 Nov 2026 18:57:05 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm12390018eec.17.2026.11.10.18.57.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 18:57:04 -0800 (PST)
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
Subject: [PATCH v25 01/16] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Wed, 11 Nov 2026 11:56:40 +0900
Message-ID: <20261111025655.63951-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111025655.63951-1-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
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
