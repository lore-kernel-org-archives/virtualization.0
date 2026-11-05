Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845912;
	b=Q+o9TPPiAgY6R/jSZ3uAtH6+tsz/RqBBYmtY9hilwld2FKN9Dojz314/cDY91PTLjU7i
	 0Tn6GAMifKdSpvIq6l0fSRfkHLClazMdTLpQDnoCNqJZNgyDw5G97zr9ILSipO+ZR6Mex
	 a0jNkucqq921EI4953hc7S+B1FReMzhaM0G5IUqa7IklhRQw5mqI1POIiPTrhKm4EzElW
	 fqWHFaGf7+lFSNPVEBjiHiEkUTiiKwkPjmnVp5VSpF0cNWYjUZUL09HMZfxddrMl9fb/e
	 e+KZvliJLiXv1j4MtifSXfbO3bATvVhQ/7ch+gYOXZDbG/XL8OuaDIl9OfkD294Rp1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BWMu6D/YafB12/Y+mikOxNZXkHRbVUuoM1lrNSU8E/Y=;
	b=UPaQYtCwrZNLyP68+/JmUNYWrIZKrcVKYWou9oc0KGTe1E7V4F1jWVgawqAyfVFk0Bpe
	 fvmIUQGenPJnwFtq/YDLx2sS5H5/63yU8C+9JhlavuTbzI0bMUOISmDY374kX/+RxVdex
	 sntbLhm7TddvJ1MP7GvYniTVbTVgQJgzP+KMbauGNGYbfIaPmGOUoMdIkR1VRrAOg4P0F
	 +XqbLWAj/khZpNv3i4FlNH7U+7DIIQc3vrScdnIdSQshnEoCdLcDRO4LqXoXXpR9U7pyE
	 HA93tAXOTjPsjUTj9taTkwaM0cD4EyvYP8SQ5Mu/oXpOJ42L8+uNmPoolhfBMyLHc+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dBByerXX;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0E606A330
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97C0E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dBByerXX
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso968245a91.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 18:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793845911; x=1794450711; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BWMu6D/YafB12/Y+mikOxNZXkHRbVUuoM1lrNSU8E/Y=;
        b=dBByerXXVEV04H1lr1GL46cHNhbydxLfn2PI8Mv2Xv5O+gBSQio4E8oWvVsTAkF91y
         P4Nxf6ExQUJJ2N8FCrFb/86ttcMRVaYrWmP0igtCA0qpPqpOwo9lOyLxdpxhOEnRAgpw
         pL2JPZcxUcGNAih0Fgqgk9Td44w2Lba6x7U6nES/Ql84XrkrnHPYr/AMi/DAK87frKBJ
         t1TFowNPwaPg3XR5qW0KjWZMV9o7gmhAyCb4Zw0S4VKyx/2qQLeiINcljN/W+LpyD9EI
         6ik3P3wYMQJ8V2p853GDSy7w61G8kMbMzHE5RSOjQ4FMwQRtCqrGJzBTLXvapA0HVhTv
         KOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793845911; x=1794450711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BWMu6D/YafB12/Y+mikOxNZXkHRbVUuoM1lrNSU8E/Y=;
        b=TOIa24N5IsRx/76gQbkq3Z4WHPeONOxKT+2sEpLyPvuJ6gJuLGKO7O55hvzAxEJt8E
         wrjbeINL5i874Api5i+qcFueaxH9w+1tWnjtITtF2249c/Zx8U07udUf++uucIqB7DJP
         NYy0wjCZ6PUCiVjxh6Si24OAD2/6ol4Gu11ejyPrIF8lb59TzL1N3nDRysqEH/AiDdJ/
         +o9HffF9CRkVz4Y8wX5xCBylA/jcvZlyWYdYB9OyV9XYxh/INB4Ab3Ed1ed2+TocsOo3
         oxKseKHI4ElAMfZa/Pp/vhGhJ0Af6Wz1zBOwqpjoii+ilM4K/e5F2lWoTLVhT2B70vKr
         6nGA==
X-Forwarded-Encrypted: i=1; AKwUvBzGWnyABoi1LbsGIkgIaQdqv3PbwgeaLUqIaFiz0u7n6cLoZq6S1UggEuyEviFQMVVg2M53JJHeoZu0ghxf+w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8l2q6sqB0bBCkLx8n86n87Y1h27LGHGy/X8YhS6P/OZ4dmOL2B
	PYphM80VHH2LQ5AR17vA8A+56JBx5/LQkEPdaws90RWPkhWvaNdfukoX
X-Gm-Gg: AYBFou0uE/AszAKWSpGqIn4piHWcMs0aicAUDDE9C5g6l5B76j0Ya1GTMOKBCqTtPCB
	aHrEuGVrBrSX+5z1pajDk813uSETQKBjGTp1olVmrATiEgCLJdePbzNA6xtq7ntzWRbwBQdYuZ2
	f/2ssQn7gjHpEXoXklWyJf4+lcBB0GoGd/uAF8gPgwLJQUkFElgueEU/bClO4C4oX5iFODgJS6+
	FWMuV9vixdPriryeFFs4jxHYUWhv6SON9CFr/R4Xr1cNptI3Y2EpVAAsoqfZ/X+IZtBZTubAUEv
	2w5gkn8css++GoeoRVEl4isNkLQx9qY12xzBOyQ3XEnwJwmOGQnAIlA46ahGZDmSi3b+82z18BM
	ynjxZU82lSFHHPSmsmC0oxH9vA0Nc5v3oqqdj4nj+KhBUHkeHJiEq6tz74xp9LgVqsfVnjQaVe+
	00XSVrKLt+i6YHIKs9w9NUV7dc77KMOkeS+Kg23ucm4h25vuHiYcwsk1W1jKDTZA9VlCk78xyab
	PQUH26/qaIy23cIRLi5D7x1ESCJa+hntS5SvHQJx+/iucpyKG/n8kIUeL0TjNG+dCM1W9/Z9oX/
	c9XLuqgjPRG/89gXWFkbmQ0IQOYYwimQRsKboA54ry38ObYZwos9tm6z8niT1bz7t7H41bkIHft
	UOehB/mjgF7m1UyYI8rOZ4jLm2LLj+Kyr/+IIvm8/L7Kwgw8=
X-Received: by 2002:a17:90b:3c08:b0:3ab:17b6:9a93 with SMTP id 98e67ed59e1d1-3ae897a64b7mr15530386a91.52.1793845910857;
        Wed, 04 Nov 2026 18:31:50 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323cd3csm1292775a91.3.2026.11.04.18.31.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 18:31:50 -0800 (PST)
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
Subject: [PATCH v16 01/12] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Thu,  5 Nov 2026 11:31:29 +0900
Message-ID: <20261105023140.18373-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105023140.18373-1-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
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
