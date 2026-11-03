Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664250;
	b=jQe6FzeT1NDmWeDDcbWyFnIOSm96/lrct5AREptNKYIu+4+GBjAWI6Hf4reN/5QBebIL
	 uSeVhvBGfML0LbL/NgZtks6XEgiJj/4it0yoK52rzomVIFyF8IiKsaptdulLLRRbEziu0
	 DAmKIqbEjfCJFoFEeO1FKivNN1O+7j6M5VdBeRG+VWEySXYKd2LxaDrSAZgmAsuRz9m/r
	 HISJsMoIkFzefmINdXwsjVoISTkAzOMdW7x8sujVwI98mNkyA/8C4NP0oBJf8cpj7NPEP
	 F5rZhn+FJw3/ToPP0U0fhn0AaftYdLIxvqp7D8XjgpGDEmexAf4zOoTQWXGOaV2xL8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+xha+Bm67+MTTTxe8zWpGLZyuEH2aPDjA0HzC7mHdv4=;
	b=hMI7I5OoAWVc8Yvqn/jSlnHQwRbOEhM05ioS4WIyajvQRZF1LogLEFjd/Oxozibs6xwo
	 +Xpwggbzi/cuGQHRHvq2TSqxMMofBLSLIxVoAA21T6KZ/i6XN7Z0aMiK6vEruIuK1oodW
	 w3erGUVTSTzMo6uoKY7U2Qm3ORGjE85hbK/VN1n9r3g47U0xI9zfNqWI5eQFJCFkEjYQn
	 0hPxmuaFIX11qmMvBbCP/9ORivokIeeml7BdHROQc+uPp14c90Wiv5vDCw+TQNB/imVGb
	 AaCTIK4uti2tyKXSAENctvkU4vdZa19quCD3XoYetyB6QFkH/7TFgea2LHSdNgfupjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oEhUsMzV;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C431606A32C
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C431606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oEhUsMzV
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso2634821a91.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 16:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793664249; x=1794269049; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+xha+Bm67+MTTTxe8zWpGLZyuEH2aPDjA0HzC7mHdv4=;
        b=oEhUsMzVvZAFp1VsM7i/kNus8wXKy/ySOwWtPdAO87UG8WoFKWrm4VH6YTljfOw7O3
         ozZpMMpgVq4UUfXxKEqE2ab282jztO2qzGiMF7AL8Gm+pVHqkafvChXbVgYdv5ivTuYu
         1KAsYaeyeHCSaMsekKcJjdErX7EfY9whEtbiB1arUr2XXYFfBLqMdHiQSdhRO28AkHj4
         XYrPIFV/LZYwEJVgtYfECGho/l2vQCrWnXxLkLCjMUCgjQsWbk8ML3Mlwjqq+n/FCUIx
         ywqlzrg4xyQFEBR45dT418mggdlmdM3zE27uoGEI3i1HhKt66WCHseanrbzvZJGsBRA/
         aFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664249; x=1794269049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+xha+Bm67+MTTTxe8zWpGLZyuEH2aPDjA0HzC7mHdv4=;
        b=LFHi6AL5tfRpITTK8WB/nfss57IVuctjPT5obT86OKVrU+avwLuljJ7w++OGUXaTjz
         RJBzuytM5u4EJNEj2lA20d2I4vmezcXrVrb/WWrfqmzYfWnqKu4zIO+NYle17BgFIzHG
         xh6zp9KOr30wZ/yTmy7lod35TX+kHzg3XfUmeGIad+NlCsJqhDjMwILVcx0fT+07kvjO
         v2LaU9cICNoJroRSTxSNyhY16Vah/YFyzOJj0ZCnZL0RBSkmvUrF91lYwKmpqFcbZpH9
         bJ52NLFhd5EcxKr4moWJ0wpTtQZvZL6a9NMZlIoxuy9JvoaUBhR2TRP7kC1DRA2R2jtj
         LrbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOLjm6Iy4U4HrNri5AylQXrQZrifIEoCLZ8deoH9Vljwusn2yKkDlllcOIyoAgWXlrrnQ5hMn2gImdK2chWg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+sSNgbqEs38BLKh6AJDmVhIRzgUrLD6PtemT5XNlhc71sppc6k
	h2ci/eCUR1rDPXOtNfBuklSC+hMFZju2VN7ebONQaM7nIExi5GFa7Kj9
