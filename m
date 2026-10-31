Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412541;
	b=AywQIk3Hhs9fxGgG7+1IzJGLVv/5zwMibe89IRVVtkdR2GNz8R0ppGMnd49ws6Z8loDw
	 T9q3ZXa+LSxkR65IQ7HcDcYmwPP+Rsf/PIIFb28N4tGShZdye4rI9v+hQeBXUcufjTHi3
	 Id5y9KBzUQzbyV4m82bIKGUX1AnWV2SsHYspvFmj+sKMdFao4uOVCWMsXirmJnED3CzGZ
	 7Ysc4HE7pGxv1A6P34LtcS0rfkw/FuYNtv+cnBYgTi+8vg08nIGH7cVIzkhACUjHPUPvj
	 8NSfvfzj/GTYb1cwmDrq50Xi4t5B3Tq2C6xHWNnJCvXBTrrZVkO83wNf2txnN6UU3Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MVIovhDLIigdwTu9NQZWopzkWwc96koBWGrzGbTR9UU=;
	b=BacV7W2oed6JHRQaoub2nqPbypt+LyeWsQgYepaMuefSzVhM8pk7ET7JUt6UoWcTL1od
	 CtXQ91rvFkf+Ps0gDw1Ve/GnSZJVZUhfX9unYocP4v4Jm/hazvVnewQrLvCcSDJ0/zNBz
	 nIZwSfcrx7DlZqmQWd1FTf+YCdu1Q2S/duOuXcdq1BGn7J2sEs8EHvUq3jPAinuldRmii
	 e+LNEppcyJDu6N7XUVPENGlR2xI+8bWu32MLbFRksc1PAvsqM8n521wvcZqEvr7czyt/a
	 tvXukKdYZTjHBE3StJ1zIx575t44xpIICMx35a8N018z1Gz3EgN9dWkdTmta5IPBkJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T1M+R4s5;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EF9606A31A
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22EF9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T1M+R4s5
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a18fc7a38so635742eec.1
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 19:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793412540; x=1794017340; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MVIovhDLIigdwTu9NQZWopzkWwc96koBWGrzGbTR9UU=;
        b=T1M+R4s5OsmdqyQArX1smWqKucgxB5f+oZ7jpI78Xb2HPMUg6K6KSzUln6vRRdGCUY
         YOshsXBMttHZHr3IA3zHgJq16QjFeEKWGHWlBE6u9QxJcHcb9Uf1Ri1y/2dKySfkgr0f
         uVKAGJEPS8NIlGzGE1uIPel/1J7icwCdhtlYyZSjRrKYO5l+jTRbgdPlqWXIiPTAGrrP
         ZLhPc3c4Q+gcRtLIQH92C7OboiPztYcNJPGwLxE+LGi4QAaLUUpk4DnFzUyeSmMdFYWv
         VCZ5Rg9AqpBPADCA0ynVEUDsEBLsyBb4e9y1BTH33oJP69HDvp5LzgRCS+weg4w0N06n
         H0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793412540; x=1794017340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MVIovhDLIigdwTu9NQZWopzkWwc96koBWGrzGbTR9UU=;
        b=gAPYnsWAPBmTcxvuAXcDRGbRPQMZ1CzxDG9TtmwmAAowqza7JPw5Ip6v4X2N27ANEP
         mHfEi92TviZVBLH19zw9gcIQ3C0jVUwiJcEhlQ8cbPtt80ZqsqESclDY6TP/MQiCeFFi
         5XX4g/qfmUwlmT5YwAdwgfpHta66VQqgk3BXPyUNWGtD2lhw6FVGI4Er8+XZ9HOiqula
         E+cILToNjwEDdwwNgzXS2mb1h3STE2wW1lOY/4ckJHGt+AYdQJQQANuJAz64L20VdpbP
         fJQMSgQEFnIFPopNjX4Xzlt2Ei9pUKKUZKuWv4i5b/lDAgIMPsLIylkulekinSIsaaM8
         KfXg==
