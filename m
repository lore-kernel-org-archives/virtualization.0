Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD13E4014A0
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084654; cv=none; b=ApvV2QyDhYx6N6+EP3ABoSeIfYU3aYc6tEuj4HLkb41mMLvvKnF+06BhlBF60bx+Cx5cyutAdZEx/t4Q9pBzIFyfdjlQPEvHmQbHcFknhGMhUR1QEugLaV74VVGdFsDkGbxwwjcfuMQ3YgKF9Aly9VVMwHWC9sA51LN5SAPhyRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084654; c=relaxed/simple;
	bh=nXGuXI6JlUseo9BWKSK5mr6HMpvxX4k8GUyh/IbgaUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gW0L8yo0Xm2FYCxk5tqemIeBt73JGMzjIcEvhke7o1f35zLoVlfz1ifredproVaA+7/sxh7zXAMK+zvu9G1u5LhqzQaIQXkcIT1hkFE8vuL3BXLdJW8RzgIMpiuKDVdL9TF61LcmglkTG+JKWReSlS++qDKJGTGALJKAkQeFET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sa1fCpj7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa1fCpj7"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-836ebdeb969so1693942b3a.3
        for <virtualization@lists.linux.dev>; Wed, 06 May 2026 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778084652; x=1778689452; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SwYxdj93zY+N8xacG4emNx/Mv1swnDwOmcb0fMU6Mnw=;
        b=sa1fCpj7v9bNQGLl8o8gqP5JoCVGG7cdAIaCLF2GrPexwziR9ifM3VFeI0zd/1hguR
         H9EaXs9AlE+3Me8iZpKZNBKqF5aDqwsiDm/aBu6FRt76E9GAPwZ7WiZAto2qpuwsBpmD
         7qakgXxpejhWLSJHPPKL7zFDf6ZD5Eort39j+6mn/7kCRCJakgbqwDnzxqXntebxH0XI
         n28Uhrd4IZrwrOEMERQO0h8H+dfZvM73/OgdMLEV6vbUYPaT4TC/oiZ0IkJkWb9AycqE
         S7qKJOzc/zvWRPMc5QL++FRkymjvyI+dyJ6EbIBNGVf8Zllr74rxY6+zPnb/Wv3u3VUm
         jIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084652; x=1778689452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwYxdj93zY+N8xacG4emNx/Mv1swnDwOmcb0fMU6Mnw=;
        b=lnwZL/kIPVnm8+4lM1IcK2zklMLZZbbV7u05CzCzTeGKvH5J8BYpOe1ZZVjwIsXfTQ
         Y8yaa5kNS8ICDEuk0fSKi1eyKvtPxHDirHm8ysB554dtFqeE1GEclLMtfdLodtvvSHRD
         OHrACjX12u5zf1KdegA+0RskBDWKBJoSlksfDEMnFkdE14IJuqOxgxhfxP13dV+ddRdd
         EYOcR7rp4QQEYCAnfAx38ExtfBnJkLc032SBv6Zsai7Z2RRnDHxGWeD+kexB+v+8GnRf
         8jkBGYULFE217yckBW1y+FFO4K478gn6yDaQ9taUhYuYe9qeSbVeYfYXduxMNFc68/5b
         G4pQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gLnItYSByPAkEcq5O3ZuMt8fMs8kFRlVNHx7RygAzMKy7mI6+IqHGo84dJ1urV8mIi8fgVcqJF83rhCIvag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzon1cEEoTljiUTJNeTIiJaP3LWQI0Zfz/BsRB526YZGMlDkhUQ
	3gy+K2QPvFbSFDMZhmE8X3XgujCAnQfgmD7eckp0mrKslYCqay76R4EN
