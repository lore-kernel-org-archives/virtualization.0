Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D6239F187
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877440; cv=none; b=t2T5GENmW+FkryWWI3oZ7qzvL3RvcSmaKOCFsnz3CHMk/f6MzfHMgnL4r2SGXOzEY2Wg8FJp3AE0QHKKe4/gG/8hl/as1hH1eQLmdFb/1Fc8TT3Lw+QG94KkgY2HAoh+a3nElIKI7x25kdxOoEsKVJMXIko3K7KYGY/Lm5TA7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877440; c=relaxed/simple;
	bh=DgZc9TaOzYmHYSvKJq23geFrfrxuctba2uQ61M8yVKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CS8kyt41/EZlustDRQtqG4q0vBgjMbf/uyS5J/zIrcIREWt8sPmfEEn+NesMR0CiFSoPI17lAKmxYQcPmxuioBTLfzJ1gh7uxgshEJCUko1k5ABM6+K1FDKYW7HpcKlerj554Wd1NnOQi6PsOSD0MQXfyP9izCgZoXXca9viyQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEUGJL2J; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEUGJL2J"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3a813079a55so2607541a91.0
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791877437; x=1792482237; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZK1NeHdcHM35sHEDjJ2Bqzc2/PgsQjYGP/lMmIlnTdw=;
        b=bEUGJL2J0meSCZfgfdqN2qau1j6t/Gw74gSoLByhriAJlweZiQIygGZatpMNtOYh4D
         65QOe1DopUfW1qnw7/qG/nWGa1BfcOdNbyhKaKpPTLCFO/PZR0royBg4TrvVLmMjjWL3
         8p7RP/36zY/LTl7fCjRKf70qxNQiZWcQf1Hk5caNySbSKsg46gMswbq0HgokuIUnFxQJ
         kRhIPRe5th844yDavbd9JINioZK+u7agR/99m5vvJKOf4D3COkZ9aLCIFLgcR4GAu/fO
         /jlsUdjKxwosfEbpmXuTfhSzPLDVYfssMHBoJnTXtDF9ySyoxOtUphbEKlaGszSIarYL
         5zGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791877437; x=1792482237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZK1NeHdcHM35sHEDjJ2Bqzc2/PgsQjYGP/lMmIlnTdw=;
        b=Rtxb1mabHLrtoUZTjoqQaWH4B4g5rca5BZo5ivzXtd0L+s0lfqJlN00KVVekOviWcJ
         WXd/h3qzfr08+rFLJWLUhRGXpTtlW3StVtKXBHL8vfVPcw3GjhsEFdZSYylxCd1a2vXi
         5gAmr0lLpCs1q1Lb29g5x7Yuom7rFYvDh6L9a0zTBr+7TDudJ/5d7aUGZf7xxoU14hFa
         9wZye4RCVgDuEbF89rOM8n6H2DPEMGPAIafEyG4Q6+hrAlBf6h0F9NrDFY0iMKg1AY7O
         8BS9pL7tPNQphbVy4fEQ63n2qAlSp2po0+wVUh5M3ZNfQasb/JH2elGXfypz9YtpsTVN
         WWYA==
X-Forwarded-Encrypted: i=1; AKwUvByqqRUgsBXSomxNQTb1jWsIBt3k4HrMG3HCLxkkir85MJYDaFZRQqjXK7/jeFSlY8w5z5ETR/9fzTFenLAlrQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKxMFWAMoVKvg0TJuXkJUVS+c249vxJndk5a50LVRp1UrstB5Rc
	dZT/Xcuo8Z62Ddxq4PE5QZ0klxzS2ZmnQAK26NisEGIbiU/ABqV7tL3a
X-Gm-Gg: AYBFou13JfKstlK7AieAWORDk3c3FZrzOlDoSyrXHBGyCaYXsRODDIID3GyGSv6X8Y0
	X9D7Q8/2fJgKTvoeegt9S++oQw0gZ2M2yatyr2AFg8qtqBg1IHaJYQfPZi2RaoSMWrO98kFQ2Pz
	OAb+txqt8IsYU94Zsgi2tDbtqI/VRrgK3o/qreg77LEcr/bRfYmh3JdJp51hAdCOC2La6hPNtwX
	Z1GPzIuDwajypOwUqWswybuxlJBj1xs+c74swJBcwWFBcw2Nj6HxpE/xXrpMHNP8vss4R9t1/9y
	nNqQutHOXG6GNG4YbiAXYyN5K1oJQ1jxu9tbLVbQfqHwH2TNcDd8AuMZ/vlOMMxGWy3aJCgl5fG
	5QjPNhwqGpdOwPc5+8+OU3cDKG26hL1rqzxDkqEA90Xpky2E4TeFVNbqLLv5jLlpXoRBP37g+Nt
	b+4gVQvIWOeLjUjzvG3cckUEys0LRvWOiXUcVeiidwCp9OvTa9JxUme2k6pcDu4XJoH4DvC3W/V
	H4kIoYZ1OtXyBwXD/si3JPHQ9H5rwWY6M4TOKZhHvTsJA1sg0DCnSnEKg1Bu9U6J+J/LXG1D31O
	+PwacqM6OVLiRWfK
