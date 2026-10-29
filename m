Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263839;
	b=tcUQm8/rPD7DEPvBGleWxqLTuxjUmxUDPpRApooNl8Y7hhzRaDH3ko7y59dmC6NSODV/
	 JbpWaWQ0ukWKI94plwghlFi0cqOMB9DCnkR/+nRq2HX+r/PmqP+QJ1JeKMRnkJSJk8Jo4
	 s/9SI1ExIQJS2KoFSEKBV7INavdlR6lZuDE/dvT42m/tV94L+u8zyiCXV8GoaDOFZn8mu
	 9rI18PTjZdHIWejFdaOi3jD/UUKQFGMHXMxWuPlI8zoeJzmpzT3Yy/xdUEtNCq3i3uiDz
	 b6klo2jqDMjLVd0MIHVHS5yQj09m6Eu9oPmJKqhFDLPw7z7zS4KpyMCEYzEToEVGGVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rK3sC4K0zeBWZNuCTD+FoSNFp2fytta2s77PkmNPweo=;
	b=MrJ22Ksk9/TIFZuAZx5X6VmaiX4qIfIJYtdC4bFsBleVWwL/2AHRNvmC0F2eDYXOkWCD
	 sTB2ofulc55NKA8dSJ7upR2ZE8GJI3xW8qcziVuY5mc1bQ2dEPkKvi7SsA0/JA0SVzO2K
	 cTn0MOY8cSo7JrIC8YzXEOt3zYM79kop/gc0THmIl4dtLD4YETTskBhJyum/0XwPrYft3
	 XdnHsnlOZGe7NXDqc0PziUPjtv9ZijCny9KCBtd/H6hjaxXTebcfOb2Et5s32T9tGzlzb
	 ZKl7ggbg1Eb9zd7PvmPABQCqVdazp0DYMwRABMZig4dfgZPdEnPjXOonUu3WXyfIsTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BeGn3PxI;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDBE606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FDBE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BeGn3PxI
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso11506405ad.1
        for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793263838; x=1793868638; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rK3sC4K0zeBWZNuCTD+FoSNFp2fytta2s77PkmNPweo=;
        b=BeGn3PxIdvOn5b1Q/Ia6/S61/bm9btbLKS6TFqEUOZifXz0FJVAX56lQbV9yRjqbN8
         jF/+mN6UbdCci1sc1PJ+YtWb6Tiz2qr6Qu7KEzCnl62Yau8W21zffXX69Ed2rDI7cLcS
         KS+1pbI3ReZjQsGk/3s6BMcnE5o+axr3tzL18TptBuxLbd6I9fxwWglQPZBgNPTNVVST
         z/eiELPVOhpfnH3SUgfWHPxNftY/NMUDXvTA2Z+9TuEhCzFIxpYGiCusui4nBwcNcQng
         r2xgNfkdNqKUNOaqikyC4bTWviSrSaQTrZIQMkKp8n+Z89jMBtfCd/ROmW9/Hs6rPlRI
         6RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263838; x=1793868638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rK3sC4K0zeBWZNuCTD+FoSNFp2fytta2s77PkmNPweo=;
        b=LFHF2duHVRkuc8kLlYbnGdlieW9z/jKO70aoL926By1iR8gpt0NgwKkpVAsmJSLu/s
         /VTVcHhEoihTQFg1a781rHujWnMqDs7huzFkZEG6wADuYfsrJcPsz0YlMZmeu2JV0NSy
         7ETJrsR5BYVvJlgd3YWBN/5vSHfOutJZPDCGBa7CTrjfzb+QEgdw34M5JMIGHG0b/odm
         N/Wy3drDKr6TdsYLaz+R0yWtO0lq9ePdT0uD9685N6oaECyM4TKCVL2r0uWIHcKublcI
         PB0uCYnql/FD5g3moEr1shm1Q1+cMuNHBWcAoK0IKYH8pi7ux8y8VeLAGwmDqXC0JdFo
         nojg==
X-Forwarded-Encrypted: i=1; AKwUvBwnlAy3/jnWWUMCeUi+tDyHcVEXGMw66nhqpFVr1fUKSz706J2QP0f4WF9wq+F7gkHNMH531ML+qicPhN1stA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKdYoj2mBpax1zyvwGOmgxjAfI2Th/36wDXLNZdf7NUq6tVzVp/
	QVRtvuAej+CgGYWWgkCg1tAHFg00J6BSNYXQaLK54VwIDo7v0/ypOCspddEGqA==
