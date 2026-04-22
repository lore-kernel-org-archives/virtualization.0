Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C8367F58
	for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863461; cv=none; b=Av/rd2IwoiDukR2bwltpuPdHg7KDxkkmqlp08GJbvWJdU2mcQLPA3mvZpG+s4/RoaQhjRm9pPYC9vcw7qxTPtIXAAmlEfOu2/sgjFlIGMg94pNGljBwcKBGiIGGBo90r5G240qelnQcDjpufLvQyT488r2HXqJtO93eDjiwCWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863461; c=relaxed/simple;
	bh=9viZ5aB0oOkxcQ67//hzdTmzBBz9TmMfppChaAsqZZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tzdM171ynfPqQrWdY3lt+veu6LQfwQGB8OmOOI8JMo6SuCyJs3QxnekFz6rmzSOr1vdVLydYrP1ipQm+TkWxjv67+y/04Y63VdacrMZrpnjRpabMDJ4EObxceN2L5/zCbJZqZIeuEpRZwBl7ljqmlQs5Lt1jffzTfxeCqxCmYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KspNF/lv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KspNF/lv"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a8fba3f769so24321405ad.2
        for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776863458; x=1777468258; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EcxhWfFYbd1ULtkHWDQs1gK8P80UiqpfpBxHR31yizg=;
        b=KspNF/lvV1RpecCkkTvALwkdbOzv61svPvI6t8l+z4t6KF3grAUZugplpzHCpgn7AR
         8n+IMTEzqISqGm0oWsqmTz63ZaJntfw+K+braMViFH20yMoKkBn1Fi/W/woVwuuJagLl
         CoRr58wKhOo++RKxI2KrQruMrJzZpbhkpeSTEQRTK30EVD4TJWTj8rQP2t2j+MIj/vr7
         66FUnydWvVIWmaheXOFf5zrFo7WFYgr2tIACgKUGu8HfXacQjQtPRzGUfUqg1qo36Hfj
         Epd7DxOntcAY0+0pZwjQ5L51C4oOlehX28zE1qU07pYPFjMNxbIjSZiF7WvWx+OfQSfb
         qFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863458; x=1777468258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcxhWfFYbd1ULtkHWDQs1gK8P80UiqpfpBxHR31yizg=;
        b=JTxg7I7uL5G9RJ8pFRYRpLhrSy5mgaEJRkBJNnDbIR6++Zk/tI1zUcKPGjCxRKtYZS
         op/vTwYzrrfBYxEFWdYmaFWRLcBytTsQ4e3M3s/u4fUoy6oZKQ48YSJYFjfsJF4WJbuv
         Jz/WCLyjkPV75SiRv36hNAy7C4t9tCF20GLGDNg0tFYHGBx+WEPCtG3DlcXY7c7SfXFu
         XaGcGpsZ1Mt2x7ppeemgEyNQ6uaO6yN6rLKELitbsnJRBQ/PkTKPZGek/PSQTizqXVA7
         trXerpedvHEVGlRnsxtLQL25bFMKUJYcdiLcPJXQxsFHgfCboVzK9nmWotpjRZq6P6Ef
         +XSg==
X-Forwarded-Encrypted: i=1; AFNElJ8DAUJac4RBcW50dRcwP3ItVMa6hWRJo/JWHLdWkSszsLhQvWQz4d5SmVqx4jSjpt5b+roxzZVLCr+18ckmDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCrrekS4BtWzO+RvzlqgMGOhapWDRZ1uRS9x6mloptpeMS4wZ2
	BR/wGLtojTtuqW7rGF34BkzUYM7kmmu06pY19fOzU4UME2Y8NIhvgScK
