Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862541;
	b=MyzZmLcg7S8v9LIG0Ci0Xb4+gjZsR7syExVDSh36nTtsNTezqEdniV/aM//KDFh19vzg
	 a2J1IiezBQ2LyjL+gPfIuSI/dW82aWjRCdsWYv2TAQNz5BxYOjw4o3jgt8gdA9g8TBBTJ
	 6rweikNzqtr8EgLb+cIojnyp16bkHqhM6+J2kjK1aERgLGA8Xq02bTc0kC8JRQ3spb7JQ
	 LE3kmujjrdsnxUGnhDX9pzK6Kjf7wA2YZ4FkTGQj2iVpz1W0WSLeA2jDTfPdDctdPddrL
	 sjdHWO7J/cwLOIfjaBHVJ8AxTYAK2fHrVudHR5MBELQ5IWJ269C5GWix1qVLSrR3T/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TCJQrdOJD6q85RoEuEvG9HE6RMwlPauaG0/4SV008m8=;
	b=QERWZj/0Zzur2dc/9rUwga5YZnU18g4JlT4RrhZqm2n61w/6/j4wHoWzgSRrVGGs7ZJ/
	 2FgoYcQ/DhEDvSon8nAS3iAvjDJtP/KiUQUiDEFeobh1dLgzJOGZGpre5aNe65I5eIk40
	 /4XHmijQjAZ9Q2hdHII6nRCiSRYR12frU67ytm+zFFb/wCcsu9R556JVHi4JS2/k1yBbm
	 KiTh7+D1iIbBJHAOLBsx7TJAD+vA6PP4+NR4EQydyNliVcOAktCX6xbA9pznnK2crLFPV
	 UrglPuxbsyaGiqsvRDtUVZnhMApee05JIJeE+EX1eqiJ2wAbj58ejP5Uqck7LAd0oLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE56606A329
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AE56606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35c76e9614aso2044480eec.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 23:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793862535; x=1794467335; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TCJQrdOJD6q85RoEuEvG9HE6RMwlPauaG0/4SV008m8=;
        b=dFrJoKkIfcjzDPyxXWmCjJzp15DscxIrj/rysbzY+Y7VBJKCtMRV4Rrj+Y6yBgzyCK
         wfAjmFeNycvJOFQk6dO3xSTwgTHHzlZ8F4UgmgeBTsHT7waJT7Ma+xd7ONPqq4U47Y1U
         UxCDK+NTmxsAZHBKg1mWFBLKPTo57CNv0ilh/e3K8qQzLEzDhyrFHq7oaOqgEMX/kor/
         UYLodHhDTnlkSnv7JykVO5q//qRSwhAuyez8dRoqshmPK3OQ0pq2x8mJ/Yn5fdUYKwLj
         dbXTUEYPsSc0aIqgh9ENykSsmkV4i/R4PStwPRDSvbw/FNATg67AdPHBu+/sJyD8sEK1
         JMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793862535; x=1794467335;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TCJQrdOJD6q85RoEuEvG9HE6RMwlPauaG0/4SV008m8=;
        b=Ztdc02JiXfLRq+iSPsD3i6kOFz7ftYApUwhPZcVDh1Q/PZgkaNKsHBiuVNpCaUNPa1
         8JaH/3EwbJApzbpzS1z6OQH5OuNeaUpMXzMt0yQq3ypceU0l9KtvXUeWtkVTnxZPqjla
         q3iUzrCkXVpsHY3iHVvrLUqQEDMsycluxnJ/WCrH9Fhro18PwJihClxiW/ZU67krw8JS
         FMHmG0gJbUmEg9W10+4tg80Ptxa0mGaQ/XQ/vV6bRWpdKbGHVGrqglWo3BfCLv4jT2ju
         /jNqQtr9sEXRdoJNfUhGKs2hAq0hfahdytKdrZR9r5kSM2QMQM1pd7OQfkOW5LzjsOJX
         iWHg==
X-Forwarded-Encrypted: i=1; AKwUvBxPFhi//z647kQ8R9Ims1zEJ82JRj8eq0w3U/OtB+TS4+insJ6xzKXgoKjsPt3aqzSC++etzWhM0FnpFE0tEg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8WDLthQrLK4QGLrOYfSFkcVwPMA2t5zHc1xKL5n2bqsT94gG8u
	J7hykQSlJ7YelmMhcxln50N1xwxaPuXMR5fed7Oy4TlWw9dwY5eK4Rub
