Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792809158;
	b=QmdhWWlmuYXkQAYHsSAUBRYi6WUvWJrnCKLI60qjf28nme3lUrsnHaN4b/PSe0qhN9Ep
	 4JtPQmrfCdUOAHgx0V4UpS8s6U70SznbzpU/Cf0lOVmEayz4khpm0Ze0tiF7fr+QOvCP0
	 Mk7Xa5YUqdn3qDlZIKD2/VU0F4AjbQ1bIZU0hB+jnCxM0+EjkbNfq/vF3GkH4Kx8NUsSp
	 O7ZOJNfI2mk3ozCOmE6KQKliqz6gFM72zb9D8llUFw1M5S9SR5MLEMWFpYTn6IlaOl9fB
	 AXhRa3ISga7YUpnlXEO+4TtScOabKEpUPsmFgFDknJ7lVtRLUUWF+iWGaupyGd+XvMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=51kv8COGqzMvJBRd7xyPk05iBH4eNFHrYUZxKFt+cc8=;
	b=L/54YP+5LPXXySlX0hgAEwzVlqQ7Ens+I0r665qm351uFvV3vZjx2GmWjpiTF3WYaTFY
	 Jc5isq63JEzlT97f8FO4zyGLdQ2xBp/+l0pAsaovpJ5cdBrIAOhLQpUefhuNXsMhW02UD
	 iPvG2ryms0djICgUcdDT2IWu2jTOiOrzX1F141ekcNZwFwggAjSA50doBw2XMCXqTQChW
	 WVa7iujwCUsTTGZTKm5/4C43kSu82gqFCOFcRDvMspEg2TlHj/7yr9VdjZf2W8lmHUKLr
	 HefGreqvg7NhzEoWaojTaj508FLALFW45IMOMYs3mMzHBOw3LxfKJRO9DZ6qnFIlg6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BOHQegLw;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B4A606A31B
	for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 02:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3B4A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BOHQegLw
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35b2c599f43so3359210eec.0
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792809157; x=1793413957; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=51kv8COGqzMvJBRd7xyPk05iBH4eNFHrYUZxKFt+cc8=;
        b=BOHQegLw0Y8AFAbyGDz24mdYbB6/f+r11DMmR8AFDhAaxqnZmXAL2UKTyJEgwxdmQv
         mVbLppk/t18eN8rFzG7cmoTSdWw3gtCyaq4ot9BwZiZC5X5JwqozpLT0pV9nqmnWa/a6
         h6KMC9ZkxvguoowUZlozinDV+UH3a7P1/qZL4lEL4uMjErO9Vq8p+HTV+zWgo/U7upU1
         fUwx4qPzQUNQlvLZ5oh/KzGwKKpVW8ft1aJEzf6z1pfDLHkdDeC1dBeN4zr7Mg9yiL+I
         9hltOfj7bGLN3wJvOc1fcNyVDiRQmCWpybXJR/UUrzQwn32RtsUMJFLQpo7115RrFZj4
         yNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792809157; x=1793413957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=51kv8COGqzMvJBRd7xyPk05iBH4eNFHrYUZxKFt+cc8=;
        b=OVyqfu2GoQkp4u3eAciRzGYgyNAUvlg0U98j9MUb8sOYRWpl9xK0p9g6bkROjt3fpB
         4BTEc2iIBUTOVdwU0pc+ufuiM9vblPw1oYP80Fg/D95gyokMF43PaXCFUyMtRZOV25l/
         3vx8awr68LIWIKIBwvjQSIdiB3K0h6bgjX5LRQ2jim6pRzyPLONiTToxVoxyVk+peJEW
         m+BEUVsmkY8Ow4JNoKWHMRtrJkD6TNCugKzZgDGYdGGzVs41k3rTrGYgO3hDUAisbqjj
         KnlgaC0b3z0BjOBgs4/dXaA6LMQqVMSVJgHW7R2H36BUas33UVxvWaiWNv1ePm2V+wMn
         IFoA==
X-Forwarded-Encrypted: i=1; AKwUvBwu0ztCfd8GfnqPPw3aCtdqo+qbIBNbO17thVaycsYsq3waR27FiI4WU5woUNFcBnxqaqQYyp+CUtvOthtzXQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYK/ruoE2XLqZZJ0Jdq70P43PruBfHaW4BSMwDqqDGdr6uQQjmJ8
	YaMVu1GRLPlsp5ToaOZ4gE5dh056nUT1gOzxVpIrtofdXDS9dH/xH8c/
X-Gm-Gg: AYBFou1RdWYzn3laPYog32foMS4l96RUEmaAoORPK5bcIuWcFEWq2LSEa/2kggF07Dp
	WxzE9aRnQCOnnLmRCJg8+nSr2UECY+I0cXN1Ft2e4569N50bn4Qq7XR+9W2R8WSYBLO83dXU+nA
	GHvujC1GYhtb6LN5x4DHWGyGvIZHHS6DoHuuyRSiHf4W9wX29SRySGn6pYvcmLS2INZEESd0HkR
	Xa8rqDAI0Obdz9tsBiJQWpGPmyDymebhy1scHLiZFlXyBtjAeVSFDeffwtn5i0yLT/7FAfvZwXV
	B/0FLHwd2Yqq6pxsjr2q4b59pT1EEhUuMmxPKNva22r7sH2iDY17wUs6+K5MG3ejUMskYMfTQ/D
	tYmz6pViTZA368CHRGA5GgMy5TfsQxHne82Lyl9NMmozhaoBrQOMy2rcmWH5/pzWVkmEwv73ca3
	r8c+q9ZPEExm53XP9LdfD20fogakeJbWsAz/ssLagZwVcu5DI0MQK5kj9QEsgaRN8j7P51wUKwJ
	uZD/VFnCuYzoqvpxNzb20ohSzCjvlkg7iMcsDFacCfzxrnLz9KcdDiRw9dsPDN8gUnO8sbFVcne
	Xa3apeoNb55ZkBa1CPQKt58ScVXU71wcTlt9U+6tbgoklRopmeLPfhokIglL/1y/hfl2gxYA
X-Received: by 2002:a05:693c:810c:b0:367:16cf:4a8d with SMTP id 5a478bee46e88-369e84dcef0mr1536459eec.35.1792809156653;
        Fri, 23 Oct 2026 19:32:36 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm3958542eec.23.2026.10.23.19.32.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 19:32:35 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ALSA: virtio-snd: fix dsnoop capture with staged buffers
Date: Sat, 24 Oct 2026 11:32:30 +0900
Message-ID: <20261024023232.84448-1-mynameisjune111@gmail.com>
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