X-Gm-Gg: AeBDietUoz82wGQ5JVDs8vcL/qkC4ym0TpeyUgOsL+JhlH6cBhPNwY283mlQIk6B732
	xhF3NlvezFSqaiSsh96l6Xc/9mAccqNolOAnP6qFa4rAgAmvDmh1lqZKaATVV4sRswFw5QcpS0j
	DBbqzHf0rEHVxxV1rLgV33b3ySOQ/FjQmtCn17v+NaNiGr9PlNF97Xsblar0zEujB08d/NsVnPi
	FybE7O/F50WVakwdd3naK4Pb1+OXj/9C1h3WsfJ44qgP7WS+SCyFrFo+chPI3sRSEV9eTCVQiZu
	15KVtzvkIxO2FpzoIw2Pg4+IKJmzniabtw1KYOjuLUVXz5xn1lsQjqjXjTfVRmZHX6ZwVJma9pk
	6u15wpdzL3P3EbMkkQhI7Xz9pYK3pazoiFGDScY31w4faVux39RORSqCvFVW3fVS8BkHgPIPdGO
	pxFg3zFs3/WcGK2gEG+XvYPOPUKwlwTZpYjIx654tUyUhCrRyee2kqzTLLWKiLbTT19XmGs1aga
	qtnzoj71Pg5kuqF2hB+t1gi4cfF3nzRjkZvnA==
X-Received: by 2002:a17:903:1a88:b0:2b4:5b9e:4edd with SMTP id d9443c01a7336-2b5f9e9a500mr241113505ad.9.1776863458025;
        Wed, 22 Apr 2026 06:10:58 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b606ce9891sm127892235ad.83.2026.04.22.06.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:10:57 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v3 0/4] virtio: add noirq system sleep PM callbacks for virtio-mmio
Date: Wed, 22 Apr 2026 22:10:10 +0900
Message-Id: <20260422131014.956-1-baver.bae@gmail.com>
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

    Adds a thin exported wrapper around the existing static
    virtqueue_reset_split()/virtqueue_reset_packed() helpers, which
    reset vring indices and descriptor state in place without any
    memory allocation. This makes them usable from the transport's
    reset_vqs() callback in noirq context.

 3. virtio: add noirq system sleep PM infrastructure

    Adds noirq-safe helpers (virtio_add_status_noirq,
    virtio_features_ok_noirq, virtio_reset_device_noirq,
    virtio_config_core_enable_noirq, virtio_device_ready_noirq) and
    the freeze_noirq/restore_noirq driver callbacks plus the
    config_ops->reset_vqs() transport hook. Modifies
    virtio_device_restore() to skip bring-up when restore_noirq
    already ran.

 4. virtio-mmio: wire up noirq system sleep PM callbacks

    Implements vm_reset_vqs() which iterates existing virtqueues,
    reinitializes the vring state via virtqueue_reinit_vring(), and
    reprograms the MMIO queue registers. Adds
    virtio_mmio_freeze_noirq/virtio_mmio_restore_noirq and registers
    them via SET_NOIRQ_SYSTEM_SLEEP_PM_OPS().

Testing
=======

Build-tested with arm64 cross-compilation.
(make ARCH=arm64 M=drivers/virtio)

Runtime-tested on an internal virtio-mmio platform with virtio-clock,
confirming that the clock device works well before other devices' normal
restore() callbacks run.

Questions for reviewers
=======================

 - virtio_config_core_enable_noirq() is currently a separate helper
   that duplicates the spin_lock logic, but it only differs from
   virtio_config_core_enable() by the locking context.
   Would it be better to merge them into a single function with irqsafe
   locking, or is the current separate-helper approach acceptable?

 - Should reset_vqs be a mandatory callback when restore_noirq is
   used, or should the core silently skip vq re-initialization when
   the vq list is empty (current behavior)?

 - Some functions, such as get_status() and set_status(), are also used
   in the noirq restore path. Therefore, it is assumed that drivers using
   noirq callbacks have implemented these functions usable in the noirq
   context.
   Is the current implementation acceptable? Or is it necessary to create a
   flag to indicate the driver supports them in the noirq context, or
   have a separate noirq callback?

Changes
=======

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

 drivers/virtio/virtio.c       | 252 ++++++++++++++++++++++++++++++----
 drivers/virtio/virtio_mmio.c  | 133 ++++++++++++------
 drivers/virtio/virtio_ring.c  |  30 ++++
 include/linux/virtio.h        |  10 ++
 include/linux/virtio_config.h |  29 ++++
 include/linux/virtio_ring.h   |   3 +
 6 files changed, 391 insertions(+), 66 deletions(-)

-- 
2.43.0