X-Gm-Gg: AYBFou2wuI4o3guByE084+uBbGu2PV3HkLLhU1roE1/b981a0sJhLl9lojmyqMDMSDQ
	2E1tUQBYujSxABmyOI2mqF94VLp32Tx363dQ1EbrIyvIgctgu4wGgASVsB9ers9oP2LfUGwVudE
	LzQ2RGlfKWRDedXHnwX7+2Ax/k7pwrlUEsKeYHRwK4fx0Xpui+zNa2o0Kak/V4nAD90sTYxozZY
	18DlZ7++A+vAu4t/x9Vv1Knxr2fd6vBnaFuWSD+elLCk/LUsLleRpvtNrS7vYgE1Zued7egBZHT
	cTVsMx8n/z0H/7Le73vYp0R+wsWeTFhzwjTry7JVuUULSKUzK/lLyEtfJV+UJWUj6w+s2v2gdCH
	sOYHScXcVnw3m/qQXRojsiOv1pimctcsu8X781LMUhf12rJB8z19FXSrs0EtW4P3dEqlJ6Q/RLb
	dTL0wFXkIxZlRdbDdn1A8m+tTofiIZ4YCzzMtngeT7+1Wf5lj2z+IY/cr6sDTrTsG1pu+21MCwQ
	YCwQlzJmBEH7cGgaiNroaEFwoVcjKWqH0KtxeUwy06EYYSmpwzdlAF/7q2kVcxVIDlXjIbDysJO
	tUeOug3xLFhP3rjaQOk/WIBniuRc/9rrQCNvBr7LTIwSc1J5jFS/RHpT+bC22N3w65+5jRmHNlr
	nGAtpuP2L8tzlGxZlKDl7vBkvBEXdfSdi2JPV71QMtzejGLU=
X-Received: by 2002:a05:7300:5988:b0:369:ef92:bd7b with SMTP id 5a478bee46e88-36a42426236mr26992906eec.41.1793862534957;
        Wed, 04 Nov 2026 23:08:54 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm16812286eec.24.2026.11.04.23.08.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 23:08:54 -0800 (PST)
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
Subject: [PATCH v17 00/12] ALSA: virtio: fix capture lifetime and accounting
Date: Thu,  5 Nov 2026 16:08:33 +0900
Message-ID: <20261105070845.6449-1-mynameisjune111@gmail.com>
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

This version addresses the v16 transport and timeout findings. Patch 6 tracks
successful virtqueue allocation so rollback does not call `del_vqs()` twice,
and so queues are released after a later event allocation failure. It also
keeps freed event-message ownership clear across freeze and restore. Patch 9
keeps jiffies timeouts and completion wait results in the kernel wait API's
return types. Patch 4 keeps ACKs rejected with `-EBADFD` during XRUN recovery
until the core publishes PREPARED, preventing a duplicate linked XRUN.

Patch 10 retains the staged capture lifecycle and DMA ownership work, and
defers linked-stream XRUN delivery while paused. The v17 follow-up arms
`stop_operating` for every member on pause, keeps a failed linked group paused
until a successful resume completes, then reports XRUN through ALSA's normal
group stop path.
Inactive `sync_stop` retires stream ownership even when the stream was not
marked stopped.

Validation:

- The complete cumulative stages 04–12 passed ARM64 `W=1` builds with KASAN,
  lockdep, and OSS PCM enabled. Candidate r5 changes one line wrap in
  `virtio_pcm_ops.c`; its stages 10–12 passed incremental rebuilds against the
  successful stage-12 build cache.
- The MMIO partial-allocation test failed queue setup after queue 0 had been
  created. Baseline reported a duplicate free-IRQ warning after transport
  rollback; the candidate completed reprobe and remove without KASAN or
  lockdep reports.
- A final-source r5 PCI test completed three remove/reprobe cycles and final
  module removal with no kernel diagnostics.
- Linked PAUSED XRUN tests covered native pause and pause-restart. Baseline
  moved the group to XRUN while paused; the candidate kept both members paused,
  accepted `PAUSE_RELEASE`, and delivered XRUN after resume. DROP, peer PREPARE,
  failed resume, blocked read, and close cases completed with clean fixtures.
- The final-source timeout pair used `msg_timeout_ms=2147483648` through
  `snd_pcm_hw_params()`: baseline returned `-ENOENT`, candidate returned
  success. A separate HZ=1000 synthetic completed-wait probe confirmed full
  width for jiffies and the wait result; it is supplemental type-width
  evidence, not a device request.
- Final-source production RW and MMAP reset/reopen capture ran for 70 seconds.
  Seven final-source segments matched the QEMU sequence oracle; fourteen
  segments were compared across baseline and candidate.

These are guest QEMU results. Physical Virtualization.framework devices,
NOMMU systems, and KCSAN were not tested.

Previous version:
https://lore.kernel.org/linux-sound/20261105023140.18373-1-mynameisjune111@gmail.com/

AI assistance was used for analysis, implementation, and test preparation.
Assisted-by: LLM

Thanks,
Joonho

base-commit: a4311e9447bbb219044db38897f95be112f46a8a
