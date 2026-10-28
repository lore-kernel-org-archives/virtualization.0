Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180500;
	b=0H2l34Qm0IQgHfeYHoMgrVt/zAatICnfNU6hblFszAKbZyNr+JT/ahOVZ15yg75Scja8
	 BuN1hFtDkhWEGCGpr90JnWKBi0ftNn0A1h4e8INL94DC45LrvnNbnalk6i4h9v2LlCHLW
	 bJtYdAYU2DqFPCiHUiMEuNdIS3q85nrZKF0qz/21/Y/2/W8YR8bRVw1yHD/Sy1NpA2LpR
	 ZIjvnlZ9L9KgpQEcIgD3t0CWhC3ktu95HJl01HVXxBaHnhjmLzKel3BgN35sH3EsLAJuu
	 JDvuzeA/PHQc9wun0PxMaYXfHo+oMezUtNLxMyJ9e1MQO5DY49bSHUSl5N7hXacJBBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZzC0BaO9ZgdLKo1L+nkEtyr8dtc0OiwBuBerUSBWik0=;
	b=j2v2Pc/hb0AIVf8o1qrwATQUUL+GkZ4RGKNWbAEYF7Jd/MDogoRN4+9dtKgST3eYLcA7
	 tGuB7K66sBLCPcqXCkOp8svUkuVZ3NecCR+8VoJex3NscrQvEspayieMgpe0OXR+7w9CL
	 TX3iqvolsgpGT92UvBHZO7elO29Kb0AgaUXvKNqH8nlI8+EmS2lKK66SPs+V4tgCHyf1d
	 l5N2PyEeb2f4hHexQM5K+KDLq+cA2i0SLWFoQv18Rcx8CdqM+QyKyCI4cJxvzskOOfcFa
	 FyUiH30AyWA4OFKGMSO1xPFmDL3iRUO8HFT+pwYun4Hf43vm/W7K+UIRM0cuMiXelww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="uj7/FMrk";
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59500606A31F
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59500606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uj7/FMrk
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso544763a91.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 02:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180500; x=1793785300; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZzC0BaO9ZgdLKo1L+nkEtyr8dtc0OiwBuBerUSBWik0=;
        b=uj7/FMrkVVeJFe9dSjJRW81pBtBVvzOXeNUklMG50VZP0Es4awTWyGOUK+/24WHSl4
         umnGC3ZKeqorKLyapdiEZwf9kHg9DMXf6apACqiCZvKzCQYbUQtahnvyKA8evJwMqrH5
         Mi/hGhSGWapDAVeDPEg/97iO1ppjvvCg1fB7z//2qvmtAdA5Z75JGWAQK5E3iVs0Mqqq
         rG2TwnvBFeEMMk+p00l2qhf+kKB62l1H+CnR/hNor+zcDIWZ1hnuT/fhg2PR+lzegYX7
         5G59XDoECXA1O0fUuTGWgFzDI5dycQf8dILORjIngoUPSJDe2uEHBqWiBiht8aRHmlg1
         G3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180500; x=1793785300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZzC0BaO9ZgdLKo1L+nkEtyr8dtc0OiwBuBerUSBWik0=;
        b=ofeUwJec/sD43QPb8ZebMBMUvk0LM8nt/ls74atGUDphIyjl132046MQcwjGj9VAUZ
         hj5S3fMm3+JRKbfsly8JLAti1r3an5mxDKySBNwMI1oY0D9zG8HmAE9sP4wI90QaYx4x
         R7oNtoFOnNDDy1PUIgtN5+zgJUqklKI3XcASLu0nhEXC+K3sQWpWRfGFNTQsFMYe3Msu
         thezZ9Ty8v/2Xd2dlqMWf6vG4HGa3YObma49BNr1SybCBDxQR1X2bdGJZKkTKu8BBPbF
         75ekVFdCNeo2uTQwqT4D1VXtbEhFuAzi1uHgXAX09PLQOCnr0grN/S/wkE80wLH0cGGK
         1j8w==
X-Forwarded-Encrypted: i=1; AKwUvBy/4mmgg3BeBf+dmu+YpjgsI60UsnQ6fnx4V7IRSaUKzlOb8i55zPiL7n19MatD4x825U65iDCX5Cq0FQ3Qnw==@lists.linux.dev
X-Gm-Message-State: AFq9FYI5XnNmfw6lCjLqVpB3ugT9+psKnunPGeyER94R5cvUEuCwb66b
	QBKi7WnmgjIof0SajyzsmwSzDxL2uSY1pqyL2dVo572eO7IPn9qit0JR
