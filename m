Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B93E0250
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216825; cv=none; b=IgFFIfebm2prwYFzLx5HvoOFCFjnf70xpe11vmPvjRcMPP8QSgCn0Tcp0hAXfGwnPDVl8XSAh4BKcXQHQ2PoskD5F0J8smaVkm5IWUWGaGSr7Z/0CnkUvhSMk7xNJ0/kF4cwND+kbOVbMGoeW8tdB3KWIEWNIe605z2X2Lh/OVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216825; c=relaxed/simple;
	bh=lq8OWJxtvFNdz454e1SVHMr8naj0Ut+ma6XM69TxQRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8LFwJwKtsulO0VKmoAe9C1ezfSwIQyuyc0hHuMbhW1UL57xKhaiPc+Qkc99cADQ580OI2GlX78lGousfluNX8T64hvYfVCkEmgqn4Ig1wyNEG57dHcQhhJyf7XOz+SR2qhSO50PGvzIn6Hymk8rid29BcoRv7qcpRqNLmGaaaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvKbF0f4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvKbF0f4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d6d28aa26cso1853555ad.2
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 23:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792216824; x=1792821624; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6t3JxNwq87GdMMoHD48Yg+y/3JiCN4qGqQmO7+PdZ3o=;
        b=jvKbF0f45ZRVKasPWveBb1x5q+fy8/eSIMdN03Lg9xta8S3BnLU5XADsF8kwe2mbty
         H6ZWnLYIi2Z5gO5897uZAvY1sKZoPTcuy1wip0aO622SRzmfhst2w370CRAnMmOn4iu6
         R/SoZkT2tqcFkb+Oal3f4f8j0cmNrmqNMDqXdAR+tu3beOHrcT1LudRoMvF6pY8WWB4b
         2ydTCoEsATLPdvj9aKhkagY/ovGyaj9SaMDt/Onk8qFmbzq3Bwar4H6rt+gECXFgE1VH
         8odNKO9Vv1CBMxnucQ6yT2L0i0YQ6nZD5QAyOOahEnVUI/Ltle2O1FD1R+7LCUxpaMWm
         K3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792216824; x=1792821624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6t3JxNwq87GdMMoHD48Yg+y/3JiCN4qGqQmO7+PdZ3o=;
        b=rJbJboRsK/PGv0lrq9GpR4AI7ILwfTqGYW/b6fNOuNj4CsBMgut0yR72K9khcQOVyM
         CTRuqDJGl94dseDFNIcVQz+yjDMjBW/f1oXlzNtbpA/7xmgozjrc62mTLyG8jpIfMsWY
         3QCsj+elJ71zeKyhxn8/cnO1uLc3UJulVB8tNxTnL01B+Gr2Wa1RTBLudQT5zjk9+yfq
         NoZpRnEqZNCWdOSmmyMHOyxNgoJq0ib/kdhFjN0en8udbSwc7HfL71AI2OiL0U9RxMTJ
         8VD27f2dyH2u3fmq+S/knLDmjitu2HgifdNraVqybDNj8EDG8QZM1LhnjXWDaFFACWe0
         7Ksg==
X-Forwarded-Encrypted: i=1; AKwUvBzOAY5jlcAPfj05Fc+FcNvUDLbRl4dcTOyX3nM0Q16/vAE8dDJtJMIu0hNu+EU/oNpjIHc2BIs9tLvQjNvKcA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIqqPgSwfMz0NZEvXcKid/we8bJcU3WZQl9OSxTHGbn8wR0wYb/
	jue8fmDB2zdPloAWA0j5Ve/T1II+OQaueIoGVDdHipV4lFk2MA0QFTqI
X-Gm-Gg: AYBFou1lc9hAOEkYdzVx70fGgh+AllwcFCoqT9bWMdUhm3xpcMFR5LF3KW7n8zxdz9N
	CdlONs3MnPuupLs1sb4zlD5h+S3s93otM9I/EKEEbi6G2Zqrr3SQWJ9zjGLw3hTtFFMMxxFumPF
	r/1dM3yIvrgUD+9mkEXHbXh1zBK6MOVIlrIIkSe+d3y1Oz3w7RBu8tEZd6JcIRNUgOByazAO1ZC
	iu283dDGnCwzk48Jcdud2LHwt7lrF+ly4U7mc/JDnzaxuajELdJ2kTb3sBKWtNbFuTEpPgtRoIu
	MEb4hqhc4IJUMclcvxvEUx+JWuoLUa7yQaGqgg/X0xWqKstjoB6CFnGVyQOTsjKxlECRnc31Mkn
	aCFmv8k2eB6rQcKv2kEk9MkxePr67dpARN0hH4wAIdjz99rD+s5yg52sWDb4xH9XRpjxNwBGOVW
	SB1fuz+/uW5FlNl10PhMQLLy7jg6C2uLYq1xFkZVd074BQofuAC2DVtSSI/1kE3YDQ/9aQzoWiA
	Zns7dgAur7MfxCKH/lhfmovPJPIODvGJREGCstCMI6HXhjaR6lNF++sgcRb/4+5zYtFG/4rnPZR
	47j+cBTcebG/+rk=
