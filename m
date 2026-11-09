Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267660;
	b=qxxeORXpIkF9lcktEVukCpNXRXGEFzuiyeQH60VvkC2cpiQ8QEuFaM4p5U4J/D611W5d
	 u9XdeYngyI+HAOEyv111A0D40JJ2sY+t31kQcDHlQKhAzG98nGeTwjPygY+PRBYavs962
	 nNkE3tCd8DUhUA9jV+LpxPRe0UWRJcqbLrKm1T//M0YMBMsFy5u0TIKCL1P3AOrDv0QD8
	 vBFFwXEwpiyLkDkxXeZzledKNr+zv8Wlu/BlYiiRgy+kNRGIV2u5lS7Kl5o9G5khFvWlM
	 U6IQXGTUJgJcKy7oG7TT7vrb+fsYsY868dAOVKXSVVMLnHyFoSYXCIJ/2MgwY2oeb4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
	b=k9cNDsyZpgwYI4jsbAgIRNpnLVy8S7XuR5NntY3q+7nd1rDbke1HDT5cjsZiUhzwJ4y8
	 H4yVpA618Xm99heKLM18iTF3fmib07S+SGMTDkTIWItyh5Na/h7EketCtRlcXoepG4RaJ
	 YyBjxos+oFFGuSmmZ2Gu4yadaExhe8/xFBbqEzEOi1iFuE+gRhprZmGNknkdXX6bwT535
	 rBg7IbfOGUks61qheeaUdMNSmdcaOyPk2uzPaa9P4jKUerk3SjIolrEkSblR6LXBJJepz
	 YZ/Puvz0pM0fFjlXoyJk560L2HRG8jTevRoPhcywAk2sKyHvZZOte070H2eAVQA1o9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NviVXgyN;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC2F606A332
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DC2F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NviVXgyN
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2761c69fbso1743935c88.0
        for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 15:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794267659; x=1794872459; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=NviVXgyNzZnOsmNUSiX0ZeUMUcLzFLOmc94cqy+lGes9iSOEq718MYEy4AtqCg8Tre
         1gfbPi1ZT3k9zdzz4Da4xJ4fcIOdd+2MBqDMykY0cg6wgfiizEOCDu5N7XO6ivbVCl2w
         mHfcQY3HC7RDkbWH/qCWjRjEhIiCVKticQernLpLKaF46Xe3iNjuhL+RllzyeonJB9D4
         OQGdv9oJh3EeHagvzz7xrBCeXiK/RuMiO2+p4tTjB09ydmlIGa/9kJsbZ4Xce6iaKY8U
         aboSA9tQI0NNgRCyKPzRoisU0IViFIKfvzwjIYZV+opkbufHEBBVnn3Qb+lzI903C+aj
         7R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267659; x=1794872459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=Kd+h42OLZQA8RTIYE2Iq+EFv/iR//4u2XobgMe6QzohLy38hZ2tVyQed5f4dTWA13O
         fKpeYzswN6BLmyQb9q1EsPNVHzq7xFGhd9m4H2ROSbNDCjNHkRTevVsMzPLEX4DOtPrq
         sYgAI6GE6NZmNIwxX7iqcyK0IvdvBxVH1kccA7wHOWuX+lh4rWmIFrZvF65981uyTKGR
         EGtxzvm8qOfOJgVY6kfqtEMl8QYcPiXpr7qybn2ZN6c0IFd7wveoBsuFxxpGgwbm9gFw
         RW6i80N+2OSc6JjJ0oTX1OiL9/rq13P6Piwy9QCkZmB0AWXJJjXNDhUWa+AuqLsMUUss
         Dkgw==
X-Forwarded-Encrypted: i=1; AL+hErFkVET6w/nNw8crNZx6bUgL3MJME227BKLFXcy5yDINBmYxb2IYU/nC3G77AKTUvp2PuvyDiUmqOxPIpJ8eKQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z85t2ibRIQ7SssvPRUfWCFKeblGMRzHoaEOB9kJsQNOSVGhoqDv
	eoT1YFPtPqOgawbbiCEQn/iyZEDtIX7ZNX7PsYjWVvyG2BYAM6LP41K3
X-Gm-Gg: AYBFou0ycCBdpvoaEcf5gYNTXiw+muQy151ANh2MT2tl+RGebpq0S7YYBChrpOa86f+
	qPRYAxXxMduQA7uEFX710qyelpVGvD4Pw0Bz9Db0AzY+icDdqwFd8HWMcATEOYLzSRvpDmRNTVX
	I1WWJuk1NLM7GIgST4gZmwoZRjbdrq6AkUp5CSNjDLKIoa/mNRFytuaTLKbnF9rtV4XtzfHsaVD
	Q4VlytEYw2Vw3sGtGUBcsaee8+pKCou9qVkMTFGolHlrNa3jm9UnN7vQKqDmlx3v+LXKF3F8Py4
	ufSkxrzFJsDZBMlk7W5+9YYqaMXdkVcDGbAIA91yunGVjXSZrpxjMT4K3+urcTMgtyNCq7nfy45
	EwRe32Ovp+ouPusErlCYGYawjUWofLOI+Rp9R0q1Dvn089965xBwlkiYrPYViuzmvFilJUsX89D
	RGny0kmsVATqqMyPttLi7uNbl1ACQZou85/VOyk28US/7v5KkVXu6tdnLdGLyKseEklhe+4RMo0
	4ljKTyw4UxVmOjVRAtT70rWatmwWWRCOdfNxJFqo+3lDga13yBlTvwwa56iKA529bIFJw9Zj0YF
	QbL97H5O8Y5Jo44/QPfHwIThGKEUAFybKh8U1kH2hbn24tDD8ZtldMYXt9ovpsdmlXAHQdAJIR4
	3VsL8hnquJnI97oSLjmapNlznnGbS8ogIhS9bi4VQZyviOnQ=
X-Received: by 2002:a05:7023:a4b:10b0:1ab:de8b:5f0f with SMTP id a92af1059eb24-1b3b618cd61mr1286428c88.40.1794267658673;
        Mon, 09 Nov 2026 15:40:58 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm1739049eec.5.2026.11.09.15.40.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 15:40:57 -0800 (PST)
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
Subject: [PATCH v23 01/14] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Tue, 10 Nov 2026 08:40:36 +0900
Message-ID: <20261109234049.79534-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109234049.79534-1-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
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
