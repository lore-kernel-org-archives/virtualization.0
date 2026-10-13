Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C760F3B71D3
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881879; cv=none; b=q4AT9tqcVxQ5gNvvkrXwcXkQVoTEBZ6R7cS+oWyp97DeGOBUjUxf3rvqU/p/ZqBisnkmQtzqirsnfHGgTs9fuVzAz3POCrmK+MnS2JhfhrDgTccrSCRUBlqcWAu+ecFakZ3tBVQYAaBBG2qAQAWmtCeNt8KCkuB+IDsejJ+Uvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881879; c=relaxed/simple;
	bh=lYJGf+muHCD1eVAUKTuW/9iJgLeoqKbg+w62GkKkB7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ES3IN6tdylvFOm5/SVq/tKrIdksLrH1GsuWm5TYKk8xmmV0FJZxchsC1RMGYe8AnSe3WJWgt9yRLeJ3HATrPr/xZBBp2/JlUccMHUZjIkiMZeJjpveCHTui3uPewz6fH7rCj55UzsIpLTyWvqDwx9iVAAtgWE08HixAmm0CImMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZUazX9B; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZUazX9B"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-884062f3296so1706292b3a.0
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791881877; x=1792486677; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XdgLBlwXA+05WisR6qNktOAyZ+0TTRkW7hNmWtduX/s=;
        b=YZUazX9BDmP4YHheplBSF55PayU4t4p9L2sy+s2SPcyIDizrRKn1/4SeoYzyHV+AZQ
         T3kItzINYNCp0bBcGa94d5/cGFZNqlymG7G96e58u2MbN25adf1rXmz9kECnA28kMPbr
         RIkBRK4GlciMRyao+jrjJY92ryZ3J+5BozzLoaZdIwtm0RQLz4vuhy/FTOZhlCpLs1hN
         HfzTuabpdD49Wk9yhrnLoGR3Wg/FnHRc9BM83QVVHitw1C8Qt7bWndtviGS7g0+AUSRQ
         dYctqJoidraI9gbPJbDyj2W/1SjcUtAZqSXb3mtQybYzE82GRNJlLWwtI/pWA4ULBGwb
         keKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881877; x=1792486677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XdgLBlwXA+05WisR6qNktOAyZ+0TTRkW7hNmWtduX/s=;
        b=UwWoKR7DZpuw4lsHOPEItkZADEINNoNOCjAAzdHWC4g/TVhaeHFe9TlAdt3rdq5Khf
         1xaGJknSCcpXtfmnXhV4m6S9WY5nfmZaR4os62vnjYQX/KJ5sH1hWwNbFuG9CCSIyh35
         207vzrFfn/SHsrVGE1g4qXeUZLdvHEA0hf61dUoe0NwnSMR3LzE8+AelRCbI+XNnBMEk
         MonerYQP3A4XGxsCOcJ0YWSb4/WhAKmyshA2tqK3ARstvTpPhzkmRusrSCEcD2VlJLxA
         C9a4t8U4RPL9+eOCVBXcw4HyngENFzkD0kXUjY6QklKXjVH5naIpGtGkdI4Sga66tr11
         wX9Q==
X-Forwarded-Encrypted: i=1; AKwUvBx5CwvyPHFd11mHR4IyEwrjI5Jr5/tYNDXUhZnx+wwyiKF75V3R2HBUFX3HaG4QL0PajXBpjW557Ncd8YfVqQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLBN0TzCttWr8Q6becVEvhGoMajahOpftQ0hyWHtlX6D8v31Ea+
	q8b24bL+YAxSw9FV3xK6zeziB0GSi3fYVEWak9h/NWjRDJo0mByaSYpW
X-Gm-Gg: AYBFou2uqfPv3OR5N0ITmwmPCvAT2Eq4qyNs3Az5No9/zKFun4RvDM5vxpvtpas3uyH
	2uW9Z2+EhXzkf2aZ9cxAPOqmAbVaeqfnKJlV0XHgN7abkpRoNWf0YFU7IAH3MYaAS60qtRQ9GVy
	YzgWAZinUx2ShImUYNTaXrsdeLtbZmvg9sBnTQsYSetEXx3twmZvPtC1NsAAB+omCX5UwF2ATgk
	j6Wp1a/yv3sqJ/unVrMeASL11padUh7RZh8/BVaVMd8Bad5EzTfiqdywJJn3fnj3NgUkr1T/Nn0
	Z+fynIXKJPxXQ85uKRgfXb6UmkKG9hChUlpckMxpUcFmdAXKR7m/A4yxYdgZzHiIR0q7DZOttr4
	aVh37t0DaFG0j4BvbWjCIQEqOsU/EBZdh36xruWSA1s9UxK5DbSX1y+bbMz87Qo0yZkBMzac9Vp
	wdi4DOE2l+4/F1sDTW7hr81y54H1M+b7bd/wmHYf+remQ5EAI7jZMTkfNzBoF1FSWUunocML1JR
	g6OpzqRmW3wV4A9h2AWIsZ6Tl/fmzShAYyuiY6QO9FbaSXsX28C8YygJRsbdwFglJ7HlS89TKVD
	Eph+PnHDS9U/xHVG
