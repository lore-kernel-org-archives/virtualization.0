Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B0937D11F
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 03:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948671; cv=none; b=Xi509uz+PffCeA17Bctzrb3j+1qBHxo40EW5//g0dqXsJWbFFgh5/ruD3L2YO1HdLHsSI2V41Rk4mIHMvccY+n+Z9xlU+QjcQOK7aI7SkDlsz/BpAcmkpKtNFAnPFvY7axtaM3FEdThCJIxie+hprjGaIG5WvC5RPK4Mfe8m3rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948671; c=relaxed/simple;
	bh=GBWVyNCoXhbGW1Io1T1lhwoid7Nmf9FxsF0UlPz0dPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aRHxcMNZPyLtYhP8APfLKyfISh2P7mZ7s6EhjAv5nDNHs6wN5JsA/1h3URApjLcqAa4jnLeGULAbCvzHrlvPz1XD47xE6iKa1VyqyOXXxyCd16Vik36QLc/9X4xhxAywdjhi/MQixbQn38iOEjeQLcAjRVAh6QkC+wpo4n2LZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrIiGlF5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrIiGlF5"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-891d19d00ceso1139955b3a.2
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 20:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791948669; x=1792553469; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UT2c60O2oAsCSVRv4sGt/dkHyKvothdKXrO/hHE7RlQ=;
        b=MrIiGlF5eVR+LoCgH4d9thAWR1Vqi8pB1d6ZP+j8Lr/LGw6MEHXzHmZGyKt5MLV5+E
         eoz+Ddr29DML4n1OqnSiHph2t219TxeqH8hkknGePdlhwDnFZcyWQwypTX+JiZG+AKoE
         ZX8vAevqwiSZpKH2aYwHGpNQBwyzHCyQSzxbILktlc/2f0zQj8tOHq/hU5tqGVL04c+o
         NO3XUIj9tuzRtMBXmTT4E6kFuXOYIzLfe9de8SxKuwCAuZW7EbmeyjibeXClGzaeQyWo
         W1i7GpFgrFNH1sdsnt/NkT2COo4wox3aKh5r576EZO7v2eugX5RaEIscFoCanDWTVZJD
         o1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791948669; x=1792553469;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UT2c60O2oAsCSVRv4sGt/dkHyKvothdKXrO/hHE7RlQ=;
        b=TeoQSTpudrgxAWcPpdZRj/eeBlQOKCxBuMV6Ykn147EytIdBpQ/NLVFgg5MCm80uwk
         vnJR/c/UqNUoQu5l+2j8G0IugZb+6TsEyQZtnKLF0UBhQ1zLcyZYk6qSs0txb2fpXmNg
         SrGjcUqI4jV+JowFURmxUi0z0DgVlBOxK0EFP60P7le6lnm6iKL4xFGTF1I9lOaF2k6e
         gg7ng7EAEkSixP3w6WdNBMWLiTy+lkIqrQyHI6uPJMlyVNbERB52rjST/TlQ3bmz5RIM
         IjZwk4BFlMb2BgZhuPiubCYANZ6ej91j/1BwWpkn6D8BRnhshltYnrCy/aH/wnOerDap
         bnnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZVebOQMI9VwPbIhJkZYaltemPSalMW7XDiPfIioQlyTnqlV/dg7LRxi3SemjvWhaWJCoI1KEItbVayRmP7Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLKEK+TEVnj9YBFGdEk3Th9lfhV9rSkAL6jimD5NsbQMA3C49CZ
	gzo4EA4Ay8PljCJ4q7IRh+cK9hVG1Zspcg2h/qMo9lIYx+OHH340ZtqD
