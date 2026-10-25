Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910449;
	b=jdojLJyd/MEZ//PHD/+94xYw33Nnf8/BPrp34WC+oXsho6R55zcKvgp0TIz/MTJhTf/G
	 H1SYsUOr0svOvb7JciRB2SfVYKYJnmbp7nuK7WL06b0YIchr0DBpUgwG07mpyfUJz3mCU
	 MALt+lR1mgYRrcHusSv17ZyVMUwvkhpOYFU9M4ZWvw6x+1lSonh7nWTCvjflKBgoOYyJY
	 PJPiLAclTtT07YgvPRCnA0arfkKhJ1+AV1PFiGcIp3gLzcyrpzQSi72iVcRed3jVCJgNc
	 w0YnFp8hlShm9shTSZXRvK2Btpg0cSNuwrn4KozgIN0ErwVkG2ySBD8wLHEU5HJczhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
	b=CqE54SdA+4TVg3sqKj1nmW3xPurt/y1XhWq6+oocwfrF5UB048/eWjnhffy26VKnCGjH
	 8WGivxp8G+hVSLpQ+dDUpujgVeLfAwCCV40l25IqMxLfurxCJB3XFwCGtJNRhZ4PpaIbu
	 7C5dKX9efS0xXRta0YJfiHitS8Cb2gwfeMM05Mz49Uo0vlGSM+z/EnMg3Ii8l8Z7TnEuq
	 xWpdYmWWkkQMGbN+NW2cPX8Ut2PeP76mqbveXOuYCdNCSCeji+TEznTipTMZJb5cNwChJ
	 tty3DnRpc2dQuPQVsRd8N9pICDNBTgZ/3tByfaqPRUscSwToy6hbtLU2cjPWXQ1tQNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cgyLV8rm;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2039F606A322
	for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 06:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2039F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cgyLV8rm
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ea7190aea1so9216205ad.1
        for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 23:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792910448; x=1793515248; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=cgyLV8rmLpBnmBvrjgTLpT5YQAUGu81YqXKj0791SEbaTPYVWbKVO1gPjJgavrsWAV
         uuuxzaBqQQgypI5ZmAR1rgJen7V23GJNibMgy08TMI4xiJHTa8SYZ0ir2TT2a40zAF2r
         NXMcvfTotIBkfkqDxrGbYH2VXGGmIBrb+h4v+ktWlMebNBPja9yfV4TKa152zMfO/zgS
         DgmeHC+heHHUp4rGRtXEDh7SuyPIMdkLlHef4gBIQ98lBJ4nXyBfi3deCX1esqMq1xhf
         l/YBVhW5sged8yY68IVC4JIXxoCobr0Ni0T0E5N4RPf3tc/XcC6IePnFY13X2QDeTxbC
         FqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792910448; x=1793515248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CeA2XEPxOKnOzt895+30F+e+QxZmzFzIqeYcgTjPdbI=;
        b=T8ntbid8nuA0dBuAxCD6PhwRn6qkhNiXQbvfxL7B9kN7NakN2HhPqhPZNtYdialDRG
         lfO++iyXH6uIjZzbm077m9K1zla9NnsXnok2pCpT0ivRCz3uxEuEh4KCYsZybdPPZkDp
         68Pfener/4uZVSRNWPlHsmXFf/YcSMW39v6v8j21neVbyJ7RN4Q99TrmBdTAW2GpgbAO
         eQBs9GzpFOZigS2J/ESDGierQ+AgSP8SkhRbqIgNFLJmVCdARrNaEwEguSI/6W+5dXdE
         oTOGo+myGxYw8/RIbeiZKXfUpUqeOs04rXtznm5tgz8oUDqy1Xoxqml0IOY2YatmjsM5
         zTrQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8v5Wwd08/IlZcvIW0vIzndPCNmCJueARwtAqvNv7fCGOjI8yFg10ECN8lWyepQtZeKVXLy7kFjcuRf4iyJw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJH5vPEkHsStgPbzBhvFSZbGpbNms7GZid1ThxWy8GfpJKPNHoN
	ywcNOwTtgTYYvC6uFFNep4qdkvWQfVHH1JfZFsevmZIzAeIgyrIMXMl/
X-Gm-Gg: AYBFou0hqLWBAm6vYdbx1d+lv0EA4G5xQEANiD0Igm8PxT83ly0QXqxMlQh0/Ij992N
	bTY4QU53uISG0WlQQXkNtrQRc4/HJfJn6/Ay3rS9OKtz/uqIDiMUpvLbasiyxgCqgl+AkqI7Rgm
	LGNDq28si589YBJRj5MMlvDQFnd1gsZyuK5rqW8zC0BjbZs+oN9BI6gi3tlyr06FhzeQPPTH5VG
	vTxceQNZdOLxxzTNNaCNfREH1B17ChkNcMMSw1vuiWRICb+w6hJpHH78NrbMyYDCN/vOvNquEeT
	TG5XhDs4mRl/IAvhbGQuYLQlOPOGd9wNrHgOsoyHOzOyAN+uNReFe7g2vwNWtO18Y9H9peUFrot
	+LF8BgBEcVBK4OGSIE92ru39tH4VqEr65jPcE6KLtBdYuu+46MNjPd9zALmBdNDbzK/r+P3BSYL
	/4SdSoavsf1kb6nYRvNJlKv/t9qS3DRgrDedyZ5DrZZJhkLGTme6Nk4XVD2ARYKbbKtxDcWjN5o
	sX2wDTjTUFeGlJImlnXOyz4XhVl/dP32qMS5tpTwicyBA/lP9q+nRc6O2wCkJjMzj69HylQ/NdK
	g7pScFomAuHe9bxFIpj4AECONRKOVyE1a0LvuyeG9WkXKKioKM3m4AbivPfK9Nnq4fsHz1Ii
X-Received: by 2002:a17:90b:3805:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3adeb131135mr2666671a91.50.1792910448307;
        Sat, 24 Oct 2026 23:40:48 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebbb2fb2sm4462670a91.1.2026.10.24.23.40.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 23:40:47 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v4 1/2] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Sun, 25 Oct 2026 15:40:37 +0900
Message-ID: <20261025064038.81674-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025064038.81674-1-mynameisjune111@gmail.com>
References: <20261025064038.81674-1-mynameisjune111@gmail.com>
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