X-Forwarded-Encrypted: i=1; AKwUvBxx76ldOxy+KIMiQ2P1/KAv9f1RaXW2KqHLpcs++q0q5lBEXAXOqnCF3wbuIdU8BxCf+nv46NDT9GzImX4Ipw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKfJFbyYZMOTrYyoUUTHnk3lVFXsD6mj7r6Rh+f4kBH2rSfyHQh
	qAiyXmu8KeLcMwFCZAfyjjLkmDcrNVoJX4ruylST/nk47Zy1UvaA50Ak
X-Gm-Gg: AYBFou3WkccHR983g2fn1ewtmGY17XdI/pAC2nfnENPxbTjfgLTrD7Dxinfodt0GnLG
	OpOovx9IgLqCr4AAQpWvBJFS9wibP83h4QDbm74JWJAxJ7LaGHz61AJ0+yTZTxchUCzBxMNF612
	zZtiplGSC/hWRmwgpJn/8MKVySAYYxOqImmynrwYa3Zn83L/8sABGjd7AZkX8e+CA+YeLN6Rri4
	wXy+otdH36XNaEDx+Sae3qjSyMfTdvJlcxf/9JMGLYgG/PyvJk7be7N0fPvsWOFbGQ5ucA9l84j
	57FKyveauZiXpXwJagt2sNSEM41qYsJ+x3mQPRbePLlYwYi912LmcuHFMBXT+5MVeEYOJf6K8rM
	Sg8PzaWGJf4VYJ2YudqgUVmoT3ulLteMfS3x/W/Le5Xyy07KGYc8vhWP8gOyciMU4MhBj2J8pLq
	oHA1m9IgL8LdwPu5QiK+KbQF1cv2emVDrpwQcK1Yzx1QfNQb1bINxHDmaT/75LTvFYisE1J81Fk
	71Z1Nnw9Cv6blVmyONNWMkm6EUM4jlY370gCtsrU5r4S0TKk4fr8+55YB8DVEOzi5GEUjtGPAhH
	yR5+gtMf+N5WwuhHSan5HiXAAMbWZntlwVUmVrZdru9J7iqO6nS4bC0JZ9bsdJ6MYPaCHnipQUL
	ZYdqhz6LCW7RHo+r3RAX3D/83IrpcQBLkWcbqWFWiqbYq2w==
X-Received: by 2002:a05:693c:880b:20b0:369:ff7d:840 with SMTP id 5a478bee46e88-36a423e3607mr6346423eec.21.1793412539983;
        Fri, 30 Oct 2026 19:08:59 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm13214096eec.26.2026.10.30.19.08.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 19:08:59 -0700 (PDT)
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
Subject: [PATCH v11 00/14] ALSA: virtio: staged capture recovery and PCM RESET synchronization
Date: Sat, 31 Oct 2026 11:08:41 +0900
Message-ID: <20261031020855.2402-1-mynameisjune111@gmail.com>
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

This revision supersedes v10 and includes the unmerged prerequisites.
Apply patches 1-14 to sound.git for-next at
a4311e9447bbb219044db38897f95be112f46a8a. Targeting 7.5 or later still
works for me.

Previous revision:
https://lore.kernel.org/linux-sound/20261030052629.27742-1-mynameisjune111@gmail.com/T/

The series adds staged capture accounting for shared clients such as
dsnoop, lifecycle recovery, and synchronized PCM RESET accounting. The
capture compatibility options remain opt-in and disabled by default.

Changes since v10

Sashiko raised nine findings in patches 4, 9, 12 and 14. This revision
folds the corrections into the relevant patches and carries the queue
retirement checks from patch 3.

Patch 4 seeds ordinary RX once per prepare. Native STOP leaves requests
and unread samples owned by the current ring, so resume preserves them.
Consumed or discarded space returns through ACK and RESET. This avoids
inflated pending lengths and resubmission of unread DMA slots.

Patch 9 restores notifications after rejected native pause and handles
both success and failure on the already-running START path. Ordinary
capture now honors the XRUN latch in ACK. Its monotonic completion count
also detects a whole unobserved ring and reports XRUN for prepare
recovery. Capture completions preserve the latch from this patch onward.

A first version of the recovery notification exposed an old ring of
samples after paused RESET. Passing every wakeup through period_elapsed
let ALSA infer a wrap without a newly completed period. The worker now
uses the partial-progress helper for synthetic wakeups and retains PCM
timer notifications for actual new periods. The sample comparison and
a periodic PCM timer test both reproduce the candidate regression and
pass with this separation.

