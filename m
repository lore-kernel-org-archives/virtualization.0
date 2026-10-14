Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9B0550DDA
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991063; cv=none; b=fo6ownFH4vbfUVXv04rkDQx2738NOVfL31dkZrKkIXKzs4rNd8lUpZPcWGFYMZ73OYJXihIBMAj+GUuH/KjypcoLgJ9GALglOp3kqRYy8IOcK+vwmWzzFwJQ3zpe0rFJ4ppovYDHMZ4AMam6GSciWBsvq/JjLMOfgJiY9Nkj4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991063; c=relaxed/simple;
	bh=GZJImD4E/p4SC5Q3qsEHW83Y+tSs3NMy2aWWJibdCPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C2iblMppP4kqBRYVy+DHBhpGJqSy8kvLdqtNJ8VZGdc5DROhS3naDf5U/VhVEUP7lIu/G7WrwpjQflTw6MgIEHpmAPzWjLMTMIwgxbqcERrUFnEFUNELWfqPt894XYPUB/Bi4yOfuxUxZ50Cmo2S5GagRAYmye/tJO9eu6cqehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izp3QvC5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izp3QvC5"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso401489f8f.1
        for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791991059; x=1792595859; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ImP4Kd27ciUItTgK/bHBhrGWjR/yCtrbiB2wFVAjs+Y=;
        b=izp3QvC5cgFbt+iRCXmWq0ZDVCBZt1Gk8aVYvIWr3EHIId0bfkqHD+MPi26cvh4lnw
         pKE31V5LGhxqNDUbeXtz4GQPZiBaEX0dDw0CBeYDhjReP+lDxfPodvYTqNLFBoFwygKF
         m1VSQGHzWi5eiOrN2pXYVv3yy/8FAEaK22Q8uWK9/+m3TFTi8AYMjE6u6uariCtXFa33
         U+mn6FwpUOcoqzJRsrLQUfi9XIjJ3UyFaJq+XwSwDoG9hFM178lGU691Kf4sH79bNdn/
         boVeB7OOjEsMnXOGtFFjJ+umoq8+y+prvY5vu4JB3p11c4MGtQ6PLyt0RiRgBYO5q3qq
         EMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991059; x=1792595859;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ImP4Kd27ciUItTgK/bHBhrGWjR/yCtrbiB2wFVAjs+Y=;
        b=d5ZEcrixsDMbyRXAGVDUqBz0MO6ydsfIKFiXY4WZUHGqqgoiKAKShjx9P39xAMvNwC
         3OlX0W+B7e8bkdjOoX+YWo2OB6xkAFGL1VUVnm8dkQ9gP2d5ll0Nnl7MawrfBMRSo0/M
         a/6RT2eAE1qGRqraOdEXup3BQIyv3989MsYVWWOcMdqfVuVGPvehmjsbZzjUZtO2JaW3
         yW0VOdgELZKSQxaKX70fDRn6HmenpXTHAo5wK49faiCXadXsXnxigNAtIRAJTkoh3jYu
         Cgx9yBMapbhk6zgdcAp8sf+E5NrzNVtHBv1CaY0xaGfQpX/nfJ7vFShv4g35UMH08iw5
         f1Hw==
X-Forwarded-Encrypted: i=1; AKwUvBw/XUe76bEsog+f2rI2l8b/FdU1Hyp7luMS4iqDwKlX2GLxMkhl8nDDWtjhu35qnvZWoCY2B0B8WyCtwUYMXg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLAF5/lor4bxmuCaKeYJwNyKYV3Ighmkjf1fAj+0ePXhnvSFyjc
	hpQpcm8QXaObzWK5sD5gA8s80P//rPFvRrI3APj2Q+ZHpnQY/f8qp0EA
X-Gm-Gg: AYBFou0TtUX42BPaFQD0VavoxBz+QkQ1Pq6W/C+MUa+Ffk8JhXr+GAF0VawtYRnHFqy
	fMgTCV8wk+85OhJHjcJkw6g+LDWvpFJ+PXQNNHPAW14+92aisA5CWvtd17zsZX5Dk2MgkyxP6sq
	W9vSRxdcYAAC892YYILU6d1K28PvHyJuH3lWV6qjc1FrehYBYrRRy7Rz0ZXXhoA8dUUXimoGVYH
	9td8+cIDDgJqtnm/W0FXP1CLhhsQfCT+WG98rQbDyxKdvzbgkBF7wqn1rNKngOEEz7mN+Na25iV
	ZKzD1/Ws027rP9mL6AFjIIv37h1hD+CIdldNv8kmYgvnv4hPM2XtezfOzxFPUkRlyE1nX+JXFC6
	Pr8zVd7FBqCfyicG2Zzl/IkVqUXvQDEGP4ADVx0u1BAnfn+dBObT4eevS5nqS9j/OAKoB0JozqN
	j/qPxEszkhjQOJuq16E2+iY78gCgg12wyI05+JQcPAEaTkaG7tQdSMgOgnzKy9niRCmO277bDa6
	P8TODOrmpwm0KCQFwWhOCpOwseSLk2ZDcLN+ccuY8RRnLLlQulBINf14D9cEw==