X-Gm-Gg: AYBFou0yBcV04C+wmM81Ot9m4oY0NqctbUEC1nN0pc7rtp9mU1LpHt/MvGmQpJhaO9n
	6jbZHPxe2+6cL2O+4gq+/lr7nYaTljrCvTNqrnZTts5phMqg9JE8W/dXTCEIUvXi1yPre7yGR4Y
	0h7Z2NRO7qrpTKxzEqKKdd8TVrNMRQBNr1PwHbJXlmzb+tRxKVTD5mda2XgqBIkkMjsFvOFCHls
	eeOgdxJBZEsl8XbapUe2JE1mAZhLxDFFBQBn1B67CLfZi5dAPJG4qABzvImi0zpSBhtyxGWZbwO
	RHRErVARWKpvvsvZnt2ws7+5RlgXp/uN2cD1iSt5fXOQcAMGl9om4eGW4rMYxlwhJwoICc92Gg1
	BqRiso7ZBTvq7uB88fPMO1+eEx+1z+n4XhbtgHYtHfHERQOc8RYyC9Rt47y2K0kEJdhCCPRgA4N
	P+b1gsljUtj7kqAF/HMAttHa6m7aPcLV1UC2PztGIMOGXtenKQvMK4NSfEtQWG7KmV6pTU4yBQg
	g/PYOnRVyqOm4vGrcTM5vgUWkddZJLBYYRxcwrLICg4y+VYC+8zVhf5+5So/dUvoebEyHZcl4Mt
	Z4kPHCJZHYZIzLUi
X-Received: by 2002:a05:6a00:807:b0:886:5938:cddb with SMTP id d2e1a72fcca58-897c5d52d33mr11853332b3a.20.1791948668856;
        Tue, 13 Oct 2026 20:31:08 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d804fab99sm539295b3a.46.2026.10.13.20.31.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 20:31:08 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] ALSA: virtio: stage capture for VZ backends
Date: Wed, 14 Oct 2026 12:31:04 +0900
Message-ID: <rfc-vz-capture-compat-0.112c40f0e9284eaa@gmail.com>
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

On the tested Apple Virtualization.framework capture path, short RX
completions and the observed response layout exposed problems with the
existing ring accounting. We also observed capture failing to resume queued
RX after pause release. These observations motivate a compatibility path;
they do not establish that every VZ version behaves this way or settle
whether a backend response violates the virtio-sound specification.

This RFC adds request-owned capture buffers. It validates returned length,
status, frame alignment and ring capacity before copying audio into ALSA,
and accounts copied, consumed and notified data separately. On the normal
MMU path this replaces direct DMA into the ALSA ring when staging is enabled,
at the cost of extra memory and copying. v3 already has a separate NOMMU
bounce-buffer path; staging is not the first owned-buffer path in the driver.

The pause profile uses STOP/RELEASE and re-preparation for subsequent START,
while preserving audio already captured in the ALSA ring. It does not promise
continuous capture during the paused interval. An ambiguous control outcome
fails closed and may require device reprobe rather than an automatic retry.

All five module parameters default off: capture_staging,
capture_packed_status, capture_allow_short, capture_allow_empty and
capture_pause_restart. These are explicit profile controls, not automatic
VZ detection or newly negotiated virtio features. The companion generic wait
and ALSA core changes still apply when this profile is disabled.

Dependencies and scope

Apply after v3 and these three proposed prerequisites:
- ALSA: virtio: wait through signals for PCM teardown
- ALSA: pcm: allow capture reads while draining
- ALSA: pcm: refresh capture pointers before drain

Companion RFC cover Message-IDs reserved for this submission:
- <rfc-generic-control-wait-0.112c40f0e9284eaa@gmail.com>
- <rfc-core-capture-drain-0.112c40f0e9284eaa@gmail.com>
These are pending companion threads, not already published messages.

This combined PCM patch shares ownership, counters and lifecycle state
across staging and pause/restart. Its size is a review concern. A smaller
split needs independently buildable and validated intermediate states.
The patch changes guest behavior; it does not add a microphone device to
stock Docker Desktop or implement host audio routing in its other VMMs.

Validation and limits

The complete local candidate (v3 plus all four RFC patches) was freshly
built on 2026-10-14 as an ARM64 KASAN Image and installed module set with
W=1, release 7.3.0-rc6-snd-lifetime-kasan. No old kernel objects were reused.
There were no build errors or warnings in the changed sound paths; 517
-Woverride-init warnings remain in two unchanged ARM64 base files.
This is a rebuild of the pinned candidate, not a rebase to a newer upstream
or sound maintainer tree.

