Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923611;
	b=R+D7tAbQLcqDW+AD/8g1C39VJQe74/zLkP66IEerNebzADHyIZh1ZP729gVvJHYsEKlp
	 5Ht+Zy/QwMa3Z+nQGEHuUMvy1/VkQiCv6MBETUgj3tbTXTIoMv98uYlCuAm5eBnHHNMRC
	 dCd4os6eAMDXCoECJ4cZOK9lXMfiSC7Rch02EHVciQgE/ZlGUkV8lPZrsO3oRJwKK9kbL
	 niMYFMAoK2HwNc7HqqrrPzgBoWHwer/xyDH83dVTvoSUwdP94yBTUAbDjZdQy7uGfxWr6
	 ChoLWeeA2QLHh+cO67tyRRLfw1fQjwobK7AnM3Srx4ZGWvWJcYq05OyelI2bHZCpF2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4ILyx/FBtGKAhRWTc3Crl9uIFFAT89HD4WOeI2dYsjg=;
	b=suVP9S624B92PUZtXfCyvziSgZCZ1cDTlNWPenv/qRL08YJsh/eKz+uw4oklbbZXJvY3
	 BOwxrFESYblmFlkf7gbRwoWrDccA35qmsvmIIyafFp7m+DDQkBDwZHmYi4fPM9LjdFHxB
	 GPba+HgnzPaGEh9j8C27k17SojalKE7T4thTjBPG5AgJdh983jqec0SmqvaybEL+ISikD
	 XtVuMSj2nZ4u1nAOFqfCXSv1iqEgFlmNhMUedvHpne/JIv/HTF6F18nvQfth4dnb6hbf0
	 RgHEe4WTpTc58MW//YqI1psFrTfOVc33astPL4cp/uFrodiT+kFPoK5G00Ts4oVwHxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J9BTkpzQ;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCAF606A329
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCCAF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J9BTkpzQ
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a1947498bso238813eec.1
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 16:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793923610; x=1794528410; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ILyx/FBtGKAhRWTc3Crl9uIFFAT89HD4WOeI2dYsjg=;
        b=J9BTkpzQ9W8RrzAqQ5MSEqBnJhiYX0dBzEx/y7dkLA84c8d21I88Br+pemwZEddTR5
         11Km4SxVS4JO28gLkAVlNynYGj/3eoRiALl7UHxHuTD/hlz3aVkNLnYRkoKwZTSSJq+b
         sE1Rng/R0zvJzTnJWzZN/58LvRzOBzkaG/LwReIgme54mvZFD9iHlIRP06cDZvr2HyRl
         17eHNLD2Dyt3K8a7Q/8Z26RaFDPYNy9Hx1U4ytDC9Hjt2aW4QC5g6r7xL1em1OAxCQWM
         VUQUFK2KgMzhiIH7+gQL2J/eEK4CNkX6zuh+CvvgXhdWiHDJhw6FRwsO+pWa3hxfm78E
         vF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793923610; x=1794528410;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4ILyx/FBtGKAhRWTc3Crl9uIFFAT89HD4WOeI2dYsjg=;
        b=hY/2YnsmepJAfEQOcxs4UQyHIBZICL+bUPSO71lTvX5khzoHo8395rWtWMNjoAriuq
         DSJqGA7pX26svM4fFvyaWCks6UavIpqXIZ098FyJU7/cBmWWLyYLHswoufL93LfVFLDm
         +fI/WvrZwozTmOs9zvcrgGfYVVxO2UxHV+yIXLkPnMfXjK+qszGI9BihIBdXyWOzOinH
         nHmX6x/IGpQJb13Hp+5kP0n6a40N0gTwF2l9fc5IP+XLpWvhjtjd6WKhWMD8gGwyK3dn
         r0GQRBNCUEuGg+pvb2YHJ7sHITEcXYBWbbsZWQvd+Tls/qm/aewcCHKQM+MXYzxbgmvx
         3j8g==
X-Forwarded-Encrypted: i=1; AKwUvBwamzgRh9cy47MPAUEo6eKsgX1RXLBqRdYMBAvRLYPvaQhcuUzlObIk1ltLg/wVPU2nkOnkEIg307c3fEnOEA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ddIboPDdbgsI96rvqFxTsT4uzdhaYc4kg38oIbvfV9z1C7jTV
	/3k4RKhtFFQaaTqzklWfvdiYVV4i46Fz4Jc2utsc4kakz5vmHDTcwSw6
