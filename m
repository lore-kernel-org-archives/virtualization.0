Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA212318EF4
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 03:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948644; cv=none; b=MHkdZAjQuxOIJUZEOqME4/n1A+3tdRf1d9kLdyQOgFSKl7OsnExFgreF7ScNbXTWQivn3u21/ZH+NyEDKsFPFTDRk2WMDUB+y+prAm8aj11rPzAm+6a7ErrHIu+JzVCKATkZLPSL6MDRosGr4Ptz3U/U98d87CV85dOWoKXri20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948644; c=relaxed/simple;
	bh=OQUeIiNH3AkOCvu2Yrgwm/MEfZa1fYsH7e7htsI51cA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vudfhr+G/tH/cdXfe0mH7aVx5Ndv1HuVZdWDfJxVk7K5B3iK0T7Q29i2YliTGilGFaUCBqfqbOS8WUHA1yb7ObZKpj9JN/l41V4D3aDkIKfCU3dyVBpwvKddZwl1gsWKpsstBgrsEUMVXfYr44/cZJjm1Gp2EIAwv25tB+0w1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLeWNG7r; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLeWNG7r"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ab8309dcbaso2656954a91.1
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 20:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791948642; x=1792553442; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CoiEcMZfz2BFBf5znP5oWgBmQOMNmu3cqdO1IbIkOOY=;
        b=mLeWNG7rkg/56OQcxHUWTveNsFStadot0qaxiJsVpQt8MimtGYOMZnCulEGaX6B6Q+
         +maZF8Wm11WLowl+dXp+jfipr00H+Ag3rAJF3ofMrWXtflTPw3r3W1/T/dpnd5ood/xj
         xu0bgLsxDzcHWZnkjYvnREwDndll4DokSRvLmFkWXolGHX4DO9mqAn7I2H43aS1ObSYy
         UJq1Yd1a8mYLO5xJ9d7b/jcgU0lOXV3WRg4HjNiQ5wf/ycKGVIJnjJkoGKj5YV9fla5u
         Il8FI6K5YOMwcIQCXq6LHphLtW6HTBPqyx86Ge/YX6zhrJJVF59CgE8u105l9hi/KDPR
         5AYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791948642; x=1792553442;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CoiEcMZfz2BFBf5znP5oWgBmQOMNmu3cqdO1IbIkOOY=;
        b=PvSJSxaFBayXHdae7AHiZB67v3KXduRx6JZuwnUg1EmxCHDqx2YciZ+vzIsP+zkxyF
         73avahMvhhGfpfXvzJr7t4d7je11R8Fdl/00e46KDcFFTpXvNdCH5/DJk4GcBU8SUP/8
         MTVprUKHicie6EZfr89O0XDZPKfTJS7/24EwEaQV4DP/JjJICd0dhPzChCxB4KkIqKT6
         iYnNKCjfxAN69BaM0kEeCwu2U/P6FSvPUOyMvmNFa69Hp5erVi8C9niT9NS2PfpFF1Q8
         uHA3nmYk5JmvFBKdfoxsUOFIXnymhP8JeiQuOIWBlI8U+utQDqi01KOttlnow5WA8JLg
         0jsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjnxuErjKjZkbH0/qLHaePAoeOLPGQLctzFSdiuLjyOwyDtXSsOrPYvtA7rKXFTVaIQ7ZP5LkiyfTfDYPgnQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJYJWcMIA0TYfwn+/7ROKTM43M//sRVLDIl5vHFY0rFgS+7TVZb
	jaOBfK+dxtpfQLXldFC1KwJGS4/ZoZiAgAiFXjBn8g63B2eZidEzsXej
