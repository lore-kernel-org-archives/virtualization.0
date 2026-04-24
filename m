Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CA03CA493
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033817; cv=none; b=h1zz/HpoqzB5trhDsxV/LS/5UwoUC6x7KS6VOFL6RnE6fAErBDMsfDYG7sdorUHKm6HIhC2tYpb7ackkb7n6wDsZ1S1v0Dka5EP/1lHeAjznIT3R1rKI01oM8NrzxtiKq/hQUgI6A9gB5oSSro2v3JPATeW9uuhpL9+pSheUvws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033817; c=relaxed/simple;
	bh=cHR21YIGwD5W8MmCt1kQ8MtFb99hOmyP6Mn5+FOkOUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FCnlVL502KbNWTQHBCOgqNnkHiFCjojvcqiBg+GokslqalKQ1fTtVTPe0CcjmUb0u0ZZ9mg4Sc6bZpY9fw2sNedXyQJEVho9wuXFyHngB1eC8eCXgiTWjKkxtqpAIBQ/Dd7phb9QMAeE1tTmj/FVWIcekcQCBCXQEkjOuXDnv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXlEQmHZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXlEQmHZ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad9516a653so39621795ad.0
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 05:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777033816; x=1777638616; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mj7hWqWsfsGU47bai7HdWFB0eEQlak+i31aNqHtdKEI=;
        b=oXlEQmHZ5AIKg64y6AzBPshXADDwwibadHkkTtZuTw/oSgAZt0DFEr9eB349CKppUB
         y1DMOiJZ4VmAEg0OLryFvQvupP91uXqWxbZhKycpoMGWUTvyAd7o0uVUzchW1JVYIvrZ
         e0l9KmuYzPoBlvf9op0TIUvgUX9Aw0E9n2wgVS2FnF53eKM69riP6E3pf5AmV3URVAgN
         MQCJ7LZ4JqAPsK5RhuiaV5HpjXheNHWIoX4h4XRvVabb8CjmvmNx2BAW38Hjf4hVlY/x
         +bG1qKlfPVi2m/PSWEcUT4l6Ezs9/c4EoukdsTUS5/dMJw4bibvdu6ctohjxti4hGSLR
         7Chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777033816; x=1777638616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mj7hWqWsfsGU47bai7HdWFB0eEQlak+i31aNqHtdKEI=;
        b=H3axraITHRoxFX2Ocs8KCfjlcOjgwCmuhWJVwpRa49PoA15aKQtBwowJs9nKcv6cro
         bEvpwaTfcgU2+1vk6YommpbutDMyZzwjPJtcm7hASEOrbf0+R63lraNK4FOJDWzGPpRf
         TLtXjznW3XaXaq6wKkS8pjeJxcA1nPN0T/jGzLy0ZQ+P63KQsO0a28xAfNORPtwPSPR7
         GI56LrOEya/fteMQ6/tOOmN4irN+LtgwHFDp3Oa6WbhqeolByL3rm7kV++M6Ab5Wtmmj
         DzdS/OhVgH1BM5FZD+101B2bsJcKTJPPwOOb2FiIGDu9gxs5LHPP0PFcBVdlNMZZPHxs
         ffzA==
X-Forwarded-Encrypted: i=1; AFNElJ+oCS3rxfIUVOBdOoBNdTH+rERzsoByxWZtS5UuMZXKMelVVKYwDQNDUYfmsX3HnlrxrrBWyEdtVkD9NW3/SA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXlpgCCSvl2Aw8rT4amFtiHnJ1njijUank/cuIWz8+Fmyj/84Z
	571/3CzXguB+Qy+T1nOF5iYObL7jr5NbB74Q/2ntClacjpvGxsWoouPK
X-Gm-Gg: AeBDiev1fUkes6GEmsU5lp7cYNlcBODsEZYuBsbfRna5mTkwzW8plzXChoYBvQOlVeg
	fsyCZ2QsCOSmcOYhbxLzNE1jck9K8ORCchlQTv6OrbJ7+18U2ZmnXI8rdeHpkxuGZkHugn2UZ2Z
	ZPwQd0NfHGMIt0VpN89Ofbk+chJi0KBEYMARIKSwYaW41CbKOunWrTL51O/jWsqi1UV8yzjZdUQ
	Yh0De8O0MKw3plYhvb3jLvC+SyQGHE6ioezQMAeLM3GC1DKgekAlsQEGDoPAXAWdyyX13nELLDB
	RqfqQXKjOVewdYpl1mnJCC0RSNwOprXydc3tJgb6Zq60u5KMJ/YJocSl0G+4Nc2i1BTZv2QRv+2
	QlzlqTqr/cR9wartTprU7B1uAUGA0PIeBdx+RuW8x/bi8jsLBPDkS6oAhp87qqUD9OU1hjNHLOF
	T9ZIT3TcL1LMn3o2KoTnS8qL2fY0N0HCzNCLotXmPySdRAWISluB6YylRTTCEo60j/TH4qGZ64u
	ph1cZc9SaBx3hnoL4a2mJ27GOpdgUyYAMvmTQ==