X-Received: by 2002:a17:902:f543:b0:2e9:5ec6:bfc9 with SMTP id d9443c01a7336-2e9a69f74b5mr16402635ad.9.1792216823244;
        Fri, 16 Oct 2026 23:00:23 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e835a19sm18834465ad.45.2026.10.16.23.00.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 23:00:22 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] ALSA: virtio: fix staged capture ACK ordering and period scheduling
Date: Sat, 17 Oct 2026 15:00:19 +0900
Message-ID: <rfc-virtio-snd-capture-followups-0.f2737c95c12e45b4@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

These two follow-ups address separate failure paths in the staged
capture support from the VZ RFC v2. Patch 1 fixes ACK accounting under
concurrent RX completion. Patch 2 changes scheduling of staged capture
period work. Keeping them separate lets the accounting fix and
scheduling policy be reviewed and tested independently.

Patch 1 commits consumed bytes under the substream lock before waiting
for the RX queue lock. It then refills with queue -> substream lock
ordering. After consumption has been committed, refill failure latches
XRUN and ACK returns success. Returning an error would roll ALSA
appl_ptr back while the driver's consumption counters remained advanced.
Pre-commit errors still propagate. Ring-capacity checks continue to
reject unread overflow.

Patch 2 routes staged capture period work to system_highpri_wq at all
ten producers, including self-requeue and the ACK error paths. Playback
and non-staged streams retain normal scheduling. Work cancellation and
initialization, buffer sizes, sample accounting and module parameter
defaults remain unchanged. Enabling staged capture changes scheduling;
this patch does not provide real-time guarantees.

Base and prerequisites

The tested base is sound.git 5618f6837ef3314e2c581d4c05ec13b7ed975cb4.
It contains core capture-drain commits 1f21537b1186 and d9f52113f2634.
Those commits supply the core dependency for this series and supersede
the older core RFC v3 dependency named by the VZ RFC v2 cover letter.

Apply these public prerequisites in order, then patches 1 and 2:

1. Five virtio-snd lifetime/error-recovery v3 patches:
   https://lore.kernel.org/all/cover.1791881787.git.mynameisjune111@gmail.com/
2. The generic teardown-wait RFC v2 patch:
   https://lore.kernel.org/all/rfc-v2-generic-control-wait-0.2eddd58a796e497f@gmail.com/
3. The VZ capture RFC v2 patch:
   https://lore.kernel.org/all/rfc-v2-vz-capture-compat-1.b9ab4c1540dc4691@gmail.com/

The seven stable prerequisite patch IDs are listed below. These
follow-ups need the pending staged-capture implementation; its
introducing patch has no upstream commit ID for a Fixes tag yet. The two
changes do not include the separate control tracepoints or input-route
recovery work.

Validation

For patch 1, source-extracted host fixtures under ASan/UBSan reproduce
the baseline ACK race and post-commit pointer rollback. The candidate
preserves wrapped data and accounting, including failed refill. Two
ARM64 QEMU boots exercise the extracted logic with real spinlocks, KASAN
and lockdep. A full-driver baseline/candidate matrix passed 20 lifecycle
scenarios, covering packed tails, delayed PREPARE/START/STOP/RELEASE,
pending RX, reset cancellation and playback/capture recovery.

For patch 2, the unchanged candidate also passed ten full-driver QEMU
scenarios with KASAN and lockdep. The ARM64 build emitted the known 517
-Woverride-init warnings outside sound/, with no sound-source warnings.
The fixtures use test glue and a modified QEMU backend for fault
injection.

