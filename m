Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA8B3DCDAD
	for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311124; cv=none; b=npzYesxhCfgsHqi+Vf/6AW6b919zCLPmono5lRdLLqcQ6EfUpcB4qMiq6yrsaUFlLTcwODK2JMbMZ8CxMXQFQdC/+4OityOeAnm+dNqi2DrSwWpW9hNP4L5V0gBut+8uT3ouWMndrXEiAhZZ9wKWQDCpZpwlrwJr+vurem58mF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311124; c=relaxed/simple;
	bh=DADUCg14lrqizbuSgNlO+g8YvyCwVDckd5+HSKcC0E8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YSrcd9bevxyDDfJq8KyvZdfu0nJCFkP1d3SVTrMZ/0KPajmzXoej5Vq2PJkNsc7xTQDkPL7UaifDiUV8aUF8TfUlhnfWodYtUAeWrbVqM9wmxwoNFgQC4lRt857zDxtr1j20iX4qSydc4Y2pGKrlWUFW2yeo3HtQG5GKQVhcNIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OILPP/yP; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OILPP/yP"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c795eacbeb0so4652030a12.2
        for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777311122; x=1777915922; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHqiWE8QEuqLZXF5BQhfJCY9yQPuREKG49UWrGiBPy8=;
        b=OILPP/yPIuq05+FXOJpUekRjB7/0uXLQjSvm0w/uazBQK+aNogV2BfS8FvMXKxacDU
         jt8cwFKIxpfEbLUGP2VQCOHHdrLlhr3tfMUzsFUACpgCuWd9khNR+HSpdfVMUmEcxgE8
         lM43MsYt9E2ub+zaWg3xL5tS8+YYp8fM6QwCeMwQIeAAudfeuTube/jdv8UnQMEWSv76
         kc7H1dqKOClGUeYCr4+pu9CB0Ul0BiMInb9j/OXuNeRZhP1oAKhulkl3H4anXvKcEHay
         1uvWCHrjME+taHRDM/EHCGlY3tb4cAv13VZ1vYQ1tUMB/IKwpuysl6PP7Z8Ad43OCWY8
         FYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311122; x=1777915922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHqiWE8QEuqLZXF5BQhfJCY9yQPuREKG49UWrGiBPy8=;
        b=jQ77/64M/o2oIvCMNXkJQcnMm5sSM8NkL+RamzQJVxGEck5gYIR88Qw2lm9AzMJn8h
         5jl3dOXlGMLC4Qy6Qo9e3Xo/d7BT4AUyROcAlx7VOxCqIkQbbyeDAjETrcHhzsNHZk7V
         Sn6HDvQ4Ejee94lq0+bqOmh26XAagfuQYEddpzTmso+fAYDFJhMt9vj2tg6J7RGJUa8i
         axuQucegJrrvZLF5DZqa66hCCGFitVB+dai0zjnIYicPYlXUNA68PCyU7KEIHoj/uzvm
         AxH1MVKlwxMNcY+obaHvXCIzsQ0FRGI0pZBlqWTstnh03Us7pDA+6jw3t3K7cw81pphR
         mn3w==
X-Forwarded-Encrypted: i=1; AFNElJ9TY5qV/2lNJbHpjGYpfxIAsZF05kHORxVupStZIBjzbOCiOfqqOdDtVwMoyZlzw2Z+rOtX0DCNHwKD50XKSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwyegLEJoXUMNmYf3pfgOeLaefk7Z1rY03NNRVMtQHSqyBo6u4
	H6m19Tj1FjwoO0dH19Sewbc5tyVgtXKnSnctSnyTpJSboCW0NAg70/RH
X-Gm-Gg: AeBDiesp0EvNHSvQRGe4iURIpgUzClQ6g7mLLIGmxwRASnL4KFcho+h4yWC7+XVOTLY
	OLILozlODLwTqbtYRiKWsStqsX0soYUy53E0tMU+luxuAaoiqnaev5elHwpEgDQH5wjoC+FRHuV
	9Ns0iWL5hn8QoWcAXC0EMvPMJd+NKm9QuKw6TafF48rz8TURW+w+1j8hXur8wEoBOwit0oKypzd
	mQDryqdov7Io1ctAzqediZaBYYlW0mAN2F03s9jTW34or/E6wBRvwld0zPsklFUoUBoTonvJC85
	Wwwqdxgsn9gJLnnY16J3xxzXsTn2/eYvz5Ui7XB6+grQvcl1xQuJB0fGvTvyObpdBYgRJsrqvuQ
	5qH9vj/EkT5OizR1jUZMXArYIhl5z2jn2CBaL1u8kziVtpjRLiRVVV2MTzwYPRVaJGZrjfTiED1
	MWn9iMqaayTnPrWLDIuNjw9DVadKtPaU7VzYQz3wY8dv+vOdHDE31/Q4SJG1wOKRnzd4Jsjtn6U
	7Ub3XgchqRrqwKuNNKr0PmOMi9jWxAgPo0VUw==
X-Received: by 2002:a05:6a20:3ca2:b0:398:787c:d2e4 with SMTP id adf61e73a8af0-3a398c893f4mr344793637.17.1777311122324;
        Mon, 27 Apr 2026 10:32:02 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7977031729sm26246246a12.25.2026.04.27.10.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:32:01 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v6 0/4] virtio: add noirq system sleep PM callbacks for virtio-mmio
Date: Tue, 28 Apr 2026 02:30:41 +0900
Message-Id: <20260427173045.28652-1-baver.bae@gmail.com>
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

 drivers/virtio/virtio.c       | 318 +++++++++++++++++++++++++++++++---
 drivers/virtio/virtio_mmio.c  | 136 ++++++++++-----
 drivers/virtio/virtio_ring.c  |  58 +++++++
 include/linux/virtio.h        |  24 +++
 include/linux/virtio_config.h |  39 +++++
 include/linux/virtio_ring.h   |   3 +
 6 files changed, 512 insertions(+), 66 deletions(-)

-- 
2.43.0