X-Received: by 2002:a17:902:d393:b0:2ad:d0ff:2ed4 with SMTP id d9443c01a7336-2b5f9e5da5fmr209158125ad.6.1777033815128;
        Fri, 24 Apr 2026 05:30:15 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff734sm218006415ad.10.2026.04.24.05.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:30:14 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v5 0/4] virtio: add noirq system sleep PM callbacks for virtio-mmio
Date: Fri, 24 Apr 2026 21:29:50 +0900
Message-Id: <20260424122954.273-1-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sungho Bae <baver.bae@lge.com>

Hi all,

Some virtio-mmio based devices, such as virtio-clock or virtio-regulator,
must become operational before other devices have their regular PM restore
callbacks invoked, because those other devices depend on them.

Generally, PM framework provides the three phases (freeze, freeze_late,
freeze_noirq) for the system sleep sequence, and the corresponding resume
phases. But, virtio core only supports the normal freeze/restore phase,
so virtio drivers have no way to participate in the noirq phase, which runs
with IRQs disabled and is guaranteed to run before any normal-phase restore
callbacks.

This series adds the infrastructure and the virtio-mmio transport
wiring so that virtio drivers can implement freeze_noirq/restore_noirq
callbacks.

Design overview
===============

The noirq phase runs with device IRQ handlers disabled and must avoid
sleepable operations. The main constraints addressed are:

 - might_sleep() in virtio_add_status() and virtio_features_ok().
 - virtio_synchronize_cbs() in virtio_reset_device() (IRQs are already
   quiesced).
 - spin_lock_irq() in virtio_config_core_enable() (not safe to call
   with interrupts already disabled).
 - Memory allocation during vq setup (virtqueue_reinit_vring() reuses
   existing buffers instead).

The series provides noirq-safe variants for each of these, plus a new
config_ops->reset_vqs() callback that lets the transport reprogram
queue registers without freeing/reallocating vring memory.

Not all transports can safely perform these operations in the noirq phase.
Transports like virtio-ccw issue channel commands and wait for a completion
interrupt, which will never arrive while device interrupts are masked at
the interrupt controller. A new boolean field config_ops->noirq_safe marks
transports that implement reset/status operations via simple MMIO
reads/writes and are therefore safe to use in noirq context. The noirq
helpers assert this flag at runtime, and virtio_device_freeze_noirq()
enforces it at freeze time, returning -EOPNOTSUPP early to prevent
a deadlock on resume.

When a driver implements restore_noirq, the device bring-up (reset ->
ACKNOWLEDGE -> DRIVER -> finalize_features -> FEATURES_OK) happens in
the noirq phase. The subsequent normal-phase virtio_device_restore()
detects this and skips the redundant re-initialization.

Patch breakdown
===============

Patch 1 is a preparatory refactoring with no functional change.
Patches 2-3 add the core infrastructure. Patch 4 wires it up for
virtio-mmio.

 1. virtio: separate PM restore and reset_done paths

    Splits virtio_device_restore_priv() into independent
    virtio_device_restore() and virtio_device_reset_done() paths,
    using a shared virtio_device_reinit() helper. This is a pure
    refactoring to make the restore path independently extensible
    without complicating the boolean dispatch.

 2. virtio_ring: export virtqueue_reinit_vring() for noirq restore

    Adds virtqueue_reinit_vring(), an exported wrapper that resets
    vring indices and descriptor state in place without any memory
    allocation, making it safe to call from noirq context. Also
    resets IN_ORDER-specific state (free_head, batch_last.id) in
    virtqueue_init() to keep the ring consistent after reinit, and
    adds runtime WARN_ON checks for unexpected in-flight descriptor
    state and split-ring index consistency.

 3. virtio: add noirq system sleep PM infrastructure

    Adds noirq-safe helpers (virtio_add_status_noirq,
    virtio_features_ok_noirq, virtio_reset_device_noirq,
    virtio_config_core_enable_noirq, virtio_device_ready_noirq) and
    the freeze_noirq/restore_noirq driver callbacks plus the
    config_ops->reset_vqs() transport hook. Introduces
    config_ops->noirq_safe to mark transports whose reset/status
    operations are safe in noirq context (e.g. simple MMIO), and
    enforces early -EOPNOTSUPP in virtio_device_freeze_noirq() when
    the transport does not meet noirq requirements. Modifies
    virtio_device_restore() to skip bring-up when restore_noirq
    already ran.

 4. virtio-mmio: wire up noirq system sleep PM callbacks

    Implements vm_reset_vqs() which iterates existing virtqueues,
    reinitializes the vring state via virtqueue_reinit_vring(), and
    reprograms the MMIO queue registers. Adds
    virtio_mmio_freeze_noirq/virtio_mmio_restore_noirq and registers
    them via SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(). Sets .noirq_safe = true
    in virtio_mmio_config_ops to declare that MMIO-based status and
    reset operations are safe during the noirq PM phase.

