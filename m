Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792907829;
	b=lpPR4Q04qciOKpV23cCMbMpV018ke+wMs+ift7o3t0LkOZnRpb3Z/xXJ0CNloIDGlK4j
	 2rh7S0dO8E4+XqCn1/MnAS//lKOb/VV3R+748GfbUvPmYhf82X+owpYPhwD81wGnxuByG
	 hNqwMrgA7pMP6K7ZD9PCm0VfK9QrSXVXh29fX2AR1NDyMs1NnBrUAzZ/rpMB7b6x/qeBD
	 S6DDMPQIXsKHGYFTPd7E3j03lDGkG23aJ8szNNwrgABltb9N20yErnmheyvUCJ8NS4tQD
	 H4cH1XBh7Q/xeDzpDS2AFIK4fV1K13cJp5h8lbedC4xy9ZgChGwLZCcCmjmUFSqybrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792907829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7Zo1T7MMY3VWBGFE9NRsyEeo8UnH0kRDPr4J9VBTFh4=;
	b=OuJdJINjK60bzATpok2SljXu3rAwEDTRRrXF8XJuFpI7arwAoU4cyYBTqsoTiKMnj0+s
	 armJXLzxd380ImQUqRCRt5vQeF9SoU1ro5TGBmUs6rk+BgX8dWGE30vBsSZiK83UFIdfN
	 jA95ZvfO76xOwavLl/rLth6LIT4PhZ5T6/8xAao6k3NO1yXQWfKNUfvcs7P0HqanaPm6A
	 4QhqieKqjzn6K+uoEBdpqNNSf9AEhsja8dtEVFRRfHA0+TA0r/m6vVeQiwJjqzhLB7fiK
	 S7ZniM1E5DFByR2+pofn66EUlm2nrrj3cV/IKO16IJvf6xr4q+Glqkn+PDK4XkTB0aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rnv1C1S0;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F67606A31B
	for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 05:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4F67606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rnv1C1S0
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3514b90bb89so4863414eec.1
        for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 22:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792907828; x=1793512628; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Zo1T7MMY3VWBGFE9NRsyEeo8UnH0kRDPr4J9VBTFh4=;
        b=Rnv1C1S09W3sAdREIpH9nWqUresvZOSVyGfC+qCPPzIzyrXapSajokfLWyMn3JVnJH
         A3Ldw1glIBqi3OhKUO1ppV5s5Hr/14nE+aohq+V1NcxNN8fTNyS48qBdtloTDGwVhO+n
         5eYcVvxjZuftRFSuRl1OXkJW9QyxOIYEs75OiRdFKbGSsNuHr+1jOO+Dl251bk2mDvxT
         PnG0YYOHGjBhFRzuqqMf/zTtqx2O2eOreRek8Iu14bg0gHEFUBbStuo8BVhUoeGnQLI3
         N4Fcel3o2xOm8laKUdX8WaDsnK4fCYxbo3xMb4PCNYTL+rfGANo93nEueDiX9av3nmeF
         aMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792907828; x=1793512628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Zo1T7MMY3VWBGFE9NRsyEeo8UnH0kRDPr4J9VBTFh4=;
        b=qiac3seRFXTuq8GERT2qUQTFuFKPuYPCQFedIBVntMMfbipF6GyxZK/k/x7u3rmguy
         ctvQrR1oyXZt8JsKyM9PtmZOVF8hHLFamMluoQGRMeWJ7seziiE4FeL/J5h1tPt2FsP8
         QvYtncxSLObyHiK1SuvVDW/Lr5qZYOpNp91hZBjzJZ1VDepsP2gk/Nbn6XTO53GkXZi6
         ilAPY8F7PQTI04pDEszficrCPww0Y6pFm6gny2n/XJRrXc+F/aobz91G3w+ZfSc/Arn5
         tgGWrTOKI5NH4sD4t97XAR89VB5+NchTrcaFdEgxGD3+436iWHaGAOPpYR0zK0TFmIco
         8ngg==
X-Forwarded-Encrypted: i=1; AKwUvBxbUyaQCjKyoC3iv9UIcdH7HvT0WcdpAffUF65AIbuGYaZPS1Td/+kc8KngLhMNLomflacgw0Z+cC7Qgp+HAQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLt9lUzELQ/R0dGtH/kQqujEr+XTXI+9yBQLEQlVpOaVgKFcvam
	2C+byxhIh1virVB8qO0Wm8fk1v8PUmvcJ7ELlpX/+dvHhl31gPRBCgkc
