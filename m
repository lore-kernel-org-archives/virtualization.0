Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981925;
	b=Tp8TNP5oBIv50pQRG8fwPI3icO4D38bX541+vejIy1MSP8vkyVHuAhOQX32KmKD5c7Az
	 AbgsQx8dWBzxBt2Hxf4PwoTLwm53cePAdcmBrQsRXv/yNJuWHGUk0owSQqb8k5ceKOXAy
	 bgHV/5ctsWJWfeRdinWQ/hCEwxMXcK2s1COFlxnO/L2ilKsWhLzZRHEO2AzHjX+EmDB/a
	 CXIbYCvqMKKPdEFLFSwxLlzNkdkSuxbyJRgDEY21NYS9T3B2xWf/jVbTIJXsmhUd3J1FI
	 L/PslYyquRk/MKjiVTCe5TVECfYEycFGkkriBu8fPeM7P7RStJDY1Ud+8FJ1WOOBf0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+Y8uax/jwHHRfNA5XH8CklJUgH6lZS47SjUqzjnUVs0=;
	b=V25OfaLIaBpnmaXWNk8+992KvCksU+YYpuTdjQJYk7AMG3Mhg5xtiTVOFtI7GpTh/J88
	 VQIpbNfNLKJIYkYrLmfq7pVaSF6HaJSdZfOKcjIoQICHEFolWDkFN4rDJgs9iuE+0Mtta
	 MJ8JK76GM7PITPbe9Cf3E75/g8LAJk4Q+6DIvNWcAAp3Wd1RHyY1OrSdmCmzJoZwKhtmw
	 2xjZ6HMywbkxFjahfAs/t6Wy9vAcwUQ0q5CHSiiTyXgMETuIgc0prtoFS9nl1ZCorQVQu
	 tCQTZxz7Whcbzg9O5nVc6utf08wjja2unVawiwqURAOw0F/STmZZRbsei9UE4OAqXGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a94zN889;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193E606A330
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 16:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A193E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a94zN889
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15dd124bbe7so1671101c88.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 08:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981924; x=1794586724; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Y8uax/jwHHRfNA5XH8CklJUgH6lZS47SjUqzjnUVs0=;
        b=a94zN889wZLX56wLPRSLMjY9oeOhFYr5rVmFRlMNw8vDK5QoDROzBpOyzjtofBcwUG
         1XhRTCOwPb4/Hyp993TPNWTTB9AviwE8r7iGrMZyF5EagLoP37YQZhfZB94C3ijdkgVy
         LK4ygxHw8mR5b3G1o2S96MW0VkLQ1rceyMhrCVKceGyhlxcqGjxiK87ixgWjlN8Y9OJW
         WWZxB24hEaEAKf879pXkNvjF7IGndTewxuJmXLZiOEgakLgsflB0zTi932Pdz6jkl54v
         1trOyLK+0DSWnZtwW9vdsXac/HvtwlcR/mq4xYj9VIee1uXg/NAiFzaNhtzHcpz9R7Ms
         2Jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981924; x=1794586724;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Y8uax/jwHHRfNA5XH8CklJUgH6lZS47SjUqzjnUVs0=;
        b=zWJ4s95mxhPdOGwzIxwieyYSqB++wkVXOSg2cRPCsKaDdyqpXT9hF/syr/oqjXVltM
         MOEETm6DDFocIui3am5CrE/HE/84IoqRyGuTHt2jomMKpAqBHfy3pXUn+IylHGDjZmq2
         7Oi5C+76mX0bR1dqbYNjbJtMmqBXsWBp8gIZ+HJIFBZpkde3jbtZgyEUGWxuZ68jftND
         SlZjb7gEiXv5H3WpCXoaWkUYwpe/LzBHba5h1eA5dLLtRqmv49yVrBXer/hT7NTq+nWg
         SxNY3Tmm+nYo/+3YlbnKAtVAo0GVbg/SX0i0jQoCQR4AqMg5t1IuuJIAj6P6hcyACA8I
         s4Cg==
X-Forwarded-Encrypted: i=1; AKwUvBwvhvKCs9OqC9Vg9kMDeMNJpzQ4Gd+mvz0YHYIS4+LlDLKSn0rMN80vddy/osU1Sar1HTi4Q3KtRahXRJ81/Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+7aF8a+42ZA4jqhrwOcCLFGFEDHjRhfcoOZnxJchXTlOjsx8Cd
	vbhz8GnmjFZe/G49QEBmwyVv4IJBLqlKNtI8dys5XpJnsZ848BlPko1K