Testing
=======

Build-tested with arm64 cross-compilation.
(make ARCH=arm64 M=drivers/virtio)

Runtime-tested on an internal virtio-mmio platform with virtio-clock,
confirming that the clock device works well before other devices' normal
restore() callbacks run.

Changes
=======

v5:
  virtio: add noirq system sleep PM infrastructure
   - Preserve FAILED across restore_noirq() failure by recording the
     failure in dev->failed before falling back to the normal restore path.
   - Document the restore/restore_noirq fallback contract more clearly,
     especially for drivers that preserve virtqueues across suspend.

v4:
  virtio_ring: export virtqueue_reinit_vring() for noirq restore
   - Reinit safety was tightened by resetting IN_ORDER-specific state.
   - Added extra split-ring consistency WARN_ON checks.
   - Clarified caller preconditions for noirq-safe vring reinit.

  virtio: add noirq system sleep PM infrastructure
   - Added config_ops->noirq_safe to explicitly mark transports that are
     safe in noirq PM phase.
   - Enforced early -EOPNOTSUPP checks in freeze_noirq for unsupported
     transport combinations (noirq_safe/reset_vqs requirements).
   - Added defensive runtime guards/warnings in noirq helper and restore
     paths.
   - Discussed the freeze-before-freeze_noirq abort scenario raised in
     review and concluded that the fallback restore path is intentionally
     handled by regular restore after core reinit/reset, so reset_vqs is
     kept limited to the noirq restore flow.

  virtio-mmio: wire up noirq system sleep PM callbacks
   - Marked virtio-mmio transport as noirq-capable by setting .noirq_safe
     in virtio_mmio_config_ops.

v3:
  virtio: separate PM restore and reset_done paths
   - Refined restore flow to explicitly handle the no-driver case after
     reinit, improving clarity and avoiding unnecessary driver-path
     assumptions.

  virtio_ring: export virtqueue_reinit_vring() for noirq restore
   - Hardened virtqueue_reinit_vring() with stronger safety notes and
     a runtime WARN_ON check to catch reinit with unexpected free-list
     state.

  virtio: add noirq system sleep PM infrastructure
   - Added explicit noirq restore completion tracking noirq_restore_done
     and updated PM sequencing to use it, plus early freeze_noirq
     validation for missing reset_vqs support.

  virtio-mmio: wire up noirq system sleep PM callbacks
   - Updated virtio-mmio restore path to skip legacy GUEST_PAGE_SIZE
     rewrite when noirq restore already completed.

v2:
  virtio-mmio: wire up noirq system sleep PM callbacks
   - The code that was duplicated in vm_setup_vq() and vm_reset_vqs() has
     been moved to vm_active_vq() function.


Sungho Bae (4):
  virtio: separate PM restore and reset_done paths
  virtio_ring: export virtqueue_reinit_vring() for noirq restore
  virtio: add noirq system sleep PM infrastructure
  virtio-mmio: wire up noirq system sleep PM callbacks

 drivers/virtio/virtio.c       | 298 +++++++++++++++++++++++++++++++---
 drivers/virtio/virtio_mmio.c  | 134 ++++++++++-----
 drivers/virtio/virtio_ring.c  |  51 ++++++
 include/linux/virtio.h        |  17 ++
 include/linux/virtio_config.h |  39 +++++
 include/linux/virtio_ring.h   |   3 +
 6 files changed, 476 insertions(+), 66 deletions(-)

-- 
2.43.0

