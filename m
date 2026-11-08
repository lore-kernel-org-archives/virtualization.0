Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794182111;
	b=acgaDllIp52chGdactOzF+oqWkI4l5460bZ63hCuuk9Z6EDFL2aWsD1acBFRNr5l+2Ru
	 iIAGCNYN2OIGii+fdxk8hBQjSd3cC6kpWNGQ3XGziC5F4HWMMU0TcmI5Ag67isTgpyrvJ
	 allR/ChBCXWBifT2i4aOfc8XsgZ2i5R3OfddpD5BI6F143dsNqIBQD1zqTh+uKl9VYAO7
	 d8cA9kphLWCSS2yG9sKB6D3C2cN3W40UulgGL6xf8fsPxWMGjIFT3FMZKW6SCBVJTNM/t
	 amiU7y/M00vnOzKE9/bk36WiIPWNIJp1GU4YyZQw/86VHpq3dnL6ijvTYUGCoMdFCvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
	b=yO9IntqK13ryVgC5z7VE2sp70wQuA48t1co0gdT603KOr61ncFPeW+fHgCvKYn57wkhC
	 fC+lniF/iliBraf7BVtDxqorfTB66PNvdzPyqFXa73bLasg2Wzk513bW0Txv/S2ex4akN
	 irvDqURYi99DrImu1zoJ9hXlOCmBslbgLsXw1pVCa8d1ht5lt+hlttQ4pYQDP53k+IEXx
	 G2A+Yn4vJ0nBQDfjA6DVktNau4bqscqqiXJaqXx939jj9TqjokA3ofJWeEJZ1TIZ4BdVU
	 hiGeMFm+t5mEMNKIVuMhTcWLNA7jCbtN5IKwTVscJVXA7Xd57lXpynfKM0bvPVJtIKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0x7or9cV;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4CA606A325
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 23:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D4CA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0x7or9cV
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ed39646f04so854825ad.0
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 15:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794182109; x=1794786909; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
        b=0x7or9cVp4q+MfWj2csE+fZReczxts3a5+bYDQRLKG+TCjHVb2UKP3cuAuwfTiAemS
         B0REzXsnr082z0TowP0/rcbk+7a9YVMnjtPK3woJVGXfXymJzSnOH/HWU6pO6a8vydf0
         Vwl+nLhJIkavv9HFCLJZ7in8/jFDjGKzgX6Rkk/w2XfDudsPNaMpaF7SS9tMa3qhQlfc
         +ob4q8hRaRtK9P9r5B6qL9C/o64VRb5UVN3v185Xgt+PWWpdRMsmPWFxSg9osE5kQYCZ
         FY4GcU12KiCe/ysPP4KPjeadZYU3EvcOZzV38emgub+cLXmhVRVUq5FmRgOgBySguvPB
         Ui5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794182109; x=1794786909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
        b=HC/v8BGNjVfSUGMVnyzfGXME6SI+1FELZ/x1+e1FzXagd5r8BFTNmvAEI5dm/gLqQ8
         pIqxOBuZBK96TKmd1TPSHmKfDbDZS/N6fRkAatCJfXTvxKXJyBf3U+xAAADYRnPYH7oB
         U60OesYqbHRhTbRm1d+ASLCdpepRgVMa77JFgjbJnxNaVNJp/y1YHzJz+WlLfts7rpO/
         vl7qQXlqGv1fuAGRoBo7oivLz+cKc9e8GymPWl1UHgT+RB5ZRF0ESCJleWwEFXQNPOV9
         sauazIl0R9Sg5fG8wk+wtOdFGltxh7EWvY3DyOFMMT1+SHjt+yhdJ1xCJuBO2mxMpcLB
         Lw1w==
X-Forwarded-Encrypted: i=1; AL+hErF1BMhyKH/+SfH5g8QDSey5ILi0EfeGDL9+7AN4teinaixOz4kJDPbGPulNVkHTOtVdKxD4AlDwdAqnix+IAg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Sc5DGWFaXjtv2jD990g5geTjZQpFnbFkGK4Bl5lrG2E86eEms
	YQnYPgLwetjQ1xx+VtgnPE3WYQyfa+CbuySq1qEPyQPc727W0EdL2Gj1
X-Gm-Gg: AYBFou34Ehr3WY76FFJjfadwUVbMSoXSL0M7aa/SBXcO86zZ3kalE+RdWg5cqbAXk9U
	7ObFy3jG9G0EORF9BZ4G+zcqKteTke1Ns0o0Q5AJoYBTpAOr+o3eSxbmlve7ThVesw7sj1xANzJ
	0pLeZd2RatcFXVRuDzFLixW0qkwS9wqLbh0JjyuonKPrJEsyABXUrHWH13xHNVIDpawjxX1x6pt
	HssCuNQ+RAHzhumYvdkvI//G3YVJFlZn2SApSNZ4vCrcF/oaOxyxQxbAyEyQXxfU0FfjQAlwFUj
	nCHEXqM9Ej9LmUDTj6wUrrbFFSxuH7PJa+m3oSXvF+yDSwh0Tu75xxV9jk094r/+uy2/RetWbYV
	mMd+SF4hw5PaHABbkTSWlzMBY5bMWoosybWqpa0p/9VIRv0HAjMIw6/NCU8E+6AVE53giFFCkfS
	FYvjrL40mNFlnJENVGol9PWGA+CrCcB4JSkPyHHRqRXvdWOq21bDuxaGBblByVrCfLVfzuG+d9L
	VAkghZnO+IK4ZrNR2kjH+vRkm8cAOLPmSuV+fxX9IFNZHBWKWRn23JQ6l6IYpfPimNMqLtQt/Ui
	QxN/qcwj4uUWQ4jw9xqQz4etROmbsCQ3u5gB6u1RietECWnR0bCLAFtRd6JRl3VxsjQiQxFj5Ai
	qrywrOGjDT2nIvAnhkOO4ZYa75dbXhc3K9ec2sp5w1YepTJ3MDJAazEmreOsr+AzCumqf
X-Received: by 2002:a17:903:2289:b0:2dd:c100:4b76 with SMTP id d9443c01a7336-2ed8378477amr25176185ad.45.1794182109426;
        Sun, 08 Nov 2026 15:55:09 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81722edesm6095215ad.55.2026.11.08.15.55.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 15:55:08 -0800 (PST)
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
Subject: [PATCH v21 01/12] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Mon,  9 Nov 2026 08:54:46 +0900
Message-ID: <20261108235457.12688-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108235457.12688-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
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