X-Gm-Gg: AYBFou3df0JulV1IMcwUhqUoXwPEcAGaha0a9CRAqYRMNH+VN5f7+zjl5hzVW7bqdny
	e0Kd5xTdehSn/ooyrMkVtfbK3SOGkFlUkBdmy30fccfKXUzoMYpjcawS8S4bk+Q4FTbHK8QUefw
	wGGlM3RMH87uFu0cy3vhXi+Z53Hmow/6Vjz5WU/P5oRPGqY2bZPq5Q20No/O4+QJaEBFdm6PiwU
	AVyzu7F52zpcjVnmtc1KVE6KH4OpuHPUvSxCmtN1oJHjIk61N/PN7cEKgr4DNo4Od4ZzRp1e4Cr
	4cboU/07fgy5RBZsGQ1eH0MhixKRQslrdrgiy45utpC+hsLlowG/cld4p82eT0IuqDJaSTrBBZK
	9yrBLUdOXlnd+HGeQPwhdujh2Yne4ggF3SSFUTv19Y1N5rh+TJS6rcMh/8BMPTfU2to+Yje8oqf
	7JG1oZiRqn5LpZvlKigJ5/OboVse4GMHQ/3F3VyTdcw9kJvkASMHHPqkJjmWtjyzN15JgNGT4uW
	m+TicWdozNTcS6cvuN7NndGOYRsygjdq7vLgMeYNk4MhHF5f1qKUnUpo8L7qdWWQ7uf2IhCTcj1
	+NdL5gpA5ALrvlLp1C/uiZxJX+PQPXgXZ10iolyZ1ODtKXpCaqeTk7Wg4RFQxTULAFMx0Q/uEkB
	dgAXLJusr19TJp+3iho81b5YuN89W+Zh3UfQhY2Bd6zD9SLE=
X-Received: by 2002:a17:90b:2641:b0:3ab:f38:2b41 with SMTP id 98e67ed59e1d1-3ae5822f75cmr1311123a91.39.1793180499480;
        Wed, 28 Oct 2026 02:41:39 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a93b3f5sm2242377a91.5.2026.10.28.02.41.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 02:41:38 -0700 (PDT)
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
	linux-doc@vger.kernel.org
Subject: [PATCH v7 00/16] ALSA: virtio: staged capture and dsnoop recovery
Date: Wed, 28 Oct 2026 18:41:16 +0900
Message-ID: <20261028094132.20364-1-mynameisjune111@gmail.com>
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
Content-Transfer-Encoding: 8bit

Hi Takashi,

This revision follows v6 and addresses nine Sashiko findings in the staged
capture and recovery paths. The follow-up diff is relative to the
submitted v6 series, which applies to sound.git for-next at
bcb4494239f57c98a8ef576566b03f2935b3000f. Targeting 7.5 or later still
works for me.

The existing request-lifetime, ACK-accounting, high-priority period-work
and dsnoop changes remain prerequisites. The capture compatibility
options remain opt-in and false by default. This revision adds no
performance tuning to the period worker.

Patches 1-14 preserve the v6 changes and commit messages. Patch 15 adds
the ALSA core paused-stop synchronization change. Patch 16 carries the
virtio-snd review corrections and depends on patch 15. All prerequisites
are included in this series.

Changes since v6

Successful START and PAUSE_RELEASE schedule pending period
notifications. RESET rebases the staged capture counters and callback
snapshot along with the ALSA position.

A per-stream lifecycle mutex serializes prepare, sync_stop, hw_params
and hw_free. The trigger path does not acquire this mutex. RELEASE_SENT
retries wait for pending RX without cancelling the period worker while
holding the PCM lock. Failed resume wakes an active runtime through the
XRUN path even when transfers have already been disabled.

Successful paused ACKs no longer predict a stop from an intermediate
availability value. The ALSA core change marks stop_operating when
snd_pcm_do_stop() leaves PAUSED, so subsequent sync_stop can clean up
outstanding requests. This affects PCM drivers beyond virtio-snd and
needs separate core review. Playback pause/drop/prepare/write and reopen
tests passed with the change.