X-Received: by 2002:a05:6a21:b98:b0:3de:7dd6:ff8f with SMTP id adf61e73a8af0-3e16be94558mr8871796637.50.1791881876834;
        Tue, 13 Oct 2026 01:57:56 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6063d31dcsm1838592a12.3.2026.10.13.01.57.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 01:57:56 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>
Subject: [PATCH v3 0/5] ALSA: virtio: Fix request lifetime and error recovery
Date: Tue, 13 Oct 2026 17:57:47 +0900
Message-ID: <cover.1791881787.git.mynameisjune111@gmail.com>
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

Changes since v2, following the Sashiko AI review:
- Patch 2 protects all stopped-state accesses with vss->lock, including
  hw_params, prepare, open, STOP and sync_stop completion. The RELEASE
  decision and stopped=true transition now share a critical section.
  Sleeping operations remain outside the spinlock.
- Patch 5 aligns every DMA region for both cache maintenance and typed
  CPU accesses, and removes the initial +1 offset. This handles coherent
  systems where dma_get_cache_alignment() returns 1, as well as odd
  region lengths that could otherwise misalign later payloads.
- Patches 1, 3 and 4 are unchanged.

Validation of the final v3 source:
- ARM64 W=1 module build and ARM32 CONFIG_MMU=n driver object build.
- Source-extracted ASan/UBSan PCM, control, reset, ACK and DMA lifetime
  regressions on macOS arm64. The v2 control allocator produces UBSan
  misalignment diagnostics; the v3 allocator passes typed header and
  request/response integer64 accesses with DMA alignments 1, 2, 4, 8,
  32, 64 and 128.
- Deterministic stopped-state lock instrumentation catches unlocked v2
  accesses and passes 73 lifecycle assertions for v3. It covers ACK
  failure, RELEASE failure/retry and ACK during RELEASE, and checks that
  blocking operations do not run with the spinlock held.

The stopped-state test instruments extracted source; it is not KCSAN or
an actual threaded kernel race test. NOMMU was compiled, not booted.
Physical non-coherent DMA hardware and host microphone behavior were
not tested by these regressions. The QEMU ARM64 KASAN fault/recovery runs
reported in v2 have not been rerun for these v3 changes.

Reproducer source and instructions:
https://github.com/whatisyourname0/virtio-snd-reproducer/tree/3ee5c7c1e864dae50a127b0a25cd122532daa6de

Based on sound.git for-next commit
8d70e364e866bdfca81eee24d0688fac9472cfb9.

AI assistance was used for code changes, tests, review and patch text.
Assisted-by trailers are included. Sashiko's findings were checked against
the driver and covered by regressions before incorporating the fixes.

Previous series Message-ID:
<cover.1791877396.git.mynameisjune111@gmail.com>

Joonho Lee (5):
  ALSA: virtio: Propagate PCM send failures through ACK
  ALSA: virtio: Recover PCM state after a failed start
  ALSA: virtio: Retain queued messages through device reset
  ALSA: virtio: Keep PCM DMA buffers alive through device ownership
  ALSA: virtio: Keep control payloads alive through DMA completion

 sound/virtio/virtio_card.c    |  44 ++++-
 sound/virtio/virtio_card.h    |   2 +
 sound/virtio/virtio_ctl_msg.c | 307 +++++++++++++++++++++++++++-------
 sound/virtio/virtio_ctl_msg.h |  28 +++-
 sound/virtio/virtio_kctl.c    | 104 ++++++------
 sound/virtio/virtio_pcm.h     |  17 +-
 sound/virtio/virtio_pcm_msg.c | 295 +++++++++++++++++++++++++++++---
 sound/virtio/virtio_pcm_ops.c | 165 +++++++++++++++---
 8 files changed, 798 insertions(+), 164 deletions(-)


base-commit: 8d70e364e866bdfca81eee24d0688fac9472cfb9
-- 
2.54.0 (Apple Git-157)

