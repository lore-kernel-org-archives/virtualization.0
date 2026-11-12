Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444435;
	b=Wh3smv3IEMYTj9/lasdok4GZfxXpUk0zRzWx6EnmrHRTABzhPDycEXtvGkpnA6cQtFS8
	 8GAA51Nw0qbVCg3jy7J21VIi2RkxPTmNTm0l3h7KTypm2O34LDfygu+DwXLScyw2oNMlx
	 TOAiQPvpt5F4c7N+oa4BhXv+e5pxeTWCeWJvOkGt/gWfm90cRq/2TIPVrm2HGqY5mkWdi
	 kK8vVYBHuf2tDG3SzT9sJHNvjPG+gqS/8OtvspTiVyjoN6bU1iD0hw0muwPVLjrhB6FJv
	 JwZSyz79LEuP5YYTuFXYBi4VzbEpXTztLT0mBGrCvhbTvRlIBTcAtVk8FLDO21J3S8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
	b=jqIZAU9wleY7WNQYJPv8eq8E6F0GMdJBgyfGpXeXcFjcw6442rixiIRKLkM7gl1E8Rmc
	 0n5fPbktqkgyAtbss58YzEMmIWN/fq8/xLWLI1NpY2oRhN3wuguN5GVCRdz9qXi0wb23o
	 UYel46dlFXTV4izdQBf9audzyErROCQc9z/WAx+hfPB2SudHWkRN6nTt8rD8bidnp/D7c
	 W2+X8rRr5CRKPFFwVwTiKkF4Dt2IFCaXo5eMOoqe7kFQS8vRJTTAZC+pQgEAYFrQJAqzM
	 dA4VaVAvI2IRkrrgi8V3YpDmsh97LWhtGfpW1FQq7dwmkH4F53dP2Rm2D2dPOYYgWHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B3iGoERO;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444FE606A883
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 00:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 444FE606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B3iGoERO
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-37600b0db49so324935eec.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 16:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794444434; x=1795049234; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=B3iGoERO9xz5jmucYMLuMoHVUtyh4JXb70ev+Y9Q8CZ/j2oO7YgVlBTnS3nXbn+3oo
         zr3whx3iffoArUhsaPtW4tfYN6+y0oSRhxVmgPLoLlHtkOUgHWXMWtXjG0nM2dBbuMhB
         sfu7gSlDIq+x7ZLaEhx228ibRdPJ26IUeMkrb8A8PrVQN+/l+h1ZIccLBu1NZ01k/vQu
         ntPYY094qy0Xu3sU3Eky05RveCXbVrTrooeY7Z8hgP92eQQ3pTtXV6KWjbjbTOi0EK8t
         y8eELzSO1ztBcw45XaKMy4hLYl4T+mTKmS2077lqwkkGIa141+FNFYSuZ0FLiTZqLopM
         Gc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794444434; x=1795049234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=VxZpsNgKfbXttkaB8w6WlxYD6RzDstaIY0aBt+lKpohSd6p5Slw/NXpoFqv6glDQaq
         4qPI/vCctGENVdfrl9dmvy02uZhBE/1s63K7eO+NBmFEa7/x4PKn+PHvXhjY5W2Ct2Fc
         gQp+ao4HeYBsMdbtd8aVToehVkd5pJCEfkOBn0K88jlR1mMibrNqLVVM7KwcCKZWWEcy
         twppzpNLjGdnyJtocsPt9huAPpxqUxPOmRXvs5G4REq2rpUFuRoL6WgHcfhXEpfyO/uB
         Gz44TymLug7fIJiYPXFE6DQBnRD+ti2DonshrPCy+ohD4SSenYwOtTh5HWb5UQj203gm
         yNTg==
X-Forwarded-Encrypted: i=1; AL+hErHNrYmrg5wwToZaOdpPQ/3nokVE+tQTEqY0f9CCHJoz5RY0WcIzeLgkJ3NicOBMhglZiRMAOQVvjfathSYcaQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ZZdE+n/egvzJWoesnYJj5d9P5DP+WJtDWI+BEkmuHq/y7arY9
	lxw9PN+IJdxp5DWBha5ZiRM1+Dt7QzWu0sPrIKOfy7HBUDb3XsDoU3I8
X-Gm-Gg: AYBFou3ha3z5WD6OON5sdROYQ3YrrYT4mcjyK+BeaoNBQh/FkQ5nRM8B3/fKdvmfP87
	bq2vxhvMLh/E2E0Ie5zoKqBpDQl55lEs9u7fsc+vbe8hvoNduVye/Sz/t7/jhO031EjkwuunN8o
	rl+s8/+BxQqd8d2q/HQGsmssW+7ymvG1JRXyApJ9vNtjViNNtJ8vm+bwJgYap86ABoTeJEU9tYw
	Dc4lIrFOgH85XOcSQvYUwG3pFZT1TjkvqgZ+t9FbuhQ+aMf3izt1z4GRraWnduuXPkwvblubhEF
	Heb4mN9TE/OJGuaodB7YdGUPZBCRFM5yy4GnwQExGXo3Q+EH8b1KY4FNGrM6kYJ3ntUZtuBn1h4
	/duF9Xoy0rbDcU3YovhQjCu3pVmyQKG2kXeUlQ0sk+gikWYgj4OpNY+rxv4IhmA+nCmT55iw+uQ
	lbNfChR+PvWby+gtmLv88lFItUOSC8MBUXtEB75gYHrciButpfCUVTcpyacUKoo/qSqoyN6e0a9
	1rGdUhNGDHF4w6Tg8eW4VmAw0aoWTWko2Ke+OufrmxUlD28oE04xFsWTAXmoq7abnEsvQNM8yTg
	7lrkuq/zJuuq9NAN1llR3hLpc73Y4mo3k1zk4bozUVKy/THP0waqIQxcBgqB5JWH+0oxEujhVcf
	TRXaA3WU9BxfEcUhoGj8MuGB+xjnDiNcgLUpIZ4dqX9mQlkc=
X-Received: by 2002:a05:7022:b0c5:b0:181:6b8:31f1 with SMTP id a92af1059eb24-1b4f5f3475fmr902229c88.10.1794444433999;
        Wed, 11 Nov 2026 16:47:13 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm20672163c88.9.2026.11.11.16.47.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 16:47:13 -0800 (PST)
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
Subject: [PATCH v27 01/17] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Thu, 12 Nov 2026 09:46:48 +0900
Message-ID: <20261112004704.49758-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112004704.49758-1-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
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
staged-capture policy sampling.

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
