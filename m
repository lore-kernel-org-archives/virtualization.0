Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C2B3A7F6B
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869437; cv=none; b=IHO/r3aTHplIsok0+jO8OtpMSGl9XrCkAQEFFBAFWuza8EWw/r9HLSezeg2f2Em65OpkB+rLcZakkX/mnMp/39OQ6cT6EcN2ZwHMsQUTcRDeuC2zarWUn+MXz6WHXjfR1WrmEBmn3e/Upgs384INiOIhX+lXQQYpOWyKlsW9ulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869437; c=relaxed/simple;
	bh=GzDlbuaBWl4rniW5HHly+69xtzsakuywhlDzQ6UktUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RtZ0AS99Y+2u96CHJHNW3IwJ+LL/gVmWpvnvk+0WaehPAS4foehiodiTRjsVlX1HQxq9CLn67U+ho8h6ceC1B/9oKhIh3wKSkvAPsypvgpJED/cXl1bO4ZpJK2lSk7GgXEV+NLXAWNNGBm0TVNo2qS+rW501MpMunH4e9AE0cZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr2H0uFK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr2H0uFK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e49fbf92aaso13338455ad.0
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 22:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791869432; x=1792474232; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=anpbORKBihWBT5stduiBRuXZUhWRspB3nfzjm5tKG/I=;
        b=lr2H0uFKZh2gn+wzoQ8mCgkDqFPbUruLuDGAC5nzTRB44beXQH1Jv4iJCmPPtPo1XQ
         VbUFSv/qbSPHfkk3KYGzDAiV8/T6S2tUvaIp7WNdJugQoPqtJ0jEVMnZMLNZJ0exXya9
         DWbsoO2zFzV9xK07yzfwk0ZV4PpndiO6bFvF8W5By7oM6vKkwfNBzr4QholoXwLZeAGY
         oGRwNpi00CmvScbgoGTSoA0aY+afUZPAvmBRSmVkTMnLxETFiNyI+bF1uPcvn//C9Vw5
         sx2Zz5usLjvgkbzFLc+Iwpk+1RJhePfm2HKyerYWRvRVUtFuLkcjx7IAk5gZ1FC/wN34
         DO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791869432; x=1792474232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=anpbORKBihWBT5stduiBRuXZUhWRspB3nfzjm5tKG/I=;
        b=xyOhk1+l3UD/DzUp8Hsdkn2aezUQiCGQrbDapPW7J/wjBf65XbXgWTgaT01tCzwkTn
         Y/YeROByMLCb6T7yBkXXqkLXl/dKND5mwXNz+J3aMXndNVOTn/GyumozDWGqku/OqAI/
         WuuSGsol8lNemxZEMVyLQItR4KDrroL7S/ZwM0snTDMJKV7Hvjxts8vYr66DlCfFudQH
         LMjCrdBM09wxWPrFozzbfvEuGKXN/Uts54ihPWiazbiis7ZTCMD1sS8x0KIKuAIvcPKw
         OqWOFU746O52qlhzbEqGB7uQvZqw3ZQpB029hejrcFzJcvIi1Eslh71Kd3ehdhnHAojS
         Z6wg==
X-Forwarded-Encrypted: i=1; AKwUvByzu6qA9UD1MPqGOoTVrakQD9YbjSOGdBmtRZn6fvTagQ+b8vRKcIfvA6B+kr4kTW6QPSjM3oedwFBb0FuWeA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKLc3YgQYED0QCwFCOte1K3dIDa1oQ8TWVz5swSR6fdyqUkzycf
	bX6BpvMr6pr+rtsc2qEPNpIecGRCad337rnap2cg3r6fI0rmYLHBUsa/
X-Gm-Gg: AYBFou3COQE2o+aA8HuO19BW0sM/0hgNSXgB7sCWYzTXzGcGny9qJXOFrq96ZrXXL17
	7LW5DC60qy+eAIe0oMjgkvmgzIr0olnk4eRicXNv4qBr7qY7VmcIyE1mkWHNK0XA4DjnI6m8saM
	gDCRisZLC3kowGH2AcZ80TJ6g95jWPTCDwhn3MFCqAx3msHBqTEFiPsRZ4nJfSNjFncCJoSa9PM
	hd780zSqUv/3L8i8MeUsx+D3MCFC0Wysp2BEeOtTT6lfCZ5uMgu7v7a53sQOlXpKi1SZEDBaazt
	xoTn21HmL6gLjNZ3PT5tFdqANJUFILvWD8ClRumpCYMhnCRo8iMrN7f5sGQtQAFqU6eAZeQiay9
	oux/VCfYZh3YyYThu5ux0V5UJN2cni5cRKznUlTDBv/brTWqXoxPppZGC+zKSMnkyJD0/yBhkD7
	qcV2wxm/01zMn3yslsos8agCBNr5vfwVDp/56RrVvId1zHhxbbKQ5wRyJHEM1We3cSCgYoYHBd0
	oLLF73RHqhpI8ECcvUHJfiQ2VblAMzSkiLpjAv5EoHRErn184Vuq08fVBKMyZHG5iIF1Xi/XFQ5
	KxRE2+igXW9QQPhY