X-Received: by 2002:a17:90b:4b:b0:3a7:96d:feaf with SMTP id 98e67ed59e1d1-3ab3a9a0c59mr6091973a91.16.1791877436619;
        Tue, 13 Oct 2026 00:43:56 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm20552825a91.4.2026.10.13.00.43.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 00:43:56 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Subject: [PATCH v2 0/5] ALSA: virtio: Fix request lifetime and error recovery
Date: Tue, 13 Oct 2026 16:43:45 +0900
Message-ID: <cover.1791877396.git.mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A failed PCM start or a timed-out request can leave virtio-snd messages
owned by the device after the caller returns. Retrying can then reuse
pending messages, and freeing ALSA or control buffers can leave their
addresses in a virtqueue.

This series fixes enqueue-error recovery and keeps the memory referenced
by outstanding requests alive until completion or device reset. Reset
also detaches unused descriptors before deleting the queues, releasing
their DMA mappings and cancelling PCM messages without reporting them
as completed audio.

Changes since v1, following the Sashiko AI review:
- Patch 1 propagates enqueue failures through ACK. Indirect PCM state is
  committed only on success; a failed transfer stops the stream and
  returns -EPIPE rather than allowing an out-of-sync retry.
- Patch 2 is unchanged.
- Patch 3 detaches unused descriptors on all queues after reset and
  balances PCM cancellation and control-message references.
- Patch 4 supports NOMMU with an owned, zeroed buffer instead of rejecting
  an ordinary kmalloc-backed ALSA buffer. Capture copies are bounded and
  disabled once the stream stops.
- Patch 5 separates CPU metadata from DMA storage and aligns each DMA
  region to dma_get_cache_alignment(). Control-send cleanup also uses
  explicit, balanced locking instead of mixing scoped guards and gotos.

Validation of the final source:
- Source-extracted ASan/UBSan regressions on macOS arm64 and Linux arm64,
  including expected failures on the v1 ACK and NOMMU implementations.
- ARM64 W=1 module builds at all five patch steps, plus an ARM32
  CONFIG_MMU=n driver object build of the final source.
- QEMU ARM64 KASAN tests with delayed PCM completion past hw_free,
  delayed PCM_INFO completion after timeout, and reset with pending
  control requests. Each case includes a subsequent recovery operation.

The QEMU tests use a synthetic audio backend; they do not validate a host
microphone. NOMMU coverage is a compile and source-extracted test, not a
booted NOMMU guest. Cache-alignment checks are not a physical
non-coherent DMA hardware test.

Reproducer source and instructions, pinned to the tested revision:
https://github.com/whatisyourname0/virtio-snd-reproducer/tree/ef97b69baea51d952ddd7c329a1894150f41849e

The reproducer currently obtains the same final driver source by applying
the archived v1 patches plus review-v2.diff. Its full kernel/QEMU rebuild
recipe has not been rerun end to end; the reported runtime tests used
rebuilt candidate modules with the existing matching KASAN kernel image.

Based on sound.git for-next commit
8d70e364e866bdfca81eee24d0688fac9472cfb9.

AI assistance was used for code changes, test harnesses, review, and patch
text. The Sashiko findings were checked against the driver and reproduced
where applicable before incorporating the fixes. Assisted-by trailers are
included in the patches.

Previous series Message-ID:
<cover.1791867377.git.mynameisjune111@gmail.com>

Joonho Lee (5):
  ALSA: virtio: Propagate PCM send failures through ACK
  ALSA: virtio: Recover PCM state after a failed start
  ALSA: virtio: Retain queued messages through device reset
  ALSA: virtio: Keep PCM DMA buffers alive through device ownership
  ALSA: virtio: Keep control payloads alive through DMA completion

 sound/virtio/virtio_card.c    |  44 ++++-
 sound/virtio/virtio_card.h    |   2 +
 sound/virtio/virtio_ctl_msg.c | 305 +++++++++++++++++++++++++++-------
 sound/virtio/virtio_ctl_msg.h |  28 +++-
 sound/virtio/virtio_kctl.c    | 104 ++++++------
 sound/virtio/virtio_pcm.h     |  13 ++
 sound/virtio/virtio_pcm_msg.c | 295 +++++++++++++++++++++++++++++---
 sound/virtio/virtio_pcm_ops.c | 147 +++++++++++++---
 8 files changed, 780 insertions(+), 158 deletions(-)


base-commit: 8d70e364e866bdfca81eee24d0688fac9472cfb9
-- 
2.54.0 (Apple Git-157)