Reset generations reject stale control completions with -ECANCELED.
Prepare revokes the previous prepared state before its early error
paths, and completed RELEASE revokes device PREPARE permission. Cached
capture tails remain readable in DRAINING and the supported released-
pause state without refilling RX.

Buffer allocation moves from automatic managed allocation into the
driver callbacks. hw_params drains old RX under the lifecycle mutex
before replacing the runtime buffer. hw_free revokes transfer and copy
access and performs synchronous cleanup before releasing the mapping.
Existing request-owned page and bounce-buffer lifetime protection
remains in place.

Validation

The corrected ARM64 kernel was built with KASAN and lockdep. Targeted
tests covered pending period wakeup, RUNNING and PAUSED RESET, paused
forward and wrapped reads, concurrent release/prepare, RELEASE_SENT
retry, failed resume, late control completion across virtio bus
freeze/restore, early prepare failure and non-staged paused XRUN
recovery.

The original RELEASE retry produced a lockdep cycle and timed out. The
corrected test completed and recovered through prepare. RESET and non-
staged recovery tests received 48000 frames after recovery. Native-pause
and pause-restart mode/lifecycle suites each passed 13 cases. A separate
two-vCPU test completed 70 seconds at 16, 44.1, 48 and 96 kHz, followed
by a five-second reopen.

The fault-injection hooks are confined to test builds. The normal
candidate kernel contains none of those hooks. Successful runs checked
loaded module hashes and immutable inputs; the corrected regression runs
reported no KASAN or lockdep errors.

One-vCPU XRUN follow-up

I compared v6 and the corrected kernel with the same kernel
configuration, QEMU binary, rootfs and fixture. The guest had one vCPU,
512 MiB RAM and two CPU busy loops. Four dsnoop clients requested 16,
44.1, 48 and 96 kHz from a 48 kHz mono slave with 960-frame periods and
a 7680-frame buffer (160 ms).

In 70-second TCG runs ordered original/corrected/corrected/original, the
original passed one of two runs and the corrected kernel passed neither.
Errors occurred at alsa-lib's client_threshold check while the hardware
slave remained RUNNING. In one corrected run, two readers completed all
70 seconds after the other two had failed.

With HVF, both kernels passed two 70-second runs and their five-second
reopens under the same guest CPU load. With TCG, lowering only the two
busy loops to nice 19 also let both kernels complete 70 seconds and
reopen. Delaying just the 96 kHz reader by 240 ms under HVF caused that
client to XRUN on both kernels while the other three readers completed
their requested frames.

These controls support delayed client consumption under CPU contention
as the immediate failure mechanism. They do not establish identical
performance. In separate 20-second TCG probe runs, mean period-worker
wall time was 343/359 us for v6 and 391/456 us for the corrected kernel.
The corresponding HVF measurements were about 22.9 and 18.6 us. Both
kernels made about 1000 worker calls per 20 seconds, with no probe
misses.

The probe measures elapsed time including waits and preemption, rather
than exclusive kernel CPU time. Host workloads were left running. TCG
and HVF also use different CPU models, so their absolute timings are not
a regression ratio. The longer TCG worker times remain an observation
requiring further isolation; the hardware-accelerated comparison did not
reproduce that increase. RX completion and period-worker function bodies
are unchanged between the two sources, although structure layout and
control paths differ.

All 20 follow-up runs were collected and checked, including three
ordinary TCG failures and two intentionally delayed-reader failures. No
KASAN or lockdep diagnostics appeared. Overflow checks and buffer sizes
were unchanged.

Scope

These results use synthetic QEMU capture. Physical VZ/MOTU, KCSAN,
32-bit and NOMMU runtime tests were not rerun for this candidate. The
buffer-lifetime changes were exercised on an MMU guest; NOMMU bounce-copy
execution still needs separate coverage. The tests check frame
counts and recovery without a new bit-exact sample-continuity claim.
Virtio bus freeze/restore testing does not cover physical host suspend,
and the core change has not been tested across all PCM drivers.

AI assistance was used to examine the review, prepare corrections and
diagnostic fixtures, analyse the results and draft this text.
The new patches carry Assisted-by attribution.

Previous v6:
https://lore.kernel.org/linux-sound/20261028025317.92450-1-mynameisjune111@gmail.com/
Sashiko review of v6:
https://sashiko.dev/#/patchset/20261028025317.92450-1-mynameisjune111%40gmail.com

Thanks,
Joonho

---
base-commit: bcb4494239f57c98a8ef576566b03f2935b3000f
