Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693332;
	b=SBdNRvpVw+P7zRs3x7BlZS3Mj75Z93iOfu9gNgM8f5wuGwaYFIajTeCgfzmzRiVTwx7V
	 3B8kUzHGPeoVfh6vZ0XzthSuVZO4zobPN+946tGvV0703qZDesu+fmiXtIolvMWkKnRve
	 THOTvXw0Tlw4FnsMZNSETmKC3KbYdBPB0RioILiL3zZs8aoNIM7DaM1vcJJGs9NP0iBGB
	 oHUC45mN44KIkomOssIVdvb5QWe8ZG2N6BEBBMPVF7oHGu3VnECTPkhUbTAAZyyARXVeL
	 lJtrzDKQptiqstZBoAC2QbQXXWiVM09jvuPg2EXdk7dO+5t4ziBeBBySWOpjV61XYAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cywAFZhsAgp/KuYWOYg1vGaGoupxAXpCdkIyUc+cjWw=;
	b=q4h8GheBqnzGNu7Mvo3+JI6x/0bxv5cPIp/JVCYWOZrVOeqFB3nZgGGbcpPFvSLUItUm
	 cabOClgsD0THYb5dpMQYl0t8ePQoggZ2TnGofANdBJovNuROCpcB6riJT2yJh1tY7HpKJ
	 ZFwUK5Y7k9vF+2iJn9HEkKqMnAFi0IEwYy7rdWsWz2POcMzLKZucM+ZW7LqftERF3kXex
	 PtzpoAgXBzYvthbv4H7a3rvRMLY74HXZ7WZzdfNzNnWSihm63PkxBCGErimZD2LtB1/kM
	 q2n7vb+7h30gNcvtXeUqaSHwXSiPoKVE7bijA11tYcO+Xl1Uo2Kr5j3H/e50s2Rn22A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hVdOOfuB;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BFB606A33C
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4BFB606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hVdOOfuB
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36661f953e4so5955139eec.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 00:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793693331; x=1794298131; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cywAFZhsAgp/KuYWOYg1vGaGoupxAXpCdkIyUc+cjWw=;
        b=hVdOOfuBW9UK+tVRtcdZZG98xG1JRWmEIduLmI8ivoeUya5X5y7fGaM6uj6qVMQaKQ
         n2YY3YCWRSMvIQmcT5AQbn6gKsOtIvVaP//uUI9ikyybe0YYeQRfsTkgnONGxkoNReAc
         mrAABizQizAx/RFPlvYUqKWtUo79apvZd60Z2aMULXgWx8FOBRtUD7zJa9+loJ+VjgnI
         aL5VlgNBsIietnQJUIWhHecxC8YEs4s98BCRu8ro9j6Cq0ZszK8YXV4MkmbzNewvRogk
         dj6oStGw/nKgP09ihduJuMhHqVRJyrCeb1tvNhzVI/3LvB6JSjPvi5XDMzsKUBF9iDAp
         ff8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693331; x=1794298131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cywAFZhsAgp/KuYWOYg1vGaGoupxAXpCdkIyUc+cjWw=;
        b=fR9PN9Y5wJO7rTxWGJDkO+SXAxMpq5JRNSqaHeQsox7/8FYc5bTdSq+cZON7GyJs81
         ZxyESjhd+4Lned40GMW004V4jd1h6L70ZBQwj+t4CqVDYM5VlCjEwFdEkSpgKDSYFi0d
         FpYiXl3Jrgs0Kn9lEAWUj15mbQbNHD8vZTnFVYDHxrxlLIIJlk6yvxzVMvA7NN3vq256
         revCtRjGCrQDdsVz4F0orh4vLRL9uS5W++BJ94IHolT2lxfLSQe1yVpAeeu917Po9aDl
         JcKEWgKeyBxB6sOR/47W0J+UbarxnlhJyi5IOCq3GzExKqcn17tERqOuSwL6snJflzIW
         dfWg==
X-Forwarded-Encrypted: i=1; AKwUvByYUk7wtrW1+4KQRrltBaiZ5VAgp8zJlFd411r/yHYRN6P9nb1uRqdUBSxMBKZM06zKEeU0bziKpzVbpmiaow==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Tfl4sF0GtwEKHABNtkfHDuOlPmZD8o/FWtOj9mSqjBzqiLDun
	JJwsO5SlwJNjXOoCcfayrcjp2JZiFtBmywmYR5+TGyr5ur3/aU9fG+6L
X-Gm-Gg: AYBFou2i853bPGd/qMh2taGtj5tKxiROTLQ1+BAnYuLCReHX6SOxZaj8h8jlnQpTprE
	TiFe6/DuyWatMpFczNImLMiYMlQzyKf+dZW1Sz6tSw9V28mI6w7w7iN6H+MncP3GD39as9GVXYC
	+qk/q4NOE6uCg9X5RfbdykXWCF71Dd1dxdBY0nFPk/qge+HkSOVA6WgcY44rc7poSk/cD1DaMW1
	tmkz6a/FD7DxYXFHTNyG/p3SB6i4U9oLggPayy0eq0kCiXVq/0y0iysz8pbvBiHBQZowHXbv9VO
	0gfYcESZZwIpSU6cHGPfGhJQrlRJic1ApDQEOzyqJJRKW+QERzezkldXZhIzD/b8MrepgcoveWx
	oQ9pZMHlmuQwEefwqB0KS+IRW6tuZu19mo9eD6ltm6YwTHuOlUmlOdQeguYi9p5BeR0qv4XMG+P
	3q45OfZSoDl2v4WKbUXBIQH9rY2gF0CH8wj7d4v4KFplNubrK3pj9+EkGAyDUJtiKH4+MopJ9kT
	Hz6H32Bx7l2is0xO901JOnQKG/J7+A9OfXxX5Xqh/igxINOL5HKRbUpv0QWXWIOhMmO1vDSIoj1
	z4p7Uq++rSDfUG1D5Z8pulrZyEk06XlCTVxNFToEQZ6L3j5y10HcubbxkNnOWoeLglX304XR6vB
	jD63lAMQWvkpnIdEkmz8A6u0czvWM6jD/7mL5Mzx/1TxMwsIsylyTZZRNmU2p+naB4dkj
X-Received: by 2002:a05:7301:6189:20b0:358:ec5c:bef1 with SMTP id 5a478bee46e88-36a42425486mr17468985eec.39.1793693330692;
        Tue, 03 Nov 2026 00:08:50 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm41468466eec.12.2026.11.03.00.08.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:08:50 -0800 (PST)
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
Subject: [PATCH v13 07/12] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Tue,  3 Nov 2026 17:08:16 +0900
Message-ID: <20261103080821.16983-8-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103080821.16983-1-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
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