X-Gm-Gg: AYBFou07KrDvxLLAdsbBF4lsaZA5MAFfJwIBAchj06KLm/4pstlu4Q79oacmeZ+dGIW
	GWaN/J6UsumOYDr5qFhnufaqlQzofOe2LA5AOq+tlk+HatVnbdAzaFDlWtNh+SvTOKMFYiYsDkS
	yspRBO3m/O21YUEp+cm73t2nG74JNVgQLMOCGZZt4qYF+w/BZqxs69sxsB5mBRgPxNrruVg2WoB
	vmak5l05xuJvMrlknK8OEKN/HbzsSrNj5qz2ubaEQ3UyjfdvLeFg2qmsjpNnQZNcdmo+JiJyvGm
	o9aWmjBrJRWkwvKnz6QOTc36HkQSjdLsXpE9A4rHAiOv6847PefHnBn1D8Z6s72SRkz6lFC7Gz3
	W0f5BV6Q8tQql5GyoZPvVLOPIFHs+R+DvGO7/82bvou33xzrmvhXAgqV7YWwDB+DE0Wbs1ntDCV
	TJ4e1QW1pDIZIZ0IgNnYktLrBjJtOUh3N3f+hUPZGxNjX5YvXD0nMsHtB1cjSV5cmwd+M0K8+HW
	/pz8DkYe9Ao+ZxErIcpnJnQg80ZHyzz02aoo1z21wzVeaIIjmtDQZS6GAWhp6yepdfcLrFBwPzt
	B6NU4aHzgPIRivFbjV/iWKWOLqAL8LtDKo/ekBeaUOTblx56I2OcFDw+1b0PnjU9J1YjL3Yc
X-Received: by 2002:a05:7301:db85:b0:369:d486:457f with SMTP id 5a478bee46e88-369e834e14amr5067746eec.2.1792907827653;
        Sat, 24 Oct 2026 22:57:07 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d9307bsm16046244eec.14.2026.10.24.22.57.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 22:57:07 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] ALSA: virtio-snd: fix dsnoop capture with staged buffers
Date: Sun, 25 Oct 2026 14:57:00 +0900
Message-ID: <20261025055702.69259-1-mynameisjune111@gmail.com>
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

Hi,

Changes in v3:
* Handle staged-capture queue-refill errors during native pause release.
  Mark XRUN and schedule the period worker so ALSA leaves PAUSED and
  wakes capture waiters after the failed pause action.
* Add a native-pause regression covering overflow, poll wakeup, read
  errors, prepare recovery and reopening. Patch 1 is unchanged.
* Preserve the base commit and prerequisite metadata added in v2.

Sashiko found the missing native-pause error path in v2 patch 2:
https://lore.kernel.org/all/sashiko-outbox-184086@kernel.org/

Previous version:
https://lore.kernel.org/all/20261025051301.54640-1-mynameisjune111@gmail.com/

This series fixes dsnoop capture on top of the staged-capture virtio-snd
changes. dsnoop configures its slave with stop_threshold == boundary and
can keep capture running without advancing the slave application pointer as
an ordinary reader would. The staged-capture accounting currently exhausts
its bounded unread capacity in this configuration.

The first patch marks stop_threshold accesses used by the driver's policy
sampling. READ_ONCE/WRITE_ONCE provide single-access annotations; the
virtio-snd state transitions remain protected by the substream lock.

The second patch caches the prepared boundary and samples the stop policy
under that lock. A completion uses one sampled policy for validation,
copying and queue refill. Free-running capture keeps requests queued and
retains the existing frame, payload and pointer-window checks. Returning to
bounded capture restores unread accounting from the monotonic counters. If
the outstanding data already fills the ring, the policy helper returns
-EPIPE without changing the cached mode or counters. The detecting RX,
pointer or ACK path then reports XRUN through its existing error path.
Native pause-release refill failures schedule the period worker to move a
paused stream to XRUN and wake capture waiters.
This does not guarantee a synchronous error from the sw_params ioctl.

The ACK accounting and subsequent queue refill each sample the policy under
the appropriate locks. Prepare and teardown reset the cached state. The
existing ACK-race and priority changes are prerequisites to this series and
are excluded from these two diffs.

New testing for v3:

* ARM64 QEMU with KASAN and lockdep, native pause: v2 returned -EPIPE
  but stayed PAUSED, and a waiting poll timed out. The corrected module
  reached XRUN, woke poll with POLLERR and returned -EPIPE from read.
  Prepare recovery and reopening each captured 48,000 frames. The
  corrected case passed with both one and two vCPUs.
* The 13-case mode suite passed with the corrected module, including
  direct and mmap capture, policy transitions, delayed-reader recovery,
  reopening, mixed-rate dsnoop readers and client departure. KASAN and
  lockdep reported no diagnostics in these runs.

