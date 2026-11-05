Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862539;
	b=YVn0bK29FrTNQiopDVzRFxuuMa10iye4kJ/Yrt1ZVCwPEe9EPiHkzWUW1NaJs9L6mcZd
	 MdQNvNn85nijRBh1WDvAZNAhlvoCG3wzwHw5AqV4l+lpTC1pl/h8oHuufcrrekVMESgrY
	 Yr5hyVW/735H9OtH7YMT8pvNj/wOqs6tKv+sZzB6GF/ezvUBjXWoVASJRzhqBfpmS3TpE
	 jv3kNC/Gw33SR3sNov8m5/8mMvEGkBrYL5gMupzkyXOAVBGN7JRpOUWxq1Zrd51HHllSX
	 akGHoVgNdhp5TXdRLFlhfHppNDN+nQ5WGUqyOvvHQqqG3vu2/pWjq7Qe3SK/QYWtdaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
	b=eTO656f4VmuMXOueb9BfKGViIAVqI+Bf2LvVcsk6MsXHs/kRR+B/Madf31hcBKVW2e1r
	 WkiGSKtN99DOmvfeAqWsRjFnIsBs0a1trx+N2hHcH/6TllJBygirP2903OjbtGS3J0IUD
	 VtFwkZu5MdUoOTEgyTYwVaU4ZShWDizTZP6eNBDwdDZZpxI97ZazdeGQFW3JIFRXOHxae
	 903rWYtCbnWLWCOAQsAO+hWPFIvJDAury3lgJ7Vpk1++rKNZ25sNYQsUI4VrXWva5cvy/
	 YrCYqEAqP6dAQcDrR22M4IFL5AobxdQzqge+QCN6+BnXvTwLTsnRWwWrE/+I3e8JPKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="oH/ECUO1";
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88054606A32C
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88054606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oH/ECUO1
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so2995090eec.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 23:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793862539; x=1794467339; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
        b=oH/ECUO1jbA7CxfprwcFndR1OV8iCOSUJc2V+tiPye1/iGD9MZ8ZsnmxISz527mX7y
         rC1o4bNe9rqx0Gwrify7qlwNHkqOsrVutFI91XblU1kErubEviVQDx51+rm/rTW9x3L7
         6u4Yr2Wi9xCPWr6u1rD6mESmxEXgTBE0XKW6VZJHGTaBegrY7vzhBmzBr+ol5OXnqauW
         k4RfktnfeDT6D/Bq/5S2A9nu3P5NHBapS82ELy89RmVm22fuhwweI6ozw+CIdETGuDGr
         mCLwoKnFC16flmFUaLasz2qUIFO5vm2CwqdWIkzoS/7dwhxfeu6WOVs1/jY5UQQ9oeLe
         5Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793862539; x=1794467339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
        b=arGyWFpJiZ3XPTWBTgCdlg6NHDdszfi1S+zsMXu/uuchSi4G5/UgyJI4yey6VDJaw8
         CQiYVt/PBx7XKK8m8GmIqcsGGLM8q7x+wFLkEO9SUdKA1IJ9g2LJGfFMVRDPnwKSBugo
         RFwNvDvObo7TNuMa6Uxv67GHfRrrfT4V8mAkx0c9HyG4K+fuvfhx84+kGCreGsFBwZ48
         8EksW8l+TYWlWu0gW9jcoca0/wNeDdx+rxNrbDySeP6SmGTTrFKXqbaE+kAuRMN5wLFE
         X73EmtCIl9vA7F4va7Pgyq58MrbRKHq607uAsiqisipubda6NnYb+F13u1dNPZvQ6NOm
         xngw==
X-Forwarded-Encrypted: i=1; AKwUvBzI7NJLYCZ7T4UlAn9NQPaBEqun7W4acRGh8LLtm1v/Hs0maG4I1TEB8CINvy4n+PtdI9TaYsdXjFfJmPCGAw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+kD/4UC0ukqD+gaYzcFRpD9BJ+trUeL8Np8UFA7eSwqYffbVOO
	Ig14lFZHul4BNakTQ2V+tiWEegRdHB2K9H73N6mhP2FgShIv39/TyUC2
X-Gm-Gg: AYBFou1ff1oogmj65KNbNbSjlxcGK8HhYfcte3mmPa/kyoe1q1mWjQf1snvO8rC5mPO
	b4TJPivgdAIkL5+WL1p35ivtLSNN/nDy4X8oMLKt/ozPcN9SL13FAgrAJ688XlxBlC3fjFYvQvq
	B9RL+DUkGeu9pZwuZp5125KMMnJD2mbaaRp10Qt9UQXlKwmKSELQlBjZHLwq4sVckV9lF7ZOzUT
	vn8ZkdFGdGiDJVwEKIrlQ16yHHxTX3OR6natE+pMbMjWe2R6NxDVuJqw6Z5K3O2JP4UJ84/ZJTk
	GfOQqNt+6swPVBFQyb166ir0CZXfGmJcAIFIkcAua/qh09U5YVQBQW5fNQPim42GMG7KTzBmLCW
	Y0r9JYGdkC7uwWEnz16I39pS0vt4l9vvzpr1KccRoAx2gXQtuwhR1fiv1CdiS2mIpkouP0gznMD
	s+piylVeEjUCybhQdpp1Gbzf6f7BDJYI2DXVF/fvzi8bwtFbWc+X/NyfRQW6q+BwrUgfSQF7CQu
	c5I7qg/tTUx0FvnTHG0/FkQnDuwei+uZ5Z9UU3DOT28zc6sbNygkZAVsfGmeJB6816QUHe8ZOqm
	/ELJYmUyaVUHA0f+bsG96lE/Ed2htTXIdwDMbbpBvnJZVXOo55LqznTs4dSb9LWLJmalgHb9v3q
	a3Zx8P4n69fZB4solnVr7tbJmrtMKOsQK0QqEVAGVx6qkNEPGBm2Qz6q6GoieWx/Wj7zF
X-Received: by 2002:a05:693c:6391:20b0:36a:21b8:b6c4 with SMTP id 5a478bee46e88-36a423408a1mr27277012eec.8.1793862538357;
        Wed, 04 Nov 2026 23:08:58 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm16812286eec.24.2026.11.04.23.08.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 23:08:57 -0800 (PST)
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
Subject: [PATCH v17 01/12] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Thu,  5 Nov 2026 16:08:34 +0900
Message-ID: <20261105070845.6449-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105070845.6449-1-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
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
