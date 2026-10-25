Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792905189;
	b=rX1J2DrINeRQC6KGty9+Jg1wYJJNQQH2HjpQej8zinKMljeT2ACuNr3NXKESoSijV5mf
	 F0krV16eYPRNOvRb6g5JponM/SusGgd4yupPwbbRBVAUVzSWIPBZzNlqKa5YcE9plnqua
	 oU+9BiSFuLfL1hGYoU7ut9MfzwlAjJEjWRNqMbzW+IJ66ESzEYrybEIuo/nGsCSmq9pYq
	 q9Im7Si01IHKRHGEsrBYCWFCNfrm1RgFUpNAR63FDQyY3UhfchHLpoT6vV098HLPB1gAJ
	 dmsRn+OG+UsStDSdQt3crMqfZ5yQAJuVk8y4TYGCVBOAI1h+5ZHGxsisW7kF70jT3Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792905189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
	b=zfhml6JBr+a5PQdG5ApawXDk5TWRx63eO40jlQBtzv41BaDtOx6LBXAhXdlac88xUwn/
	 +4Pkt6zDZ+5cdBkWsDh6PEx82YA0Zz2UZz7C1WhQ8LJfIY6akq8Tq2Vym3lJk4tMOFDyb
	 w0wh+kJCkxkjQE8uKWyT1uSBtmE1KGaTV51GMo3F9t3vCA9+HFuckfBcpn//K5FqK2H/L
	 q6wPXUFD1LWUAyjq2Go+OxbIFIa30wWNPmqR6Zcj01NudkYQ2F+2RkE5I2rFWYNCCxWze
	 TIygJ7bzldED2GcGk0uoVGeY8pbGLoeI27NY7TmL5NvoDhop1rTqIew7em2VRAy/8tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CBuvrZkO;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D13606A31B
	for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 05:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D13606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CBuvrZkO
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3514b90bb89so4833916eec.1
        for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 22:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792905188; x=1793509988; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=CBuvrZkOozRXc08Unvz5EWYtJENs5yTwDkbD6iwTru2Ad1EWvjj4Weq8p2rsMZtyHB
         5W5E0Ie5fhAVVfnpuGdG22JlmgaV9PsANvfQHFsnr3Add0FYFSHSkCKtF1FxOmCqsIgw
         y/ZJDvekZAMWm5LYwlg/2N3c724zZPGgPaMXPQ22ubdlTApf873twa0NyYh0bv6g0lux
         O2YCge7KCYamRpxdU/OIxh5AFTJ8yObAlDriQR6J3KvJdOGYk5esosr5ofUwSyK0bQ+D
         UnWpdCnOW4TLKqHPeXFNAlonEw2WGNyC/vMvO3tB4lKfJOIY3ukRPaHgy7Otyq9ziovD
         3keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792905188; x=1793509988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=vgqphOdJbLT++dvuLxJEq5wlD8raocnJfoZYJhUEff9fS+OAWHxASu/mQ25wPabkmU
         yLK5GzaoVA3UYDryjwiVDSk15LMZhvVgCM7FoDaDzpCi2z8UsJkzf+/picaYovXH64id
         nD8/Vpww0C3tDfVujV6zZARpX7MFSooToKS/lgJi7H81eRvdjcL3nxMDhD4nkStPD7uA
         ebcQMCvOgiHNMwIiLNI2iSL86IQbDHpaFf/0xxYv/OCKhX3Sz6XcmmkEh/veIcyRiWhM
         lPyRHBboNJfH9JzO27uwbZ86ihblVmn4cfgoqqnMLMT8OOD9Qc52cnktW0C/9B7ODfA8
         37OQ==
X-Forwarded-Encrypted: i=1; AKwUvBzH8k6JJ0twL0zU1rkAjexYQrlR00hjrfe3dXJ8eprQOhkJtMYJGtGib9s759svpuWss8nnKeMgSlD1G/Yt7g==@lists.linux.dev
X-Gm-Message-State: AFq9FYKjK+eKGeOXT8NVZUmanbWuV3rG3OI4w1t/nhDEkTvQuDkMfeXA
	VYGTyihQ1KWSzU8Bw7cV7QSg4VBo4NFs0j9H71GHt1K2emXcHju+zryNUgg9rpjD
X-Gm-Gg: AYBFou3bFV94QGiuXvsLsD3YlwxUXIyyJNerNm6brsRVuHovoG+d9rW/xN0Z3LCjr7L
	zG1xHDK1eY8QfW/gpsQ+2MtmIfDcb1MH7pDjwSJ3STB/ql0CIhET4qQSdDs4eTE1oXUDdA7OP/j
	dpze/8YNy274/AnNFkAPBebi0v0VrcYRSCgzB2SQoGRZVHLivOlUFCUjE/nzo1peP9bTn1lIuVx
	AjlRniLtIClslnHQ4yY2FPlc49RX9uDtlvP8Q/E9RrcSlflHI2mD+l6xxyct6sq43+5ieH/kriL
	hDZanlvJKahyv3yCEl91vmRukrb/yMDQmaU/s90sIRkkxQo5AFuNQ29TtrnHKwFE863wD+HHKDI
	AhjqF3eboyKRuY7m7xsPNiHpeO1yLTLuQfRERtO2rJNW0GM+dT7I+xONY4Xl+IQbAo/VM2dLgbb
	nm55Emc/KqwOCKgIJaH5gEaoC5SaCdA4cXIX25owhXxdyqf6iUabPIP34gZuaG6I2CQuUwBNG7g
	Cs+9jR7B614DPLWYyHCIxu7+yi+Lgjdy6Ek2kAChcM0dXZw4/YV5kNBPC+YAaIC/Bm0wnyJWxpE
	/XN6Fzp4DLk7bTv6Aeg8UZGIxOTOTX16V+aa1ledzTpPUz/o3QBgUVh5j33agezL2kP76luB
X-Received: by 2002:a05:701b:4212:20b0:19d:6484:869f with SMTP id a92af1059eb24-19d648486dbmr1653830c88.7.1792905188364;
        Sat, 24 Oct 2026 22:13:08 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaf25sm12588456c88.14.2026.10.24.22.13.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 22:13:07 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v2 1/2] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Sun, 25 Oct 2026 14:13:00 +0900
Message-ID: <20261025051301.54640-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025051301.54640-1-mynameisjune111@gmail.com>
References: <20261025051301.54640-1-mynameisjune111@gmail.com>
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
