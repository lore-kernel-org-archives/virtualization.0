Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792907832;
	b=hMlbNoe2bW6SRnMRTgGwp4hqRy5s/sh6xeOeh3IKfsyOEUtLILQoGLTueqkCrdlXSz3I
	 62H1gS8swS/BzxZ+6SzBr7vFI9g9SKJw5soL3M2ArIMiH9riBSaygPLOhbIHaG89s3lo+
	 IcJmTd8UMZU6kYwO+PRcktNjD6LTLrImRqVsEFEKQ9w3I5RJTs79hJF4MrCd5/t3HxiyD
	 gzsVIFN5T6XMzC23ElKw+caIb99sPK4bEOh8KzmdaiZrAzNr908a00oKYU9E0v5T6qPID
	 nolVAH8YIzJjx1G/YmVuUUra6sm+wvrJL6GNzFzBCWmbe3bf4gnrrRsucZudai4AeRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792907832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
	b=gcBl/xrwWNIMDqNzJuUQL9sjLVl8+IENUieXnX6iAo1PZ2Mhxr2jdkJ6lPN371rxT/F4
	 Cwj/fAEekaSewm0ZSdVfAPPcXNyxH2L16oy+yh6bpEGqzh6q/jHq5eppuCmoVs9pMJDyA
	 hqKKE38W2XiCEpLWAGgZMKXQPCCphhPPzPf7HIVOsihYKxNkSh4Sn67ZBM+Scmwws2qth
	 wHhoQZ2NkPQXX7WXBgPIYiwL55cZ5IUGtapWOEZcfX/k3kUptv3z/VP8PTRtxUwQwx7oK
	 NiXSqzNqotraDBj1VFgQtu9OPRBFsEBc9rtKcnm/6wHP37kh6MbKY7aSfI13nX5RISA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UjEb8Kem;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C2606A332
	for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 05:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D11C2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UjEb8Kem
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35829219da8so3752981eec.0
        for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 22:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792907831; x=1793512631; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=UjEb8KemoHhIrKc8Dcf8JAgdsuhtW6EhuF5v8lxfN5YIzAVAHE5ZDiUgca5rlmhV5L
         iQe2VhVMikRiLzpIZetE6TubxtOh3sJRYNRT/cL3H1ZVVeG4LiH64h9kYyUqmLfe5cAZ
         UedtW935RzTLIxUQx/M39UIEv9eoxc7/Rj1V/urypuvnbu6tEarp73v6SEmOuWpV2pBW
         hoLEuu0kxLQzobEGQekJ9F/BBdMz+vnFXGHTe/ecfSCsSt2IkhsU8A2HugXKJf/DOHj/
         a9X/A/BixZCN1N6AUUrYtW2GaDYivoqEY9rB3IMpVMg6abfsM6PskGHMeJWTVZLDlxop
         VvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792907831; x=1793512631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=tukOJy7hHR8GDhraNKsY+Cxik1+uwfg6NdTUU8O8bPr8rlUejpZ5ebYoGRx4sUsOy5
         C8XB6KAPkcpyCyocAITJOYq8LTSEHSZoyL9hoqypZuERgjLVewLBFz6IJzRyPnKL8ris
         pwuN+vHs2BaiPnoIJ6ntqbvW88mXW6fR8sVWJJFDiVnEYfU0fNvvO2Nh4AuxVxp957RC
         EDNAa7vO4yS2Izi79R+m3WJcXpQxWqD69Pi6q6724rsmMCsiswig1cf0OQCb5VFgdLFG
         FIvKRw3nhPieELhITSE8GgVWSa+gL+qoIXQS+iI2qoxKPavzzsYrhSv94r0nGXNysEdm
         X8zw==
X-Forwarded-Encrypted: i=1; AKwUvByQI8W67Wur6+wIZM6H7cBY9HJvGT1g0Naim8tSCvfP91I7gr/8BAhjSmxkKUn3DFdYbe+I/LHgRzYZeVdSng==@lists.linux.dev
X-Gm-Message-State: AFq9FYIG8OsbF2wZB70+4/L91LcphaqUKNGge8Sg2fSVHHoP3FiqAfM9
	rZbWiS3KgqkX4BOqJP8QpWXpt4Dyps8yYsy9vAp2zAGywL/19+3jzLfI
X-Gm-Gg: AYBFou0NG9LlXdDkStIZoR7WNjQojeXOjhkXOU/wB8po0KZfy33fUwXkX7Rkp37o/Gw
	FRJFd/PPQBgUDew/YhHYTBrKROl6uWO5NA/8/7n81AtuDNXKP4ZLukwvRVmUOXzQP918vbv+VZb
	2+pEmibtycAtLzyjRODc3pmBGp+fx9eEnq6q4SH1HChLb/EVLN4g8tA9h3CGr6LPrGERIawzhON
	/b991xH5g0tVcOdq3G3o5qprElO+dL1KhTQDYwbBQDA+6wXZ5lGquLljX4FolUz6zlyXFW0vCMw
	95oKi6kVsjQijqF+lxPLXcOjmlLUe2OIFeHASizSeijwbyPpcy1f9nphoTlbd3AZGkkooKMATZ+
	gaXA5iEhwIQHMYGFIRCcpxLitANJnmX5BiSGwV6Zd5ee3cncx4SKyAiWubEEImmp1pdX/ACceS1
	q+GeBKuaGimD3zqNlSF+jbIaRZS1Rdv9QYDuoFxLzgPMqlUzjvR9gcBj8y/ea3/CF+phJAn384z
	hqiVFd9Fp7d1jYMcGDEwy0epbS3uVuPPO12bkxxu62FAd7IRDnsensaG5vV4mOC+FzeZ8T+Ld3M
	rsbdBmyoaFPKakMK0Q8u3r0H6dbPNpSVWRLuXF6VjFUWr9QHSuwuegj+XOoAmHbQ/sHOrQzOxRK
	ElsoDNv7TVsgYz/3RucI=
X-Received: by 2002:a05:7022:5f0c:b0:181:6b8:31f1 with SMTP id a92af1059eb24-1993505e277mr4456002c88.10.1792907830883;
        Sat, 24 Oct 2026 22:57:10 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d9307bsm16046244eec.14.2026.10.24.22.57.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 22:57:10 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v3 1/2] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Sun, 25 Oct 2026 14:57:01 +0900
Message-ID: <20261025055702.69259-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025055702.69259-1-mynameisjune111@gmail.com>
References: <20261025055702.69259-1-mynameisjune111@gmail.com>
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