X-Gm-Gg: AeBDiesSgLH2Rl8p9kUw5jAqqUMzHtYCZ8QJOWrREh9NcBS4N+sODVPc2OzWnQQuBoE
	ZoohTbCru0gTlhtryNjRYx9GacZF6VYNdPif77Y3l6IQwLRcX10R2EF09WNBmxd7aIPFEKbVCZz
	X1vuou6SpKMEWLnGDCzvyKmmgHipqPE/VhCaRs0Kw00BRQDblqt2+kYZ8a0D8aJjAhkM88zQUrS
	Yp1mG747sVHdQDXJX57O5xL7l6vPW9nbAnNsdKE0NywxSH3cEb99/swQA1k7EARudYQUjUiooyC
	OdG1ZlwLyUZmuvSTzyykqBXTmwxkHijCEeRqaJtxi9ETf1BeXhJ6MgU028DUq/pa5s9kDphj92W
	pBgQCQYwnVWIznzYYjN77cDedxAwEWnPXYv2e74NAq5XBgoxtkK7kgTwCe9+v0P/KvFC8+b018W
	iDNOrIG6ZW6Q3e9OgnNuLXpfsVowTGBGcPEmTi7/wYd8sWOTh2Wp5srXnZJXQb2eQRRcgMisrvL
	Voob8WWKrFPt31E9x2hU5I1bxzXqaWBgTd8KA==
X-Received: by 2002:a05:6a00:21ca:b0:82d:24f:2509 with SMTP id d2e1a72fcca58-83a5b0dbb5amr3732722b3a.1.1778084651808;
        Wed, 06 May 2026 09:24:11 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8629sm5980337b3a.36.2026.05.06.09.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:24:11 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v8 0/4] virtio: add noirq system sleep PM callbacks for virtio-mmio
Date: Thu,  7 May 2026 01:22:50 +0900
Message-Id: <20260506162254.25576-1-baver.bae@gmail.com>
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
    enforces early -EOPNOTSUPP in virtio_device_freeze() when
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

v8:
  virtio: add noirq system sleep PM infrastructure
   - Enforced freeze/restore and freeze_noirq/restore_noirq callback
     pairing in virtio_device_freeze() via virtio_has_valid_pm_cbs()
   - Skipped virtio_check_mem_acc_cb() in noirq path (may sleep)
   - set VIRTIO_NOIRQ_ENTERED only on freeze_noirq success to allow
     restore() to proceed on failure.

v7:
  virtio: add noirq system sleep PM infrastructure
   - Configured virtio_noirq_state to have 3 states to differentiate
     between restore_noirq failures and skipping the noirq phase.
   - Re-verified the PM callback combinations.

  virtio-mmio: wire up noirq system sleep PM callbacks
   - Aligned both conditions for GUEST_PAGE_SIZE and virtio_device_reinit()

v6:
  virtio_ring: export virtqueue_reinit_vring() for noirq restore
   - Made virtqueue_reinit_vring() fail with -EBUSY on precondition
     violations and propagate that error.

  virtio: add noirq system sleep PM infrastructure
   - Make noirq restore failure terminal for the same device:
     .restore is not a same-device fallback for .restore_noirq failure.
   - Decouple noirq failure from pre-freeze dev->failed snapshot.
   - Add noirq_safe validation in virtio_device_freeze() to catch transport
     mismatch early.

  virtio-mmio: wire up noirq system sleep PM callbacks
   - Make vm_reset_vqs() handle virtqueue_reinit_vring() failures
     to prevent continuing noirq restore with a potentially corrupted
     split free-list state.

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

 drivers/virtio/virtio.c       | 368 +++++++++++++++++++++++++++++++---
 drivers/virtio/virtio_mmio.c  | 137 +++++++++----
 drivers/virtio/virtio_ring.c  |  58 ++++++
 include/linux/virtio.h        |  42 ++++
 include/linux/virtio_config.h |  39 ++++
 include/linux/virtio_ring.h   |   3 +
 6 files changed, 581 insertions(+), 66 deletions(-)

-- 
2.43.0

