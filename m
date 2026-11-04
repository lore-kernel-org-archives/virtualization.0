Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758677;
	b=EJCjdjCz7KgoX2GsUCZNoBDAL0PUS5KF9864uO/wXCERR0dQ060DfD12mV/UhzptfgfC
	 wJFbmZp3lhu5SKzF1Mbm4M/8qRmsdXWo40S1Ue4JqSKoUGYDVuVEz+JUlSskpEFgJnkR9
	 Acr2kLPkwkz1lNG1NTIABLkl6N3RRA5JF0HFUJaSH6jA8S29a36X8PDrFlTNG6Jkuh+RK
	 /clRVT18vqkxvkBiaeAlPOdAoPEFohQ0WbI0oMqxTIJoW5VdwldKEbDZ68Ze2oiG7A3fK
	 3tUc+yUn/5h+tNtpKp3WPOCVqPallftj3ifpvQ/PdE2F5FvLz7kx3eNJJWoP2b2bKYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BWMu6D/YafB12/Y+mikOxNZXkHRbVUuoM1lrNSU8E/Y=;
	b=QgS853SOms7Y5ljXZXMt5TVWLniPGb/JiSxpXCnv4j5lzkOQn4W9T5iIHU/wQq72oHx2
	 0SfncXUCWrb6HCQ1sAqgJmRJehawSLm/JgfdmgVcroXNtePZr/oYDo/IE/8LTA+JAnlS9
	 It2ucAxA/eVHAgPGb3e4lnW3lZFWqNv3U0p0BZns+sSoCa27Edz1uBqznmUc8ru4HkitA
	 0Sy0wgpmvJ7E+lf/q11QJACopK3yJRWRWnIFSbovw4VeosmP2kg3NpB+H6cDcNsfTiwgp
	 co0GgWjNDmdxdn2RgWK7E/vVspeatn9pc+NHrCXKcaO4mIKyyueUoByA2eZVu4VvJKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cB6r23Xk;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEDC606A32E
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 02:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FEDC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cB6r23Xk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso189274a91.3
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 18:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793758676; x=1794363476; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BWMu6D/YafB12/Y+mikOxNZXkHRbVUuoM1lrNSU8E/Y=;
        b=cB6r23Xklkgu4pQPotXGZIm9bnrYGZ5P1cJyF+lO4Bu/dITTI0BBeCfjYpgGHJZSij
         w4FO8AhclqaIp9GSmel2qHnFqO5UH8n0JEvEgWjnREeIuZImmNysETmeTQB4y4lkS9xP
         2NCVFUYfrT2QX8E+aiylwYbwXoNqsAr3dPKmQIbfR0YXizh3rPKS1DWfcHuRo5fygRaY
         y8YG+TmM+EdNmTnz48w+rHh3IFNHXwnpbwpiLYEh7/5s+lQeiS/kBa5PTjIK2s4S25lQ
         Vd5YUpvqWDGHB2zr4q2ABwwAJIkonz3AsyfEvJ5Mx1E4VZx/mSS1pVOb2P9BxdAklhYj
         IQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758676; x=1794363476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BWMu6D/YafB12/Y+mikOxNZXkHRbVUuoM1lrNSU8E/Y=;
        b=WHu7joJKESEyQHt5GlnZHs2P+GpJNL1fi3SsX6kYiY1xB54gSXJs040JcCbQm0lOFH
         7WWMJH+urX/adhpvjZXHE0t/UR4jKq3zWZT1jxDWARcwLZUKmnXiqazgeABGbq3urSzB
         e8pTJAAkIUz9GAv1KsPLjavfJxbuUKl7nTc5CAVRfpO6Nef99fEUajjv/3BsbsuIbTBt
         VN32Z8WPoHpLGlXLhjKGfVXt6AvQjI8j6ezAfk10HvnyjsUL6oj7OXDoVUi3mcEooaRt
         bdvqGjuiozXGUtEjoZMFP76uyzD6CDqEYiBKHKprdLBkpiXXaaqEmDrIfBDyc9RRJp5j
         NT4A==
X-Forwarded-Encrypted: i=1; AKwUvBwIKxuUHqZjtoXUT3GfqolyEOBt8nEWLn6kvYpIFmNQgemBwbSp4w3vIaoyfzKtFGM+u8wMaHm1L9iBwNXVsA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/aoaDRMX+PBtFI1ifDZlZJ0GRLSRw4qRON2nHalesNdcxPeWco
	GpEiQlBRaeWIWlJQdQqrqFSZpy+uepWdQcQDpHDJeW3HJPTbk8THQr3v
X-Gm-Gg: AYBFou31awcI+SCIcMuNhYJQeXsoWTn9pftgKJS4+xI/KzA2BS+BUyH4DOOqTNH5B2z
	e3c15TBgVAvAtcEpqK9YWRWwwwILihvDcDtZGrUpMj3QLqdb6VB9rOB2H6wY3wWXFUoq9T3BnKn
	q6103DuFTshP3mArWV1hEio86Q2rM3VwG67M9fEhvdqZptguGwftAwMJi9A7Mc9a6lJJ76ovAqC
	HbGbMMdZN/d4RTY9vun34ZEZyFSkBAUj5YI/SPvrpujGoOGUX8PVP2F4YWwMCvzfIpi+uTvg1H9
	rzvVPqkaNxvrTKE6uOtYERaiyx6UB1RICagP1sTpkYUcDvvUIY8c0w10/Xs5e6FQZ+QOR8ODLN8
	biqkp6TBUO3VW0aFwogCA0df/SM2oMpLEFytbQ5XS503VDiaZxXAmsV5O3iB3GxV5AEupZ9Ilcx
	KGlXzj4gPW1ZPqLNxNClvAm71HGi0wkgIB8s5qJwI3jxZ7lh3uRQf3nJLz98GBQQg46piVusHxp
	o1IShviOD61ebwOFOH+M5vjjsjh5/2KKMWGdrOAzKmFZzdcst/GLVDqpI3HVAO9Tt/QxnYk5h9U
	Xo3diHzWyFlxZFXqMegtD8blL8YGZPGpTyAOpUQkQ9ekRWKZdXmoeqWRX28T2w4J6SSB2LZFAfD
	Jm4CkEUMg8J0TQhmMSuv5xow1FPsdnJaeef/TZUoIanRb83Jewy1U33THIsV19In9L83U
X-Received: by 2002:a17:90b:3d4e:b0:3ad:1841:6f8b with SMTP id 98e67ed59e1d1-3ae8981e41fmr11117473a91.37.1793758676321;
        Tue, 03 Nov 2026 18:17:56 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46326f8bsm346131a12.0.2026.11.03.18.17.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 18:17:55 -0800 (PST)
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
Subject: [PATCH v14 01/12] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Wed,  4 Nov 2026 11:17:34 +0900
Message-ID: <20261104021745.57733-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104021745.57733-1-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
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
