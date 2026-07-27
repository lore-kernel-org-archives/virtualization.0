Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13D3F6600
	for <virtualization@lists.linux.dev>; Mon, 27 Jul 2026 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150289; cv=none; b=jYPU/HwIP1PcO+P0ZpLzJ+jnxv29AM+F3kk3DXxWqhvzan4JFJhH/sQQEbdnMrzdAB6M18PnYdvZ/XWgwg2jQQUPjwHZ9xG3IFGOXZ2uOaWONsGKvZNat6udMnEVdGAyOlupVUE5IIR++3tIChGpE2q1oLL2vJJlEYDHnDudL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150289; c=relaxed/simple;
	bh=ZSVdxXoqaN4miCQDh1UcXemCo+5Lz6q/t2f1JUT1vT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZGwiFIwDK31anayHpLmBwV8T1Uvgynr8HpAZiynor+zzFagn25z2Dc/WzVmCaXUipmzSoSYq6JF42JU80/wuJe8WhJbaoQsh2KiyplKOXjVcQ+kC0u517cyChJ4BRcLnL94pBJl4UUCT9XN3GgI/FxFT3AdSH3wCn7F54hIpJqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjFppY58; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjFppY58"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954afac04bso30364925e9.0
        for <virtualization@lists.linux.dev>; Mon, 27 Jul 2026 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785150286; x=1785755086; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q5i0GUCYnj0aBBUICYHMNZKYVOhAjS07u/AM3wMKFiY=;
        b=bjFppY58gsbDZoQPMHHvivigDIXpszRzNBoVnI1+TxZNqJTu0wAFxa6021yHXPwGn1
         Y9DVbj1eFGoxvBXzPoEz1vmsC68/S0W8310trUY6zCT7baTAgbrJoCtQ669t+Ek6mUVt
         4oJT4R2lUC43oL/YCCmxulUgeO78yCtC7eEtyhNiK60IP1ICSgrRQkE4T2wBYudZfz3D
         F3AbiVzCqFydf0gPe4hfi1/wDsBpfz7dS3TQCMSR4FhJAukaoG1tG04z8VYsaBkDUmNK
         Sb8JGTQiCqB1REiDV/8hQ5Q5Dg645YiU3RXWAWkd2uEuEyzE0n8/AxkRIIl7RaQIG+Gk
         BH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785150286; x=1785755086;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q5i0GUCYnj0aBBUICYHMNZKYVOhAjS07u/AM3wMKFiY=;
        b=GvPV3nXNftOand3h9d0c1twdBWGeCSrkebf3PxmZ6h+AWEdMgEqRKYTYIkGZJ7CepO
         93U9ptKMHj5EdRNuVHRFFM+oab2+V9exyCe09FHUV1T7A4IYBZgVXPvUPk8JY8iRIObW
         HfNtjzMqzNvo/RRM5QGjgybNNLz9cQdC4ltjOOHqMuPOOmNSp5VRQD063qMd9dqHik+I
         7Vw14xfjtVHOmxKpHmQYFKax6Y4wavyiIqJ01q+4uqC8Ohq5DqKsiJjmRYBpcW4q8H4t
         zqM4V8GGQgo3NlfdzFP2Mcg22+GSnL1LcmCGVOoXrz0KXZL8sbtaNJAnoUJLqEBIQyYj
         DEJg==
X-Forwarded-Encrypted: i=1; AHgh+Rpa8x7yKjJQgm2H6YS7Z+8xmvSVYmzMoih6jdeTe6MWrbI6LfzxrKLqndp6G7lAVwPJkHQSpD9xg2bRukwqoA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/kS3G4b3JcRGVoRkJJESzB8wLUo2M//CNdIixhf47JwhpUzzW
	TAlVDlO1oitQ+RXerbkSWD7xeyqiEiQ6N6ATog3IvQXys5uaOqPH18Y+
X-Gm-Gg: AR+sD12xwPoclkvwBFTvxgw1yfGEid6YgxwThJ6B1Yh0Y7ZbsmTGxYvnWUXDPfNP+Ef
	ryfTPbZs+eTFCVL88kLUpQpq4z5GvXtsulHlMyKS/4wU0zgcr0HgEfsAsxHDeHVAiit/Doy4tHQ
	qkdfmXWpfxsimZ9RWNv/LebPpQZw9gxCDTx/RgDFTBJFLSS6VCyJcT/cwXSkm6OTw0gAO6MuWlW
	NjbgZkQ1zF5W/nketU/aNutb1vEbkyN79glI42yBcAu7hrWlYHEWHDIicLpOW+d8M0JbyYpMkq2
	+5DU1C9/mW+EKJ6P/XODxbu9CpOd7ya9o6SiPpcFHJ87Bg6FaMfBsab8FUUe/H4d5/JvH4/JjBY
	CiT6qO39tzia2xpieymMmQIRP5kF56j5RvIqK2gTD3zznn7thfeKP0XGtZfgJOpnNL2eJyyoWmb
	YHqIhceLdlPtxKpsTZLKNajmbvOXSkmKYu+zKasN3tRhW1Pn3v8XJqinNT5myPRXwNwvQRcT6WE
	8x1
X-Received: by 2002:a05:600c:310d:b0:495:7b1b:f387 with SMTP id 5b1f17b1804b1-496b56f141dmr101917265e9.24.1785150285281;
        Mon, 27 Jul 2026 04:04:45 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4858e28sm240519915e9.2.2026.07.27.04.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 04:04:44 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3] drm/qxl: fix use-after-free in qxl_irq_handler on PCI
