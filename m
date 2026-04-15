Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4A6314A82
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776274824; cv=none; b=QMPZueJO8ugK2xJIU5lTolTEEFKWcE/jYrVQQV3xCr9ar4DivzAXsVusXdoJ9pSYBFf3GoMJ6feZ9lOan00mP9tjonwjKTcn1zzKtaFGJ+EIOuRWSIYt8OqFm2TyqAR4QwbTbMamLV891I7D1FRky4DoAe1RWxZsE9s2rTVNr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776274824; c=relaxed/simple;
	bh=Z/9VzlpYWM4Y/6rZcMIzAhM6BfBFDNWqNNGIeASOG+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aJsLRWvf35yn3wSVYxTzt+5X863dxCb8BUeK2dKj0SZxpF68mAkdysQpJtSbSYQgOVvWC3wb2zxMTrJskZw8AllJ+iHkFEeZz9x518G2qllw15csZD6bjhazIQXuXkb7f7BWJC3qw+WrYLGozFkpuaEJyve+N2v7yLggZR3TbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT++EgcU; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT++EgcU"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35fb7f51171so3203814a91.1
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 10:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776274821; x=1776879621; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xs6hE61joQieGjzSDamvQRkpCvN6ccFcScM9HaFTdM4=;
        b=XT++EgcUOVzzYXX6fQ8p7LOEQdd/lZImiR4F68hlSCWTYmFPQLdkjFEh//xhnU9bsM
         KhsxJ66LbPDsokMpxpywCcJLIUOf7LQDOgmTsSj8epLMrOrghUGD2cCmKdalsZOiYm22
         bL47d6ZK8wvZQ63up1VtMkGNkZpMlKZSnYjpz2JPFVgT6bJgmLCgkH/MhhFryGYhqNyo
         XjxJWyQ9lV504fnMLBTi8svTfRB3PpuoxqMx6MKMxk28xSh2KPjBr4U+JYrp7Rt3jAEA
         /lguUmFq051mw+ISJ1xanD4ByApWKokr6JmuTfruFzh8QJp+QhLE6na0xEOw6bDOce3s
         U/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776274821; x=1776879621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs6hE61joQieGjzSDamvQRkpCvN6ccFcScM9HaFTdM4=;
        b=XJjndLqjc3S55m1jEMipr71vnFpXY19qiQW9YR+wONab8olqf9woToomncuZiXiajZ
         ZKV47uxz5FRG0Z3rbIZ3fhLQeIjXSpbbgD8VYFI96I3UTP3SPKlP18seCsdhpsrBUggY
         kV3MqskecTXScnB62Of5DpPD/EuuUsNz1aP9u9mBPYEHtXtShav3Q9dEotkBD5U7WqBf
         8UQ0CD1rTRqTv8G6EJuljlAtXha6ao1pic23xZbaZFuBRHygKMJUvu7ThamNpDSsdS2a
         FyUZo3MTyddgDldzkW5w9XPuUUJ9bdhP8bohBRMd2AZwbG48d3xhgU5QkUYDkQLwkyBz
         jeOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/TFjE6QZTiV9yofgzYCMXgqtUsoGQkQGk7y6xjIpBLGhVld/pu3gNCMxFTAZQ0edjZpLWG3iRsN1/ORqXkVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKtUDuBwsfCcS4NBPgK1+MmoZ0iL6xmkTb1BvXgNU22Ri3tCQC
	adY0e2gyUJeseaN/I8K0Dvzo/rJqXqdGBvtDeeqYP9d2RQtFGWOXsl4a
X-Gm-Gg: AeBDies8oZMUweLCbKeJPZ5Wc+SUWkqhTN0Celh8LncZqA+FHNbVDphq1u4iFWpgaPV
	XhvPTLPjBu7jqZFNV2pI48wuW91HQKWnlfbkrKWFAideaq87+CI8HwSoo8zmbCspa/K57yj67YJ
	GYu4jydU/t37KbdDg/CzSK/AME8Ph7yLJCnCSWmSYBZ9/OjwGzXIH3z7Zn5Q3y71s+VznI+KVf8
	zBcwoTCAE0ZjjjNRKd28BkJkFgzapOIcDvP9sOewPkYNgGm6bx1nVQo0LIr1xi4qV8q9aNdRhW6
	EmHpFFixLVagq/CG9q89spfhZykpO75SDHeV7Wd6WDj1eNdr7my0PMwn6XVctbFZ6EUzBggqsfA
	K2ooKlwPFVlp3lfsR2G3WW9hYAaHZu8VPmgMbc/i0Kqfoc8Lwkct2fTBj16/M9iamddOV0p+ixh
	8WOI//4+sKwejCYlNsOMWTdYxB8wlTQpNrBssUW38wDt7evHLWz1sN9NxSYwDd8fwaFF4LW8ywb
	/30dHYLsPaZnzbymi3dJOk5DHAjswpAjug2aG8LRRpj4/XE
X-Received: by 2002:a17:90a:e70d:b0:35e:56ef:d5f3 with SMTP id 98e67ed59e1d1-35fcd2638f8mr5322173a91.28.1776274821423;
        Wed, 15 Apr 2026 10:40:21 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd1fe9b50sm2891026a91.3.2026.04.15.10.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:40:21 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v1 0/4] virtio: add noirq system sleep PM callbacks for virtio-mmio
Date: Thu, 16 Apr 2026 02:38:29 +0900
Message-Id: <20260415173833.6319-1-baver.bae@gmail.com>
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

Sungho Bae (4):
  virtio: separate PM restore and reset_done paths
  virtio_ring: export virtqueue_reinit_vring() for noirq restore
  virtio: add noirq system sleep PM infrastructure
  virtio-mmio: wire up noirq system sleep PM callbacks

 drivers/virtio/virtio.c       | 234 ++++++++++++++++++++++++++++++----
 drivers/virtio/virtio_mmio.c  |  79 ++++++++++++
 drivers/virtio/virtio_ring.c  |  19 +++
 include/linux/virtio.h        |   8 ++
 include/linux/virtio_config.h |  29 +++++
 include/linux/virtio_ring.h   |   3 +
 6 files changed, 346 insertions(+), 26 deletions(-)

-- 
2.34.1