Patch 12 removes the second appl_ptr assignment after a callback member
has completed prepare. A linked member's prepare can sleep while the
first member accepts SYNC_PTR. The callback path now preserves that
acknowledgment under its PCM lock. Explicit RESET retains playback
silence handling; prepare leaves filling to the normal START path.

Patch 14 checks the existing XRUN and lifecycle state before mutating
paused indirect accounting. The RX queue and substream locks cover its
pointer observation, temporary accounting and refill. The notification
floor follows the RESET observation. Refill failure retains the existing
zero-return policy while the worker reports XRUN and prepare recovers it.

Patch 3 retires each queue wrapper under the detach lock and checks queue
identity in PCM, control and event callbacks. The proposed detached-ring
IRQ failure was not reproduced on the tested PCI transport: forced
callback tests passed on both versions. This part strengthens teardown
ownership boundaries; the transport reset callback synchronization
contract still applies.

Patch layout

  1-6: ACK errors, START/RELEASE recovery and request/DMA lifetime.
  7:   Core stop-threshold accesses used by capture policy sampling.
  8:   Partial-progress notification under the PCM stream lock.
  9:   Staged capture, shared capture policy and lifecycle recovery.
  10:  Staged capture work priority.
  11:  Capture compatibility option documentation.
  12:  Optional PCM reset operation under the stream lock.
  13:  Staged capture RESET accounting.
  14:  Ordinary capture RESET accounting.

The core API additions remain separate from their driver users. Drivers
without a reset callback retain the ioctl path. Linked RESET and prepare
retain their first-error, partial-completion contract. A zero RESET
return allows the core rebase to finish; later I/O can report -EPIPE and
require prepare or reopen. The internal snd_pcm_ops addition requires
out-of-tree modules using it to be rebuilt.

Validation

The functional candidate passed 23 ARM64 QEMU runs with KASAN and lockdep,
covering error injection, recovery, reopen and compatibility tests.
The core fixtures covered 72 atomic/nonatomic, callback/legacy and linked
failure cases, including playback silence. snd-dummy and virtio-snd each
passed three playback/capture cycles. Additional timer comparisons kept
real period ticks and removed the synthetic resume tick.

For both ordinary and staged capture, an uninstrumented kernel recorded
70 seconds through RW and another 70 seconds through MMAP after
PAUSE, RESET and resume, followed by reopen. All 14 segments,
14,208,000 S16 mono frames at 48 kHz, matched independently generated
SHA-256 values from QEMU sequence metadata. The oracle includes the
intended RESET discard and backend epoch boundaries. The earlier failing
candidate and its sample comparison remain in the local evidence.

The paused interleaving test verifies the new atomic observation
boundary; it does not establish sample loss in the original code.
ARM64 W=1 Image/modules and ARM32 LLVM object builds passed. Test hooks
remain separate from the submitted code. Each mail patch is applied to
the pinned baseline and compared with its expected intermediate source.

Fresh v11 postimages at stages 3-14 built without compiler warnings.
Nine additional stage VMs passed, including eight injected recovery cases
at patch 9, staged native and pause-restart capture, and paused RESET at
patches 13 and 14. All six additional MMAP segments matched the sequence
oracle. Neighboring patches have refreshed contexts where earlier changes
moved their code.

Packaging also adds braces to one existing staged if arm. The new module's
executable, relocation, data and symbol sections match the tested module
byte for byte. The fresh stage tests above use this formatted source.

These results cover QEMU synthetic input. Physical VZ/MOTU acceptance,
an independent KCSAN run and broader format/multichannel and ARM32
runtime testing remain pending. The high-load TCG scheduling results
from earlier revisions still limit performance conclusions. The new
ordinary full-ring check reports -EPIPE where the modulo-only path could
wait indefinitely. The core progress helper and linked RESET contract
still need maintainer review.

Coding assistance was used for analysis, implementation, fixtures and
this explanation. The patches carry Assisted-by: LLM.

Thanks,
Joonho

base-commit: a4311e9447bbb219044db38897f95be112f46a8a