Date: Mon, 27 Jul 2026 13:01:55 +0200
Message-ID: <20260727110212.64913-1-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

while :; do
    echo [pci qxl id] > /sys/bus/pci/drivers/qxl/unbind
    echo [pci qxl id] > /sys/bus/pci/drivers/qxl/bind
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

The qxl_pci_remove() function does not call free_irq(), allowing the IRQ
handler to fire after the device has been torn down, accessing freed
memory (qdev->ram_header, qdev->io_base).

I followed these steps to unload driver at link.

Added Disable the device from generating IRQs, Release the IRQ (free_irq())
at the start of qxl_pci_remove() to ensure no IRQs fire
after teardown begins.

Added at end Disable the device.

Fix: Added goto fini in ttm_device_fini() on error.
Bug: qxl_ttm_init never calls ttm_device_fini on failure
If qxl_ttm_init_mem_type() fails after ttm_device_init() succeeded,
ttm_glob_use_count stays incremented. All subsequent bind/unbind cycles
see refcount > 0 and skip ttm_pool_mgr_{init,fini}() entirely.
The global pool types are never finalized, and the list_lru_destroy fix
in ttm_pool_mgr_fini never runs.

Added free_irq on qxl_probe unload.

Set to NULL after free on qxl_device_fini.

Assisted-by: OpenCode:1.17.8-Big Pickle/DeepSeek V4 Flash
Fixes: 48bd85808443 ("drm/qxl: Convert to Linux IRQ interfaces")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
Link: https://www.kernel.org/doc/html/latest/PCI/pci.html
---
 drivers/gpu/drm/qxl/qxl_drv.c |  9 +++++++++
 drivers/gpu/drm/qxl/qxl_kms.c | 13 +++++++++++++
 drivers/gpu/drm/qxl/qxl_ttm.c |  8 ++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 1e6a2392d7c6..e109114ac691 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -128,6 +128,8 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	qxl_modeset_fini(qdev);
 unload:
 	qxl_device_fini(qdev);
+	qxl_io_reset(qdev);
+	free_irq(pdev->irq, &qdev->ddev);
 put_vga:
 	if (pci_is_vga(pdev) && pdev->revision < 5)
 		vga_put(pdev, VGA_RSRC_LEGACY_IO);
@@ -154,12 +156,19 @@ static void
 qxl_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct qxl_device *qdev = to_qxl(dev);
+
+	qdev->ram_header->int_mask = 0;
+	outb(0, qdev->io_base + QXL_IO_UPDATE_IRQ);
+	free_irq(pdev->irq, dev);
+	cancel_work_sync(&qdev->client_monitors_config_work);
 
 	drm_kms_helper_poll_fini(dev);
 	drm_dev_unregister(dev);
 	drm_atomic_helper_shutdown(dev);
 	if (pci_is_vga(pdev) && pdev->revision < 5)
 		vga_put(pdev, VGA_RSRC_LEGACY_IO);
+	pci_disable_device(pdev);
 }
 
 static void
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 461b7ab9ad5c..eb17d61eac11 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -313,11 +313,24 @@ void qxl_device_fini(struct qxl_device *qdev)
 	qxl_gem_fini(qdev);
 	qxl_bo_fini(qdev);
 	qxl_ring_free(qdev->command_ring);
+	qdev->command_ring = NULL;
 	qxl_ring_free(qdev->cursor_ring);
+	qdev->cursor_ring = NULL;
 	qxl_ring_free(qdev->release_ring);
+	qdev->release_ring = NULL;
 	io_mapping_free(qdev->surface_mapping);
+	qdev->surface_mapping = NULL;
 	io_mapping_free(qdev->vram_mapping);
+	qdev->vram_mapping = NULL;
 	iounmap(qdev->ram_header);
+	qdev->ram_header = NULL;
 	iounmap(qdev->rom);
 	qdev->rom = NULL;
+
+	idr_destroy(&qdev->release_idr);
+	idr_destroy(&qdev->surf_id_idr);
+	kfree(qdev->client_monitors_config);
+	qdev->client_monitors_config = NULL;
+
+	qdev->gc_work.func = NULL;
 }
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 5d495c4798a3..bdcc7560f3f1 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -207,13 +207,13 @@ int qxl_ttm_init(struct qxl_device *qdev)
 	r = qxl_ttm_init_mem_type(qdev, TTM_PL_VRAM, num_io_pages);
 	if (r) {
 		DRM_ERROR("Failed initializing VRAM heap.\n");
-		return r;
+		goto fini;
 	}
 	r = qxl_ttm_init_mem_type(qdev, TTM_PL_PRIV,
 				  qdev->surfaceram_size / PAGE_SIZE);
 	if (r) {
 		DRM_ERROR("Failed initializing Surfaces heap.\n");
-		return r;
+		goto fini;
 	}
 	DRM_INFO("qxl: %uM of VRAM memory size\n",
 		 (unsigned int)qdev->vram_size / (1024 * 1024));
@@ -222,6 +222,10 @@ int qxl_ttm_init(struct qxl_device *qdev)
 	DRM_INFO("qxl: %uM of Surface memory size\n",
 		 (unsigned int)qdev->surfaceram_size / (1024 * 1024));
 	return 0;
+
+fini:
+	ttm_device_fini(&qdev->mman.bdev);
+	return r;
 }
 
 void qxl_ttm_fini(struct qxl_device *qdev)
-- 
2.55.0