X-Gm-Gg: AYBFou2NnG1jN0s/VIIM3Hu1/G5TTdvsVYOZczvwvsKAhmCuAXbJj7DFywF9mnpxak2
	PkAtf2sxHyVDBDq9p48Nk+sv1cj1OVGpFnoHkb0qeeIy1par7YH8np/qjP3aSa10J8WhEdIxDLr
	JGJegm0SsNWoSbPEJVYDR4TVayrYVp+SOfwh6P9IKdszfunef72EQ2S4+NWF+/8F+aSvFvXKjky
	aJZvAd8Qs47YE9ZklHwPMCbDnMDJRy6w7ZS/tb9uaJBGqIlIuSTyCtkSHFKc+RxYefQ5mK1ksv4
	KyIM0dyuJQOJeaKCYT6JYxMStF+75XC/AR04HnSILA5x74Gyi+1xfreF91nSSksehGVHV1OgW4L
	AS0AS96DdED9EeIXYKtO1/xEaafbYqZgQsv/NcCVgp6yEXOWr2C/CzYj8AXDwr0ZNFb6rsRzjsI
	El8NpIO7r6JdaI/D9fB5Sp7/FlgPgzvwbkybWvcWYfPsnsM+U4sYXhHwPIfWotUlYNFXnErnVzJ
	XoXEPJaxZCKRoGyXpBAeQBqepIcyYW2XjSmS4D4SjrS05W7e9HQgRN9iuUg1RB9lmq9XbXVpHud
	rYyidHKCC//6X+io9Mfl2pyz9iLwc+nzT3Fgh9GlW+Ywwec57scbJXua2lxhVf+XqLKAmBd6dYy
	pdTj5gBkrAa8+ObJFBA7K3U2fTKwYbCRC9LgvP3Ys1t0hHNw=
X-Received: by 2002:a17:90b:48c6:b0:3ac:af8b:6f4 with SMTP id 98e67ed59e1d1-3ae898352c3mr9667896a91.37.1793664249367;
        Mon, 02 Nov 2026 16:04:09 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm1339225a91.13.2026.11.02.16.04.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 16:04:08 -0800 (PST)
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
Subject: [PATCH v12 00/12] ALSA: virtio: staged capture recovery and PCM RESET synchronization
Date: Tue,  3 Nov 2026 09:03:51 +0900
Message-ID: <20261103000403.67106-1-mynameisjune111@gmail.com>
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

This revision replaces v11 and carries the unmerged prerequisites.
Apply patches 1-12 to sound.git for-next at
a4311e9447bbb219044db38897f95be112f46a8a.
Targeting 7.5 or later still works for me.

Previous revision:
https://lore.kernel.org/linux-sound/20261031020855.2402-1-mynameisjune111@gmail.com/T/

The series adds staged capture for shared clients such as dsnoop,
lifecycle recovery and synchronized PCM RESET accounting. Capture
compatibility options remain opt-in and disabled by default.

Changes since v11

The ACK path tried buffer_mutex while holding the PCM lock. That mutex
can already be held during normal RESET, refinement and linked prepare.
ACK then returned -EBADFD despite a valid stream. Private accounting can
also change before the indirect helper sees the ACK error.

Patch 10 uses the PCM lock for ACK and prepare accounting, with a
preparing gate lasting until the RESET callback completes. The core
keeps that same lock through its public pointer rebase. Playback RESET
rebases private accounting while preserving queued TX ownership. Both
capture modes synchronize their private pointers with the common reset,
including RESET from PREPARED. Queue-to-substream lock order is retained.

Paused native capture accepts RX completions from the live prepared
epoch even when transfers are disabled. Refill remains gated by transfer
state. Resume preserves the notification floor, so real missed periods
retain their PCM timer ticks and synthetic progress adds none. Device
events and failed STOP latch XRUN and wake readers. ACK rejects invalid
or stopped streams. Failed PREPARE preserves the previous accounting.

