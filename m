Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252668;
	b=BBlRGm6AvDV7tZs0naArGGa8Lk4Ugq5tfjRjcvRJJaC722CRD9Z/j8XzPkLzdei/LKtV
	 QOa3OrossSoNdzJCsGF++ZetoTVm8pq+pXGdItU17AdT0YQDQvHLtePPMX7C2u9icAJdP
	 FR8J4yX7yspkk3xy7n/S6nzrJcAZpIiUkuKCSJn0u7yzU6u2ylCyGeMDLB4/IggALH7r4
	 1xz46+h18fHaqVWXvVm1Gy5kVoOj9lcmzFCmQiCgzAm1y7m6/f73WU3eu7+tOqz7RhOdb
	 UPydjUOC8S1SR562CDM1yDv+D9sSDmiJK1LpQ+rtnCvzMCBvaWobeztX4iaK0pn7nLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
	b=KE7uNj4/h6ug4L+1/ZbM4ln9O+1W8EdKbztfKk0SKi1HzfgRGD77Sas5m4FCX36ZUq7m
	 uIsgk6eCdmLRfDC7wEhVjO2OI01kuxuaWfRVtiEyBPayghYaEfHBFCDC/fuGQPYkzpEyX
	 o0+woQhnsfeWfOfInnpKHwzq9CncLT96tl4ildrodwnxLKcduCsjMXmApNKsiPHEjWObt
	 d/Kryyw97CMb9i1oFxqtcyOGUAl37lRtDdfp60EprhovB/gzUT8OPeXhbzjYfLvWf4zZW
	 rw5Pb9Bk0OgrMSnxAd3iN5E9sx1++GqZeRGOQkrAyRncdkQsFxez+bIlJCvtKnmbZKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uaLqjntJ;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FA7606A326
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77FA7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uaLqjntJ
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc751eddf25so1181184a12.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793252668; x=1793857468; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=uaLqjntJ4OsF0bT69YDh3pC9utSwcYYK2/qE6vyPPu7bYxTJS21/B7uer5zRf4ndn7
         m/jNa6ldLiyBl25Ejvs6FSWAEEtFjVMYUXlaHo8V6KXx6PX4DOz+Z+odwzfEAxDEalP7
         y2HKBrkmd5wi878cV40sQVs0xv2tSbZeeasEWTSrIZ4zUUYe1jNv4BHaAj1TtZYwkZ06
         AKEKK901MRYHcHuP819TgtK2uqCUw8pB6dmA8LA2V8TPjIO87zoEOWPqXUHCz3XZ9F/a
         KP9+liMIbOnPbgo47b3ExwFrmVz4v/ojt5XVAnVUkrP8m11/K5lX9RBNFhg1LTkFu/3Y
         Iriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252668; x=1793857468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=NxsXELnRcEU024PUgKkZqBhCE5NF1Qk/BBkG/EAbX/kgqGYPYFJr+F/vnhX3BWsNXA
         6WNKFT+OFXFyU1d4oTsvXTOwcjU/0SCw585ZbyZtylpOQEUydHhu5wZ0UCQTf3CZIzjD
         fyq0kllGgdczDEuU4EhIeuqPcTBXJXtZ6ddx9HmNYi5AxknO+FymaA9jtVBQZT35PJhu
         VLnm8TfuXf62KRAmnrSj6oho7uqcvxP6B3w0oVV0lwZY2/Zd1jkPzzB6jxvo/e1tlxFo
         28I4CbJXo6Ez35Kf88/hXnJU4Sp9xpbmpjQDZsJYZb2Q1H5U3/vY/0tCjXKMdBh9Gohd
         GWsw==
X-Forwarded-Encrypted: i=1; AKwUvBwScF2M1ihTnIFsqq/PqFH2wjd24nwsKqPa9om+h3GrQkfhqFYq8zBOLkr5eOycnSfL9jgdyM+SvnkFR3Q2tA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLASeuBzmjbSSSD95pRJjdEl+JwYUx0qdPiB8nBEbPbyM2DAtuN
	31IR7gUeYC2+x69TDENxisS60L6eyu9HJa6aa4O4XYiKRbMN8nP+ccuk
X-Gm-Gg: AYBFou3RXsOJT6FQBiZx1v/8POStIOzwJdCjaNqOOE/3/M3rK8OPLyjnpv6fGVR5oVZ
	j0J/bPYLICxUZetuat+d0X50JKx3H0RpGxl6NPuRMwWikC+TLwMkoffLa5qBQIE4Q6BpmIZaR7s
	RgHjNsEVhq7wX3sjPoBVQR4qpQp0FoACkl9MAeKFaGNUcc3R2SKsomyq08RH4tPqSREqQGHpRVf
	vCg3FrTmg1qIMOYFt9xDbVgxcam8khXdwUcH01MZOe5B/LN570oRPYGvNJKRvjFvEhlxtzk+W4n
	anCqUylsQ23eMySrBMs62VIKKXy6XeVGOupG9bBfkezVWbWrUZJqkzPkdtLuOmmwTheEiyBjW3r
	sQP8k6tpKp5sGieHTmD7RcQpusNxoyG8qKx6elmAjogcjhDv28n7bIbeut8JdBrpkYWqzdbb5SP
	uJErKJ13xqhV7UF4KTaJCuYCpHIiMacqLYgMGOajrzWb8WZUd0mlXTtbeSP2Mb+m/fVw4Qj4mSM
	tfCg/z6JBEfrrocfVb+2BmXPxb/deO+9MlPvsZy4uG1ZEt+FPB1DZwEhQ9q51MMC6uj0AM8m0hs
	h/gm1R8/XYFAHkBqQaBeqn3ZRrN9FvvrbiuxOdBR2HMBtDStmsdFEgjx+NbxAWFsCPvXZS75i+P
	rN3DUpYqzxXLLBYDXc78cctFGalbyzTF7qJHkm6ogKmyI/cI=
X-Received: by 2002:a17:90b:3142:b0:3a7:8c68:6446 with SMTP id 98e67ed59e1d1-3ae58362f48mr3595933a91.63.1793252667831;
        Wed, 28 Oct 2026 22:44:27 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e83127csm2433520a91.10.2026.10.28.22.44.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 22:44:27 -0700 (PDT)
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
Subject: [PATCH v8 07/14] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Thu, 29 Oct 2026 14:43:47 +0900
Message-ID: <20261029054354.2931-8-mynameisjune111@gmail.com>
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