X-Gm-Gg: AYBFou3zrGCVKTXMkucdbJpo2EQ3cr2kQNNxmIr/TOcbwN3dz9czCkVj7v4IRPz0pqY
	J4Rxzhq8RxzAFVQbVKu5xluGHc20G0ACJ5se7orWV8avvUbpJ2D+Os47fYRjOxdWLix8fio+Z92
	FnEex6XVGnBouDWWfo6i0mi/dNx9yt95xo01WiUOdF3XAnP1n/hRO6j3UyGp6pW2aioIkPlEAk8
	UU0e1GXo5N98KXbcDtgrixD03fNYj0QOx83SdTaKirG9PirKgDDQRSXnOYTBFK6tU41hpUrSo2U
	JIBV00xlyJU6RsqR/H6eIF0GconkvKyqM8cO5sp3rqlv2pypaXlULcq5ZqY/dTCLPDuVn6j/bMF
	FQA+0g8kzNgbdQsgg6BP1QyAnQHFROp6egwOhcONnNfLvKExNLNPYGBkfOCXo+ZBStTXAT9lnSw
	7GIyZVdd2m5s89InQ3hM+vjsxH4L2MCObEtctLpPJvybgfgRIxtULQzvgILRfsdXMzM65uQhqLZ
	zTGSmxta28q3FzMDcFvl9E8ohkEdsG8UK+JSuhV+jxh4UZq+4xOKZ6uMe5TWmKibyipR39VI0T1
	n+LxPTHviIDtgTavLmtFy1ynsbfk2jjgv5qobhURM9oM5Jn7Yw8ShVzwcU9ziOXhNyaIMP57su6
	V1sMUgvFn8I0u2F0X5SYIx4Dhng5w78LGy0jxshQ6Chp4Jg==
X-Received: by 2002:a05:701b:4588:20b0:17d:7b45:f927 with SMTP id a92af1059eb24-1b25d3499d6mr3671255c88.33.1793981923536;
        Fri, 06 Nov 2026 08:18:43 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4840f3sm13139526c88.5.2026.11.06.08.18.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 08:18:42 -0800 (PST)
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
	linux-doc@vger.kernel.org
Subject: [PATCH v19 00/12] ALSA: virtio: fix capture accounting
Date: Sat,  7 Nov 2026 01:18:26 +0900
Message-ID: <20261106161838.94308-1-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Takashi,

This cumulative resend keeps the twelve-patch series on the same base,
a4311e9447bbb219044db38897f95be112f46a8a. It covers PCM stop-threshold
sampling, locked partial-progress reporting, the optional reset operation,
VirtIO ACK error propagation and recovery, PCM and control DMA ownership,
signal-safe teardown, staged capture lifecycle and work prioritization, and
capture parameter documentation.

Relative to v18, patch 7 validates ordinary indirect capture appl_ptr
accounting before calling the indirect transfer helper. It bounds ACK
consumption by completed, unread capture bytes and rejects positive
advances before RX ring seeding. Active over-budget advances follow the
existing XRUN path; invalid PAUSED advances roll back without ending
PAUSED.

Validation:

- Cumulative ARM64 stages 04–12 passed W=1 builds with KASAN, lockdep,
  and OSS PCM enabled. Stage 04 built Image and modules; stages 05–12
  rebuilt modules incrementally.
- A bounded candidate-only raw SYNC_PTR audit rejected unseeded PREPARED
  and over-budget RUNNING advances before indirect accounting. The PCM
  pointer rolled back, and prepare/start/read recovery passed. Valid
  partial ACKs also passed. No vulnerable baseline sequence was rerun.
- Candidate state runs passed valid subperiod ACKs, PAUSED rollback and
  resume, DRAINING tail consumption and over-budget rollback, and raw ACK
  before and after PAUSED RESET.
- A slow-reader QEMU run kept the unread capture slot unchanged while
  appl_ptr was held, then recycled it once after one period was consumed.
- Four final-byte no-hook QEMU runs covered ordinary and staged capture
  through RW and MMAP, including reset and reopen. The 14-sample oracle
  passed across ring wrap with no KASAN or lockdep diagnostics.
- v18 MMIO rollback, timeout-width, and PCI remove/reprobe checks are
  inherited for the unchanged transport and control-message paths.

The bounded ownership trace did not reproduce an in-flight duplicate
virtqueue add or message-length overflow; neither is claimed as reproduced.
Numeric ALSA runtime->boundary wrap, physical Virtualization.framework
devices, and KCSAN were not tested.

Previous version:
https://lore.kernel.org/r/20261106000644.20460-1-mynameisjune111@gmail.com/

AI assistance was used for analysis, implementation, and test preparation.
Assisted-by: LLM

Thanks,
Joonho

base-commit: a4311e9447bbb219044db38897f95be112f46a8a