Ordinary RX validates status and payload before advancing counters.
Empty STOP responses contribute zero frames. Full-ring XRUN detection
remains enabled: sample checks showed a real overwritten ring after a
220 ms observation delay. A candidate that suppressed the error returned
frame 31680 where frame 24000 was expected. That candidate was discarded.
The final code reports -EPIPE and recovers through prepare. Normal drain
returns the expected 64-frame tail. The full-ring check in v11 remains
valid; the corrected issue is frame accounting for empty STOP responses.

Byte alignment uses gcd(frame_bits, 8), preserving byte-aligned queue
boundaries for packed 4-bit formats. Broader format runtime coverage is
still pending.

Several findings reproduce before v11, including ACK mutex contention
in the earlier lifecycle implementation and playback RESET accounting.
The ACK mutex findings share one synchronization cause. The staged
pause-tail and missed-period failures reproduce in both v10 and v11.
The local comparison retains original, earlier and final results.

Patch layout and dependencies

  1-6: ACK errors, START/RELEASE recovery and request/DMA lifetime.
  7:   Core stop-threshold accesses used by capture policy sampling.
  8:   Partial-progress notification under the PCM stream lock.
  9:   Optional PCM reset operation under the stream lock.
  10:  Staged capture, lifecycle serialization and driver RESET users.
  11:  Staged capture work priority.
  12:  Capture compatibility option documentation.

Patches 1-8 are unchanged from v11. The previous core patch 12 moves to
patch 9 without a code change. Previous driver patches 9, 13 and 14 are
combined in patch 10 with the corrections above. ACK's preparing gate
and its RESET completion must arrive together; separating them would
leave an intermediate driver with no matching completion path.
Previous patches 10 and 11 become patches 11 and 12.

The core API stays separate from its driver users. Drivers without a
reset callback retain the ioctl path. Linked RESET and prepare stop at
the first error and can leave earlier members completed. Applications
must recover the group after partial failure. A zero callback result
allows the core rebase; later I/O can report XRUN. The internal
snd_pcm_ops change requires out-of-tree users to be rebuilt.

Validation

The final source matches the corrected candidate byte for byte across
all 15 touched files. The comparison includes 43 ARM64 QEMU runs, with
56 transition checks across ordinary/staged capture and KASAN/KCSAN,
and four linked prepare/ACK checks. Faults include ACK contention,
failed PREPARE/STOP, paused RX, status-only RX and invalid ACK states.
KASAN, lockdep and KCSAN_STRICT reported no diagnostics in those runs.

Uninstrumented RW and MMAP captures ran for 70 seconds per mode and
capture policy, with pause, RESET and reopen. All 14 segments,
14,208,000 mono S16 frames at 48 kHz, matched independent sequence
hashes. Native-pause tail checks and PCM timer tests compared v11 with
the correction. Core compatibility tests include 72 callback/legacy,
atomic/nonatomic and linked-failure checks, plus snd-dummy playback and
capture. Test hooks are excluded from the submitted source.

Each of the 12 reconstructed intermediate sources is checked by applying
its mail patch to the pinned baseline and comparing the postimage.
ARM64 W=1 Image/modules builds and additional intermediate-stage runtime
checks are recorded in the local submission package. Fifteen additional
VM runs passed, including 28 injected transition checks at patch 10.

These are ARM64 QEMU TCG tests with two vCPUs and 512 MiB. Physical
VZ/MOTU acceptance for this revision and broader format, multichannel
and architecture runtime coverage remain pending. Earlier high-load
TCG XRUN results limit performance conclusions; this revision does not
claim a general CPU or scheduling improvement. The optional core APIs
and linked RESET partial-failure policy still need maintainer review.

Coding assistance was used for analysis, implementation, fixtures and
this explanation. The patches carry Assisted-by: LLM.

Thanks,
Joonho

base-commit: a4311e9447bbb219044db38897f95be112f46a8a
