Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464697;
	b=qy6j7wnqTzOtU3e1FaOvQTAb5OE97q6qSO0qNyUCyhMKKzEx5/DP/U70zd3TLUFDyrxE
	 KsOlzYpg2P9B4LU6jvO5iXE9uTgGKJojhU+6roflOGg/PH3MRI7sNHYF0b2gcGTyKMMVy
	 mTMGpigYEHKMxUUSaq8Nql1RL1BTdNdg6bVQHAK+DjJSFTNi9R+rbbgCO5wSWjF8v97n8
	 cuyH0cccBtje10tjEYyQ+ilxQRBOak9EHCXDYaa70V1q+JmgGVvayP/BpXi2rETujqkUu
	 vEqvpPH9kvxLkl4HYRy45oW756NpzKxcIYGnKNU0MvydwWAHkjKSk4CpLfNFi2ww5VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
	b=FKX0pKOz0vIbziokKW85HrSnBbk6/z+Kckb7FEHMgEKojc5HQOW9qZspsnuiDx5PTU1W
	 pWRCEV6IZ5N8O3w4OTARyAfZzjXtK95wqmC4ziJtrhoVAdzqpyGbISb+iXqMh6EP0wsXQ
	 m7MTjf84BWgr+YKGT7YShLjrBQyTwaUyO8z8sEBwnudQSI6KBIQk1WDeFRld6UtNb7MEU
	 MOvpsGw4ESIlAYf9vWw1EU8adXEKSS3cynfJrayAWHrS03TrTVfOskrWY1FkXYz3Tp9Om
	 OmpodGo5ItKAx5iGuY0JEPHitNyIuHOf9gF6jCNhRS/ADbMu92M5FDRXAx7pgDtEfiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SRFFMq1x;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA899606A32D
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA899606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SRFFMq1x
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e940d5d2beso15142275ad.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 22:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794464696; x=1795069496; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=SRFFMq1xTTZVxngn9M8bei/3+Cx0C8+y8T6Gw2Zp04/BsLyu6rokrlF/MXRniqWiGR
         uy7kWLFnX4M9Axwrqe2TFL6r6iw3b54dFUnE27VZrXtQ2B9+zs93uZnv/LaViuemR3lX
         vU7g6eOfY22xind8Q0aP0aIE4xR1m0rbARpLIps0v+ja4edzhr2Dr3ugvrn3VbQNS0Oc
         EZqx8d9DOmjZ6ZUegp4uTdamER7qX1wWZT5mLW6t6GkPWwWdODhL+czugmKFroG5ONh1
         cNBhuzGRPhN/JhzO7361HyUOxSg61DvGmgeeFTyYZNFykO/iie3AjcnPgFHHMe21iXTD
         EhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794464696; x=1795069496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=zGDynLQOCecLkfr1YPkOFjToGwDER4yzPqshLsNDRYpKouF7eFmgi3+XbvmUNVpgbC
         nChxyoBsjwQMKSTMjChk8C72CJL8ZHCktuCqCklCPKvzry2CVbKsX+Ih2oSTzOItWqzi
         dohzEzJ08NUGdxqSUdwjcBsjYX2ek80oB7Ji+NepKz3oCDwBwR6K22YWCM+mlqH5lYdK
         Frsj5jeKq6b6kVpoy+Ok+BcPw7fOt8ILeLXz1FnZbaVaslvzMZkqTSgETID2ScuXFAVA
         elktQMsgf5Iz99UGW+6DImXqfJrkaC9c7XiD3qVKOM4O+/1EECstpcY2Ld+7Aw7JBiZ7
         MmPA==
X-Forwarded-Encrypted: i=1; AL+hErHuiHkmLM+ZDNzqVbPNfugyC9+uKMamGIAVjTH1qHij3k1PamwhuuYxfg7A2nIp+YnVL4ybYNSiJd0JQnJxpQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z88HsW+Z/zIv0HyVosUXl/1n2YYQTl4Ju5wYwWqZiB1eVQarWhn
	4rfYEKzWkk9i9KW3j8YuOWqDbrKhpCubd7req4G2i3OHoxO0NID7JxaY
X-Gm-Gg: AYBFou0eDx97HSie6/exIiNHkephiv2ieSam3GdVDyxjCEF3KeSdyxC/s7Py35LG/dN
	gA28wQsIIwU8ck+kD9P3AeS+edjG+Y5NhnIu++QBKH48+B79cGvCR8b3fMi6S4h7Ta/pZ9R3oTn
	GH0IRvXvEScTcOYbl3E1gN5bz73I1U3Zy9DmCxiY38pUtuDXXEVQsi0HaY2uFYbNqh++9dB6M2Q
	ThvdKFxanKTrkntIyEcukKa4MGxQT/fRXJhbjB3fQg4gVrkUF3VUkkfouBtsm1aBc/g42yD2wcI
	3RnWbpku+Hu5IqjUmMr7+piPPlhjGFJj4HHuRVakvmBs/NJPj0P4DMGwAuRF2LcrhwYu58fn8Or
	zbmvi6f7cj1lytI2Ft5MyFZUQE6ZkrLjBbOfnHTppVv3P8J2MZD53YhvqfFX19+f4voQ/LmiauE
	QSfK27AOS6pldeBTqi6STOT7o8N+c/icg5FU0CidrpLQWxriph/udFsvJQaxpcAASMlEY91Ptry
	WLMZURuNgRZnGOpduIIG6otaJqW3/wJjcqirrLS/A5Ji9Tp3E5zAMFQws99cs/VkfL8gxq++vkN
	Ah7AQGdaD08AOKyuzOc7Ns/TYKHmNL0oNRhyBMo1uukmE4eEDBLR6GnXAdpZct597OUC87hKm8o
	iIEzaeafJQAerHtfned7rIVU4NcwLWKelYeHgKnGRYq2352k=
X-Received: by 2002:a17:903:1a8c:b0:2ed:a8bc:6d48 with SMTP id d9443c01a7336-2edd7a86c7amr46594825ad.43.1794464696003;
        Wed, 11 Nov 2026 22:24:56 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a3e61bsm26979965ad.11.2026.11.11.22.24.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 22:24:55 -0800 (PST)
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
Subject: [PATCH v30 01/17] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Thu, 12 Nov 2026 15:24:30 +0900
Message-ID: <20261112062446.159-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112062446.159-1-mynameisjune111@gmail.com>
References: <20261112062446.159-1-mynameisjune111@gmail.com>
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