X-Gm-Gg: AYBFou2VCZTbxo+dJFIbOg3lAM080mJpb0zPSBBuvg4Rqzo2cVPk1FnkTrT45gw/Gn0
	4nLEqzjnwbwh341sfB8PG1LzOmITGG4Cwe+cV5Gbh2pmmAdyv+0toGBwDZRIqNI62SMWpk08qKA
	XQep+arKxOWLN8ZTvBxcmdOPJiERdBSLDceqPLOUO3+eJ2Eq70QSih+00THph+eAKY9ab+Gwsxk
	RvdEaY9DIcyyWqRWu/mqaqC/sSCbJVh/4n7bwKiE7bRCOJ0NHnBka28QqaT+Xzwm2uy8Dt1Co6j
	/tolKooqDzxFjhX79cmqoJUt9WzKnTC+zFxVEWaNCMQfQJPSjMFyS0sQsD6Q0PtCyXCX3zsnHln
	AdASaOwKET9hJYVlfs3uvkfBYXDpUCNmUiXtydKTMsLLVinQBGMZwcT6QXfYvDz9jHj9I/GW9Nm
	mPcER3vt+MM5+rWr+dKKxwcARrWN5vPeZDe14tLlZAX/ylMKsO8h5UhdZqTjXsgoEslkeno1IIm
	6rs7x+UShijTqnR0j1eFmhHqholwkVmIMlAFaGUbmHas620MaCRMN6DMc9Gl0z10qcnzStGcrf5
	z1BWjYGvNHBwVauovpVwy7Rk8FeYvah55De5ugaE4Bponn9EOT3sAIp+ijpWI9NzAE6FnsIbNvM
	/MEQ9zkgwomm5CxTeUbCnGLZrhd0Pwb+zOAX96YkhzhmBiF0=
X-Received: by 2002:a05:7022:170e:b0:186:3f0c:bd09 with SMTP id a92af1059eb24-1b25d29403dmr804327c88.5.1793923609691;
        Thu, 05 Nov 2026 16:06:49 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4e079esm371165c88.19.2026.11.05.16.06.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 16:06:49 -0800 (PST)
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
Subject: [PATCH v18 00/12] ALSA: virtio: fix capture lifetime and accounting
Date: Fri,  6 Nov 2026 09:06:32 +0900
Message-ID: <20261106000644.20460-1-mynameisjune111@gmail.com>
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

Relative to v17, patch 4 adds the transfer-failure XRUN latch so later
completions do not advance PCM accounting after a failed ACK. The existing
ACK and prepare recovery behavior is retained. Patch 6's partial-restore
rollback and event-message ownership fixes, and patch 9's wait-result type
fix, are carried forward unchanged from v17. Patch 7 retains PCM DMA lifetime
and fixed-slot completion checks, and now reserves the successfully seeded
ordinary capture ring until userspace advances appl_ptr. Patch 10 retains the
staged capture lifecycle and paused linked-stream XRUN handling, and restores
full-ring accounting after active and native paused RESET requeues completed
requests.

Validation:

- Cumulative stages 04–12 passed incremental ARM64 W=1 builds with KASAN,
  lockdep, and OSS PCM enabled.
- The no-hook production candidate passed ordinary and staged RW/MMAP QEMU
  capture. The 14-capture sequence verifier passed across both modes,
  including RESET/reopen boundaries.
- A slow-reader QEMU oracle reproduces unread-period overwrite on upstream
  a4311e9 and v17. The candidate keeps the ring slice unchanged until
  appl_ptr advances. Separate active and paused RESET pairs reproduce the
  same baseline issue and show the candidate preserving the unread slice.
- Synthetic ACK-failure QEMU probes cover capture, playback, and DRAINING
  admission. Subsequent virtqueue completions and recovery paths were also
  exercised.
- An exact ALSA-helper model covers partial-period capture accounting.
- MMIO rollback, timeout-width, PCI remove/reprobe, and linked paused-XRUN
  evidence is inherited from the validated v17 candidate for source paths
  unchanged by v18; the manifest identifies those inherited checks.

These are guest QEMU and host-model results. ACK failures were injected by
test-only hooks; the returned VirtIO completions were real QEMU events.
Physical Virtualization.framework devices and KCSAN were not tested.

Previous version:
https://lore.kernel.org/linux-sound/20261105070845.6449-1-mynameisjune111@gmail.com/

AI assistance was used for analysis, implementation, and test preparation.
Assisted-by: LLM

Thanks,
Joonho

base-commit: a4311e9447bbb219044db38897f95be112f46a8a
