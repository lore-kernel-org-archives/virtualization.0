Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5524B3C8724
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388889; cv=none; b=EuSP2MkR8LK/Rbkef9YkaCeMpCWrqIFrKcebaNdMG2TKCaJWNs1A2LOMEN4K78TGngHxCRVfQ/LV8IXkAa5s1qcDnQZGBzP3T8V/1Jfs5sDRbaA6KahnjiSzaxqdowgEoNJzbCoHUTbjzRjuNYKJh5rN9De+HP/hG8sxZPfnqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388889; c=relaxed/simple;
	bh=jcrzp1DFmtJfG6NLkTcUSwNjlkqwagKGt/Uo4kBhlg8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nCuLM2umO2QI78wzehtbM81tG59F+OlC1BCFUOeno1G8q94lfI8chsPT8J5q1fljljhdnThqUYp0+x81xbXdEOgWjs/8vIIviL7gbb5tOmpngXTnpO+qWp61HXFtHxLy4v/oMGAg3IBuwO2bVTiVYrzZnfVOHo83RSRjySc4E50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXIGts2M; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXIGts2M"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3591cc98871so5327257a91.3
        for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777388888; x=1777993688; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMCUDqXYPEmc/H4vTHUNufqbd3PwU88AIKVXTZAaCUE=;
        b=OXIGts2MYebHCuMmOww7TiDE4qrVFoMcNiNXaMUu1N2patnss78X5QcezCNR7EaGwE
         Q/B5V2QAvWsREokl8ptSL+pCGbj++8X+oK00pbpx1oaNZj6rYaYuxJOO7mN83XrxeHVg
         UkIEJwtDC5usJtldXY7rgR498iRPoiTU7vzt/up48jigXjtiaH/389BX9jNcHWI7S5bI
         S2/pgONeE6mVbsCs7Aek8ABzhzzHTyxq84j1h2RBhP+bYt9hVGjD1ZYBiYbh+LDVUg/w
         rby8NXwMUakNfvNPawvZJfc2yMTKhvlM7YQH4V9/uHVxZtWFw4rAOeU943BD6TCj2NYW
         lX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388888; x=1777993688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMCUDqXYPEmc/H4vTHUNufqbd3PwU88AIKVXTZAaCUE=;
        b=cA/eFXT2v87hDBoRFcpSfsZkK5sZw9ftqPdtGSbi9A08+iUg1WFidCTMZXtkcyCkE6
         JS6435VJkv5cmCQhXfBT3huz2HoJba0Qarb0DgxOqf4EMH6p5BZBV+7aYPRf3GqgjLMS
         y1DueYd3hEswWGdLcGlsq+0EEB8iFNiJNVT/2s/y8CvvrZnOHMOFLjzvjwTnvhto4ej2
         qFfHB8VCoLqHWxBv6ksyPb43Ph6GezzJtPUSH6n402Ytm2mj7bY1ka/xsj85xBiDHjGT
         yUBQL5d0SCC/OcPozU49O6iVoqqsIToe5rNjCDztSxy9eA7WRyA7S5v+I/RkLZlIUYrE
         IJYQ==
X-Forwarded-Encrypted: i=1; AFNElJ//nhHkOrc9UQkRwLr4nbUHcz5HJkZcMtpEsKNDHxwSAsyhRhzcQt9iEJI6NlZHgCxSpb9Pz95p70/D0qNEhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzb42eqKsaw6LlP3CyeDTlVQYqrL24MV12rXG3OiVX0XpHQFeHN
	LrVzVK9kJAgSG2AmdUuv+2xLPEBs31psTDN/XUJ8SWzKVsl1dgLbHV+I
X-Gm-Gg: AeBDiessXKKRL7VStI5UaEF2fD77Z+5KeyAuH6pjgddxNeCWZRlJxRa/unnvqvymOPr
	QmuhUqJdl31yX9vLpyPBnJFXN619HwYViAnVS9l3OKc+1p4p4ol3TpPUXW5UY8u0QGe00I0bROF
	FY4R+MpDYN5bQa/g3Zrejpmvgp4MbW+FzHdtpoB0krFPd0gQxwIL8egKj9fN54Gnkhl6Bv2JPb1
	2WV0+vvBgIJOznTitoysTviazqK+BXVZ7em7pIBZZAUM85weMCF5h/dVtBZ4YaVmSQ9pQgcsJqh
	8DLEYufGQc3J2nnFNeAfEf5mOm6eGj16Ag8fwcWchM6dTInAnjmRjKVhPZFAftuZt/tM1LAQvt0
	5cPFgZ07a3vqYeOcfmMFTXAcDD4nOFDSQ1biyUdZ4uewo5el95judeHkMne09d6LF2xqfVRgU+/
	I8SvEIrODQOK4DZFANGtbCu7r/ZXbdkd6Vh0uQYMZb93CMdZhe6Kg/8x3+Tl9mtOgSlDWGr8MLa
	sw95SxT9UklZNRR83A14q7t3SyH9Lod/E191Q==
X-Received: by 2002:a17:90a:d2c7:b0:35d:a0b7:9608 with SMTP id 98e67ed59e1d1-36491fbc1dfmr3666125a91.7.1777388887292;
        Tue, 28 Apr 2026 08:08:07 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490bd66f6sm1606127a91.3.2026.04.28.08.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:08:06 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v7 0/4] virtio: add noirq system sleep PM callbacks for virtio-mmio
Date: Wed, 29 Apr 2026 00:07:38 +0900
Message-Id: <20260428150742.23999-1-baver.bae@gmail.com>
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

 drivers/virtio/virtio.c       | 325 +++++++++++++++++++++++++++++++---
 drivers/virtio/virtio_mmio.c  | 137 +++++++++-----
 drivers/virtio/virtio_ring.c  |  58 ++++++
 include/linux/virtio.h        |  42 +++++
 include/linux/virtio_config.h |  39 ++++
 include/linux/virtio_ring.h   |   3 +
 6 files changed, 538 insertions(+), 66 deletions(-)

-- 
2.43.0

