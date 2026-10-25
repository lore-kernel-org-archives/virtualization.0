Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792905187;
	b=i3mDGqdrbZEIbyR7AkXSCMTNLh8L9LbXI7wBkqzyRhBHYwvNY5eV9fYClGQf/HWYPrto
	 PDAYnI+iyNxZjC75DaqMzn2XGHc8OJ2Sb9KIef2ZnzyosYvNGrLv2cLu91S63DYL9zSA1
	 XZD7AcUahrpMx29gUdjN7+Z4lHbufs0yM510nennnqDQ25kkkX/ByilG5uA9y5iuIjeIl
	 /+QP3dBvzvDV7KJ66kCCm8ysTYhtH2eTdsN734r5AyXnhdwUYaApFpL89xZK9ncANVcaP
	 oeceuHXdaROQEGm5AilX1DJanN2oxf35LPpOBA7lcFl71TlRT6blnUDJvLd4TH78HbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792905187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CeUUT3Q4JYEP/r8GnfprbKgPDs256aM4zq4jrxr8WPU=;
	b=QI5+H5hZOP79Mhv4zZNqBWbIO+vHd/4bWJKFtvVCvEPmXi439TOPbb6twBlfAXokx2EK
	 qDc7UD3m7Wv9oLc1/P8lX+5eINLzIV2qvNgQC15wtXJX2kJ0ocqPacrWuIbrWjmh0EFuM
	 hC9d8qfDjo+yWVlbr67sAO8EHIB97vvJbf7fENhre99gwIfR9y4F2ne8cdRWZJIfITujW
	 BPDuqzaBlyca+TNeu8E+QZwa4Z6k3IoWW5ntt41teh2zHMDDunH7n4Yift2CgedSsoA6u
	 W3VpenWQHADviPU0q7D9zWAwaR8EHkipY1Vo30KaQDEM0T0M26NGjdRLJZq/EZH8j1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UFUCYzkb;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FD0606A31B
	for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 05:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26FD0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UFUCYzkb
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35d0be18c71so3542145eec.1
        for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 22:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792905186; x=1793509986; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CeUUT3Q4JYEP/r8GnfprbKgPDs256aM4zq4jrxr8WPU=;
        b=UFUCYzkbJ7dtLgWPudmIqAOmSXT8/Mue+W1sftKiJta4mheoeYH5WVwPuewO9JunkR
         coPJT7aQelrIy+JV2A+ghRi+ZybI759NVQq9pmCGf2BPrvCnG6NJEW9jCeYbZVk/mGHl
         0OKFga7ozhN5vXLu0DiyETQyGwiqkrWvWvyH4wIx+FCK7ydMz5/sho0jJc9ZFdJGwDmS
         lsiLJxeghPIfKH4HrsEU3JvbWqtGPbBbCv+N1zZvueOn1HZvcq9KeGDJU9wuajlQr7nD
         RI7BPYNi/uP+L7Tr2Ctr84/28ZYm6mF2JM4Hgg/dLf/pJ+AYQQfuvd6hDsrmQbIBtNYx
         gqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792905186; x=1793509986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeUUT3Q4JYEP/r8GnfprbKgPDs256aM4zq4jrxr8WPU=;
        b=BMCY52wcZxU0vFVeKRMnkTbOb1QSikvfipPPtP344otw6OtMVq5wg5GYDiZD993J00
         FRTNODe59LOGGyqOLwBbv0psqdu59tqGqhOnt7RP1uhEpSA8GNKvdvqrjuU2zqabQxff
         brs1MxRqU2jl4/H54ASbTDJLk6U5L+z67cgIAjMsYTvUkiBLYrQnK4/2L5yLN4b5h7pG
         V7U8RlhQJhr7Hcqwz2HiFDiW3XZeZ1+OLjq1ZTvIBMtwdZx/8G1P7WWqh9moCYWZViUI
         7gHRhFoQp8VXdt4BdsPWRKxJdJIFxePiK+v2KGHUKFo6HLGiW0izPR/eBk2JEk8+/+UF
         SUVw==
X-Forwarded-Encrypted: i=1; AKwUvBxmhvu6hduHwYNxxqTJOVd4tk5FZ+SbhVHpEpywEbbmN/0Jm0jCSO5GMK3JXyzbEo6elVCl+hlJsc1455rmsA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKuKuoVQLlMk4ZvX6Cy+7lsMYUMmHKAyzsZfiMdLJI9c8zsmvLv
	1Zj5tyvRFlEMSvX5SgvNUy6Dr0dn3Mz3t2SdqRuV2ZXcrPUDU5aKQYGe
X-Gm-Gg: AYBFou31OWHHu/3NjwoHeLcsBv+QvgeP9TwWVeoGqWO8uXVYs2D9Ty2k4cVNBZBCJ88
	HObhXZcU3nsJIc48QYmKfFis1BP7x10ermSXWOgQFgC35VZkMNCMA1w+BxheOQOlrzYI4KnTqOH
	Es7cHaV5pVsgbTI9s8ON8Wp49npTHdl2wKPQzB8n/eCxvRGVDeLVoKP19dnVL96CyNa96Lo5RWh
	v5hdeW5GuC1yBCHJqTQiOAKj/HwJP/s8I9rLUFrpLaNEIPA4b5hastu1d8khTa6F/JFae7jd4jj
	HjEcrFHfAyb+pspqnGQDdrg6h4hrqd0DfPm1Xdai/cFh83LahyPGVOcfmT3z4/WH36Nawljmtx6
	RGXxsYJIYjejSB9mTt0eO/+62XpYSCfnlR39lC+A1+kxvykdsOTipm6AMFb/uf8EEKZLgcypMRi
	aba5R3NPsU5z1jInU77jk+HFnlyLC89QgDFWcNwg1j2c/agVKsY0hwYyUxqBeEpFSe8+K8hKXCk
	z0I6YFJG8grTSSZlnliu7XtQrlwwxj9lv0qCNoODcULVxHHNsMSOMT1ITpAXU38vSXDXdGPcxkv
	w+rAVri3aucHvzvtOxf+2joWytMKXxhH0sJTMeYqGWPiLDuDc0x+OMS0XIocKoiicM1Zdo7cHg=
	=
X-Received: by 2002:a05:701b:4554:10b0:19f:cc98:f603 with SMTP id a92af1059eb24-19fccb77ab4mr88773c88.1.1792905185931;
        Sat, 24 Oct 2026 22:13:05 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaf25sm12588456c88.14.2026.10.24.22.13.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 22:13:05 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ALSA: virtio-snd: fix dsnoop capture with staged buffers
Date: Sun, 25 Oct 2026 14:12:59 +0900
Message-ID: <20261025051301.54640-1-mynameisjune111@gmail.com>
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

Changes in v2:
* Add a machine-readable base commit, nine prerequisite patch IDs and
  four prerequisite thread hints for automated baseline reconstruction.
* Keep both patch bodies, code changes and existing sign-offs unchanged.

The v1 submission was indexed, but Sashiko could not apply patch 2 against
its default baselines. The prerequisite links in v1 were prose only.

Previous version:
https://lore.kernel.org/linux-sound/20261024023232.84448-1-mynameisjune111@gmail.com/

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
This does not guarantee a synchronous error from the sw_params ioctl.

The ACK accounting and subsequent queue refill each sample the policy under
the appropriate locks. Prepare and teardown reset the cached state. The
existing ACK-race and priority changes are prerequisites to this series and
are excluded from these two diffs.

Testing:

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
