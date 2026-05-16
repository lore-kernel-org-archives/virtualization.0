Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA13626CE2C
	for <virtualization@lists.linux.dev>; Sat, 16 May 2026 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778896744; cv=none; b=O6i2CzygPOBbIBMZRnGXmY4T8WdnV5H5oTDwAwNVAOgiup+sGWOWP1BpSRIqL4DwTuoIN0WmkEJgN8dGwoyRR58bp9DdFt6izj2iC6K8ib6ASOa7FRKPTVcuYx5BsQa0dMnLLkpZSsYZVgWvaK3Mdii8MGziiVBi084T/oZMmwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778896744; c=relaxed/simple;
	bh=b73Eg0znGaHLjCRsE0KqlotE+t8MJRlelEnlZTv+d+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FlgLQEv+gRNEpqZS5Xbe64GQHEaNQlN6MOD4sYrrZIkTdJFlT3w/7tf1iLic+pOi8vnxoUBUYd9/KKCBNQHIrxWJZRZey9+9WsqoTGbMutsRK0VvghYto5Tbf1CXWw8svDWAGk83uHpkfOBpXZ+r8/5PrLTQ3if1Pym9b+X7tgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoMT0VXU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoMT0VXU"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-365e20fe3b8so215415a91.3
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 18:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778896742; x=1779501542; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PzsEAS1FL9O1jB+d9K2/EfF9rXJj+g/96Fl6NcxXcAw=;
        b=LoMT0VXU+DkR8gF5CQW/uGKYR/da8k7uEaPNL4QkFnXFETAFmxqKCNTBED4LfN1vEA
         ihBDkZMDqExDLf42BiHCmXYT+XME0jjL+hD1tR3K9RA3mllKY0iIZEztEZbLCy/D0v+q
         CU4Hm6ESA9tLXQIVMzpMa5n58xceCkRWJpHNWw/HlJlRDTBTMOe02uZGIlGIlYJJVD2p
         o1F8M0Gk+0jYCMS3NVmPcI5VqiXNFiVh5fIEN8/68JEkmkhjBHiYcwbuy0c1o0GSdbAb
         oXzI8T4Si159S2OLH6O9Ed2mzn6NHBWITq1a71j1bySTwW8PbtfkmRYR5akubCszaPgy
         +Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778896742; x=1779501542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzsEAS1FL9O1jB+d9K2/EfF9rXJj+g/96Fl6NcxXcAw=;
        b=md97nZP0N9PQvk0AEIgS/8U7/jD0Y3K3whTtfrfmHaK4HX9l50e0VE8XxBvz8Z98yL
         TPsWrGOchoGlbyNBlegYUcLZIvzrIscHjWVjoag8pHlMEaP/KIrKdoKtnkdu+nIBIhHu
         TxjXYKf17xzSwBIegxLTYN07PJD/q/3ca53ZK5BDi5m399NVE6vhzg+H7wYmyvsXQ6TS
         uN76F9Ov6LEz8qIfgC7zH9/5B6rg8KMTfbPPzKNpmQwLcIliby4CrfOE1g9AnMS3bZof
         HuDsBgVfo/LuoB/Ltih9HN852EN05eQoF+Anoqzm4X9OIosecsBe1xWQfsDjmJoC+Scj
         oDfg==
X-Forwarded-Encrypted: i=1; AFNElJ8uzDMShUdxMnM1CFA0grPyAtDLaVx4IKC9Ygwkc7Oet/IsT8l4EQr3Qi1dV+px80zF/QcgwCHDmvUXydlqAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnTOv/31yXbXZGLV+NhN5L+AcQ6x/9FQV3nKkUIVEJinAN7lLN
	2hXsD8iFJUL9+Xiz8Cj6M4SLMI83GieaTfGWSuMetZ3Z2JKZJdMlaY9D
X-Gm-Gg: Acq92OGpETdT5YeoBy1NuABxanDU+SG7tb2DXvHVZO/uD7dpkP884Ppbn3gQfPH0eln
	Z/iV9RIu3/XbaC3a3IfHOiCQgj2Br+R63hTJdLZwhSwkb7WMp76s8VFpLU+54EeAOU4dDi/NA56
	QCX7/HXYH87E1KaeMZcIcDkjlM9dTKbDQEAyp285KZ/TSSFgrcmk2mWm1egzRegwpkoFlAK60jb
	i9tph5wcc39DJI+rpHAjgN9Rje0qibTtqjh2KtljeCLDt7oEHFSMPP77iTa4h6HvJzV6CyJNTv7
	R3Xv/kvnICfC6CUAujTDo/g9JUggG2gwvVc3erJVEavKWzwxNfmyMzzmas4CJQFVdhUqPn29KoA
	EEz9K/3qXHdXHxsr0t55w2Yi2q+5jOL5REVpqxl3iJuQPXvGShl+pG40d0mTbpyT6Xn8uLl1Xd8
	4Uj+yKenOWOrGlIH77YOQEjx6KofQbnooeIbKVAVwm0IYU/CNriSlrkt3SKKCHMJEnsYMAESKkk
	bnzy7jNR4Y9zGyr8+AoH7zBumU=
