Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201388;
	b=zYo/p7unXFvuQ+eP/r7cejADKAXn3FPNxuBLUOEYMzRB01KtmVxCklPuiaC7k5QRM45O
	 w0pVytPE7JK5f6nAUUsvVcdINReZSp2CoxK28zhmH3CevDI5F7iQ+Yk/bdStLGPNlBBJQ
	 mO6fFHCn/yDwtgVY854yUYgf1W2tEewcSg6kNksxTcaU/OS/fspdGqk6Xhcd+uE3+ubxf
	 tSX2c7RlF+b4UfVtDLJvqDdKUH6v5JC9verOej02jmqd/8tFvKOMmIbgXIYmtvQS2c/K5
	 75PgqTRAkCPNuzz3aWcp7Pxo04RQlvCv9Yk/b79vIZpZXBdNb02ynd4piEcrLa8bUTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
	b=JHpUzNiDJI5PPWVOExcJrYiyi+tDVZiw8qH0m7ELaRo6ww0IfCwBciIblM+GoCB9Y/Qd
	 iftbWZAwk6Jk3fiOdfGDu+A7rbuPdEivNs4VXMGw6R7o1DIQ+W5NCAWcg6MwDiMjjUYZc
	 /7Ku5hjMJJ3+/GF6qkH/BYWNPNO76+kNS/Xvlx80MUtb2utedxPmee3pk1UQT3YmqqRmv
	 pIXvluJHvGhmpE2jQXxpZlYqQW0ZzvSg2MLh/Iac/jCXieq6hgB1jlHILX4RVn/pEtXI+
	 +MhZNO6la9juaeMe7AqGHDQYMiW+XwI5MMccd+SLqqDQDEBuyIFIwbJXXUiazUQdSCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nVbS5H0H;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED29606A325
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CED29606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nVbS5H0H
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a8cc11ac42so298191c88.0
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794201387; x=1794806187; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=nVbS5H0HmZgDVc+im8g3D7H4UTJ3dfVfeHJPC/qUoCLJS17ddZC/BysfSxHC2FmfSK
         j56oaGb+Lv5PH08/dXEUoxqvpZvx2GyO/aFzOnxcs6NgiD0JL3E1ybg5RwRbBNGZyhcF
         axmTif0FetqbyOpK8gzicNZ2+o09VPUHLE68jxuwTyERLRiKK3Hchk2PuUSH5rL2gGZ4
         bNzEEcI3wYSnYM6k7Q27LpQeB12Kesmeqwt/mg+r7ATtA9EgUH1yLwNdWVe8UfkaLhG4
         eikuGB2zHmglTBXaX/d4yK69PI3Vss3nuMHtLP0/czrOFQCQJeGIUqNhllDKCTZGKEdW
         qUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794201387; x=1794806187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bu79jnLYOYZ0lwXrvvCFZpjbtsmUaJ7g+2H7bpOxRio=;
        b=ANU8soS/WBQ/3Ji3ZDIIKsbKZHNYt6JRJhyNbqszho70kAhx0VVr+D4i66iCZQgwV+
         cCwB+UUuSQeGlrigNZnetoz49n35x/si0NR/eFAL9S+MdbMovV5rBa4cWbynPF/popwp
         l8naJAO2Za+WMzfC5i79MxAzOwRI5ox4v+mYOrw91nEzHSoA8wz0JGvslHRR1GnOLjZ6
         bLfOB/nM3vxN9ib5UdYEkRmX+1V1wyp13ihr3fFOzxvkpzo1YuEj8KuPFpzS2TuicqOz
         cizVeyKzHmmf9Bc1bglBOv82IJd2nginAy0Brk8vl13+DffCMiirXG8IHdCczsP1cPcJ
         QSjg==
X-Forwarded-Encrypted: i=1; AL+hErGWVKL3EG9OFpdLoTWQ7eawjAlVlpmWsGiAEs1ExUoH6SYnbwg0c+0iBqoz8nGINc/12FG+N6hQKMr8HadBsg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/5IDPyW3n29Y6ymYWNXKcqx5i0j7gLazS/qioVocOm+sewV4CT
	jQ/M7zzdsW6+wnk4qBgljjRa24DXgAC53JoF/Yjb6LalqcTShuodg82e
X-Gm-Gg: AYBFou3bPOs3jvXKsj0BLp1ZW/ZphJk2Cl5ZJQEXG8xYkCoPF6B15ohFBAX8UehqKjR
	P26IypEmvPIcl4chcin3Uk0rpSyFhfHnvMNPJvmOOBJc6S31gpiyps4UEhTdBGN1KXgsrS0WIOn
	vwmE116slcDg6XZeay+CWPZdT9LB8+sSN3er5rHRm6srTsPYqxemLaTfQCUo0Xp2kt6YoPFO7na
	yJOnYQr7sJHOwKvrV1d+bxHeTFNr4NkbKm5sKkmqMNjGsk+S9xVwoMy9NmrmCtcKbOgmg9qGjiR
	Kqpl2JLHWP7Lh4eyqcnmep9OQ47+jlz3GKuMn9d+h9+Ado9BdLdnYmJwhoPn8X+Jr5Bkv3WmKMt
	1o5P76PX2V5ukTlATuag6cTxxQAd11oSsJRKxS6COQB34RM1RRrXpQoOcNRvPO4Rczu1tf7CNHN
	sl5IbcUy6FHsPF+VUnuyltXBu/qNNEG6vEr9+pRxxgUxI6KmgXXBSdTfzOYnp6kCw+6VXMpEjUE
	XUiOAetSYLIOol42rUOFBw8S2/hy3q1wirK5+TDlO4vTLyy5ctAvvHCeSS5Uddw462zGrzrpuW9
	2s5l7JeGhZFf0qiYawn45GG1aiX2urDhoVmvrsRck+vexxeqy0+Q2IeKHJJFcCOqKHkIDgWw2Da
	h5slXeWYcb0sxqe16F/68AbKfu+dprmXVoC8OZLe8UanohLM=
X-Received: by 2002:a05:701b:450c:10b0:192:fd91:c567 with SMTP id a92af1059eb24-1b39fe87361mr5510996c88.11.1794201386847;
        Sun, 08 Nov 2026 21:16:26 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314826asm11395635c88.3.2026.11.08.21.16.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 21:16:26 -0800 (PST)
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
Subject: [PATCH v22 01/13] ALSA: pcm: mark stop-threshold accesses for capture policy sampling
Date: Mon,  9 Nov 2026 14:16:06 +0900
Message-ID: <20261109051618.22506-2-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109051618.22506-1-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
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
