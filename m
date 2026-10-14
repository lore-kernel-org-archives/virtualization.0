Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC54A206F
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965737; cv=none; b=dexsg2uH9O8CilR89TRu2sGPpHIt9j/4uWhefzlePvUOsTXIAl3cQ7Gy4FuT0F0G2SoMCpJ5NyeP4lgf/CQ0l+OHulrznMsDGnc0J/hvzFMi447f+0maKgZboQ3qiMzsMt3jSlXm1VQQB8cXgI+pNvNFhkPPw3Nn747W063DF6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965737; c=relaxed/simple;
	bh=Jy21Spwkgjb6XMpEYLFn8RZ8houUdP1vTbK7y45kJuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dx8e/44kYKnFPweFuBIREqtqYtVxOUqnvR3788mM6JRqQ4HF/keV6XZde+wzKNu/cJmMTTGHYRm5MkddLIhbJ2W5x45+un//srpV6ui1AHyI7EZzkzs2HROzUyvBFB+mCBkufKm6AINAIT5EGpuMDSRAzN6Kdx6El2r24g14A+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTWeWneT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTWeWneT"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-89a595332c7so2024680b3a.0
        for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 01:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791965732; x=1792570532; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PboKOrqQwewyKEheT1zYUFWFbeqlewnmjUU+OIA0cnM=;
        b=MTWeWneTKWw5yuNyCunFIbXJjb5cPB3trwc2WNgrv+mj7O4vUUVkknYKaINkn4Yrql
         bG+4FI65mZFCqimJAF47c1v/s0iBDD9oK25ZHNwT7sqUIXdH6DWN1bf+9kqSQtq/zR7u
         wGnYgdnIfxncgneMWZJQJFWSNJJIFrp/Z7rqU8nEXFX9NOHEtbJNBrr9jNJEyrQL12Zl
         ZdP6xBXWMG3mZEZ72x8hSSBreH080/ruvb8wlv2u3KJwMvPIfCnZo+h+Ff0XYc1O9lHZ
         yxL848gAZHSsrV6Ix5viN79QxCRzdVU3CPp7S64eCUypMXqDCdxtjLLzkkQL2Ug9QDD5
         XztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791965732; x=1792570532;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PboKOrqQwewyKEheT1zYUFWFbeqlewnmjUU+OIA0cnM=;
        b=nTrK/BVX8d/gbHUq6ElVZuLrCjDlXtHqi822eEu2h1uLs33hgCe3e0b93tDDEABnh1
         XQKl3+Q27FAINbrLm0qN4EXeKkLpBwZnQ+a5q2Gf7mjf5DBuoC1L8dGRQidJSpHsamw0
         7ZW6fgxIK5+tviVapxlGBfXjJQCouBlMDNMRlgFUWZz6aEprFAmPf0y7PJvJgIi9Du77
         T4pe+3rG+w7KVmp31tGVlA9kWb1bthvydZIqk//JtYLIhXlMcQnLcI8P6YBJhiGWZx1H
         MGDrC7YCiF+xTlO7oG0mBh3eHMn5U9FBmm4X1IIW6MdUGO4Mu4+Rr7cCX7CSQpNYYMnM
         aCVQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/+KeOgCuO3qx1HZ7VNURe8y1DOoIxFhdbjeJIyFl1dmb3gplZywlXLCtudjU+SHIKBL9JwayzeQt6Ob3fPA==@lists.linux.dev
X-Gm-Message-State: AFq9FYI6cSvFLkPrkACfJBtFtrQlB/RGNy1GJOcG3MNLuh3awKuOYVYT
	CIGO7nXp+bxtvnvx0w/msnwGl17nxAIWfc9vVaR8VF0jWX/29dXgX2M4
