Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095042D8DBB
	for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432939; cv=none; b=rUIn5uGV58AmfKCb8hVFNnLsqCRNC5hs+iFeSI/Ou/xmtTT6vEmAdmq1HzzQ5gSbhHV2DT5r3TtErZHzALTcOlzw5aaCTzIuwsuEUyxqqjJz5rRurywzReQIvfUSU/17goacjZSde/Q9KKEmzokqAFf8xapDhVoGmQMjKuGooQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432939; c=relaxed/simple;
	bh=4qDz94G7x8HI+wX0z4uKY10lcdoSui/8FCp1LBvnqno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KE274RTRtQ4Ihq6g1cXQbU6z02vX5ljtskKrBYeZYjh5l500E0RqU517XI8R1vmHenYxjP1eSh2S76QWUPeK41CQccsxJC9/Xr5KFX/GuDw/Tw0ihILr69bX+u5nDHAPEBruR4TQp5JQ+xzZcuKvQoRi4lq80MDOj8ylteYO+X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaRDe5BT; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaRDe5BT"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c795f096fa5so282857a12.3
        for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 06:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776432936; x=1777037736; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWCo8dQHdy7JLYOMp3LwgNCKyK1/Vth9lMKSBroTst8=;
        b=XaRDe5BTJWiDcBTQz02jhAk3bfhheDDoOFLDCX0Oac66c3yDqq97xrLFaNV0dK/rFm
         jINkw+JZ85DwU87qbzeRuQb2xVdvaTJTglTdiEYgrjHUjyb8RhUdJkYyVr4oFrP6nv3R
         qpRzq85x4hV9IKqFgh6O7PV1fPJmm5yCihVj7Khopzp2PmU9UIEP9rHSfNBmG8nJ8It0
         2s+lD4Jd4pnIMY+DVZLPN3SPSKRv49PM1DaB3T5oCC4NR2H09+/hPEz+UwrjhcbRcDHe
         XtqYvoTrT/5BbxHrOiMBE43vJdkKk8kDpjcLL/b4Yv0JfOcjBRYhL7V/UdWVYvbXEQxP
         R27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432936; x=1777037736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWCo8dQHdy7JLYOMp3LwgNCKyK1/Vth9lMKSBroTst8=;
        b=I2nHNTweGY9M93ttw8sq5Fx97bYcsjvcLvjKN6SBS6WY6sjg1k/Bhph1NRVhe1UIF1
         Y1PafKZ1O/71E5kuM5agKtpLbPH/BhFUWkUgXzcT9k6292gvxn0WdoxtBxXEIVjbdw1Q
         +HVc5vzoczkVHDzZvrwla2YrqWkNNE4Ol0hw52szCOT8QInW8n3s+J3HpY6icP5bzDgk
         7Eh5IZZl/XOzYKODxjXjM6NNxuofZzjqIMVnp+b6zGu71dfHSycoVSEOODjonXNTTswD
         Bns6806mJqrKvWGxoAo6Cs9EIg8OGIkq40NUCgY0l8JbkZEtOA6uburkzM5vlKDZG3zh
         jUVw==
X-Forwarded-Encrypted: i=1; AFNElJ/xUDEKH5Grdp8FjStl9zzFHo124fVEZxiN5YBTVoUIKaI8q6/MhMsix7LUaw8CCPLb4kMtq+7rurUHMprfhg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/Fsj7XIeAZpWoqq5wkPfAzzajwiEaYdHF8m0XyacsOYk1yn9N
	xVnKkCD4Uiv+5iV2SfpsIUrEKN6FJkTFTfjdZFAcQn5xs5hIhAYZtuzhbN6VX/y4
X-Gm-Gg: AeBDieuZgjWvbZNX+8bdT4OA0Zw9C4TCHW6ix2mrTk8FE7WhhwtRjJ4edf9gwDLb55U
	t5jcme8TDYGZ+S52aIqt/52WkwrJ8g9bUaH6BTytMsGlxHDrAuOus9uycTxVFMbdwmd+cLsvaH7
	p0JHL+ZAfTnwj7ZiwkCDDtSO/ehaJw14uhPjbF7uoQykHiBeWjES6aYT5cFoBoi2bzzAq/AB1BQ
	X54IyYhstETrSd3qVlPn3z8bpGY2YAnTIaF6SqaPsNz8U71ctGjy1m/RDtIBQlHQpqgT04fCd+M
	/2zShbZ5IUhhvQaphAAh8YPiH6GKwdEzx54DjoCu27mbPtoAI3qzi4og4BFdg2p2TVVhfMZ8wNY
	Jq8xr798RpBRf2+d68y4f7TF09QBCw90t5F/AhLsZzHNCyRZ8CqkRu3qgnwwctOoGT1I06QdtQL
	CSF7KQIFekODOToZhVU1mrsFvn+1izsXXxfEItwTvoJKILK7lGOpB7TocDp9OzBva8Vnsn0HtoM
	0IrUhYYH08lkLZdzaXwrGJ0+jhs4zVHNVL8OA==
X-Received: by 2002:a05:6a20:6a13:b0:39f:a42:9243 with SMTP id adf61e73a8af0-3a08d67e277mr3348334637.3.1776432936309;
        Fri, 17 Apr 2026 06:35:36 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa3604sm1421272a12.14.2026.04.17.06.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:35:35 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v2 0/4] virtio: add noirq system sleep PM callbacks for virtio-mmio
Date: Fri, 17 Apr 2026 22:34:26 +0900
Message-Id: <20260417133430.507-1-baver.bae@gmail.com>
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

v2:
  virtio-mmio: wire up noirq system sleep PM callbacks
   - The code that was duplicated in vm_setup_vq() and vm_reset_vqs() has
     been moved to vm_active_vq() function.


Sungho Bae (4):
  virtio: separate PM restore and reset_done paths
  virtio_ring: export virtqueue_reinit_vring() for noirq restore
  virtio: add noirq system sleep PM infrastructure
  virtio-mmio: wire up noirq system sleep PM callbacks

 drivers/virtio/virtio.c       | 234 ++++++++++++++++++++++++++++++----
 drivers/virtio/virtio_mmio.c  | 131 +++++++++++++------
 drivers/virtio/virtio_ring.c  |  19 +++
 include/linux/virtio.h        |   8 ++
 include/linux/virtio_config.h |  29 +++++
 include/linux/virtio_ring.h   |   3 +
 6 files changed, 359 insertions(+), 65 deletions(-)

-- 
2.43.0