All ten ordinary-TCG scenarios passed with the same fresh kernel/module
set: three short-tail drain/drop cases, four delayed-control cases, one
pending-RX case, and two direct STOP/RELEASE reset-cancellation cases.
Ambiguous STOP/RELEASE/PREPARE/START timeouts leave the reader at XRUN with
zero frames; prepare is rejected before reprobe, then capture recovers.

In the pending-RX case, STOP and RELEASE are acknowledged; waiting for the
held RX times out after 1017 ms. It completes once after 5.08 guest seconds,
then capture returns 1024 frames without another RELEASE or reset. Running
this case from the relocated final archive also passes (1016 ms / 4.99s).
The direct cases cancel held STOP/RELEASE responses by device unbind/rebind
after SIGKILL and timeout, wait beyond the old response deadline, then pass
playback/capture/replay. This does not cover every reset interleaving or
actual event-virtqueue XRUN delivery.

The QEMU 11.1.2 fixture includes backend reset cleanup changes as well as
fault injection. These are integrated candidate results, not standalone
v3 or isolated-patch proof, and not stock-QEMU, VZ or hardware acceptance.
Earlier runs failed follow-on capture with ring saturation and overruns;
those logs remain retained. Final passes do not establish a permanent fix
for load or clock/scheduling sensitivity.

Historical microphone evidence (not rerun with this new KASAN build):
Our LinuxKit VZ launcher passed AirPods Compose capture at 6s/600s/6s.
The 600s run returned 28,800,000 frames in 600.088s with recorder status 0
and no non-finite samples. After recorder SIGKILL, two captures passed;
after VM stop and fresh boot, 6s/70s/6s passed. SIP stayed enabled, the host
audio service was not restarted, and no microphone PCM was saved.
That earlier Compose virtio_snd.ko SHA-256 was
245db509cb64b596e608d9ed5d86fb30235033d08b4bfcc495026252087e4476.
It is a different binary/configuration from the fresh KASAN runtime set.
The historical guest was 7.3.0-rc6-linuxkit-vz-compose-r3-20261014, with two
vCPUs and --mem 4096. The packaging host reported macOS 26.7 (25G229), but
that build was not recorded in the original run log. The exact historical
launcher binary is not pinned by its public PR link. See vz/README.txt in
the bundle for known inputs and these reproduction limits.

The historical floating-point peak was 1.73. Liveness and finite samples
do not establish acoustic calibration or absence of clipping. Built-in
input, input switching, macOS sleep/wake, guest freeze/restore, physical
non-coherent DMA/NOMMU systems and other Docker Desktop VMMs have not been
validated on this candidate. This remains an experimental RFC.

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

- Which observed response and pause behaviors should be fixed in the host
  backend instead of accepted by a guest compatibility path? What protocol
  traces or conformance cases would help decide this?
- Are module parameters appropriate for this profile, or should activation
  use an identifiable device quirk or a negotiated capability? What stable
  identification would be acceptable rather than a blanket VZ assumption?
- Is release/reprepare an acceptable implementation of capture pause, with
  buffered-tail preservation but no continuity during the pause interval?
- Is request-owned staging acceptable for this scope, and how should the
  patch be split so ownership and lifecycle invariants remain reviewable?
- Which PM, non-VZ backend and capture-format regressions should gate a
  non-RFC submission?

Joonho Lee (1):
  ALSA: virtio: stage VZ capture and restart paused streams

 sound/virtio/virtio_pcm.c     |  93 ++++-
 sound/virtio/virtio_pcm.h     |  68 ++++
 sound/virtio/virtio_pcm_msg.c | 286 ++++++++++++-
 sound/virtio/virtio_pcm_ops.c | 734 +++++++++++++++++++++++++++++++++-
 4 files changed, 1151 insertions(+), 30 deletions(-)