X-Gm-Gg: AYBFou0nqMj0KrQ7TR3oC4Us1aGPDyENCmZCCc9Uj2KJEYw63g/z5AimWFeXRE3qi+X
	BPhD/o5XZYU/19U66daZY/MzrNE++SzfS61/tFwt5sV8P0RSEwyeOxmNwOZSU4ArmUPJB8p8EG0
	f45EP234OQGBrkWiuKYhjD98MlPAHRcM6IFXvkgMs2OqVLurtzzFlDqzDoIIS4liyrcCHt2JZwM
	RJIvFqgrPZ70/jQVMl+96fxSdPk/MtV5FkIVZdkPYlHd5Id5nxvyu3KgWph85ov/BlWHkYst3oO
	/QMKOr0OIytD7ZU4FP6Salqf7zzzFiujkxM1IE4yfvbBR4Af2l6iBWI9cyU01L17XRUyUXFzTZh
	bhrlVy0WjwfuuhJSNp+zfe5UDkgEeW0/Y/YE6Vpz0FqGeQDDxvWtjhT6g6Sc2AF2S9rigfoNg7K
	SO6oGGRas+8DZR8j+FtscK1Fq3V/bl5CqRRub+YkK1sKu5DuEyk3agvhrqoYuNW84V3itkDHuoN
	GZ2lMxvmbljVYQWUC9IVLW4gLPH7sdfwqM6VpoT9jB5yEn0tfiItlKTji03AFQXNcHzcLYs5u6K
	sqpknrrd8FZKCj4=
X-Received: by 2002:a05:6a00:23c8:b0:874:705d:f64d with SMTP id d2e1a72fcca58-897c6443144mr11859234b3a.27.1791965731814;
        Wed, 14 Oct 2026 01:15:31 -0700 (PDT)