X-Received: by 2002:a05:6000:8:b0:48d:e663:a7de with SMTP id ffacd0b85a97d-48de663b537mr6263415f8f.0.1791991058739;
        Wed, 14 Oct 2026 08:17:38 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df0f99f0bsm1212710f8f.21.2026.10.14.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:17:37 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v7] drm/qxl: fix use-after-free in qxl_irq_handler on PCI
Date: Wed, 14 Oct 2026 17:17:26 +0200
Message-ID: <20261014151731.16775-1-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Executing below script:

i=0;\
while [ 1 -eq 1 ]; do\
  i=$((i+1)); echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/unbind;\
  if (($i%1000==0)); then\
      echo loops=$i; free;\
      grep nr_free_pages /proc/vmstat;\
      grep -E "VmallocUsed|Slab|Reclaimable|SUnreclaim" /proc/meminfo;\
      sync; echo 3 > /proc/sys/vm/drop_caches;\
      echo 1 > /proc/sys/vm/compact_memory;\
      udevadm settle;\
      free;\
      grep nr_free_pages /proc/vmstat;\
      grep -E "VmallocUsed|Slab|Reclaimable|SUnreclaim" /proc/meminfo;\
      uptime;\
  fi;\
  echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/bind;\
done

After a few seconds, it reports:

==================================================================
BUG: KASAN: slab-use-after-free in qxl_irq_handler+0x269/0x2b0
Read of size 8 at addr ffff888001c6cd48 by task swapper/0/0

CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
     7.1.0-10963-g1a3746ccbb0a #31 PREEMPT(lazy)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
               BIOS Arch Linux 1.17.0-2-2 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0x4d/0x70
 print_report+0x14b/0x4b0
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 ? profile_tick+0x56/0x90
 ? tick_nohz_handler+0x23c/0x5c0
 kasan_report+0x117/0x140
 ? qxl_irq_handler+0x269/0x2b0
 ? qxl_irq_handler+0x269/0x2b0
 ? __pfx_qxl_irq_handler+0x10/0x10
 qxl_irq_handler+0x269/0x2b0
 ? __pfx_qxl_irq_handler+0x10/0x10
 ? __pfx_qxl_irq_handler+0x10/0x10
 __handle_irq_event_percpu+0x116/0x450
 ? __pfx__raw_spin_lock+0x10/0x10
 handle_irq_event+0xa6/0x1c0
 handle_fasteoi_irq+0x271/0xb10
 ? __pfx_handle_fasteoi_irq+0x10/0x10
 __common_interrupt+0x60/0x130
 common_interrupt+0x7a/0x90
 </IRQ>
 <TASK>
  asm_common_interrupt+0x26/0x40
 RIP: 0010:pv_native_safe_halt+0xf/0x20
 Code: 42 de 00 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90
       90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d a3 cf 20 00
       fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90
       90 90 90 90 90
 RSP: 0018:ffffffffb8207e48 EFLAGS: 00000206
 RAX: ffff8880b296f000 RBX: ffffffffb82146c0 RCX: 0000000000000001
 RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000067a04
 RBP: fffffbfff70428d8 R08: ffffffffb7247e1d R09: 1ffff1100d846202
 R10: ffffed100d846203 R11: ffffed100d846203 R12: 0000000000000000
 R13: 0000000000000000 R14: 1ffffffff7040fcd R15: dffffc0000000000
  ? ct_kernel_exit.constprop.0+0x9d/0xc0
  default_idle+0x9/0x10
  default_idle_call+0x37/0x60
  do_idle+0x3a8/0x5d0
  ? __pfx___schedule+0x10/0x10
  ? __pfx_do_idle+0x10/0x10
  cpu_startup_entry+0x4e/0x60
  rest_init+0x11a/0x120
  start_kernel+0x382/0x390
  x86_64_start_reservations+0x24/0x30
  x86_64_start_kernel+0xd6/0xe0
  common_startup_64+0x13e/0x158
  </TASK>

qxl_device_fini() tears down GEM, buffer objects and command rings,
but it never releases the IRQ resources allocated during device
initialization. This leaves the IRQ handler and its associated state
alive after the device has been finalized, which can lead to use-after-
free if an interrupt fires during or after teardown.

Add the missing qxl_irq_fini() call to the finalization path, placed
before qxl_gem_fini() so that no IRQ can be delivered while GEM and
buffer object resources are being freed.