X-Received: by 2002:a17:903:1b63:b0:2e7:ff72:203f with SMTP id d9443c01a7336-2e842bd0f74mr85666295ad.61.1791869432441;
        Mon, 12 Oct 2026 22:30:32 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cb6sm50820915ad.60.2026.10.12.22.30.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 22:30:31 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Takashi Iwai <tiwai@suse.com>
Cc: Joonho Lee <mynameisjune111@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Subject: [PATCH v1 0/5] ALSA: virtio: Fix request lifetime and error recovery
Date: Tue, 13 Oct 2026 14:30:21 +0900
Message-ID: <cover.1791867377.git.mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A failed PCM start or a timed-out request can leave virtio-snd with
messages still owned by the device. Retrying a stream can then reuse
pending messages, and freeing the ALSA buffer or a control payload can
leave a descriptor pointing at released memory.

This series fixes the enqueue and start error paths, then keeps control
requests and PCM backing pages alive until completion or device reset.
It is based on Takashi Iwai's sound.git for-next branch at the base
commit below. Please apply the five patches in order.

Patches 1 and 2 fix partial enqueue notification and failed-start state.
Patch 3 serializes control notification with teardown and retains queue
references through reset. Patch 4 retains the vmalloc-backed PCM pages
when ALSA releases the buffer mapping after a failed drain. Patch 5 puts
control payloads under the message reference count; it needs patch 3's
reset lifetime handling as well as normal completion handling.

Keeping a message object alive is not sufficient by itself: its payload
must remain alive too. Patches 3 and 5 therefore need to stay together
when evaluating the control-request lifetime fix. An unresponsive device
can retain memory until reset. Patch 4 adds a page-pointer array and page
references per PCM buffer; patch 5 adds owned payload storage and copies.

Validation:
- ARM64 GCC 14.2.0 W=1 builds passed for the final series and the
  intermediate tree through patch 4, with no build warnings in those
  runs. The tree through patch 3 also passed a W=1 driver rebuild.
  Patches 1 and 2 were not separately kernel-built or booted.
- Source-extracted ASan/UBSan tests passed 340 assertions covering partial
  enqueue, failed start, allocation failure, timeout/interruption, late
  access, cleanup and a subsequent operation. These use kernel shims;
  they do not prove real kernel concurrency.
- An ARM64 KASAN guest with a fault-injecting QEMU virtio-sound backend
  reproduced PCM-page and PCM_INFO-payload use-after-free on the tree
  through patch 3. Two runs of each case with the complete series had no
  KASAN or other kernel diagnostics and passed subsequent capture and
  playback checks. A separate drain-timeout/reset/rebind run also passed.

The backend deliberately holds a capture descriptor past RELEASE, or a
PCM_INFO response past the caller's timeout, then accesses the original
scatterlist. A test-only guest observer reads the referenced storage so
KASAN can check it; external DMA alone is not instrumented by KASAN. The
reset test checks that the backend's delayed callback does not run after
reset. It does not independently inspect guest memory after reset.

These are local fault-injection results, using QEMU's none audio backend.
TLV and enum payloads have source-shim coverage only. No physical audio,
Apple VZ or Docker Desktop microphone validation is claimed for this
series. VZ-specific completion compatibility changes are excluded. The
playback ACK callback's inability to propagate enqueue errors is also
outside this series. No new userspace ABI or feature is introduced.

Reproducer source and instructions:
https://github.com/whatisyourname0/virtio-snd-reproducer/tree/8e6ef41bb9c102af4f9d9809bc9fa9bd6243fb02

The source-only package includes the host harnesses, QEMU fault-injection
patch, guest observer and build/run scripts. The 340 host assertions were
rerun on macOS arm64 and Debian Linux aarch64. The portable QEMU validators
passed PCM, PCM_INFO and reset checks using existing build artifacts.
A newly generated initramfs also passed the PCM and recovery checks.
The complete QEMU/kernel source rebuild recipe has not been run end to
end from this package; that boundary is recorded in its README.

AI assistance (Codex, including GPT-6 Luna Max) was used for code analysis,
implementation, test fixtures, validation and patch text. The work was
prompted to isolate generic virtio-snd lifetime and error fixes from
VZ-specific behavior, reproduce the failures, and check recovery. Each
patch carries Assisted-by: LLM.

Joonho Lee (5):
  ALSA: virtio: Notify queued PCM messages after send errors
  ALSA: virtio: Recover PCM state after a failed start
  ALSA: virtio: Retain control requests through device reset
  ALSA: virtio: Retain PCM DMA pages until messages are freed
  ALSA: virtio: Keep control payloads in refcounted messages

 sound/virtio/virtio_card.c    |   6 +-
 sound/virtio/virtio_card.h    |   2 +
 sound/virtio/virtio_ctl_msg.c | 170 ++++++++++++++++++++++++++++------
 sound/virtio/virtio_ctl_msg.h |  20 +++-
 sound/virtio/virtio_kctl.c    | 101 ++++++++++----------
 sound/virtio/virtio_pcm.h     |   5 +
 sound/virtio/virtio_pcm_msg.c | 124 +++++++++++++++++++++++--
 sound/virtio/virtio_pcm_ops.c |  65 +++++++++++--
 8 files changed, 398 insertions(+), 95 deletions(-)


base-commit: 8d70e364e866bdfca81eee24d0688fac9472cfb9
-- 
2.54.0 (Apple Git-157)