Received: from localhost.localdomain ([121.137.86.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d803cf66fsm796426b3a.32.2026.10.14.01.15.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 01:15:30 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/1] ALSA: virtio: wait through signals for PCM teardown
Date: Wed, 14 Oct 2026 17:15:25 +0900
Message-ID: <rfc-v2-generic-control-wait-0.2eddd58a796e497f@gmail.com>
In-Reply-To: <rfc-generic-control-wait-0.112c40f0e9284eaa@gmail.com>
References: <rfc-generic-control-wait-0.112c40f0e9284eaa@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since RFC v1

The implementation patch is unchanged. This revision adds machine-readable
base/prerequisite information and updates the integrated regression results
to use the revised core capture-drain patch. The generic wait and VZ
behavior changes proposed in v1 remain open design questions.

The public base and ordered prerequisite patch IDs appear below. The local
v3 tip d58a3ac9b1719fdf8ce9d286be606128aeebf1aa is reconstructed by applying
the five v3 patches to that public base; it is not an upstream commit.

This is v2 of this follow-up RFC, not v4 of the five-patch virtio-snd
lifetime series. The v3 prerequisite thread is:
https://lore.kernel.org/all/cover.1791881787.git.mynameisjune111@gmail.com/
The submitted v3 fixes ACK error propagation, failed START recovery, and
message/buffer lifetime through completion and reset. It does not add the
VZ capture profile or the ALSA core drain handling in these companion RFCs.

A pending signal can end the STOP or RELEASE wait while the request is
still owned by the device. A later teardown can then submit another RELEASE
before the earlier request completes. Keeping its memory alive, as v3 does,
does not by itself resolve that ordering problem.

This patch makes synchronous STOP and RELEASE waits non-interruptible,
using the existing message timeout. Completion or reset cancellation can
still wake the waiter. Other control requests remain interruptible.

This changes teardown responsiveness for virtio-snd generally, even with
all VZ options disabled: a signal no longer ends these waits immediately.
It does not introduce a new ioctl or wire command. Each wait uses the
configured timeout; this is not a bound on the whole close/exit sequence.
A timeout still leaves device completion uncertain; this patch alone
does not establish safe retry ordering after every timeout.

Dependencies

This patch applies directly to v3, independently of the two ALSA core drain
patches. The companion VZ capture RFC requires this patch and both core
patches. Keeping these reviews separate should allow a decision on teardown
waiting without requiring agreement on the VZ compatibility profile.

Validation and limits

Earlier isolated v3-plus-wait-change STD and VZ builds passed. The earlier
source-extracted comparison passed 108 candidate assertions; v3 has the
expected 14 wait-selection failures, without sanitizer diagnostics. This
models kernel primitives, not real scheduler interleavings or hardware DMA.

The complete local candidate (v3 plus all four RFC patches, including the
revised core locking) was freshly built on 2026-10-14 as an ARM64 Image and
full module set with W=1, KASAN, PROVE_LOCKING, LOCKDEP and
DEBUG_ATOMIC_SLEEP, release 7.3.0-rc6-snd-rfc-cleanup-lockdep.
There were no build errors or warnings in the changed sound paths; 517
-Woverride-init warnings remain in two unchanged ARM64 base files.
This is a rebuild of the pinned candidate, not a rebase to a newer upstream
or sound maintainer tree.

With this kernel, delayed PREPARE/START/STOP/RELEASE responses passed under
ordinary TCG: each targeted command executes once, then its response is
held for 1500 ms against a 1000 ms driver timeout. The reader wakes with
zero frames and final XRUN/-EPIPE; prepare returns -EIO before reprobe and
capture succeeds afterwards. STOP/RELEASE may first return -EIO or -EPIPE,
depending on which ALSA wait/XRUN condition is observed first.

The direct STOP and RELEASE tests hold a request, send SIGKILL, then perform
device unbind/rebind after the process exits. Exit took 1.03s and 1.05s of
guest time. Reset cancels the held descriptor, and no late completion is
observed beyond its original deadline; playback/capture/replay passes.
These runs exercise reset after timeout, not every reset/wait race.

The QEMU 11.1.2 fixture includes backend reset cleanup changes as well as
fault injection. These are integrated candidate results, not standalone
v3 or isolated-patch proof, and not stock-QEMU, VZ or hardware acceptance.
Earlier runs failed follow-on capture with ring saturation and overruns;
those logs remain retained. Final passes do not establish a permanent fix
for load or clock/scheduling sensitivity.

All ten ordinary-TCG regression scenarios passed with the fresh candidate,
as did the additional linked-stream error/recovery fixture and 24 Python
harness tests. Successful runtime logs contained no KASAN, lockdep, WARNING,
BUG, Oops or panic diagnostics. Initial harness/CPU-configuration failures
are retained as invalid attempts, not counted as kernel passes.
No new real-microphone or VZ runtime test was performed for this revision.

Reproducer

The previously published source package remains at this pinned commit:
https://github.com/whatisyourname0/virtio-snd-reproducer/tree/7a9876738bdc70ce669f02ec31fe8968eb0ee4fc/rfc/vz-capture-20261014
It contains the original RFC snapshots, kernel builder, QEMU fixture and
ten runtime commands. It does not contain the revised core locking or the
newly rebuilt linked-stream fixture. Do not treat it as the exact source
of the new results above. Existing v3 patches in it are build prerequisites,
not patches being resubmitted.

The revised source stack, four signed implementation patches, exact kernel
config and portable linked-stream fixture are published at this commit:
https://github.com/whatisyourname0/virtio-snd-reproducer/tree/64fa85f3260b45e7dbb85c4eee68a5b4a8b064e1/rfc/vz-capture-20261014/sashiko-followup
The public source recipe reconstructs all eight changed files byte-for-byte
against the tested candidate. The packaged linked fixture also passed with
freshly compiled probes, a new Alpine rootfs and a rebuilt test module on
the same KASAN/lockdep kernel. The public archive was downloaded and checked
against the local source package. See README.md and RESULTS.txt at that URL.
This supplements the earlier bundle; use its corrected core 2/2 patch
rather than the earlier core 2/2 snapshot.

Questions for review

- Is a bounded, non-interruptible STOP/RELEASE wait the right teardown
  contract, given the effect on process exit latency?
- Would retaining explicit in-flight teardown state across an interrupted
  wait be preferable to changing interruptibility?
- Should timeout/retry serialization be required in this generic change,
  rather than addressed separately by the companion state machine?

Joonho Lee (1):
  ALSA: virtio: wait through signals for PCM teardown

 sound/virtio/virtio_ctl_msg.c | 15 ++++++++++++++-
 sound/virtio/virtio_ctl_msg.h |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

base-commit: 8d70e364e866bdfca81eee24d0688fac9472cfb9
prerequisite-patch-id: 39fb327a004c966ab90f66a34a64bbdbb3ffb475
prerequisite-patch-id: 7c6bc344656fd839ae0d697ba18d66ac0b47827a
prerequisite-patch-id: 9dd290ac3147fa7b49a475d7df8a6172778f2860
prerequisite-patch-id: f4c24a5e441343a690f4ac2437f181c815bc23d0
prerequisite-patch-id: ab4a5b770247a65272ab7af18a75a147daf81287