Masking after free_irq to avoid be overwritten by a concurrent
interrupt handler.

Cancel the work after freeing the IRQ to avoid a use-after-free.

qdev->ram_header set to NULL after iounmap to avoid dereference
the unmapped qdev->ram_header.

Added cancel_work_sync(&qdev->gc_work) after qxl_irq_fini() to
avoid a use-after-free when the pending work executes later.

Assisted-by: OpenCode:1.17.13-Big Pickle/DeepSeek V4 Flash
Fixes: 48bd85808443 ("drm/qxl: Convert to Linux IRQ interfaces")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
Changes in v2:
  - Updated qxl_ttm_init to add ttm_device_fini on error in
    qxl_ttm_init_mem_type.

Changes in v3:
  - Added free_irq on qxl_probe unload.
  - Set to NULL after free on qxl_device_fini and
    added idr_destroy on release_idr and surf_id_idr.
  - Free client_monitors_config.

Changes in v4:
  - Delete all code unnecessary. Leave only code to fix the BUG.

Changes in v5:
  - Replace disable_irq() with device-specific interrupt masking via
    qdev->ram_header->int_mask = 0 to prevent global masking on
    IRQF_SHARED lines.
  - Reorder qxl_irq_fini() call in qxl_pci_remove() to ensure hardware
    teardown events (like release_event in qxl_device_fini) complete before
    free_irq().

Changes in v6:
  - qxl_irq_fini() call in qxl_pci_remove() do not free all resources
    if your run unbind after end xorg. Place qxl_irq_fini() in
    qxl_device_fini() before GEM and buffer object resources are being
    freed is the correct place to release IRQ resources.

Changes in v7:
  - Fixed four issues reported by sashiko-bot@kernel.org:
    - Masking after free_irq to avoid be overwritten by a concurrent
      interrupt handler.
    - Cancel the work after freeing the IRQ to avoid a use-after-free.
    - qdev->ram_header set to NULL after iounmap to avoid dereference
      the unmapped qdev->ram_header.
    - Added cancel_work_sync(&qdev->gc_work) after qxl_irq_fini() to
      avoid a use-after-free when the pending work executes later.
---
 drivers/gpu/drm/qxl/qxl_drv.h |  1 +
 drivers/gpu/drm/qxl/qxl_irq.c | 15 +++++++++++++++
 drivers/gpu/drm/qxl/qxl_kms.c |  3 +++
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index cc02b5f10ad9..e8598fdbe886 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -424,6 +424,7 @@ void qxl_gem_prime_vunmap(struct drm_gem_object *obj,
 
 /* qxl_irq.c */
 int qxl_irq_init(struct qxl_device *qdev);
+void qxl_irq_fini(struct qxl_device *qdev);
 
 void qxl_debugfs_add_files(struct qxl_device *qdev,
 			   struct drm_info_list *files,
diff --git a/drivers/gpu/drm/qxl/qxl_irq.c b/drivers/gpu/drm/qxl/qxl_irq.c
index 4018bcf808e5..7e3e80134562 100644
--- a/drivers/gpu/drm/qxl/qxl_irq.c
+++ b/drivers/gpu/drm/qxl/qxl_irq.c
@@ -105,3 +105,18 @@ int qxl_irq_init(struct qxl_device *qdev)
 	}
 	return 0;
 }
+
+void qxl_irq_fini(struct qxl_device *qdev)
+{
+	struct drm_device *ddev = &qdev->ddev;
+	struct pci_dev *pdev = to_pci_dev(ddev->dev);
+
+	free_irq(pdev->irq, ddev);
+
+	if (qdev->ram_header) {
+		qdev->ram_header->int_mask = 0;
+		outb(0, qdev->io_base + QXL_IO_UPDATE_IRQ);
+	}
+
+	cancel_work_sync(&qdev->client_monitors_config_work);
+}
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 461b7ab9ad5c..872939414af4 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -310,6 +310,8 @@ void qxl_device_fini(struct qxl_device *qdev)
 	qxl_surf_evict(qdev);
 	qxl_vram_evict(qdev);
 
+	qxl_irq_fini(qdev);
+	cancel_work_sync(&qdev->gc_work);
 	qxl_gem_fini(qdev);
 	qxl_bo_fini(qdev);
 	qxl_ring_free(qdev->command_ring);
@@ -318,6 +320,7 @@ void qxl_device_fini(struct qxl_device *qdev)
 	io_mapping_free(qdev->surface_mapping);
 	io_mapping_free(qdev->vram_mapping);
 	iounmap(qdev->ram_header);
+	qdev->ram_header = NULL;
 	iounmap(qdev->rom);
 	qdev->rom = NULL;
 }
-- 
2.56.0

