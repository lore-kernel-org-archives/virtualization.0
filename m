Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981929;
	b=3PHttbFdymCImFJdHUW8APG2mG5RAUqFLm3baeaKYELCDw+3CKU6IBAaJ/ZyDOLC8DBU
	 j7ITgGl4oa/M99MaKllp5GulUZpioaa/wCvPrgDREjY8+R9Ykk7nKrXcUFFeX2opp8XPZ
	 AiVaimU0p2gG7fyWGsK+9ZvsHgMnz02Ce21OejVdEyEKQdWIywCKfSgqFPERCe+lPdYQh
	 3dsHizr4nwQksiuoG+tMJzDUuEJRkkO5SR0PQpQm5pj/N0cltfinHvWzsOcOR/qrIYSKh
	 NsR4JvM+TtrJ5lxJfZuM8PhVrBtdRhjXc25lkRAcF2yBdCRGsw0KEJc5yYXPvF/4EgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
	b=3fzmCI36G7QZIb+85YtqsQLEqjjyqASIf/LuqjdVAUfEpX5US3dNcoIs7xOCIwpGvL9V
	 hlIcYb9zDEZUI25je1XF2PEdYGa9v1Va5Rk3ogNpYlHujz96MoylkHT/wgImnS9GApPuM
	 hsgDYDmX+754M9j+oXXvXN1tvPXckymMAWm1WqHxlhO3UeShaXuY4dg7oT/ftXdltggcb
	 EHcUehZpsDIxCppca90FPSuQ9qrnYBRRfzprFradyK6GIHi5a0NOTvTyzT0Yjuo3dHfTU
	 YloNzaBczkwowe9GCws8934KEiJg80QSxH4FA/m6IP/HWsyXhcRmDj08VkA+vk7b78Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SoTKU9oU;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB55606D82A
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 16:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EB55606D82A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SoTKU9oU
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1a2761c69fbso1897653c88.0
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 08:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981928; x=1794586728; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
        b=SoTKU9oU9+5Rj8dk8s+DwB7hozdrwfD612NBbQvbfJ0OwTb+mSxDgTuOauptc0OUwa
         iz/zZ8ZfYnRiYFs1sUcW/F9yEAaHAo6Fp9DNQOxX8jnrUrMCyQr8DlF/ndilWkyFYAtK
         nL7HUwwhroBzZ6+46KThipTKxECOKqBRcnQ1XMslHGriI2YhBHnB3V3rqcaIojYiYQIl
         V/zAVU28X26PvSQwl+re3+eahS9ApO9dAjaumQZ7qNqM02n/aFQ42T1QJT3fwe+OCIrv
         eMEgXkLuoQX0UByn3uRHU9XjS/b254/RSNw1fGFCXSAGrO0asD/8JD1ZwO/GygSNweSc
         wjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981928; x=1794586728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
        b=tEHk2GiC6izxrokahzZiKVThfp+uV6dEOGyE1RqFvFCTEyKDNfvErsjtGA0VykowCn
         pCXSggr1Q6LpSr5V0tlPWZEy18jGaUlziqj1wiPvOyRXCdyv4drnKwEFHvuVfXzWuCp8
         HVkEF84ugS3Ri59yuirFw6bUtxsgHYtsPoynQqmMkbtS0ZtSyTQ3VVRl6/dsLmqSI0Ok
         9tVv20vYOl/1uR9Bdx8vo20KPuPKZu3nuUsQNf5H7BwJJMMO5NRgLYzYmkx2DfMaDPsh
         Op7LkA3arSlSBBWkcGy7OUIozuBNN5cT5D5DMBTy+nVNPRi09ZKC1zdC/9m8JdZuxKPn
         Wjgw==
X-Forwarded-Encrypted: i=1; AKwUvBxPm75NBK7RSGU921xHgEVriuDfWolLK4P0IUm2+DNuwCIy7kjjfzJ7YyyZtBlaIlOETszsdc1YVdDX25Dbpw==@lists.linux.dev
X-Gm-Message-State: APuU4Z96YZ2jidtk2DCb0i621ivmFBwjHEAtmGhgxNC9NUvpaeFRQIeJ
	yMh7dH0+8yLuHmNmee80g7f7ZBxLBr6gwDTu7DjZg1DPMq6+G8OPeaXN
X-Gm-Gg: AYBFou1io9YHD2gvLQUJhTPeOQ8GNg/kcjoaiQa4EzAFxxzTJk0gg1QUw7tDET/J9TJ
	nnuZsIAbpAjiEi7NpCl4LVQJSis3k5PZ3z1zrNNqaDP7AK9o81Hj6xBl0sqdj4qZVaH74k9vXY2
	zTplCEf3sXhx4Sd2R2aJ9tpO6iGcXv31QM6XyLG9vUd/mjbv/TU5oKnZdZTEVW+fNRq1z5GY7uQ
	9XSEUcCG00Zak4b94pHCAIbrOldJt7xi3HeA9XfU8ZaB1ZGvShiCCe4cd7XGzIoDUmYP4K9oqU/
	p78Q29usRauKNDY5NV3aoGfjlpMc6n17haNeG2AXZx/+IFGlxJR/SaSj1s6EogBT/7kz8UEQiDR
	4JvIsNGroh3MaVNU/kVL/qVuCgeBJEAMKw3ZFjZUSwk6wghE9LiUeC6na8aHuqBdtrFxJbLPznh
	O+gZuhoGN/TpmsI8ljqS4htEn5HsMWMfBXhbqW0jt4mcNKUDZkGfIp6aklZ5oKp1XxRPq54eUtV
	OvAhtz1RamLq+OD5S1hhQ0INtyQDeeUdFYwoptitXHYSm9l2QZYO5E6GeHFwXEdDg/lSQnMSwuO
	rrbpdQcWnRP73R0JN1yNZuTmcQK4MrBp27bzT3gCxf71jiIHRyWsdUqmfRCEXY9yDOVdPZfgPWA
	XzK/mERN03P0ezIfPQKV9m/Gqmwk07az3Pzyk7k9nBhAm8A==
X-Received: by 2002:a05:7022:ea8c:b0:19b:98bc:326f with SMTP id a92af1059eb24-1b25d31f475mr3820669c88.18.1793981926801;
        Fri, 06 Nov 2026 08:18:46 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4840f3sm13139526c88.5.2026.11.06.08.18.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 08:18:46 -0800 (PST)
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
Subject: [PATCH v19 01/12] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Sat,  7 Nov 2026 01:18:27 +0900
Message-ID: <20261106161838.94308-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106161838.94308-1-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
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