X-Received: by 2002:a17:90b:33c4:b0:35d:9c32:6219 with SMTP id 98e67ed59e1d1-369519e8faamr6167579a91.9.1778896741969;
        Fri, 15 May 2026 18:59:01 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb07b007sm6605080a12.11.2026.05.15.18.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 18:59:01 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	stephan.gerhold@kernkonzept.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@gmail.com>
Subject: [RFC PATCH v9 0/5] virtio: add noirq system sleep PM callbacks for virtio-mmio
Date: Sat, 16 May 2026 10:57:51 +0900
Message-Id: <20260516015756.20948-1-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Some virtio-mmio based devices, such as virtio-clock or virtio-regulator,
must become operational before other devices have their regular PM restore
callbacks invoked, because those other devices depend on them.

Generally, the PM framework provides the three phases (freeze, freeze_late,
freeze_noirq) for the system sleep sequence, and the corresponding resume
phases. But, the virtio core only supports the normal freeze/restore phase,
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

Patch 1 fixes a bug that configures the guest page size before
the reset step of the initialization sequence on virtio-mmio
legacy devices.
Patch 2 is a preparatory refactoring with no functional change.
Patches 3-4 add the core infrastructure. Patch 5 wires it up for
virtio-mmio.

 1. virtio-mmio: move guest page size setting into vm_reset()

    Moves the GuestPageSize configuration into vm_reset() immediately
    after the status register reset to fully comply with the virtio-mmio
    legacy specification. It prevents the configuration from being
    cleared during device resets and eliminates duplicate write
    operations across probe and restore paths.
    https://lore.kernel.org/all/20260507183807.22007-1-baver.bae@gmail.com/

 2. virtio: separate PM restore and reset_done paths

    Splits virtio_device_restore_priv() into independent
    virtio_device_restore() and virtio_device_reset_done() paths,
    using a shared virtio_device_reinit() helper. This is a pure
    refactoring to make the restore path independently extensible
    without complicating the boolean dispatch.

 3. virtio_ring: export virtqueue_reinit_vring() for noirq restore

    Adds virtqueue_reinit_vring(), an exported wrapper that resets
    vring indices and descriptor state in place without any memory
    allocation, making it safe to call from noirq context. Also
    resets IN_ORDER-specific state (free_head, batch_last.id) in
    virtqueue_init() to keep the ring consistent after reinit, and
    adds runtime WARN_ON checks for unexpected in-flight descriptor
    state and split-ring index consistency.

 4. virtio: add noirq system sleep PM infrastructure

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

 5. virtio-mmio: wire up noirq system sleep PM callbacks

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


Notes
=====

 - Although the author of the fixed commit (e0c2ce821795) in Patch 1 is
   included in the CC list, please note that their email address returned
   a delivery failure error during previous submissions.


Changes
=======

v9:
  virtio-mmio: move guest page size setting into vm_reset()
   - Newly introduced in this series as a prerequisite for Patch 5.

  virtio-mmio: wire up noirq system sleep PM callbacks
   - Fixed a bug where VIRTIO_MMIO_GUEST_PAGE_SIZE was set before calling
     virtio_device_restore_noirq().

v8:
  virtio: add noirq system sleep PM infrastructure
   - Enforced freeze/restore and freeze_noirq/restore_noirq callback
     pairing in virtio_device_freeze() via virtio_has_valid_pm_cbs()
   - Skipped virtio_check_mem_acc_cb() in noirq path (may sleep)
   - Set VIRTIO_NOIRQ_ENTERED only on freeze_noirq success to allow
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


Sungho Bae (5):
  virtio-mmio: move guest page size setting into vm_reset()
  virtio: separate PM restore and reset_done paths
  virtio_ring: export virtqueue_reinit_vring() for noirq restore
  virtio: add noirq system sleep PM infrastructure
  virtio-mmio: wire up noirq system sleep PM callbacks

 drivers/virtio/virtio.c       | 368 +++++++++++++++++++++++++++++++---
 drivers/virtio/virtio_mmio.c  | 146 ++++++++++----
 drivers/virtio/virtio_ring.c  |  58 ++++++
 include/linux/virtio.h        |  42 ++++
 include/linux/virtio_config.h |  39 ++++
 include/linux/virtio_ring.h   |   3 +
 6 files changed, 586 insertions(+), 70 deletions(-)

-- 
2.34.1