The following testing was performed on v2 before this focused change:

* ARM64 QEMU synthetic dsnoop capture: 12 files and 2,160,000 frames
  matched the reference sequence from each client's observed starting
  position. All 48 corruption, loss, duplication and reordering controls
  were detected.
* Default KCSAN: 13/13 cases and 619 policy transitions passed without
  race or lockdep reports. Forced RX/ACK policy changes and four isolated
  policy-helper branches passed under KASAN and KCSAN.
* macOS VZ with MOTU UltraLite-mk5 at 48 kHz: comparisons used one or two
  vCPUs and idle or CPU-saturated guests. The baseline failed all 32
  shared-client captures. The candidate passed 48 captures and eight
  recovery diagnostics, including mixed-rate sharing, client departure,
  reopening and recovery after an intentionally delayed reader.
  Loaded shared captures ran for 70 seconds. All eight accepted VM runs
  shut down on the first request.

The physical tests checked frame counts and nonzero input. Exact sample
continuity was checked with the QEMU synthetic source. VZ exposed mono;
these tests do not establish physical input-channel routing or multichannel
support. Aggressive KCSAN still produced dsnoop client-threshold XRUNs with
a 160 ms buffer. Further isolation supports a deadline sensitivity, but
does not exclude every kernel timing contribution. Separate generic KCSAN
reports remain recorded in the test evidence.

This series depends on the staged-capture prerequisite stack below. The
tested local base is 8d0d4c1a6c4bcb81ae9f52d1c0d979fafb2e22f2, consisting
of nine prerequisite patches above sound.git commit
5618f6837ef3314e2c581d4c05ec13b7ed975cb4.

Prerequisites, in application order:

1-5. Lifetime and error recovery v3:
https://lore.kernel.org/all/cover.1791881787.git.mynameisjune111@gmail.com/
6. Generic teardown/control wait v2:
https://lore.kernel.org/all/rfc-v2-generic-control-wait-0.2eddd58a796e497f@gmail.com/
7. VZ staged capture v2:
https://lore.kernel.org/all/rfc-v2-vz-capture-compat-1.b9ab4c1540dc4691@gmail.com/
8-9. ACK accounting and high-priority period work:
https://lore.kernel.org/all/rfc-virtio-snd-capture-followups-1.f2737c95c12e45b4@gmail.com/
https://lore.kernel.org/all/rfc-virtio-snd-capture-followups-2.f2737c95c12e45b4@gmail.com/

This fixes the staged-capture accounting introduced by that prerequisite
stack. The reproductions do not establish the same failure in an unmodified
upstream kernel.

The policy uses the existing stop_threshold == boundary convention.
Sampling it under the driver lock avoids introducing a PCM stream lock into
RX completion. A completion overlapping a policy update may finish with the
previous policy; its accounting and refill use that same sample. Rejecting
a transition whose bounded accounting cannot be restored preserves
explicit overflow detection and lets the caller recover the stream.

Patches:
  ALSA: pcm: mark stop-threshold accesses for capture policy sampling
  ALSA: virtio-snd: fix dsnoop capture with staged buffers

Thanks,
Joonho

---
base-commit: 5618f6837ef3314e2c581d4c05ec13b7ed975cb4
prerequisite-patch-id: 39fb327a004c966ab90f66a34a64bbdbb3ffb475
prerequisite-patch-id: 7c6bc344656fd839ae0d697ba18d66ac0b47827a
prerequisite-patch-id: 9dd290ac3147fa7b49a475d7df8a6172778f2860
prerequisite-patch-id: f4c24a5e441343a690f4ac2437f181c815bc23d0
prerequisite-patch-id: ab4a5b770247a65272ab7af18a75a147daf81287
prerequisite-patch-id: cfe3e7000e695a2fda27993f4d9acf0a637cf24e
prerequisite-patch-id: 771e8815f2b874d98376f309dc60bc90244f378c
prerequisite-patch-id: fdea8eaa29a47360e19820e27301dd8b6b26e43e
prerequisite-patch-id: 67ffb5c72970e1aeace72b6537dab1b977a3fc6c
prerequisite-message-id: cover.1791881787.git.mynameisjune111@gmail.com
prerequisite-message-id: rfc-v2-generic-control-wait-0.2eddd58a796e497f@gmail.com
prerequisite-message-id: rfc-v2-vz-capture-compat-1.b9ab4c1540dc4691@gmail.com
prerequisite-message-id: rfc-virtio-snd-capture-followups-0.f2737c95c12e45b4@gmail.com