X-Gm-Gg: AYBFou0cq+va/UW85UUJ7Kh6TFIgrVxEswe8fLhJ6VJSE3eN541jvIXR26Lco4/QI8E
	LDnb1ZkYsuN/0V4RihFvwpj4e+ggPeyAvq+FEi/7UTkYglUUFTfjkEIntUaxsoRr8/ShY9F78SS
	1C4gxCoBnZv/9n+mLT0GDoi4md3gRSdebp+oKU+mvG/A5aT+9s22mxFmfASiyqH+syGCXjsq1xV
	3p5HOPQXLxNXgum7OeNkZTJMrWgrc6hCD76rj4HdnP9jlDoCpf3q8H/jV9yrZzUjHNPVjztw8/L
	PEDy/k7uMnE3w0TTcQk37nn56z806ywCkeCyI8ppD2cjN2KpXhyBSMryvlqSFREjgRFLy0Iy8Kb
	Ni49D0wB5sKLSKFWcXyJ9fUwbivTEzb6s3d/fXhtyRExI/6sx06TGy9cVzWh4TvhHn3DxULOS/U
	Np48dsYZtX4YU5efKvip20qSzkLTVYVnK1BvgX5PQFY3YgPUqPCfLyJZu2n2aY7DWVHk9Alb7P9
	oKMU3BnIqtYQvNkog56vLg0RrZk1DI6jK+BLiH8O+0JxaCzF/4qonY8brYP7cwuUjr0G+xnfkhv
	HFK026lU+zCw5gvRyy0ya+nc/74=
X-Received: by 2002:a17:90b:4e8b:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3abbe66dfa9mr5759893a91.32.1791948641919;
        Tue, 13 Oct 2026 20:30:41 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac60064254sm2226483a91.4.2026.10.13.20.30.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 20:30:41 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] ALSA: virtio: wait through signals for PCM teardown
Date: Wed, 14 Oct 2026 12:30:37 +0900
Message-ID: <rfc-generic-control-wait-0.112c40f0e9284eaa@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Base: d58a3ac9b1719fdf8ce9d286be606128aeebf1aa
      ("ALSA: virtio: Keep control payloads alive through DMA completion")
      Local tip of the five submitted v3 patches; not an upstream commit.
Previous series: <cover.1791881787.git.mynameisjune111@gmail.com>
Link: https://lore.kernel.org/all/cover.1791881787.git.mynameisjune111@gmail.com/

This is a follow-up RFC, not a replacement or v4 of that five-patch series.
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

Earlier isolated v3-plus-wait-change STD and VZ builds passed. The current
source-extracted comparison passes 108 candidate assertions; v3 has the
expected 14 wait-selection failures, without sanitizer diagnostics. This
models kernel primitives, not real scheduler interleavings or hardware DMA.

The complete local candidate (v3 plus all four RFC patches) was freshly
built on 2026-10-14 as an ARM64 KASAN Image and installed module set with
W=1, release 7.3.0-rc6-snd-lifetime-kasan. No old kernel objects were reused.
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
device unbind/rebind after the process exits. Exit took 1.04s and 1.02s of
guest time. Reset cancels the held descriptor, and no late completion is
observed beyond its original deadline; playback/capture/replay passes.
These runs exercise reset after timeout, not every reset/wait race.

The QEMU 11.1.2 fixture includes backend reset cleanup changes as well as
fault injection. These are integrated candidate results, not standalone
v3 or isolated-patch proof, and not stock-QEMU, VZ or hardware acceptance.
Earlier runs failed follow-on capture with ring saturation and overruns;
those logs remain retained. Final passes do not establish a permanent fix
for load or clock/scheduling sensitivity.

Reproducer

A source-only bundle contains the pinned base/v3/RFC preparation recipe,
kernel builder, QEMU patch stack, guest probes and all ten runtime commands.
See qemu/README.txt and qemu/VALIDATION-RESULTS.txt in that bundle. The final
runtime set passed under ordinary TCG; no KASAN/BUG/WARNING/oops/panic was
matched. The 24 Python harness tests and relocated source comparison also
passed. Existing v3 patches are included only as build prerequisites, not
for resubmission. Reproducer source (pinned commit):
https://github.com/whatisyourname0/virtio-snd-reproducer/tree/7a9876738bdc70ce669f02ec31fe8968eb0ee4fc/rfc/vz-capture-20261014
The source bundle includes qemu/README.txt with the full build/run recipe,
qemu/VALIDATION-RESULTS.txt and checksums. Downloaded public files were
verified against the tested source package. Bundled RFC mail drafts are
reproduction snapshots; these emails are the submission copies.

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

