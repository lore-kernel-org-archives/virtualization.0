Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792809160;
	b=o90JAb5btGFwpaADAqu6WDrRjel6zGgvVmYRj8ooBlURi/w4zgyAWRnVrR5epi0A+rj+
	 s+k/pcu6NCkhhQ+0kFDAt4Ncbd0pQOPN4yOhOQn8LSf0DHjlEQ3HA76OcdW3isxNaGTIF
	 Hf2/IGPWEb+9ewc31r5r3GyUrPDI48v6eqqiclRYKhfslMVecipSGYirT1+D/TAKefL7F
	 oLPmvzOnvVZGN4VDIzcS/Xf1dLCPUUH3jV9vw/T8bWfKVDseEN3uwAI5IUFzz7k46Ai//
	 xXTou5u6TeOjzoXE4C4o26/w3IRYZf6ba3J1VDTgGQ2ZrcFLdhgHuzRTjhZIMy/XfvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
	b=Zc4Ohc3XAIPZAoxDs0KcpPYpCsMnSI4dHkp/+jiDe2nD+Vi5TLRPmWDHAKjf1XAtVbmX
	 GEQKzqPADmxMtWgxgAzwFxShJAnXZIq9/0K4QVpcARvZxT7q7NzQW40Y4HdNQtnldwDT+
	 WIoehxdrNy0OOUAmGxxtZVmMj/J1z6vV67gZXBdFPnC94K/ZaqIBqAowq+a/BtNW1t67Q
	 ser2SEpC6VOmUuPvVf6YZd+uF3hVhZBPsUL22A8qcGHE6woqE09of4xfcE6nsZ3x/i1Sa
	 lPHeUj8SefU9nq6v+IwyTOp4OziH9qDDuq9GI2yy3Qk3aCKrv6ro9Wnto3uv0uEyuiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hRIGrZxs;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F71606A323
	for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 02:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31F71606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hRIGrZxs
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35b2c599f43so3359268eec.0
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 19:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792809159; x=1793413959; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=hRIGrZxsJjsbgcEqyfXH/pjUSFqoGiWs+GDdGzcYEyzF8xkpYZWmL11J+AZyFTlWwK
         oMa99ZY+E4niqYlE95hIEw4YECEejdJ+Nd+V2ax48Hm4LykjSkfrYVSZZwYlfKh/qzHs
         BUCHEHX3Eb/jIARBFtUWXtTG7jy3WgAEP5dIoRuF7ADCAFU3katv5OpLx9wgKyG7tIFh
         gqo8ddc3LS0eVRl4PgrSk7qFWKghXArkK51sskGB82lTc9kNsUVA0R7szSnMMH+b4Efz
         b5zbIUgurqyxwbvXX7jwonZjCHyOrmJpawxngJP1gebOPNwdGWOOF22ibugegtY140dC
         sCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792809159; x=1793413959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=glk12dXf+FCSqSSI7fAVGLPOlRXeaGJ6/iI9Trcoa95Rlnk+FNLV/72XXu3M4klLIA
         edMyYLJlqlSpm29J9p40HUvrsQ7+mS6u1WhKPRpG3qYg0uiaBATSKNw3exoaEsTG4Brf
         XIN8S4CxPf7sln3hPaVXxguxbXQX9wbXSAH7EaHGJo7wqSp2keKJT+Z9A/nHa+2e05d4
         9rcwTzgkXh3G8nc+UAAa/i/+SNNFagizo9OoQNMDWeGjbuPbf5b6P7bjsOajGuv96+UL
         5oNcI7E/SxQ3EF1sZzY9lj+5yKNuGwUcsVbpugJgqpJ7/GPL7hSKn1lk7MgL/idc8b/7
         fDmA==
X-Forwarded-Encrypted: i=1; AKwUvByb+mgzWc+ySf3wep9E7KCCP69xwAs/ZIfWJUOUfFjjWaNsrsKSkvhQRM3uYfKwdX+CrAZTEihpxMBRwniTSQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJSDDWbdhHzI9p81FGMPnTu1UkXUPnzx+6iuY+kFiJsDpXgFpyt
	Gvrlz86YGxjVzw0RqobMpzv2kxwQ7iQn9OCBCtsst0+OXjVj0clE+D9u
X-Gm-Gg: AYBFou0AyewC7ZXoCtHcBwl+rltG7INOFRJb76rCoY3tndMyT0M/Mw5MjbThQ4PGd8c
	uQIi/gyliTss1uRyHj1aRzCulGxNuSohuiIE3q3/y2yQ0mS84mcALPIwaq+NkhdSQB+cgbs1wuc
	4uQYqRYJAWFqcBtpGU2JPt6uJhlK03PdarWoafm7pyXGA03AoTI6sFfxu+SQkF6f4b7ldcjpC+l
	h+iTgn8Zontk9QtsfDOZ/VRvs4ocXWf1bSBGliqK1l+O+cZgxqxjuOSGdTYRxarP8YPdd1R+w+O
	/3w5q5Fn3aXR88JFtXN0oRmmFNkv86Z7y1SOuAB/Bz35PFPlDzW0TLbThT1TzS86rwJIdqLkFFM
	SdhDPdjl1RsvsvyK8/D8Tdo2KTSjWIsLvqVRO2efX04/tE4EfX2BPqNAS92NP1aHYk2hQ2t9uIq
	7UienAmW7O71TSvasMlnphsXUtNQV798Hl+UAB2RE1+f5UxOoLyuD+HlRECied6KSN4O8JR+OJV
	EuihFfvFheB7VdRbOg+Hoem0BbIXjARWp2pkLeDVqPWOQgNIBhaz27R/60gBalmByuKHyuhUQxC
	QA9VHV1zWKNzEOAxJSaeQG7ttiNlySS7h0t6Qhi671pRiU91gwIZ4Wg84cdfr3tPcnVeYCi7
X-Received: by 2002:a05:7300:f0ce:b0:366:846a:e21d with SMTP id 5a478bee46e88-369e84d35c0mr1484016eec.33.1792809159135;
        Fri, 23 Oct 2026 19:32:39 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm3958542eec.23.2026.10.23.19.32.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 19:32:38 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH 1/2] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Sat, 24 Oct 2026 11:32:31 +0900
Message-ID: <20261024023232.84448-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261024023232.84448-1-mynameisjune111@gmail.com>
References: <20261024023232.84448-1-mynameisjune111@gmail.com>
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
