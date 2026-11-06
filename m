Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923614;
	b=R2mQo9GmehMdyB6LrRR3ZQYkobwJjB8L4DJLNn7CvePm6gOqBKDDiXC1sI2peqh7Kgqk
	 DXu0NyqJflaFztpIFq0zZGPsUWrqfKObwbP4f+uPB69k0dTY7grgVlIIkzcMsgXnvE94g
	 L9dVYP6tW/l/kB2FSO3cCN4SD3j5Sc0pjtBhLDmFYlnnD2FKVf75Zgn5vaOKmDTtTpKhy
	 VnKWn/q/XwIZMeTvN1AlnjpdWDcNLe1A/hVP70mSM7eV1OJPw7EHGdyvjqA5qO1HniaV/
	 C+m4u6rMSollDinasF0GRWL17F1kzNlqTtOCWCZjRLR8m6gu3GbdVIfrB1t2H682wig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
	b=zDVW2f4QFRdK1HjQhVwZ9EvnHomu6sDU2nxcsly4Rh740mOSCjCG6GVFHEtB80w1EAsa
	 icBaW6nVKdc0tBD8tFqDCrsstC/c1z4qpgpEoxXsLRWXcSFQd0Pf3oSwzuWCueZvKq//Z
	 7FiSO95VOywwLpcN1yG882XoCwPB8NoTgi5GQdRtBRPp+KHgWJLKx/A6HoKurvFMeoVVE
	 3pvK+v+Up+5GTv2Ki9zRzroKrjKNlnVOup5fvUi+EaxLpF6RSXbxtbCCK/JVCyEIuZymX
	 tBxyD6WS1ignG7N5CRKzjOfvzGwPPc4IOS8hWAE0pCUY/ltAw2kNuRTpHfvbbz14Oxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4I5Rkzv;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB19606A32D
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDB19606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4I5Rkzv
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1438d9363fbso102976c88.0
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 16:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793923613; x=1794528413; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
        b=C4I5RkzvvBxB8ycovSx1OMCLmlZ38lGxMQLlUakLRrPafX/H2Wxict2+lUMnofu7sQ
         4Kg6rc3mOIOQ/LF8S+dBBTd7AsPErzkdOGE2DwZ06PeLpuYaPsPy9PeB1LlD7+ZKKIX6
         byd/TcgF9JC0u7Y9OM3Mjl8gF4j8SO5WiuiV2FB+EFKMBHaDxljvatkrLeYBhik0FGLB
         Z5LpNRQ92OYxNu2cF7hpmrX2cgF5ckF1qXKaJiaJYc/9J5yH6DK+wQCmR145eogsixK6
         lonK/oMP52yhR7AphbOKhoXhlt3zh7CZerljVKYAh4ckfHESTeWwO+KRMfiZ71ZhQL+8
         oaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793923613; x=1794528413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
        b=wL29NQgVsAgekyqb+qd31h/zb67tUuZPuMCLZYCxChQEvdvyL1kHtEqkuOhmZPp2Ey
         HneuTyvGtycIGFflHRSmZW8MiOTD8M7i07OiNgG6Jn6UL9EEZsWdu2NqdmFNU0pI8xkA
         gSptQKzLGI4G/tdJ5I2UqFZd+LorFo4ogv3HyPGdZ0w0UZz9kT4h5wfz5G/Eu77/xXFO
         XGOAbVaPDsLrAEK6Nfv6BZ9d00VYJAhZNg9uRcYEF/LHMqPP2w+cxaXtUJLLFRNpYqCK
         RNZAWx/xZcStJm00iw587gudq98IXlmHtqQhkcOG57OqW1xcCOujiLIUxQrPL9lGJodi
         Akog==
X-Forwarded-Encrypted: i=1; AKwUvBzfIlTzD/fA22OUsQb9n8xqxESpynvoBPbKzqTfy7aO38U/LXKSWSX0yYx17EuRjjqizRVJU+ihLzh1jyyCSQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+CJQhuBfBheM0EVzHgaFHxMwaf666T+VmftfkKGtgYVyrXe637
	iHTI/WKECkl+R6nom16rKdveyYrb3t3ewOT6yg6IiFFjs/nk2f50MgHz
X-Gm-Gg: AYBFou0UymdA1bgKscOHtgWgn7dXqMm9oOKrU8ab8Rz6yMXMGkMr69t4N8LepQWAVig
	XiscJJsEi9hl/n4YaNYC/onl+A9cnXfCLTipJ2sqMsqO+NYTUtft5xsUOpWoNQoWtaCEyxeDBam
	Wqm1SX7deIn2Pwpx5/TkH2vPt6VesOjQaa934tQTYQl+PUM+QXnhyooXg6hqblBxqZOWZG8F0fQ
	p+MLbAb62hi62zrVhMm9Vf/Ozexm8u21rPAh5knxZHmE/PZIGUNrbi4pX+56Kv0odQxv66Jgc5n
	P8j8EEBHh4psQMTQeqIla2BdCxcSVIwrj5nKp9/n0z2M9IaqEkhhatcpdpMmXL2v2WLKR6EuhqQ
	cdk83JbCOhHGKvek8eWPzSHXOMQhszFnKWClDlumnWCfQObrUn9XKXPePDHrB8xeb967I2JCa5b
	+B1zwZ2KEsBWMg4T7cEi+Smt+zb5v/RAvPQfP9+Y1Gl5Xkcn22KE58P3zGTIk04i/B/8kumIRwz
	GN7D8SXXMb7XQZxVqkG2tMWL48HcdtRsborZZeLk0kObs4XvkhH6BSfV1HzpijD15AYhjAJ5YrY
	U7iXkiSB11vzSo+7VZuiB0Yf/hNctQHd4BHeyklzbrd8MQChZIO5tMe+wi+UBYW548TUM8ZhFL4
	FOTBJTKWNXydVJ7/c6oT7u/ah4rDstGnlNisMFs76l21THOw=
X-Received: by 2002:a05:701b:260d:b0:1b2:459d:331f with SMTP id a92af1059eb24-1b24f4d01b2mr4820315c88.16.1793923612880;
        Thu, 05 Nov 2026 16:06:52 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4e079esm371165c88.19.2026.11.05.16.06.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 16:06:52 -0800 (PST)
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
Subject: [PATCH v18 01/12] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Fri,  6 Nov 2026 09:06:33 +0900
Message-ID: <20261106000644.20460-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106000644.20460-1-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
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
