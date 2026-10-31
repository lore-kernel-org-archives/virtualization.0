Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412563;
	b=J5JPYDPXIOE/VzyWiVynuxgVCk19E02UFxSyXShUz2t8j7l+sLnkLdGMs6xmSMMn8JJF
	 ztLpqdEyhz5Olvpmrq72pOtZ+OsAMhgg6iLmaxDe/ZEVRFnnvfSglD2DBjHFQLNoparkW
	 TZsNOkayA/xekxZQHEDGtcRykliwBhVR894hAUIHpYecWZaesSfHyUk7r3vPBSbKGgpFz
	 UX20iUFQohWgcuu0u7osYdMdF9zgPmgH+ULOfHCQVab1ZqnzLT0nE/Jcs8PvrjCxAM7MH
	 PDnEWZQOiYI+lwZ77GVmvIxaQ/SN+0tgAL8fLBQj852oqJiQcobPI/qxr3AIY3nNwuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XTf7x6rvt6K8mT1295GgXCNKMEZiEblGXzNlO5X+Nyg=;
	b=u5oSx3suoEY0mwuRHPSzPJelTiS3o6Jwzmy0IKPRpu3V8IiytM3mWvlXnFlvtMK6LqvM
	 9bM/63Icqc1uQ04USYsuhVK5V+M4sR/6We+vmx8TJCbHZgmLW6P0bdEgAT9ni+GoPtVxl
	 n/pqzcaMEXYtE4lYTg4p41WIBWNT/jVx0OfBvTycQNqrkMlEK9D67gqfuBZIBWeTllRrH
	 lYnvW8QANq9346FR0SSsOafTnT94CZLjP5826AtyA+2WIbUW7miAuUPBHFLHkjMueeg0v
	 B91IG1nrWHN6q86ykhYtpUw5nkzUahG6QUc5lJ1746l3gdQjk04nkGnIY7z9UMR/gjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SzPjjKuA;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD74606A336
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAD74606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SzPjjKuA
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-369f33df08eso2679602eec.0
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 19:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793412562; x=1794017362; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XTf7x6rvt6K8mT1295GgXCNKMEZiEblGXzNlO5X+Nyg=;
        b=SzPjjKuAo1S+eQ1eeYvZcC3fGT8Gq84eCe82gcvCrmKArlStULmxMnNO6HqB3B9xiU
         2GS9G5vCxxuvfwjj6F+DpTSQ5qzqkieXc7RIopyK7WeW0dvOZfPQN/Jbm7fa0Un+nCl1
         kaVhal05Tcao+pV0WWmdJRUMmfUIl8pBlqJZ6dEC/hgewSz/0+IRcUMt8LvQ28sVBv8V
         BHCoTdLh9a6UDQsx+yvmFwwAYTZ/YsJKl07MxS2WTpwOC2aKMkJPTYAHXwZkWXERGVKN
         RKDeV7huJDon/vb8jHXOkWfDjNvufRIYM+QyPyZQk3MS4cGXnHEDBZD4K2aqy1YsFu84
         /pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793412562; x=1794017362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XTf7x6rvt6K8mT1295GgXCNKMEZiEblGXzNlO5X+Nyg=;
        b=e+EBrRksvcq4Ox3Io8/mWp2aF5BNLdNah+8tuOiktqC5KP8nH5uSRd9DlkDznhKwGA
         YompPwZh5oDarGw2iEbxjlEpGmh7cOkfl+j6xoi9ayl1OcbSPKi5VZnIXWlww7pRm4Ox
         1t1rRbLhnIhvSZGjBQQYsgJmgrJyx9x0PzixoZ8qU8Stuc4ilMUoq0dNzx1K3zxckLkr
         atYPXLgD2Ikl5rwylmXWC+hhBf6zmyJFqrb+WN8xx0JPwGbOPBKA9USejkGp0KqdT6GU
         d7KKQoOrq+JERTFwpJBSAZTD+4IWUlvoRpjSnFtTspeeB8B3cMEmoOkGOB8pzjfMXvr4
         005Q==
X-Forwarded-Encrypted: i=1; AKwUvBxw7po8oL2QpVE/S3YL1VN2eoIj5Ivh/LoB2RfhZqcUU7fqp8qHiqEmdRc5us8WBwc09h//21KN4qTHg95eFQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYL79pQjADFfhj2ck8ZpGR9vLQryFAsf+PYjNssoaKcKKXrtijAx
	1fCb0APhnSzkHj3NJqNDDa/UIdhTF6kx5YTVrnQJUunbRYuJQzVTqOx1
X-Gm-Gg: AYBFou0OVxeIEnbHYL+8E/e0hUlSIsT5TXj3OyhMrRz+mMVKHyvTmmtlWueIrTtd/yK
	k/01cu2iaCN0EaygbsLjrTjF6vgrvlyQVVTrukJ9+TXfsg34Qv1Mtp8LkiyWnkpiXXr+tCZbagY
	SIWXMJrfZbzNiQ8kz/r8fhHktBWz/uhO66Mx7aketECHIqtxP9VlCz9awvCXZRgmPf4cVPN16Ae
	HA3bwDfPGDotIUf2CfQhTWvkSsmRnZTYcMyp2cZ6orPK3lxJdfoPJPmtXwUGrups56LNEYXNT8L
	2cC+N7eP+3LfZ0tIGBCzEs88TbKQGMMJSqZrSB9SwVnDWL01chNcVStEV/Hm94Pn6jWFQI0nU1j
	hvX1UWopy61PFvAp5ckCNKcbaeIbDkasGQTqaJLbNLPp06nXr7J+VIuVRxwO/jNWTRgXWnMDpKg
	rcSkp5XDvm5jJCJcK6Lp3oLYqbLBHb8wI01i7LGIBla0979VJCTDjM/mfJ06sgs2d1uvgxziGbW
	swPo5HlXcRBdF7w/0xdL7yfOP8WvMVp6dOziRhMQj6bVE9i7x4jq3jRaDV+4/OvfnUir+3+Tw4t
	1bmgs3ckQRsHZdughi01vSL85S+oNKETykx9rHdW5GPDLtJm5txR6GNYbJ+vXV7bGJyYP+fmLnp
	WfXgp7YzgwckCeo65IFo19pU8pXrvR1n9s6HCkbIABie68Q16EOW/lh4R7ZGwZftgiD4=
X-Received: by 2002:a05:7300:2a91:b0:36a:1bd4:627f with SMTP id 5a478bee46e88-36a423a9d6fmr5462617eec.14.1793412561785;
        Fri, 30 Oct 2026 19:09:21 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm13214096eec.26.2026.10.30.19.09.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 19:09:21 -0700 (PDT)
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
Subject: [PATCH v11 07/14] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Sat, 31 Oct 2026 11:08:48 +0900
Message-ID: <20261031020855.2402-8-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261031020855.2402-1-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
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