X-Gm-Gg: AYBFou3M0GOPlHaNdqdYFMnWAj06VYsdaz5+tPKCt+m6GVbPck88Sq1cYUkQg9wvTGW
	nkoJZpr2me5nu8VBd4rWDwLdqXgvzzcwsIVAlIFdEipkKsgc1xx0kJpZykg5c5ccgGLie8cS2kU
	Pz7dKXEXxyWYn6i/tmff+sI4xz/QOvJzkO6RgwdX+qY48W/C/Cd8gmp5r9wf/o1IpgcOADcYZwr
	5ISt+wEaB3yTZswuRNidZKTi7bllSITCD4r4FT6o72CeT85VWWedsCgH/jtQBAwLiISWOPNG3OF
	CP/bprsmy6/4AvNk2AXZo76K73D+COFh6tbxsOls3mSNDhqN+ruuQ8xd0ij5XMaQGVHSlTrTN7F
	2w3/0Xw6H2F2LmoLwCVSAibkt9tdM9G/C/J2uMLuOuyNqIwS5AEB6SWx5jxJcLu6cEU69ufSvX8
	UyO8OMU4lKn0c2uJDDww/eoRSHuurh+9ti53AaouUYpdgt20KeWJOKJmym4ZZGZWANKieTpAiuu
	soSRMoSdNeSfW7vsHz37euwhSwx+BqzAWQpbnIq43RLAUzzoVxBPrB1+NDk39pafb+ZXbBDs2/O
	4ENrO0Qmbh/I4LlxlRcSCBsVM6McRB3wCk5jgc8k36hnPeTFyA64v/MMmx0jE9sh6HWcYa2yl+w
	wNajlmWMUz8IC+5tvHHdVFEDsIZ0UR8ccu4tgeIJ10Q==
X-Received: by 2002:a17:903:1ae4:b0:2eb:162e:37 with SMTP id d9443c01a7336-2eb162e0241mr27242695ad.16.1793263838410;
        Thu, 29 Oct 2026 01:50:38 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm29991205ad.35.2026.10.29.01.50.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 01:50:37 -0700 (PDT)
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
Subject: [PATCH v9 00/14] ALSA: virtio: staged capture recovery and PCM RESET synchronization
Date: Thu, 29 Oct 2026 17:50:18 +0900
Message-ID: <20261029085032.70689-1-mynameisjune111@gmail.com>
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

This revision supersedes v8 and includes its unmerged prerequisites.
It applies directly to sound.git for-next at
 a4311e9447bbb219044db38897f95be112f46a8a.
Please apply it to that base. Targeting 7.5 or later still works for me.

Previous revision:
https://lore.kernel.org/all/20261029054354.2931-1-mynameisjune111@gmail.com/T/

The series adds staged capture accounting for shared capture users such
as dsnoop, with lifecycle recovery and synchronized RESET accounting.
The capture compatibility options remain opt-in and disabled by default.

Changes since v8

I removed the generic PAUSED-to-STOP change. Existing ALSA drivers retain
the upstream STOP condition; virtio-snd now tracks its device running
state and RELEASE obligation independently from runtime readiness.
A successful RELEASE clears that obligation before the RX wait, allowing
a wait timeout to resume cleanup without sending RELEASE twice. A known
STOP rejection can be retried before RELEASE. An uncertain control result
requires device reset before the transition can be trusted again.

The control requests keep their originating PCM epoch through enqueue,
where the queue and PCM locks protect the final generation check. Period
geometry and message ranges are checked before transfer construction.
The aligned control response allocation now appears in patch 5, where
INTEGER64 values first need it.

Patch 8 adds snd_pcm_progress_under_stream_lock() as a separate ALSA core
change. Partial capture progress needs a reader wakeup before a complete
period is available. A delayed notification through the period-interrupt
path can infer a false wrap. The helper uses the ordinary pointer update
and reader/fasync notification without ticking the PCM timer. The caller
holds the stream lock and releases driver pointer and trigger locks.
Synthetic tests in both locking modes reproduced the missing-wakeup and
false-wrap alternatives and passed with the helper. Its API shape still
needs ALSA maintainer review.

The staged RESET path reclaims RX space at the common pointer observation
and updates its notified-period position there. Completions arriving
after that observation remain available. Ordinary capture also completes
the core rebase after a late refill failure, including paused streams.

Layout and dependencies

  1-6: ACK errors, START/RELEASE recovery and request/DMA lifetime.
       Patch 2 tracks RELEASE completion; patch 4 checks period ranges.
  7:   Mark core stop-threshold accesses used by capture policy sampling.
  8:   ALSA partial-progress notification under the stream lock.
  9:   Staged capture, dsnoop policy and lifecycle recovery; uses 1-8.
  10:  Staged capture period-work priority; uses 9.
  11:  Capture compatibility option documentation.
  12:  Optional PCM reset operation under the stream lock.
  13:  Staged capture RESET accounting; uses 9 and 12.
  14:  Ordinary indirect capture RESET accounting; follows 12-13.

