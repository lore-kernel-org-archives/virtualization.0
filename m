Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DAB25A2C9
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966055; cv=none; b=ljFmsww1sy/KCmflDmsWkTGyFP19A+YSlb2ohxGcWIvCS2NyufxkWY8ososiTl8M6kiVLNp3YZ2RZmNiFdBpCXJWYa0cqFXtKBUhm3LdDbA6sz2dLCrw4LGzNxCmBs8DbvQb7yM6I1z7WKtnVqTzslAXuYdY/4EFC6emN7h/ztU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966055; c=relaxed/simple;
	bh=wGcdgtPZygfHo8FJMy41ko0c+pH1Q0Jfh+Jb2HOmRKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QTJu9IW8TcCkcbTOrXnYe8mFwVZGhnpLi1B8V3EKN/g7QAZOdZcrmgKBwADcc2hQNC2Siqa0LMjP30Ydw4rLZnqFRqSmm3EIkbSUkGrDgZHdSZF42D4jNZmMv9e8+tw1e4v5TOwA+E2kC23/y2D3JPjsN3Xe2T6BjJpPhJWS9B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7MAdM+v; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7MAdM+v"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so3670107b3a.1
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 10:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776966053; x=1777570853; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhPcOtlTSnq+IPIdCokakonQWrGMmRZhayhnS9aOfQY=;
        b=T7MAdM+vmhZmwjYBQX1FySuV5iYcw95N+LA26Swb+ZgoJU1kclpDzYRCDX/4fB1g55
         xtK8OOaRLt72pNpjBg7m8q6GFd2jM+QNakPR/nYcyF3UOBCxd9YHVXQQmCvFOqs2TeJ8
         40YFeV6OlltmBCOjFgtRrruLOwt2/OYy3FlTxojSVzEkYsPcDq3XZhJ9rjSwyuqrRoGM
         yZyfsAVqVi9LTjatKhqdFKmVOSfX5dHRvdY3NXeleeFkAUVAcPBJK7RwbEGHUY+bs1W0
         pXfo/aIZHil2bF4q7YHpgJaDxqsLwtEvSCq7kBYjmfzlqx7SvEmrThuDVNO1wzPeqeFA
         tEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776966053; x=1777570853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhPcOtlTSnq+IPIdCokakonQWrGMmRZhayhnS9aOfQY=;
        b=JxvkTCL7fGH2TVZFu6Vaq76nmFvzi3TXmDFrW7HxYpaI6W+I80aUFgReGiAEMmX2QC
         kP76xtRNC7gCrhfl2C7BRkn7ugCOERs2GC1FLRgePg6l3hWjBwrCqW0QQAr8jL+DgXRC
         99VBMAjR5VrvE1Y5UlSCdjHmoMIn1uQqBcKTdACoR1E8FNnx7F/u9kWwScWLvv3lvE/W
         URKv029GJDo5OojrJCha49fpE135cy0XTb9oHR4ciQiBXWaBPCLDTTshdUCurnQOMTvt
         yqIgB2iv+klnUKh1dje2Oj3RuI+v+9xI75oF3Tzj8AtsihT4e2Xqy0HDq4PsX08yo/yX
         eMdA==
X-Forwarded-Encrypted: i=1; AFNElJ8fIriipIs8LGuSr0624JkVxpi/N9v6oxyewCahn0Xz1lxwMvXVRwL/ZQM2+Sia+km/TO8TTgWB/EijC8P5/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJxCFcELoVQbQATKlZDeNPgGEAHY3/5mzj/mT5RifZ4uay0p5O
	Dt9wH3aaHjK14T0V7IzXNw1lgH6DQWjRhNG4IiD3ChyeYlPe7OvroZRQP/7eDGVk
X-Gm-Gg: AeBDiesn/C/xAXwSHPCv2NEWM/TCApjo0jnhe4DQZwgjuedPHq2mGyVlnq/ZLwiYTw8
	YhNLw1+Db0x/P9QnEvVOpXhvjFAg+ZowHhbuO2SyHpmK5Y2eK+ZW38S4B43g4OvemjuzpXib1nP
	E1eKFZ7lOBfOFr+4w/pvVGRKnO1/kGyEeqNowmxxONi9XAWCi0PEpl7dh/bmJLGR6H04ETRwvCY
	MzVTwL4muBuLnVYMrfP0b+gHpNj/2+lPR17Unk8+oD8zRnYALcn8EvPo9SeXzr+PLPgW7hiPWNI
	Rg4o1Tn9v5Ns7W4FqD/2Y4mXer7YibtOY5SaMVhRwYngoJ4WdF/Dy/KArB7/0GCCCPlw/OVxevT
	1sJ2DWHDKWE/cnyMsSZgXkqM2rifdTXbVx8WcCLiy6DZchUURIz/Kc9UqFbKWGpmShJvWoq3pCT
	6wNnq6TB6m10t5r4mUUQOu0NUUCCXZVjW/gfskXhWy8XQrrUf1M4u5Tka+7NvNDcVUyZyumtGQN
	TuXabgUhlokYZM92rOgeN/mtfMzLPKHLQ3F2g==
X-Received: by 2002:a05:6a00:18a8:b0:81f:3fa0:8c38 with SMTP id d2e1a72fcca58-82f8c84add7mr31799280b3a.20.1776966052417;
        Thu, 23 Apr 2026 10:40:52 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebcc9easm27014498b3a.39.2026.04.23.10.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:40:51 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v4 0/4] virtio: add noirq system sleep PM callbacks for virtio-mmio
Date: Fri, 24 Apr 2026 02:40:35 +0900
Message-Id: <20260423174039.276-1-baver.bae@gmail.com>
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

 drivers/virtio/virtio.c       | 291 +++++++++++++++++++++++++++++++---
 drivers/virtio/virtio_mmio.c  | 134 +++++++++++-----
 drivers/virtio/virtio_ring.c  |  51 ++++++
 include/linux/virtio.h        |  10 ++
 include/linux/virtio_config.h |  39 +++++
 include/linux/virtio_ring.h   |   3 +
 6 files changed, 462 insertions(+), 66 deletions(-)

-- 
2.43.0

