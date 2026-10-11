Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176C434989
	for <virtualization@lists.linux.dev>; Sun, 11 Oct 2026 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791716531; cv=none; b=Yipepqb5kePT5L/ZNNnhGc+LKPECyh3CrrynrvX1khhgI5IMAO+RvKI4lSpXDLrcJRH9wXg/Zha+YfqnrFSph42fS4iV5IWZOAkiEods+B6JGW0wG3jc5loIFztnQ98grfPnQR/M5GkGyF7r+UHGUqHzBDe3VzS8Xc6DalPUI7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791716531; c=relaxed/simple;
	bh=ID59jjhelGBlALrOEwLjK4+YAvd/ykxpAnzLuaEkcso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JXw+P7gm3WO5vIAKKo2f4q/tdaTCi5qLl9gQ7mJRndHGWPxACsGrz1S0O9aJCgQ/x6PpAe/mv4yqfo4I+cChCLBdrXY+iuT22IbDdnyMsYvvCPFLHLqLJA0BXrj1CqIIzsnIOrGKSyNzhuswdhj7LJ7DKf5uOVppKE1poQDV/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULo8R1xi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULo8R1xi"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so11371245e9.1
        for <virtualization@lists.linux.dev>; Sun, 11 Oct 2026 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791716527; x=1792321327; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9yLUxPzbiNldjCwSi9bPvpj+pj/YOzN3wSQS/XDWpqw=;
        b=ULo8R1xiuV+GT4CIKmEQXafvyK9c/tJAsgPtTaT1of3qQYxVgEN8cNgDW6mZSr+fce
         OjbrpDcKc+DiRC/fGQHXHBQJd5LtcHFvdFtLJWessZkaOE3fp+2yQp8PpkJBWES9Tzx+
         yqEQcmJZXvYl31UN/QUDgftNG+j5lI4z6sCpVWeewjdtC/K8SLBX8OtieIPSiBvPzCKl
         qi0I7yklCrzIwTPTRo3ZPC9pLt31kH9IozRdWcyw/u4Cif4j8LIDz3U8bCtYcTWy1GRR
         vb4cKRi0hg1rG3GlpO/A3EEgHMbMYkZhNHu/04H9DH+EtK0Fdc7ALqdP41sNvxcT/+Ck
         GN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791716527; x=1792321327;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9yLUxPzbiNldjCwSi9bPvpj+pj/YOzN3wSQS/XDWpqw=;
        b=d+sZbJKj4FCqb1mgcACkTa3DAx8IoGc6F5FXa18M9bAknihWKBhLK+eZW6lc9DBtvf
         ofjES2+41+yHlEiPLgplaR5lOebwata08jgtCeVnbrRjPsldI0vBd/+aNL/R9guzKSeU
         GYXC8onVCxcYTjhNG9TtQjeTiMxIH+XBHXf99JFzwksQOei5ShH/vZ7tGd05w35qv6BX
         mw1Dgh51Mm+2WXJlYTgKXyQJBBjMeoYj1nOb/zKfnVhoueb2Vu6MtCdrn8++iKYe5/34
         pjeI3mlyS53/oFVGOMtEj07pmcD0Av968GmQxF3AhEyUVUrWEMgOTYHIvp975wOb5b4U
         lcAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwto3oZBER3XUxF4qV4+aaMyKU8S3DgISxDjCd2U+AWKrmm1DIHsFzY8EYL5YHOMt/fhXJaBSWORccSSxJYBw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJnr/hE4mLWBeH6OrmP/m0jonc8zLa0enppSMYgcyAEpTcyZZNs
	98GsB9n5cd4yjQOgzeJCvDq5ewestcJdn56exwhqz5M73T8+sd2bxFwm
X-Gm-Gg: AYBFou3QX4eozFkRaiWpLNeVu8VaqyAQMi/p2ImVfTSm2o0pcYPfbtJbhjUrj0yqSKn
	jXNeUroUKPBTQXLjoaqTnJTLZuoFDDHLhvzkOzh5K5F4uYLbmHyTz3MIWjrH3YHoz6tIjS+42Iq
	IMrwd4MbpgVddJ3hI24JfHb4qD139jr119LcQ8+KqFRdF34UHa61vEiBgh1obWS26qQcpT96ub7
	QyF/njYo2sDffLXvZ8N+0Fy4mD0KHT4pLXGp3DxC1niXUi+Oz9BUSiyX33VJbIA6Xko0Hoo0/dT
	3MqAUl+p1j7i92wClYei2NdYvQS67N2W7bWUKm11MWHmDHuTeAuyQdmQQwLZUpkAnYSQpM1rDaS
	scHd36eJxP44PgJp0OYHyK8CrhDnKN6NaVc9rrbdV3L1rVA9fH/v/oLVTJki0HzTY7MMOIR609D
	cJWxrZF5Zf6j5p2quKyj53WL2e05Djk6Xo9Jux2oXl9h9Y4MH/yxAVTqLSdKrTYBG+zZgAi/G7S
	T4lVmNqvhkV0xcBxxV3Q0thACVsaGnTg9CjKjemXDu15oVcQPFm5IojEM2chQ==
X-Received: by 2002:a05:600c:3b98:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-4a18e49886amr139699625e9.10.1791716526419;
        Sun, 11 Oct 2026 04:02:06 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bb6beaesm124386765e9.0.2026.10.11.04.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 04:02:04 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v6] drm/qxl: fix use-after-free in qxl_irq_handler on PCI
Date: Sun, 11 Oct 2026 13:01:42 +0200
Message-ID: <20261011110144.40575-1-megia.oscar@gmail.com>
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
---
 drivers/gpu/drm/qxl/qxl_drv.h |  1 +
 drivers/gpu/drm/qxl/qxl_irq.c | 15 +++++++++++++++
 drivers/gpu/drm/qxl/qxl_kms.c |  1 +
 3 files changed, 17 insertions(+)

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
index 4018bcf808e5..3698428b50ef 100644
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
+	if (qdev->ram_header) {
+		qdev->ram_header->int_mask = 0;
+		outb(0, qdev->io_base + QXL_IO_UPDATE_IRQ);
+	}
+
+	cancel_work_sync(&qdev->client_monitors_config_work);
+
+	free_irq(pdev->irq, ddev);
+}
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 461b7ab9ad5c..fc2502752ae2 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -310,6 +310,7 @@ void qxl_device_fini(struct qxl_device *qdev)
 	qxl_surf_evict(qdev);
 	qxl_vram_evict(qdev);
 
+	qxl_irq_fini(qdev);
 	qxl_gem_fini(qdev);
 	qxl_bo_fini(qdev);
 	qxl_ring_free(qdev->command_ring);
-- 
2.56.0