The RELEASE completion bookkeeping is included from patch 2 onward.
Whole-byte period geometry and message bounds checks are included from
patch 4 onward, so these fixes also cover partial application.

The previous v8 patch 8 is dropped and replaced by the new helper patch.
The RESET core interface, staged application and ordinary capture fix
remain separate. The ACK and work-priority changes remain separate too.

RESET error policy

The optional callback runs with the member's stream lock held and retains
the common pointer and time handling through snd_pcm_lib_reset(). Zero
allows the core to finish the position and appl_ptr rebase before unlock.
It does not guarantee recovery from XRUN. A negative result skips core
completion, so the callback must leave coherent pointers after any
partial work. Drivers without the callback retain their existing path.
The callback also runs after a successful prepare.

After virtio-snd has performed the common pointer mutation, a late refill
failure latches XRUN and permits core completion. RESET returns zero.
With the notification worker delayed, a nonblocking read can first return
-EAGAIN and later -EPIPE; a paused stream's resume can return -EPIPE.
Applications need prepare or reopen recovery. This changes the observable
late-failure behavior from v8's immediate refill error, which could leave
the rebase incomplete. No new userspace ioctl or structure is introduced.
The internal snd_pcm_ops addition requires out-of-tree modules to rebuild.

Linked RESET and prepare stop on the first error without rollback.
Earlier callback members may already have completed; mixed legacy members
retain their existing post_action policy. An error does not imply the
group is unchanged. Applications must recover the group before relying
on its positions. The callback contract makes this partial failure clear.

Validation and remaining limits

The candidate's runtime code was built as an ARM64 Image and modules with
W=1, KASAN and lockdep. ARM32 LLVM object builds also passed. The final
API-contract refinement only changes comments. Packaging checks apply
every patch in order and compare the result with the validated candidate.

The QEMU regressions cover native and restart lifecycle handling, rejected
STOP and PAUSE, successful RELEASE followed by an RX wait timeout, stale
reset epochs, failed prepare, suspend, delayed replies and virtqueue reset.
The fault matrix passed 14 cases. The linked RESET/prepare fixtures passed
40 cases across atomic and nonatomic locking. Four delayed-worker cases
covered RUNNING/PAUSED and managed/free-running capture, then recovery and
reopen. The partial-progress alternatives were compared in both locking
modes. KASAN and lockdep reported no diagnostics in these targeted runs.

A forced 90 ms interval after the RESET pointer observation reproduced
-EPIPE with the earlier staged accounting. The corrected path matched
48,000 subsequent deterministic frames and passed reopen. Deterministic
ordinary MMAP capture and a 70-second recording also passed. These tests
use synthetic sources; they do not establish physical-device acceptance.

The reordered prerequisites were also boot-tested independently. An
injected RX wait failure after successful RELEASE reproduced two RELEASE
attempts with the earlier patch-2 stage. Each corrected stage from 2
through 8 made one attempt and passed prepare, capture and reopen.
Stages 4 through 8 passed eight direct message-boundary checks. An
additional stage-4 run rejected three malformed hw_params cases before
any SET_PARAMS request, including a fractional-byte period. These nine
QEMU runs passed their expected outcomes with no KASAN or lockdep reports.
Fault hooks are isolated from the submitted patches. The malformed-format
case tests validation logic and does not claim ADPCM hardware support.

High-load TCG capture still fails. In an alternating A-B-B-A comparison
using submitted v8 and this candidate with the same guest configuration,
two vCPUs, two busy loops and four dsnoop clients, both versions failed
both 70-second runs. Reopen passed once in two v8 runs and zero times in
two candidate runs. Observed reader gaps reached 165-283 ms against
160 ms client buffers. All failures remain in the test evidence.

In separate instrumented 20-second runs, both versions failed. All four
candidate errors reached dsnoop's client_threshold check. The v8 run also
reached direct_check, where a later RUNNING snapshot cannot exclude an
earlier slave XRUN. Host scheduling and load varied between runs. This
comparison does not establish performance equivalence or rule out a
performance regression. Buffers, priorities and expected outcomes were
not changed to turn these failures into passes. The work-priority patch
provides no hard real-time guarantee.

This revision has no VZ/MOTU physical-input acceptance yet. ADPCM hardware
negotiation, other MMAP layouts and formats, multichannel capture, ARM32
runtime and all physical ALSA drivers remain outside these tests. The
partial-progress API and linked RESET contract still need maintainer
review. The current revision has not received a Sashiko service review.

Thanks,
Joonho

base-commit: a4311e9447bbb219044db38897f95be112f46a8a
