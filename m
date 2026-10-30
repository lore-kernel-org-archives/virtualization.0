Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338019;
	b=IBWPU+qYsXUmj7tAwuWjnos835lx2ToDaoLTaiFJzT9hLbda2yjlRwm08XLZYglcCkwV
	 /4FUQye8HopSJuxCCN2KYeCvkffVgBWxXWkYUSZnrbTM9SOBCcYcGlGV5CaoNvl2ks0xv
	 e9fpKQWaLO5nDQfT/TCBBCxAIbIA+tz8pkd+RlWeqkPi+MzAA2mRPsAVpw2Z9rOfGDmAx
	 CivUe3j8oQcd/SBSDBCwxjc+KSpYItFbQXc4WA5kIPGXWuC57KIh3dhj8TUlKMARjSrCS
	 cMQlM0CWgLyH47rccs66G+d2VgiAxai7j9TCd+iaVEfx0DsU2SPvBkbEvmQuE1O72IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XTf7x6rvt6K8mT1295GgXCNKMEZiEblGXzNlO5X+Nyg=;
	b=K91OKFDCt2wjRecpU2jVQ/5Zse9dfmv6Kv45c2YuOlcOkfxEmrmEKHF/MzroukRjfWww
	 9PwbPXFnbfuG5RVOidO5Tlbq5G9lTX9b1481irkejaO+srb0NvAmqpolyqC4F1or+jYpa
	 Jvar3DwEZvmBo93Os03ajbQLtDYp0uYmg/XInq/aHu/vSu/Y3v+efXcFGef4o2LLLZS2i
	 IlQRBXO1mBMcstkVczrlkqO+a1yyTzaapMdl92vweftxcEBWxppFhTRdzGBPH/+KF9i57
	 ZkXOlOoJDBCgXCY5ckNs0pbioaSTFOQGu78G4qpNb4AHcUrE4H3+b66zgP/ErWrLUAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T4PI9YUC;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFA9606A320
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DFA9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T4PI9YUC
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso169843a12.2
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 22:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793338019; x=1793942819; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XTf7x6rvt6K8mT1295GgXCNKMEZiEblGXzNlO5X+Nyg=;
        b=T4PI9YUCqSB1pawEgDBKkd8dRRVbMjeHZCzDi3iM0WKWspxgUwgF0EHzR3cmgq9KNp
         oaO3oV1YEtk0AUJnU+sxjHI4yfGdOOcCAuJgi3rofTC+ZU27hYGmXJ35SmjX9eeYmCM6
         /uSUnb4rzTUjDD9Smqs76//DiCryyxMBP5/0fudVkEJAP3RcUDrVWXzIBTDrp+e1XFgX
         lUL6KGA9Hm23Z2k0wVGAi3KRc1uGdWaMkSTDtracw7bA8j3d0ROYSFtfLPzAuZ3VMpFU
         IGC9ivhiB7pClE8qVjLtEwvK4fIlWvlkRbsQb9sHb9lie5F24so5ypZ/yN2JdWT5r3kt
         Jdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793338019; x=1793942819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XTf7x6rvt6K8mT1295GgXCNKMEZiEblGXzNlO5X+Nyg=;
        b=zNuO4Og5Vj61orBoq+YzGCuoHEQj8WK80r95XdLst/7/ErMcRwb88rwyzgPUox+QmN
         yObrJo+1q3pSf6F+bXgu78irV22gYUawo63782WNc7vOr1qUDHHoD/pKbdhy0M8OKlV5
         iib3FtkIAjWDXe4/ZpLYq9tT+VKjsdD6NPy9RnjD3SAgn2vNidQ4A/pFydfBYomgVC1k
         lPm5KN7w17DoHT89nEqmXPffBjIYZgcTlbHGYSx9mX5ACQS0LauluylcskdfBLU91+KF
         gpASBvO/TPKD+WAd0DuanGAOk2SKnDJfQ76kdY7FajKKKKS4HIgS6VgXabqv5nlNLQht
         bnbg==
X-Forwarded-Encrypted: i=1; AKwUvByycUw49pk3YdbN8nDF5PLKF2smq7D4IHDy11mKyFWVf7bKEzHHsWAPNTY7PO9edLWer3kkRz05Ce2PqQ9Ddg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKKpZsfy56o/IueRmo3573UVtGuiOw6G+gKA2wuMjn7CDtvKJoG
	ao6ea8l7Vhir/2QiDAdNXabkhSw9WRczqnUtkMJA0bClcTWFv/AE2wFq
X-Gm-Gg: AYBFou0IdP36o5beMUKbNODl7BVYp1loJhLsFRJOOWI2rdLMJttE6s2X6eRL7wquFXT
	RsC93OlzPomXo3jOawYoakN9OFS2ahm8Mcgya2fa2RPgohqPDAzn9Tg1cqsOw6pGYovjUa+14UG
	DSp7f2hcr/2QeI6l/njFQ1IkB2joRcm8vsPTEIO5X9hrFL06Yf8/KXSrcV+3dKB8sADGdPMSoMV
	DCov1PSk++YzjGojJeU1V5Nn90p/Zn5mCWkS9oIZJ456naMKAnGWM8RF/u31KS7PteGRAeo9dmI
	2WE7bAopdzSJXFvdfuC7yIvjFLbVz6/KwZpYApLevsOg0GRL1cRdmY7KS4ynreOh6li7LaAAue0
	+V9Xor18EdMmq1VNzjRyapkkiQu2eFPXKaskDfICvo9BbhN2jWSGuBuTUW94IQ702nePk9tdSxN
	U5KwCt9+FrBWaaJslE7bWza2oHPRU62gsUFNtklZeV33Qfq4RyL1Fz1Ye0PDNmWFXlOEqCjGsYH
	fqKAI9VRFZzo9++ODCuWjYIDwNNofT16vmGIZbK+RnyVK3H9afm5eDi/lz1HPdqn5ViOd/CmQfe
	9fC3Xc48OCpAVQQGpLl5eH5z/iF146Knv2CMg7eWbFmAPZ8n4vCdb5Wn6V0Z74cs9eEtv7Zlxui
	Ck4GisdZpbI6Y3ZKkQJ1SltOnKyWl55A+voGdbff0LfNhWQQ=
X-Received: by 2002:a17:90a:e7cd:b0:3a7:9413:cfae with SMTP id 98e67ed59e1d1-3ae89839170mr906333a91.42.1793338018851;
        Thu, 29 Oct 2026 22:26:58 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845429e6sm2421027a91.6.2026.10.29.22.26.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 22:26:58 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
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
Subject: [PATCH v10 07/14] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Fri, 30 Oct 2026 14:26:22 +0900
Message-ID: <20261030052629.27742-8-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030052629.27742-1-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
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