The physical comparison used the built-in MacBook Pro microphone through
VZ, a two-vCPU/2048 MiB guest, mono S16_LE at 48 kHz, a 1024-frame
period and a 4096-frame buffer. Six fresh boots compared ACK-only with
ACK plus patch 2, in A/B, B/A, A/B order. Each boot ran quiet capture
for six seconds, then a 70-second target with 16 nice-0 CPU workers,
then a six-second reopen. The reader also used nice 0 in both arms.

  Run  ACK-only received before EPIPE     ACK + patch 2
  1       563520 frames (11.74 seconds)   3360000 frames (70 seconds)
  2      1476752 frames (30.77 seconds)   3360000 frames (70 seconds)
  3      1455840 frames (30.33 seconds)   3360000 frames (70 seconds)

All three failures logged ring_capacity. All candidate captures had zero
read errors and nonzero signal; all six immediate reopens passed.
Routes, worker priorities, worker cleanup and guest shutdown were
checked. Trace loss was zero. The initrd contents differed only in
virtio_snd.ko and its expected-hash file; the kernel and capture
executable were equal.

The first baseline failure included a 108.112 ms period-work dispatch
delay and a 255.821 ms runnable wait for the reader. The other two
failures left pending work without matching execution, so their
matched-only latency maxima understate outstanding work. Candidate
maximum dispatch delays were 13.029, 12.355 and 20.366 ms across the
three runs.

In a separate pair with the reader at nice -10 in both arms, both
versions completed 70 seconds and reopened successfully. Host load was
lower during that control. It is an exploratory result, not an isolated
priority effect. Host load varied throughout the comparisons and tracing
adds overhead. The evidence supports this change for the tested
workload, with contention affecting both kernel work and userspace
scheduling. It does not establish an exclusive kernel-only cause or
lossless capture under arbitrary load.

One initial run failed before valid capture because of a harness
identity check. Another had a result-parser delimiter error; its
original trace was preserved and independently reparsed. Four preflight
attempts refused an unexpected input device before launching a VM. These
are excluded from clean-capture counts. The eight accepted boots contain
24 capture phases: three reproduced baseline failures and 21 completed
captures.

Remaining coverage and review questions

The physical result covers this built-in mono input and this guest
setup. Input switching, sleep/wake, other interfaces, other VMMs and
physical non-coherent DMA remain outside this comparison. Guest poweroff
was used for cleanup; graceful ACPI shutdown was not tested by this
matrix. The fresh regressions described above predate this packaging
step. The committed source matches the tested source byte for byte.

The new fixtures, harness and raw logs are currently local. An immutable
public reproducer snapshot still needs to be prepared before submission.

Is system_highpri_wq appropriate for the opt-in staged capture path, or
would a driver-owned queue be preferable? Is returning success after the
ACK accounting commit, with XRUN latched on refill failure, the right
way to preserve ALSA pointer consistency? I would also appreciate
guidance on whether these follow-ups should be folded into the pending
VZ revision.

Codex (GPT-6 Astra) assisted with test harnesses, trace review and this
text. The work was directed at isolating the ACK race, preserving
accounting on errors, and comparing unchanged baseline/candidate
artifacts under the same explicit guest workload. The patches carry
Assisted-by attribution.

Thanks,
Joonho

Joonho Lee (2):
  ALSA: virtio: account staged capture reads before RX refill
  ALSA: virtio: prioritize staged capture period work

 sound/virtio/virtio_pcm.c     |   4 +-
 sound/virtio/virtio_pcm.h     |  12 ++++
 sound/virtio/virtio_pcm_msg.c |   6 +-
 sound/virtio/virtio_pcm_ops.c | 132 ++++++++++++++++++++--------------
 4 files changed, 96 insertions(+), 58 deletions(-)


base-commit: 5618f6837ef3314e2c581d4c05ec13b7ed975cb4
prerequisite-patch-id: 39fb327a004c966ab90f66a34a64bbdbb3ffb475
prerequisite-patch-id: 7c6bc344656fd839ae0d697ba18d66ac0b47827a
prerequisite-patch-id: 9dd290ac3147fa7b49a475d7df8a6172778f2860
prerequisite-patch-id: f4c24a5e441343a690f4ac2437f181c815bc23d0
prerequisite-patch-id: ab4a5b770247a65272ab7af18a75a147daf81287
prerequisite-patch-id: cfe3e7000e695a2fda27993f4d9acf0a637cf24e
prerequisite-patch-id: 771e8815f2b874d98376f309dc60bc90244f378c
prerequisite-message-id: cover.1791881787.git.mynameisjune111@gmail.com
prerequisite-message-id: rfc-v2-generic-control-wait-0.2eddd58a796e497f@gmail.com
prerequisite-message-id: rfc-v2-vz-capture-compat-0.b9ab4c1540dc4691@gmail.com
