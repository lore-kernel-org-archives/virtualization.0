Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062071;
	b=maL1jjvBMCz8vYatn40xb4Z0SSjD4f4OQV4Pj1ojeL50ngBLKpgIT2vcOxDK+AtXduiP
	 otxlVz7NQyVDv8NkxLrIhYMXq/11bZPmQVDFC/0I+husRL6tLY4ysWOl0/Vihpgx/vZX+
	 Aqv1k376AvgrZBWFxQXmzHwopeheiO4k8KBODcVmJoKFIC5qNkE3LjRk2Lz3Us/5a2aMg
	 2hHrvkiaFMzal2CWrbuZUmS3Mdf+ZgQcRXxaCox8CQ0n0OkolmW22F3rK52fhYEJFU+Xv
	 dG4h9tVwDZVFGNTLOX272vi7TaST2nU9v3GRJnj1VnFcOpF9VasuuXTCVH3DDBHN1qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
	b=wi78JKMqU84/Ebbv7wvuOzPJYTsfI1120V4jQ+Ejra01pFb6lZJqWMFWOd4gC+PX5NK/
	 UCvcQ5hsjEk5kp4ROQTJu/xcPXndKNN7Er7YZ7cjkFoIC9btwPOZ9PdJ4v9m0s/I6oQBh
	 Fp7C1rUArLNyDrT7U6eZRGGKIUfztLxcEcdMojt2hfJJx30XHyPPOzlKjENPpqUEBGX/U
	 PZkPZkTJ91sPQHCMNLsVdPhVFJxqpB4bblAgTfl8v0aLU/QhpOYXzm5H5SHEvJUlhC4kQ
	 bANzN0WZfZdUwNSRgQTXIy4naCjvCQ5YiL30x0HXsKQYgaPphRP24o1VfwOmI5L3X1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gt22IT5Z;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F3A606D80F
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79F3A606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gt22IT5Z
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36ff9c9da34so2109538eec.1
        for <virtualization@lists.linux.dev>; Sat, 07 Nov 2026 06:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794062071; x=1794666871; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
        b=Gt22IT5Ze4oUp9MipDc1rMAtCCTdb+dyJBUBNU8mq/1gj/+gNSrYQWRBhkeC/iWMwC
         JU8/kvJeJ5ZNXNTIYQGSB5g11ejES29qOIA7M/yEd+YjiR17mJG4n4wonwYYx3IvnArO
         Z53gAT+KRQamT/qZm2wHkrzC+PyuXouyNFtRK1XBEUe1VkgyOHQ7+mOyRf0Doy7enA4T
         4CIWBkaaXxxx+N7e8BJhLVPrOYBKFXjaobLgwm31/+YXM4vy3HfQCea3H9yoe5KABKX8
         G6rIt3I4da/6/2DYITKel7eNB5NnYxjLIXkKV8XaAfOQOD6XZeitGaSGphnfNWNC9P7z
         o5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794062071; x=1794666871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6dd8UEmYGL47gppjCwakrDSGeCZVV1ZnI+Je+e+Uck=;
        b=dwrMLHqOc6l+pCT8I5344QHGwFuMbU/3iHfpH4tZ9LivYWT3t7aLSnycaJjOMZzFbW
         xQYiObvkGkr59RviFbVbDeuV0FlcB5EG5l41tTY9QbjVanX2DSmNjywbV/STLOuxC9BF
         Y7BPdIwoW9MsCXK2NZRmTCzZnaRHG0qWV54rKRhFSfXyK5beNLgnee2PLB//sfQicpEp
         0AuW4vLzDLOpmPpWI0FQzYaH0uUdk37qEOSXLTgQ6afF6utknyTAouyPaqWZ8L+ouSaB
         nOA1hgfuy0Se/Fqp8kRuCM3PG1/aN+1T0Lbd7RtD2eajHbT8VuGRjGMaat0vlV8D6Utp
         bcCg==
X-Forwarded-Encrypted: i=1; AL+hErEgewF4P04z3GR1MkvEcc1zLZ6JIHjMUTWM5v1ZLtg/E4NPY3Hd9KDNuxO2ug7knmV8YLNCvuPNerIYoD2eGA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9sUL/v/I6o2SZHm2SXkyM8+fvbdnGtAMj5N4N0XBmNjgDA0su7
	f7WPTXGoZsG+vFHk8GVsTKr0TjYiuhLHmXjAk+/O4Gb5+mEBeeq/fhNK
X-Gm-Gg: AYBFou1thY/5yZ9GEVt8C39tGy+hJGhsFWhejrTntAyU7ck/qiQ1/yx7sbzxOr1DdvG
	6V4KYbVi2XECl/r3ttrRtJFPoo+FOqqu2jjIB9taIL+/7rj3L+J0S7RDctqOofln36p6ExAmpVB
	1naPKJ4I+ztSOTn6t25rAnh+fXSiee+ephSyEqsaV7rbFbf5oTGFWbxNKb8xekwZ3Lv3WjowUph
	eaHfNstHkVcmMVA36v9pCCB9+sfyjmNaBGO/hh/d6ci2gwKs9h+fNyM2roOhfY+FhxR/g6Kjz1U
	04I4df7ie0al4O9xHMOaWc+XkXsynI8jtjzxD5m4l3JXW1sD8xrJoGYcZl9FdvOI/6bNEmMLEpn
	XuyrBht//POzsReSfZMaOnGJ7mkys4p/GAvwYppei8mOzQ6Dtw6OHf7jUyt8nVo5TLq9rBrvLIB
	HwmtHQFmLi58/05MfnTzjvcdAv0c759qx2UXn59RvkX3gvok8gA8cqOOKhrbdImie8y+5A/c0Io
	NreK2d674KXQ+TMkrsM89/OrVLtmOODrOvN+YJv5T3Vv9BfWScmRMkfDZseaYHvK+eEnJjkVZYB
	jmrqBvlF32uvUioIDHQZFjWYbyLj9TWRV86+GZrIqF1LC2Xl/xCuRVuhvXRvuIyhZpZn//554zR
	ivbvkcgHMVqEjfLWVnTlLBb4TeEj60yeP5g4zEpPJ62JrGg==
X-Received: by 2002:a05:7301:d813:b0:36f:6b99:f94d with SMTP id 5a478bee46e88-36f75b1f80cmr6584172eec.20.1794062070524;
        Sat, 07 Nov 2026 06:34:30 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm27881873eec.15.2026.11.07.06.34.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 06:34:29 -0800 (PST)
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
Subject: [PATCH v20 01/12] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Sat,  7 Nov 2026 23:34:11 +0900
Message-ID: <20261107143422.29319-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107143422.29319-1-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
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
